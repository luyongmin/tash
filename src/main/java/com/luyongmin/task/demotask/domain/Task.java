package com.luyongmin.task.demotask.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * @author: lu.yongmin
 * @date: 2020/3/6 15:04
 * @description:任务
 */
@Getter
@Setter
@ToString
public class Task  implements Serializable {

    private static final long serialVersionUID = 6486047777019793341L;
    /**
     * 主键
     */
    private Long id;
    /**
     * 任务编号
     */
    private String taskCode;
    /**
     * 任务名称
     */
    private String taskName;
    /**
     * 计划ID
     */
    private Long planId;
    /**
     * 任务参数
     */
    private String taskParam;
    /**
     * 任务开始时间
     */
    private Date taskStartTime;
    /**
     * 状态
     */
    private String status;
    /**
     * 优先级
     */
    private Integer priority;
    /**
     * 结算日期
     */
    private String settleDate;
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
    //
    private String modifyUser;
    /**
     * 修改时间
     */
    private Date modifyTime;
    /**
     * 任务节点
     */
    private List<TaskNode> taskNodeList;
}
