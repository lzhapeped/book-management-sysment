"""应用通用工具。

本模块提供：
- `CustomJSONProvider`，Flask JSON 提供者，将 Decimal/date/datetime 序列化为
  友好的 JSON 格式（日期为 YYYY-MM-DD，时间为 YYYY-MM-DD HH:MM:SS），并允许中文直接输出。
- `calculate_fine()`，用于根据逾期天数计算罚款金额。
- 基于 Flask `session` 的简单角色判断函数。
"""
from decimal import Decimal
from datetime import date, datetime
from flask import session
from flask.json.provider import DefaultJSONProvider


class CustomJSONProvider(DefaultJSONProvider):
    """处理 Decimal 和日期类型的 JSON 提供者，且中文不转义输出。"""

    ensure_ascii = False

    @staticmethod
    def default(obj):
        if isinstance(obj, Decimal):
            return float(obj)
        if isinstance(obj, datetime):
            return obj.strftime("%Y-%m-%d %H:%M:%S")
        if isinstance(obj, date):
            return obj.strftime("%Y-%m-%d")
        return DefaultJSONProvider.default(obj)


def calculate_fine(over_days):
    """根据逾期天数计算罚款金额（每天0.5元）。"""
    if over_days is None or over_days <= 0:
        return 0.00
    return round(over_days * 0.5, 2)


def is_admin():
    """当当前会话用户角色为管理员时返回 True。"""
    return session.get('user', {}).get('role') == 'admin'
