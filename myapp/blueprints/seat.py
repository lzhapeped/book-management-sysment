"""座位管理蓝图。

实现 list/add/update/delete 以及前端下拉框使用的 `options` 接口。
"""

from flask import Blueprint, request, jsonify, session
from ..core.db import get_conn
from ..core.utils import is_admin

seat_bp = Blueprint('seat', __name__, url_prefix='/api/seat')


@seat_bp.route('/list')
def seat_list():
    """返回座位数据。所有角色可查看。"""
    conn = get_conn()
    cur = conn.cursor()
    try:
        cur.execute("SELECT * FROM seat")
        res = cur.fetchall()
    finally:
        cur.close()
        conn.close()
    return jsonify(res)


@seat_bp.route('/add', methods=['POST'])
def seat_add():
    """添加座位。期望 JSON：{sid,sfloor,sroom,sstatus}。"""
    if not is_admin():
        return jsonify({"msg": "无权限"})
    d = request.json
    conn = get_conn()
    cur = conn.cursor()
    try:
        cur.execute("INSERT INTO seat (sid, sfloor, sroom, sstatus) VALUES (%s, %s, %s, %s)",
                    (d['sid'], d['sfloor'], d['sroom'], d.get('sstatus', '空闲')))
        conn.commit()
    except Exception as e:
        conn.rollback()
        return jsonify({"msg": f"添加失败：{e}"})
    finally:
        cur.close()
        conn.close()
    return jsonify({"msg": "添加成功"})


@seat_bp.route('/update', methods=['POST'])
def seat_update():
    """根据 `sid` 更新座位。"""
    if not is_admin():
        return jsonify({"msg": "无权限"})
    d = request.json
    conn = get_conn()
    cur = conn.cursor()
    try:
        cur.execute("UPDATE seat SET sfloor=%s, sroom=%s, sstatus=%s WHERE sid=%s",
                    (d['sfloor'], d['sroom'], d['sstatus'], d['sid']))
        if cur.rowcount == 0:
            conn.rollback()
            return jsonify({"msg": "修改失败：未找到该座位"})
        conn.commit()
    except Exception as e:
        conn.rollback()
        return jsonify({"msg": f"修改失败：{e}"})
    finally:
        cur.close()
        conn.close()
    return jsonify({"msg": "修改成功"})


@seat_bp.route('/delete', methods=['POST'])
def seat_delete():
    """根据 `sid` 删除座位。"""
    if not is_admin():
        return jsonify({"msg": "无权限"})
    sid = request.json['sid']
    conn = get_conn()
    cur = conn.cursor()
    try:
        cur.execute("DELETE FROM seat WHERE sid=%s", (sid,))
        if cur.rowcount == 0:
            conn.rollback()
            return jsonify({"msg": "删除失败：未找到该座位"})
        conn.commit()
    except Exception as e:
        conn.rollback()
        return jsonify({"msg": f"删除失败：{e}"})
    finally:
        cur.close()
        conn.close()
    return jsonify({"msg": "删除成功"})


@seat_bp.route('/options')
def seat_options():
    """返回用于下拉框的精简列表：[{sid,sroom},...]。"""
    conn = get_conn()
    cur = conn.cursor()
    cur.execute("SELECT sid, sroom FROM seat WHERE sstatus='空闲'")
    res = cur.fetchall()
    cur.close()
    conn.close()
    return jsonify([{"sid": r[0], "sroom": r[1]} for r in res])
