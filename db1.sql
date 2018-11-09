/*
Navicat MySQL Data Transfer

Source Server         : 47.99.169.110
Source Server Version : 50561
Source Host           : 47.99.169.110:13388
Source Database       : db1

Target Server Type    : MYSQL
Target Server Version : 50561
File Encoding         : 65001

Date: 2018-11-09 10:19:55
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for pictree
-- ----------------------------
DROP TABLE IF EXISTS `pictree`;
CREATE TABLE `pictree` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pictree
-- ----------------------------
INSERT INTO `pictree` VALUES ('16', '0', null, '沈巷变');
INSERT INTO `pictree` VALUES ('29', '16', null, '113沈东线');
INSERT INTO `pictree` VALUES ('30', '16', null, '135沈巷线');
INSERT INTO `pictree` VALUES ('31', '29', null, '站房');
INSERT INTO `pictree` VALUES ('32', '29', null, '线路');
INSERT INTO `pictree` VALUES ('33', '31', null, 'A开闭所');
INSERT INTO `pictree` VALUES ('34', '31', null, 'B环网柜');
INSERT INTO `pictree` VALUES ('35', '31', null, 'C配电房');
INSERT INTO `pictree` VALUES ('36', '32', null, '1#杆塔');
INSERT INTO `pictree` VALUES ('37', '32', null, 'A电缆');
INSERT INTO `pictree` VALUES ('38', '32', null, 'B架空导线');
INSERT INTO `pictree` VALUES ('39', '16', null, 'ggg');
INSERT INTO `pictree` VALUES ('40', '0', null, 'vvv');
INSERT INTO `pictree` VALUES ('41', '0', null, 'ttt');

-- ----------------------------
-- Table structure for picurl
-- ----------------------------
DROP TABLE IF EXISTS `picurl`;
CREATE TABLE `picurl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `picid` int(11) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of picurl
-- ----------------------------
INSERT INTO `picurl` VALUES ('66', '34', '/UploadFile/2018-11-06/9d84f245-585f-4a72-bddc-4518644620fc.jpg');
INSERT INTO `picurl` VALUES ('67', '34', '/UploadFile/2018-11-06/9e432775-da47-4c25-bec6-2fde183baf0e.jpg');
INSERT INTO `picurl` VALUES ('68', '34', '/UploadFile/2018-11-06/81f4a5fb-d7b6-4428-9494-3a6617df7776.jpg');
INSERT INTO `picurl` VALUES ('69', '35', '/UploadFile/2018-11-06/e509ba36-e0fc-4ec7-958e-8b025badaf59.jpg');
INSERT INTO `picurl` VALUES ('70', '35', '/UploadFile/2018-11-06/abd5d9c0-53eb-44dc-a54c-ca399c86867a.jpg');
INSERT INTO `picurl` VALUES ('71', '33', '/UploadFile/2018-11-06/9be17fae-f05e-49e0-908a-ea46696c787c.jpg');
INSERT INTO `picurl` VALUES ('72', '33', '/UploadFile/2018-11-06/cda3e1ab-3393-447a-bea6-9977b266df7a.jpg');
INSERT INTO `picurl` VALUES ('73', '31', '/UploadFile/2018-11-06/ac784b33-f1de-4f76-8618-0ac3b7f8d162.jpg');
INSERT INTO `picurl` VALUES ('82', '16', '/UploadFile/2018-11-06/1064ef97-1a89-4756-9dd8-2a645fbc73a5.jpg');
