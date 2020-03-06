package com.luyongmin.task.demotask.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.Date;

/**
 * @author: lu.yongmin
 * @date: 2020/3/6 14:03
 * @description:
 */
@Getter
@Setter
@ToString
public class TaskPlanDetail {

    /**
     * 编号
     */
    private Long id;
    /**
     * 计划ID
     */
    private Long planId;
    /**
     * 任务编号
     */
    private String taskCode;
    /**
     * 任务名称
     */
    private String taskName;
    /**
     * 任务参数
     */
    private String taskParam;
    /**
     * 任务CRON
     */
    private String taskCron;
    /**
     * 状态
     */
    private String status;
    /**
     * 优先级
     */
    private Integer priority;
    /**
     * 创建时间
     */
    private Date createTime;
    /**
     * 修改时间
     */
    private Date modifyTime;
}
