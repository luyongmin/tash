package com.luyongmin.task.demotask.service;

import com.luyongmin.task.demotask.domain.TaskPlan;

import java.util.List;

/**
 * @author: lu.yongmin
 * @date: 2020/3/6 13:59
 * @description:
 */
public interface TaskPlanService {

    /**
     * 根据计划创建任务
     * @param plan
     */
    void createTask(TaskPlan plan);

    /**
     * 查询有效的清结算计划
     * @return
     */
    List<TaskPlan> queryValidPlan();

    /**
     * 更新计划
     * @param taskPlan
     */
    void update(TaskPlan taskPlan);

    /**
     * 查询计划
     */
    List<TaskPlan> queryTaskPlanByPage();
}
