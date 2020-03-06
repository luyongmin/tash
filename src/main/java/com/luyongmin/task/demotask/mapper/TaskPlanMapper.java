package com.luyongmin.task.demotask.mapper;

import com.luyongmin.task.demotask.domain.TaskPlan;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * @author: lu.yongmin
 * @date: 2020/3/6 14:22
 * @description:
 */
public interface TaskPlanMapper {

    /**
     * 根据ID查询任务计划
     * @param planId
     * @return
     */
    TaskPlan queryById(Long planId);

    /**
     * 根据状态查询执行计划
     * @param status
     * @return
     */
    List<TaskPlan> queryByStatus(@Param("status") String status);


    /**
     * 插入一条记录
     */
    int add(TaskPlan plan);

    /**
     * 更新记录状态
     * @param plan
     * @return
     */
    int update(TaskPlan plan);
}
