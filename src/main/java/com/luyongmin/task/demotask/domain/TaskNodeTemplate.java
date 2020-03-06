package com.luyongmin.task.demotask.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.io.Serializable;
import java.util.Date;

/**
 * @author: lu.yongmin
 * @date: 2020/3/6 15:14
 * @description:任务节点模板
 */
@ToString
@Getter
@Setter
public class TaskNodeTemplate implements Serializable {

    private static final long serialVersionUID = 2430711213307565695L;

    /**
     * id
     */
    private Long id;
    /**
     * 节点编号
     */
    private String nodeCode;
    /**
     * 节点名称
     */
    private String nodeName;
    /**
     * 节点描述
     */
    private String nodeDesc;
    /**
     * 前置节点(逗号分隔)
     */
    private String frontNode;
    /**
     * 开始时间CRON
     */
    private String startTimeCron;
    /**
     * 状态
     */
    private String status;
    /**
     * 创建用户
     */
    private String createUser;
    /**
     * 创建时间
     */
    private Date createTime;
    /**
     * 修改用户
     */
    private String modifyUser;
    /**
     * 修改时间
     */
    private Date modifyTime;
    /**
     * 优先级
     */
    private Integer priority;

}
