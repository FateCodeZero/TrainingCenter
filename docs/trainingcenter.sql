/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50718
Source Host           : localhost:3306
Source Database       : trainingcenter

Target Server Type    : MYSQL
Target Server Version : 50718
File Encoding         : 65001

Date: 2018-11-02 14:27:21
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for tab_login_info
-- ----------------------------
DROP TABLE IF EXISTS `tab_login_info`;
CREATE TABLE `tab_login_info` (
  `id` varchar(36) NOT NULL COMMENT 'ID',
  `username` varchar(255) NOT NULL COMMENT '用户名',
  `password` varchar(255) NOT NULL COMMENT '密码',
  `login_IP` varchar(255) DEFAULT NULL COMMENT '用户登录IP',
  `last_login_time` date DEFAULT NULL COMMENT '最后登录时间',
  `attribute1` varchar(255) DEFAULT NULL COMMENT '预留字段1',
  `attribute2` varchar(255) DEFAULT NULL COMMENT '预留字段2',
  `attribute3` varchar(255) DEFAULT NULL COMMENT '预留字段3',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tab_login_info
-- ----------------------------
INSERT INTO `tab_login_info` VALUES ('0a361e1c-3be6-4dd9-985c-b46a331138d4', 'admin', '63a9f0ea7bb98050796b649e85481845', '0:0:0:0:0:0:0:1', '2018-11-02', null, null, null);

-- ----------------------------
-- Table structure for tab_permission
-- ----------------------------
DROP TABLE IF EXISTS `tab_permission`;
CREATE TABLE `tab_permission` (
  `id` varchar(36) NOT NULL COMMENT 'ID',
  `name` varchar(255) DEFAULT NULL COMMENT '权限名称',
  `describe` text COMMENT '权限描述',
  `resource_id` text COMMENT '权限对应资源id',
  `remarks` text COMMENT '备注',
  `create_user_id` varchar(36) DEFAULT NULL COMMENT '创建人id',
  `create_date` date DEFAULT NULL COMMENT '创建时间',
  `update_user_id` varchar(36) DEFAULT NULL COMMENT '更新人id',
  `update_date` date DEFAULT NULL COMMENT '更新时间',
  `attribute1` varchar(255) DEFAULT NULL COMMENT '预留字段1',
  `attribute2` varchar(255) DEFAULT NULL COMMENT '预留字段2',
  `attribute3` varchar(255) DEFAULT NULL COMMENT '预留字段3',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of tab_permission
-- ----------------------------

-- ----------------------------
-- Table structure for tab_role
-- ----------------------------
DROP TABLE IF EXISTS `tab_role`;
CREATE TABLE `tab_role` (
  `id` varchar(255) NOT NULL COMMENT 'ID',
  `name` varchar(255) NOT NULL COMMENT '角色名称',
  `describe` text COMMENT '角色描述',
  `permission_ids` text COMMENT '所含权限ids',
  `remarks` text COMMENT '备注',
  `create_user_id` varchar(36) DEFAULT NULL COMMENT '创建人id',
  `create_date` date DEFAULT NULL COMMENT '创建时间',
  `update_user_id` varchar(36) DEFAULT NULL COMMENT '更新人id',
  `update_date` date DEFAULT NULL COMMENT '更新时间',
  `attribute1` varchar(255) DEFAULT NULL COMMENT '预留字段1',
  `attribute2` varchar(255) DEFAULT NULL COMMENT '预留字段2',
  `attribute3` varchar(255) DEFAULT NULL COMMENT '预留字段3',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of tab_role
-- ----------------------------

-- ----------------------------
-- Table structure for tab_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `tab_role_permission`;
CREATE TABLE `tab_role_permission` (
  `id` varchar(36) NOT NULL COMMENT 'ID',
  `role_id` varchar(36) NOT NULL COMMENT '角色id',
  `permission_id` varchar(36) NOT NULL COMMENT '权限id',
  `remarks` text COMMENT '备注',
  `create_user_id` varchar(36) DEFAULT NULL COMMENT '创建人id',
  `create_date` date DEFAULT NULL COMMENT '创建时间',
  `update_user_id` varchar(36) DEFAULT NULL COMMENT '更新人id',
  `update_date` date DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of tab_role_permission
-- ----------------------------

-- ----------------------------
-- Table structure for tab_sys_log
-- ----------------------------
DROP TABLE IF EXISTS `tab_sys_log`;
CREATE TABLE `tab_sys_log` (
  `id` varchar(36) NOT NULL DEFAULT '' COMMENT 'ID',
  `op_user_id` varchar(36) DEFAULT NULL COMMENT '操作人id',
  `op_type` varchar(255) DEFAULT NULL COMMENT '操作类型',
  `op_content` text COMMENT '操作内容',
  `op_date` date DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of tab_sys_log
-- ----------------------------

-- ----------------------------
-- Table structure for tab_user
-- ----------------------------
DROP TABLE IF EXISTS `tab_user`;
CREATE TABLE `tab_user` (
  `id` varchar(36) NOT NULL COMMENT 'ID',
  `username` varchar(255) NOT NULL COMMENT '用户名',
  `nickname` varchar(255) DEFAULT NULL COMMENT '用户昵称',
  `head_portrait` text COMMENT '用户头像URL',
  `real_name` varchar(255) DEFAULT NULL COMMENT '真实姓名',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `gender` int(1) DEFAULT '1' COMMENT '性别(1：男，0：女)',
  `phone` varchar(11) DEFAULT NULL COMMENT '手机号码',
  `email` varchar(255) DEFAULT NULL COMMENT '邮箱',
  `address` varchar(255) DEFAULT NULL COMMENT '地址',
  `motto` varchar(1000) DEFAULT NULL COMMENT '用户签名',
  `user_type_id` varchar(36) DEFAULT NULL COMMENT '用户类型ID',
  `user_code` varchar(255) DEFAULT NULL COMMENT '用户编码（教职工与学生独有，教职工为职工编号，学生为学号）',
  `describe` text COMMENT '职工描述（教职工与学生独有）',
  `imgs` text COMMENT '用户相关图片url',
  `state` int(2) DEFAULT '1' COMMENT '使用状态（1启用，0禁用）',
  `register_time` date DEFAULT NULL COMMENT '注册时间',
  `attribute1` varchar(255) DEFAULT NULL COMMENT '预留字段1',
  `attribute2` varchar(255) DEFAULT NULL COMMENT '预留字段2',
  `attribute3` varchar(255) DEFAULT NULL COMMENT '预留字段3',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of tab_user
-- ----------------------------
INSERT INTO `tab_user` VALUES ('7b88a705-7865-4d5f-be9c-b154d72b58e3', 'admin', 'admin', null, null, '2018-11-02', '1', null, null, null, null, null, null, null, null, '1', '2018-11-02', null, null, null);

-- ----------------------------
-- Table structure for tab_user_type
-- ----------------------------
DROP TABLE IF EXISTS `tab_user_type`;
CREATE TABLE `tab_user_type` (
  `id` varchar(36) NOT NULL COMMENT 'ID',
  `name` varchar(100) NOT NULL COMMENT '用户类型名称',
  `describe` text COMMENT '用户类型描述',
  `remarks` varchar(1000) DEFAULT NULL COMMENT '备注',
  `create_user_id` varchar(36) DEFAULT NULL COMMENT '创建人ID',
  `create_date` date DEFAULT NULL COMMENT '创建时间',
  `update_user_id` varchar(36) DEFAULT NULL COMMENT '更新人ID',
  `update_date` date DEFAULT NULL COMMENT '更新时间',
  `attribute1` varchar(255) DEFAULT NULL COMMENT '预留字段1',
  `attribute2` varchar(255) DEFAULT NULL COMMENT '预留字段2',
  `attribute3` varchar(255) DEFAULT NULL COMMENT '预留字段3',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of tab_user_type
-- ----------------------------
