package com.luyongmin.task.demotask.mapper;

import com.luyongmin.task.demotask.domain.TaskNodeTemplate;

import java.util.List;

/**
 * @author: lu.yongmin
 * @date: 2020/3/6 15:21
 * @description:
 */
public interface TaskNodeTemplateMapper {

    /**
     * 根据编号查询任务节点模板
     * @param taskCode
     * @return
     */
    public List<TaskNodeTemplate> queryByTaskCode(String taskCode);
}
