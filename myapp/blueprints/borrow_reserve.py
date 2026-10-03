"""借阅预约管理蓝图。

处理 `borrow_reserve` 表的 增删改查 操作，并根据当前登录角色返回相关记录。

业务闭环说明：
- 借书：校验读者状态与图书库存，原子扣减 `book.bcan_borrow`；
- 预约座位：校验座位空闲且无进行中的预约，原子置为 `占用`；
- 完成/取消/爽约：自动恢复图书库存、释放座位，并计算逾期天数与罚款。
权限：管理员可办理任意读者业务；读者只能办理/修改本人业务。
"""
from flask import Blueprint, request, jsonify, session
from ..core.db import get_conn
from ..core.utils import is_admin, calculate_fine
from datetime import datetime, timedelta

borrow_reserve_bp = Blueprint('borrow_reserve', __name__, url_prefix='/api/borrow_reserve')


def _current_user():
    """返回当前会话中的用户信息（未登录时为空字典）。"""
    return session.get('user') or {}


def _parse_dt(value):
    """把前端传来的时间字符串解析为 datetime，解析失败返回 None。"""
    if not value:
        return None
    s = str(value).strip().replace('T', ' ')
    for fmt in ('%Y-%m-%d %H:%M:%S', '%Y-%m-%d %H:%M', '%Y-%m-%d'):
        try:
            return datetime.strptime(s, fmt)
        except ValueError:
            continue
    return None


@borrow_reserve_bp.route('/list')
def borrow_reserve_list():
    """返回与当前角色相关的借阅预约记录。"""
    user = _current_user()
    role = user.get('role')
    relation_id = user.get('relation_id')
    conn = get_conn()
    cur = conn.cursor()
    try:
        if role == 'reader':
            cur.execute("SELECT * FROM borrow_reserve WHERE rid=%s", (relation_id,))
        else:
            cur.execute("SELECT * FROM borrow_reserve")
        res = cur.fetchall()
    finally:
        cur.close()
        conn.close()
    return jsonify(res)


@borrow_reserve_bp.route('/add', methods=['POST'])
def borrow_reserve_add():
    """添加借阅/预约记录。期望 JSON：{rid,bid,sid,br_type}。

    - 权限：管理员可办理任意读者业务；读者只能办理本人业务。
    - 借书：检查可借库存并原子扣减，无库存则失败。
    - 预约座位：检查座位空闲且无进行中的预约，并原子置为占用。
    """
    d = request.json or {}
    user = _current_user()
    rid = d.get('rid')

    # 权限校验：未登录、或读者办理他人业务时拒绝
    if user.get('role') != 'admin':
        if user.get('role') != 'reader' or not rid or rid != user.get('relation_id'):
            return jsonify({"msg": "无权限：读者仅可办理本人业务，或使用管理员账号办理"})

    br_type = d.get('br_type')
    if br_type not in ('借书', '预约座位'):
        return jsonify({"msg": "业务类型必须是 借书 或 预约座位"})

    conn = get_conn()
    cur = conn.cursor()
    try:
        # 读者存在性与状态检查
        cur.execute("SELECT rstatus FROM reader WHERE rid=%s", (rid,))
        rr = cur.fetchone()
        if not rr:
            conn.rollback()
            return jsonify({"msg": "添加失败：读者不存在"})
        if rr[0] != '正常':
            conn.rollback()
            return jsonify({"msg": f"添加失败：读者状态异常（{rr[0]}），无法办理业务"})

        now = datetime.now()
        if br_type == '借书':
            bid = d.get('bid')
            sid = None
            if not bid:
                conn.rollback()
                return jsonify({"msg": "借书需要指定图书编号"})
            deadline = now + timedelta(days=30)
            # 原子扣减库存：仅当库存大于 0 时更新才会生效，避免超借
            cur.execute("UPDATE book SET bcan_borrow = bcan_borrow - 1 WHERE bid=%s AND bcan_borrow > 0", (bid,))
            if cur.rowcount == 0:
                conn.rollback()
                return jsonify({"msg": "添加失败：图书不存在或已无可借副本"})
        else:
            sid = d.get('sid')
            bid = None
            if not sid:
                conn.rollback()
                return jsonify({"msg": "预约座位需要指定座位编号"})
            deadline = now + timedelta(hours=8)
            # 检查该座位是否已有进行中的预约
            cur.execute("SELECT COUNT(*) FROM borrow_reserve WHERE sid=%s AND br_state='待完成'", (sid,))
            if cur.fetchone()[0] > 0:
                conn.rollback()
                return jsonify({"msg": "添加失败：该座位已有进行中的预约"})
            # 原子占用座位：仅当座位空闲时更新才会生效
            cur.execute("UPDATE seat SET sstatus='占用' WHERE sid=%s AND sstatus='空闲'", (sid,))
            if cur.rowcount == 0:
                conn.rollback()
                return jsonify({"msg": "添加失败：座位不存在或当前不可预约（占用/维修）"})

        cur.execute(
            "INSERT INTO borrow_reserve (rid, bid, sid, br_type, operate_time, deadline, real_end, renew_num, over_days, fine_money, pay_state, br_state) VALUES (%s, %s, %s, %s, %s, %s, NULL, 0, 0, 0.00, '无罚款', '待完成')",
            (rid, bid, sid, br_type, now.strftime('%Y-%m-%d %H:%M:%S'), deadline.strftime('%Y-%m-%d %H:%M:%S'))
        )
        conn.commit()
    except Exception as e:
        conn.rollback()
        return jsonify({"msg": f"添加失败：{e}"})
    finally:
        cur.close()
        conn.close()
    return jsonify({"msg": "添加成功"})


