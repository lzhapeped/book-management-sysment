# library_db 数据库文档说明

## 主要文件

- `library_db.sql`：数据库表结构与测试数据脚本（Navicat 导出）。
- `notes.md`：表结构说明、字段含义和设计要点。

## 使用方法

1. 在 MySQL 中创建数据库 `library_db`
2. 用 Navicat 或命令行导入 `library_db.sql`
3. 脚本包含建表语句和测试数据，导入后可直接使用

## 数据库配置

在 `myapp/core/db.py` 中配置连接：

```python
host="localhost"
user="root"
password="123456"
database="library_db"
```
