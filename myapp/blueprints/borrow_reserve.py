"""借阅预约管理蓝图。

处理 `borrow_reserve` 表的 增删改查 操作，并根据当前登录角色返回相关记录。
"""
from flask import Blueprint, request, jsonify, session
from ..core.db import get_conn
from ..core.utils import is_admin
from datetime import datetime, timedelta

borrow_reserve_bp = Blueprint('borrow_reserve', __name__, url_prefix='/api/borrow_reserve')


@borrow_reserve_bp.route('/list')
def borrow_reserve_list():
    """返回与当前角色相关的借阅预约记录。"""
    user = session.get('user', {})
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
    """添加借阅/预约记录。期望 JSON：{rid,bid,sid,br_type}。"""
    d = request.json
    conn = get_conn()
    cur = conn.cursor()
    try:
        now = datetime.now()
        if d['br_type'] == '借书':
            deadline = now + timedelta(days=30)
            bid = d.get('bid')
            sid = None
            if not bid:
                return jsonify({"msg": "借书需要指定图书编号"})
        else:
            deadline = now + timedelta(hours=8)
            sid = d.get('sid')
            bid = None
            if not sid:
                return jsonify({"msg": "预约座位需要指定座位编号"})

        cur.execute(
            "INSERT INTO borrow_reserve (rid, bid, sid, br_type, operate_time, deadline, real_end, renew_num, over_days, fine_money, pay_state, br_state) VALUES (%s, %s, %s, %s, %s, %s, NULL, 0, 0, 0.00, '无罚款', '待完成')",
            (d['rid'], bid, sid, d['br_type'], now.strftime('%Y-%m-%d %H:%M:%S'), deadline.strftime('%Y-%m-%d %H:%M:%S'))
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
    """更新借阅/预约记录。可更新 br_state、pay_state 等字段。"""
    d = request.json
    conn = get_conn()
    cur = conn.cursor()
    try:
        real_end = d.get('real_end')
        if real_end == '':
            real_end = None
        cur.execute(
            "UPDATE borrow_reserve SET br_state=%s, pay_state=%s, real_end=%s WHERE br_id=%s",
            (d['br_state'], d['pay_state'], real_end, d['br_id'])
        )
        if cur.rowcount == 0:
            conn.rollback()
            return jsonify({"msg": "修改失败：未找到该记录"})
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
    """根据 `br_id` 删除借阅/预约记录。"""
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
