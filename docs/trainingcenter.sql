/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50718
Source Host           : localhost:3306
Source Database       : trainingcenter

Target Server Type    : MYSQL
Target Server Version : 50718
File Encoding         : 65001

Date: 2018-11-27 01:57:02
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for tab_advertisement
-- ----------------------------
DROP TABLE IF EXISTS `tab_advertisement`;
CREATE TABLE `tab_advertisement` (
  `id` varchar(36) NOT NULL DEFAULT '' COMMENT 'ID',
  `imgs` text COMMENT '广告图片',
  `describe` text COMMENT '广告描述',
  `url` text COMMENT '广告链接',
  `start` date DEFAULT NULL COMMENT '开始时间',
  `end` date DEFAULT NULL COMMENT '结束时间',
  `remarks` varchar(36) DEFAULT NULL COMMENT '广告备注',
  `create_user_id` varchar(36) DEFAULT NULL COMMENT '创始人ID',
  `create_date` date DEFAULT NULL COMMENT '创建时间',
  `update_user_id` varchar(36) DEFAULT NULL COMMENT '更新人ID',
  `update_date` date DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of tab_advertisement
-- ----------------------------

-- ----------------------------
-- Table structure for tab_log
-- ----------------------------
DROP TABLE IF EXISTS `tab_log`;
CREATE TABLE `tab_log` (
  `id` varchar(255) NOT NULL COMMENT '主键ID',
  `op_user_id` varchar(255) NOT NULL COMMENT '操作人',
  `op_content` varchar(2000) DEFAULT NULL COMMENT '操作内容',
  `op_type` varchar(10) NOT NULL COMMENT '操作类型',
  `op_time` datetime DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tab_log
-- ----------------------------

-- ----------------------------
-- Table structure for tab_news_info
-- ----------------------------
DROP TABLE IF EXISTS `tab_news_info`;
CREATE TABLE `tab_news_info` (
  `id` varchar(36) NOT NULL DEFAULT '' COMMENT 'ID',
  `title` varchar(36) DEFAULT NULL COMMENT '新闻备注',
  `content` varchar(36) DEFAULT NULL COMMENT '新闻内容',
  `imgs` text COMMENT '新闻图片',
  `remarks` varchar(36) DEFAULT NULL COMMENT '新闻备注',
  `create_user_id` varchar(36) DEFAULT NULL COMMENT '创始人ID',
  `create_date` date DEFAULT NULL COMMENT '创建时间',
  `update_user_id` varchar(36) DEFAULT NULL COMMENT '更新人ID',
  `update_date` date DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of tab_news_info
-- ----------------------------

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
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_user_id` varchar(36) DEFAULT NULL COMMENT '更新人ID',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
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
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_user_id` varchar(36) DEFAULT NULL COMMENT '更新人ID',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_resource` (`name`,`url`) COMMENT '索引_资源表-资源名称资源URL（联合索引）'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tab_resource
-- ----------------------------
INSERT INTO `tab_resource` VALUES ('396f9846-d0fc-42b0-b267-d8be114e4786', '菜单管理', '/resource/listPage', '1', '系统菜单管理，即系统页面管理，可管理系统中的所有前后端页面（启用/禁用）。\n只有启用的页面才能授权给角色，禁用的页面所有角色对其都无权访问。', '注：\n1、菜单管理的主要作用是提供页面的启用与禁用功能，其他功能只是附带，非软件开发专业人员可不随意操作！\n2、菜单管理实行的是软删除，无法真正删除系统菜单，菜单被删除后会进入已删除状态，作用同禁用。\n3、菜单添加只能添加系统已经用代码实现了的页面，随意添加其他URL没有效果。\n4、菜单编辑目前不提供URL的更改，URL关乎到页面的正常显示，不能修改可避免误操作。\n5、修改菜单名称时，建议名称能有“见名知意”的效果。', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '2018-11-22 00:00:00', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '2018-11-23 17:08:22');

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
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_user_id` varchar(36) DEFAULT NULL COMMENT '更新人ID',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_role_name` (`name`) USING HASH COMMENT '索引_角色表-角色名称'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tab_role
-- ----------------------------
INSERT INTO `tab_role` VALUES ('7e0ee84f-216f-41d3-b3b0-832eaea51e79', 'USER', '普通用户角色', '普通用户角色，在用户注册时会默认添加', null, '2018-11-18 00:00:00', null, null);
INSERT INTO `tab_role` VALUES ('c09b1a67-1ab6-43fc-b1b6-7cd48ad21336', 'ADMIN', '超级管理员角色', '超级管理员', null, '2018-11-18 00:00:00', null, null);

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
-- Table structure for tab_training_dynamic
-- ----------------------------
DROP TABLE IF EXISTS `tab_training_dynamic`;
CREATE TABLE `tab_training_dynamic` (
  `id` varchar(36) NOT NULL DEFAULT '' COMMENT 'ID',
  `title` varchar(36) DEFAULT NULL COMMENT '动态培训的标题',
  `imgs` text COMMENT '动态培训的图片',
  `content` text COMMENT '培训内容',
  `remarks` varchar(36) DEFAULT NULL COMMENT '培训备注',
  `createUserId` varchar(36) DEFAULT NULL COMMENT '创始人ID',
  `createDate` date DEFAULT NULL COMMENT '创建时间',
  `updateUserId` varchar(36) DEFAULT NULL COMMENT '更新人ID',
  `updateDate` date DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of tab_training_dynamic
-- ----------------------------
INSERT INTO `tab_training_dynamic` VALUES ('1', '培训1', 'https://goss.veer.com/creative/vcg/veer/800water/veer-155063993.jpg', '培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容', '培训1', '培训1', '2018-11-05', '培训1', '2018-11-29');
INSERT INTO `tab_training_dynamic` VALUES ('2', '培训2', 'https://goss.veer.com/creative/vcg/veer/800water/veer-303342183.jpg', '培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容', '培训2', '培训2', '2018-11-05', '培训2', '2018-11-29');
INSERT INTO `tab_training_dynamic` VALUES ('3', '培训3', 'https://goss.veer.com/creative/vcg/veer/800water/veer-302222696.jpg', '培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容', '培训3', '培训3', '2018-11-06', '培训3', '2018-11-14');
INSERT INTO `tab_training_dynamic` VALUES ('4', '培训4', 'https://goss.veer.com/creative/vcg/veer/800water/veer-147418763.jpg', '培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容', '培训4', '培训4', '2018-11-05', '培训4', '2018-11-20');
INSERT INTO `tab_training_dynamic` VALUES ('5', '培训5', 'https://goss.veer.com/creative/vcg/veer/800water/veer-147424398.jpg', '培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容', '培训5', '培训5', '2018-11-06', '培训5', '2018-11-22');

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
  `register_time` datetime DEFAULT NULL COMMENT '注册时间',
  `last_login_time` datetime DEFAULT NULL COMMENT '最后登录时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_username` (`username`) USING BTREE COMMENT '索引_用户表-账号',
  KEY `idx_user_password` (`password`) USING HASH COMMENT '索引_用户表-密码'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tab_user
-- ----------------------------
INSERT INTO `tab_user` VALUES ('d6a00d9d-2801-45c3-a99f-326e2949e2f2', 'admin@qq.com', '63a9f0ea7bb98050796b649e85481845', '0:0:0:0:0:0:0:1', '1', '1', '2018-11-18 00:00:00', '2018-11-23 00:00:00');

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
INSERT INTO `tab_user_role` VALUES ('a53ccb57-ca3d-4d76-a1a0-40efa11ce347', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', 'c09b1a67-1ab6-43fc-b1b6-7cd48ad21336');
