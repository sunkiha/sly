/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50619
Source Host           : localhost:3306
Source Database       : mybatistest

Target Server Type    : MYSQL
Target Server Version : 50619
File Encoding         : 65001

Date: 2014-07-15 15:13:23
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` char(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of test
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'jiahao');
INSERT INTO `user` VALUES ('2', 'jiahong');
INSERT INTO `user` VALUES ('3', 'xiaochang');
