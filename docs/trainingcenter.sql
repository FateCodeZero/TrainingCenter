/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50718
Source Host           : localhost:3306
Source Database       : trainingcenter

Target Server Type    : MYSQL
Target Server Version : 50718
File Encoding         : 65001

Date: 2018-12-04 21:38:20
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
-- Table structure for tab_lock_ip
-- ----------------------------
DROP TABLE IF EXISTS `tab_lock_ip`;
CREATE TABLE `tab_lock_ip` (
  `id` varchar(36) NOT NULL COMMENT '主键ID',
  `IP` varchar(50) NOT NULL COMMENT '被锁定IP',
  `remarks` varchar(500) DEFAULT NULL COMMENT '备注',
  `create_user_id` varchar(36) DEFAULT NULL COMMENT '创建人id',
  `create_date` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_user_id` varchar(36) DEFAULT NULL COMMENT '更新人id',
  `update_date` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_lock_ip` (`IP`) COMMENT '索引_IP锁定表-IP'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tab_lock_ip
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
INSERT INTO `tab_log` VALUES ('00d7133f-3ba8-45e1-bb45-8f45f01ab56a', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在删除数据，删除对象ID为：\n[\"382fb5ec-31b8-41eb-84a7-4ec874bf7585\"]', '删除', '2018-12-04 21:31:05');
INSERT INTO `tab_log` VALUES ('014039a6-554a-447d-8dbc-d5f4c7d77a2f', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在添加数据，数据信息为：\n[{\"remarks\":\"\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543658519097,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543658519097,\"id\":\"d3f2fd52-487e-4d37-8560-435f9e7eca81\",\"name\":\"管理系统首页（增）\",\"resourceId\":\"f87236f6-edf5-4b21-9739-0cdc0472fc5c\",\"operations\":\"CREATE\",\"state\":1,\"describe\":\"\",\"operationList\":[\"CREATE\"]}]', '添加', '2018-12-01 18:01:59');
INSERT INTO `tab_log` VALUES ('05a18655-6152-4239-b017-8d37b8afe430', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543675902000,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543826022132,\"id\":\"03fc5466-eedf-4444-be87-312d5a71245a\",\"name\":\"信息管理\",\"url\":\"\",\"state\":1,\"parentId\":\"f87236f6-edf5-4b21-9739-0cdc0472fc5c\",\"orderNumber\":5,\"level\":1,\"iconStyle\":\"glyphicon glyphicon-send\",\"describe\":\"\"}]', '更新', '2018-12-03 16:33:42');
INSERT INTO `tab_log` VALUES ('10997f9a-e771-449a-b32e-e4b24f3059e8', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在添加数据，数据信息为：\n[{\"id\":\"43fbea5a-d1e0-44d0-b0cf-95b3897463ef\",\"username\":\"admin_test@qq.com\",\"password\":\"63a9f0ea7bb98050796b649e85481845\",\"loginIP\":null,\"unlockedFlag\":1,\"state\":1,\"registerTime\":1543929810751,\"lastLoginTime\":1543929810751,\"authorities\":null,\"enabled\":true,\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true},\"c09b1a67-1ab6-43fc-b1b6-7cd48ad21336,7e0ee84f-216f-41d3-b3b0-832eaea51e79\"]', '添加', '2018-12-04 21:24:18');
INSERT INTO `tab_log` VALUES ('11377012-9b66-49b5-a367-cbc3d33867c6', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在添加数据，数据信息为：\n[{\"remarks\":\"\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543576642138,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543576642138,\"id\":\"7d4b041c-c0c0-49d7-b959-f650194fd236\",\"name\":\"角色管理\",\"url\":\"/webpages/admin/role_list.jsp\",\"state\":1,\"parentId\":\"9ef51893-2a55-4029-b3c1-7890220c90bc\",\"orderNumber\":4,\"level\":2,\"iconStyle\":\"\",\"describe\":\"\"}]', '添加', '2018-11-30 19:17:22');
INSERT INTO `tab_log` VALUES ('1e12b9e6-43b2-407f-8b18-cd13cbd2ea52', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"test\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543313452000,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543313759899,\"id\":\"54f83d8a-c087-4870-a68c-ae585d4e3d25\",\"name\":\"TEST\",\"state\":0,\"describe\":\"test\",\"permissions\":null,\"authority\":\"ROLE_TEST\"}]', '更新', '2018-11-27 18:16:00');
INSERT INTO `tab_log` VALUES ('1f6fbe34-2742-405f-95d2-ccdba0908dce', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543576391000,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543578178286,\"id\":\"9ef51893-2a55-4029-b3c1-7890220c90bc\",\"name\":\"系统管理\",\"url\":\"\",\"state\":1,\"parentId\":\"f87236f6-edf5-4b21-9739-0cdc0472fc5c\",\"orderNumber\":1,\"level\":1,\"iconStyle\":\"layui-icon-set-fill\",\"describe\":\"\"}]', '更新', '2018-11-30 19:42:58');
INSERT INTO `tab_log` VALUES ('20595bc8-2537-4e1d-82f3-8a9be724899e', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"可进入后台管理系统首页，后台管理系统可对网站各个部分进行管理，对网站非常重要，为了系统安全，后台管理系统只能是有管理员权限的人员才能进入！\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543307206000,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543397590616,\"id\":\"d2a220ae-3b26-4611-bd8b-8dee30f74de1\",\"name\":\"后台管理系统首页\",\"url\":\"/webpages/admin/index.jsp\",\"state\":1,\"describe\":\"后台管理系统首页。\"}]', '更新', '2018-11-28 17:33:11');
INSERT INTO `tab_log` VALUES ('20e2ede1-eee9-48fd-b3c4-4375d78d0577', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543826304000,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543828666020,\"id\":\"50774cdc-ebc0-43db-aa45-a8d078d84730\",\"name\":\"用户管理\",\"url\":\"/webpages/admin/user_list.jsp\",\"state\":1,\"parentId\":\"f87236f6-edf5-4b21-9739-0cdc0472fc5c\",\"orderNumber\":6,\"level\":1,\"iconStyle\":\"layui-icon layui-icon-group\",\"describe\":\"\"}]', '更新', '2018-12-03 17:17:46');
INSERT INTO `tab_log` VALUES ('2c59f5bc-841e-4845-b215-e5ebd7327611', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在添加数据，数据信息为：\n[{\"remarks\":\"\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543826303996,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543826303996,\"id\":\"50774cdc-ebc0-43db-aa45-a8d078d84730\",\"name\":\"用户管理\",\"url\":\"/webpages/admin/user_list.jsp\",\"state\":1,\"parentId\":\"f87236f6-edf5-4b21-9739-0cdc0472fc5c\",\"orderNumber\":6,\"level\":1,\"iconStyle\":\"layui-icon layui-icon-user\",\"describe\":\"\"}]', '添加', '2018-12-03 16:38:24');
INSERT INTO `tab_log` VALUES ('2e15945c-058d-447e-9845-35bfe6a6a939', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在添加数据，数据信息为：\n[{\"remarks\":\"测试用户\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543313905903,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543313905903,\"id\":\"3edb62ca-376c-485c-9132-c1b44f22effe\",\"name\":\"TEST\",\"state\":1,\"describe\":\"测试用户\",\"permissions\":null,\"authority\":\"ROLE_TEST\"}]', '添加', '2018-11-27 18:18:26');
INSERT INTO `tab_log` VALUES ('37a4dd42-710a-46d2-876b-9a412c492844', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在添加数据，数据信息为：\n[{\"remarks\":\"系统管理\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543506607463,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543506607463,\"id\":\"044083b7-db2a-4d5b-a58b-12891ef1fa74\",\"name\":\"系统管理\",\"url\":\"\",\"state\":1,\"parentId\":\"044083b7-db2a-4d5b-a58b-12891ef1fa74\",\"orderNumber\":0,\"iconStyle\":\"layui-icon-set-fill\",\"describe\":\"系统管理\"}]', '添加', '2018-11-29 23:50:27');
INSERT INTO `tab_log` VALUES ('3852504e-57a3-47cf-9311-4109ab7a8514', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"test\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543399955000,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543498989485,\"id\":\"cfcab4d4-7cb5-413c-8315-be34d1a05755\",\"name\":\"test\",\"resourceId\":\"396f9846-d0fc-42b0-b267-d8be114e4786\",\"operations\":\"READ,CREATE,UPDATE\",\"state\":1,\"describe\":\"test\",\"operationList\":[\"READ\",\"CREATE\",\"UPDATE\"]}]', '更新', '2018-11-29 21:43:09');
INSERT INTO `tab_log` VALUES ('3a71d11c-3296-4eb1-8533-3b1c6be2d83f', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"test\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543399955000,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543402331605,\"id\":\"cfcab4d4-7cb5-413c-8315-be34d1a05755\",\"name\":\"test\",\"resourceId\":\"396f9846-d0fc-42b0-b267-d8be114e4786\",\"operations\":\"READ,CREATE,UPDATE\",\"state\":0,\"describe\":\"test\",\"operationList\":[\"READ\",\"CREATE\",\"UPDATE\"]}]', '更新', '2018-11-28 18:52:12');
INSERT INTO `tab_log` VALUES ('3c6d039b-96c7-4923-bd9f-f6bebba45b04', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在添加数据，数据信息为：\n[{\"remarks\":\"\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543576436261,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543576436261,\"id\":\"26449d80-ef15-4b4b-be91-e4f9f77e2afc\",\"name\":\"菜单管理\",\"url\":\"/webpages/admin\",\"state\":1,\"parentId\":\"9ef51893-2a55-4029-b3c1-7890220c90bc\",\"orderNumber\":2,\"level\":2,\"iconStyle\":\"\",\"describe\":\"\"}]', '添加', '2018-11-30 19:13:56');
INSERT INTO `tab_log` VALUES ('40f6e1b9-65ae-4684-a7fa-fbb2c187146f', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在删除数据，删除对象ID为：\n[\"dcfd8026-5f94-4270-a271-40922db59ca9\"]', '删除', '2018-12-04 15:00:33');
INSERT INTO `tab_log` VALUES ('44bf2a5b-f565-4ecd-af9a-aff9f85bd645', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在添加数据，数据信息为：\n[{\"remarks\":\"\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543581582220,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543581582220,\"id\":\"c9a6d40c-b917-4e6a-a47d-46010a3f99d7\",\"name\":\"管理系统首页（全）\",\"resourceId\":\"f87236f6-edf5-4b21-9739-0cdc0472fc5c\",\"operations\":\"READ,CREATE,UPDATE,DELETE\",\"state\":1,\"describe\":\"\",\"operationList\":[\"READ\",\"CREATE\",\"UPDATE\",\"DELETE\"]}]', '添加', '2018-11-30 20:39:42');
INSERT INTO `tab_log` VALUES ('461de226-0a95-441c-967a-c6d104ca910a', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在添加数据，数据信息为：\n[{\"remarks\":\"test\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543399954863,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543399954863,\"id\":\"cfcab4d4-7cb5-413c-8315-be34d1a05755\",\"name\":\"test\",\"resourceId\":\"396f9846-d0fc-42b0-b267-d8be114e4786\",\"operations\":\"READ,CREATE,UPDATE\",\"state\":1,\"describe\":\"test\",\"operationList\":[\"READ\",\"CREATE\",\"UPDATE\"]}]', '添加', '2018-11-28 18:12:35');
INSERT INTO `tab_log` VALUES ('4685dad3-5f97-4e7d-9ed6-08df83541266', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543576436000,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543673738625,\"id\":\"26449d80-ef15-4b4b-be91-e4f9f77e2afc\",\"name\":\"菜单管理\",\"url\":\"/webpages/admin/resource_list.jsp\",\"state\":1,\"parentId\":\"9ef51893-2a55-4029-b3c1-7890220c90bc\",\"orderNumber\":2,\"level\":2,\"iconStyle\":\"layui-icon layui-icon-app\",\"describe\":\"\"}]', '更新', '2018-12-01 22:15:39');
INSERT INTO `tab_log` VALUES ('4f968e70-0c33-46c8-a01f-e823e903a8ef', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在添加数据，数据信息为：\n[{\"remarks\":\"\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543580256692,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543580256692,\"id\":\"0a45e984-355b-4f6d-aca9-de5b4128bd78\",\"name\":\"角色管理（读）\",\"resourceId\":\"7d4b041c-c0c0-49d7-b959-f650194fd236\",\"operations\":\"READ\",\"state\":1,\"describe\":\"\",\"operationList\":[\"READ\"]}]', '添加', '2018-11-30 20:17:37');
INSERT INTO `tab_log` VALUES ('5019bf78-19fb-421c-bd79-979165652a78', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在添加数据，数据信息为：\n[{\"remarks\":\"test\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543313321746,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543313321746,\"id\":\"c913a227-5142-46b0-bef1-1ef3bed0c020\",\"name\":\"test\",\"state\":1,\"describe\":\"test\",\"permissions\":null,\"authority\":\"ROLE_test\"}]', '添加', '2018-11-27 18:08:44');
INSERT INTO `tab_log` VALUES ('51e2e28d-e970-4685-85e6-214cf6b1a3cc', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543828633000,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543828810570,\"id\":\"047d43c2-19dd-4dbf-bf6b-316f6c69eb9e\",\"name\":\"管理员管理\",\"url\":\"/webpages/admin/user_list.jsp\",\"state\":1,\"parentId\":\"50774cdc-ebc0-43db-aa45-a8d078d84730\",\"orderNumber\":7,\"level\":2,\"iconStyle\":\"layui-icon layui-icon-friends\",\"describe\":\"\"}]', '更新', '2018-12-03 17:20:11');
INSERT INTO `tab_log` VALUES ('54dcc6e0-75cd-41f9-a52f-4dfe2db249fa', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543576391000,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543578217143,\"id\":\"9ef51893-2a55-4029-b3c1-7890220c90bc\",\"name\":\"系统管理\",\"url\":\"\",\"state\":1,\"parentId\":\"f87236f6-edf5-4b21-9739-0cdc0472fc5c\",\"orderNumber\":1,\"level\":1,\"iconStyle\":\"layui-icon layui-icon-set-fill\",\"describe\":\"\"}]', '更新', '2018-11-30 19:43:37');
INSERT INTO `tab_log` VALUES ('571748ff-9e6d-4453-8c21-b36abdb701fe', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在添加数据，数据信息为：\n[{\"remarks\":\"\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543576346420,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543576346420,\"id\":\"f87236f6-edf5-4b21-9739-0cdc0472fc5c\",\"name\":\"管理系统首页\",\"url\":\"/webpages/admin/index.jsp\",\"state\":1,\"parentId\":\"0\",\"orderNumber\":0,\"level\":0,\"iconStyle\":\"\",\"describe\":\"\"}]', '添加', '2018-11-30 19:12:26');
INSERT INTO `tab_log` VALUES ('5ac7f2a0-d427-4dc8-9d24-376d8f3a6457', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"注：\\n1、菜单管理的主要作用是提供页面的启用与禁用功能，其他功能只是附带，非软件开发专业人员可不随意操作！\\n2、菜单管理实行的是软删除，无法真正删除系统菜单，菜单被删除后会进入已删除状态，作用同禁用。\\n3、菜单添加只能添加系统已经用代码实现了的页面，随意添加其他URL没有效果。\\n4、菜单编辑目前不提供URL的更改，URL关乎到页面的正常显示，不能修改可避免误操作。\\n5、修改菜单名称时，建议名称能有“见名知意”的效果。\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1542816000000,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543397675589,\"id\":\"396f9846-d0fc-42b0-b267-d8be114e4786\",\"name\":\"菜单管理\",\"url\":\"/webpages/admin/resource_list.jsp\",\"state\":1,\"describe\":\"系统菜单管理，即系统页面管理，可管理系统中的所有前后端页面（启用/禁用）。\\n只有启用的页面才能授权给角色，禁用的页面所有角色对其都无权访问。\"}]', '更新', '2018-11-28 17:34:36');
INSERT INTO `tab_log` VALUES ('5e0f2e07-f3be-482c-9fbc-1e675506c8ff', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543826304000,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543828713564,\"id\":\"50774cdc-ebc0-43db-aa45-a8d078d84730\",\"name\":\"用户管理\",\"url\":\"/webpages/admin/user_list.jsp\",\"state\":1,\"parentId\":\"f87236f6-edf5-4b21-9739-0cdc0472fc5c\",\"orderNumber\":6,\"level\":1,\"iconStyle\":\"layui-icon layui-icon-group\",\"describe\":\"\"}]', '更新', '2018-12-03 17:18:34');
INSERT INTO `tab_log` VALUES ('5e6d07f0-6064-42a0-922c-714fcdee2f40', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在添加数据，数据信息为：\n[{\"remarks\":\"\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543832434137,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543832434137,\"id\":\"854d6f60-5a15-4525-8b78-bfb4d6055265\",\"name\":\"用户管理\",\"url\":\"/webpages/admin/user_list.jsp\",\"state\":1,\"parentId\":\"50774cdc-ebc0-43db-aa45-a8d078d84730\",\"orderNumber\":8,\"level\":2,\"iconStyle\":\"layui-icon layui-icon-user\",\"describe\":\"\"}]', '添加', '2018-12-03 18:20:34');
INSERT INTO `tab_log` VALUES ('6026957d-d60e-4cfe-9fa2-5f88705d7d7d', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543576436000,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543671895894,\"id\":\"26449d80-ef15-4b4b-be91-e4f9f77e2afc\",\"name\":\"菜单管理\",\"url\":\"/webpages/admin\",\"state\":1,\"parentId\":\"9ef51893-2a55-4029-b3c1-7890220c90bc\",\"orderNumber\":2,\"level\":2,\"iconStyle\":\"layui-icon layui-icon-app\",\"describe\":\"\"}]', '更新', '2018-12-01 21:44:56');
INSERT INTO `tab_log` VALUES ('67f93161-6089-4358-a343-18860a00894c', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"test\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543313452000,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543313858813,\"id\":\"54f83d8a-c087-4870-a68c-ae585d4e3d25\",\"name\":\"TEST\",\"state\":1,\"describe\":\"test\",\"permissions\":null,\"authority\":\"ROLE_TEST\"}]', '更新', '2018-11-27 18:17:39');
INSERT INTO `tab_log` VALUES ('6fc56adc-f320-4fa4-86d5-80ae818db069', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在添加数据，数据信息为：\n[{\"remarks\":\"后台管理系统可对整个网站进行相关管理，对系统来说非常重要，所以只能是管理员才能进入后台管理系统。\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543308104299,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543308104299,\"id\":\"cdcdd7be-8927-4a99-b77b-daff72df72bf\",\"name\":\"后台管理系统首页（读）\",\"resourceId\":\"d2a220ae-3b26-4611-bd8b-8dee30f74de1\",\"operations\":\"READ\",\"state\":1,\"describe\":\"后台管理系统首页的读权限，即拥有此权限才能进入后台管理系统首页。\",\"operationList\":[\"READ\"]}]', '添加', '2018-11-27 16:41:44');
INSERT INTO `tab_log` VALUES ('72983a0e-480b-475f-9e33-9d99feed6211', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"test\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543399955000,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543399964844,\"id\":\"cfcab4d4-7cb5-413c-8315-be34d1a05755\",\"name\":\"test\",\"resourceId\":\"396f9846-d0fc-42b0-b267-d8be114e4786\",\"operations\":\"READ,CREATE,UPDATE\",\"state\":1,\"describe\":\"test\",\"operationList\":[\"READ\",\"CREATE\",\"UPDATE\"]}]', '更新', '2018-11-28 18:12:45');
INSERT INTO `tab_log` VALUES ('72aba0bc-cc06-46c4-a3ee-80917e169759', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"可进入后台管理系统首页，后台管理系统可对网站各个部分进行管理，对网站非常重要，为了系统安全，后台管理系统只能是有管理员权限的人员才能进入！\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543307206000,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543307437624,\"id\":\"d2a220ae-3b26-4611-bd8b-8dee30f74de1\",\"name\":\"后台管理系统首页\",\"url\":\"/webpages/admin/index.jsp\",\"state\":0,\"describe\":\"后台管理系统首页。\"}]', '更新', '2018-11-27 16:30:53');
INSERT INTO `tab_log` VALUES ('74c4d648-6f06-48ca-bb9d-438b8dd4df5f', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"测试用户\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543313906000,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543917626382,\"id\":\"3edb62ca-376c-485c-9132-c1b44f22effe\",\"name\":\"TEST\",\"state\":1,\"describe\":\"测试用户\",\"permissions\":null,\"authority\":\"ROLE_TEST\"}]', '更新', '2018-12-04 18:00:26');
INSERT INTO `tab_log` VALUES ('752477ae-ee92-4e76-9abf-20239f99ee68', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543576391000,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543577937122,\"id\":\"9ef51893-2a55-4029-b3c1-7890220c90bc\",\"name\":\"系统管理\",\"url\":\"\",\"state\":1,\"parentId\":\"f87236f6-edf5-4b21-9739-0cdc0472fc5c\",\"orderNumber\":1,\"level\":1,\"iconStyle\":\"layui-icon-set-fill\",\"describe\":\"\"}]', '更新', '2018-11-30 19:38:57');
INSERT INTO `tab_log` VALUES ('77d044c1-6eec-46b0-932b-28c749d3d5f6', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"test\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543399955000,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543500966678,\"id\":\"cfcab4d4-7cb5-413c-8315-be34d1a05755\",\"name\":\"test\",\"resourceId\":\"396f9846-d0fc-42b0-b267-d8be114e4786\",\"operations\":\"READ,CREATE,UPDATE\",\"state\":0,\"describe\":\"test\",\"operationList\":[\"READ\",\"CREATE\",\"UPDATE\"]}]', '更新', '2018-11-29 22:16:07');
INSERT INTO `tab_log` VALUES ('7824eb4c-6e9d-4a6f-a7d8-62d826e878c9', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"可进入后台管理系统首页，后台管理系统可对网站各个部分进行管理，对网站非常重要，为了系统安全，后台管理系统只能是有管理员权限的人员才能进入！\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543307206000,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543397611900,\"id\":\"d2a220ae-3b26-4611-bd8b-8dee30f74de1\",\"name\":\"后台管理系统首页\",\"url\":\"/webpages/admin/index.jsp\",\"state\":1,\"describe\":\"后台管理系统首页。\"}]', '更新', '2018-11-28 17:33:32');
INSERT INTO `tab_log` VALUES ('7c0ab177-1fec-4f30-a781-8024154e33ad', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543576491000,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543671816129,\"id\":\"828b5970-ee7a-4ee9-a5d7-bda06480056f\",\"name\":\"权限管理\",\"url\":\"/webpages/admin/permission_list.jsp\",\"state\":1,\"parentId\":\"9ef51893-2a55-4029-b3c1-7890220c90bc\",\"orderNumber\":3,\"level\":2,\"iconStyle\":\"glyphicon glyphicon-lock\",\"describe\":\"\"}]', '更新', '2018-12-01 21:43:36');
INSERT INTO `tab_log` VALUES ('7c47ac4b-9831-4777-b2a1-09848a358ade', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"后台管理系统可对整个网站进行相关管理，对系统来说非常重要，所以只能是管理员才能进入后台管理系统。\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543308104000,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543308144496,\"id\":\"cdcdd7be-8927-4a99-b77b-daff72df72bf\",\"name\":\"后台管理系统首页（读）\",\"resourceId\":\"d2a220ae-3b26-4611-bd8b-8dee30f74de1\",\"operations\":\"READ\",\"state\":0,\"describe\":\"后台管理系统首页的读权限，即拥有此权限才能进入后台管理系统首页。\",\"operationList\":[\"READ\"]}]', '更新', '2018-11-27 16:42:25');
INSERT INTO `tab_log` VALUES ('7d12d973-b5fb-40cf-837b-c53022379f53', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在添加数据，数据信息为：\n[{\"remarks\":\"\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543576491357,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543576491357,\"id\":\"828b5970-ee7a-4ee9-a5d7-bda06480056f\",\"name\":\"权限管理\",\"url\":\"/webpages/admin/permission_list.jsp\",\"state\":1,\"parentId\":\"9ef51893-2a55-4029-b3c1-7890220c90bc\",\"orderNumber\":3,\"level\":2,\"iconStyle\":\"\",\"describe\":\"\"}]', '添加', '2018-11-30 19:14:51');
INSERT INTO `tab_log` VALUES ('7d896887-d1c8-4938-b519-9e4c0398de6c', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543576391000,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543671562091,\"id\":\"9ef51893-2a55-4029-b3c1-7890220c90bc\",\"name\":\"系统管理\",\"url\":\"\",\"state\":1,\"parentId\":\"f87236f6-edf5-4b21-9739-0cdc0472fc5c\",\"orderNumber\":1,\"level\":1,\"iconStyle\":\"glyphicon glyphicon-cog\",\"describe\":\"\"}]', '更新', '2018-12-01 21:39:22');
INSERT INTO `tab_log` VALUES ('866ffa57-3b53-4193-94e9-6856c88714bb', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"测试用户\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543313906000,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543401420357,\"id\":\"3edb62ca-376c-485c-9132-c1b44f22effe\",\"name\":\"TEST\",\"state\":0,\"describe\":\"测试用户\",\"permissions\":null,\"authority\":\"ROLE_TEST\"}]', '更新', '2018-11-28 18:37:00');
INSERT INTO `tab_log` VALUES ('884b62fe-41cb-4abe-9d7e-b5beb5e044dc', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在添加数据，数据信息为：\n[{\"remarks\":null,\"createUserId\":null,\"createDate\":null,\"updateUserId\":null,\"updateDate\":null,\"id\":\"e204de29-86ef-4a8e-a30a-6eba14dd4538\",\"ip\":\"0:0:0:0:0:0:0:1\"}]', '添加', '2018-12-03 23:59:41');
INSERT INTO `tab_log` VALUES ('8d641878-f1be-49e0-b75e-8e594c3b21b2', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"test\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543313452000,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543313705697,\"id\":\"54f83d8a-c087-4870-a68c-ae585d4e3d25\",\"name\":\"TEST\",\"state\":1,\"describe\":\"test\",\"permissions\":null,\"authority\":\"ROLE_TEST\"}]', '更新', '2018-11-27 18:15:06');
INSERT INTO `tab_log` VALUES ('8df969a9-1ed9-49af-a3d8-f6a1dd266ed9', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在添加数据，数据信息为：\n[{\"remarks\":\"\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543576391134,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543576391134,\"id\":\"9ef51893-2a55-4029-b3c1-7890220c90bc\",\"name\":\"系统管理\",\"url\":\"\",\"state\":1,\"parentId\":\"f87236f6-edf5-4b21-9739-0cdc0472fc5c\",\"orderNumber\":1,\"level\":1,\"iconStyle\":\"\",\"describe\":\"\"}]', '添加', '2018-11-30 19:13:11');
INSERT INTO `tab_log` VALUES ('8e5c0072-5495-4f1c-85bb-6510a464d594', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在添加数据，数据信息为：\n[{\"remarks\":\"测试\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543572651180,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543572651180,\"id\":\"91427c55-c07f-4b8e-abf1-849ca7db54df\",\"name\":\"后台管理系统首页（全）\",\"resourceId\":\"d2a220ae-3b26-4611-bd8b-8dee30f74de1\",\"operations\":\"READ,CREATE,UPDATE,DELETE\",\"state\":1,\"describe\":\"测试\",\"operationList\":[\"READ\",\"CREATE\",\"UPDATE\",\"DELETE\"]}]', '添加', '2018-11-30 18:10:51');
INSERT INTO `tab_log` VALUES ('8ee10111-0107-4246-b734-f1436ecfba64', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在添加数据，数据信息为：\n[{\"remarks\":\"\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543580190618,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543580190618,\"id\":\"beae122d-2306-42a6-9000-9024bdd7553c\",\"name\":\"菜单管理（读）\",\"resourceId\":\"26449d80-ef15-4b4b-be91-e4f9f77e2afc\",\"operations\":\"READ\",\"state\":1,\"describe\":\"\",\"operationList\":[\"READ\"]}]', '添加', '2018-11-30 20:16:31');
INSERT INTO `tab_log` VALUES ('9175c2c7-b5ae-43a4-95e4-2b052099a166', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在添加数据，数据信息为：\n[{\"remarks\":\"test\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543313451621,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543313451621,\"id\":\"54f83d8a-c087-4870-a68c-ae585d4e3d25\",\"name\":\"test\",\"state\":1,\"describe\":\"test\",\"permissions\":null,\"authority\":\"ROLE_test\"}]', '添加', '2018-11-27 18:10:53');
INSERT INTO `tab_log` VALUES ('91858bbd-a678-4d9d-872c-8760fd8729fe', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"test\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543313452000,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543313861660,\"id\":\"54f83d8a-c087-4870-a68c-ae585d4e3d25\",\"name\":\"TEST\",\"state\":0,\"describe\":\"test\",\"permissions\":null,\"authority\":\"ROLE_TEST\"}]', '更新', '2018-11-27 18:17:42');
INSERT INTO `tab_log` VALUES ('a01dee0e-fcc0-41d6-a1c1-605e8876b98e', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在添加数据，数据信息为：\n[{\"remarks\":null,\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543853864262,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543853864262,\"id\":\"5cb9e45c-48d5-463b-a92e-d0a6eb4b6003\",\"ip\":\"0:0:0:0:0:0:0:1\"}]', '添加', '2018-12-04 00:17:44');
INSERT INTO `tab_log` VALUES ('a21f826c-9333-4e21-a813-4c5be55628c5', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543576391000,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543577928729,\"id\":\"9ef51893-2a55-4029-b3c1-7890220c90bc\",\"name\":\"系统管理\",\"url\":\"\",\"state\":1,\"parentId\":\"f87236f6-edf5-4b21-9739-0cdc0472fc5c\",\"orderNumber\":1,\"level\":1,\"iconStyle\":\"layui-icon-set-fill\",\"describe\":\"\"}]', '更新', '2018-11-30 19:38:49');
INSERT INTO `tab_log` VALUES ('a2a67d54-b5ed-45db-8efd-fc6126042f36', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在删除数据，删除对象ID为：\n[\"76557876-b09b-4c66-9bcf-400400aad2c9\"]', '删除', '2018-12-04 00:12:33');
INSERT INTO `tab_log` VALUES ('ab1a0b6f-39d3-459c-ae4f-af701d99cb6f', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543828633000,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543832327517,\"id\":\"047d43c2-19dd-4dbf-bf6b-316f6c69eb9e\",\"name\":\"管理员管理\",\"url\":\"/webpages/admin/user_admin.jsp\",\"state\":1,\"parentId\":\"50774cdc-ebc0-43db-aa45-a8d078d84730\",\"orderNumber\":7,\"level\":2,\"iconStyle\":\"layui-icon layui-icon-friends\",\"describe\":\"\"}]', '更新', '2018-12-03 18:18:48');
INSERT INTO `tab_log` VALUES ('b031f627-c688-4be1-9aec-ff1c9a7d46e5', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"test\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543399955000,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543498991308,\"id\":\"cfcab4d4-7cb5-413c-8315-be34d1a05755\",\"name\":\"test\",\"resourceId\":\"396f9846-d0fc-42b0-b267-d8be114e4786\",\"operations\":\"READ,CREATE,UPDATE\",\"state\":1,\"describe\":\"test\",\"operationList\":[\"READ\",\"CREATE\",\"UPDATE\"]}]', '更新', '2018-11-29 21:43:11');
INSERT INTO `tab_log` VALUES ('b0b73047-e93e-462d-86d5-909ef0650058', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"后台管理系统可对整个网站进行相关管理，对系统来说非常重要，所以只能是管理员才能进入后台管理系统。\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543308104000,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543402319637,\"id\":\"cdcdd7be-8927-4a99-b77b-daff72df72bf\",\"name\":\"后台管理系统首页（读）\",\"resourceId\":\"d2a220ae-3b26-4611-bd8b-8dee30f74de1\",\"operations\":\"READ\",\"state\":1,\"describe\":\"后台管理系统首页的读权限，即拥有此权限才能进入后台管理系统首页。\",\"operationList\":[\"READ\"]}]', '更新', '2018-11-28 18:52:00');
INSERT INTO `tab_log` VALUES ('b0c2789a-d371-4622-92c6-5c3dbbc25ec3', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在添加数据，数据信息为：\n[{\"remarks\":\"\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543578445886,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543578445886,\"id\":\"74203a7f-afe9-41ff-9371-808107003ab4\",\"name\":\"管理系统首页（读）\",\"resourceId\":\"f87236f6-edf5-4b21-9739-0cdc0472fc5c\",\"operations\":\"READ\",\"state\":1,\"describe\":\"\",\"operationList\":[\"READ\"]}]', '添加', '2018-11-30 19:47:26');
INSERT INTO `tab_log` VALUES ('b1a5ae3f-23f0-4ce9-a66c-542e95efa7f5', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"测试用户\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543313906000,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543677360474,\"id\":\"3edb62ca-376c-485c-9132-c1b44f22effe\",\"name\":\"TEST\",\"state\":1,\"describe\":\"测试用户\",\"permissions\":null,\"authority\":\"ROLE_TEST\"}]', '更新', '2018-12-01 23:16:00');
INSERT INTO `tab_log` VALUES ('b1e54212-2608-487e-86ac-d22a7572bd49', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在添加数据，数据信息为：\n[{\"remarks\":\"\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543590990261,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543590990261,\"id\":\"adb8731c-1f0f-4269-9d39-91696f040715\",\"name\":\"管理系统首页（添加）\",\"resourceId\":\"f87236f6-edf5-4b21-9739-0cdc0472fc5c\",\"operations\":\"CREATE\",\"state\":1,\"describe\":\"\",\"operationList\":[\"CREATE\"]}]', '添加', '2018-11-30 23:16:30');
INSERT INTO `tab_log` VALUES ('b229b777-8f38-4f48-8b6c-4cd9fd588c4f', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543576391000,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543577957923,\"id\":\"9ef51893-2a55-4029-b3c1-7890220c90bc\",\"name\":\"系统管理\",\"url\":\"\",\"state\":1,\"parentId\":\"f87236f6-edf5-4b21-9739-0cdc0472fc5c\",\"orderNumber\":1,\"level\":1,\"iconStyle\":\"layui-icon-set-fill\",\"describe\":\"\"}]', '更新', '2018-11-30 19:39:18');
INSERT INTO `tab_log` VALUES ('b821404d-f05f-42e6-8350-17f4813e3b00', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543826304000,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543828742217,\"id\":\"50774cdc-ebc0-43db-aa45-a8d078d84730\",\"name\":\"用户管理\",\"url\":\"null\",\"state\":1,\"parentId\":\"f87236f6-edf5-4b21-9739-0cdc0472fc5c\",\"orderNumber\":6,\"level\":1,\"iconStyle\":\"layui-icon layui-icon-group\",\"describe\":\"\"}]', '更新', '2018-12-03 17:19:02');
INSERT INTO `tab_log` VALUES ('b83a5886-a0d9-4d35-90ae-7394b7f6fd07', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543576436000,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543671876120,\"id\":\"26449d80-ef15-4b4b-be91-e4f9f77e2afc\",\"name\":\"菜单管理\",\"url\":\"/webpages/admin\",\"state\":1,\"parentId\":\"9ef51893-2a55-4029-b3c1-7890220c90bc\",\"orderNumber\":2,\"level\":2,\"iconStyle\":\"layui-icon-app\",\"describe\":\"\"}]', '更新', '2018-12-01 21:44:36');
INSERT INTO `tab_log` VALUES ('be39f73c-ba6e-4a2e-bc9a-e84596243060', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543590990000,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543590990000,\"id\":\"adb8731c-1f0f-4269-9d39-91696f040715\",\"name\":\"管理系统首页（添加）\",\"resourceId\":\"f87236f6-edf5-4b21-9739-0cdc0472fc5c\",\"operations\":\"READ,CREATE\",\"state\":1,\"describe\":\"\",\"operationList\":[\"READ\",\"CREATE\"]}]', '更新', '2018-11-30 23:23:45');
INSERT INTO `tab_log` VALUES ('c014e0c4-69aa-4cd6-a6d8-f47681287cf7', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543832434000,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543832496245,\"id\":\"854d6f60-5a15-4525-8b78-bfb4d6055265\",\"name\":\"所有用户管理\",\"url\":\"/webpages/admin/user_list.jsp\",\"state\":1,\"parentId\":\"50774cdc-ebc0-43db-aa45-a8d078d84730\",\"orderNumber\":8,\"level\":2,\"iconStyle\":\"layui-icon layui-icon-user\",\"describe\":\"\"}]', '更新', '2018-12-03 18:21:36');
INSERT INTO `tab_log` VALUES ('c6507286-8a22-46f8-a36b-4ab92f704fac', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在添加数据，数据信息为：\n[{\"remarks\":\"可进入后台管理系统首页，后台管理系统可对网站各个部分进行管理，对网站非常重要，为了系统安全，后台管理系统只能是有管理员权限的人员才能进入！\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543307206350,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543307207353,\"id\":\"d2a220ae-3b26-4611-bd8b-8dee30f74de1\",\"name\":\"后台管理系统首页\",\"url\":\"/webpages/admin/index.jsp\",\"state\":1,\"describe\":\"后台管理系统首页。\"}]', '添加', '2018-11-27 16:27:04');
INSERT INTO `tab_log` VALUES ('d5fdc5fb-12d4-4526-ab9f-55a128ebcda2', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543576642000,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543671684526,\"id\":\"7d4b041c-c0c0-49d7-b959-f650194fd236\",\"name\":\"角色管理\",\"url\":\"/webpages/admin/role_list.jsp\",\"state\":1,\"parentId\":\"9ef51893-2a55-4029-b3c1-7890220c90bc\",\"orderNumber\":4,\"level\":2,\"iconStyle\":\"glyphicon glyphicon-user\",\"describe\":\"\"}]', '更新', '2018-12-01 21:41:25');
INSERT INTO `tab_log` VALUES ('d6462f40-0a68-446c-a7d2-aa8365f4f51f', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在添加数据，数据信息为：\n[{\"remarks\":null,\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543906830289,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543906830289,\"id\":\"dcfd8026-5f94-4270-a271-40922db59ca9\",\"ip\":\"0:0:0:0:0:0:0:1\"}]', '添加', '2018-12-04 15:00:30');
INSERT INTO `tab_log` VALUES ('d6db4e3b-49d7-42ac-b0b0-82528f3147e2', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在添加数据，数据信息为：\n[{\"remarks\":\"test\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543313102356,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543313102356,\"id\":\"7719c9b9-0f3d-42a7-979f-1ab04cf703a1\",\"name\":\"test\",\"state\":1,\"describe\":\"test\",\"permissions\":null,\"authority\":\"ROLE_test\"}]', '添加', '2018-11-27 18:05:24');
INSERT INTO `tab_log` VALUES ('d978a74e-84f3-4843-8c27-0de36025d96a', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在删除数据，删除对象ID为：\n[\"5cb9e45c-48d5-463b-a92e-d0a6eb4b6003\"]', '删除', '2018-12-04 00:17:47');
INSERT INTO `tab_log` VALUES ('daaaa15f-61ad-49e1-8d30-30fa5b13a797', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在添加数据，数据信息为：\n[{\"remarks\":null,\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543853504336,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543853505149,\"id\":\"76557876-b09b-4c66-9bcf-400400aad2c9\",\"ip\":\"0:0:0:0:0:0:0:1\"}]', '添加', '2018-12-04 00:11:46');
INSERT INTO `tab_log` VALUES ('dd1a824c-4ff6-4c68-a732-aee0ae415092', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"test\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543399955000,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543500964259,\"id\":\"cfcab4d4-7cb5-413c-8315-be34d1a05755\",\"name\":\"test\",\"resourceId\":\"396f9846-d0fc-42b0-b267-d8be114e4786\",\"operations\":\"READ,CREATE,UPDATE\",\"state\":1,\"describe\":\"test\",\"operationList\":[\"READ\",\"CREATE\",\"UPDATE\"]}]', '更新', '2018-11-29 22:16:04');
INSERT INTO `tab_log` VALUES ('e33dd964-7f94-48f2-a247-cfd397e0c7a5', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543590990000,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543590990000,\"id\":\"adb8731c-1f0f-4269-9d39-91696f040715\",\"name\":\"管理系统首页（添加）\",\"resourceId\":\"f87236f6-edf5-4b21-9739-0cdc0472fc5c\",\"operations\":\"CREATE,READ\",\"state\":1,\"describe\":\"\",\"operationList\":[\"CREATE\",\"READ\"]}]', '更新', '2018-11-30 23:28:33');
INSERT INTO `tab_log` VALUES ('e4814e8f-f0da-4987-a46f-80984fb2fa2c', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在添加数据，数据信息为：\n[{\"remarks\":\"\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543675902076,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543675902076,\"id\":\"03fc5466-eedf-4444-be87-312d5a71245a\",\"name\":\"信息管理\",\"url\":\"\",\"state\":1,\"parentId\":\"f87236f6-edf5-4b21-9739-0cdc0472fc5c\",\"orderNumber\":6,\"level\":1,\"iconStyle\":\"glyphicon glyphicon-send\",\"describe\":\"\"}]', '添加', '2018-12-01 22:51:42');
INSERT INTO `tab_log` VALUES ('e5b91dec-4a3d-453d-b836-943f042c1d18', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在添加数据，数据信息为：\n[{\"remarks\":\"\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543541659311,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543541659311,\"id\":\"2639dd57-361d-4ea3-bd2a-b936968ff8ce\",\"name\":\"权限管理\",\"url\":\"/webpages/admin/permission_list.jsp\",\"state\":1,\"parentId\":\"044083b7-db2a-4d5b-a58b-12891ef1fa74\",\"orderNumber\":2,\"level\":1,\"iconStyle\":\"\",\"describe\":\"\"}]', '添加', '2018-11-30 09:34:19');
INSERT INTO `tab_log` VALUES ('ea15d8e0-83cb-426b-9be0-bc153387de42', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543576346000,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543671455716,\"id\":\"f87236f6-edf5-4b21-9739-0cdc0472fc5c\",\"name\":\"管理系统首页\",\"url\":\"/webpages/admin/index.jsp\",\"state\":1,\"parentId\":\"0\",\"orderNumber\":0,\"level\":0,\"iconStyle\":\"glyphicon glyphicon-home\",\"describe\":\"\"}]', '更新', '2018-12-01 21:37:36');
INSERT INTO `tab_log` VALUES ('ea174ef6-4d45-4596-9094-9aec401f998d', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在添加数据，数据信息为：\n[{\"remarks\":\"\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543828633110,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543828633110,\"id\":\"047d43c2-19dd-4dbf-bf6b-316f6c69eb9e\",\"name\":\"管理员用户管理\",\"url\":\"/webpages/admin/user_list.jsp\",\"state\":1,\"parentId\":\"50774cdc-ebc0-43db-aa45-a8d078d84730\",\"orderNumber\":7,\"level\":2,\"iconStyle\":\"layui-icon layui-icon-friends\",\"describe\":\"\"}]', '添加', '2018-12-03 17:17:13');
INSERT INTO `tab_log` VALUES ('eba31f5b-b2e6-42e9-8587-011a76b48ec5', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"test\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543313452000,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543313530981,\"id\":\"54f83d8a-c087-4870-a68c-ae585d4e3d25\",\"name\":\"TEST\",\"state\":1,\"describe\":\"test\",\"permissions\":null,\"authority\":\"ROLE_TEST\"}]', '更新', '2018-11-27 18:12:11');
INSERT INTO `tab_log` VALUES ('ed108d79-b78b-443b-8d3e-8baa9535d4c6', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"test\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543399955000,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543399960453,\"id\":\"cfcab4d4-7cb5-413c-8315-be34d1a05755\",\"name\":\"test\",\"resourceId\":\"396f9846-d0fc-42b0-b267-d8be114e4786\",\"operations\":\"READ,CREATE,UPDATE\",\"state\":0,\"describe\":\"test\",\"operationList\":[\"READ\",\"CREATE\",\"UPDATE\"]}]', '更新', '2018-11-28 18:12:40');
INSERT INTO `tab_log` VALUES ('f1a7e7bf-cdb6-4b1e-a7fa-406f4f6903de', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在添加数据，数据信息为：\n[{\"remarks\":\"\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543580221557,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543580221557,\"id\":\"f0e4a234-32b7-40d9-8ad6-2a24aa4af58c\",\"name\":\"权限管理（读）\",\"resourceId\":\"828b5970-ee7a-4ee9-a5d7-bda06480056f\",\"operations\":\"READ\",\"state\":1,\"describe\":\"\",\"operationList\":[\"READ\"]}]', '添加', '2018-11-30 20:17:02');
INSERT INTO `tab_log` VALUES ('f5afd00f-e75d-4aeb-9fc3-3ae58571f759', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543832434000,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543921307233,\"id\":\"854d6f60-5a15-4525-8b78-bfb4d6055265\",\"name\":\"普通用户管理\",\"url\":\"/webpages/admin/user_list.jsp\",\"state\":1,\"parentId\":\"50774cdc-ebc0-43db-aa45-a8d078d84730\",\"orderNumber\":8,\"level\":2,\"iconStyle\":\"layui-icon layui-icon-user\",\"describe\":\"\"}]', '更新', '2018-12-04 19:01:47');
INSERT INTO `tab_log` VALUES ('f82379d6-dd08-49fe-9b58-3985f180e1c0', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在添加数据，数据信息为：\n[{\"remarks\":null,\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543930260056,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543930260056,\"id\":\"382fb5ec-31b8-41eb-84a7-4ec874bf7585\",\"ip\":\"0:0:0:0:0:0:0:1\"}]', '添加', '2018-12-04 21:31:00');
INSERT INTO `tab_log` VALUES ('f8e8be82-33dd-4929-98cd-db52b08d3ea7', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"测试用户\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543313906000,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543677364439,\"id\":\"3edb62ca-376c-485c-9132-c1b44f22effe\",\"name\":\"TEST\",\"state\":0,\"describe\":\"测试用户\",\"permissions\":null,\"authority\":\"ROLE_TEST\"}]', '更新', '2018-12-01 23:16:04');
INSERT INTO `tab_log` VALUES ('fb04a327-33ad-4f8a-a099-0f20dee25a9e', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在添加数据，数据信息为：\n[{\"remarks\":\"\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1543578539645,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1543578539645,\"id\":\"28f948b5-b5fa-4ebc-b964-87a5488adbc8\",\"name\":\"系统管理（读）\",\"resourceId\":\"9ef51893-2a55-4029-b3c1-7890220c90bc\",\"operations\":\"READ\",\"state\":1,\"describe\":\"\",\"operationList\":[\"READ\"]}]', '添加', '2018-11-30 19:49:00');

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
  `state` int(2) DEFAULT '1' COMMENT '使用状态（1：已启用，0已禁用）',
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
INSERT INTO `tab_permission` VALUES ('0a45e984-355b-4f6d-aca9-de5b4128bd78', '角色管理（读）', '7d4b041c-c0c0-49d7-b959-f650194fd236', 'READ', '1', '', '', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '2018-11-30 20:17:37', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '2018-11-30 20:17:37');
INSERT INTO `tab_permission` VALUES ('28f948b5-b5fa-4ebc-b964-87a5488adbc8', '系统管理（读）', '9ef51893-2a55-4029-b3c1-7890220c90bc', 'READ', '1', '', '', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '2018-11-30 19:49:00', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '2018-11-30 19:49:00');
INSERT INTO `tab_permission` VALUES ('74203a7f-afe9-41ff-9371-808107003ab4', '管理系统首页（读）', 'f87236f6-edf5-4b21-9739-0cdc0472fc5c', 'READ', '1', '', '', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '2018-11-30 19:47:26', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '2018-11-30 19:47:26');
INSERT INTO `tab_permission` VALUES ('beae122d-2306-42a6-9000-9024bdd7553c', '菜单管理（读）', '26449d80-ef15-4b4b-be91-e4f9f77e2afc', 'READ', '1', '', '', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '2018-11-30 20:16:31', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '2018-11-30 20:16:31');
INSERT INTO `tab_permission` VALUES ('d3f2fd52-487e-4d37-8560-435f9e7eca81', '管理系统首页（增）', 'f87236f6-edf5-4b21-9739-0cdc0472fc5c', 'CREATE', '1', '', '', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '2018-12-01 18:01:59', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '2018-12-01 18:01:59');
INSERT INTO `tab_permission` VALUES ('f0e4a234-32b7-40d9-8ad6-2a24aa4af58c', '权限管理（读）', '828b5970-ee7a-4ee9-a5d7-bda06480056f', 'READ', '1', '', '', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '2018-11-30 20:17:02', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '2018-11-30 20:17:02');

-- ----------------------------
-- Table structure for tab_resource
-- ----------------------------
DROP TABLE IF EXISTS `tab_resource`;
CREATE TABLE `tab_resource` (
  `id` varchar(36) NOT NULL COMMENT '主键ID',
  `name` varchar(100) NOT NULL COMMENT '资源名称',
  `url` varchar(100) DEFAULT NULL COMMENT '资源对应URL',
  `state` int(2) DEFAULT '1' COMMENT '使用状态（1：已启用，0已禁用）',
  `parent_id` varchar(36) NOT NULL COMMENT '父级菜单的id，若为自己，则该菜单为顶级菜单',
  `order_number` int(2) NOT NULL COMMENT '菜单排序',
  `level` int(2) NOT NULL COMMENT '当前菜单所处的层级',
  `icon_style` varchar(50) DEFAULT NULL COMMENT '图标样式',
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
INSERT INTO `tab_resource` VALUES ('03fc5466-eedf-4444-be87-312d5a71245a', '信息管理', '', '1', 'f87236f6-edf5-4b21-9739-0cdc0472fc5c', '5', '1', 'glyphicon glyphicon-send', '', '', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '2018-12-01 22:51:42', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '2018-12-03 16:33:42');
INSERT INTO `tab_resource` VALUES ('047d43c2-19dd-4dbf-bf6b-316f6c69eb9e', '管理员管理', '/webpages/admin/user_admin.jsp', '1', '50774cdc-ebc0-43db-aa45-a8d078d84730', '7', '2', 'layui-icon layui-icon-friends', '', '', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '2018-12-03 17:17:13', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '2018-12-03 18:18:48');
INSERT INTO `tab_resource` VALUES ('26449d80-ef15-4b4b-be91-e4f9f77e2afc', '菜单管理', '/webpages/admin/resource_list.jsp', '1', '9ef51893-2a55-4029-b3c1-7890220c90bc', '2', '2', 'layui-icon layui-icon-app', '', '', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '2018-11-30 19:13:56', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '2018-12-01 22:15:39');
INSERT INTO `tab_resource` VALUES ('50774cdc-ebc0-43db-aa45-a8d078d84730', '用户管理', 'null', '1', 'f87236f6-edf5-4b21-9739-0cdc0472fc5c', '6', '1', 'layui-icon layui-icon-group', '', '', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '2018-12-03 16:38:24', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '2018-12-03 17:19:02');
INSERT INTO `tab_resource` VALUES ('7d4b041c-c0c0-49d7-b959-f650194fd236', '角色管理', '/webpages/admin/role_list.jsp', '1', '9ef51893-2a55-4029-b3c1-7890220c90bc', '4', '2', 'glyphicon glyphicon-user', '', '', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '2018-11-30 19:17:22', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '2018-12-01 21:41:25');
INSERT INTO `tab_resource` VALUES ('828b5970-ee7a-4ee9-a5d7-bda06480056f', '权限管理', '/webpages/admin/permission_list.jsp', '1', '9ef51893-2a55-4029-b3c1-7890220c90bc', '3', '2', 'glyphicon glyphicon-lock', '', '', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '2018-11-30 19:14:51', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '2018-12-01 21:43:36');
INSERT INTO `tab_resource` VALUES ('854d6f60-5a15-4525-8b78-bfb4d6055265', '普通用户管理', '/webpages/admin/user_list.jsp', '1', '50774cdc-ebc0-43db-aa45-a8d078d84730', '8', '2', 'layui-icon layui-icon-user', '', '', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '2018-12-03 18:20:34', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '2018-12-04 19:01:47');
INSERT INTO `tab_resource` VALUES ('9ef51893-2a55-4029-b3c1-7890220c90bc', '系统管理', '', '1', 'f87236f6-edf5-4b21-9739-0cdc0472fc5c', '1', '1', 'glyphicon glyphicon-cog', '', '', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '2018-11-30 19:13:11', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '2018-12-01 21:39:22');
INSERT INTO `tab_resource` VALUES ('f87236f6-edf5-4b21-9739-0cdc0472fc5c', '管理系统首页', '/webpages/admin/index.jsp', '1', '0', '0', '0', 'glyphicon glyphicon-home', '', '', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '2018-11-30 19:12:26', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '2018-12-01 21:37:36');

-- ----------------------------
-- Table structure for tab_role
-- ----------------------------
DROP TABLE IF EXISTS `tab_role`;
CREATE TABLE `tab_role` (
  `id` varchar(36) NOT NULL COMMENT '主键ID',
  `name` varchar(100) NOT NULL COMMENT '角色名称',
  `state` int(2) DEFAULT '1' COMMENT '使用状态（1：已启用，0已禁用）',
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
INSERT INTO `tab_role` VALUES ('3edb62ca-376c-485c-9132-c1b44f22effe', 'TEST', '1', '测试用户', '测试用户', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '2018-11-27 18:18:26', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '2018-12-04 18:00:26');
INSERT INTO `tab_role` VALUES ('7e0ee84f-216f-41d3-b3b0-832eaea51e79', 'USER', '1', '普通用户角色', '普通用户角色，在用户注册时会默认添加', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '2018-11-18 00:00:00', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '2018-11-27 17:22:33');
INSERT INTO `tab_role` VALUES ('c09b1a67-1ab6-43fc-b1b6-7cd48ad21336', 'ADMIN', '1', '超级管理员角色', '超级管理员', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '2018-11-18 00:00:00', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '2018-11-27 17:22:36');

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
INSERT INTO `tab_role_permission` VALUES ('51a64d7b-3d41-4311-ac34-ab7bd21cc8ba', 'c09b1a67-1ab6-43fc-b1b6-7cd48ad21336', '0a45e984-355b-4f6d-aca9-de5b4128bd78');
INSERT INTO `tab_role_permission` VALUES ('052d3140-de07-4c3b-8edd-c6cdb8a8e805', 'c09b1a67-1ab6-43fc-b1b6-7cd48ad21336', '28f948b5-b5fa-4ebc-b964-87a5488adbc8');
INSERT INTO `tab_role_permission` VALUES ('0bd6f8fb-eda0-426b-bde0-13a10bcc2fa7', 'c09b1a67-1ab6-43fc-b1b6-7cd48ad21336', '74203a7f-afe9-41ff-9371-808107003ab4');
INSERT INTO `tab_role_permission` VALUES ('f5a3eb22-2cf1-49c4-a72f-b5a628d78931', 'c09b1a67-1ab6-43fc-b1b6-7cd48ad21336', 'beae122d-2306-42a6-9000-9024bdd7553c');
INSERT INTO `tab_role_permission` VALUES ('5e75b58b-078e-4d35-a6a6-d3f8f9a004ea', 'c09b1a67-1ab6-43fc-b1b6-7cd48ad21336', 'f0e4a234-32b7-40d9-8ad6-2a24aa4af58c');

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
INSERT INTO `tab_user` VALUES ('43fbea5a-d1e0-44d0-b0cf-95b3897463ef', 'admin_test@qq.com', '63a9f0ea7bb98050796b649e85481845', null, '1', '1', '2018-12-04 21:23:31', '2018-12-04 21:23:31');
INSERT INTO `tab_user` VALUES ('d6a00d9d-2801-45c3-a99f-326e2949e2f2', 'admin@qq.com', '63a9f0ea7bb98050796b649e85481845', '0:0:0:0:0:0:0:1', '1', '1', '2018-11-18 00:00:00', '2018-12-04 21:30:28');
INSERT INTO `tab_user` VALUES ('f40b6507-7561-4fa6-b3a7-749ce67d200c', 'test@qq.com', '63a9f0ea7bb98050796b649e85481845', '0:0:0:0:0:0:0:1', '1', '1', '2018-12-04 19:00:42', '2018-12-04 19:00:42');

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
INSERT INTO `tab_user_info` VALUES ('b2f4d5c3-21ac-4e8e-8580-70263800cc2b', 'test@qq.com', 'test@qq.com', null, null, '1', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `tab_user_info` VALUES ('b945bd29-97dc-4f9b-9087-adf6a1dba981', 'admin_test@qq.com', 'admin_test@qq.com', null, null, '1', null, null, null, null, null, null, null, null, null, null, null);

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
INSERT INTO `tab_user_role` VALUES ('5204008e-6668-4f5f-971a-0abb6b0d8512', '43fbea5a-d1e0-44d0-b0cf-95b3897463ef', '7e0ee84f-216f-41d3-b3b0-832eaea51e79');
INSERT INTO `tab_user_role` VALUES ('78c776ef-a23b-42a7-925d-8df7981b31eb', '43fbea5a-d1e0-44d0-b0cf-95b3897463ef', 'c09b1a67-1ab6-43fc-b1b6-7cd48ad21336');
INSERT INTO `tab_user_role` VALUES ('a53ccb57-ca3d-4d76-a1a0-40efa11ce340', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '7e0ee84f-216f-41d3-b3b0-832eaea51e79');
INSERT INTO `tab_user_role` VALUES ('a53ccb57-ca3d-4d76-a1a0-40efa11ce347', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', 'c09b1a67-1ab6-43fc-b1b6-7cd48ad21336');
INSERT INTO `tab_user_role` VALUES ('373c4430-049c-4033-babe-7912365f863b', 'f40b6507-7561-4fa6-b3a7-749ce67d200c', '7e0ee84f-216f-41d3-b3b0-832eaea51e79');
