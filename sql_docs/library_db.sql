/*
 Navicat Premium Dump SQL

 Source Server         : mytest
 Source Server Type    : MySQL
 Source Server Version : 80400 (8.4.0)
 Source Host           : localhost:3306
 Source Schema         : library_db

 Target Server Type    : MySQL
 Target Server Version : 80400 (8.4.0)
 File Encoding         : 65001

 Date: 21/06/2026 17:06:08
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book`  (
  `bid` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'ISBN图书编号',
  `bname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '书名',
  `bauthor` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '作者',
  `bcategory` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '图书分类',
  `bpress` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '出版社',
  `bpub_date` date NULL DEFAULT NULL COMMENT '出版日期',
  `btotal` int NOT NULL COMMENT '馆藏总数',
  `bcan_borrow` int NOT NULL DEFAULT 0 COMMENT '可借数量',
  `bshelf` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '书架号',
  `bprice` decimal(6, 2) NULL DEFAULT NULL COMMENT '定价',
  PRIMARY KEY (`bid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '图书馆藏表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES ('9787020000222', '红楼梦', '曹雪芹', '文学', '人民文学出版社', '2018-03-01', 25, 18, 'B01', 58.00);
INSERT INTO `book` VALUES ('9787020000239', '三国演义', '罗贯中', '文学', '人民文学出版社', '2018-04-02', 22, 16, 'B01', 56.00);
INSERT INTO `book` VALUES ('9787020000246', '水浒传', '施耐庵', '文学', '人民文学出版社', '2018-05-05', 20, 13, 'B02', 54.00);
INSERT INTO `book` VALUES ('9787020000253', '西游记', '吴承恩', '文学', '人民文学出版社', '2018-06-08', 24, 17, 'B02', 52.00);
INSERT INTO `book` VALUES ('9787020000260', '骆驼祥子', '老舍', '文学', '人民文学出版社', '2018-07-12', 26, 19, 'B01', 32.00);
INSERT INTO `book` VALUES ('9787020000277', '围城', '钱钟书', '文学', '人民文学出版社', '2018-08-14', 23, 15, 'B01', 38.00);
INSERT INTO `book` VALUES ('9787020000284', '骆驼祥子解读', '老舍', '文学', '人民文学出版社', '2018-09-05', 18, 11, 'B01', 28.00);
INSERT INTO `book` VALUES ('9787020000291', '茶馆', '老舍', '文学', '人民文学出版社', '2018-10-12', 16, 10, 'B01', 26.00);
INSERT INTO `book` VALUES ('9787020000307', '四世同堂', '老舍', '文学', '人民文学出版社', '2018-11-18', 22, 14, 'B01', 62.00);
INSERT INTO `book` VALUES ('9787020000314', '子夜', '茅盾', '文学', '人民文学出版社', '2018-12-22', 20, 13, 'B01', 48.00);
INSERT INTO `book` VALUES ('9787030654210', '高等数学同济七版', '同济大学数学系', '数理', '高等教育出版社', '2019-07-22', 40, 31, 'D01', 76.00);
INSERT INTO `book` VALUES ('9787030654227', '线性代数同济七版', '同济大学数学系', '数理', '高等教育出版社', '2019-08-10', 38, 29, 'D01', 42.00);
INSERT INTO `book` VALUES ('9787030654234', '概率论与数理统计', '盛骤', '数理', '高等教育出版社', '2019-09-05', 36, 27, 'D02', 48.00);
INSERT INTO `book` VALUES ('9787030654241', '复变函数', '钟玉泉', '数理', '高等教育出版社', '2019-10-22', 32, 23, 'D02', 45.00);
INSERT INTO `book` VALUES ('9787030654258', '离散数学', '屈婉玲', '数理', '高等教育出版社', '2019-11-10', 34, 25, 'D02', 52.00);
INSERT INTO `book` VALUES ('9787030654265', '数学分析', '华东师大数学系', '数理', '高等教育出版社', '2019-12-20', 30, 21, 'D02', 68.00);
INSERT INTO `book` VALUES ('9787030654272', '常微分方程', '王高雄', '数理', '高等教育出版社', '2020-01-08', 28, 19, 'D02', 46.00);
INSERT INTO `book` VALUES ('9787030654289', '实变函数', '周民强', '数理', '高等教育出版社', '2020-02-16', 26, 17, 'D02', 58.00);
INSERT INTO `book` VALUES ('9787030654296', '数学建模', '姜启源', '数理', '高等教育出版社', '2020-03-20', 32, 23, 'D02', 49.00);
INSERT INTO `book` VALUES ('9787101127823', '史记', '司马迁', '历史', '中华书局', '2017-08-10', 12, 7, 'C01', 128.00);
INSERT INTO `book` VALUES ('9787101127830', '资治通鉴', '司马光', '历史', '中华书局', '2017-09-15', 10, 6, 'C01', 168.00);
INSERT INTO `book` VALUES ('9787101132445', '明朝那些事儿', '当年明月', '历史', '中华书局', '2018-11-03', 35, 26, 'C02', 49.00);
INSERT INTO `book` VALUES ('9787101132452', '万历十五年', '黄仁宇', '历史', '中华书局', '2018-12-08', 16, 9, 'C02', 46.00);
INSERT INTO `book` VALUES ('9787101132469', '史记精讲', '韩兆琦', '历史', '中华书局', '2019-01-15', 14, 8, 'C02', 58.00);
INSERT INTO `book` VALUES ('9787101132476', '中国通史', '吕思勉', '历史', '中华书局', '2019-02-22', 15, 9, 'C02', 68.00);
INSERT INTO `book` VALUES ('9787101132483', '史记人物解读', '张大可', '历史', '中华书局', '2019-03-10', 13, 7, 'C02', 55.00);
INSERT INTO `book` VALUES ('9787101132490', '清朝那些事儿', '雾满拦江', '历史', '中华书局', '2019-04-15', 14, 8, 'C02', 43.00);
INSERT INTO `book` VALUES ('9787101132506', '唐朝简史', '吕思勉', '历史', '中华书局', '2019-05-22', 12, 7, 'C02', 41.00);
INSERT INTO `book` VALUES ('9787111608327', 'Python编程：从入门到实践', '埃里克马瑟斯', '计算机', '机械工业出版社', '2022-03-22', 20, 14, 'A02', 89.00);
INSERT INTO `book` VALUES ('9787111608334', 'Python数据分析', '韦斯麦金尼', '计算机', '机械工业出版社', '2022-04-15', 19, 13, 'A02', 98.00);
INSERT INTO `book` VALUES ('9787111608341', 'Vue.js实战', '梁灏', '计算机', '机械工业出版社', '2022-05-30', 17, 11, 'A03', 79.00);
INSERT INTO `book` VALUES ('9787111608358', '前端开发实战', '阮一峰', '计算机', '机械工业出版社', '2022-06-20', 15, 9, 'A03', 95.00);
INSERT INTO `book` VALUES ('9787111632728', 'MySQL必知必会', 'Ben Forta', '计算机', '人民邮电出版社', '2019-05-10', 12, 8, 'A01', 59.00);
INSERT INTO `book` VALUES ('9787111632735', 'SQL高级编程', 'Ben Forta', '计算机', '人民邮电出版社', '2019-06-12', 11, 7, 'A01', 62.00);
INSERT INTO `book` VALUES ('9787111632742', 'Redis设计与实现', '黄健宏', '计算机', '人民邮电出版社', '2019-07-20', 9, 5, 'A01', 108.00);
INSERT INTO `book` VALUES ('9787111632759', 'Mysql8.0从入门到精通', '王英英', '计算机', '人民邮电出版社', '2019-08-18', 14, 9, 'A01', 75.00);
INSERT INTO `book` VALUES ('9787111645636', 'Java核心技术卷1', 'Cay S.Horstmann', '计算机', '机械工业出版社', '2020-07-11', 18, 11, 'A03', 109.00);
INSERT INTO `book` VALUES ('9787111645643', 'SpringBoot实战', 'Craig Walls', '计算机', '机械工业出版社', '2020-08-22', 16, 9, 'A03', 102.00);
INSERT INTO `book` VALUES ('9787111645650', '微服务架构设计', '克里斯理查森', '计算机', '机械工业出版社', '2020-09-10', 13, 7, 'A03', 142.00);
INSERT INTO `book` VALUES ('9787111645667', '微服务SpringCloud', '周亮', '计算机', '机械工业出版社', '2020-10-15', 12, 7, 'A03', 116.00);
INSERT INTO `book` VALUES ('9787111658728', '操作系统概念', '西尔伯沙茨', '计算机', '机械工业出版社', '2019-11-05', 14, 9, 'A03', 119.00);
INSERT INTO `book` VALUES ('9787111658735', '分布式系统', 'Tanenbaum', '计算机', '机械工业出版社', '2019-12-10', 12, 6, 'A03', 135.00);
INSERT INTO `book` VALUES ('9787111658742', '云计算基础', '周志华', '计算机', '机械工业出版社', '2019-12-28', 11, 6, 'A04', 96.00);
INSERT INTO `book` VALUES ('9787111658759', '分布式数据库设计', '黄圣君', '计算机', '机械工业出版社', '2020-01-02', 10, 5, 'A04', 138.00);
INSERT INTO `book` VALUES ('9787111672342', '计算机网络自顶向下', '库罗斯', '计算机', '机械工业出版社', '2021-08-16', 16, 12, 'A04', 105.00);
INSERT INTO `book` VALUES ('9787111672359', '大数据技术原理与应用', '林子雨', '计算机', '机械工业出版社', '2021-09-22', 14, 10, 'A04', 112.00);
INSERT INTO `book` VALUES ('9787111672366', 'Spark大数据分析', '霍尔登卡拉乌', '计算机', '机械工业出版社', '2021-10-12', 12, 8, 'A04', 118.00);
INSERT INTO `book` VALUES ('9787111672373', 'Hadoop大数据开发', '王松', '计算机', '机械工业出版社', '2021-11-25', 11, 6, 'A04', 125.00);
INSERT INTO `book` VALUES ('9787111689012', '深度学习', '伊恩古德费洛', '计算机', '人民邮电出版社', '2022-05-20', 9, 4, 'A04', 149.00);
INSERT INTO `book` VALUES ('9787111689029', '机器学习实战', 'Peter Harrington', '计算机', '人民邮电出版社', '2022-06-18', 10, 5, 'A04', 126.00);
INSERT INTO `book` VALUES ('9787111689036', 'TensorFlow实战', '黄文坚', '计算机', '人民邮电出版社', '2022-07-15', 9, 4, 'A04', 129.00);
INSERT INTO `book` VALUES ('9787111689043', '深度学习图像识别', '黄文坚', '计算机', '人民邮电出版社', '2022-08-22', 8, 3, 'A04', 136.00);
INSERT INTO `book` VALUES ('9787115528971', '数据结构与算法分析', '马克艾伦维斯', '计算机', '人民邮电出版社', '2021-01-08', 15, 10, 'A02', 79.00);
INSERT INTO `book` VALUES ('9787115528988', '算法导论', '托马斯科尔曼', '计算机', '人民邮电出版社', '2021-02-10', 13, 8, 'A02', 145.00);
INSERT INTO `book` VALUES ('9787115528995', 'C++ Primer', '斯坦利利普曼', '计算机', '人民邮电出版社', '2021-03-18', 15, 10, 'A02', 122.00);
INSERT INTO `book` VALUES ('9787115529008', 'Python爬虫开发', '崔庆才', '计算机', '人民邮电出版社', '2021-04-22', 16, 10, 'A02', 86.00);
INSERT INTO `book` VALUES ('9787115546081', '高性能MySQL', '施瓦茨', '计算机', '人民邮电出版社', '2020-02-14', 10, 5, 'A01', 129.00);
INSERT INTO `book` VALUES ('9787115546098', '数据库系统概论', '王珊', '计算机', '人民邮电出版社', '2020-03-15', 17, 12, 'A01', 86.00);
INSERT INTO `book` VALUES ('9787115546104', '数据挖掘概念与技术', '韩家炜', '计算机', '人民邮电出版社', '2020-04-22', 11, 6, 'A02', 132.00);
INSERT INTO `book` VALUES ('9787115546111', '数据仓库与数据挖掘', '陈文伟', '计算机', '人民邮电出版社', '2020-05-30', 10, 5, 'A02', 92.00);
INSERT INTO `book` VALUES ('9787508099876', '经济学原理', '曼昆', '经济', '华夏出版社', '2021-04-11', 18, 10, 'F01', 139.00);
INSERT INTO `book` VALUES ('9787508099883', '微观经济学', '高鸿业', '经济', '华夏出版社', '2021-05-06', 22, 14, 'F01', 78.00);
INSERT INTO `book` VALUES ('9787508099890', '宏观经济学', '高鸿业', '经济', '华夏出版社', '2021-06-18', 20, 12, 'F01', 82.00);
INSERT INTO `book` VALUES ('9787508099906', '计量经济学', '李子奈', '经济', '华夏出版社', '2021-07-22', 16, 9, 'F01', 76.00);
INSERT INTO `book` VALUES ('9787508099913', '产业经济学', '苏东水', '经济', '华夏出版社', '2021-08-16', 14, 8, 'F01', 72.00);
INSERT INTO `book` VALUES ('9787514930223', '艺术概论', '王宏建', '艺术', '中国书店出版社', '2020-06-12', 15, 8, 'G01', 65.00);
INSERT INTO `book` VALUES ('9787514930230', '西方美术史', '陈丹青', '艺术', '中国书店出版社', '2020-07-25', 13, 7, 'G01', 72.00);
INSERT INTO `book` VALUES ('9787514930247', '现代艺术150年', '威尔贡培兹', '艺术', '中国书店出版社', '2020-08-30', 12, 6, 'G01', 88.00);
INSERT INTO `book` VALUES ('9787514930254', '中外美术简史', '央美教研室', '艺术', '中国书店出版社', '2020-09-25', 11, 5, 'G01', 66.00);
INSERT INTO `book` VALUES ('9787521324456', '四级词汇闪过', '巨微英语', '外语', '外语教学与研究出版社', '2022-02-18', 50, 38, 'E01', 39.00);
INSERT INTO `book` VALUES ('9787521324463', '六级真题逐句精解', '巨微英语', '外语', '外语教学与研究出版社', '2022-03-20', 45, 33, 'E01', 49.00);
INSERT INTO `book` VALUES ('9787521324470', '考研英语历年真题', '张剑', '外语', '外语教学与研究出版社', '2022-04-28', 42, 30, 'E01', 56.00);
INSERT INTO `book` VALUES ('9787521324487', '雅思词汇词根联想记忆', '俞敏洪', '外语', '外语教学与研究出版社', '2022-05-15', 38, 26, 'E01', 52.00);
INSERT INTO `book` VALUES ('9787521324494', '考研英语写作高分攻略', '王江涛', '外语', '外语教学与研究出版社', '2022-06-30', 36, 24, 'E01', 42.00);
INSERT INTO `book` VALUES ('9787530218666', '活着', '余华', '文学', '北京十月文艺出版社', '2020-01-12', 30, 22, 'B03', 45.00);
INSERT INTO `book` VALUES ('9787530218673', '平凡的世界', '路遥', '文学', '北京十月文艺出版社', '2019-09-20', 28, 19, 'B03', 72.00);
INSERT INTO `book` VALUES ('9787530218680', '人生', '路遥', '文学', '北京十月文艺出版社', '2020-02-20', 21, 14, 'B03', 36.00);
INSERT INTO `book` VALUES ('9787530218697', '兄弟', '余华', '文学', '北京十月文艺出版社', '2020-03-11', 19, 12, 'B03', 42.00);
INSERT INTO `book` VALUES ('9787530218703', '许三观卖血记', '余华', '文学', '北京十月文艺出版社', '2020-04-09', 20, 13, 'B03', 33.00);
INSERT INTO `book` VALUES ('9787530218710', '在细雨中呼喊', '余华', '文学', '北京十月文艺出版社', '2020-05-16', 18, 11, 'B03', 35.00);
INSERT INTO `book` VALUES ('9787530218727', '活着解读', '余华研究学会', '文学', '北京十月文艺出版社', '2020-06-10', 17, 10, 'B03', 29.00);
INSERT INTO `book` VALUES ('9787530218734', '平凡的世界解读', '路遥研究会', '文学', '北京十月文艺出版社', '2020-07-18', 16, 9, 'B03', 36.00);

-- ----------------------------
-- Table structure for borrow_reserve
-- ----------------------------
DROP TABLE IF EXISTS `borrow_reserve`;
CREATE TABLE `borrow_reserve`  (
  `br_id` int NOT NULL AUTO_INCREMENT COMMENT '业务流水ID',
  `rid` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '读者编号',
  `bid` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '借阅图书ISBN，预约座位为空',
  `sid` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '预约座位编号，借书为空',
  `br_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '业务类型：借书/预约座位',
  `operate_time` datetime NOT NULL COMMENT '操作时间',
  `deadline` datetime NULL DEFAULT NULL COMMENT '归还/预约结束时限',
  `real_end` datetime NULL DEFAULT NULL COMMENT '实际归还/离场时间',
  `renew_num` tinyint NULL DEFAULT 0 COMMENT '续借次数',
  `over_days` int NULL DEFAULT 0 COMMENT '逾期天数',
  `fine_money` decimal(5, 2) NULL DEFAULT 0.00 COMMENT '罚款金额',
  `pay_state` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '无罚款' COMMENT '缴费状态',
  `br_state` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '待完成' COMMENT '业务状态',
  PRIMARY KEY (`br_id`) USING BTREE,
  INDEX `fk_br_rid`(`rid` ASC) USING BTREE,
  INDEX `fk_br_bid`(`bid` ASC) USING BTREE,
  INDEX `fk_br_sid`(`sid` ASC) USING BTREE,
  CONSTRAINT `fk_br_bid` FOREIGN KEY (`bid`) REFERENCES `book` (`bid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_br_rid` FOREIGN KEY (`rid`) REFERENCES `reader` (`rid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_br_sid` FOREIGN KEY (`sid`) REFERENCES `seat` (`sid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 58 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '借阅预约综合业务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of borrow_reserve
-- ----------------------------
INSERT INTO `borrow_reserve` VALUES (1, '20240001', '9787111632728', NULL, '借书', '2026-04-01 08:30:00', '2026-05-01 08:30:00', '2026-04-28 15:20:00', 0, 0, 0.00, '无罚款', '已完成');
INSERT INTO `borrow_reserve` VALUES (2, '20240001', '9787020000222', NULL, '借书', '2026-04-02 09:10:00', '2026-05-02 09:10:00', NULL, 1, 8, 4.00, '未缴费', '待完成');
INSERT INTO `borrow_reserve` VALUES (3, '20240002', '9787115546081', NULL, '借书', '2026-04-03 10:00:00', '2026-05-03 10:00:00', '2026-04-30 16:10:00', 0, 0, 0.00, '无罚款', '已完成');
INSERT INTO `borrow_reserve` VALUES (4, '20240002', '9787101132445', NULL, '借书', '2026-04-04 08:40:00', '2026-05-04 08:40:00', NULL, 0, 0, 0.00, '无罚款', '待完成');
INSERT INTO `borrow_reserve` VALUES (5, '20240003', '9787111608327', NULL, '借书', '2026-04-05 11:20:00', '2026-05-05 11:20:00', '2026-05-02 14:30:00', 1, 0, 0.00, '无罚款', '已完成');
INSERT INTO `borrow_reserve` VALUES (6, '20240003', '9787030654210', NULL, '借书', '2026-04-06 09:50:00', '2026-05-06 09:50:00', NULL, 0, 3, 1.50, '未缴费', '待完成');
INSERT INTO `borrow_reserve` VALUES (7, '20240013', NULL, 'A01-01', '预约座位', '2026-06-18 07:30:00', '2026-06-18 12:00:00', '2026-06-18 11:50:00', 0, 0, 0.00, '无罚款', '已完成');
INSERT INTO `borrow_reserve` VALUES (8, '20240014', NULL, 'A01-05', '预约座位', '2026-06-18 08:00:00', '2026-06-18 13:00:00', NULL, 0, 0, 0.00, '无罚款', '待完成');
INSERT INTO `borrow_reserve` VALUES (9, '20240016', '9787020000260', NULL, '借书', '2026-04-16 08:50:00', '2026-05-16 08:50:00', NULL, 0, 10, 5.00, '未缴费', '待完成');
INSERT INTO `borrow_reserve` VALUES (10, '20240017', '9787530218673', NULL, '借书', '2026-04-17 10:20:00', '2026-05-17 10:20:00', '2026-05-12 15:10:00', 0, 0, 0.00, '无罚款', '已完成');
INSERT INTO `borrow_reserve` VALUES (11, '20240021', NULL, 'B01-03', '预约座位', '2026-06-18 08:20:00', '2026-06-18 14:00:00', '2026-06-18 13:50:00', 0, 0, 0.00, '无罚款', '已完成');
INSERT INTO `borrow_reserve` VALUES (12, '20240024', '9787111632742', NULL, '借书', '2026-04-22 15:10:00', '2026-05-22 15:10:00', NULL, 1, 6, 3.00, '未缴费', '待完成');
INSERT INTO `borrow_reserve` VALUES (13, '20240028', NULL, 'B02-02', '预约座位', '2026-06-19 07:40:00', '2026-06-19 12:30:00', NULL, 0, 0, 0.00, '无罚款', '取消');
INSERT INTO `borrow_reserve` VALUES (14, '20240030', '9787111645650', NULL, '借书', '2026-04-26 13:20:00', '2026-05-26 13:20:00', NULL, 1, 9, 4.50, '未缴费', '待完成');
INSERT INTO `borrow_reserve` VALUES (15, '20240035', NULL, 'C01-03', '预约座位', '2026-06-19 09:00:00', '2026-06-19 17:30:00', '2026-06-19 17:00:00', 0, 0, 0.00, '无罚款', '已完成');
INSERT INTO `borrow_reserve` VALUES (16, '20240036', NULL, 'C01-07', '预约座位', '2026-06-19 10:10:00', '2026-06-19 16:00:00', NULL, 0, 0, 0.00, '无罚款', '爽约');
INSERT INTO `borrow_reserve` VALUES (17, 'T001', '9787111632728', NULL, '借书', '2026-04-05 09:00:00', '2026-05-05 09:00:00', '2026-04-30 11:20:00', 0, 0, 0.00, '无罚款', '已完成');
INSERT INTO `borrow_reserve` VALUES (18, 'T002', '9787115546081', NULL, '借书', '2026-04-08 10:10:00', '2026-05-08 10:10:00', NULL, 1, 0, 0.00, '无罚款', '待完成');
INSERT INTO `borrow_reserve` VALUES (19, 'T004', NULL, 'A01-10', '预约座位', '2026-06-18 08:40:00', '2026-06-18 12:30:00', '2026-06-18 12:00:00', 0, 0, 0.00, '无罚款', '已完成');
INSERT INTO `borrow_reserve` VALUES (20, 'T007', NULL, 'B01-12', '预约座位', '2026-06-19 09:50:00', '2026-06-19 17:00:00', NULL, 0, 0, 0.00, '无罚款', '取消');
INSERT INTO `borrow_reserve` VALUES (21, '20240048', NULL, 'D01-02', '预约座位', '2026-06-20 09:20:00', '2026-06-20 18:00:00', NULL, 0, 0, 0.00, '无罚款', '爽约');
INSERT INTO `borrow_reserve` VALUES (22, '20240050', '9787514930247', NULL, '借书', '2026-05-10 08:30:00', '2026-06-10 08:30:00', NULL, 0, 11, 5.50, '未缴费', '待完成');
INSERT INTO `borrow_reserve` VALUES (23, 'T005', '9787020000222', NULL, '借书', '2026-04-15 11:30:00', '2026-05-15 11:30:00', NULL, 0, 4, 2.00, '已缴费', '待完成');
INSERT INTO `borrow_reserve` VALUES (24, 'T010', NULL, 'C01-11', '预约座位', '2026-06-20 08:00:00', '2026-06-20 15:30:00', '2026-06-20 15:10:00', 0, 0, 0.00, '无罚款', '已完成');
INSERT INTO `borrow_reserve` VALUES (25, '20240006', '9787020000277', NULL, '借书', '2026-05-13 10:40:00', '2026-06-13 10:40:00', NULL, 1, 13, 6.50, '未缴费', '待完成');
INSERT INTO `borrow_reserve` VALUES (26, '20240009', NULL, 'A02-11', '预约座位', '2026-06-21 09:00:00', '2026-06-21 18:00:00', '2026-06-21 17:40:00', 0, 0, 0.00, '无罚款', '已完成');
INSERT INTO `borrow_reserve` VALUES (27, '20240042', '9787030654265', NULL, '借书', '2026-05-06 10:10:00', '2026-06-06 10:10:00', NULL, 0, 2, 1.00, '未缴费', '待完成');
INSERT INTO `borrow_reserve` VALUES (28, '20240045', NULL, 'A01-17', '预约座位', '2026-06-22 10:30:00', '2026-06-22 15:00:00', '2026-06-22 14:40:00', 0, 0, 0.00, '无罚款', '已完成');
INSERT INTO `borrow_reserve` VALUES (29, 'T003', '9787101132490', NULL, '借书', '2026-06-04 13:00:00', '2026-07-04 13:00:00', '2026-07-02 10:10:00', 0, 0, 0.00, '无罚款', '已完成');
INSERT INTO `borrow_reserve` VALUES (30, 'T005', NULL, 'B01-20', '预约座位', '2026-06-25 09:30:00', '2026-06-25 18:00:00', NULL, 0, 0, 0.00, '无罚款', '待完成');

-- ----------------------------
-- Table structure for reader
-- ----------------------------
DROP TABLE IF EXISTS `reader`;
CREATE TABLE `reader`  (
  `rid` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '读者编号',
  `rname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '姓名',
  `rtype` char(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '学生/教工',
  `rmajor` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '专业',
  `rphone` char(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '手机号',
  `remail` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `rreg_date` date NOT NULL DEFAULT (curdate()) COMMENT '注册日期',
  `rstatus` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '正常' COMMENT '账号状态',
  PRIMARY KEY (`rid`) USING BTREE,
  UNIQUE INDEX `uk_phone`(`rphone` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '读者信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reader
-- ----------------------------
INSERT INTO `reader` VALUES ('20240001', '张明', '学生', '软件工程', '13800001001', 'zm@stu.xtlg.edu.cn', '2024-09-01', '正常');
INSERT INTO `reader` VALUES ('20240002', '李小雨', '学生', '数据科学', '13800001002', 'lxy@stu.xtlg.edu.cn', '2024-09-01', '正常');
INSERT INTO `reader` VALUES ('20240003', '王浩', '学生', '计算机科学', '13800001003', 'wh@stu.xtlg.edu.cn', '2024-09-02', '正常');
INSERT INTO `reader` VALUES ('20240004', '刘雅', '学生', '人工智能', '13800001004', 'ly@stu.xtlg.edu.cn', '2024-09-02', '封禁');
INSERT INTO `reader` VALUES ('20240005', '陈宇', '学生', '大数据技术', '13800001005', 'cy@stu.xtlg.edu.cn', '2024-09-03', '正常');
INSERT INTO `reader` VALUES ('20240006', '周欣', '学生', '软件工程', '13800001006', 'zx@stu.xtlg.edu.cn', '2024-09-03', '正常');
INSERT INTO `reader` VALUES ('20240007', '吴泽', '学生', '数据科学', '13800001007', 'wz@stu.xtlg.edu.cn', '2024-09-04', '正常');
INSERT INTO `reader` VALUES ('20240008', '郑雪', '学生', '计算机科学', '13800001008', 'zxue@stu.xtlg.edu.cn', '2024-09-04', '正常');
INSERT INTO `reader` VALUES ('20240009', '孙嘉', '学生', '人工智能', '13800001009', 'sj@stu.xtlg.edu.cn', '2024-09-05', '正常');
INSERT INTO `reader` VALUES ('20240010', '马远', '学生', '大数据技术', '13800001010', 'my@stu.xtlg.edu.cn', '2024-09-05', '注销');
INSERT INTO `reader` VALUES ('20240011', '黄思琪', '学生', '软件工程', '13800001011', 'hsq@stu.xtlg.edu.cn', '2024-09-06', '正常');
INSERT INTO `reader` VALUES ('20240012', '朱俊', '学生', '数据科学', '13800001012', 'zj@stu.xtlg.edu.cn', '2024-09-06', '正常');
INSERT INTO `reader` VALUES ('20240013', '胡玲', '学生', '计算机科学', '13800001013', 'hl@stu.xtlg.edu.cn', '2024-09-07', '正常');
INSERT INTO `reader` VALUES ('20240014', '林航', '学生', '人工智能', '13800001014', 'lh@stu.xtlg.edu.cn', '2024-09-07', '正常');
INSERT INTO `reader` VALUES ('20240015', '谢婷', '学生', '大数据技术', '13800001015', 'xt@stu.xtlg.edu.cn', '2024-09-08', '正常');
INSERT INTO `reader` VALUES ('20240016', '罗威', '学生', '软件工程', '13800001016', 'lw@stu.xtlg.edu.cn', '2024-09-08', '正常');
INSERT INTO `reader` VALUES ('20240017', '江瑶', '学生', '数据科学', '13800001017', 'jy@stu.xtlg.edu.cn', '2024-09-09', '正常');
INSERT INTO `reader` VALUES ('20240018', '方浩宇', '学生', '计算机科学', '13800001018', 'fhy@stu.xtlg.edu.cn', '2024-09-09', '封禁');
INSERT INTO `reader` VALUES ('20240019', '温欣', '学生', '人工智能', '13800001019', 'wx@stu.xtlg.edu.cn', '2024-09-10', '正常');
INSERT INTO `reader` VALUES ('20240020', '曹杰', '学生', '大数据技术', '13800001020', 'cj@stu.xtlg.edu.cn', '2024-09-10', '正常');
INSERT INTO `reader` VALUES ('20240021', '许梦', '学生', '软件工程', '13800001021', 'xm@stu.xtlg.edu.cn', '2024-09-11', '正常');
INSERT INTO `reader` VALUES ('20240022', '彭涛', '学生', '数据科学', '13800001022', 'pt@stu.xtlg.edu.cn', '2024-09-11', '正常');
INSERT INTO `reader` VALUES ('20240023', '薛丽', '学生', '计算机科学', '13800001023', 'xl@stu.xtlg.edu.cn', '2024-09-12', '正常');
INSERT INTO `reader` VALUES ('20240024', '段明宇', '学生', '人工智能', '13800001024', 'dmy@stu.xtlg.edu.cn', '2024-09-12', '正常');
INSERT INTO `reader` VALUES ('20240025', '姚菲', '学生', '大数据技术', '13800001025', 'yf@stu.xtlg.edu.cn', '2024-09-13', '正常');
INSERT INTO `reader` VALUES ('20240026', '钟诚', '学生', '软件工程', '13800001026', 'zc@stu.xtlg.edu.cn', '2024-09-13', '正常');
INSERT INTO `reader` VALUES ('20240027', '苏晴', '学生', '数据科学', '13800001027', 'sq@stu.xtlg.edu.cn', '2024-09-14', '正常');
INSERT INTO `reader` VALUES ('20240028', '秦凯', '学生', '计算机科学', '13800001028', 'qk@stu.xtlg.edu.cn', '2024-09-14', '正常');
INSERT INTO `reader` VALUES ('20240029', '顾小雨', '学生', '人工智能', '13800001029', 'gxy@stu.xtlg.edu.cn', '2024-09-15', '正常');
INSERT INTO `reader` VALUES ('20240030', '孟阳', '学生', '大数据技术', '13800001030', 'myang@stu.xtlg.edu.cn', '2024-09-15', '正常');
INSERT INTO `reader` VALUES ('20240031', '施文', '学生', '软件工程', '13800001031', 'sw@stu.xtlg.edu.cn', '2024-09-16', '正常');
INSERT INTO `reader` VALUES ('20240032', '陶然', '学生', '数据科学', '13800001032', 'tr@stu.xtlg.edu.cn', '2024-09-16', '正常');
INSERT INTO `reader` VALUES ('20240033', '严佳', '学生', '计算机科学', '13800001033', 'yj@stu.xtlg.edu.cn', '2024-09-17', '正常');
INSERT INTO `reader` VALUES ('20240034', '贺斌', '学生', '人工智能', '13800001034', 'hb@stu.xtlg.edu.cn', '2024-09-17', '正常');
INSERT INTO `reader` VALUES ('20240035', '戴雪', '学生', '大数据技术', '13800001035', 'dx@stu.xtlg.edu.cn', '2024-09-18', '正常');
INSERT INTO `reader` VALUES ('20240036', '伍洲', '学生', '软件工程', '13800001036', 'wz1@stu.xtlg.edu.cn', '2024-09-18', '正常');
INSERT INTO `reader` VALUES ('20240037', '蓝星', '学生', '数据科学', '13800001037', 'lx@stu.xtlg.edu.cn', '2024-09-19', '正常');
INSERT INTO `reader` VALUES ('20240038', '纪伟', '学生', '计算机科学', '13800001038', 'jw@stu.xtlg.edu.cn', '2024-09-19', '正常');
INSERT INTO `reader` VALUES ('20240039', '单琪', '学生', '人工智能', '13800001039', 'sq1@stu.xtlg.edu.cn', '2024-09-20', '正常');
INSERT INTO `reader` VALUES ('20240040', '谷峰', '学生', '大数据技术', '13800001040', 'gf@stu.xtlg.edu.cn', '2024-09-20', '正常');
INSERT INTO `reader` VALUES ('20240041', '盛楠', '学生', '软件工程', '13800001041', 'sn@stu.xtlg.edu.cn', '2024-09-21', '正常');
INSERT INTO `reader` VALUES ('20240042', '樊华', '学生', '数据科学', '13800001042', 'fh@stu.xtlg.edu.cn', '2024-09-21', '正常');
INSERT INTO `reader` VALUES ('20240043', '焦阳', '学生', '计算机科学', '13800001043', 'jy@stu.xtlg.edu.cn', '2024-09-22', '正常');
INSERT INTO `reader` VALUES ('20240044', '鲍蕾', '学生', '人工智能', '13800001044', 'bl@stu.xtlg.edu.cn', '2024-09-22', '正常');
INSERT INTO `reader` VALUES ('20240045', '葛亮', '学生', '大数据技术', '13800001045', 'gl@stu.xtlg.edu.cn', '2024-09-23', '正常');
INSERT INTO `reader` VALUES ('20240046', '安欣', '学生', '软件工程', '13800001046', 'ax@stu.xtlg.edu.cn', '2024-09-23', '正常');
INSERT INTO `reader` VALUES ('20240047', '尤佳', '学生', '数据科学', '13800001047', 'youj@stu.xtlg.edu.cn', '2024-09-24', '正常');
INSERT INTO `reader` VALUES ('20240048', '温涛', '学生', '计算机科学', '13800001048', 'wt@stu.xtlg.edu.cn', '2024-09-24', '正常');
INSERT INTO `reader` VALUES ('20240049', '管琳', '学生', '人工智能', '13800001049', 'glin@stu.xtlg.edu.cn', '2024-09-25', '正常');
INSERT INTO `reader` VALUES ('20240050', '骆宾', '学生', '大数据技术', '13800001050', 'lb@stu.xtlg.edu.cn', '2024-09-25', '正常');
INSERT INTO `reader` VALUES ('T001', '王建国', '教工', NULL, '13900002001', 'wjg@xtlg.edu.cn', '2020-03-10', '正常');
INSERT INTO `reader` VALUES ('T002', '李华', '教工', NULL, '13900002002', 'lh@xtlg.edu.cn', '2020-04-12', '正常');
INSERT INTO `reader` VALUES ('T003', '张伟', '教工', NULL, '13900002003', 'zw@xtlg.edu.cn', '2020-05-08', '正常');
INSERT INTO `reader` VALUES ('T004', '刘敏', '教工', NULL, '13900002004', 'lm@xtlg.edu.cn', '2020-06-11', '正常');
INSERT INTO `reader` VALUES ('T005', '陈凯', '教工', NULL, '13900002005', 'ck@xtlg.edu.cn', '2020-07-02', '正常');
INSERT INTO `reader` VALUES ('T006', '杨芳', '教工', NULL, '13900002006', 'yf1@xtlg.edu.cn', '2020-08-15', '正常');
INSERT INTO `reader` VALUES ('T007', '赵宇', '教工', NULL, '13900002007', 'zy@xtlg.edu.cn', '2020-09-09', '正常');
INSERT INTO `reader` VALUES ('T008', '黄丽', '教工', NULL, '13900002008', 'hl1@xtlg.edu.cn', '2020-10-21', '正常');
INSERT INTO `reader` VALUES ('T009', '吴涛', '教工', NULL, '13900002009', 'wt1@xtlg.edu.cn', '2020-11-05', '正常');
INSERT INTO `reader` VALUES ('T010', '郑琪', '教工', NULL, '13900002010', 'zq@xtlg.edu.cn', '2020-12-03', '正常');

-- ----------------------------
-- Table structure for seat
-- ----------------------------
DROP TABLE IF EXISTS `seat`;
CREATE TABLE `seat`  (
  `sid` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '座位编号',
  `sfloor` tinyint NOT NULL COMMENT '楼层1-4',
  `sroom` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '自习室',
  `sstatus` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '空闲' COMMENT '座位状态',
  PRIMARY KEY (`sid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '自习座位表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of seat
-- ----------------------------
INSERT INTO `seat` VALUES ('A01-01', 1, 'A01', '空闲');
INSERT INTO `seat` VALUES ('A01-02', 1, 'A01', '空闲');
INSERT INTO `seat` VALUES ('A01-03', 1, 'A01', '占用');
INSERT INTO `seat` VALUES ('A01-04', 1, 'A01', '空闲');
INSERT INTO `seat` VALUES ('A01-05', 1, 'A01', '空闲');
INSERT INTO `seat` VALUES ('A01-06', 1, 'A01', '维修');
INSERT INTO `seat` VALUES ('A01-07', 1, 'A01', '空闲');
INSERT INTO `seat` VALUES ('A01-08', 1, 'A01', '占用');
INSERT INTO `seat` VALUES ('A01-09', 1, 'A01', '空闲');
INSERT INTO `seat` VALUES ('A01-10', 1, 'A01', '空闲');
INSERT INTO `seat` VALUES ('A01-11', 1, 'A01', '空闲');
INSERT INTO `seat` VALUES ('A01-12', 1, 'A01', '占用');
INSERT INTO `seat` VALUES ('A01-13', 1, 'A01', '空闲');
INSERT INTO `seat` VALUES ('A01-14', 1, 'A01', '空闲');
INSERT INTO `seat` VALUES ('A01-15', 1, 'A01', '维修');
INSERT INTO `seat` VALUES ('A01-16', 1, 'A01', '空闲');
INSERT INTO `seat` VALUES ('A01-17', 1, 'A01', '占用');
INSERT INTO `seat` VALUES ('A01-18', 1, 'A01', '空闲');
INSERT INTO `seat` VALUES ('A01-19', 1, 'A01', '空闲');
INSERT INTO `seat` VALUES ('A01-20', 1, 'A01', '空闲');
INSERT INTO `seat` VALUES ('A02-01', 1, 'A02', '空闲');
INSERT INTO `seat` VALUES ('A02-02', 1, 'A02', '占用');
INSERT INTO `seat` VALUES ('A02-03', 1, 'A02', '空闲');
INSERT INTO `seat` VALUES ('A02-04', 1, 'A02', '空闲');
INSERT INTO `seat` VALUES ('A02-05', 1, 'A02', '维修');
INSERT INTO `seat` VALUES ('A02-06', 1, 'A02', '空闲');
INSERT INTO `seat` VALUES ('A02-07', 1, 'A02', '占用');
INSERT INTO `seat` VALUES ('A02-08', 1, 'A02', '空闲');
INSERT INTO `seat` VALUES ('A02-09', 1, 'A02', '空闲');
INSERT INTO `seat` VALUES ('A02-10', 1, 'A02', '空闲');
INSERT INTO `seat` VALUES ('A02-11', 1, 'A02', '占用');
INSERT INTO `seat` VALUES ('A02-12', 1, 'A02', '空闲');
INSERT INTO `seat` VALUES ('A02-13', 1, 'A02', '空闲');
INSERT INTO `seat` VALUES ('A02-14', 1, 'A02', '维修');
INSERT INTO `seat` VALUES ('A02-15', 1, 'A02', '空闲');
INSERT INTO `seat` VALUES ('A02-16', 1, 'A02', '占用');
INSERT INTO `seat` VALUES ('A02-17', 1, 'A02', '空闲');
INSERT INTO `seat` VALUES ('A02-18', 1, 'A02', '空闲');
INSERT INTO `seat` VALUES ('A02-19', 1, 'A02', '空闲');
INSERT INTO `seat` VALUES ('A02-20', 1, 'A02', '占用');
INSERT INTO `seat` VALUES ('B01-01', 2, 'B01', '空闲');
INSERT INTO `seat` VALUES ('B01-02', 2, 'B01', '空闲');
INSERT INTO `seat` VALUES ('B01-03', 2, 'B01', '占用');
INSERT INTO `seat` VALUES ('B01-04', 2, 'B01', '空闲');
INSERT INTO `seat` VALUES ('B01-05', 2, 'B01', '空闲');
INSERT INTO `seat` VALUES ('B01-06', 2, 'B01', '空闲');
INSERT INTO `seat` VALUES ('B01-07', 2, 'B01', '维修');
INSERT INTO `seat` VALUES ('B01-08', 2, 'B01', '空闲');
INSERT INTO `seat` VALUES ('B01-09', 2, 'B01', '占用');
INSERT INTO `seat` VALUES ('B01-10', 2, 'B01', '空闲');
INSERT INTO `seat` VALUES ('B01-11', 2, 'B01', '空闲');
INSERT INTO `seat` VALUES ('B01-12', 2, 'B01', '空闲');
INSERT INTO `seat` VALUES ('B01-13', 2, 'B01', '占用');
INSERT INTO `seat` VALUES ('B01-14', 2, 'B01', '空闲');
INSERT INTO `seat` VALUES ('B01-15', 2, 'B01', '空闲');
INSERT INTO `seat` VALUES ('B01-16', 2, 'B01', '维修');
INSERT INTO `seat` VALUES ('B01-17', 2, 'B01', '空闲');
INSERT INTO `seat` VALUES ('B01-18', 2, 'B01', '占用');
INSERT INTO `seat` VALUES ('B01-19', 2, 'B01', '空闲');
INSERT INTO `seat` VALUES ('B01-20', 2, 'B01', '空闲');
INSERT INTO `seat` VALUES ('B02-01', 2, 'B02', '空闲');
INSERT INTO `seat` VALUES ('B02-02', 2, 'B02', '占用');
INSERT INTO `seat` VALUES ('B02-03', 2, 'B02', '空闲');
INSERT INTO `seat` VALUES ('B02-04', 2, 'B02', '空闲');
INSERT INTO `seat` VALUES ('B02-05', 2, 'B02', '空闲');
INSERT INTO `seat` VALUES ('B02-06', 2, 'B02', '维修');
INSERT INTO `seat` VALUES ('B02-07', 2, 'B02', '空闲');
INSERT INTO `seat` VALUES ('B02-08', 2, 'B02', '占用');
INSERT INTO `seat` VALUES ('B02-09', 2, 'B02', '空闲');
INSERT INTO `seat` VALUES ('B02-10', 2, 'B02', '空闲');
INSERT INTO `seat` VALUES ('B02-11', 2, 'B02', '空闲');
INSERT INTO `seat` VALUES ('B02-12', 2, 'B02', '占用');
INSERT INTO `seat` VALUES ('B02-13', 2, 'B02', '空闲');
INSERT INTO `seat` VALUES ('B02-14', 2, 'B02', '空闲');
INSERT INTO `seat` VALUES ('B02-15', 2, 'B02', '维修');
INSERT INTO `seat` VALUES ('B02-16', 2, 'B02', '空闲');
INSERT INTO `seat` VALUES ('B02-17', 2, 'B02', '占用');
INSERT INTO `seat` VALUES ('B02-18', 2, 'B02', '空闲');
INSERT INTO `seat` VALUES ('B02-19', 2, 'B02', '空闲');
INSERT INTO `seat` VALUES ('B02-20', 2, 'B02', '空闲');
INSERT INTO `seat` VALUES ('C01-01', 3, 'C01', '空闲');
INSERT INTO `seat` VALUES ('C01-02', 3, 'C01', '空闲');
INSERT INTO `seat` VALUES ('C01-03', 3, 'C01', '占用');
INSERT INTO `seat` VALUES ('C01-04', 3, 'C01', '空闲');
INSERT INTO `seat` VALUES ('C01-05', 3, 'C01', '维修');
INSERT INTO `seat` VALUES ('C01-06', 3, 'C01', '空闲');
INSERT INTO `seat` VALUES ('C01-07', 3, 'C01', '占用');
INSERT INTO `seat` VALUES ('C01-08', 3, 'C01', '空闲');
INSERT INTO `seat` VALUES ('C01-09', 3, 'C01', '空闲');
INSERT INTO `seat` VALUES ('C01-10', 3, 'C01', '空闲');
INSERT INTO `seat` VALUES ('C01-11', 3, 'C01', '占用');
INSERT INTO `seat` VALUES ('C01-12', 3, 'C01', '空闲');
INSERT INTO `seat` VALUES ('C01-13', 3, 'C01', '空闲');
INSERT INTO `seat` VALUES ('C01-14', 3, 'C01', '空闲');
INSERT INTO `seat` VALUES ('C01-15', 3, 'C01', '维修');
INSERT INTO `seat` VALUES ('C01-16', 3, 'C01', '占用');
INSERT INTO `seat` VALUES ('C01-17', 3, 'C01', '空闲');
INSERT INTO `seat` VALUES ('C01-18', 3, 'C01', '空闲');
INSERT INTO `seat` VALUES ('C01-19', 3, 'C01', '空闲');
INSERT INTO `seat` VALUES ('C01-20', 3, 'C01', '占用');
INSERT INTO `seat` VALUES ('C02-01', 3, 'C02', '空闲');
INSERT INTO `seat` VALUES ('C02-02', 3, 'C02', '空闲');
INSERT INTO `seat` VALUES ('C02-03', 3, 'C02', '占用');
INSERT INTO `seat` VALUES ('C02-04', 3, 'C02', '空闲');
INSERT INTO `seat` VALUES ('C02-05', 3, 'C02', '空闲');
INSERT INTO `seat` VALUES ('C02-06', 3, 'C02', '维修');
INSERT INTO `seat` VALUES ('C02-07', 3, 'C02', '空闲');
INSERT INTO `seat` VALUES ('C02-08', 3, 'C02', '占用');
INSERT INTO `seat` VALUES ('C02-09', 3, 'C02', '空闲');
INSERT INTO `seat` VALUES ('C02-10', 3, 'C02', '空闲');
INSERT INTO `seat` VALUES ('C02-11', 3, 'C02', '空闲');
INSERT INTO `seat` VALUES ('C02-12', 3, 'C02', '占用');
INSERT INTO `seat` VALUES ('C02-13', 3, 'C02', '空闲');
INSERT INTO `seat` VALUES ('C02-14', 3, 'C02', '空闲');
INSERT INTO `seat` VALUES ('C02-15', 3, 'C02', '维修');
INSERT INTO `seat` VALUES ('C02-16', 3, 'C02', '空闲');
INSERT INTO `seat` VALUES ('C02-17', 3, 'C02', '占用');
INSERT INTO `seat` VALUES ('C02-18', 3, 'C02', '空闲');
INSERT INTO `seat` VALUES ('C02-19', 3, 'C02', '空闲');
INSERT INTO `seat` VALUES ('C02-20', 3, 'C02', '空闲');
INSERT INTO `seat` VALUES ('D01-01', 4, 'D01', '空闲');
INSERT INTO `seat` VALUES ('D01-02', 4, 'D01', '占用');
INSERT INTO `seat` VALUES ('D01-03', 4, 'D01', '空闲');
INSERT INTO `seat` VALUES ('D01-04', 4, 'D01', '空闲');
INSERT INTO `seat` VALUES ('D01-05', 4, 'D01', '空闲');
INSERT INTO `seat` VALUES ('D01-06', 4, 'D01', '维修');
INSERT INTO `seat` VALUES ('D01-07', 4, 'D01', '空闲');
INSERT INTO `seat` VALUES ('D01-08', 4, 'D01', '占用');
INSERT INTO `seat` VALUES ('D01-09', 4, 'D01', '空闲');
INSERT INTO `seat` VALUES ('D01-10', 4, 'D01', '空闲');
INSERT INTO `seat` VALUES ('D01-11', 4, 'D01', '占用');
INSERT INTO `seat` VALUES ('D01-12', 4, 'D01', '空闲');
INSERT INTO `seat` VALUES ('D01-13', 4, 'D01', '空闲');
INSERT INTO `seat` VALUES ('D01-14', 4, 'D01', '空闲');
INSERT INTO `seat` VALUES ('D01-15', 4, 'D01', '维修');
INSERT INTO `seat` VALUES ('D01-16', 4, 'D01', '占用');
INSERT INTO `seat` VALUES ('D01-17', 4, 'D01', '空闲');
INSERT INTO `seat` VALUES ('D01-18', 4, 'D01', '空闲');
INSERT INTO `seat` VALUES ('D01-19', 4, 'D01', '空闲');
INSERT INTO `seat` VALUES ('D01-20', 4, 'D01', '占用');

-- ----------------------------
-- View structure for admin_system_info
-- ----------------------------
DROP VIEW IF EXISTS `admin_system_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `admin_system_info` AS select `r`.`rid` AS `rid`,`r`.`rname` AS `rname`,`r`.`rtype` AS `rtype`,`r`.`rmajor` AS `rmajor`,`r`.`rstatus` AS `rstatus`,`br`.`br_id` AS `br_id`,`br`.`br_type` AS `br_type`,`br`.`operate_time` AS `operate_time`,`br`.`deadline` AS `deadline`,`br`.`br_state` AS `br_state`,`br`.`over_days` AS `over_days`,`br`.`fine_money` AS `fine_money`,`b`.`bid` AS `bid`,`b`.`bname` AS `bname`,`b`.`bcategory` AS `bcategory`,`s`.`sid` AS `sid`,`r`.`rreg_date` AS `rreg_date` from (((`reader` `r` left join `borrow_reserve` `br` on((`r`.`rid` = `br`.`rid`))) left join `book` `b` on((`br`.`bid` = `b`.`bid`))) left join `seat` `s` on((`br`.`sid` = `s`.`sid`)));

-- ----------------------------
-- View structure for librarian_work_info
-- ----------------------------
DROP VIEW IF EXISTS `librarian_work_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `librarian_work_info` AS select `r_t`.`rid` AS `librarian_id`,`r_t`.`rname` AS `librarian_name`,`br`.`br_id` AS `br_id`,`r`.`rid` AS `reader_id`,`r`.`rname` AS `reader_name`,`br`.`br_type` AS `br_type`,`br`.`operate_time` AS `operate_time`,`br`.`br_state` AS `br_state`,`br`.`over_days` AS `over_days`,`br`.`fine_money` AS `fine_money`,`br`.`pay_state` AS `pay_state`,`b`.`bid` AS `bid`,`b`.`bname` AS `bname`,`b`.`bauthor` AS `bauthor`,`b`.`bcategory` AS `bcategory`,`br`.`sid` AS `seat_id`,(case when (`br`.`br_state` = '爽约') then '是' else '否' end) AS `is_break_contract` from (((`reader` `r_t` left join `borrow_reserve` `br` on(((`r_t`.`rid` = `br`.`rid`) and (cast(`br`.`operate_time` as date) = curdate())))) left join `reader` `r` on((`br`.`rid` = `r`.`rid`))) left join `book` `b` on((`br`.`bid` = `b`.`bid`))) where ((`r_t`.`rid` = 'T001') and (`r_t`.`rtype` = '教工'));

-- ----------------------------
-- View structure for reader_my_info
-- ----------------------------
DROP VIEW IF EXISTS `reader_my_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `reader_my_info` AS select `r`.`rid` AS `rid`,`r`.`rname` AS `rname`,`r`.`rtype` AS `rtype`,`r`.`rmajor` AS `rmajor`,`r`.`rstatus` AS `rstatus`,`br`.`br_id` AS `br_id`,`br`.`br_type` AS `br_type`,`br`.`operate_time` AS `operate_time`,`br`.`deadline` AS `deadline`,`br`.`real_end` AS `real_end`,`br`.`renew_num` AS `renew_num`,`br`.`br_state` AS `br_state`,`br`.`over_days` AS `over_days`,`br`.`fine_money` AS `fine_money`,`br`.`pay_state` AS `pay_state`,`b`.`bname` AS `book_name`,`br`.`sid` AS `seat_id` from ((`reader` `r` left join `borrow_reserve` `br` on((`r`.`rid` = `br`.`rid`))) left join `book` `b` on((`br`.`bid` = `b`.`bid`))) where (`r`.`rid` = '20240001');

SET FOREIGN_KEY_CHECKS = 1;
