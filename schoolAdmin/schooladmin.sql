/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50617
Source Host           : localhost:3306
Source Database       : schooladmin

Target Server Type    : MYSQL
Target Server Version : 50617
File Encoding         : 65001

Date: 2018-05-08 15:16:42
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for costitem
-- ----------------------------
DROP TABLE IF EXISTS `costitem`;
CREATE TABLE `costitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `num` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `modDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of costitem
-- ----------------------------

-- ----------------------------
-- Table structure for emailcode
-- ----------------------------
DROP TABLE IF EXISTS `emailcode`;
CREATE TABLE `emailcode` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(33) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `deadTime` longtext,
  `type` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of emailcode
-- ----------------------------
INSERT INTO `emailcode` VALUES ('92', 'qwe', '2771161998@qq.com', '3388', '1525321085287', null);
INSERT INTO `emailcode` VALUES ('93', 'qwe', '2771161998@qq.com', '9292', '1525323861107', null);
INSERT INTO `emailcode` VALUES ('94', 'qwe', '2771161998@qq.com', '3481', '1525324492375', '2');
INSERT INTO `emailcode` VALUES ('95', 'qwe', '2771161998@qq.com', '7023', '1525326189328', '2');
INSERT INTO `emailcode` VALUES ('96', '1232', '450273594@qq.com', '3852', '1525330592479', '1');
INSERT INTO `emailcode` VALUES ('97', 'qwe', '2771161998@qq.com', '3496', '1525339101437', '2');
INSERT INTO `emailcode` VALUES ('98', 'qqq', 'qq@qq.com', '9812', '1525339123717', '1');

