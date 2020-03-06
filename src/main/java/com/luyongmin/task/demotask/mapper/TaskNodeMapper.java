package com.luyongmin.task.demotask.mapper;

import com.luyongmin.task.demotask.domain.TaskNode;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author: lu.yongmin
 * @date: 2020/3/6 16:17
 * @description: 任务节点处理
 */
public interface TaskNodeMapper {


    /**
     * 根据条件查询任务明细
     * @param paramMap
     * @return
     */
    List<TaskNode> queryByParam(Map<String,Object> paramMap);

    /**
     * 根据条件查询任务明细
     * @param paramMap
     * @return
     */
    List<TaskNode> queryByParam1(Map<String,Object> paramMap);



    /**
     * 插入一条记录
     */
    int add(TaskNode taskNode);

    /**
     * 根绝任务编号删除
     * @param taskId
     */
    void deleteByTask(Long taskId);

    /**
     * 批次修改任务节点状态
     * @param param
     * @return
     */
    int batchUpdateStatus(Map<String,Object> param);
    /**
     * 查询一条记录
     * @param param
     * @return
     */

    TaskNode queryByParamSingle(HashMap<String, Object> param);


    /**
     * 更新执行令牌
     * @param id
     * @param modifyUser
     * @param token
     */
    void updateToken(TaskNode taskNode);


    /**
     * 更新任务节点状态
     * @param nodeId
     * @param modifyUser
     * @param status
     */
    public void updateStatus(TaskNode taskNode);
}
