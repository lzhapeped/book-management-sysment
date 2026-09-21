# student_project 目录结构说明

- `start.py`：启动 Flask 应用的入口脚本。
- `myapp/`：应用包。
  - `__init__.py`：应用工厂函数 `create_app()`，注册蓝图并初始化应用。
  - `core/`：核心支持代码。
    - `db.py`：创建 MySQL 连接的 `get_conn()` 函数。
    - `utils.py`：自定义 JSON 编码器、罚款计算、权限判断等通用工具函数。
  - `blueprints/`：业务路由模块。
    - `auth.py`：登录和认证接口。
    - `reader.py`：读者信息管理接口。
    - `book.py`：图书管理接口。
    - `seat.py`：座位管理接口。
    - `borrow_reserve.py`：借阅预约管理接口。
- `templates/`：前端 HTML 页面模板。
- `static/`：前端静态资源。
  - `css/style.css`：页面样式。
  - `js/app.js`：前端交互和 AJAX 请求逻辑。
- `sql_docs/`：数据库文档和 SQL 脚本。
  - `library_db.sql`：数据库建表和测试数据脚本。
  - `README.md`：数据库表结构说明。
  - `notes.md`：数据库设计说明。

## 说明

`__pycache__/` 目录由 Python 运行时自动生成的字节码缓存，不需要手动修改。
