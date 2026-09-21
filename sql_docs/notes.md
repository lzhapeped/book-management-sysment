# library_db 数据库说明

## 表结构与字段含义

### 表：`book`（图书馆藏表）

| 字段 | 类型 | 说明 |
|------|------|------|
| `bid` | varchar(30) | ISBN图书编号，主键 |
| `bname` | varchar(100) | 书名 |
| `bauthor` | varchar(80) | 作者 |
| `bcategory` | varchar(30) | 图书分类（文学/计算机/数理/历史） |
| `bpress` | varchar(60) | 出版社 |
| `bpub_date` | date | 出版日期 |
| `btotal` | int | 馆藏总数 |
| `bcan_borrow` | int | 可借数量 |
| `bshelf` | varchar(20) | 书架号 |
| `bprice` | decimal(6,2) | 定价 |

### 表：`reader`（读者信息表）

| 字段 | 类型 | 说明 |
|------|------|------|
| `rid` | varchar(20) | 读者编号，主键（学生如20240001，教工如T001） |
| `rname` | varchar(50) | 姓名 |
| `rtype` | char(4) | 类型（学生/教工） |
| `rmajor` | varchar(30) | 专业（教工为空） |
| `rphone` | char(11) | 手机号（唯一） |
| `remail` | varchar(50) | 邮箱 |
| `rreg_date` | date | 注册日期 |
| `rstatus` | varchar(10) | 账号状态（正常/封禁/注销） |

### 表：`seat`（自习座位表）

| 字段 | 类型 | 说明 |
|------|------|------|
| `sid` | varchar(15) | 座位编号，主键（如A01-01） |
| `sfloor` | tinyint | 楼层（1-4） |
| `sroom` | varchar(10) | 自习室（如A01） |
| `sstatus` | varchar(10) | 座位状态（空闲/占用/维修） |

### 表：`borrow_reserve`（借阅预约表）

| 字段 | 类型 | 说明 |
|------|------|------|
| `br_id` | int | 记录编号，主键，自增 |
| `rid` | varchar(20) | 读者编号 |
| `bid` | varchar(30) | 图书ISBN（借书时填写） |
| `sid` | varchar(15) | 座位编号（预约座位时填写） |
| `br_type` | varchar(20) | 类型（借书/预约座位） |
| `operate_time` | datetime | 操作时间 |
| `deadline` | datetime | 截止时间 |
| `real_end` | datetime | 实际结束时间 |
| `renew_num` | int | 续借次数 |
| `over_days` | int | 逾期天数 |
| `fine_money` | decimal(6,2) | 罚款金额 |
| `pay_state` | varchar(20) | 缴费状态（无罚款/未缴费/已缴费） |
| `br_state` | varchar(20) | 借阅状态（待完成/已完成/取消/爽约） |

## 视图

- `admin_system_info`：管理员系统信息视图，关联读者、借阅、图书、座位
- `librarian_work_info`：馆员工作信息视图，查询当日借阅记录
- `reader_my_info`：读者个人信息视图，查询个人借阅记录
