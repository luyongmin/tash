CREATE TABLE `t_task_plan` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '计划ID',
  `PLAN_NAME` varchar(50) DEFAULT NULL COMMENT '计划名称',
  `PLAN_TYPE` varchar(20) DEFAULT NULL COMMENT '计划类型',
  `PLAN_DESC` varchar(100) DEFAULT NULL COMMENT '计划描述',
  `LAST_EXT_TIME` timestamp NULL DEFAULT NULL COMMENT '节点开始时间',
  `STATUS` varchar(3) DEFAULT NULL COMMENT '状态',
  `SETTLE_TIME_START` varchar(32) DEFAULT NULL COMMENT '结算开始时间',
  `SETTLE_TIME_END` varchar(32) DEFAULT NULL COMMENT '结算关闭时间',
  `EXECUTE_CRON` varchar(50) DEFAULT NULL COMMENT '执行CRON',
  `CREATE_USER` varchar(32) DEFAULT NULL COMMENT '创建用户',
  `CREATE_TIME` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `MODIFY_USER` varchar(32) DEFAULT NULL COMMENT '修改用户',
  `MODIFY_TIME` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='任务计划表';

-- ---------------------------------------------

CREATE TABLE `t_task_plan_detail` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `PLAN_ID` bigint(20) NOT NULL COMMENT '计划ID',
  `TASK_CODE` varchar(32) NOT NULL COMMENT '任务编号',
  `TASK_NAME` varchar(50) DEFAULT NULL COMMENT '任务名称',
  `TASK_PARAM` varchar(150) DEFAULT NULL COMMENT '任务参数',
  `TASK_CRON` varchar(50) DEFAULT NULL COMMENT '任务CRON',
  `STATUS` varchar(3) DEFAULT NULL COMMENT '状态',
  `PRIORITY` tinyint(3) DEFAULT NULL COMMENT '优先级',
  `CREATE_TIME` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `MODIFY_TIME` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8 COMMENT='任务计划明细表';


CREATE TABLE `t_task_operation_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `node_code` varchar(32) NOT NULL COMMENT '节点编号',
  `node_name` varchar(50) DEFAULT NULL COMMENT '节点名称',
  `start_date` char(8) DEFAULT '' COMMENT '执行开始日期',
  `end_date` char(8) DEFAULT '' COMMENT '执行结束日期',
  `is_clear_all` char(2) NOT NULL COMMENT '是否强制（00：是，01：否）',
  `execute_state` char(2) DEFAULT '00' COMMENT '执行状态（00：执行中，01：执行完毕，02：执行失败）',
  `mer_list` text COMMENT '商户集合',
  `CREATE_USER` varchar(32) DEFAULT NULL COMMENT '创建用户',
  `CREATE_TIME` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `node_count` int(8) DEFAULT '0' COMMENT '总节点数',
  `succ_node_count` int(8) DEFAULT '0' COMMENT '成功节点数',
  `fail_node_count` int(8) DEFAULT '0' COMMENT '失败节点数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8 COMMENT='任务节点操作记录表';


CREATE TABLE `t_task_node_template_rel` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `TASK_CODE` varchar(32) NOT NULL COMMENT '任务编号',
  `NODE_CODE` varchar(32) NOT NULL COMMENT '节点编号',
  `PRIORITY` tinyint(3) DEFAULT NULL COMMENT '优先级',
  `CREATE_TIME` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8 COMMENT='任务节点模板关联表';


CREATE TABLE `t_task_node_template` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `NODE_CODE` varchar(32) NOT NULL COMMENT '节点编号',
  `NODE_NAME` varchar(50) DEFAULT NULL COMMENT '节点名称',
  `NODE_DESC` varchar(100) DEFAULT NULL COMMENT '节点描述',
  `FRONT_NODE` varchar(200) DEFAULT NULL COMMENT '前置节点',
  `START_TIME_CRON` varchar(32) DEFAULT '' COMMENT '开始时间cron',
  `STATUS` varchar(3) DEFAULT NULL,
  `CREATE_USER` varchar(32) DEFAULT NULL COMMENT '创建用户',
  `CREATE_TIME` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `MODIFY_USER` varchar(32) DEFAULT NULL COMMENT '修改用户',
  `MODIFY_TIME` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8 COMMENT='任务节点模板表';


CREATE TABLE `t_task_node` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `TASK_ID` bigint(20) NOT NULL COMMENT '任务ID',
  `NODE_CODE` varchar(32) NOT NULL COMMENT '节点编号',
  `NODE_NAME` varchar(50) DEFAULT NULL COMMENT '节点名称',
  `NODE_START_TIME` timestamp NULL DEFAULT NULL COMMENT '节点开始时间',
  `PRIORITY` tinyint(4) DEFAULT NULL COMMENT '优先级',
  `RESP_CODE` varchar(30) DEFAULT NULL COMMENT '返回编号',
  `RESP_MSG` varchar(200) DEFAULT NULL COMMENT '返回信息',
  `STATUS` varchar(3) DEFAULT NULL COMMENT '状态',
  `EXECUTE_TOKEN` varchar(32) DEFAULT NULL COMMENT '执行令牌',
  `CREATE_USER` varchar(32) DEFAULT NULL COMMENT '创建用户',
  `CREATE_TIME` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `MODIFY_USER` varchar(32) DEFAULT NULL COMMENT '修改用户',
  `MODIFY_TIME` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=49918 DEFAULT CHARSET=utf8 COMMENT='任务节点表';



CREATE TABLE `t_task_batch_record` (
  `id` bigint(32) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `task_type` varchar(2) NOT NULL COMMENT '任务类型',
  `start_time` varchar(8) DEFAULT '' COMMENT '开始时间',
  `end_time` varchar(8) DEFAULT '' COMMENT '截至时间',
  `settle_time` varchar(8) DEFAULT '' COMMENT '记账日期',
  `mer_id` varchar(32) NOT NULL DEFAULT '' COMMENT '商户编号/对账单编号',
  `status` varchar(2) DEFAULT '00' COMMENT '执行结果，00:初始，01：执行中，02：成功，03：失败',
  `apply_user` varchar(8) DEFAULT '' COMMENT '申请人',
  `apply_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '申请人',
  `audit_user` varchar(8) NOT NULL DEFAULT '' COMMENT '审核人',
  `audit_time` timestamp NOT NULL DEFAULT '2000-01-01 00:00:00' COMMENT '审核时间',
  `audit_status` varchar(32) DEFAULT '00' COMMENT '审核状态，00：初始，01：审核通过，02：审核拒绝',
  `audit_reason` text COMMENT '审核意见',
  `execute_result` text COMMENT '执行结果',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8 COMMENT='批量任务记录';



CREATE TABLE `t_task` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务id',
  `TASK_CODE` varchar(32) NOT NULL DEFAULT '' COMMENT '任务编号',
  `TASK_NAME` varchar(50) DEFAULT '' COMMENT '任务名称',
  `PLAN_ID` bigint(20) DEFAULT NULL COMMENT '计划id',
  `TASK_PARAM` varchar(150) DEFAULT '' COMMENT '任务参数',
  `TASK_START_TIME` timestamp NULL DEFAULT NULL COMMENT '任务开始时间',
  `SETTLE_DATE` varchar(20) DEFAULT NULL COMMENT '结算日期',
  `STATUS` varchar(3) DEFAULT '' COMMENT '0-等待执行,1-成功,2-已调度,3-失败',
  `PRIORITY` tinyint(3) DEFAULT NULL COMMENT '优先级',
  `CREATE_USER` varchar(32) DEFAULT NULL COMMENT '创建人',
  `CREATE_TIME` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `MODIFY_USER` varchar(32) DEFAULT NULL COMMENT '修改人',
  `MODIFY_TIME` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=15831 DEFAULT CHARSET=utf8 COMMENT='任务表';



CREATE TABLE `t_task_template` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `TASK_CODE` varchar(32) NOT NULL COMMENT '任务编号',
  `TASK_NAME` varchar(50) DEFAULT NULL COMMENT '任务名称',
  `TASK_DESC` varchar(100) DEFAULT NULL COMMENT '任务描述',
  `TASK_PARAM` varchar(150) DEFAULT NULL COMMENT '任务参数',
  `STATUS` varchar(3) DEFAULT NULL COMMENT '状态',
  `CREATE_USER` varchar(32) DEFAULT NULL COMMENT '创建用户',
  `CREATE_TIME` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `MODIFY_USER` varchar(32) DEFAULT NULL COMMENT '修改用户',
  `MODIFY_TIME` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8 COMMENT='任务模板表';


