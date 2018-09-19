/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50520
Source Host           : localhost:3306
Source Database       : sunphp

Target Server Type    : MYSQL
Target Server Version : 50520
File Encoding         : 65001

Date: 2014-09-18 15:12:21
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for god
-- ----------------------------
DROP TABLE IF EXISTS `god`;
CREATE TABLE `god` (
  `id` varchar(32) NOT NULL,
  `username` varchar(30) DEFAULT NULL,
  `password` varchar(30) DEFAULT NULL,
  `head` varchar(200) DEFAULT NULL,
  `sex` int(2) DEFAULT NULL,
  `email` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of god
-- ----------------------------
INSERT INTO `god` VALUES ('a', 'sd', 'ad', null, '1', 'sdf');
INSERT INTO `god` VALUES ('sd', null, null, null, null, '');

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `id` varchar(32) NOT NULL,
  `godId` varchar(32) DEFAULT NULL,
  `godName` varchar(30) DEFAULT NULL,
  `head` varchar(200) DEFAULT NULL,
  `content` varchar(2000) DEFAULT NULL,
  `photo` varchar(2000) DEFAULT NULL,
  `level` int(11) DEFAULT '0',
  `createdate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES ('0040f0eb277b4f6da17ecaa08ce4db88', 'wqerqwer', 'qwerq', 'head.jpg', '70温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('00e6d55eb7644736a61fc096f474b847', 'wqerqwer', 'qwerq', 'head.jpg', '95温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('020a4fb580d544d4925d25bba01cbb44', 'wqerqwer', 'qwerq', 'head.jpg', '154温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('039f6c3ceca849528021858c4367f9e6', 'wqerqwer', 'qwerq', 'head.jpg', '46温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('053b0b36b9754046bf65145f2ef5fc30', 'wqerqwer', 'qwerq', 'head.jpg', '1温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('07d019c398c04768ac05c32ec451be10', 'wqerqwer', 'qwerq', 'head.jpg', '160温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('0912a7072ac248b0a8be0db3e52fe29d', 'wqerqwer', 'qwerq', 'head.jpg', '87温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('0acddca6c17849eda57ee30591a1f393', 'wqerqwer', 'qwerq', 'head.jpg', '34温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('0b20165d7d5644f28a511348e47ec5ad', 'wqerqwer', 'qwerq', 'head.jpg', '91温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('0d5e062471c5497aa7819b52f5620c6f', 'wqerqwer', 'qwerq', 'head.jpg', '57温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('0e1439accd684ecc868d4a22abfc5e7a', 'wqerqwer', 'qwerq', 'head.jpg', '146温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('0e674643f4e44a5a8b86f1cc78dd6b36', 'wqerqwer', 'qwerq', 'head.jpg', '22温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('1188d32eecf94ffa84a6eea9fb102b2d', 'wqerqwer', 'qwerq', 'head.jpg', '128温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('12c0e03985114e8197e3bf2c87b4e584', 'wqerqwer', 'qwerq', 'head.jpg', '52温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('146baaee9ac847ce917865384472a209', 'wqerqwer', 'qwerq', 'head.jpg', '61温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('150af6d6c73147e4b6fe273ea7449c1a', 'wqerqwer', 'qwerq', 'head.jpg', '8温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('16bba9ea4b74433e80378b0b8bedec45', 'wqerqwer', 'qwerq', 'head.jpg', '111温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('1731cbd3147449d9825ff03a15389c83', 'wqerqwer', 'qwerq', 'head.jpg', '21温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('176750c98bb04d90a041eaab1274ccf2', 'wqerqwer', 'qwerq', 'head.jpg', '191温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('191611a16c8347cfa1325463c31e8f4f', 'wqerqwer', 'qwerq', 'head.jpg', '43温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('19c8d51b6bd448a9a7dfaecd483ad3b9', 'wqerqwer', 'qwerq', 'head.jpg', '89温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('1a1da43906824548af6ad2508838ebcb', 'wqerqwer', 'qwerq', 'head.jpg', '31温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('1af50e10edb44aa2b8faa8cc488b93eb', 'wqerqwer', 'qwerq', 'head.jpg', '103温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('1c616aaf553f453ba69bbf0aeee3f9c5', 'wqerqwer', 'qwerq', 'head.jpg', '182温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('1de58d7e93eb4244a2261c2c1b96eceb', 'wqerqwer', 'qwerq', 'head.jpg', '107温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('1e9a8ba5bfec4ddc9b01f896a8095215', 'wqerqwer', 'qwerq', 'head.jpg', '161温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('1fda4f9752d74324a2d3c710840cf275', 'wqerqwer', 'qwerq', 'head.jpg', '110温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('203cfc372f6f434b8cf2c4f4a2f656e4', 'wqerqwer', 'qwerq', 'head.jpg', '132温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('230b38156dc243c7860a58d49a1f21be', 'wqerqwer', 'qwerq', 'head.jpg', '98温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('23bd27c86dea4b4e8bb09cd37ab4dd37', 'wqerqwer', 'qwerq', 'head.jpg', '142温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('23c606c8982146f1961a390f68018ff5', 'wqerqwer', 'qwerq', 'head.jpg', '35温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('289b130db83b4eef99ffe1ef05fbd366', 'wqerqwer', 'qwerq', 'head.jpg', '105温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('28cabb3664b042e181d20d973697bfd4', 'wqerqwer', 'qwerq', 'head.jpg', '194温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('2a0ee441773b44f881f4b106916ab9c7', 'wqerqwer', 'qwerq', 'head.jpg', '25温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('2a7e72b3bd374280b81cd190a1912c30', 'wqerqwer', 'qwerq', 'head.jpg', '144温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('2c9d7fb213c84b78957131e671b9192c', 'wqerqwer', 'qwerq', 'head.jpg', '184温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('2ca77dc5408f40fcb95fa51c6778dcae', 'wqerqwer', 'qwerq', 'head.jpg', '125温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('2d2452298bb2487381117272c334e149', 'wqerqwer', 'qwerq', 'head.jpg', '67温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('2d3c5a3e4a2246e69db9fcd859689fce', 'wqerqwer', 'qwerq', 'head.jpg', '11温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('2f34223d9a884c5b95fbed8033b39fc7', 'wqerqwer', 'qwerq', 'head.jpg', '71温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('2ff468537b5f4518a646e56b09d10cee', 'wqerqwer', 'qwerq', 'head.jpg', '199温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('32fe2ab266c84314a5606ce4a39e2722', 'wqerqwer', 'qwerq', 'head.jpg', '131温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('33cfa7af45e64da9bb8bcd9f538a9cfe', 'wqerqwer', 'qwerq', 'head.jpg', '164温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('33d8496e3cc84e21af9b4d122976f748', 'wqerqwer', 'qwerq', 'head.jpg', '4温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('34369ba6dfea4280a981be272356ac2b', 'wqerqwer', 'qwerq', 'head.jpg', '65温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('3665ab1293b84e29b1cf245961c8b077', 'wqerqwer', 'qwerq', 'head.jpg', '45温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('39a6a1bfe04f4876b99f2c551cdb42ac', 'wqerqwer', 'qwerq', 'head.jpg', '97温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('3b87b3b47b3c4452927c09290fdef22d', 'wqerqwer', 'qwerq', 'head.jpg', '16温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('3b8e8e5994f543499f845d0f7e135d32', 'wqerqwer', 'qwerq', 'head.jpg', '152温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('3cd5f55072ec4e84a10c73b82de8c8ad', 'wqerqwer', 'qwerq', 'head.jpg', '75温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('41ed42c3fab24b3e8e6908df3482e71f', 'wqerqwer', 'qwerq', 'head.jpg', '23温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('439296af9186483a8b028b8de7764e23', 'wqerqwer', 'qwerq', 'head.jpg', '140温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('44031ae6592945c58d39b786c90de6a0', 'wqerqwer', 'qwerq', 'head.jpg', '82温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('441de703b46d4cdb87e174e5fb5ccd0d', 'wqerqwer', 'qwerq', 'head.jpg', '133温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('44b9432a59a9426798ab24e4a3c61ca3', 'wqerqwer', 'qwerq', 'head.jpg', '66温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('44f336454711431ba938fdc6ce2f87dc', 'wqerqwer', 'qwerq', 'head.jpg', '196温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('4529d1879c8a442c8f8d9be603f7003a', 'wqerqwer', 'qwerq', 'head.jpg', '88温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('45cd0ece62d24e359fa9a7c58e358fec', 'wqerqwer', 'qwerq', 'head.jpg', '129温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('494ff48cac864bfd8a8a2259324e2f65', 'wqerqwer', 'qwerq', 'head.jpg', '192温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('49f55fd0e74f4b74b089b512c5842b57', 'wqerqwer', 'qwerq', 'head.jpg', '73温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('4a8e4b04d17c4ce480a9525024fb8214', 'wqerqwer', 'qwerq', 'head.jpg', '14温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('4b07db23145643e0904810b12e583ce8', 'wqerqwer', 'qwerq', 'head.jpg', '18温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('4c9decf51e244c3fa1a77c5494aa6d1c', 'wqerqwer', 'qwerq', 'head.jpg', '150温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('4e844a7861124c62b65430cae4a82433', 'wqerqwer', 'qwerq', 'head.jpg', '49温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('4f26a7a8320e4eea99150b932412b798', 'wqerqwer', 'qwerq', 'head.jpg', '127温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('4f4f07ee1c4e4591a2f3ce7ec3e25ebf', 'wqerqwer', 'qwerq', 'head.jpg', '6温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('4f69b09c6fe645e3a595478675fdce1f', 'wqerqwer', 'qwerq', 'head.jpg', '157温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('509706c33c384597a68083aaa763c973', 'wqerqwer', 'qwerq', 'head.jpg', '165温柔死而复生是', 'photo.png', '0', '2014-09-18 14:02:13');
INSERT INTO `message` VALUES ('509706c33c384597a68083aaa763c976', 'wqerqwer', 'qwerq', 'head.jpg', '165温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('509706c33c384597a68083aaa763c97t', 'wqerqwer', 'qwerq', 'head.jpg', '165温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('514836ea53b24f489106446d39a477e9', 'wqerqwer', 'qwerq', 'head.jpg', '135温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('525a45442ce1444c9b212d309a71822f', 'wqerqwer', 'qwerq', 'head.jpg', '106温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('542ba7c66fb846e4832805ed2d0447f2', 'wqerqwer', 'qwerq', 'head.jpg', '81温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('5456bf3cc913496384dd8296c49c9eb5', 'wqerqwer', 'qwerq', 'head.jpg', '83温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('54e7996c49844009ba3a723b133bb955', 'wqerqwer', 'qwerq', 'head.jpg', '3温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('550fae9be3354bf9bee2ea90bb0d812a', 'wqerqwer', 'qwerq', 'head.jpg', '84温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('586f66a3b11b411585e34e30273543ad', 'wqerqwer', 'qwerq', 'head.jpg', '69温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('59816bf5c50143e1a6ce0994eb73de8e', 'wqerqwer', 'qwerq', 'head.jpg', '151温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('5a85fb0fcdb140849d900e4d32ceaf8a', 'wqerqwer', 'qwerq', 'head.jpg', '119温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('5aa10de85520484aa78c0a442e22f1e2', 'wqerqwer', 'qwerq', 'head.jpg', '62温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('5ba83318599f4d6889dc06b751e2d6dd', 'wqerqwer', 'qwerq', 'head.jpg', '101温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('5d6f1173fab24617a28c7ef72436eec0', 'wqerqwer', 'qwerq', 'head.jpg', '26温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('5de2b9eca9064050bc387ca0d56e69b6', 'wqerqwer', 'qwerq', 'head.jpg', '13温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('5e2f3707c9204c359ac8fab2dc1819fb', 'wqerqwer', 'qwerq', 'head.jpg', '64温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('5e47ced9f6764eeeaa438339fe4856cd', 'wqerqwer', 'qwerq', 'head.jpg', '90温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('5f04573fb69e40199d1deeb375b0b96b', 'wqerqwer', 'qwerq', 'head.jpg', '60温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('5f61e6df8b3b490bb981c8df31049ec4', 'wqerqwer', 'qwerq', 'head.jpg', '188温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('5f971d53bf4a40808af4f2b4d32ba195', 'wqerqwer', 'qwerq', 'head.jpg', '44温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('5fa8f03c573f49dd83781a3482391e58', 'wqerqwer', 'qwerq', 'head.jpg', '181温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('6159371c34f74bf4a3236035431988bc', 'wqerqwer', 'qwerq', 'head.jpg', '178温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('627391e28b5c42888a0bd101f108bd4c', 'wqerqwer', 'qwerq', 'head.jpg', '102温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('638232560d164c9b8d7f0f50c7da5622', 'wqerqwer', 'qwerq', 'head.jpg', '77温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('646042c78f3a473da91d6c4528febd18', 'wqerqwer', 'qwerq', 'head.jpg', '28温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('65cd9ac2df0245f8b4a2cc5afc15525b', 'wqerqwer', 'qwerq', 'head.jpg', '137温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('65d29f2124fd48c78b885c8ffdfaee69', 'wqerqwer', 'qwerq', 'head.jpg', '185温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('67f53757a22141d4b44916ec6b6484eb', 'wqerqwer', 'qwerq', 'head.jpg', '121温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('690c5fd1d83b48c898e61b5841356f4f', 'wqerqwer', 'qwerq', 'head.jpg', '197温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('69543d4fba2c4a4fa0e7dfba6d2379f7', 'wqerqwer', 'qwerq', 'head.jpg', '19温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('6a7578cd6ab44f3893f455fb83778434', 'wqerqwer', 'qwerq', 'head.jpg', '27温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('6c997acf58aa492bb3fda099baaf2fef', 'wqerqwer', 'qwerq', 'head.jpg', '167温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('70b5b4bddec94a62bc8256f7ef14a779', 'wqerqwer', 'qwerq', 'head.jpg', '179温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('70b82ec7570e47a48abbad9e995cf366', 'wqerqwer', 'qwerq', 'head.jpg', '96温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('7208c54c52cd400ea19932e71a613b76', 'wqerqwer', 'qwerq', 'head.jpg', '139温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('72c89bab051e43babc9a4fad4cbada7d', 'wqerqwer', 'qwerq', 'head.jpg', '173温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('732268f4d3da40e5af944282b4845ceb', 'wqerqwer', 'qwerq', 'head.jpg', '114温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('748c127422154ad2831403d79f7fc5f7', 'wqerqwer', 'qwerq', 'head.jpg', '99温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('756b3114433f4f5484a49168ecb0c480', 'wqerqwer', 'qwerq', 'head.jpg', '38温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('759c8d3caba1480891932130d0e44d6d', 'wqerqwer', 'qwerq', 'head.jpg', '30温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('75ecd56c43a24a50b30e635a85c846dc', 'wqerqwer', 'qwerq', 'head.jpg', '29温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('784f7005aac54e0888add2599ed53ea2', 'wqerqwer', 'qwerq', 'head.jpg', '12温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('78a885d9163c489a834ba7e94327880e', 'wqerqwer', 'qwerq', 'head.jpg', '36温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('78d0c3fc76714ea199de26648eb333c5', 'wqerqwer', 'qwerq', 'head.jpg', '163温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('7bdff8eb1f9c4c899fb54f749a1a64b4', 'wqerqwer', 'qwerq', 'head.jpg', '143温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('848528883951465595b59000ee7b2786', 'wqerqwer', 'qwerq', 'head.jpg', '74温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('8659fae507f84bdd9cc4537801508e07', 'wqerqwer', 'qwerq', 'head.jpg', '198温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('8666371e13a94c258b56ae5055d42694', 'wqerqwer', 'qwerq', 'head.jpg', '166温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('87799d263deb485eab460bb581e5e68e', 'wqerqwer', 'qwerq', 'head.jpg', '189温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('8d6ad1a3981949248887801102d26b5f', 'wqerqwer', 'qwerq', 'head.jpg', '15温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('90de6daf233544a38e8068fad63dea58', 'wqerqwer', 'qwerq', 'head.jpg', '2温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('91493c21d49849bfa3dc1845ede86bf3', 'wqerqwer', 'qwerq', 'head.jpg', '158温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('922d994fa645497fa24b9885ea398e77', 'wqerqwer', 'qwerq', 'head.jpg', '17温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('930179a51acc4575805553bc3a94a1f9', 'wqerqwer', 'qwerq', 'head.jpg', '50温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('934b87c978d74bc09bd65d6d6cc1337b', 'wqerqwer', 'qwerq', 'head.jpg', '126温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('942fe148cf7c494ebe7c3f88dd019a20', 'wqerqwer', 'qwerq', 'head.jpg', '76温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('966720822c304a1785be48412077dc58', 'wqerqwer', 'qwerq', 'head.jpg', '149温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('995f3336690e405dae8f448c82444156', 'wqerqwer', 'qwerq', 'head.jpg', '108温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('9a1b9bf14ff84d30bda1475e8f413303', 'wqerqwer', 'qwerq', 'head.jpg', '92温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('9a1ebc1a0507485fbcaa1276ea812ab7', 'wqerqwer', 'qwerq', 'head.jpg', '174温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('9a9d5a4ce1014982aad83b73e06d0ccb', 'wqerqwer', 'qwerq', 'head.jpg', '134温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('9b75f69b15b34ab1abe4e73d83da7fbf', 'wqerqwer', 'qwerq', 'head.jpg', '80温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('a11936d6f48748338e8bb487c69d84b2', 'wqerqwer', 'qwerq', 'head.jpg', '186温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('a3b14539e22344f286ca59ab469f20e1', 'wqerqwer', 'qwerq', 'head.jpg', '42温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('a6846b6071304a058c723fd6ea08c039', 'wqerqwer', 'qwerq', 'head.jpg', '159温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('a69aaa2e7bf345cea2be1241be6539ae', 'wqerqwer', 'qwerq', 'head.jpg', '33温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('a749ee1ecc3c41b3b2cc5bd4047f789c', 'wqerqwer', 'qwerq', 'head.jpg', '93温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('abe55f7c412b4421976abfac6e3e2189', 'wqerqwer', 'qwerq', 'head.jpg', '148温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('acc48ab42cec438bbef8964731b9a863', 'wqerqwer', 'qwerq', 'head.jpg', '54温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('acf06ca2f05d43a6838a0e60fecfeb8d', 'wqerqwer', 'qwerq', 'head.jpg', '104温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('acf593c2c1a94b02bd6cf5cac7fa7478', 'wqerqwer', 'qwerq', 'head.jpg', '168温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('ad6b85d245b34937bfc9a886470fe017', 'wqerqwer', 'qwerq', 'head.jpg', '183温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('ad79a8496b834937b82257c84bbb5a3e', 'wqerqwer', 'qwerq', 'head.jpg', '24温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('ae1828ae269c4ae5b4831c43a36aa31a', 'wqerqwer', 'qwerq', 'head.jpg', '10温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('ae7ee74e834349e4a00eb8f76576abb9', 'wqerqwer', 'qwerq', 'head.jpg', '122温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('b19599c1afa34ad3a15b509efb16158b', 'wqerqwer', 'qwerq', 'head.jpg', '170温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('b1f1fe12a40940f59b766f2fe14c06bf', 'wqerqwer', 'qwerq', 'head.jpg', '175温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('b3aea32da0c6428cbcfa6a97798264d7', 'wqerqwer', 'qwerq', 'head.jpg', '141温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('b49ff6d1b8fe4764ab3497004ff502af', 'wqerqwer', 'qwerq', 'head.jpg', '145温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('b55ce16c81e842c79647b90147926b15', 'wqerqwer', 'qwerq', 'head.jpg', '156温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('b7ddeac212a44e5bac96178637938a81', 'wqerqwer', 'qwerq', 'head.jpg', '169温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('b99c57f5a2ed4cac82d5fa7f7e17f174', 'wqerqwer', 'qwerq', 'head.jpg', '51温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('bd38717b248844aa9fb209aea2ff0e36', 'wqerqwer', 'qwerq', 'head.jpg', '7温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('bdc343a60f50475dbca74fbe07da912a', 'wqerqwer', 'qwerq', 'head.jpg', '155温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('be1546e55308457ab40273240def4aec', 'wqerqwer', 'qwerq', 'head.jpg', '195温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('bec40f5926744c8aa6e95ba88940fcd3', 'wqerqwer', 'qwerq', 'head.jpg', '112温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('bf0c8356dfe14f15bf3b70e424bf7f87', 'wqerqwer', 'qwerq', 'head.jpg', '162温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('bf85b8228c1143c9b24aab989773d8da', 'wqerqwer', 'qwerq', 'head.jpg', '177温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('c09515d026794e8688193a98149bbf7f', 'wqerqwer', 'qwerq', 'head.jpg', '47温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('c0ba653b9a5b4c17ba12b3e0948959c2', 'wqerqwer', 'qwerq', 'head.jpg', '20温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('c0c3247d5e2b4fddaaa5c427e8ecbf0d', 'wqerqwer', 'qwerq', 'head.jpg', '109温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('c140fa4719d840b3bef8cb7bcba68ed3', 'wqerqwer', 'qwerq', 'head.jpg', '130温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('c15a55337e794c7c831d5a3697ce7f9f', 'wqerqwer', 'qwerq', 'head.jpg', '124温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('c19dfdb6eab44334b8e0e09916a0f8ec', 'wqerqwer', 'qwerq', 'head.jpg', '56温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('c2c7954a8cc040eba16fa77e117d38ad', 'wqerqwer', 'qwerq', 'head.jpg', '123温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('c2dec76e98e446c79bcff4b7557720a3', 'wqerqwer', 'qwerq', 'head.jpg', '113温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('c6ab5601be884f7aadf749b47dadbb26', 'wqerqwer', 'qwerq', 'head.jpg', '86温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('c7b5008d896a450c8cb9f450900888f6', 'wqerqwer', 'qwerq', 'head.jpg', '59温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('c8a4100ae3ac4050ade557df89eece52', 'wqerqwer', 'qwerq', 'head.jpg', '48温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('c9bb9d99bb914d2894a39834e300f88f', 'wqerqwer', 'qwerq', 'head.jpg', '94温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('c9cb74fb52944d619435260a8106a28c', 'wqerqwer', 'qwerq', 'head.jpg', '58温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('ca77a62bb7964a75ab7a373269a1e7a1', 'wqerqwer', 'qwerq', 'head.jpg', '171温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('cb166c69b66f4328b111151d552ad992', 'wqerqwer', 'qwerq', 'head.jpg', '100温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('cc47e7a28c264651af473bcee2686023', 'wqerqwer', 'qwerq', 'head.jpg', '63温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('cd2d88a88f4d47968ce275279ab79e4d', 'wqerqwer', 'qwerq', 'head.jpg', '118温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('d1d46b37515845a0b9f046b96c4d25d0', 'wqerqwer', 'qwerq', 'head.jpg', '180温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('d4e1499e900a44648e0705b59b08fb09', 'wqerqwer', 'qwerq', 'head.jpg', '53温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('d73da51d27554eb985f863362f1cf94b', 'wqerqwer', 'qwerq', 'head.jpg', '153温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('d820f4696e894024a0d6a8998d0ee964', 'wqerqwer', 'qwerq', 'head.jpg', '78温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('d8f0f64f45474e5884857b0974e0dfc3', 'wqerqwer', 'qwerq', 'head.jpg', '117温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('d8fed33cafed4a18b4c3a7707973e703', 'wqerqwer', 'qwerq', 'head.jpg', '136温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('d9024a6e8e5e4bacbd71054ac39c17d8', 'wqerqwer', 'qwerq', 'head.jpg', '55温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('db2fd6b40c9548689670f387d107d8bb', 'wqerqwer', 'qwerq', 'head.jpg', '147温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('de1a0c95c39a4d9e8a5c3c572bf073bc', 'wqerqwer', 'qwerq', 'head.jpg', '138温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('de283d39530b463996a75c7270341f81', 'wqerqwer', 'qwerq', 'head.jpg', '190温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('ded94c0f4f3d4ad2b2b3b501e883577c', 'wqerqwer', 'qwerq', 'head.jpg', '39温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('e7d31d0ca5024b8b9d293b9bd4c4f2e3', 'wqerqwer', 'qwerq', 'head.jpg', '187温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('e7d861da066042f68c64f925bb82fe1f', 'wqerqwer', 'qwerq', 'head.jpg', '37温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('e89f9ac751204ea1bda39e9c3a62c5c3', 'wqerqwer', 'qwerq', 'head.jpg', '0温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('ea1d80c7934d4cc2afa13840fea95f4a', 'wqerqwer', 'qwerq', 'head.jpg', '72温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('eb03f317dad14ed48548b03f144a9995', 'wqerqwer', 'qwerq', 'head.jpg', '79温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('ee1ac46e09404deeb6fbf8fd597ab127', 'wqerqwer', 'qwerq', 'head.jpg', '172温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('ee9316ff93124236ba97e3ed93fb7f9d', 'wqerqwer', 'qwerq', 'head.jpg', '116温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('f0822f2814c04ef08fa7fc774dd843b0', 'wqerqwer', 'qwerq', 'head.jpg', '41温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('f375b65e1edd4f3ab83d69a84c741b53', 'wqerqwer', 'qwerq', 'head.jpg', '85温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('f3d33f590e05495382f8435f9ac76208', 'wqerqwer', 'qwerq', 'head.jpg', '40温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('f41a4dae085e47f1a428519e0fa5defe', 'wqerqwer', 'qwerq', 'head.jpg', '68温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('f7f1cd542a1d474c8215c4e37d1c7030', 'wqerqwer', 'qwerq', 'head.jpg', '9温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('f9638ef1484a4819872365277d22549c', 'wqerqwer', 'qwerq', 'head.jpg', '115温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('fab1009dee1e4636a87615bfde464b69', 'wqerqwer', 'qwerq', 'head.jpg', '32温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('fb9d1774361544f09125e8e918d7537f', 'wqerqwer', 'qwerq', 'head.jpg', '120温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('fc535a1bf6f04a7c96966d89608421ed', 'wqerqwer', 'qwerq', 'head.jpg', '176温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('ff06e1db5ba34e908da7f5a53c5de46e', 'wqerqwer', 'qwerq', 'head.jpg', '5温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('ffd26654c5ae467e92d5f1966d2ad809', 'wqerqwer', 'qwerq', 'head.jpg', '193温柔死而复生是', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('qwe', 'wqerqwer', 'qwerq', 'head.jpg', '阿萨法萨嘎反对阿斯蒂芬', 'photo.png', '0', null);
INSERT INTO `message` VALUES ('温柔地方', 'wqerqwer', 'qwerq', 'head.jpg', '温柔死而复生是', 'photo.png', '0', null);

-- ----------------------------
-- Table structure for remessage
-- ----------------------------
DROP TABLE IF EXISTS `remessage`;
CREATE TABLE `remessage` (
  `id` varchar(32) NOT NULL,
  `messageId` varchar(32) DEFAULT NULL,
  `content` varchar(2000) DEFAULT NULL,
  `godId` varchar(32) DEFAULT NULL,
  `godName` varchar(30) DEFAULT NULL,
  `head` varchar(200) DEFAULT NULL,
  `createdate` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of remessage
-- ----------------------------
