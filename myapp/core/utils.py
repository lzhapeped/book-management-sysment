"""应用通用工具。

本模块提供：
- `CustomJSONEncoder`，用于将 Decimal/date 对象序列化为 JSON。
- `calculate_fine()`，用于根据逾期天数计算罚款金额。
- 基于 Flask `session` 的简单角色判断函数。
"""
import json
from decimal import Decimal
from datetime import date, datetime
from flask import session


class CustomJSONEncoder(json.JSONEncoder):
    """处理 Decimal 和日期类型的 JSON 编码器。"""
    def default(self, obj):
        if isinstance(obj, Decimal):
            return float(obj)
        if isinstance(obj, (date, datetime)):
            return obj.strftime("%Y-%m-%d %H:%M:%S") if isinstance(obj, datetime) else obj.strftime("%Y-%m-%d")
        return super().default(obj)


def calculate_fine(over_days):
    """根据逾期天数计算罚款金额（每天0.5元）。"""
    if over_days is None or over_days <= 0:
        return 0.00
    return round(over_days * 0.5, 2)


def is_admin():
    """当当前会话用户角色为管理员时返回 True。"""
    return session.get('user', {}).get('role') == 'admin'
