"""数据库连接助手。

该助手集中管理数据库连接配置，需要根据实际情况进行调整。
"""
import pymysql


def get_conn():
    """返回一个新的 PyMySQL 连接。"""
    return pymysql.connect(
        host="localhost",
        user="root",
        password="1234",
        database="library_db",
        charset="utf8mb4"
    )