-- ----------------------------
-- Table structure for examine
-- ----------------------------
DROP TABLE IF EXISTS `examine`;
CREATE TABLE `examine` (
  `id` int(11) NOT NULL,
  `reimbursemeId` int(11) DEFAULT NULL,
  `managerId` int(11) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `modDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` varchar(255) DEFAULT NULL,
  `segId` int(11) DEFAULT NULL,
  `desc` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of examine
-- ----------------------------

-- ----------------------------
-- Table structure for manager
-- ----------------------------
DROP TABLE IF EXISTS `manager`;
CREATE TABLE `manager` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `username` varchar(16) CHARACTER SET utf8mb4 NOT NULL DEFAULT '',
  `password` varchar(30) NOT NULL,
  `uname` varchar(20) DEFAULT NULL,
  `sex` varchar(5) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `type` int(10) NOT NULL DEFAULT '1' COMMENT '0 超级管理员',
  `roleId` int(11) DEFAULT NULL,
  `createdate` datetime NOT NULL,
  `modDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` varchar(10) NOT NULL DEFAULT '0',
  `email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_unque` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of manager
-- ----------------------------
INSERT INTO `manager` VALUES ('1', 'admin', '123', '斯蒂芬森的', '女', '23', '1', '1', '2014-12-25 08:38:12', '2018-05-04 11:02:34', '2', null);
INSERT INTO `manager` VALUES ('3', 'xs', '123', '撒旦法', '撒旦法', '23', '1', '3', '2016-01-18 14:37:14', '2018-05-03 17:20:58', '2', 'aa@qq.com');
INSERT INTO `manager` VALUES ('5', 'js', '123', null, null, null, '1', '2', '2016-01-18 14:39:58', '2018-04-27 16:40:06', '0', null);
INSERT INTO `manager` VALUES ('6', 'sh', '123', null, null, null, '1', '4', '2016-01-18 16:21:04', '2018-04-27 16:51:36', '0', null);
INSERT INTO `manager` VALUES ('10', 'gl', '123', null, null, null, '1', '5', '2016-03-26 09:42:44', '2018-05-04 11:34:32', '0', null);
INSERT INTO `manager` VALUES ('11', 'adminmjh120', 'mjh277116', null, null, null, '0', '2', '2016-03-26 13:32:38', '2016-06-04 11:11:50', '0', null);
INSERT INTO `manager` VALUES ('12', 'ad123', '1233', null, null, null, '1', '2', '2016-06-03 16:55:21', '2016-06-04 11:07:10', '0', null);
INSERT INTO `manager` VALUES ('13', '123', '32', null, null, null, '1', '1', '2016-06-04 09:19:43', '2016-06-04 09:20:02', '0', null);
INSERT INTO `manager` VALUES ('14', 'tupian', '123', null, null, null, '1', '4', '2016-07-20 10:22:43', '2016-07-20 10:22:43', '0', null);
INSERT INTO `manager` VALUES ('16', 'qwe', '1234', null, null, null, '3', '3', '2018-05-03 12:34:55', '2018-05-07 14:53:11', '2', '2771161998@qq.com');

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `parentId` int(11) DEFAULT '0',
  `url` varchar(255) DEFAULT NULL,
  `status` int(1) DEFAULT '0',
  `createDate` datetime DEFAULT NULL,
  `modDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES ('1', '系统管理', '0', null, '0', '2016-05-30 13:59:40', '2016-05-31 09:59:21');
INSERT INTO `menu` VALUES ('2', '菜单管理', '1', 'view/menu/menu_list.jsp', '0', '2016-05-30 13:59:43', '2016-06-01 14:45:18');
INSERT INTO `menu` VALUES ('13', '角色权限', '1', 'view/sys/power_list.jsp', '0', '2016-06-01 14:46:14', '2016-06-02 15:13:09');
INSERT INTO `menu` VALUES ('14', '帐号管理', '1', 'view/sys/manager_list.jsp', '0', '2016-06-01 14:46:49', '2016-06-03 14:02:52');
INSERT INTO `menu` VALUES ('40', '用户端', '0', null, '0', '2018-04-27 15:34:28', '2018-04-27 16:12:28');
INSERT INTO `menu` VALUES ('41', '个人资料', '40', 'view/userclient/person.jsp', '0', '2018-04-27 15:58:54', '2018-05-02 10:05:04');
INSERT INTO `menu` VALUES ('42', '我的报销', '40', 'view/userclient/my_reimburseme_list.jsp', '0', '2018-04-27 16:02:03', '2018-05-07 13:57:39');
INSERT INTO `menu` VALUES ('44', '公告端', '0', null, '0', '2018-04-27 16:12:20', '2018-04-27 16:12:49');
INSERT INTO `menu` VALUES ('45', '财务端', '0', null, '0', '2018-04-27 16:12:58', '2018-04-27 16:12:58');
INSERT INTO `menu` VALUES ('46', '管理端', '0', null, '0', '2018-04-27 16:13:04', '2018-04-27 16:13:04');
INSERT INTO `menu` VALUES ('47', '新闻管理', '44', 'view/news/news_list.jsp', '0', '2018-04-27 16:13:37', '2018-04-27 17:15:12');
INSERT INTO `menu` VALUES ('48', '报销管理', '45', 'view/financeclient/reimburseme_list.jsp', '0', '2018-04-27 16:14:00', '2018-04-30 17:18:59');
INSERT INTO `menu` VALUES ('49', '报销统计', '46', 'managerclient/tj', '0', '2018-04-27 16:15:09', '2018-05-08 17:45:05');
INSERT INTO `menu` VALUES ('50', '注册审批', '46', 'view/managerclient/manager_list.jsp', '0', '2018-04-27 16:21:58', '2018-04-30 19:29:17');
INSERT INTO `menu` VALUES ('51', '报销设置', '46', 'managerclient/toRebSet', '0', '2018-04-27 16:22:26', '2018-05-04 17:23:47');

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL,
  `content` varchar(2550) DEFAULT NULL,
  `clicknum` int(11) DEFAULT '0',
  `createDate` datetime DEFAULT NULL,
  `status` int(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of news
-- ----------------------------
INSERT INTO `news` VALUES ('1', '公告', 'sdfdsfds', 'admin', '<p>地方vd</p>', '6', '2018-05-04 10:20:36', '0');
INSERT INTO `news` VALUES ('5', '事件', '速度三顿饭都是dfg', 'admin', '<p>dfcdfdgdfgsdf&nbsp;</p>', '4', '2018-05-04 10:20:42', '0');
INSERT INTO `news` VALUES ('6', '通知', '人事处及各二级学院领导根据黄淮学院参访学习活动', 'admin', '<p>&lt;p&gt;6月6日下午，在学院会议室我院召开了&lt;em class=&quot;blue&quot;&gt;黄淮学院&lt;/em&gt;参访活动暨推进转型工作研讨会。会议由副院长汪阳主持，院长助理董世平，教务处、实验实训中心、发展规划处、人事处、就业与创业办公室及各二级学院领导参加了研讨会。</p><p>&lt;/p&gt;</p><p>&lt;p&gt;会议结合黄淮学院参访活动、第三届产教融合发展战略国际论坛，对我院的转型工作进行了研究探讨。会上发展规划处处长赵清涛汇报了我院转型试点一年来所做的工作和成绩、黄淮学院参访活动，机电信息学院陈雪梅副院长通报了第三届产教融合发展战略国际论坛春季会议的议题及精神。 &lt;/p&gt;</p><p>&lt;img src=&quot;3.jpg&quot; width=&quot;500&quot; height=&quot;300&quot; align=&quot;middle&quot;/&gt;</p><p>&lt;p&gt;</p><p>&nbsp;教务处、实验实训中心、人事处及各二级学院领导根据黄淮学院参访学习活动，从应用型转型认识、单位目前现状、存在不足和未来规划四个方面进行了分别发言，就人才培养方案、双师型教师队伍、实习实训、课程改革毕业设计、第二课堂、实验室建设、校企合作等应用型转型工作推进的关键点进行了有益的研讨。&nbsp;</p><p>&lt;/p&gt;</p><p>&lt;p&gt;最后，汪阳副院长做了总结发言。他表示，各单位部门要遵循教育规律，始终以学生为本，大胆设计，多调研，多创新，在人才培养模式改革、课程质量监控、创新平台建设、师资队伍的引进培养、校企协同育人、学生思想教育等方面扎实工作，在维持好正常的教学活动的前提下，积极推动学院的应用型转型工作。 &lt;/p&gt;</p><p><br/></p>', '4', '2018-05-02 17:03:27', '0');
INSERT INTO `news` VALUES ('7', null, null, 'admin', null, '0', '2018-05-02 17:14:26', '0');

-- ----------------------------
-- Table structure for power
-- ----------------------------
DROP TABLE IF EXISTS `power`;
CREATE TABLE `power` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menuId` int(11) DEFAULT NULL,
  `roleId` int(11) DEFAULT NULL,
  `status` int(1) DEFAULT '0',
  `createDate` datetime DEFAULT NULL,
  `modDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=285 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of power
-- ----------------------------
INSERT INTO `power` VALUES ('242', '1', '1', '0', '2018-04-27 16:28:17', '2018-04-27 16:28:17');
INSERT INTO `power` VALUES ('243', '2', '1', '0', '2018-04-27 16:28:17', '2018-04-27 16:28:18');
INSERT INTO `power` VALUES ('244', '13', '1', '0', '2018-04-27 16:28:17', '2018-04-27 16:28:18');
INSERT INTO `power` VALUES ('245', '14', '1', '0', '2018-04-27 16:28:17', '2018-04-27 16:28:18');
INSERT INTO `power` VALUES ('246', '40', '1', '0', '2018-04-27 16:28:17', '2018-04-27 16:28:18');
INSERT INTO `power` VALUES ('247', '41', '1', '0', '2018-04-27 16:28:17', '2018-04-27 16:28:18');
INSERT INTO `power` VALUES ('248', '42', '1', '0', '2018-04-27 16:28:17', '2018-04-27 16:28:18');
INSERT INTO `power` VALUES ('249', '44', '1', '0', '2018-04-27 16:28:17', '2018-04-27 16:28:18');
INSERT INTO `power` VALUES ('250', '47', '1', '0', '2018-04-27 16:28:17', '2018-04-27 16:28:18');
INSERT INTO `power` VALUES ('251', '45', '1', '0', '2018-04-27 16:28:17', '2018-04-27 16:28:18');
INSERT INTO `power` VALUES ('252', '48', '1', '0', '2018-04-27 16:28:17', '2018-04-27 16:28:18');
INSERT INTO `power` VALUES ('253', '46', '1', '0', '2018-04-27 16:28:17', '2018-04-27 16:28:18');
INSERT INTO `power` VALUES ('254', '49', '1', '0', '2018-04-27 16:28:17', '2018-04-27 16:28:18');
INSERT INTO `power` VALUES ('255', '50', '1', '0', '2018-04-27 16:28:17', '2018-04-27 16:28:18');
INSERT INTO `power` VALUES ('256', '51', '1', '0', '2018-04-27 16:28:17', '2018-04-27 16:28:18');
INSERT INTO `power` VALUES ('257', '52', '1', '0', '2018-04-27 16:28:17', '2018-04-27 16:28:18');
INSERT INTO `power` VALUES ('258', '40', '2', '0', '2018-04-27 16:28:33', '2018-04-27 16:28:33');
INSERT INTO `power` VALUES ('259', '41', '2', '0', '2018-04-27 16:28:33', '2018-04-27 16:28:33');
INSERT INTO `power` VALUES ('260', '42', '2', '0', '2018-04-27 16:28:33', '2018-04-27 16:28:33');
INSERT INTO `power` VALUES ('261', '44', '2', '0', '2018-04-27 16:28:33', '2018-04-27 16:28:33');
INSERT INTO `power` VALUES ('262', '47', '2', '0', '2018-04-27 16:28:33', '2018-04-27 16:28:33');
INSERT INTO `power` VALUES ('263', '40', '5', '0', '2018-04-27 16:29:13', '2018-04-27 16:29:13');
INSERT INTO `power` VALUES ('264', '41', '5', '0', '2018-04-27 16:29:13', '2018-04-27 16:29:13');
INSERT INTO `power` VALUES ('265', '44', '5', '0', '2018-04-27 16:29:13', '2018-04-27 16:29:13');
INSERT INTO `power` VALUES ('266', '47', '5', '0', '2018-04-27 16:29:13', '2018-04-27 16:29:13');
INSERT INTO `power` VALUES ('267', '45', '5', '0', '2018-04-27 16:29:13', '2018-04-27 16:29:13');
INSERT INTO `power` VALUES ('268', '48', '5', '0', '2018-04-27 16:29:13', '2018-04-27 16:29:13');
INSERT INTO `power` VALUES ('269', '46', '5', '0', '2018-04-27 16:29:13', '2018-04-27 16:29:13');
INSERT INTO `power` VALUES ('270', '49', '5', '0', '2018-04-27 16:29:13', '2018-04-27 16:29:13');
INSERT INTO `power` VALUES ('271', '50', '5', '0', '2018-04-27 16:29:13', '2018-04-27 16:29:13');
INSERT INTO `power` VALUES ('272', '51', '5', '0', '2018-04-27 16:29:13', '2018-04-27 16:29:13');
INSERT INTO `power` VALUES ('273', '52', '5', '0', '2018-04-27 16:29:13', '2018-04-27 16:29:13');
INSERT INTO `power` VALUES ('274', '40', '4', '0', '2018-04-27 16:29:31', '2018-04-27 16:29:31');
INSERT INTO `power` VALUES ('275', '41', '4', '0', '2018-04-27 16:29:31', '2018-04-27 16:29:31');
INSERT INTO `power` VALUES ('276', '44', '4', '0', '2018-04-27 16:29:31', '2018-04-27 16:29:31');
INSERT INTO `power` VALUES ('277', '47', '4', '0', '2018-04-27 16:29:31', '2018-04-27 16:29:31');
INSERT INTO `power` VALUES ('278', '45', '4', '0', '2018-04-27 16:29:31', '2018-04-27 16:29:31');
INSERT INTO `power` VALUES ('279', '48', '4', '0', '2018-04-27 16:29:31', '2018-04-27 16:29:31');
INSERT INTO `power` VALUES ('280', '40', '3', '0', '2018-04-27 16:29:41', '2018-04-27 16:29:41');
INSERT INTO `power` VALUES ('281', '41', '3', '0', '2018-04-27 16:29:41', '2018-04-27 16:29:41');
INSERT INTO `power` VALUES ('282', '42', '3', '0', '2018-04-27 16:29:41', '2018-04-27 16:29:41');
INSERT INTO `power` VALUES ('283', '44', '3', '0', '2018-04-27 16:29:41', '2018-04-27 16:29:41');
INSERT INTO `power` VALUES ('284', '47', '3', '0', '2018-04-27 16:29:41', '2018-04-27 16:29:41');

-- ----------------------------
-- Table structure for reimburseme
-- ----------------------------
DROP TABLE IF EXISTS `reimburseme`;
CREATE TABLE `reimburseme` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `openDate` varchar(255) DEFAULT NULL,
  `managerId` int(11) DEFAULT NULL,
  `money` float(255,0) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `modDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` varchar(255) DEFAULT NULL,
  `authFile` varchar(255) DEFAULT NULL,
  `desc` varchar(255) DEFAULT NULL,
  `pday` int(11) DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of reimburseme
-- ----------------------------
INSERT INTO `reimburseme` VALUES ('7', '周一,窗口3', '1', '333', '2018-05-07 17:21:49', '2018-05-07 17:21:49', '2', 'http://localhost:8080/schoolAdmin/upload/5aefc5da7c427ac4429e396d.png', '车费', '0', '山东肥城');
INSERT INTO `reimburseme` VALUES ('8', '周二,窗口1', '1', '123', '2018-05-08 11:31:01', '2018-05-08 11:31:01', '1', 'http://localhost:8080/schoolAdmin/upload/5af172e7cedd24de5b18df19.png', '23', '0', '');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  `describe` varchar(255) DEFAULT NULL,
  `status` int(1) DEFAULT '0',
  `createDate` datetime DEFAULT NULL,
  `modDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', '超级管理员', null, '0', '2018-04-24 14:50:48', '2018-04-27 15:56:58');
INSERT INTO `role` VALUES ('2', '教师', null, '0', '2018-04-25 14:51:29', '2018-04-27 15:57:04');
INSERT INTO `role` VALUES ('3', '学生', null, '0', '2018-04-26 15:55:19', '2018-04-27 15:57:12');
INSERT INTO `role` VALUES ('4', '财务审核人员', '', '0', '2018-04-27 10:15:37', '2018-04-27 15:55:42');
INSERT INTO `role` VALUES ('5', '财务管理人员', null, '0', '2018-04-27 15:55:23', '2018-04-27 15:55:24');

-- ----------------------------
-- Table structure for seg
-- ----------------------------
DROP TABLE IF EXISTS `seg`;
CREATE TABLE `seg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `segDay` varchar(255) DEFAULT NULL,
  `startTime` varchar(10) DEFAULT NULL,
  `endTime` varchar(10) DEFAULT NULL,
  `num` varchar(11) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `segDayZh` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=266 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of seg
-- ----------------------------
INSERT INTO `seg` VALUES ('253', '1', '4:00', '6:00', '2', '2018-05-04 18:18:23', '周一');
INSERT INTO `seg` VALUES ('254', '1', '4:00', '6:00', '3', '2018-05-04 18:18:23', '周一');
INSERT INTO `seg` VALUES ('255', '2', '5:00', '8:00', '1', '2018-05-04 18:18:23', '周二');
INSERT INTO `seg` VALUES ('256', '2', '5:00', '8:00', '2', '2018-05-04 18:18:23', '周二');
INSERT INTO `seg` VALUES ('257', '3', '3:00', '5:00', '1', '2018-05-04 18:18:23', '周三');
INSERT INTO `seg` VALUES ('258', '3', '3:00', '5:00', '3', '2018-05-04 18:18:23', '周三');
INSERT INTO `seg` VALUES ('259', '4', '4:00', '8:00', '1', '2018-05-04 18:18:23', '周四');
INSERT INTO `seg` VALUES ('260', '4', '4:00', '8:00', '2', '2018-05-04 18:18:23', '周四');
INSERT INTO `seg` VALUES ('261', '4', '4:00', '8:00', '4', '2018-05-04 18:18:24', '周四');
INSERT INTO `seg` VALUES ('262', '5', '2:00', '4:00', '1', '2018-05-04 18:18:24', '周五');
INSERT INTO `seg` VALUES ('263', '5', '2:00', '4:00', '2', '2018-05-04 18:18:24', '周五');
INSERT INTO `seg` VALUES ('264', '5', '2:00', '4:00', '3', '2018-05-04 18:18:24', '周五');
INSERT INTO `seg` VALUES ('265', '5', '2:00', '4:00', '4', '2018-05-04 18:18:24', '周五');
