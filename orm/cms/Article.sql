CREATE TABLE `article` (
  `aid` int unsigned NOT NULL AUTO_INCREMENT,
  `topicid` int unsigned NOT NULL COMMENT '栏目id',
  `classtype` int unsigned NOT NULL,
  `userid` int unsigned NOT NULL,
  `sortid` int NOT NULL COMMENT '排序',
  `topicname` varchar(140) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `title` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `keywords` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '关键字',
  `fromsource` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文章来源',
  `author` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文章作者',
  `addip` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `createtime` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '显示的创建时间',
  `addtime` bigint unsigned NOT NULL COMMENT '添加或修改时间',
  `readnum` int NOT NULL,
  `review` int NOT NULL,
  `icoimg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '列表图片',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mdcontent` longtext COLLATE utf8mb4_general_ci NOT NULL COMMENT 'markdown content',
  `isopen` tinyint NOT NULL COMMENT '是否开放',
  `iscomment` tinyint NOT NULL COMMENT '是否可以评论',
  `fromlocal` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '发表地址',
  `texturl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'url用英文代替',
  `summary` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文章摘要',
  `editauthor` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文章编辑',
  `relatecontent` varchar(256) COLLATE utf8mb4_general_ci NOT NULL COMMENT '相关内容',
  PRIMARY KEY (`aid`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci