package com.luyongmin.task.demotask.mapper;

import com.luyongmin.task.demotask.domain.TaskTemplate;

import java.util.List;

/**
 * @author: lu.yongmin
 * @date: 2020/3/6 15:20
 * @description:
 */
public interface TaskTemplateMapper {


    /**
     * 根据编号查询任务模板
     * @param taskCode
     * @return
     */
    TaskTemplate queryByCode(String taskCode);

    /**
     * 查询所有的任务模板
     * @return
     */
    List<TaskTemplate> queryAll();
}
