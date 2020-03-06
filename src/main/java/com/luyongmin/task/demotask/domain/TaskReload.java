package com.luyongmin.task.demotask.domain;

import com.luyongmin.task.demotask.enums.TaskReloadStrategy;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.io.Serializable;
import java.util.List;

/**
 * @author: lu.yongmin
 * @date: 2020/3/6 15:38
 * @description: 任务重载
 */
@Getter
@Setter
@ToString
public class TaskReload implements Serializable{

    private static final long serialVersionUID = -4821774890540277892L;
    /**
     * 计划ID
     */
    private Long planId;
    /**
     * 清算日期
     */
    private String settleDate;
    /**
     * 任务ID列表
     */
    private List<Long> taskIdList;
    /**
     * 任务节点列表
     */
    private List<Long> taskNodeIdList;
    /**
     * 策略
     */
    private TaskReloadStrategy strategy;
    /**
     * 重载用户
     */
    private String reloadUser;
}
