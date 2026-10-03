# 图书馆预约管理系统

基于 Flask + PyMySQL + ECharts 的图书馆预约管理系统，支持图书管理、读者管理、座位管理、借阅预约管理和数据可视化。

## 运行步骤

1. 在 Navicat 中导入 `sql_docs/library_db.sql` 到 MySQL，创建 `library_db` 数据库

2. 安装依赖：

```bash
pip install -r requirements.txt
```

3. 修改 `myapp/core/db.py` 中的数据库连接配置（默认 localhost:3306, root/1234）

4. 启动应用（默认端口 5000）：

```bash
python start.py
```

5. 浏览器访问 `http://localhost:5000`

## 登录账号

| 角色 | 账号 | 密码 |
|------|------|------|
| 管理员 | admin | admin123 |
| 读者 | 读者编号（如 20240001） | 读者编号+123（如 20240001123） |
| 读者 | 教工编号（如 T001） | 教工编号+123（如 T001123） |

## 目录结构

- `start.py`：Flask 应用入口
- `myapp/`：应用包
  - `core/db.py`：数据库连接配置
  - `core/utils.py`：通用工具函数与 JSON 编码器
  - `blueprints/`：业务路由模块
    - `auth.py`：登录与认证
    - `reader.py`：读者信息管理
    - `book.py`：图书管理
    - `seat.py`：座位管理
    - `borrow_reserve.py`：借阅与预约管理
- `templates/`：页面模板
- `static/`：静态资源（CSS + JS）
- `sql_docs/`：数据库脚本与说明文档

## 功能模块

- **首页**：数据总览，含6张统计卡片和7个 ECharts 图表
- **读者管理**：读者信息的增删改查（管理员权限）
- **图书管理**：图书信息的增删改查（管理员权限）
- **座位管理**：自习座位信息的增删改查（管理员权限）
- **借阅管理**：借书/预约座位的增删改查

## 技术栈

- 后端：Python + Flask + PyMySQL
- 前端：HTML + CSS + JavaScript + ECharts
- 数据库：MySQL 8.0
