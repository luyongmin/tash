package com.luyongmin.task.demotask.factory;

import com.luyongmin.task.demotask.domain.TaskNode;
import com.luyongmin.task.demotask.service.TaskNodeMngInf;

/**
 * @author: lu.yongmin
 * @date: 2020/3/6 17:50
 * @description:
 */
public interface TaskNodeMngFactory {
    /**
     * 根据任务节点选择管理对象
     * @param node
     * @return
     */
    TaskNodeMngInf getManager(TaskNode node);
}
