package com.luyongmin.task.demotask.mapper;

import com.luyongmin.task.demotask.domain.Task;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author: lu.yongmin
 * @date: 2020/3/6 15:46
 * @description: 任务处理
 */
public interface TaskMapper {

    /**
     * 根据任务ID
     * @param id
     * @return
     */
    Task queryById(Long id);

    /**
     * 根据条件查询任务
     * @param paramMap
     * @return
     */
    List<Task> queryByParam(Map<String,Object> paramMap);

    /**
     * 插入一条记录
     */
    int add(Task task);

    /**
     * 批次更新任务状态
     * @param paramMap
     */
    void batchUpdateStatus(Map<String,Object> paramMap);

    Task queryByParamSingle(HashMap<String, Object> param);


    /**
     * 更新任务状态
     * @param task
     */
    void updateStatus(Task task);

    /**
     * 根据清算日期查询任务
     * @param settleDate
     * @return
     */
    public List<Task> queryBySettleDate(String settleDate);
}
