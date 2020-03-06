package com.luyongmin.task.demotask.service;

import com.luyongmin.task.demotask.domain.*;

import java.util.List;

/**
 * @author: lu.yongmin
 * @date: 2020/3/6 15:33
 * @description:
 */
public interface TaskService {

    /**
     * 根据条件查询
     * @param taskQuery
     * @return
     */
    List<Task> queryByParam(TaskQuery taskQuery);

    /**
     * 根据主键查询任务信息
     * @param id
     * @return
     */
    Task queryById(Long id);


    /**
     * 批量创建任务
     * @param taskList
     */
    void batchInsert(List<Task> taskList);

    /**
     * 重载任务
     * @param taskReload
     */
    void reloadTask(TaskReload taskReload);
    /**
     * 根据主键查询计划信息
     * @param planId
     * @return
     */
    TaskPlan queryPlanById(Long planId);
    /**
     * 根据条件查询计划详情列表
     * @param taskQuery
     * @return
     */
    List<TaskPlanDetail> queryPlanDetailListByParam(TaskQuery taskQuery);
    /**
     * 复制计划
     * @param taskPlan
     */
    void copyPlan(TaskPlan taskPlan);


    /**
     * 查询未完成的任务
     * @return
     */
    List<Task> queryWaitingTask();

    /**
     * 分配任务令牌
     * @param task
     * @param ipList
     */
    void allocationToken(Task task, List<String> ipList);

    /**
     * 查询已调度任务
     * @return
     */
    List<Task> queryDispatchTask();

    /**
     * 设置任务结束
     * @param taskId
     * @param modifyUser
     */
    public void setTaskEnd(Long taskId,String modifyUser);

    /**
     * 根据清算日期查询任务信息
     * @param planId
     * @return
     */
    public List<Task> queryBySettleDate(String settleDate);
}
