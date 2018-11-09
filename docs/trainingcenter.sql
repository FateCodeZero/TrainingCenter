/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50718
Source Host           : localhost:3306
Source Database       : trainingcenter

Target Server Type    : MYSQL
Target Server Version : 50718
File Encoding         : 65001

Date: 2018-11-09 13:40:03
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for tab_disable_ip
-- ----------------------------
DROP TABLE IF EXISTS `tab_disable_ip`;
CREATE TABLE `tab_disable_ip` (
  `id` varchar(36) NOT NULL COMMENT '用户登录IP封禁表ID',
  `IP` varchar(255) NOT NULL COMMENT '用户登录IP',
  `state` int(1) NOT NULL DEFAULT '1' COMMENT '使用状态（0：锁定，1：正常）'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tab_disable_ip
-- ----------------------------

-- ----------------------------
-- Table structure for tab_login_info
-- ----------------------------
DROP TABLE IF EXISTS `tab_login_info`;
CREATE TABLE `tab_login_info` (
  `id` varchar(36) NOT NULL COMMENT 'ID',
  `username` varchar(255) NOT NULL COMMENT '用户名',
  `password` varchar(255) NOT NULL COMMENT '密码',
  `login_IP` varchar(255) DEFAULT NULL COMMENT '用户登录IP',
  `state` int(2) DEFAULT '1' COMMENT '用户使用状态（-1：已注销，0：已禁用，1：已启用）',
  `is_unlocked` int(2) DEFAULT '0' COMMENT 'ip是否被锁（0：被锁定，1：不锁定）',
  `last_login_time` date DEFAULT NULL COMMENT '最后登录时间',
  `attribute1` varchar(255) DEFAULT NULL COMMENT '预留字段1',
  `attribute2` varchar(255) DEFAULT NULL COMMENT '预留字段2',
  `attribute3` varchar(255) DEFAULT NULL COMMENT '预留字段3',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tab_login_info
-- ----------------------------
INSERT INTO `tab_login_info` VALUES ('5edfc5cd-dffd-493c-be95-640654263b89', 'admin@qq.com', '63a9f0ea7bb98050796b649e85481845', '0:0:0:0:0:0:0:1', '1', '1', '2018-11-08', null, null, null);
INSERT INTO `tab_login_info` VALUES ('d98d8e67-6da3-4785-a75c-cb8c38df7e74', 'yangyi@qq.com', '63a9f0ea7bb98050796b649e85481845', '0:0:0:0:0:0:0:1', '1', '1', '2018-11-07', null, null, null);

-- ----------------------------
-- Table structure for tab_login_info_role
-- ----------------------------
DROP TABLE IF EXISTS `tab_login_info_role`;
CREATE TABLE `tab_login_info_role` (
  `id` varchar(36) NOT NULL DEFAULT '' COMMENT '用户-角色对应表ID',
  `login_info_id` varchar(36) NOT NULL COMMENT '登录信息id',
  `role_id` varchar(36) NOT NULL COMMENT '角色id',
  `remarks` text COMMENT '备注',
  `create_user_id` varchar(36) DEFAULT NULL COMMENT '创建人id',
  `create_date` date DEFAULT NULL COMMENT '创建时间',
  `update_user_id` varchar(36) DEFAULT NULL COMMENT '更新人id',
  `update_date` date DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tab_login_info_role
-- ----------------------------
INSERT INTO `tab_login_info_role` VALUES ('1a51ee8c-83a2-491d-bdc8-f2e99a6ae31e', 'd98d8e67-6da3-4785-a75c-cb8c38df7e74', '7e0ee84f-216f-41d3-b3b0-832eaea51e79', null, null, null, null, null);
INSERT INTO `tab_login_info_role` VALUES ('8940bc0f-230a-450b-828c-2f270d1cdbed', '5edfc5cd-dffd-493c-be95-640654263b89', '7e0ee84f-216f-41d3-b3b0-832eaea51e79', null, null, null, null, null);

-- ----------------------------
-- Table structure for tab_permission
-- ----------------------------
DROP TABLE IF EXISTS `tab_permission`;
CREATE TABLE `tab_permission` (
  `id` varchar(36) NOT NULL COMMENT 'ID',
  `name` varchar(255) DEFAULT NULL COMMENT '权限名称',
  `describe` text COMMENT '权限描述',
  `url` text COMMENT '权限对应资源url',
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
INSERT INTO `tab_role` VALUES ('7e0ee84f-216f-41d3-b3b0-832eaea51e79', 'USER', '普通用户角色', '普通用户角色，在用户注册时会默认添加', null, '2018-11-06', null, null, null, null, null);
INSERT INTO `tab_role` VALUES ('c09b1a67-1ab6-43fc-b1b6-7cd48ad21336', 'ADMIN', '超级管理员角色', '超级管理员', null, '2018-11-06', null, null, '', null, null);

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
  `user_type_id` varchar(36) DEFAULT NULL COMMENT '用户类型id',
  `role_id` varchar(36) DEFAULT NULL COMMENT '用户角色ID',
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
INSERT INTO `tab_user` VALUES ('0c81b622-f86b-447d-924d-e6c923e97c7b', 'yangyi@qq.com', 'yangyi@qq.com', null, null, '2018-11-07', '1', null, null, null, null, null, null, null, null, null, '1', '2018-11-07', null, null, null);
INSERT INTO `tab_user` VALUES ('3862cd33-ba66-4d69-8fc4-540b22098804', 'admin@qq.com', 'admin@qq.com', null, null, '2018-11-06', '1', null, null, null, null, null, null, null, null, null, '1', '2018-11-06', null, null, null);

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
