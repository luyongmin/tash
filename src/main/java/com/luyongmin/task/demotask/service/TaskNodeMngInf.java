package com.luyongmin.task.demotask.service;

import com.luyongmin.task.demotask.domain.TaskNode;

/**
 * @author: lu.yongmin
 * @date: 2020/3/6 17:51
 * @description:任务处理
 */
public interface TaskNodeMngInf {


    /**
     * 验证节点是否可以执行
     * @param taskNode
     * @param settleDate
     */
    void validateExecute(TaskNode taskNode,String settleDate);

    /**
     * 执行任务
     * @param task
     */
    void execute(TaskNode taskNode, String settleDate) throws Exception;


    /**
     * 节点编号
     * @return
     */
    String getNodeCode();
}
