/*
 Navicat Premium Data Transfer

 Source Server         : lov
 Source Server Type    : MySQL
 Source Server Version : 100110
 Source Host           : localhost:3306
 Source Schema         : schoolAdmin

 Target Server Type    : MySQL
 Target Server Version : 100110
 File Encoding         : 65001

 Date: 02/05/2018 00:12:51
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

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
-- Table structure for emailcode
-- ----------------------------
DROP TABLE IF EXISTS `emailcode`;
CREATE TABLE `emailcode` (
  `id` int(11) NOT NULL,
  `managerId` int(11) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `deadTime` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `uable` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of manager
-- ----------------------------
BEGIN;
INSERT INTO `manager` VALUES (1, 'admin', '123', NULL, NULL, NULL, 1, 1, '2014-12-25 08:38:12', '2016-06-04 15:56:28', '0', NULL);
INSERT INTO `manager` VALUES (3, 'xs', '123', NULL, NULL, NULL, 1, 3, '2016-01-18 14:37:14', '2018-04-27 16:40:05', '0', NULL);
INSERT INTO `manager` VALUES (5, 'js', '123', NULL, NULL, NULL, 1, 2, '2016-01-18 14:39:58', '2018-04-27 16:40:06', '0', NULL);
INSERT INTO `manager` VALUES (6, 'sh', '123', NULL, NULL, NULL, 1, 4, '2016-01-18 16:21:04', '2018-04-27 16:51:36', '0', NULL);
INSERT INTO `manager` VALUES (10, 'admin01', 'admin123456', NULL, NULL, NULL, 1, 2, '2016-03-26 09:42:44', '2016-06-04 11:04:22', '0', NULL);
INSERT INTO `manager` VALUES (11, 'adminmjh120', 'mjh277116', NULL, NULL, NULL, 0, 2, '2016-03-26 13:32:38', '2016-06-04 11:11:50', '0', NULL);
INSERT INTO `manager` VALUES (12, 'ad123', '1233', NULL, NULL, NULL, 1, 2, '2016-06-03 16:55:21', '2016-06-04 11:07:10', '0', NULL);
INSERT INTO `manager` VALUES (13, '123', '32', NULL, NULL, NULL, 1, 1, '2016-06-04 09:19:43', '2016-06-04 09:20:02', '0', NULL);
INSERT INTO `manager` VALUES (14, 'tupian', '123', NULL, NULL, NULL, 1, 4, '2016-07-20 10:22:43', '2016-07-20 10:22:43', '0', NULL);
COMMIT;

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
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of menu
-- ----------------------------
BEGIN;
INSERT INTO `menu` VALUES (1, '系统管理', 0, NULL, 0, '2016-05-30 13:59:40', '2016-05-31 09:59:21');
INSERT INTO `menu` VALUES (2, '菜单管理', 1, 'view/menu/menu_list.jsp', 0, '2016-05-30 13:59:43', '2016-06-01 14:45:18');
INSERT INTO `menu` VALUES (13, '角色权限', 1, 'view/sys/power_list.jsp', 0, '2016-06-01 14:46:14', '2016-06-02 15:13:09');
INSERT INTO `menu` VALUES (14, '帐号管理', 1, 'view/sys/manager_list.jsp', 0, '2016-06-01 14:46:49', '2016-06-03 14:02:52');
INSERT INTO `menu` VALUES (40, '用户端', 0, NULL, 0, '2018-04-27 15:34:28', '2018-04-27 16:12:28');
INSERT INTO `menu` VALUES (41, '个人资料', 40, '1', 0, '2018-04-27 15:58:54', '2018-04-27 15:58:54');
INSERT INTO `menu` VALUES (42, '我的报销', 40, 'view/userclient/my_reimburseme_list.jsp', 0, '2018-04-27 16:02:03', '2018-04-30 17:09:37');
INSERT INTO `menu` VALUES (44, '公告端', 0, NULL, 0, '2018-04-27 16:12:20', '2018-04-27 16:12:49');
INSERT INTO `menu` VALUES (45, '财务端', 0, NULL, 0, '2018-04-27 16:12:58', '2018-04-27 16:12:58');
INSERT INTO `menu` VALUES (46, '管理端', 0, NULL, 0, '2018-04-27 16:13:04', '2018-04-27 16:13:04');
INSERT INTO `menu` VALUES (47, '新闻管理', 44, 'view/news/news_list.jsp', 0, '2018-04-27 16:13:37', '2018-04-27 17:15:12');
INSERT INTO `menu` VALUES (48, '报销管理', 45, 'view/financeclient/reimburseme_list.jsp', 0, '2018-04-27 16:14:00', '2018-04-30 17:18:59');
INSERT INTO `menu` VALUES (49, '报销统计', 46, '1', 0, '2018-04-27 16:15:09', '2018-04-27 16:15:09');
INSERT INTO `menu` VALUES (50, '注册审批', 46, 'view/managerclient/manager_list.jsp', 0, '2018-04-27 16:21:58', '2018-04-30 19:29:17');
INSERT INTO `menu` VALUES (51, '报销设置', 46, 'view/managerclient/reimburseme_seting.jsp', 0, '2018-04-27 16:22:26', '2018-04-30 20:04:34');
COMMIT;

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news` (
  `id` int(11) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `clicknum` int(11) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `status` int(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of news
-- ----------------------------
BEGIN;
INSERT INTO `news` VALUES (0, '公告', 'sdfdsfds', '司法所地方', '斯蒂芬斯蒂芬斯蒂芬斯蒂芬森', 2, '2018-04-27 17:11:21', 0);
COMMIT;

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
BEGIN;
INSERT INTO `power` VALUES (242, 1, 1, 0, '2018-04-27 16:28:17', '2018-04-27 16:28:17');
INSERT INTO `power` VALUES (243, 2, 1, 0, '2018-04-27 16:28:17', '2018-04-27 16:28:18');
INSERT INTO `power` VALUES (244, 13, 1, 0, '2018-04-27 16:28:17', '2018-04-27 16:28:18');
INSERT INTO `power` VALUES (245, 14, 1, 0, '2018-04-27 16:28:17', '2018-04-27 16:28:18');
INSERT INTO `power` VALUES (246, 40, 1, 0, '2018-04-27 16:28:17', '2018-04-27 16:28:18');
INSERT INTO `power` VALUES (247, 41, 1, 0, '2018-04-27 16:28:17', '2018-04-27 16:28:18');
INSERT INTO `power` VALUES (248, 42, 1, 0, '2018-04-27 16:28:17', '2018-04-27 16:28:18');
INSERT INTO `power` VALUES (249, 44, 1, 0, '2018-04-27 16:28:17', '2018-04-27 16:28:18');
INSERT INTO `power` VALUES (250, 47, 1, 0, '2018-04-27 16:28:17', '2018-04-27 16:28:18');
INSERT INTO `power` VALUES (251, 45, 1, 0, '2018-04-27 16:28:17', '2018-04-27 16:28:18');
INSERT INTO `power` VALUES (252, 48, 1, 0, '2018-04-27 16:28:17', '2018-04-27 16:28:18');
INSERT INTO `power` VALUES (253, 46, 1, 0, '2018-04-27 16:28:17', '2018-04-27 16:28:18');
INSERT INTO `power` VALUES (254, 49, 1, 0, '2018-04-27 16:28:17', '2018-04-27 16:28:18');
INSERT INTO `power` VALUES (255, 50, 1, 0, '2018-04-27 16:28:17', '2018-04-27 16:28:18');
INSERT INTO `power` VALUES (256, 51, 1, 0, '2018-04-27 16:28:17', '2018-04-27 16:28:18');
INSERT INTO `power` VALUES (257, 52, 1, 0, '2018-04-27 16:28:17', '2018-04-27 16:28:18');
INSERT INTO `power` VALUES (258, 40, 2, 0, '2018-04-27 16:28:33', '2018-04-27 16:28:33');
INSERT INTO `power` VALUES (259, 41, 2, 0, '2018-04-27 16:28:33', '2018-04-27 16:28:33');
INSERT INTO `power` VALUES (260, 42, 2, 0, '2018-04-27 16:28:33', '2018-04-27 16:28:33');
INSERT INTO `power` VALUES (261, 44, 2, 0, '2018-04-27 16:28:33', '2018-04-27 16:28:33');
INSERT INTO `power` VALUES (262, 47, 2, 0, '2018-04-27 16:28:33', '2018-04-27 16:28:33');
INSERT INTO `power` VALUES (263, 40, 5, 0, '2018-04-27 16:29:13', '2018-04-27 16:29:13');
INSERT INTO `power` VALUES (264, 41, 5, 0, '2018-04-27 16:29:13', '2018-04-27 16:29:13');
INSERT INTO `power` VALUES (265, 44, 5, 0, '2018-04-27 16:29:13', '2018-04-27 16:29:13');
INSERT INTO `power` VALUES (266, 47, 5, 0, '2018-04-27 16:29:13', '2018-04-27 16:29:13');
INSERT INTO `power` VALUES (267, 45, 5, 0, '2018-04-27 16:29:13', '2018-04-27 16:29:13');
INSERT INTO `power` VALUES (268, 48, 5, 0, '2018-04-27 16:29:13', '2018-04-27 16:29:13');
INSERT INTO `power` VALUES (269, 46, 5, 0, '2018-04-27 16:29:13', '2018-04-27 16:29:13');
INSERT INTO `power` VALUES (270, 49, 5, 0, '2018-04-27 16:29:13', '2018-04-27 16:29:13');
INSERT INTO `power` VALUES (271, 50, 5, 0, '2018-04-27 16:29:13', '2018-04-27 16:29:13');
INSERT INTO `power` VALUES (272, 51, 5, 0, '2018-04-27 16:29:13', '2018-04-27 16:29:13');
INSERT INTO `power` VALUES (273, 52, 5, 0, '2018-04-27 16:29:13', '2018-04-27 16:29:13');
INSERT INTO `power` VALUES (274, 40, 4, 0, '2018-04-27 16:29:31', '2018-04-27 16:29:31');
INSERT INTO `power` VALUES (275, 41, 4, 0, '2018-04-27 16:29:31', '2018-04-27 16:29:31');
INSERT INTO `power` VALUES (276, 44, 4, 0, '2018-04-27 16:29:31', '2018-04-27 16:29:31');
INSERT INTO `power` VALUES (277, 47, 4, 0, '2018-04-27 16:29:31', '2018-04-27 16:29:31');
INSERT INTO `power` VALUES (278, 45, 4, 0, '2018-04-27 16:29:31', '2018-04-27 16:29:31');
INSERT INTO `power` VALUES (279, 48, 4, 0, '2018-04-27 16:29:31', '2018-04-27 16:29:31');
INSERT INTO `power` VALUES (280, 40, 3, 0, '2018-04-27 16:29:41', '2018-04-27 16:29:41');
INSERT INTO `power` VALUES (281, 41, 3, 0, '2018-04-27 16:29:41', '2018-04-27 16:29:41');
INSERT INTO `power` VALUES (282, 42, 3, 0, '2018-04-27 16:29:41', '2018-04-27 16:29:41');
INSERT INTO `power` VALUES (283, 44, 3, 0, '2018-04-27 16:29:41', '2018-04-27 16:29:41');
INSERT INTO `power` VALUES (284, 47, 3, 0, '2018-04-27 16:29:41', '2018-04-27 16:29:41');
COMMIT;

-- ----------------------------
-- Table structure for reimburseme
-- ----------------------------
DROP TABLE IF EXISTS `reimburseme`;
CREATE TABLE `reimburseme` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `openDate` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `managerId` int(11) DEFAULT NULL,
  `money` float(255,0) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `modDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` varchar(255) DEFAULT NULL,
  `authFile` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
BEGIN;
INSERT INTO `role` VALUES (1, '超级管理员', NULL, 0, '2018-04-24 14:50:48', '2018-04-27 15:56:58');
INSERT INTO `role` VALUES (2, '教师', NULL, 0, '2018-04-25 14:51:29', '2018-04-27 15:57:04');
INSERT INTO `role` VALUES (3, '学生', NULL, 0, '2018-04-26 15:55:19', '2018-04-27 15:57:12');
INSERT INTO `role` VALUES (4, '财务审核人员', '', 0, '2018-04-27 10:15:37', '2018-04-27 15:55:42');
INSERT INTO `role` VALUES (5, '财务管理人员', NULL, 0, '2018-04-27 15:55:23', '2018-04-27 15:55:24');
COMMIT;

-- ----------------------------
-- Table structure for seg
-- ----------------------------
DROP TABLE IF EXISTS `seg`;
CREATE TABLE `seg` (
  `id` int(11) NOT NULL,
  `segDay` varchar(255) DEFAULT NULL,
  `startTime` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `endTime` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `num` int(11) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

SET FOREIGN_KEY_CHECKS = 1;
