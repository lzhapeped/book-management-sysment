"""图书管理蓝图。

提供对 `book` 表的简单 增删改查 接口。
"""

from flask import Blueprint, request, jsonify, session
from ..core.db import get_conn
from ..core.utils import is_admin

book_bp = Blueprint('book', __name__, url_prefix='/api/book')


@book_bp.route('/list')
def book_list():
    """返回图书数据。所有角色可查看。"""
    conn = get_conn()
    cur = conn.cursor()
    try:
        cur.execute("SELECT * FROM book")
        res = cur.fetchall()
    finally:
        cur.close()
        conn.close()
    return jsonify(res)


@book_bp.route('/add', methods=['POST'])
def book_add():
    """添加图书。期望 JSON：{bid,bname,bauthor,bcategory,bpress,bpub_date,btotal,bcan_borrow,bshelf,bprice}。"""
    if not is_admin():
        return jsonify({"msg": "无权限"})
    d = request.json
    conn = get_conn()
    cur = conn.cursor()
    try:
        cur.execute(
            "INSERT INTO book (bid, bname, bauthor, bcategory, bpress, bpub_date, btotal, bcan_borrow, bshelf, bprice) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)",
            (d['bid'], d['bname'], d['bauthor'], d['bcategory'], d.get('bpress', ''), d.get('bpub_date', None), d['btotal'], d.get('bcan_borrow', 0), d['bshelf'], d.get('bprice', None))
        )
        conn.commit()
    except Exception as e:
        conn.rollback()
        return jsonify({"msg": f"添加失败：{e}"})
    finally:
        cur.close()
        conn.close()
    return jsonify({"msg": "添加成功"})


@book_bp.route('/update', methods=['POST'])
def book_update():
    """根据 `bid` 更新图书。"""
    if not is_admin():
        return jsonify({"msg": "无权限"})
    d = request.json
    conn = get_conn()
    cur = conn.cursor()
    try:
        cur.execute("UPDATE book SET bname=%s,bauthor=%s,bcategory=%s,bpress=%s,bpub_date=%s,btotal=%s,bcan_borrow=%s,bshelf=%s,bprice=%s WHERE bid=%s",
                    (d['bname'], d['bauthor'], d['bcategory'], d.get('bpress', ''), d.get('bpub_date', None), d['btotal'], d.get('bcan_borrow', 0), d['bshelf'], d.get('bprice', None), d['bid']))
        if cur.rowcount == 0:
            conn.rollback()
            return jsonify({"msg": "修改失败：未找到该图书"})
        conn.commit()
    except Exception as e:
        conn.rollback()
        return jsonify({"msg": f"修改失败：{e}"})
    finally:
        cur.close()
        conn.close()
    return jsonify({"msg": "修改成功"})


@book_bp.route('/delete', methods=['POST'])
def book_delete():
    """根据 `bid` 删除图书。"""
    if not is_admin():
        return jsonify({"msg": "无权限"})
    bid = request.json['bid']
    conn = get_conn()
    cur = conn.cursor()
    try:
        cur.execute("DELETE FROM book WHERE bid=%s", (bid,))
        if cur.rowcount == 0:
            conn.rollback()
            return jsonify({"msg": "删除失败：未找到该图书"})
        conn.commit()
    except Exception as e:
        conn.rollback()
        return jsonify({"msg": f"删除失败：{e}"})
    finally:
        cur.close()
        conn.close()
    return jsonify({"msg": "删除成功"})


@book_bp.route('/options')
def book_options():
    """返回用于下拉框的精简列表：[{bid,bname},...]。"""
    conn = get_conn()
    cur = conn.cursor()
    cur.execute("SELECT bid, bname FROM book")
    res = cur.fetchall()
    cur.close()
    conn.close()
    return jsonify([{"bid": r[0], "bname": r[1]} for r in res])
