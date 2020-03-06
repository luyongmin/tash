package com.luyongmin.task.demotask.service;

import com.luyongmin.task.demotask.domain.Task;
import com.luyongmin.task.demotask.domain.TaskNode;

import java.util.List;

/**
 * @author: lu.yongmin
 * @date: 2020/3/6 17:46
 * @description:
 */
public interface TaskNodeExecuteService {


    /**
     * 执行任务节点
     * @param taskNode
     */
    void execute(TaskNode taskNode);

    /**
     * 排序任务节点
     * @param taskList
     * @return
     */
    List<TaskNode> sortTaskNode(List<Task> taskList, Integer maxCount);

    /**
     * 执行tasknodeList
     * @author ye.yangyang
     * 2018年3月5日
     * @param taskNodeList
     */
    void execute(List<TaskNode> taskNodeList,int waitTime);
}
