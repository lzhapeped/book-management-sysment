"""读者管理蓝图。

本模块实现了对 `reader` 表的简单 CRUD 接口，并根据当前登录角色
返回与该角色相关的数据。
"""

from flask import Blueprint, request, jsonify, session
from ..core.db import get_conn
from ..core.utils import is_admin

reader_bp = Blueprint('reader', __name__, url_prefix='/api/reader')


@reader_bp.route('/list')
def reader_list():
    """返回与当前角色相关的读者记录。"""
    user = session.get('user', {})
    role = user.get('role')
    relation_id = user.get('relation_id')

    conn = get_conn()
    cur = conn.cursor()
    try:
        if role == 'reader':
            cur.execute("SELECT * FROM reader WHERE rid=%s", (relation_id,))
        else:
            cur.execute("SELECT * FROM reader")
        res = cur.fetchall()
    finally:
        cur.close()
        conn.close()
    return jsonify(res)


@reader_bp.route('/add', methods=['POST'])
def reader_add():
    """插入新的读者。期望 JSON：{rid,rname,rtype,rmajor,rphone,remail,rstatus}。"""
    if not is_admin():
        return jsonify({"msg": "无权限"})
    d = request.json
    conn = get_conn()
    cur = conn.cursor()
    try:
        cur.execute(
            "INSERT INTO reader (rid, rname, rtype, rmajor, rphone, remail, rstatus) VALUES (%s, %s, %s, %s, %s, %s, %s)",
            (d['rid'], d['rname'], d['rtype'], d.get('rmajor', ''), d.get('rphone', ''), d.get('remail', ''), d.get('rstatus', '正常'))
        )
        conn.commit()
    except Exception as e:
        conn.rollback()
        return jsonify({"msg": f"添加失败：{e}"})
    finally:
        cur.close()
        conn.close()
    return jsonify({"msg": "添加成功"})


@reader_bp.route('/update', methods=['POST'])
def reader_update():
    """根据 `rid` 更新已有读者。"""
    if not is_admin():
        return jsonify({"msg": "无权限"})
    d = request.json
    conn = get_conn()
    cur = conn.cursor()
    try:
        cur.execute("UPDATE reader SET rname=%s,rtype=%s,rmajor=%s,rphone=%s,remail=%s,rstatus=%s WHERE rid=%s",
                    (d['rname'], d['rtype'], d.get('rmajor', ''), d.get('rphone', ''), d.get('remail', ''), d.get('rstatus', '正常'), d['rid']))
        if cur.rowcount == 0:
            conn.rollback()
            return jsonify({"msg": "修改失败：未找到该读者"})
        conn.commit()
    except Exception as e:
        conn.rollback()
        return jsonify({"msg": f"修改失败：{e}"})
    finally:
        cur.close()
        conn.close()
    return jsonify({"msg": "修改成功"})


@reader_bp.route('/delete', methods=['POST'])
def reader_delete():
    """根据 `rid` 删除读者。"""
    if not is_admin():
        return jsonify({"msg": "无权限"})
    rid = request.json['rid']
    conn = get_conn()
    cur = conn.cursor()
    try:
        cur.execute("DELETE FROM reader WHERE rid=%s", (rid,))
        if cur.rowcount == 0:
            conn.rollback()
            return jsonify({"msg": "删除失败：未找到该读者"})
        conn.commit()
    except Exception as e:
        conn.rollback()
        return jsonify({"msg": f"删除失败：{e}"})
    finally:
        cur.close()
        conn.close()
    return jsonify({"msg": "删除成功"})


@reader_bp.route('/options')
def reader_options():
    """返回用于下拉框的精简列表：[{rid,rname},...]。"""
    conn = get_conn()
    cur = conn.cursor()
    cur.execute("SELECT rid, rname FROM reader")
    res = cur.fetchall()
    cur.close()
    conn.close()
    return jsonify([{"rid": r[0], "rname": r[1]} for r in res])
