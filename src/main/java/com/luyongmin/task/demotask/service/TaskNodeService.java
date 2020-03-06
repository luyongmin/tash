package com.luyongmin.task.demotask.service;

import com.luyongmin.task.demotask.constant.ErrorCode;
import com.luyongmin.task.demotask.domain.TaskNode;

import java.util.List;
import java.util.Map;

/**
 * @author: lu.yongmin
 * @date: 2020/3/6 15:47
 * @description:
 */
public interface TaskNodeService {


    /**
     * 批次新增
     * @param nodeList
     */
    void batchInsert(List<TaskNode> nodeList, Long taskId);

    /**
     * 根据任务查询节点
     * @param taskId
     * @return
     */
    List<TaskNode> queryByTask(Long taskId);

    /**
     * 重启任务节点
     * @param taskIdNodeList
     */
    void reloadTaskNode(List<Long> taskIdNodeList,String reloadUser,boolean onlyReloadNode);

    /**
     * 根据条件查询节点
     * @param paramMap
     * @return
     */
    List<TaskNode> queryByParam(Map<String,Object> paramMap);


    /**
     * 根据任务ID查询明细
     * @param taskId
     * @return
     */
    List<TaskNode> queryNodeByTaskId(Long taskId);


    /**
     * 更新令牌
     * @param taskNode
     * @param token
     */
    void updateToken(TaskNode taskNode, String token,String modifyUser);


    /**
     * 设置节点处理中
     * @param taskNode
     */
    void setNodeExeing(TaskNode taskNode);


    /**
     * 设置节点失败
     * @param taskNode
     * @param eCode
     * @param msg
     */
    void setNodeFail(TaskNode taskNode, ErrorCode eCode, String msg);


    /**
     * 设置节点成功
     * @param taskNode
     */
    void setNodeSucc(TaskNode taskNode);
}
