package com.luyongmin.task.demotask.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.Date;
import java.util.List;

/**
 * @author: lu.yongmin
 * @date: 2020/3/6 14:00
 * @description:
 */
@Getter
@Setter
@ToString
public class TaskPlan {

    private static final long serialVersionUID = -5891297176506031159L;
    /**
     * 主键
     */
    private Long id;
    /**
     * 计划名称
     */
    private String planName;
    /**
     * 计划描述
     */
    private String planDesc;
    /**
     * 计划类型
     */
    private String planType;
    /**
     * 状态
     */
    private String status;
    /**
     * 清算开始时间
     */
    private String settleTimeStart;
    /**
     * 清算结束时间
     */
    private String settleTimeEnd;
    /**
     * 执行时间cron
     */
    private String executeCron;
    /**
     * 上次执行时间
     */
    private Date lastExtTime;
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
     * 任务计划明细
     */
    private List<TaskPlanDetail> planDetailList;
}
