/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50718
Source Host           : localhost:3306
Source Database       : trainingcenter

Target Server Type    : MYSQL
Target Server Version : 50718
File Encoding         : 65001

Date: 2018-11-23 17:11:31
*/

SET FOREIGN_KEY_CHECKS=0;

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
INSERT INTO `tab_log` VALUES ('11d25e11-a5d7-4197-aeca-78cd224e8862', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"id\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"username\":\"admin@qq.com\",\"password\":\"63a9f0ea7bb98050796b649e85481845\",\"loginIP\":\"0:0:0:0:0:0:0:1\",\"unlockedFlag\":1,\"state\":1,\"registerTime\":1542470400000,\"lastLoginTime\":1542874276978,\"authorities\":[{\"remarks\":\"普通用户角色，在用户注册时会默认添加\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"7e0ee84f-216f-41d3-b3b0-832eaea51e79\",\"name\":\"USER\",\"describe\":\"普通用户角色\",\"permissions\":[],\"authority\":\"ROLE_USER\"},{\"remarks\":\"超级管理员\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"c09b1a67-1ab6-43fc-b1b6-7cd48ad21336\",\"name\":\"ADMIN\",\"describe\":\"超级管理员角色\",\"permissions\":[],\"authority\":\"ROLE_ADMIN\"}],\"enabled\":true,\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true}]', '更新', '2018-11-22 00:00:00');
INSERT INTO `tab_log` VALUES ('12a05564-5a4b-4fca-8b31-62326e5117f7', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"注：\\n1、菜单管理的主要作用是提供页面的启用与禁用功能，其他功能只是附带，非软件开发专业人员可不随意操作！\\n2、菜单管理实行的是软删除，无法真正删除系统菜单，菜单被删除后会进入已删除状态，作用同禁用。\\n3、菜单添加只能添加系统已经用代码实现了的页面，随意添加其他URL没有效果。\\n4、菜单编辑目前不提供URL的更改，URL关乎到页面的正常显示，不能修改可避免误操作。\\n5、修改菜单名称时，建议名称能有“见名知意”的效果。\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1542816000000,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1542895767521,\"id\":\"396f9846-d0fc-42b0-b267-d8be114e4786\",\"name\":\"菜单管理\",\"url\":\"/resource/listPage\",\"state\":1,\"describe\":\"系统菜单管理，即系统页面管理，可管理系统中的所有前后端页面（启用/禁用），只有启用的页面才能授权给角色，禁用的页面所有角色对其都无权访问。\"}]', '更新', '2018-11-22 00:00:00');
INSERT INTO `tab_log` VALUES ('150be66a-2154-4944-ad63-80f8de9b49a9', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在添加数据，数据信息为：\n[{\"remarks\":\"注：\\n1、菜单管理的主要作用是提供页面的启用与禁用功能，其他功能只是附带，非软件开发专业人员可不随意操作！\\n2、菜单管理实行的是软删除，无法真正删除系统菜单，菜单被删除后会进入已删除状态，作用同禁用。\\n3、菜单添加只能添加系统已经用代码实现了的页面，随意添加其他URL没有效果。\\n4、菜单编辑目前不提供URL的更改，URL关乎到页面的正常显示，不能修改可避免误操作。\\n5、修改菜单名称时，建议名称能有“见名知意”的效果。\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1542880306299,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1542880306299,\"id\":\"396f9846-d0fc-42b0-b267-d8be114e4786\",\"name\":\"菜单管理\",\"url\":\"/resource/listPage\",\"state\":1,\"describe\":null}]', '添加', '2018-11-22 00:00:00');
INSERT INTO `tab_log` VALUES ('15236538-443f-4ec9-994c-2959d70c834b', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"id\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"username\":\"admin@qq.com\",\"password\":\"63a9f0ea7bb98050796b649e85481845\",\"loginIP\":\"0:0:0:0:0:0:0:1\",\"unlockedFlag\":1,\"state\":1,\"registerTime\":1542470400000,\"lastLoginTime\":1542870383602,\"authorities\":[{\"remarks\":\"普通用户角色，在用户注册时会默认添加\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"7e0ee84f-216f-41d3-b3b0-832eaea51e79\",\"name\":\"USER\",\"describe\":\"普通用户角色\",\"permissions\":[],\"authority\":\"ROLE_USER\"},{\"remarks\":\"超级管理员\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"c09b1a67-1ab6-43fc-b1b6-7cd48ad21336\",\"name\":\"ADMIN\",\"describe\":\"超级管理员角色\",\"permissions\":[],\"authority\":\"ROLE_ADMIN\"}],\"enabled\":true,\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true}]', '更新', '2018-11-22 00:00:00');
INSERT INTO `tab_log` VALUES ('2cbc81df-2ad2-4eb4-b7d2-493aee630c38', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"id\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"username\":\"admin@qq.com\",\"password\":\"63a9f0ea7bb98050796b649e85481845\",\"loginIP\":\"0:0:0:0:0:0:0:1\",\"unlockedFlag\":1,\"state\":1,\"registerTime\":1542470400000,\"lastLoginTime\":1542795693742,\"authorities\":[{\"remarks\":\"普通用户角色，在用户注册时会默认添加\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"7e0ee84f-216f-41d3-b3b0-832eaea51e79\",\"name\":\"USER\",\"describe\":\"普通用户角色\",\"permissions\":[],\"authority\":\"ROLE_USER\"},{\"remarks\":\"超级管理员\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"c09b1a67-1ab6-43fc-b1b6-7cd48ad21336\",\"name\":\"ADMIN\",\"describe\":\"超级管理员角色\",\"permissions\":[],\"authority\":\"ROLE_ADMIN\"}],\"enabled\":true,\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true}]', '更新', '2018-11-21 00:00:00');
INSERT INTO `tab_log` VALUES ('482728ac-5172-4e29-b6a3-573762e73915', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"id\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"username\":\"admin@qq.com\",\"password\":\"63a9f0ea7bb98050796b649e85481845\",\"loginIP\":\"0:0:0:0:0:0:0:1\",\"unlockedFlag\":1,\"state\":1,\"registerTime\":1542470400000,\"lastLoginTime\":1542785809184,\"authorities\":[{\"remarks\":\"普通用户角色，在用户注册时会默认添加\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"7e0ee84f-216f-41d3-b3b0-832eaea51e79\",\"name\":\"USER\",\"describe\":\"普通用户角色\",\"permissions\":[],\"authority\":\"ROLE_USER\"},{\"remarks\":\"超级管理员\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"c09b1a67-1ab6-43fc-b1b6-7cd48ad21336\",\"name\":\"ADMIN\",\"describe\":\"超级管理员角色\",\"permissions\":[],\"authority\":\"ROLE_ADMIN\"}],\"enabled\":true,\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true}]', '更新', '2018-11-21 00:00:00');
INSERT INTO `tab_log` VALUES ('4af04340-a88b-4a01-a2dc-3c26a96f84a4', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"id\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"username\":\"admin@qq.com\",\"password\":\"63a9f0ea7bb98050796b649e85481845\",\"loginIP\":\"0:0:0:0:0:0:0:1\",\"unlockedFlag\":1,\"state\":1,\"registerTime\":1542470400000,\"lastLoginTime\":1542890374564,\"authorities\":[{\"remarks\":\"普通用户角色，在用户注册时会默认添加\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"7e0ee84f-216f-41d3-b3b0-832eaea51e79\",\"name\":\"USER\",\"describe\":\"普通用户角色\",\"permissions\":[],\"authority\":\"ROLE_USER\"},{\"remarks\":\"超级管理员\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"c09b1a67-1ab6-43fc-b1b6-7cd48ad21336\",\"name\":\"ADMIN\",\"describe\":\"超级管理员角色\",\"permissions\":[],\"authority\":\"ROLE_ADMIN\"}],\"enabled\":true,\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true}]', '更新', '2018-11-22 00:00:00');
INSERT INTO `tab_log` VALUES ('530643cc-6100-4878-a4f3-2c7c77719e00', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"id\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"username\":\"admin@qq.com\",\"password\":\"63a9f0ea7bb98050796b649e85481845\",\"loginIP\":\"0:0:0:0:0:0:0:1\",\"unlockedFlag\":1,\"state\":1,\"registerTime\":1542470400000,\"lastLoginTime\":1542874715690,\"authorities\":[{\"remarks\":\"普通用户角色，在用户注册时会默认添加\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"7e0ee84f-216f-41d3-b3b0-832eaea51e79\",\"name\":\"USER\",\"describe\":\"普通用户角色\",\"permissions\":[],\"authority\":\"ROLE_USER\"},{\"remarks\":\"超级管理员\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"c09b1a67-1ab6-43fc-b1b6-7cd48ad21336\",\"name\":\"ADMIN\",\"describe\":\"超级管理员角色\",\"permissions\":[],\"authority\":\"ROLE_ADMIN\"}],\"enabled\":true,\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true}]', '更新', '2018-11-22 00:00:00');
INSERT INTO `tab_log` VALUES ('55d285cd-9cd5-4ac8-9db7-f36d8948615d', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"注：\\n1、菜单管理的主要作用是提供页面的启用与禁用功能，其他功能只是附带，非软件开发专业人员可不随意操作！\\n2、菜单管理实行的是软删除，无法真正删除系统菜单，菜单被删除后会进入已删除状态，作用同禁用。\\n3、菜单添加只能添加系统已经用代码实现了的页面，随意添加其他URL没有效果。\\n4、菜单编辑目前不提供URL的更改，URL关乎到页面的正常显示，不能修改可避免误操作。\\n5、修改菜单名称时，建议名称能有“见名知意”的效果。\",\"createUserId\":null,\"createDate\":null,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1542894990305,\"id\":\"396f9846-d0fc-42b0-b267-d8be114e4786\",\"name\":\"菜单管理\",\"url\":\"/resource/listPage\",\"state\":1,\"describe\":\"系统菜单管理，即系统页面管理，可管理系统中的所有前后端页面（启用/禁用），只有启用的页面才能授权给角色，禁用的页面所有角色对其都无权访问。\"}]', '更新', '2018-11-22 00:00:00');
INSERT INTO `tab_log` VALUES ('5a8ba574-8a06-4233-a884-f6f490bcae12', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"id\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"username\":\"admin@qq.com\",\"password\":\"63a9f0ea7bb98050796b649e85481845\",\"loginIP\":\"0:0:0:0:0:0:0:1\",\"unlockedFlag\":1,\"state\":1,\"registerTime\":1542470400000,\"lastLoginTime\":1542891568857,\"authorities\":[{\"remarks\":\"普通用户角色，在用户注册时会默认添加\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"7e0ee84f-216f-41d3-b3b0-832eaea51e79\",\"name\":\"USER\",\"describe\":\"普通用户角色\",\"permissions\":[],\"authority\":\"ROLE_USER\"},{\"remarks\":\"超级管理员\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"c09b1a67-1ab6-43fc-b1b6-7cd48ad21336\",\"name\":\"ADMIN\",\"describe\":\"超级管理员角色\",\"permissions\":[],\"authority\":\"ROLE_ADMIN\"}],\"enabled\":true,\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true}]', '更新', '2018-11-22 00:00:00');
INSERT INTO `tab_log` VALUES ('5d05f866-f529-4a23-8d60-f9a45e2270d5', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"id\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"username\":\"admin@qq.com\",\"password\":\"63a9f0ea7bb98050796b649e85481845\",\"loginIP\":\"0:0:0:0:0:0:0:1\",\"unlockedFlag\":1,\"state\":1,\"registerTime\":1542470400000,\"lastLoginTime\":1542795882557,\"authorities\":[{\"remarks\":\"普通用户角色，在用户注册时会默认添加\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"7e0ee84f-216f-41d3-b3b0-832eaea51e79\",\"name\":\"USER\",\"describe\":\"普通用户角色\",\"permissions\":[],\"authority\":\"ROLE_USER\"},{\"remarks\":\"超级管理员\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"c09b1a67-1ab6-43fc-b1b6-7cd48ad21336\",\"name\":\"ADMIN\",\"describe\":\"超级管理员角色\",\"permissions\":[],\"authority\":\"ROLE_ADMIN\"}],\"enabled\":true,\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true}]', '更新', '2018-11-21 00:00:00');
INSERT INTO `tab_log` VALUES ('644ad83d-2b97-47f4-b530-6a6b39c166f2', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"id\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"username\":\"admin@qq.com\",\"password\":\"63a9f0ea7bb98050796b649e85481845\",\"loginIP\":\"0:0:0:0:0:0:0:1\",\"unlockedFlag\":1,\"state\":1,\"registerTime\":1542470400000,\"lastLoginTime\":1542795475959,\"authorities\":[{\"remarks\":\"普通用户角色，在用户注册时会默认添加\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"7e0ee84f-216f-41d3-b3b0-832eaea51e79\",\"name\":\"USER\",\"describe\":\"普通用户角色\",\"permissions\":[],\"authority\":\"ROLE_USER\"},{\"remarks\":\"超级管理员\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"c09b1a67-1ab6-43fc-b1b6-7cd48ad21336\",\"name\":\"ADMIN\",\"describe\":\"超级管理员角色\",\"permissions\":[],\"authority\":\"ROLE_ADMIN\"}],\"enabled\":true,\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true}]', '更新', '2018-11-21 00:00:00');
INSERT INTO `tab_log` VALUES ('65292b9a-a806-4f69-8992-7e5e88ad1b85', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"id\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"username\":\"admin@qq.com\",\"password\":\"63a9f0ea7bb98050796b649e85481845\",\"loginIP\":\"0:0:0:0:0:0:0:1\",\"unlockedFlag\":1,\"state\":1,\"registerTime\":1542470400000,\"lastLoginTime\":1542790502382,\"authorities\":[{\"remarks\":\"普通用户角色，在用户注册时会默认添加\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"7e0ee84f-216f-41d3-b3b0-832eaea51e79\",\"name\":\"USER\",\"describe\":\"普通用户角色\",\"permissions\":[],\"authority\":\"ROLE_USER\"},{\"remarks\":\"超级管理员\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"c09b1a67-1ab6-43fc-b1b6-7cd48ad21336\",\"name\":\"ADMIN\",\"describe\":\"超级管理员角色\",\"permissions\":[],\"authority\":\"ROLE_ADMIN\"}],\"enabled\":true,\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true}]', '更新', '2018-11-21 00:00:00');
INSERT INTO `tab_log` VALUES ('66374dff-85d2-47a1-8ec4-a25542af2359', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"id\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"username\":\"admin@qq.com\",\"password\":\"63a9f0ea7bb98050796b649e85481845\",\"loginIP\":\"0:0:0:0:0:0:0:1\",\"unlockedFlag\":1,\"state\":1,\"registerTime\":1542470400000,\"lastLoginTime\":1542879234994,\"authorities\":[{\"remarks\":\"普通用户角色，在用户注册时会默认添加\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"7e0ee84f-216f-41d3-b3b0-832eaea51e79\",\"name\":\"USER\",\"describe\":\"普通用户角色\",\"permissions\":[],\"authority\":\"ROLE_USER\"},{\"remarks\":\"超级管理员\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"c09b1a67-1ab6-43fc-b1b6-7cd48ad21336\",\"name\":\"ADMIN\",\"describe\":\"超级管理员角色\",\"permissions\":[],\"authority\":\"ROLE_ADMIN\"}],\"enabled\":true,\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true}]', '更新', '2018-11-22 00:00:00');
INSERT INTO `tab_log` VALUES ('75848c1d-57be-40b5-afc8-ad7917f70602', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"id\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"username\":\"admin@qq.com\",\"password\":\"63a9f0ea7bb98050796b649e85481845\",\"loginIP\":\"0:0:0:0:0:0:0:1\",\"unlockedFlag\":1,\"state\":1,\"registerTime\":1542470400000,\"lastLoginTime\":1542707319177,\"authorities\":[{\"remarks\":\"普通用户角色，在用户注册时会默认添加\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"7e0ee84f-216f-41d3-b3b0-832eaea51e79\",\"name\":\"USER\",\"describe\":\"普通用户角色\",\"permissions\":[],\"authority\":\"ROLE_USER\"}],\"enabled\":true,\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true}]', '更新', '2018-11-20 00:00:00');
INSERT INTO `tab_log` VALUES ('7a668be5-c2e0-4a37-8dbc-afb728302f4e', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"注：\\n1、菜单管理的主要作用是提供页面的启用与禁用功能，其他功能只是附带，非软件开发专业人员可不随意操作！\\n2、菜单管理实行的是软删除，无法真正删除系统菜单，菜单被删除后会进入已删除状态，作用同禁用。\\n3、菜单添加只能添加系统已经用代码实现了的页面，随意添加其他URL没有效果。\\n4、菜单编辑目前不提供URL的更改，URL关乎到页面的正常显示，不能修改可避免误操作。\\n5、修改菜单名称时，建议名称能有“见名知意”的效果。\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1542816000000,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1542896587683,\"id\":\"396f9846-d0fc-42b0-b267-d8be114e4786\",\"name\":\"菜单管理\",\"url\":\"/resource/listPage\",\"state\":1,\"describe\":\"系统菜单管理，即系统页面管理，可管理系统中的所有前后端页面（启用/禁用），只有启用的页面才能授权给角色，禁用的页面所有角色对其都无权访问。\"}]', '更新', '2018-11-22 00:00:00');
INSERT INTO `tab_log` VALUES ('8139e6e5-6a95-4ee4-978f-27705abd19d7', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"id\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"username\":\"admin@qq.com\",\"password\":\"63a9f0ea7bb98050796b649e85481845\",\"loginIP\":\"0:0:0:0:0:0:0:1\",\"unlockedFlag\":1,\"state\":1,\"registerTime\":1542470400000,\"lastLoginTime\":1542888220406,\"authorities\":[{\"remarks\":\"普通用户角色，在用户注册时会默认添加\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"7e0ee84f-216f-41d3-b3b0-832eaea51e79\",\"name\":\"USER\",\"describe\":\"普通用户角色\",\"permissions\":[],\"authority\":\"ROLE_USER\"},{\"remarks\":\"超级管理员\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"c09b1a67-1ab6-43fc-b1b6-7cd48ad21336\",\"name\":\"ADMIN\",\"describe\":\"超级管理员角色\",\"permissions\":[],\"authority\":\"ROLE_ADMIN\"}],\"enabled\":true,\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true}]', '更新', '2018-11-22 00:00:00');
INSERT INTO `tab_log` VALUES ('82ce63ad-0011-424b-9788-38f02e100bb4', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"id\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"username\":\"admin@qq.com\",\"password\":\"63a9f0ea7bb98050796b649e85481845\",\"loginIP\":\"0:0:0:0:0:0:0:1\",\"unlockedFlag\":1,\"state\":1,\"registerTime\":1542470400000,\"lastLoginTime\":1542793287048,\"authorities\":[{\"remarks\":\"普通用户角色，在用户注册时会默认添加\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"7e0ee84f-216f-41d3-b3b0-832eaea51e79\",\"name\":\"USER\",\"describe\":\"普通用户角色\",\"permissions\":[],\"authority\":\"ROLE_USER\"},{\"remarks\":\"超级管理员\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"c09b1a67-1ab6-43fc-b1b6-7cd48ad21336\",\"name\":\"ADMIN\",\"describe\":\"超级管理员角色\",\"permissions\":[],\"authority\":\"ROLE_ADMIN\"}],\"enabled\":true,\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true}]', '更新', '2018-11-21 00:00:00');
INSERT INTO `tab_log` VALUES ('8734c649-b745-4010-8302-00f483210a79', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"id\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"username\":\"admin@qq.com\",\"password\":\"63a9f0ea7bb98050796b649e85481845\",\"loginIP\":\"0:0:0:0:0:0:0:1\",\"unlockedFlag\":1,\"state\":1,\"registerTime\":1542470400000,\"lastLoginTime\":1542891186916,\"authorities\":[{\"remarks\":\"普通用户角色，在用户注册时会默认添加\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"7e0ee84f-216f-41d3-b3b0-832eaea51e79\",\"name\":\"USER\",\"describe\":\"普通用户角色\",\"permissions\":[],\"authority\":\"ROLE_USER\"},{\"remarks\":\"超级管理员\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"c09b1a67-1ab6-43fc-b1b6-7cd48ad21336\",\"name\":\"ADMIN\",\"describe\":\"超级管理员角色\",\"permissions\":[],\"authority\":\"ROLE_ADMIN\"}],\"enabled\":true,\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true}]', '更新', '2018-11-22 00:00:00');
INSERT INTO `tab_log` VALUES ('88db6eb6-5dc3-40e7-8cac-29281aaae83e', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"id\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"username\":\"admin@qq.com\",\"password\":\"63a9f0ea7bb98050796b649e85481845\",\"loginIP\":\"0:0:0:0:0:0:0:1\",\"unlockedFlag\":1,\"state\":1,\"registerTime\":1542470400000,\"lastLoginTime\":1542793093377,\"authorities\":[{\"remarks\":\"普通用户角色，在用户注册时会默认添加\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"7e0ee84f-216f-41d3-b3b0-832eaea51e79\",\"name\":\"USER\",\"describe\":\"普通用户角色\",\"permissions\":[],\"authority\":\"ROLE_USER\"},{\"remarks\":\"超级管理员\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"c09b1a67-1ab6-43fc-b1b6-7cd48ad21336\",\"name\":\"ADMIN\",\"describe\":\"超级管理员角色\",\"permissions\":[],\"authority\":\"ROLE_ADMIN\"}],\"enabled\":true,\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true}]', '更新', '2018-11-21 00:00:00');
INSERT INTO `tab_log` VALUES ('88f8ee70-fecd-4468-ac47-d406f5dc1edd', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"id\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"username\":\"admin@qq.com\",\"password\":\"63a9f0ea7bb98050796b649e85481845\",\"loginIP\":\"0:0:0:0:0:0:0:1\",\"unlockedFlag\":1,\"state\":1,\"registerTime\":1542470400000,\"lastLoginTime\":1542891464241,\"authorities\":[{\"remarks\":\"普通用户角色，在用户注册时会默认添加\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"7e0ee84f-216f-41d3-b3b0-832eaea51e79\",\"name\":\"USER\",\"describe\":\"普通用户角色\",\"permissions\":[],\"authority\":\"ROLE_USER\"},{\"remarks\":\"超级管理员\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"c09b1a67-1ab6-43fc-b1b6-7cd48ad21336\",\"name\":\"ADMIN\",\"describe\":\"超级管理员角色\",\"permissions\":[],\"authority\":\"ROLE_ADMIN\"}],\"enabled\":true,\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true}]', '更新', '2018-11-22 00:00:00');
INSERT INTO `tab_log` VALUES ('8cb6fb13-bc4a-43c3-9842-424be18cc2bd', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"id\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"username\":\"admin@qq.com\",\"password\":\"63a9f0ea7bb98050796b649e85481845\",\"loginIP\":\"0:0:0:0:0:0:0:1\",\"unlockedFlag\":1,\"state\":1,\"registerTime\":1542470400000,\"lastLoginTime\":1542874692610,\"authorities\":[{\"remarks\":\"普通用户角色，在用户注册时会默认添加\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"7e0ee84f-216f-41d3-b3b0-832eaea51e79\",\"name\":\"USER\",\"describe\":\"普通用户角色\",\"permissions\":[],\"authority\":\"ROLE_USER\"},{\"remarks\":\"超级管理员\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"c09b1a67-1ab6-43fc-b1b6-7cd48ad21336\",\"name\":\"ADMIN\",\"describe\":\"超级管理员角色\",\"permissions\":[],\"authority\":\"ROLE_ADMIN\"}],\"enabled\":true,\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true}]', '更新', '2018-11-22 00:00:00');
INSERT INTO `tab_log` VALUES ('909c3265-bbaa-433f-90cf-755473980026', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"id\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"username\":\"admin@qq.com\",\"password\":\"63a9f0ea7bb98050796b649e85481845\",\"loginIP\":\"0:0:0:0:0:0:0:1\",\"unlockedFlag\":1,\"state\":1,\"registerTime\":1542470400000,\"lastLoginTime\":1542888736168,\"authorities\":[{\"remarks\":\"普通用户角色，在用户注册时会默认添加\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"7e0ee84f-216f-41d3-b3b0-832eaea51e79\",\"name\":\"USER\",\"describe\":\"普通用户角色\",\"permissions\":[],\"authority\":\"ROLE_USER\"},{\"remarks\":\"超级管理员\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"c09b1a67-1ab6-43fc-b1b6-7cd48ad21336\",\"name\":\"ADMIN\",\"describe\":\"超级管理员角色\",\"permissions\":[],\"authority\":\"ROLE_ADMIN\"}],\"enabled\":true,\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true}]', '更新', '2018-11-22 00:00:00');
INSERT INTO `tab_log` VALUES ('98c1da54-85e6-43e4-b311-2ecfe2b2e718', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在添加数据，数据信息为：\n[{\"remarks\":\"管理系统的所有菜单，即系统页面管理，包括前后端的所有页面。\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1542877085114,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1542877086244,\"id\":\"739f6d2d-e606-4927-ba33-9dc7cd170a1e\",\"name\":\"菜单管理\",\"url\":\"/resource/listPage\",\"state\":1}]', '添加', '2018-11-22 00:00:00');
INSERT INTO `tab_log` VALUES ('9caafb75-1218-4b68-8fed-b14680cb59e2', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"注：\\n1、菜单管理的主要作用是提供页面的启用与禁用功能，其他功能只是附带，非软件开发专业人员可不随意操作！\\n2、菜单管理实行的是软删除，无法真正删除系统菜单，菜单被删除后会进入已删除状态，作用同禁用。\\n3、菜单添加只能添加系统已经用代码实现了的页面，随意添加其他URL没有效果。\\n4、菜单编辑目前不提供URL的更改，URL关乎到页面的正常显示，不能修改可避免误操作。\\n5、修改菜单名称时，建议名称能有“见名知意”的效果。\",\"createUserId\":null,\"createDate\":null,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1542894775935,\"id\":\"396f9846-d0fc-42b0-b267-d8be114e4786\",\"name\":\"菜单管理\",\"url\":\"/resource/listPage\",\"state\":1,\"describe\":\"系统菜单管理，即系统页面管理，可管理系统中的所有前后端页面（启用/禁用），只有启用的页面才能授权给角色，禁用的页面所有角色对其都无权访问。\"}]', '更新', '2018-11-22 00:00:00');
INSERT INTO `tab_log` VALUES ('a35cd4e8-f6cd-49bd-a721-bc73488383d3', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"id\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"username\":\"admin@qq.com\",\"password\":\"63a9f0ea7bb98050796b649e85481845\",\"loginIP\":\"0:0:0:0:0:0:0:1\",\"unlockedFlag\":1,\"state\":1,\"registerTime\":1542470400000,\"lastLoginTime\":1542886670891,\"authorities\":[{\"remarks\":\"普通用户角色，在用户注册时会默认添加\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"7e0ee84f-216f-41d3-b3b0-832eaea51e79\",\"name\":\"USER\",\"describe\":\"普通用户角色\",\"permissions\":[],\"authority\":\"ROLE_USER\"},{\"remarks\":\"超级管理员\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"c09b1a67-1ab6-43fc-b1b6-7cd48ad21336\",\"name\":\"ADMIN\",\"describe\":\"超级管理员角色\",\"permissions\":[],\"authority\":\"ROLE_ADMIN\"}],\"enabled\":true,\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true}]', '更新', '2018-11-22 00:00:00');
INSERT INTO `tab_log` VALUES ('acedef3d-6c69-48c5-b581-21034690d09e', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"id\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"username\":\"admin@qq.com\",\"password\":\"63a9f0ea7bb98050796b649e85481845\",\"loginIP\":\"0:0:0:0:0:0:0:1\",\"unlockedFlag\":1,\"state\":1,\"registerTime\":1542470400000,\"lastLoginTime\":1542873492847,\"authorities\":[{\"remarks\":\"普通用户角色，在用户注册时会默认添加\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"7e0ee84f-216f-41d3-b3b0-832eaea51e79\",\"name\":\"USER\",\"describe\":\"普通用户角色\",\"permissions\":[],\"authority\":\"ROLE_USER\"},{\"remarks\":\"超级管理员\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"c09b1a67-1ab6-43fc-b1b6-7cd48ad21336\",\"name\":\"ADMIN\",\"describe\":\"超级管理员角色\",\"permissions\":[],\"authority\":\"ROLE_ADMIN\"}],\"enabled\":true,\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true}]', '更新', '2018-11-22 00:00:00');
INSERT INTO `tab_log` VALUES ('b17358ad-a108-4fc6-9c83-41f2e5f17d40', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"id\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"username\":\"admin@qq.com\",\"password\":\"63a9f0ea7bb98050796b649e85481845\",\"loginIP\":\"0:0:0:0:0:0:0:1\",\"unlockedFlag\":1,\"state\":1,\"registerTime\":1542470400000,\"lastLoginTime\":1542880212224,\"authorities\":[{\"remarks\":\"普通用户角色，在用户注册时会默认添加\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"7e0ee84f-216f-41d3-b3b0-832eaea51e79\",\"name\":\"USER\",\"describe\":\"普通用户角色\",\"permissions\":[],\"authority\":\"ROLE_USER\"},{\"remarks\":\"超级管理员\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"c09b1a67-1ab6-43fc-b1b6-7cd48ad21336\",\"name\":\"ADMIN\",\"describe\":\"超级管理员角色\",\"permissions\":[],\"authority\":\"ROLE_ADMIN\"}],\"enabled\":true,\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true}]', '更新', '2018-11-22 00:00:00');
INSERT INTO `tab_log` VALUES ('c923f980-73e0-4b59-9a45-1b1a99e68a39', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"id\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"username\":\"admin@qq.com\",\"password\":\"63a9f0ea7bb98050796b649e85481845\",\"loginIP\":\"0:0:0:0:0:0:0:1\",\"unlockedFlag\":1,\"state\":1,\"registerTime\":1542470400000,\"lastLoginTime\":1542876834121,\"authorities\":[{\"remarks\":\"普通用户角色，在用户注册时会默认添加\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"7e0ee84f-216f-41d3-b3b0-832eaea51e79\",\"name\":\"USER\",\"describe\":\"普通用户角色\",\"permissions\":[],\"authority\":\"ROLE_USER\"},{\"remarks\":\"超级管理员\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"c09b1a67-1ab6-43fc-b1b6-7cd48ad21336\",\"name\":\"ADMIN\",\"describe\":\"超级管理员角色\",\"permissions\":[],\"authority\":\"ROLE_ADMIN\"}],\"enabled\":true,\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true}]', '更新', '2018-11-22 00:00:00');
INSERT INTO `tab_log` VALUES ('d1f7e0e5-a179-4b00-ae8f-ce5b1c479f8c', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"注：\\n1、菜单管理的主要作用是提供页面的启用与禁用功能，其他功能只是附带，非软件开发专业人员可不随意操作！\\n2、菜单管理实行的是软删除，无法真正删除系统菜单，菜单被删除后会进入已删除状态，作用同禁用。\\n3、菜单添加只能添加系统已经用代码实现了的页面，随意添加其他URL没有效果。\\n4、菜单编辑目前不提供URL的更改，URL关乎到页面的正常显示，不能修改可避免误操作。\\n5、修改菜单名称时，建议名称能有“见名知意”的效果。\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1542816000000,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1542895712569,\"id\":\"396f9846-d0fc-42b0-b267-d8be114e4786\",\"name\":\"菜单管理\",\"url\":\"/resource/listPage\",\"state\":1,\"describe\":\"系统菜单管理，即系统页面管理，可管理系统中的所有前后端页面（启用/禁用），只有启用的页面才能授权给角色，禁用的页面所有角色对其都无权访问。\"}]', '更新', '2018-11-22 00:00:00');
INSERT INTO `tab_log` VALUES ('d89aaa3f-c811-435c-a557-fd77e837cc68', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"id\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"username\":\"admin@qq.com\",\"password\":\"63a9f0ea7bb98050796b649e85481845\",\"loginIP\":\"0:0:0:0:0:0:0:1\",\"unlockedFlag\":1,\"state\":1,\"registerTime\":1542470400000,\"lastLoginTime\":1542870754085,\"authorities\":[{\"remarks\":\"普通用户角色，在用户注册时会默认添加\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"7e0ee84f-216f-41d3-b3b0-832eaea51e79\",\"name\":\"USER\",\"describe\":\"普通用户角色\",\"permissions\":[],\"authority\":\"ROLE_USER\"},{\"remarks\":\"超级管理员\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"c09b1a67-1ab6-43fc-b1b6-7cd48ad21336\",\"name\":\"ADMIN\",\"describe\":\"超级管理员角色\",\"permissions\":[],\"authority\":\"ROLE_ADMIN\"}],\"enabled\":true,\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true}]', '更新', '2018-11-22 00:00:00');
INSERT INTO `tab_log` VALUES ('d8bcb0c7-267e-4a7a-8b92-bcab0e849693', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在添加数据，数据信息为：\n[{\"remarks\":null,\"createUserId\":null,\"createDate\":null,\"updateUserId\":null,\"updateDate\":null,\"id\":\"86c5f358-9d12-46b9-bece-451d7801549b\",\"name\":\"资源管理\",\"url\":\"/resource/listPage\",\"state\":1}]', '添加', '2018-11-22 00:00:00');
INSERT INTO `tab_log` VALUES ('dfbe1c56-7ec6-4adc-bcb4-8045544ad528', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"id\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"username\":\"admin@qq.com\",\"password\":\"63a9f0ea7bb98050796b649e85481845\",\"loginIP\":\"0:0:0:0:0:0:0:1\",\"unlockedFlag\":1,\"state\":1,\"registerTime\":1542470400000,\"lastLoginTime\":1542886809170,\"authorities\":[{\"remarks\":\"普通用户角色，在用户注册时会默认添加\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"7e0ee84f-216f-41d3-b3b0-832eaea51e79\",\"name\":\"USER\",\"describe\":\"普通用户角色\",\"permissions\":[],\"authority\":\"ROLE_USER\"},{\"remarks\":\"超级管理员\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"c09b1a67-1ab6-43fc-b1b6-7cd48ad21336\",\"name\":\"ADMIN\",\"describe\":\"超级管理员角色\",\"permissions\":[],\"authority\":\"ROLE_ADMIN\"}],\"enabled\":true,\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true}]', '更新', '2018-11-22 00:00:00');
INSERT INTO `tab_log` VALUES ('e5c896ae-5608-4953-b624-b3099980afea', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"id\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"username\":\"admin@qq.com\",\"password\":\"63a9f0ea7bb98050796b649e85481845\",\"loginIP\":\"0:0:0:0:0:0:0:1\",\"unlockedFlag\":1,\"state\":1,\"registerTime\":1542470400000,\"lastLoginTime\":1542785037440,\"authorities\":[{\"remarks\":\"普通用户角色，在用户注册时会默认添加\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"7e0ee84f-216f-41d3-b3b0-832eaea51e79\",\"name\":\"USER\",\"describe\":\"普通用户角色\",\"permissions\":[],\"authority\":\"ROLE_USER\"},{\"remarks\":\"超级管理员\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"c09b1a67-1ab6-43fc-b1b6-7cd48ad21336\",\"name\":\"ADMIN\",\"describe\":\"超级管理员角色\",\"permissions\":[],\"authority\":\"ROLE_ADMIN\"}],\"enabled\":true,\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true}]', '更新', '2018-11-21 00:00:00');
INSERT INTO `tab_log` VALUES ('e67a1986-fef4-442b-a97a-152db0c9a9e5', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"id\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"username\":\"admin@qq.com\",\"password\":\"63a9f0ea7bb98050796b649e85481845\",\"loginIP\":\"0:0:0:0:0:0:0:1\",\"unlockedFlag\":1,\"state\":1,\"registerTime\":1542470400000,\"lastLoginTime\":1542787520603,\"authorities\":[{\"remarks\":\"普通用户角色，在用户注册时会默认添加\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"7e0ee84f-216f-41d3-b3b0-832eaea51e79\",\"name\":\"USER\",\"describe\":\"普通用户角色\",\"permissions\":[],\"authority\":\"ROLE_USER\"},{\"remarks\":\"超级管理员\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"c09b1a67-1ab6-43fc-b1b6-7cd48ad21336\",\"name\":\"ADMIN\",\"describe\":\"超级管理员角色\",\"permissions\":[],\"authority\":\"ROLE_ADMIN\"}],\"enabled\":true,\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true}]', '更新', '2018-11-21 00:00:00');
INSERT INTO `tab_log` VALUES ('ee9816bb-9e85-475e-9a61-6aa725f8afa9', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"remarks\":\"注：\\n1、菜单管理的主要作用是提供页面的启用与禁用功能，其他功能只是附带，非软件开发专业人员可不随意操作！\\n2、菜单管理实行的是软删除，无法真正删除系统菜单，菜单被删除后会进入已删除状态，作用同禁用。\\n3、菜单添加只能添加系统已经用代码实现了的页面，随意添加其他URL没有效果。\\n4、菜单编辑目前不提供URL的更改，URL关乎到页面的正常显示，不能修改可避免误操作。\\n5、修改菜单名称时，建议名称能有“见名知意”的效果。\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1542816000000,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1542964102268,\"id\":\"396f9846-d0fc-42b0-b267-d8be114e4786\",\"name\":\"菜单管理\",\"url\":\"/resource/listPage\",\"state\":1,\"describe\":\"系统菜单管理，即系统页面管理，可管理系统中的所有前后端页面（启用/禁用）。\\n只有启用的页面才能授权给角色，禁用的页面所有角色对其都无权访问。\"}]', '更新', '2018-11-23 17:08:22');
INSERT INTO `tab_log` VALUES ('f198013e-7e49-4661-bbaa-14061957b04e', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"id\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"username\":\"admin@qq.com\",\"password\":\"63a9f0ea7bb98050796b649e85481845\",\"loginIP\":\"0:0:0:0:0:0:0:1\",\"unlockedFlag\":1,\"state\":1,\"registerTime\":1542470400000,\"lastLoginTime\":1542887134794,\"authorities\":[{\"remarks\":\"普通用户角色，在用户注册时会默认添加\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"7e0ee84f-216f-41d3-b3b0-832eaea51e79\",\"name\":\"USER\",\"describe\":\"普通用户角色\",\"permissions\":[],\"authority\":\"ROLE_USER\"},{\"remarks\":\"超级管理员\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"c09b1a67-1ab6-43fc-b1b6-7cd48ad21336\",\"name\":\"ADMIN\",\"describe\":\"超级管理员角色\",\"permissions\":[],\"authority\":\"ROLE_ADMIN\"}],\"enabled\":true,\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true}]', '更新', '2018-11-22 00:00:00');
INSERT INTO `tab_log` VALUES ('f5558ece-dd2d-47ba-be9a-359c2f73d149', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"id\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"username\":\"admin@qq.com\",\"password\":\"63a9f0ea7bb98050796b649e85481845\",\"loginIP\":\"0:0:0:0:0:0:0:1\",\"unlockedFlag\":1,\"state\":1,\"registerTime\":1542470400000,\"lastLoginTime\":1542877486361,\"authorities\":[{\"remarks\":\"普通用户角色，在用户注册时会默认添加\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"7e0ee84f-216f-41d3-b3b0-832eaea51e79\",\"name\":\"USER\",\"describe\":\"普通用户角色\",\"permissions\":[],\"authority\":\"ROLE_USER\"},{\"remarks\":\"超级管理员\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"c09b1a67-1ab6-43fc-b1b6-7cd48ad21336\",\"name\":\"ADMIN\",\"describe\":\"超级管理员角色\",\"permissions\":[],\"authority\":\"ROLE_ADMIN\"}],\"enabled\":true,\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true}]', '更新', '2018-11-22 00:00:00');
INSERT INTO `tab_log` VALUES ('f7ccb53b-323b-4196-b6e7-cadf303dd3a8', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在添加数据，数据信息为：\n[{\"remarks\":\"注：\\n1、菜单管理的主要作用是提供页面的启用与禁用功能，其他功能只是附带，非软件开发专业人员可不随意操作！\\n2、菜单管理实行的是软删除，无法真正删除系统菜单，菜单被删除后会进入已删除状态，作用同禁用。\\n3、菜单添加只能添加系统已经用代码实现了的页面，随意添加其他URL没有效果。\\n4、菜单编辑目前不提供URL的更改，URL关乎到页面的正常显示，不能修改可避免误操作。\\n5、修改菜单名称时，建议名称能有“见名知意”的效果。\",\"createUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"createDate\":1542879414955,\"updateUserId\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"updateDate\":1542879418932,\"id\":\"110ef72e-5359-4b27-b604-d5f06dea5d15\",\"name\":\"菜单管理\",\"url\":\"/resource/listPage\",\"state\":1,\"describe\":null}]', '添加', '2018-11-22 00:00:00');
INSERT INTO `tab_log` VALUES ('f813e146-b2c5-4e51-b050-8d65fc866e5f', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"id\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"username\":\"admin@qq.com\",\"password\":\"63a9f0ea7bb98050796b649e85481845\",\"loginIP\":\"0:0:0:0:0:0:0:1\",\"unlockedFlag\":1,\"state\":1,\"registerTime\":1542470400000,\"lastLoginTime\":1542793439044,\"authorities\":[{\"remarks\":\"普通用户角色，在用户注册时会默认添加\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"7e0ee84f-216f-41d3-b3b0-832eaea51e79\",\"name\":\"USER\",\"describe\":\"普通用户角色\",\"permissions\":[],\"authority\":\"ROLE_USER\"},{\"remarks\":\"超级管理员\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"c09b1a67-1ab6-43fc-b1b6-7cd48ad21336\",\"name\":\"ADMIN\",\"describe\":\"超级管理员角色\",\"permissions\":[],\"authority\":\"ROLE_ADMIN\"}],\"enabled\":true,\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true}]', '更新', '2018-11-21 00:00:00');
INSERT INTO `tab_log` VALUES ('fbce9876-8c17-4ec7-adf7-60dc3597526d', 'd6a00d9d-2801-45c3-a99f-326e2949e2f2', '用户：【admin@qq.com】正在更新数据，数据信息为：\n[{\"id\":\"d6a00d9d-2801-45c3-a99f-326e2949e2f2\",\"username\":\"admin@qq.com\",\"password\":\"63a9f0ea7bb98050796b649e85481845\",\"loginIP\":\"0:0:0:0:0:0:0:1\",\"unlockedFlag\":1,\"state\":1,\"registerTime\":1542470400000,\"lastLoginTime\":1542784928751,\"authorities\":[{\"remarks\":\"普通用户角色，在用户注册时会默认添加\",\"createUserId\":null,\"createDate\":1542470400000,\"updateUserId\":null,\"updateDate\":null,\"id\":\"7e0ee84f-216f-41d3-b3b0-832eaea51e79\",\"name\":\"USER\",\"describe\":\"普通用户角色\",\"permissions\":[],\"authority\":\"ROLE_USER\"}],\"enabled\":true,\"accountNonExpired\":true,\"accountNonLocked\":true,\"credentialsNonExpired\":true}]', '更新', '2018-11-21 00:00:00');

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
-- ----------------------------
--  Table structure for `tab_training_dynamic`
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
--  Records of `tab_training_dynamic`
-- ----------------------------
INSERT INTO `tab_training_dynamic` VALUES ('1', '培训1', 'https://goss.veer.com/creative/vcg/veer/800water/veer-155063993.jpg', '培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容', '培训1', '培训1', '2018-11-5', '培训1', '2018-11-29');
INSERT INTO `tab_training_dynamic` VALUES ('2', '培训2', 'https://goss.veer.com/creative/vcg/veer/800water/veer-303342183.jpg', '培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容', '培训2', '培训2', '2018-11-5', '培训2', '2018-11-29');
INSERT INTO `tab_training_dynamic` VALUES ('3', '培训3', 'https://goss.veer.com/creative/vcg/veer/800water/veer-302222696.jpg', '培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容', '培训3', '培训3', '2018-11-6', '培训3', '2018-11-14');
INSERT INTO `tab_training_dynamic` VALUES ('4', '培训4', 'https://goss.veer.com/creative/vcg/veer/800water/veer-147418763.jpg', '培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容', '培训4', '培训4', '2018-11-5', '培训4', '2018-11-20');
INSERT INTO `tab_training_dynamic` VALUES ('5', '培训5', 'https://goss.veer.com/creative/vcg/veer/800water/veer-147424398.jpg', '培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容培训内容', '培训5', '培训5', '2018-11-6', '培训5', '2018-11-22');
-- ----------------------------
--  Table structure for `tab_advertisement`
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
--  Table structure for `tab_course`
-- ----------------------------
-- ----------------------------
--  Table structure for `tab_news_info`
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
--  Table structure for `tab_news_info`
-- ----------------------------