INSERT INTO `settle`.`t_task_plan` (`ID`, `PLAN_NAME`, `PLAN_TYPE`, `PLAN_DESC`, `LAST_EXT_TIME`, `STATUS`, `SETTLE_TIME_START`, `SETTLE_TIME_END`, `EXECUTE_CRON`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('1', '每日清结算执行计划', '1', 'T+1日执行T日数据清结算', '2019-09-23 17:52:12', '1', '@{T,-1}', '@{T,-1}', '0 4 0 * * ?', 'sys', '2018-01-05 00:05:00', 'sys', '2019-09-23 17:52:17');
INSERT INTO `settle`.`t_task_plan` (`ID`, `PLAN_NAME`, `PLAN_TYPE`, `PLAN_DESC`, `LAST_EXT_TIME`, `STATUS`, `SETTLE_TIME_START`, `SETTLE_TIME_END`, `EXECUTE_CRON`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('2', '201812月计划重跑', '2', '201812月计划重跑', '2018-01-16 16:15:01', '2', '20171226', '20180102', '0 10 16 16 1 ?', 'qinyingying', '2018-01-10 14:24:52', 'sys', '2018-01-16 16:15:00');
INSERT INTO `settle`.`t_task_plan` (`ID`, `PLAN_NAME`, `PLAN_TYPE`, `PLAN_DESC`, `LAST_EXT_TIME`, `STATUS`, `SETTLE_TIME_START`, `SETTLE_TIME_END`, `EXECUTE_CRON`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('4', '20180523计划重跑', '2', '20180523计划重跑', '2018-05-24 11:07:20', '2', '20180523', '20180523', '0 29 10 * * ?', 'qinyingying', '2018-05-24 10:28:40', 'sys', '2018-05-24 11:07:19');
INSERT INTO `settle`.`t_task_plan` (`ID`, `PLAN_NAME`, `PLAN_TYPE`, `PLAN_DESC`, `LAST_EXT_TIME`, `STATUS`, `SETTLE_TIME_START`, `SETTLE_TIME_END`, `EXECUTE_CRON`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('5', '中行消费量上传文件任务计划', '1', '中行消费量上传文件任务计划', '2019-09-23 17:52:12', '2', '@{T,-1}', '@{T,-1}', '0 30 0 2,17 * *', 'cxx', '2018-06-28 18:10:15', 'sys', '2019-09-23 17:52:17');
INSERT INTO `settle`.`t_task_plan` (`ID`, `PLAN_NAME`, `PLAN_TYPE`, `PLAN_DESC`, `LAST_EXT_TIME`, `STATUS`, `SETTLE_TIME_START`, `SETTLE_TIME_END`, `EXECUTE_CRON`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('6', '生成excel文件', '1', '生成excel文件', '2019-09-23 17:52:12', '2', '@{T,-1}', '@{T,-1}', '0 4 0 1 * ?', 'sys', '2019-02-25 16:17:51', 'sys', '2019-09-23 17:52:17');


INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('1', '1', 'TASK_COMMON_TABLE_SYS', '通用业务数据表同步任务', '', '', '1', '1', '2017-12-28 15:57:33', '2017-12-28 15:57:33');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('2', '1', 'TASK_CHANNEL_COLLATE', '渠道对账任务', '', '', '1', '2', '2017-12-28 15:57:36', '2017-12-28 15:57:36');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('3', '1', 'TASK_MER_JFZC_COLLATE', '下游商户-众筹对账任务', '', '', '1', '3', '2017-12-28 15:57:38', '2017-12-28 15:57:38');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('4', '1', 'TASK_MER_MALL_COLLATE', '下游商户-商城对账任务', '', '', '1', '3', '2017-12-28 15:57:39', '2017-12-28 15:57:39');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('5', '1', 'TASK_CONSUME_SPLIT', '消费订单拆分任务', '', '', '1', '4', '2017-12-28 15:57:41', '2017-12-28 15:57:41');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('6', '1', 'TASK_MER_CLEAR', '商户清分报表任务', '', '', '1', '5', '2017-12-28 15:57:44', '2017-12-28 15:57:44');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('7', '1', 'TASK_OUTER_JFXF_CLEAR', '股东方积分消费清分任务', '', '', '1', '6', '2017-12-28 15:57:45', '2017-12-28 15:57:45');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('8', '1', 'TASK_OUTER_JFDR_CLEAR', '股东方积分兑入清分任务', '', '', '1', '6', '2017-12-28 15:57:48', '2017-12-28 15:57:48');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('9', '1', 'TASK_OUTER_COLLATE', '股东方对账任务', NULL, NULL, '1', '9', '2017-12-28 15:57:53', '2017-12-28 15:57:53');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('10', '1', 'TASK_COMMON_FILE_UPLOAD', '通用文件上传任务', NULL, NULL, '0', '1', '2017-12-28 15:57:55', '2017-12-28 15:57:55');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('11', '2', 'TASK_COMMON_TABLE_SYS', '通用业务数据表同步任务', '', '', '1', '1', '2018-01-10 14:24:52', '2018-01-10 14:24:52');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('12', '2', 'TASK_CHANNEL_COLLATE', '渠道对账任务', '', '', '1', '2', '2018-01-10 14:24:52', '2018-01-10 14:24:52');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('13', '2', 'TASK_MER_JFZC_COLLATE', '下游商户-众筹对账任务', '', '', '1', '3', '2018-01-10 14:24:52', '2018-01-10 14:24:52');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('14', '2', 'TASK_MER_MALL_COLLATE', '下游商户-商城对账任务', '', '', '1', '3', '2018-01-10 14:24:52', '2018-01-10 14:24:52');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('15', '2', 'TASK_CONSUME_SPLIT', '消费订单拆分任务', '', '', '1', '4', '2018-01-10 14:24:52', '2018-01-10 14:24:52');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('16', '2', 'TASK_MER_CLEAR', '商户清分报表任务', '', '', '1', '5', '2018-01-10 14:24:52', '2018-01-10 14:24:52');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('17', '2', 'TASK_OUTER_JFXF_CLEAR', '股东方积分消费清分任务', '', '', '1', '6', '2018-01-10 14:24:52', '2018-01-10 14:24:52');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('18', '2', 'TASK_OUTER_JFDR_CLEAR', '股东方积分兑入清分任务', '', '', '1', '6', '2018-01-10 14:24:52', '2018-01-10 14:24:52');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('19', '2', 'TASK_OUTER_COLLATE', '股东方对账任务', '', '', '1', '9', '2018-01-10 14:24:52', '2018-01-10 14:24:52');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('20', '2', 'TASK_COMMON_FILE_UPLOAD', '通用文件上传任务', '', '', '1', '1', '2018-01-10 14:24:52', '2018-01-10 14:24:52');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('21', '1', 'TASK_TRIAL_BALANCE_COLLATE', '试算平衡对账任务', '', '', '1', '7', '2018-02-06 13:23:07', '2018-02-06 13:23:07');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('22', '1', 'TASK_MER_BUTLER_COLLATE', '下游商户-积分管家对账任务', '', '', '1', '3', '2018-02-05 14:43:49', '2018-02-05 14:43:44');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('23', '1', 'TASK_CROSS_DIFF_CLOSE', '跨日差异自动关闭任务', NULL, NULL, '1', '10', '2018-05-10 22:41:24', '2018-05-10 22:41:24');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('24', '1', 'TASK_ORDER', '订单汇总', NULL, NULL, '1', '10', '2018-05-10 22:41:44', '2018-05-10 22:41:44');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('25', '3', 'TASK_COMMON_TABLE_SYS', '通用业务数据表同步任务', '', '', '1', '1', '2018-05-24 10:09:56', '2018-05-24 10:09:56');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('26', '3', 'TASK_CHANNEL_COLLATE', '渠道对账任务', '', '', '1', '2', '2018-05-24 10:09:56', '2018-05-24 10:09:56');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('27', '3', 'TASK_MER_JFZC_COLLATE', '下游商户-众筹对账任务', '', '', '1', '3', '2018-05-24 10:09:56', '2018-05-24 10:09:56');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('28', '3', 'TASK_MER_MALL_COLLATE', '下游商户-商城对账任务', '', '', '1', '3', '2018-05-24 10:09:56', '2018-05-24 10:09:56');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('29', '3', 'TASK_CONSUME_SPLIT', '消费订单拆分任务', '', '', '1', '4', '2018-05-24 10:09:56', '2018-05-24 10:09:56');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('30', '3', 'TASK_MER_CLEAR', '商户清分报表任务', '', '', '1', '5', '2018-05-24 10:09:56', '2018-05-24 10:09:56');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('31', '3', 'TASK_OUTER_JFXF_CLEAR', '股东方积分消费清分任务', '', '', '1', '6', '2018-05-24 10:09:56', '2018-05-24 10:09:56');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('32', '3', 'TASK_OUTER_JFDR_CLEAR', '股东方积分兑入清分任务', '', '', '1', '6', '2018-05-24 10:09:56', '2018-05-24 10:09:56');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('33', '3', 'TASK_OUTER_COLLATE', '股东方对账任务', '', '', '1', '9', '2018-05-24 10:09:56', '2018-05-24 10:09:56');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('34', '3', 'TASK_COMMON_FILE_UPLOAD', '通用文件上传任务', '', '', '1', '1', '2018-05-24 10:09:56', '2018-05-24 10:09:56');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('35', '3', 'TASK_TRIAL_BALANCE_COLLATE', '试算平衡对账任务', '', '', '1', '7', '2018-05-24 10:09:56', '2018-05-24 10:09:56');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('36', '3', 'TASK_MER_BUTLER_COLLATE', '下游商户-积分管家对账任务', '', '', '1', '3', '2018-05-24 10:09:56', '2018-05-24 10:09:56');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('37', '3', 'TASK_CROSS_DIFF_CLOSE', '跨日差异自动关闭任务', '', '', '1', '10', '2018-05-24 10:09:56', '2018-05-24 10:09:56');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('38', '3', 'TASK_ORDER', '订单汇总', '', '', '1', '10', '2018-05-24 10:09:56', '2018-05-24 10:09:56');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('39', '4', 'TASK_COMMON_TABLE_SYS', '通用业务数据表同步任务', '', '', '1', '1', '2018-05-24 10:28:40', '2018-05-24 10:28:40');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('40', '4', 'TASK_CHANNEL_COLLATE', '渠道对账任务', '', '', '1', '2', '2018-05-24 10:28:40', '2018-05-24 10:28:40');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('41', '4', 'TASK_MER_JFZC_COLLATE', '下游商户-众筹对账任务', '', '', '1', '3', '2018-05-24 10:28:40', '2018-05-24 10:28:40');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('42', '4', 'TASK_MER_MALL_COLLATE', '下游商户-商城对账任务', '', '', '1', '3', '2018-05-24 10:28:40', '2018-05-24 10:28:40');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('43', '4', 'TASK_CONSUME_SPLIT', '消费订单拆分任务', '', '', '1', '4', '2018-05-24 10:28:40', '2018-05-24 10:28:40');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('44', '4', 'TASK_MER_CLEAR', '商户清分报表任务', '', '', '1', '5', '2018-05-24 10:28:40', '2018-05-24 10:28:40');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('45', '4', 'TASK_OUTER_JFXF_CLEAR', '股东方积分消费清分任务', '', '', '1', '6', '2018-05-24 10:28:40', '2018-05-24 10:28:40');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('46', '4', 'TASK_OUTER_JFDR_CLEAR', '股东方积分兑入清分任务', '', '', '1', '6', '2018-05-24 10:28:40', '2018-05-24 10:28:40');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('47', '4', 'TASK_OUTER_COLLATE', '股东方对账任务', '', '', '1', '9', '2018-05-24 10:28:40', '2018-05-24 10:28:40');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('48', '4', 'TASK_COMMON_FILE_UPLOAD', '通用文件上传任务', '', '', '1', '1', '2018-05-24 10:28:40', '2018-05-24 10:28:40');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('49', '4', 'TASK_TRIAL_BALANCE_COLLATE', '试算平衡对账任务', '', '', '1', '7', '2018-05-24 10:28:40', '2018-05-24 10:28:40');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('50', '4', 'TASK_MER_BUTLER_COLLATE', '下游商户-积分管家对账任务', '', '', '1', '3', '2018-05-24 10:28:40', '2018-05-24 10:28:40');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('51', '4', 'TASK_CROSS_DIFF_CLOSE', '跨日差异自动关闭任务', '', '', '1', '10', '2018-05-24 10:28:40', '2018-05-24 10:28:40');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('52', '4', 'TASK_ORDER', '订单汇总', '', '', '1', '10', '2018-05-24 10:28:40', '2018-05-24 10:28:40');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('53', '1', 'ROC_AOU_FILE_FETCH', '中行消费量取文件', NULL, NULL, '1', '10', '2018-06-23 20:42:20', '2018-06-23 20:42:20');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('54', '1', 'ROC_EXR_FILE_FETCH', '中行兑换量取文件', NULL, NULL, '1', '10', '2018-06-23 20:43:21', '2018-06-23 20:43:21');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('55', '1', 'SEND_ROC_EXR_FILE_FETCH', '中行兑换量发文件', NULL, NULL, '1', '1', '2018-06-23 20:44:10', '2018-06-23 20:44:10');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('56', '5', 'SEND_ROC_AOU_FILE_FETCH', '中行消费量发文件', NULL, NULL, '1', '10', '2018-06-23 20:45:13', '2018-06-23 20:45:13');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('57', '1', 'TASK_CHECK_DATA_MNG', '同步数据检查', NULL, NULL, '1', '11', '2018-10-25 14:00:00', NULL);
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('58', '1', 'TASK_ALARM_POINTSTOTAL_MNG', '积分消费额告警', NULL, NULL, '1', '12', '2018-12-12 20:57:55', NULL);
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('59', '1', 'SEND_DIF_FILE_EXR_MNG', '中行兑换差异处理文件', NULL, NULL, '1', '10', '2018-12-21 16:42:05', NULL);
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('60', '1', 'ACCOUNT_DAY_CUT', '账务核心日切', NULL, NULL, '1', '1', '2019-02-19 14:28:10', NULL);
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('100', '6', 'GEN_EXCEL_FILE', '生成excel文件', NULL, NULL, '1', '10', '2019-02-25 16:17:51', '2019-02-25 16:17:51');
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('101', '1', 'COLLECT_ACCOUNT_DATA', '账务收集数据', NULL, NULL, '1', '10', '2019-03-05 18:41:43', NULL);
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('102', '1', 'ACCOUNT_SETTLE_MONITOR_MNG', '核心账务记账监测', NULL, NULL, '1', '10', '2019-07-18 13:59:27', NULL);
INSERT INTO `settle`.`t_task_plan_detail` (`ID`, `PLAN_ID`, `TASK_CODE`, `TASK_NAME`, `TASK_PARAM`, `TASK_CRON`, `STATUS`, `PRIORITY`, `CREATE_TIME`, `MODIFY_TIME`) VALUES ('103', '1', 'TASK_FILE_SCANPAY_ORDER_FILE', '推送银联商务文件', NULL, NULL, '1', '1', '2019-07-25 11:26:53', NULL);



INSERT INTO `settle`.`t_task_template` (`ID`, `TASK_CODE`, `TASK_NAME`, `TASK_DESC`, `TASK_PARAM`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('1', 'TASK_COMMON_TABLE_SYS', '通用业务数据表同步任务', '同步各业务系统数据任务', '', '1', 'sys', '2017-12-10 11:11:43', 'sys', '2017-12-10 11:11:43');
INSERT INTO `settle`.`t_task_template` (`ID`, `TASK_CODE`, `TASK_NAME`, `TASK_DESC`, `TASK_PARAM`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('2', 'TASK_CHANNEL_COLLATE', '渠道对账任务', '集合所有渠道对账任务', '', '1', 'sys', '2017-12-10 11:11:43', 'sys', '2017-12-10 11:11:43');
INSERT INTO `settle`.`t_task_template` (`ID`, `TASK_CODE`, `TASK_NAME`, `TASK_DESC`, `TASK_PARAM`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('3', 'TASK_MER_JFZC_COLLATE', '下游商户-众筹对账任务', '下游商户-众筹对账任务', '', '1', 'sys', '2017-12-10 11:11:43', 'sys', '2017-12-10 11:11:43');
INSERT INTO `settle`.`t_task_template` (`ID`, `TASK_CODE`, `TASK_NAME`, `TASK_DESC`, `TASK_PARAM`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('4', 'TASK_MER_MALL_COLLATE', '下游商户-商城对账任务', '下游商户-商城对账任务', '', '1', 'sys', '2017-12-10 11:11:44', 'sys', '2017-12-10 11:11:44');
INSERT INTO `settle`.`t_task_template` (`ID`, `TASK_CODE`, `TASK_NAME`, `TASK_DESC`, `TASK_PARAM`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('6', 'TASK_CONSUME_SPLIT', '消费订单拆分任务', '消费订单拆分任务', '', '1', 'sys', '2017-12-10 11:11:44', 'sys', '2017-12-10 11:11:44');
INSERT INTO `settle`.`t_task_template` (`ID`, `TASK_CODE`, `TASK_NAME`, `TASK_DESC`, `TASK_PARAM`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('7', 'TASK_MER_CLEAR', '商户清分报表任务', '商户清分报表任务', 'merId', '1', 'sys', '2017-12-10 11:11:44', 'sys', '2017-12-10 11:11:44');
INSERT INTO `settle`.`t_task_template` (`ID`, `TASK_CODE`, `TASK_NAME`, `TASK_DESC`, `TASK_PARAM`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('8', 'TASK_OUTER_JFXF_CLEAR', '股东方积分消费清分任务', '股东方积分消费清分任务', '', '1', 'sys', '2017-12-10 11:11:44', 'sys', '2017-12-10 11:11:44');
INSERT INTO `settle`.`t_task_template` (`ID`, `TASK_CODE`, `TASK_NAME`, `TASK_DESC`, `TASK_PARAM`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('9', 'TASK_OUTER_JFDR_CLEAR', '股东方积分兑入清分任务', '股东方积分消费清分任务', '', '1', 'sys', '2017-12-10 11:11:44', 'sys', '2017-12-10 11:11:44');
INSERT INTO `settle`.`t_task_template` (`ID`, `TASK_CODE`, `TASK_NAME`, `TASK_DESC`, `TASK_PARAM`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('10', 'TASK_OUTER_COLLATE', '股东方对账任务', '股东方对账任务', NULL, '1', 'sys', '2017-12-28 16:22:04', 'sys', '2017-12-28 16:22:04');
INSERT INTO `settle`.`t_task_template` (`ID`, `TASK_CODE`, `TASK_NAME`, `TASK_DESC`, `TASK_PARAM`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('11', 'TASK_COMMON_FILE_UPLOAD', '通用的文件上传任务', '通用的文件上传任务', NULL, '0', 'sys', '2017-12-28 15:41:52', 'sys', '2017-12-28 15:41:52');
INSERT INTO `settle`.`t_task_template` (`ID`, `TASK_CODE`, `TASK_NAME`, `TASK_DESC`, `TASK_PARAM`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('12', 'TASK_TRIAL_BALANCE_COLLATE', '试算平衡对账任务', '试算平衡对账任务', '1', '1', 'sys', '2018-02-06 13:23:08', 'sys', '2018-02-06 13:23:08');
INSERT INTO `settle`.`t_task_template` (`ID`, `TASK_CODE`, `TASK_NAME`, `TASK_DESC`, `TASK_PARAM`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('13', 'TASK_MER_BUTLER_COLLATE', '下游商户-积分管家对账任务', '下游商户-积分管家对账任务', '', '1', 'sys', '2017-12-10 11:11:44', 'sys', '2017-12-10 11:11:44');
INSERT INTO `settle`.`t_task_template` (`ID`, `TASK_CODE`, `TASK_NAME`, `TASK_DESC`, `TASK_PARAM`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('14', 'TASK_CROSS_DIFF_CLOSE', '跨日差异自动关闭任务', '跨日差异自动关闭任务', NULL, '1', 'sys', '2018-05-10 22:41:24', 'sys', '2018-05-10 22:41:24');
INSERT INTO `settle`.`t_task_template` (`ID`, `TASK_CODE`, `TASK_NAME`, `TASK_DESC`, `TASK_PARAM`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('15', 'TASK_ORDER', '订单汇总任务', '订单汇总任务', NULL, '1', 'sys', '2018-05-10 22:41:44', 'sys', '2018-05-10 22:41:44');
INSERT INTO `settle`.`t_task_template` (`ID`, `TASK_CODE`, `TASK_NAME`, `TASK_DESC`, `TASK_PARAM`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('16', 'ROC_AOU_FILE_FETCH', '中行消费量取文件', '中行消费量取文件', NULL, '1', 'sys', '2018-06-23 20:42:40', 'sys', '2018-06-23 20:42:40');
INSERT INTO `settle`.`t_task_template` (`ID`, `TASK_CODE`, `TASK_NAME`, `TASK_DESC`, `TASK_PARAM`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('17', 'ROC_EXR_FILE_FETCH', '中行兑换量取文件', '中行兑换量取文件', NULL, '1', 'sys', '2018-06-23 20:43:32', 'sys', '2018-06-23 20:43:32');
INSERT INTO `settle`.`t_task_template` (`ID`, `TASK_CODE`, `TASK_NAME`, `TASK_DESC`, `TASK_PARAM`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('18', 'SEND_ROC_EXR_FILE_FETCH', '中行兑换量发文件', '中行兑换量发文件', NULL, '1', 'sys', '2018-06-23 20:44:26', 'sys', '2018-06-23 20:44:26');
INSERT INTO `settle`.`t_task_template` (`ID`, `TASK_CODE`, `TASK_NAME`, `TASK_DESC`, `TASK_PARAM`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('19', 'SEND_ROC_AOU_FILE_FETCH', '中行消费量发文件', '中行消费量发文件', NULL, '1', 'sys', '2018-06-23 20:45:37', 'sys', '2018-06-23 20:45:37');
INSERT INTO `settle`.`t_task_template` (`ID`, `TASK_CODE`, `TASK_NAME`, `TASK_DESC`, `TASK_PARAM`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('20', 'TASK_CHECK_DATA_MNG', '同步数据检查', '对同步数据进行检查', NULL, '1', 'sys', '2018-10-25 14:00:00', NULL, NULL);
INSERT INTO `settle`.`t_task_template` (`ID`, `TASK_CODE`, `TASK_NAME`, `TASK_DESC`, `TASK_PARAM`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('21', 'TASK_ALARM_POINTSTOTAL_MNG', '积分消费额告警', '积分消费额告警', NULL, '1', 'sys', '2018-12-12 20:57:55', NULL, NULL);
INSERT INTO `settle`.`t_task_template` (`ID`, `TASK_CODE`, `TASK_NAME`, `TASK_DESC`, `TASK_PARAM`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('22', 'SEND_DIF_FILE_EXR_MNG', '中行兑换差异处理文件', '中行兑换差异处理文件', NULL, '1', 'sys', '2018-12-21 16:42:06', NULL, NULL);
INSERT INTO `settle`.`t_task_template` (`ID`, `TASK_CODE`, `TASK_NAME`, `TASK_DESC`, `TASK_PARAM`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('23', 'ACCOUNT_DAY_CUT', '账务核心日切', '账务核心日切', NULL, '1', 'sys', '2019-02-19 14:28:11', NULL, NULL);
INSERT INTO `settle`.`t_task_template` (`ID`, `TASK_CODE`, `TASK_NAME`, `TASK_DESC`, `TASK_PARAM`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('50', 'GEN_EXCEL_FILE', '生成excel文件', '生成excel文件', 'merId', '1', 'sys', '2019-02-25 16:17:52', 'sys', '2019-02-25 16:17:52');
INSERT INTO `settle`.`t_task_template` (`ID`, `TASK_CODE`, `TASK_NAME`, `TASK_DESC`, `TASK_PARAM`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('51', 'COLLECT_ACCOUNT_DATA', '账务收集数据', '账务收集数据', NULL, '1', 'sys', '2019-03-05 18:41:44', NULL, NULL);
INSERT INTO `settle`.`t_task_template` (`ID`, `TASK_CODE`, `TASK_NAME`, `TASK_DESC`, `TASK_PARAM`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('52', 'ACCOUNT_SETTLE_MONITOR_MNG', '核心账务记账监测', '核心账务记账监测', NULL, '1', 'sys', '2019-07-18 13:59:27', NULL, NULL);
INSERT INTO `settle`.`t_task_template` (`ID`, `TASK_CODE`, `TASK_NAME`, `TASK_DESC`, `TASK_PARAM`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('53', 'TASK_FILE_SCANPAY_ORDER_FILE', '推送银联商务文件', '推送银联商务文件', NULL, '1', 'sys', '2019-07-25 11:26:53', NULL, NULL);


INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('1', 'ALIPAY_COLLATE', '支付宝对账', '支付宝对账-包括账单入库', 'CASHIER_PAY_TRANS_SYN', '0 30 8 * * ?', '1', 'sys', '2017-12-28 15:15:41', 'sys', '2017-12-28 15:15:41');
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('2', 'JFDR_CLEAR', '积分兑入清分', '积分兑入清分-包括兑入明细和汇总', 'BUTLER_POINTS_ORDER_SYN', NULL, '1', 'sys', '2017-12-28 15:16:33', 'sys', '2017-12-28 15:16:33');
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('3', 'WXPAY_COLLATE', '微信对账', '微信对账-包括账单入库', 'CASHIER_PAY_TRANS_SYN', '0 0 11 * * ?', '1', 'sys', '2017-12-28 15:17:17', 'sys', '2018-05-30 18:47:51');
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('4', 'JFPAY_COLLATE', '积分核心对账', '积分核心对账', 'POINT_CORE_TXN_TABLE_SYN,POINT_CORE_ORIGIN_TABLE_SYN,CASHIER_PAY_TRANS_SYN', '0 0 2 * * ?', '1', 'sys', '2017-12-28 15:27:26', 'sys', '2017-12-28 15:27:26');
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('5', 'POINT_CORE_ORIGIN_TABLE_SYN', '积分核心交易溯源表同步', '积分核心交易溯源表同步', '', NULL, '1', 'sys', '2017-12-07 20:58:10', 'sys', '2017-12-07 20:58:10');
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('6', 'MALL_ORIGIN_TABLE_SYN', '商城溯源表同步', '商城溯源表同步', 'CASHIER_PAY_TRANS_SYN', NULL, '1', 'sys', '2017-12-28 15:27:31', 'sys', '2017-12-28 15:27:31');
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('7', 'POINT_CORE_TXN_TABLE_SYN', '积分核心交易表同步', '积分核心交易溯源表同步', '', NULL, '1', 'sys', '2017-12-07 20:58:10', 'sys', '2017-12-07 20:58:10');
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('8', 'MEMBER_INFO_TABLE_SYN', '会员表同步', '会员表同步', '', NULL, '1', 'sys', '2017-12-07 20:58:10', 'sys', '2017-12-07 20:58:10');
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('9', 'CASHIER_PAY_TRANS_SYN', '收银台支付记录同步', '收银台支付记录同步', '', NULL, '1', 'sys', '2017-12-07 20:58:10', 'sys', '2017-12-07 20:58:10');
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('10', 'CONSUME_SPLIT', '消费数据拆分', '消费数据拆分', 'POINT_CORE_ORIGIN_TABLE_SYN,MALL_ORIGIN_TABLE_SYN,POINT_CORE_TXN_TABLE_SYN,CASHIER_PAY_TRANS_SYN', NULL, '1', 'sys', '2017-12-27 19:50:22', 'sys', '2017-12-27 19:50:22');
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('11', 'MER_ORDER_CLEAR', '商户订单清分', '商户订单清分', 'CONSUME_SPLIT,ORDER_TABLE_SYS', NULL, '1', 'sys', '2017-12-07 20:58:11', 'sys', '2017-12-07 20:58:11');
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('12', 'MER_PRODUCT_CLEAR', '商户商品清分', '商户商品清分', 'MER_ORDER_CLEAR', NULL, '1', 'sys', '2017-12-07 20:58:11', 'sys', '2017-12-07 20:58:11');
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('13', 'MER_TOTEL_CLEAR', '商户汇总清分', '商户汇总清分', 'MER_ORDER_CLEAR,MER_PRODUCT_CLEAR,MER_ECard_CLEAR', NULL, '1', 'sys', '2017-12-07 20:58:11', 'sys', '2017-12-07 20:58:11');
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('14', 'MER_ORDER_FILE', '生成商户订单对账文件', '订单维度对账文件', 'MER_ORDER_CLEAR', NULL, '1', 'sys', '2017-12-10 11:15:03', 'sys', '2017-12-10 11:15:03');
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('15', 'MER_PRODUCT_FILE', '生成商户商品对账文件', '商品维度对账文件', 'MER_PRODUCT_CLEAR', NULL, '1', 'sys', '2017-12-10 11:15:11', 'sys', '2017-12-10 11:15:11');
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('16', 'OUTER_TRANS_DETAIL_CLEAR', '股东方交易明细清分', '股东方交易明细清分', 'POINTS_ACC_RDM_TABLE_SYS,CONSUME_SPLIT', NULL, '1', 'sys', '2017-12-07 20:58:11', 'sys', '2017-12-07 20:58:11');
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('17', 'OUTER_TRANS_TOTAL_CLEAR', '股东方交易汇总清分', '股东方交易汇总清分', 'OUTER_TRANS_DETAIL_CLEAR', NULL, '1', 'sys', '2017-12-07 20:58:11', 'sys', '2017-12-07 20:58:11');
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('18', 'MALL_ORDER_TABLE_SYN', '商城订单表同步', '商城订单表同步', '', NULL, '1', 'sys', '2017-12-07 20:58:12', 'sys', '2017-12-07 20:58:12');
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('19', 'JFZC_ORDER_TABLE_SYN', '众筹订单表同步', '众筹订单表同步', '', NULL, '1', 'sys', '2017-12-07 20:58:12', 'sys', '2017-12-07 20:58:12');
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('20', 'CASHIER_JFZC_FILE', '收银台众筹生成文件', '收银台众筹生成文件', '', NULL, '1', 'sys', '2017-12-07 20:58:12', 'sys', '2017-12-07 20:58:12');
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('21', 'CASHIER_MALL_FILE', '收银台商城生成文件', '收银台商城生成文件', '', NULL, '1', 'sys', '2017-12-07 20:58:12', 'sys', '2017-12-07 20:58:12');
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('22', 'MER_MALL_COLLATE', '商城对账', '商城对账', 'MALL_ORDER_TABLE_SYN,CASHIER_MALL_FILE', NULL, '1', 'sys', '2017-12-07 20:58:12', 'sys', '2017-12-07 20:58:12');
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('23', 'MER_JFZC_COLLATE', '众筹对账', '众筹对账', 'JFZC_ORDER_TABLE_SYN,CASHIER_JFZC_FILE', NULL, '1', 'sys', '2017-12-07 20:58:12', 'sys', '2017-12-07 20:58:12');
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('24', 'OUTER_EXCHANGE_CMCC_COLLATE', '股东方积分兑换对账-移动', '股东方积分兑换对账-移动', 'BUTLER_POINTS_ORDER_SYN', '0 0 11 * * ?', '1', 'sys', '2017-12-28 15:30:23', 'sys', '2018-05-30 18:48:01');
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('26', 'OUTER_EXCHANGE_MU_COLLATE', '股东方积分兑换对账-东航', '股东方积分兑换对账-东航', 'BUTLER_POINTS_ORDER_SYN', '0 0 11 * * ?', '1', 'sys', '2017-12-28 15:30:25', 'sys', '2018-05-30 18:48:08');
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('27', 'OUTER_CONSUME_CMCC_COLLATE', '股东方积分消费对账-移动', '股东方积分消费对账-移动', 'MALL_ORIGIN_TABLE_SYN', '0 0 11 * * ?', '1', 'sys', '2017-12-28 15:30:26', 'sys', '2018-05-30 18:48:16');
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('28', 'OUTER_CONSUME_MU_COLLATE', '股东方积分消费对账-东航', '股东方积分消费对账-东航', 'MALL_ORIGIN_TABLE_SYN', '0 0 11 * * ?', '1', 'sys', '2017-12-28 15:30:28', 'sys', '2018-05-30 18:48:24');
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('29', 'BUTLER_POINTS_ORDER_SYN', '管家订单表同步', '管家订单表同步', '', '', '1', 'sys', '2017-12-28 15:04:32', 'sys', '2017-12-28 15:04:32');
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('30', 'BOSC_PAY_DETAIL_FILE', '上海银行交易明细文件', '上海银行交易明细文件', '', '', '1', 'sys', '2017-12-28 15:39:26', 'sys', '2017-12-28 15:39:26');
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('31', 'POINT_TRIAL_BALANCE_COLLATE', '积分试算平衡对账', '积分试算平衡对账', 'POINTS_ACCOUNT_TABLE_SYS', '0 0 4 * * ?', '1', 'sys', '2018-02-06 13:23:08', 'sys', '2018-02-06 13:23:08');
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('33', 'MER_BUTLER_COLLATE', '收银台-积分管家对账', '收银台-积分管家对账', 'CASHIER_BUTLER_EX_SYN,BUTLER_POINTS_ORDER_SYN', '', '1', 'sys', '2018-02-05 15:02:18', 'sys', '2018-02-05 15:02:18');
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('34', 'CASHIER_BUTLER_EX_SYN', '收银台-积分管交易同步', '收银台-积分管交易同步', '', '', '1', 'sys', '2018-02-05 14:58:57', 'sys', '2018-02-05 14:58:57');
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('35', 'SECOND_TRACE_COLLATE', '二次溯源对账', '二次溯源和一次溯源对账', 'POINT_CORE_ORIGIN_TABLE_SYN,MALL_ORIGIN_TABLE_SYN,POINT_CORE_TXN_TABLE_SYN', '', '1', 'sys', '2018-03-05 10:18:55', 'sys', '2018-03-05 10:18:55');
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('36', 'POINTS_ACCOUNT_TABLE_SYS', '新增账户同步任务', '新增账户同步任务', 'POINT_CORE_TXN_TABLE_SYN,POINT_CORE_ORIGIN_TABLE_SYN', '0 0 4 * * ?', '1', 'sys', '2018-03-15 14:35:28', 'sys', '2018-03-15 14:35:28');
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('37', 'SYS_DIFF_HANDLE', '跨日差异关闭', '自动关闭跨日差异', 'POINT_CORE_ORIGIN_TABLE_SYN,POINT_CORE_TXN_TABLE_SYN,MALL_ORIGIN_TABLE_SYN,BUTLER_POINTS_ORDER_SYN,CASHIER_PAY_TRANS_SYN', '0 0 4 * * ?', '1', 'sys', '2018-05-10 22:41:23', 'sys', '2018-05-10 22:41:23');
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('38', 'ORDER_TABLE_SYS', '订单汇总对账', '订单汇总对账', '', '0 0 4 * * ?', '1', 'sys', '2018-05-10 22:41:43', 'sys', '2018-05-11 16:44:19');
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('39', 'POINTS_ACC_RDM_TABLE_SYS', '一次溯源同步', '一次溯源同步', '', '', '1', 'sys', '2018-06-21 14:28:51', 'sys', '2018-06-21 14:28:51');
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('40', 'ROC_AOU_FILE_FETCH', '中行消费量取文件', '中行消费量取文件', '', '0 0 4 * * ?', '0', 'sys', '2018-06-23 20:41:54', 'sys', '2018-06-23 20:41:54');
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('41', 'ROC_EXR_FILE_FETCH', '中行兑换量取文件', '中行兑换量取文件', '', '0 0/5 7 * * ?', '1', 'sys', '2018-06-23 20:42:55', 'sys', '2018-06-23 20:42:55');
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('42', 'SEND_ROC_EXR_FILE_FETCH', '中行兑换量发文件', '中行兑换量发文件', '', '0 30 0 ? * *', '1', 'sys', '2018-06-23 20:43:45', 'sys', '2018-06-23 20:43:45');
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('43', 'SEND_ROC_AOU_FILE_FETCH', '中行消费量发文件', '中行消费量发文件', '', '0 30 0 2,17 * *', '1', 'sys', '2018-06-23 20:44:38', 'sys', '2018-06-23 20:44:38');
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('44', 'MER_ECard_CLEAR', '商户卡券核销清分', '商户卡券核销清分', 'MER_ORDER_CLEAR', '', '1', 'sys', '2018-07-05 17:37:04', 'sys', '2018-07-05 17:37:04');
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('45', 'ZHPAY_COLLATE', '中行快捷支付', '中行快捷支付', 'CASHIER_PAY_TRANS_SYN', '0 0 11 * * ?', '1', 'sys', '2018-08-06 17:11:53', 'sys', '2018-08-06 17:11:53');
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('48', 'SYN_MALL_DATA_MNG', '商城', '商城', '', '', '1', 'sys', '2018-11-01 10:00:00', NULL, NULL);
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('49', 'SYN_COLLECT_COLLAGE_TEAM_MNG', '拼团数据', '拼团数据', '', '', '1', 'sys', '2018-11-01 10:00:00', NULL, NULL);
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('50', 'SYN_TRHOTELDB_DATA_MNG', '出行数据', '出行数据', '', '', '1', 'sys', '2018-11-01 10:00:00', NULL, NULL);
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('51', 'SYN_MER_CHANT_MNG', '积分扫描付', '积分扫描付', '', '', '1', 'sys', '2018-11-08 10:00:00', NULL, NULL);
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('52', 'SYN_PARTNER_TB_DATA', '合作方', '合作方', '', '', '1', 'sys', '2018-11-08 10:00:00', NULL, NULL);
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('53', 'OCCURRENCE_AMOUNT_COLLATE', '日发生额对账统计', '日发生额对账统计', 'MALL_ORIGIN_TABLE_SYN', '', '1', 'sys', '2018-11-09 11:42:43', 'sys', '2018-11-09 11:42:43');
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('56', 'TOTLE_MER_POINT', '花分入分统计', '花分入分统计', 'MALL_ORIGIN_TABLE_SYN,POINT_CORE_ORIGIN_TABLE_SYN,POINT_CORE_TXN_TABLE_SYN', '', '1', 'sys', '2018-11-28 17:12:41', 'sys', '2018-11-28 17:12:41');
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('57', 'ALARM_POINTS_TOTAL_MONTH', '积分消费汇总月告警', '积分消费汇总月告警', 'OUTER_TRANS_TOTAL_CLEAR', '', '1', 'sys', '2018-12-12 20:57:56', NULL, NULL);
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('58', 'ALARM_TASK_NODE', '任务节点执行结果统计', '任务节点执行结果统计', '', '0 0 8 * * ?', '1', 'sys', '2018-12-15 17:37:38', NULL, NULL);
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('59', 'SYN_TR_FLIGHT_TB_DATA_MNG', '机票tb', '机票tb', NULL, '', '0', 'sys', '2018-12-20 16:25:03', NULL, NULL);
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('60', 'SYN_TR_FLIGHT_TC_DATA_MNG', '机票tc', '机票tc', NULL, '', '0', 'sys', '2018-12-20 16:25:03', NULL, NULL);
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('61', 'SYN_TR_FOOD_DATA_MNG', '美食', '美食', NULL, '', '0', 'sys', '2018-12-20 16:25:03', NULL, NULL);
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('62', 'SEND_DIF_FILE_EXR_MNG', '中行兑换差异处理文件', '中行兑换差异处理文件', 'ROC_EXR_FILE_FETCH', '0 0/5 9 * * ?', '1', 'sys', '2018-12-21 16:42:06', NULL, NULL);
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('63', 'SYN_COLLECT_COUPON_DATA', '收集优惠券', '收集优惠券', 'SYN_TR_FOOD_DATA_MNG,SYN_TR_FLIGHT_TC_DATA_MNG,SYN_TR_FLIGHT_TB_DATA_MNG,SYN_MALL_DATA_MNG,SYN_COLLECT_COLLAGE_TEAM_MNG,SYN_TRHOTELDB_DATA_MNG,SYN_MER_CHANT_MNG,SYN_PARTNER_TB_DATA', '', '1', 'sys', '2019-01-08 17:56:40', NULL, NULL);
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('64', 'GEN_EXCEL_FILE', '生成excel文件', '生成excel文件', 'MER_TOTEL_CLEAR', '0 5 * 1 * ?', '1', 'sys', '2019-02-18 17:03:12', NULL, NULL);
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('65', 'ACCOUNT_DAY_CUT', '账务核心日切', '账务核心日切', 'COLLECT_CASHSETTLE,CYP_SETTLE_CLEAR,COLLECT_EXPIRE_POINT,GD_SETTLE_CLEAR,COLLCECT_MALL_COUPON,COLLECT_SETTLE_CLEAR', '0 0 1 * * ? ', '1', 'sys', '2019-02-19 14:28:11', 'zhangmeng1', '2019-06-10 18:00:30');
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('66', 'COLLECT_CASHSETTLE', '支付渠道清分采集', '支付渠道清分采集', '', '', '1', 'sys', '2019-03-05 18:41:44', NULL, NULL);
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('67', 'CYP_SETTLE_CLEAR', '畅由积分源清分', '畅由积分源清分', 'TASK_OUTER_JFXF_CLEAR', '', '1', 'sys', '2019-03-05 18:41:44', NULL, NULL);
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('68', 'COLLECT_EXPIRE_POINT', '积分过期采集器', '积分过期采集器', '', '', '1', 'sys', '2019-03-05 18:41:45', NULL, NULL);
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('69', 'GD_SETTLE_CLEAR', '非畅由积分源清分', '非畅由积分源清分', 'TASK_OUTER_JFXF_CLEAR', '', '1', 'sys', '2019-03-05 18:41:45', NULL, NULL);
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('70', 'COLLCECT_MALL_COUPON', '商城优惠券', '商城优惠券', '', '', '1', 'sys', '2019-03-05 18:41:45', NULL, NULL);
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('71', 'COLLECT_SETTLE_CLEAR', '结算清分采集器', '结算清分采集器', 'TASK_MER_CLEAR', '', '1', 'sys', '2019-03-05 18:41:46', NULL, NULL);
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('72', 'MER_ORDER_WITH_ACCOUNT_CLEAR', '商户订单清分与账务', '新商户清分', 'CONSUME_SPLIT,ORDER_TABLE_SYS', '', '1', 'sys', '2019-04-25 17:54:32', NULL, NULL);
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('73', 'ADD_PROVIDER_ORDER', '添加行权订单号', '添加行权订单号', 'MER_ORDER_CLEAR', '', '1', 'sys', '2019-05-09 17:52:04', NULL, NULL);
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('74', 'POINTS_EXCHANGE_SYN', '新零售订单收集', '新零售订单收集', NULL, '', '1', 'sys', '2019-07-11 11:20:28', NULL, NULL);
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('75', 'ACCOUNT_SETTLE_MONITOR_MNG', '核心账务记账监测', '核心账务记账监测', '', '0 0 6 * * ?', '1', 'sys', '2019-07-18 13:59:27', NULL, NULL);
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('76', 'SCANPAY_SYN', '银联商务数据同步', '银联商务数据同步', NULL, '', '1', 'sys', '2019-07-25 11:26:52', NULL, NULL);
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('77', 'FILE_SCANPAY_ORDER_FILE', '推送银联商务明细文件', '推送银联商务明细文件', 'SCANPAY_SYN', '', '1', 'sys', '2019-07-25 11:26:53', NULL, NULL);
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('87', 'CLEAR_PRODUCT_TOTAL', '商品清分和汇总清分', '商品清分和汇总清分', 'MER_ORDER_WITH_ACCOUNT_CLEAR', '', '1', 'sys', '2019-07-29 16:52:00', NULL, NULL);
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('88', 'CREATE_EXCEL_FILE', '对账单文件生成', '对账单文件生成', 'CLEAR_PRODUCT_TOTAL', '', '1', 'sys', '2019-07-29 16:52:00', NULL, NULL);
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('89', 'FETCH_SCANPAY_FILE_MNG', '获取银联对账文件', '获取银联对账文件', NULL, '', '1', 'sys', '2019-08-15 10:03:10', NULL, NULL);
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('90', 'FETCH_SCANPAY_FILE_MNG', '获取银联对账文件', '获取银联对账文件', NULL, '0 1 11 * * ?', '1', 'sys', '2019-08-16 14:16:05', NULL, NULL);
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('91', 'FILE_RUI_XIAN_MNG', '江苏瑞祥积分', '江苏瑞祥积分', NULL, '', '1', 'sys', '2019-09-23 17:44:31', NULL, NULL);
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('92', 'FILE_RUI_XIAN_MNG', '江苏瑞祥积分', '江苏瑞祥积分', NULL, '', '1', 'sys', '2019-09-23 17:44:51', NULL, NULL);
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('93', 'FILE_RUI_XIAN_MNG', '江苏瑞祥积分', '江苏瑞祥积分', NULL, '', '1', 'sys', '2019-09-24 16:35:45', NULL, NULL);
INSERT INTO `settle`.`t_task_node_template` (`ID`, `NODE_CODE`, `NODE_NAME`, `NODE_DESC`, `FRONT_NODE`, `START_TIME_CRON`, `STATUS`, `CREATE_USER`, `CREATE_TIME`, `MODIFY_USER`, `MODIFY_TIME`) VALUES ('94', 'CLEAR_SETTLE_MONITOR', '统计T日清分明细中结算价为0元的总笔数', '统计T日清分明细中结算价为0元的总笔数', 'MER_ORDER_CLEAR', '', '0', 'sys', '2019-10-30 16:56:27', 'sys', '2019-10-30 16:56:27');


INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('1', 'TASK_COMMON_TABLE_SYS', 'MEMBER_INFO_TABLE_SYN', '1', '2017-12-28 15:56:02');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('2', 'TASK_COMMON_TABLE_SYS', 'POINT_CORE_ORIGIN_TABLE_SYN', '2', '2017-12-10 12:15:41');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('3', 'TASK_COMMON_TABLE_SYS', 'MALL_ORIGIN_TABLE_SYN', '3', '2017-12-10 12:15:41');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('4', 'TASK_COMMON_TABLE_SYS', 'POINT_CORE_TXN_TABLE_SYN', '4', '2017-12-10 12:15:41');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('5', 'TASK_COMMON_TABLE_SYS', 'CASHIER_PAY_TRANS_SYN', '5', '2017-12-10 12:15:41');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('6', 'TASK_CHANNEL_COLLATE', 'ALIPAY_COLLATE', '3', '2017-12-28 15:56:14');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('7', 'TASK_CHANNEL_COLLATE', 'WXPAY_COLLATE', '2', '2017-12-10 12:15:41');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('8', 'TASK_CHANNEL_COLLATE', 'JFPAY_COLLATE', '1', '2017-12-28 15:56:12');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('9', 'TASK_MER_JFZC_COLLATE', 'JFZC_ORDER_TABLE_SYN', '1', '2017-12-10 12:15:42');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('10', 'TASK_MER_JFZC_COLLATE', 'CASHIER_JFZC_FILE', '2', '2017-12-10 12:15:42');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('11', 'TASK_MER_JFZC_COLLATE', 'MER_JFZC_COLLATE', '3', '2017-12-10 12:15:42');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('12', 'TASK_MER_MALL_COLLATE', 'MALL_ORDER_TABLE_SYN', '1', '2017-12-10 12:15:42');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('13', 'TASK_MER_MALL_COLLATE', 'CASHIER_MALL_FILE', '2', '2017-12-10 12:15:42');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('14', 'TASK_MER_MALL_COLLATE', 'MER_MALL_COLLATE', '3', '2017-12-10 12:15:42');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('15', 'TASK_CONSUME_SPLIT', 'CONSUME_SPLIT', '1', '2017-12-10 12:15:42');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('16', 'TASK_MER_CLEAR', 'MER_ORDER_CLEAR', '1', '2017-12-28 15:53:52');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('17', 'TASK_MER_CLEAR', 'MER_PRODUCT_CLEAR', '2', '2017-12-28 15:53:58');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('18', 'TASK_MER_CLEAR', 'MER_ORDER_FILE', '4', '2017-12-10 12:15:42');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('19', 'TASK_MER_CLEAR', 'MER_PRODUCT_FILE', '5', '2017-12-28 15:53:47');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('20', 'TASK_MER_CLEAR', 'MER_TOTEL_CLEAR', '3', '2017-12-28 15:53:45');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('21', 'TASK_OUTER_JFXF_CLEAR', 'OUTER_TRANS_DETAIL_CLEAR', '1', '2017-12-10 12:15:43');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('22', 'TASK_OUTER_JFXF_CLEAR', 'OUTER_TRANS_TOTAL_CLEAR', '2', '2017-12-28 15:56:42');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('23', 'TASK_OUTER_JFDR_CLEAR', 'JFDR_CLEAR', '1', '2017-12-10 12:15:43');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('24', 'TASK_COMMON_TABLE_SYS', 'BUTLER_POINTS_ORDER_SYN', '6', '2017-12-28 15:56:07');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('25', 'TASK_OUTER_COLLATE', 'OUTER_EXCHANGE_CMCC_COLLATE', '1', '2017-12-28 16:23:04');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('26', 'TASK_OUTER_COLLATE', 'OUTER_EXCHANGE_MU_COLLATE', '2', '2017-12-28 16:23:06');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('27', 'TASK_OUTER_COLLATE', 'OUTER_CONSUME_CMCC_COLLATE', '3', '2017-12-28 16:23:08');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('28', 'TASK_OUTER_COLLATE', 'OUTER_CONSUME_MU_COLLATE', '4', '2017-12-28 16:23:11');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('29', 'TASK_COMMON_FILE_UPLOAD', 'BOSC_PAY_DETAIL_FILE', '1', '2017-12-28 15:57:22');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('30', 'TASK_TRIAL_BALANCE_COLLATE', 'POINT_TRIAL_BALANCE_COLLATE', '2', '2018-02-06 13:23:09');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('32', 'TASK_MER_BUTLER_COLLATE', 'CASHIER_BUTLER_EX_SYN', '1', '2018-02-05 15:14:42');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('33', 'TASK_MER_BUTLER_COLLATE', 'MER_BUTLER_COLLATE', '2', '2018-02-05 15:14:17');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('34', 'TASK_CHANNEL_COLLATE', 'SECOND_TRACE_COLLATE', '4', '2018-03-05 10:18:57');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('35', 'TASK_TRIAL_BALANCE_COLLATE', 'POINTS_ACCOUNT_TABLE_SYS', '1', '2018-03-15 14:35:11');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('36', 'TASK_CROSS_DIFF_CLOSE', 'SYS_DIFF_HANDLE', '1', '2018-05-10 22:41:24');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('37', 'TASK_ORDER', 'ORDER_TABLE_SYS', '1', '2018-05-10 22:41:44');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('38', 'TASK_COMMON_TABLE_SYS', 'POINTS_ACC_RDM_TABLE_SYS', '6', '2018-06-21 14:29:09');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('39', 'ROC_AOU_FILE_FETCH', 'ROC_AOU_FILE_FETCH', '1', '2018-06-23 20:42:09');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('40', 'ROC_EXR_FILE_FETCH', 'ROC_EXR_FILE_FETCH', '1', '2018-06-23 20:43:10');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('41', 'SEND_ROC_EXR_FILE_FETCH', 'SEND_ROC_EXR_FILE_FETCH', '1', '2018-06-23 20:43:57');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('42', 'SEND_ROC_AOU_FILE_FETCH', 'SEND_ROC_AOU_FILE_FETCH', '1', '2018-06-23 20:44:51');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('43', 'TASK_MER_CLEAR', 'MER_ECard_CLEAR', '6', '2018-07-05 17:37:15');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('44', 'TASK_CHANNEL_COLLATE', 'ZHPAY_COLLATE', '1', '2018-08-06 17:12:03');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('47', 'TASK_CHECK_DATA_MNG', 'SYN_MALL_DATA_MNG', '1', '2018-11-01 10:00:00');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('48', 'TASK_CHECK_DATA_MNG', 'SYN_COLLECT_COLLAGE_TEAM_MNG', '1', '2018-11-01 10:00:00');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('49', 'TASK_CHECK_DATA_MNG', 'SYN_TRHOTELDB_DATA_MNG', '1', '2018-11-01 10:00:00');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('50', 'TASK_CHECK_DATA_MNG', 'SYN_MER_CHANT_MNG', '1', '2018-11-08 10:00:00');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('51', 'TASK_CHECK_DATA_MNG', 'SYN_PARTNER_TB_DATA', '1', '2018-11-08 10:00:00');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('52', 'TASK_CHANNEL_COLLATE', 'OCCURRENCE_AMOUNT_COLLATE', '5', '2018-11-09 11:42:43');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('55', 'TASK_CHANNEL_COLLATE', 'TOTLE_MER_POINT', '6', '2018-11-28 17:12:41');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('56', 'TASK_ALARM_POINTSTOTAL_MNG', 'ALARM_POINTS_TOTAL_MONTH', '1', '2018-12-12 20:57:56');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('57', 'TASK_ALARM_POINTSTOTAL_MNG', 'ALARM_TASK_NODE', '2', '2018-12-15 17:37:38');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('58', 'TASK_CHECK_DATA_MNG', 'SYN_TR_FLIGHT_TB_DATA_MNG', '1', '2018-12-20 16:25:03');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('59', 'TASK_CHECK_DATA_MNG', 'SYN_TR_FLIGHT_TC_DATA_MNG', '1', '2018-12-20 16:25:04');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('60', 'TASK_CHECK_DATA_MNG', 'SYN_TR_FOOD_DATA_MNG', '1', '2018-12-20 16:25:04');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('61', 'SEND_DIF_FILE_EXR_MNG', 'SEND_DIF_FILE_EXR_MNG', '1', '2018-12-21 16:42:06');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('62', 'TASK_CHECK_DATA_MNG', 'SYN_COLLECT_COUPON_DATA', '1', '2019-01-08 17:56:40');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('63', 'GEN_EXCEL_FILE', 'GEN_EXCEL_FILE', '8', '2019-02-18 17:03:12');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('64', 'ACCOUNT_DAY_CUT', 'ACCOUNT_DAY_CUT', '1', '2019-02-19 14:28:11');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('65', 'COLLECT_ACCOUNT_DATA', 'COLLCECT_MALL_COUPON', '1', '2019-03-05 18:41:46');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('66', 'COLLECT_ACCOUNT_DATA', 'COLLECT_EXPIRE_POINT', '1', '2019-03-05 18:41:46');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('67', 'COLLECT_ACCOUNT_DATA', 'COLLECT_CASHSETTLE', '2', '2019-03-05 18:41:46');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('68', 'COLLECT_ACCOUNT_DATA', 'GD_SETTLE_CLEAR', '3', '2019-03-05 18:41:46');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('69', 'COLLECT_ACCOUNT_DATA', 'COLLECT_SETTLE_CLEAR', '3', '2019-03-05 18:41:46');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('70', 'COLLECT_ACCOUNT_DATA', 'CYP_SETTLE_CLEAR', '3', '2019-03-05 18:41:46');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('71', 'TASK_MER_CLEAR', 'MER_ORDER_WITH_ACCOUNT_CLEAR', '1', '2019-04-25 17:54:32');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('72', 'TASK_MER_CLEAR', 'ADD_PROVIDER_ORDER', '1', '2019-05-09 17:51:52');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('73', 'TASK_COMMON_TABLE_SYS', 'POINTS_EXCHANGE_SYN', '1', '2019-07-11 11:20:29');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('74', 'ACCOUNT_SETTLE_MONITOR_MNG', 'ACCOUNT_SETTLE_MONITOR_MNG', '1', '2019-07-18 13:59:27');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('75', 'TASK_COMMON_TABLE_SYS', 'SCANPAY_SYN', '1', '2019-07-25 11:26:52');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('76', 'TASK_FILE_SCANPAY_ORDER_FILE', 'FILE_SCANPAY_ORDER_FILE', '1', '2019-07-25 11:26:53');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('83', 'TASK_MER_CLEAR', 'CLEAR_PRODUCT_TOTAL', '7', '2019-07-29 16:52:00');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('84', 'TASK_MER_CLEAR', 'CREATE_EXCEL_FILE', '7', '2019-07-29 16:52:00');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('85', 'TASK_FILE_SCANPAY_ORDER_FILE', 'FETCH_SCANPAY_FILE_MNG', '2', '2019-08-15 10:04:29');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('86', 'TASK_FILE_SCANPAY_ORDER_FILE', 'FETCH_SCANPAY_FILE_MNG', '2', '2019-08-16 14:17:03');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('87', 'GEN_EXCEL_FILE', 'FILE_RUI_XIAN_MNG', '1', '2019-09-23 17:44:42');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('88', 'GEN_EXCEL_FILE', 'FILE_RUI_XIAN_MNG', '1', '2019-09-24 16:35:45');
INSERT INTO `settle`.`t_task_node_template_rel` (`ID`, `TASK_CODE`, `NODE_CODE`, `PRIORITY`, `CREATE_TIME`) VALUES ('89', 'TASK_ALARM_POINTSTOTAL_MNG', 'CLEAR_SETTLE_MONITOR', '3', '2019-10-30 16:56:23');
