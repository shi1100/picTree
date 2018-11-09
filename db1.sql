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