@borrow_reserve_bp.route('/update', methods=['POST'])
def borrow_reserve_update():
    """更新借阅/预约记录。可更新 br_state、pay_state、real_end 等字段。

    - 权限：管理员可修改任意记录；读者只能修改本人记录。
    - 待完成业务转为 已完成/取消/爽约 时：自动恢复图书库存、释放座位。
    - 转为 已完成 时：按 deadline 计算逾期天数与罚款（每天 0.5 元）。
    """
    d = request.json or {}
    br_id = d.get('br_id')
    user = _current_user()

    conn = get_conn()
    cur = conn.cursor()
    try:
        cur.execute("SELECT rid, br_type, bid, sid, br_state, deadline FROM borrow_reserve WHERE br_id=%s", (br_id,))
        row = cur.fetchone()
        if not row:
            conn.rollback()
            return jsonify({"msg": "修改失败：未找到该记录"})
        rec_rid, br_type, bid, sid, old_state, deadline = row

        # 权限校验：管理员或记录本人
        if user.get('role') != 'admin' and not (user.get('role') == 'reader' and user.get('relation_id') == rec_rid):
            conn.rollback()
            return jsonify({"msg": "无权限：读者仅可修改本人记录"})

        br_state = d.get('br_state') or old_state
        real_end_dt = _parse_dt(d.get('real_end'))

        over_days = 0
        fine_money = 0.00
        pay_state = d.get('pay_state') or '无罚款'

        # 资源恢复条件：待完成 -> 已完成/取消/爽约（只恢复一次，避免重复加回）
        restore_needed = (old_state == '待完成' and br_state != '待完成')

        if br_state == '已完成':
            # 归还/离场时间：未提供则取当前时间
            real_end_dt = real_end_dt or datetime.now()
            if restore_needed and deadline and real_end_dt > deadline:
                over_days = (real_end_dt - deadline).days
            fine_money = calculate_fine(over_days)
            if not d.get('pay_state'):
                pay_state = '无罚款' if fine_money == 0 else '未缴费'

        # 与 book / seat 表联动，恢复库存或释放座位
        if restore_needed:
            if br_type == '借书' and bid:
                cur.execute("UPDATE book SET bcan_borrow = bcan_borrow + 1 WHERE bid=%s", (bid,))
            if br_type == '预约座位' and sid:
                cur.execute("UPDATE seat SET sstatus='空闲' WHERE sid=%s", (sid,))

        real_end = real_end_dt.strftime('%Y-%m-%d %H:%M:%S') if real_end_dt else None
        cur.execute(
            "UPDATE borrow_reserve SET br_state=%s, pay_state=%s, real_end=%s, over_days=%s, fine_money=%s WHERE br_id=%s",
            (br_state, pay_state, real_end, over_days, fine_money, br_id)
        )
        conn.commit()
    except Exception as e:
        conn.rollback()
        return jsonify({"msg": f"修改失败：{e}"})
    finally:
        cur.close()
        conn.close()
    return jsonify({"msg": "修改成功"})


@borrow_reserve_bp.route('/delete', methods=['POST'])
def borrow_reserve_delete():
    """根据 `br_id` 删除借阅/预约记录（仅管理员）。"""
    if not is_admin():
        return jsonify({"msg": "无权限"})
    br_id = request.json['br_id']
    conn = get_conn()
    cur = conn.cursor()
    try:
        cur.execute("DELETE FROM borrow_reserve WHERE br_id=%s", (br_id,))
        if cur.rowcount == 0:
            conn.rollback()
            return jsonify({"msg": "删除失败：未找到该记录"})
        conn.commit()
    except Exception as e:
        conn.rollback()
        return jsonify({"msg": f"删除失败：{e}"})
    finally:
        cur.close()
        conn.close()
    return jsonify({"msg": "删除成功"})
