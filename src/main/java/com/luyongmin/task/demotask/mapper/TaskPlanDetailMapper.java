package com.luyongmin.task.demotask.mapper;

import com.luyongmin.task.demotask.domain.TaskPlanDetail;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @author: lu.yongmin
 * @date: 2020/3/6 14:28
 * @description:
 */
public interface TaskPlanDetailMapper {
    /**
     * 更加计划id和状态查询计划明细
     * @param id
     * @param s
     * @return
     */
    List<TaskPlanDetail> queryByPlanIdAndStatus(@Param("planId") Long id, @Param("status") String s);



    /**
     * 根据条件查询任务
     * @param paramMap
     * @return
     */
    List<TaskPlanDetail> queryByParam(Map<String,Object> paramMap);

    /**
     * 插入一条记录
     */
    int add(TaskPlanDetail planDetail);
    /**
     * 批量插入
     * @param planDetailList
     */
    void batchInsert(List<TaskPlanDetail> planDetailList);


}
