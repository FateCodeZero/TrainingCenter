/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50718
Source Host           : localhost:3306
Source Database       : trainingcenter

Target Server Type    : MYSQL
Target Server Version : 50718
File Encoding         : 65001

Date: 2018-11-18 07:04:53
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for tab_permission
-- ----------------------------
DROP TABLE IF EXISTS `tab_permission`;
CREATE TABLE `tab_permission` (
  `id` varchar(36) NOT NULL COMMENT '主键ID',
  `name` varchar(100) NOT NULL COMMENT '权限名称',
  `resource_id` varchar(36) NOT NULL COMMENT '权限对应资源ID',
  `operations` varchar(50) DEFAULT NULL COMMENT '可执行操作',
  `describe` varchar(500) DEFAULT NULL COMMENT '权限描述',
  `remarks` varchar(500) DEFAULT NULL COMMENT '备注',
  `create_user_id` varchar(36) DEFAULT NULL COMMENT '创建人ID',
  `create_date` date DEFAULT NULL COMMENT '创建时间',
  `update_user_id` varchar(36) DEFAULT NULL COMMENT '更新人ID',
  `update_date` date DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_permission_name` (`name`) USING BTREE COMMENT '索引_权限表-权限名称',
  KEY `idx_permission_resourceid` (`resource_id`) USING BTREE COMMENT '索引_权限表-资源ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tab_permission
-- ----------------------------

-- ----------------------------
-- Table structure for tab_resource
-- ----------------------------
DROP TABLE IF EXISTS `tab_resource`;
CREATE TABLE `tab_resource` (
  `id` varchar(36) NOT NULL COMMENT '主键ID',
  `name` varchar(100) NOT NULL COMMENT '资源名称',
  `url` varchar(255) NOT NULL COMMENT '资源对应URL',
  `state` int(2) DEFAULT '1' COMMENT '资源使用状态',
  `describe` varchar(500) DEFAULT NULL COMMENT '资源描述',
  `remarks` varchar(500) DEFAULT NULL COMMENT '备注',
  `create_user_id` varchar(36) DEFAULT NULL COMMENT '创建人ID',
  `create_date` date DEFAULT NULL COMMENT '创建时间',
  `update_user_id` varchar(36) DEFAULT NULL COMMENT '更新人ID',
  `update_date` date DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_resource` (`name`,`url`) COMMENT '索引_资源表-资源名称资源URL（联合索引）'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tab_resource
-- ----------------------------

-- ----------------------------
-- Table structure for tab_role
-- ----------------------------
DROP TABLE IF EXISTS `tab_role`;
CREATE TABLE `tab_role` (
  `id` varchar(36) NOT NULL COMMENT '主键ID',
  `name` varchar(100) NOT NULL COMMENT '角色名称',
  `describe` varchar(500) DEFAULT NULL COMMENT '角色描述',
  `remarks` varchar(500) DEFAULT NULL COMMENT '备注',
  `create_user_id` varchar(36) DEFAULT NULL COMMENT '创建人ID',
  `create_date` date DEFAULT NULL COMMENT '创建时间',
  `update_user_id` varchar(36) DEFAULT NULL COMMENT '更新人ID',
  `update_date` date DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_role_name` (`name`) USING HASH COMMENT '索引_角色表-角色名称'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tab_role
-- ----------------------------
INSERT INTO `tab_role` VALUES ('7e0ee84f-216f-41d3-b3b0-832eaea51e79', 'USER', '普通用户角色', '普通用户角色，在用户注册时会默认添加', null, '2018-11-18', null, null);
INSERT INTO `tab_role` VALUES ('c09b1a67-1ab6-43fc-b1b6-7cd48ad21336', 'ADMIN', '超级管理员角色', '超级管理员', null, '2018-11-18', null, null);

-- ----------------------------
-- Table structure for tab_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `tab_role_permission`;
CREATE TABLE `tab_role_permission` (
  `id` varchar(36) NOT NULL COMMENT '主键ID',
  `role_id` varchar(36) NOT NULL COMMENT '角色ID',
  `permission_id` varchar(36) NOT NULL COMMENT '权限ID',
  PRIMARY KEY (`id`),
  KEY `idx_role_permission` (`role_id`,`permission_id`) COMMENT '索引_角色-权限表_角色ID权限ID（联合索引）'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tab_role_permission
-- ----------------------------

-- ----------------------------
-- Table structure for tab_user
-- ----------------------------
DROP TABLE IF EXISTS `tab_user`;
CREATE TABLE `tab_user` (
  `id` varchar(36) NOT NULL COMMENT '主键ID',
  `username` varchar(100) NOT NULL COMMENT '用户账号',
  `password` varchar(100) NOT NULL COMMENT '用户密码',
  `login_IP` varchar(100) DEFAULT NULL COMMENT '登录IP',
  `unlocked_flag` int(2) DEFAULT '1' COMMENT 'IP解锁标志（1：解锁，0：被锁）',
  `state` int(2) DEFAULT '1' COMMENT '账号使用状态（1：已启用，0：已禁用，-1：已注销）',
  `register_time` date DEFAULT NULL COMMENT '注册时间',
  `last_login_time` date DEFAULT NULL COMMENT '最后登录时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_username` (`username`) USING BTREE COMMENT '索引_用户表-账号',
  KEY `idx_user_password` (`password`) USING HASH COMMENT '索引_用户表-密码'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tab_user
-- ----------------------------
INSERT INTO `tab_user` VALUES ('d6a00d9d-2801-45c3-a99f-326e2949e2f2', 'admin@qq.com', '63a9f0ea7bb98050796b649e85481845', '0:0:0:0:0:0:0:1', '1', '1', '2018-11-18', '2018-11-18');

-- ----------------------------
-- Table structure for tab_user_info
-- ----------------------------
DROP TABLE IF EXISTS `tab_user_info`;
CREATE TABLE `tab_user_info` (
  `id` varchar(36) NOT NULL COMMENT '主键ID',
  `username` varchar(100) NOT NULL COMMENT '用户账号',
  `nickname` varchar(100) DEFAULT NULL COMMENT '昵称',
  `real_name` varchar(100) DEFAULT NULL COMMENT '真实姓名',
  `portrait_img` varchar(255) DEFAULT NULL COMMENT '头像URL',
  `gender` int(2) NOT NULL COMMENT '性别（1：男，0：女）',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `address` varchar(500) DEFAULT NULL COMMENT '联系地址',
  `postal_code` varchar(50) DEFAULT NULL COMMENT '邮政编码',
  `email` varchar(200) DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(20) DEFAULT NULL COMMENT '电话号码',
  `motto` varchar(255) DEFAULT NULL COMMENT '用户签名',
  `describe` varchar(1000) DEFAULT NULL COMMENT '个人简介',
  `imgs` text COMMENT '用户相关图片URLS',
  `company` varchar(255) DEFAULT NULL COMMENT '工作单位（公司）',
  `position` varchar(100) DEFAULT NULL COMMENT '职位',
  `career` varchar(100) DEFAULT NULL COMMENT '职业',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_userinfo_username` (`username`) USING HASH COMMENT '索引_用户信息表-账号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tab_user_info
-- ----------------------------
INSERT INTO `tab_user_info` VALUES ('abb5531d-84f2-4f8c-a279-ff094036e04c', 'admin@qq.com', 'admin@qq.com', null, null, '1', null, null, null, null, null, null, null, null, null, null, null);

-- ----------------------------
-- Table structure for tab_user_role
-- ----------------------------
DROP TABLE IF EXISTS `tab_user_role`;
CREATE TABLE `tab_user_role` (
  `id` varchar(36) NOT NULL COMMENT '主键ID',
  `user_id` varchar(36) NOT NULL COMMENT '用户ID',
  `role_id` varchar(36) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`id`),
  KEY `idx_user_role` (`user_id`,`role_id`) USING BTREE COMMENT '索引_用户-角色表_用户ID角色ID（联合索引）'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tab_user_role
-- ----------------------------
INSERT INTO `tab_user_role` VALUES ('a53ccb57-ca3d-4d76-a1a0-40efa11ce343', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '7e0ee84f-216f-41d3-b3b0-832eaea51e79');
