"""认证蓝图。

该蓝图提供 `/api/login`、`/api/logout`、`/api/me` 接口。
登录成功后设置 `session['user']`。
管理员账号为 admin/admin123，读者密码为 读者编号+123。
"""

from flask import Blueprint, request, jsonify, session
from ..core.db import get_conn

auth_bp = Blueprint('auth', __name__, url_prefix='/api')


def _build_user_session(username, role, relation_id):
    return {
        "uid": 0,
        "username": username,
        "role": role,
        "relation_id": relation_id,
    }


@auth_bp.route('/me')
def me():
    """返回当前登录用户信息。"""
    return jsonify({"user": session.get('user')})


@auth_bp.route('/logout', methods=['POST'])
def logout():
    """清除当前登录会话。"""
    session.clear()
    return jsonify({"msg": "已退出登录"})


@auth_bp.route('/login', methods=['POST'])
def login():
    """认证用户并创建会话信息。"""
    d = request.json or {}
    username = (d.get('username') or '').strip()
    password = (d.get('password') or '').strip()

    if username == 'admin' and password == 'admin123':
        session.clear()
        session['user'] = _build_user_session(username, 'admin', None)
        return jsonify({"msg": "登录成功", "user": session['user']})

    if not username or not password or password != f"{username}123":
        return jsonify({"msg": "账号或密码错误"})

    conn = get_conn()
    cur = conn.cursor()
    try:
        cur.execute("SELECT rid, rstatus FROM reader WHERE rid=%s", (username,))
        reader = cur.fetchone()
        if reader:
            if reader[1] != '正常':
                return jsonify({"msg": f"账号状态异常：{reader[1]}，无法登录"})
            session.clear()
            session['user'] = _build_user_session(username, 'reader', username)
            return jsonify({"msg": "登录成功", "user": session['user']})
    finally:
        cur.close()
        conn.close()

    return jsonify({"msg": "账号或密码错误"})
