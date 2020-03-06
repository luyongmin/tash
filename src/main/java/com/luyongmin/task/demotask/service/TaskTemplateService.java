package com.luyongmin.task.demotask.service;

import com.luyongmin.task.demotask.domain.TaskTemplate;

/**
 * @author: lu.yongmin
 * @date: 2020/3/6 15:19
 * @description:
 */
public interface TaskTemplateService {

    /**
     * 根据任务编号查询任务模板
     * @param taskCode
     * @return
     */
    TaskTemplate queryCacheByCode(String taskCode);
}
