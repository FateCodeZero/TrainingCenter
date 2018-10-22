/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50718
Source Host           : localhost:3306
Source Database       : trainingcenter

Target Server Type    : MYSQL
Target Server Version : 50718
File Encoding         : 65001

Date: 2018-10-23 02:14:23
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for tab_comment
-- ----------------------------
DROP TABLE IF EXISTS `tab_comment`;
CREATE TABLE `tab_comment` (
  `id` varchar(36) NOT NULL COMMENT 'ID',
  `content` text COMMENT '评论内容',
  `state` int(1) DEFAULT NULL COMMENT '审核状态（-1：未审核，0：未通过，1通过）',
  `remarks` varchar(1000) DEFAULT NULL COMMENT '备注',
  `create_user_id` varchar(36) DEFAULT NULL COMMENT '评论人',
  `create_date` date DEFAULT NULL COMMENT '评论时间',
  `update_user_id` varchar(36) DEFAULT NULL COMMENT '审核人',
  `update_date` date DEFAULT NULL COMMENT '审核时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of tab_comment
-- ----------------------------

-- ----------------------------
-- Table structure for tab_contact
-- ----------------------------
DROP TABLE IF EXISTS `tab_contact`;
CREATE TABLE `tab_contact` (
  `id` varchar(36) NOT NULL COMMENT 'ID',
  `name` varchar(200) DEFAULT NULL COMMENT '联系方式名称',
  `content` text COMMENT '联系方式内容',
  `remarks` varchar(1000) DEFAULT NULL COMMENT '备注',
  `create_user_id` varchar(36) DEFAULT NULL COMMENT '创建人',
  `create_date` date DEFAULT NULL COMMENT '创建时间',
  `update_user_id` varchar(36) DEFAULT NULL COMMENT '更新人',
  `update_date` date DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of tab_contact
-- ----------------------------

-- ----------------------------
-- Table structure for tab_core_introduce
-- ----------------------------
DROP TABLE IF EXISTS `tab_core_introduce`;
CREATE TABLE `tab_core_introduce` (
  `id` varchar(36) NOT NULL COMMENT 'ID',
  `content` text COMMENT '中心简介内容',
  `img_urls` text COMMENT '相关图片URLS',
  `remarks` varchar(1000) DEFAULT NULL COMMENT '备注',
  `create_user_id` varchar(36) DEFAULT NULL COMMENT '创建人ID',
  `create_date` date DEFAULT NULL COMMENT '创建时间',
  `update_user_id` varchar(36) DEFAULT NULL COMMENT '更新人ID',
  `update_date` date DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of tab_core_introduce
-- ----------------------------

-- ----------------------------
-- Table structure for tab_course
-- ----------------------------
DROP TABLE IF EXISTS `tab_course`;
CREATE TABLE `tab_course` (
  `id` varchar(36) NOT NULL COMMENT 'ID',
  `name` varchar(200) NOT NULL COMMENT '课程名称',
  `describe` text COMMENT '课程描述',
  `remarks` varchar(1000) DEFAULT NULL COMMENT '备注',
  `create_user_id` varchar(36) DEFAULT NULL COMMENT '创建人ID',
  `create_date` date DEFAULT NULL COMMENT '创建时间',
  `update_user_id` varchar(36) DEFAULT NULL COMMENT '更新人ID',
  `update_date` date DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of tab_course
-- ----------------------------

-- ----------------------------
-- Table structure for tab_news_information
-- ----------------------------
DROP TABLE IF EXISTS `tab_news_information`;
CREATE TABLE `tab_news_information` (
  `id` varchar(36) NOT NULL COMMENT 'ID',
  `title` varchar(200) NOT NULL COMMENT '资讯标题',
  `content` text COMMENT '资讯内容',
  `img_urls` text COMMENT '资讯相关图片',
  `remarks` varchar(1000) DEFAULT NULL COMMENT '备注',
  `create_user_id` varchar(36) DEFAULT NULL COMMENT '创建人ID',
  `create_date` date DEFAULT NULL COMMENT '创建时间',
  `update_user_id` varchar(36) DEFAULT NULL COMMENT '更新人ID',
  `update_date` date DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of tab_news_information
-- ----------------------------

-- ----------------------------
-- Table structure for tab_teaching_resource
-- ----------------------------
DROP TABLE IF EXISTS `tab_teaching_resource`;
CREATE TABLE `tab_teaching_resource` (
  `id` varchar(36) NOT NULL COMMENT 'ID',
  `name` varchar(200) NOT NULL COMMENT '教学资源名称',
  `describe` text COMMENT '教学资源描述',
  `img_urls` text COMMENT '资源图片URLS',
  `remarks` varchar(1000) DEFAULT NULL COMMENT '备注',
  `create_user_id` varchar(36) DEFAULT NULL COMMENT '创建人ID',
  `create_date` date DEFAULT NULL COMMENT '创建时间',
  `update_user_id` varchar(36) DEFAULT NULL COMMENT '更新人ID',
  `update_date` date DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of tab_teaching_resource
-- ----------------------------

-- ----------------------------
-- Table structure for tab_training_display
-- ----------------------------
DROP TABLE IF EXISTS `tab_training_display`;
CREATE TABLE `tab_training_display` (
  `id` varchar(36) NOT NULL COMMENT 'ID',
  `title` varchar(255) DEFAULT NULL COMMENT '培训展示标题',
  `content` text COMMENT '培训展示内容',
  `img_urls` text COMMENT '展示图片URLS',
  `remarks` varchar(1000) DEFAULT NULL COMMENT '备注',
  `create_user_id` varchar(36) DEFAULT NULL COMMENT '创建人ID',
  `create_date` date DEFAULT NULL COMMENT '创建时间',
  `update_user_id` varchar(36) DEFAULT NULL COMMENT '更新人ID',
  `update_date` date DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of tab_training_display
-- ----------------------------

-- ----------------------------
-- Table structure for tab_training_dynamic
-- ----------------------------
DROP TABLE IF EXISTS `tab_training_dynamic`;
CREATE TABLE `tab_training_dynamic` (
  `id` varchar(36) NOT NULL COMMENT 'ID',
  `title` varchar(200) NOT NULL COMMENT '培训动态标题',
  `content` text COMMENT '动态内容',
  `img_urls` text COMMENT '动态相关图片URLS',
  `remarks` varchar(1000) DEFAULT NULL COMMENT '备注',
  `create_user_id` varchar(36) DEFAULT NULL COMMENT '创建人ID',
  `create_date` date DEFAULT NULL COMMENT '创建时间',
  `update_user_id` varchar(36) DEFAULT NULL COMMENT '更新人ID',
  `update_date` date DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of tab_training_dynamic
-- ----------------------------

-- ----------------------------
-- Table structure for tab_user
-- ----------------------------
DROP TABLE IF EXISTS `tab_user`;
CREATE TABLE `tab_user` (
  `id` varchar(36) NOT NULL COMMENT 'ID',
  `username` varchar(255) NOT NULL COMMENT '用户名',
  `nickname` varchar(255) DEFAULT NULL COMMENT '用户昵称',
  `head_portrait_url` text COMMENT '用户头像URL',
  `gender` int(1) DEFAULT '1' COMMENT '性别(1：男，0：女)',
  `phone` varchar(11) DEFAULT NULL COMMENT '手机号码',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `address` varchar(255) DEFAULT NULL COMMENT '地址',
  `signature` varchar(1000) DEFAULT NULL COMMENT '用户签名',
  `user_type_id` varchar(36) NOT NULL COMMENT '用户类型ID',
  `code` varchar(255) DEFAULT NULL COMMENT '用户编码（教职工与学生独有，教职工为职工编号，学生为学号）',
  `describe` text COMMENT '职工描述（教职工与学生独有）',
  `img_urls` text COMMENT '用户相关图片',
  `state` int(2) DEFAULT NULL COMMENT '使用状态（1启用，0禁用）',
  `remarks` varchar(1000) DEFAULT NULL COMMENT '备注',
  `create_user_id` varchar(36) DEFAULT NULL COMMENT '创建人ID',
  `create_date` date DEFAULT NULL COMMENT '创建时间',
  `update_user_id` varchar(36) DEFAULT NULL COMMENT '更新人ID',
  `update_date` date DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of tab_user
-- ----------------------------
INSERT INTO `tab_user` VALUES ('09b47d1a-e189-4cd4-82f8-e01510e5227f', 'admin', null, null, null, null, null, null, null, '0', null, null, null, null, null, null, null, null, null);

-- ----------------------------
-- Table structure for tab_user_check
-- ----------------------------
DROP TABLE IF EXISTS `tab_user_check`;
CREATE TABLE `tab_user_check` (
  `id` varchar(36) NOT NULL COMMENT 'ID',
  `username` varchar(255) NOT NULL COMMENT '用户名',
  `password` varchar(255) NOT NULL COMMENT '密码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of tab_user_check
-- ----------------------------
INSERT INTO `tab_user_check` VALUES ('c4f8b90e-1a6e-4bf7-9552-6b638e8e3b47', 'admin', '63a9f0ea7bb98050796b649e85481845');

-- ----------------------------
-- Table structure for tab_user_type
-- ----------------------------
DROP TABLE IF EXISTS `tab_user_type`;
CREATE TABLE `tab_user_type` (
  `id` varchar(36) NOT NULL COMMENT 'ID',
  `name` varchar(100) NOT NULL COMMENT '用户类型名称',
  `describe` text COMMENT '用户类型描述',
  `remarks` varchar(1000) DEFAULT NULL COMMENT '备注',
  `create_user_id` varchar(36) NOT NULL COMMENT '创建人ID',
  `create_date` date DEFAULT NULL COMMENT '创建时间',
  `update_user_id` varchar(36) DEFAULT NULL COMMENT '更新人ID',
  `update_date` date DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of tab_user_type
-- ----------------------------
