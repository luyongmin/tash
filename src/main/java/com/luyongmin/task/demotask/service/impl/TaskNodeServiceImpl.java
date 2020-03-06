package com.luyongmin.task.demotask.service.impl;

import com.luyongmin.task.demotask.constant.Constant;
import com.luyongmin.task.demotask.constant.ErrorCode;
import com.luyongmin.task.demotask.convert.TaskNodeConvert;
import com.luyongmin.task.demotask.domain.TaskNode;
import com.luyongmin.task.demotask.enums.TaskNodeStatus;
import com.luyongmin.task.demotask.enums.TaskStatus;
import com.luyongmin.task.demotask.mapper.TaskMapper;
import com.luyongmin.task.demotask.mapper.TaskNodeMapper;
import com.luyongmin.task.demotask.service.TaskNodeService;
import com.luyongmin.task.demotask.service.TaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author: lu.yongmin
 * @date: 2020/3/6 15:50
 * @description:任务明细
 */
@Service
public class TaskNodeServiceImpl implements TaskNodeService {

    @Resource
    private TaskNodeMapper taskNodeMapper;

    @Resource
    private TaskMapper taskMapper;

    @Autowired
    private TaskService taskService;



    /**
     * 批次新增
     * @param nodeList
     */
    @Override
    public void batchInsert(List<TaskNode> nodeList, Long taskId){
        if(nodeList != null){
            for(TaskNode taskNode : nodeList){
                taskNode.setTaskId(taskId);
                taskNodeMapper.add(taskNode);
            }
        }
    }

    /**
     * 根据任务查询节点
     * @param taskId
     * @return
     */
    @Override
    public List<TaskNode> queryByTask(Long taskId){
        Map<String,Object> paramMap = new HashMap<String,Object>();
        paramMap.put("taskId", taskId);

        return queryByParam(paramMap);
    }

    /**
     * 根据条件查询节点
     * @param paramMap
     * @return
     */
    @Override
    public List<TaskNode> queryByParam(Map<String,Object> paramMap){

        List<TaskNode> taskNodeList = taskNodeMapper.queryByParam(paramMap);

        return taskNodeList;
    }

    /**
     * 重载任务节点
     * @param nodeIdList
     */
    @Override
    @Transactional(propagation= Propagation.REQUIRED,rollbackFor = Exception.class)
    public void reloadTaskNode(List<Long> nodeIdList,String reloadUser,boolean onlyReloadNode) {

        if(nodeIdList != null && nodeIdList.size()>0){
            Map<String,Object> paramMap = new HashMap<String,Object>();
            paramMap.put("taskNodeIdList", nodeIdList);
            paramMap.put("status", TaskNodeStatus.WAIT_EXE.getCode());
            paramMap.put("executeToken", "");
            paramMap.put("respCode", "");
            paramMap.put("respMsg", "");
            paramMap.put("modifyUser", reloadUser);

            taskNodeMapper.batchUpdateStatus(paramMap);
        }

        if(onlyReloadNode){  //如果是单独重载节点，需要设置任务为处理中
            Map<String,Object> paramMap = new HashMap<String,Object>();
            paramMap.put("taskNodeIdList", nodeIdList);

            List<TaskNode> taskNodeList = queryByParam(paramMap);

            List<Long> taskIdList = TaskNodeConvert.convertIdList(taskNodeList);

            if(!CollectionUtils.isEmpty(taskIdList)){
                paramMap = new HashMap<String,Object>();
                paramMap.put("taskIdList", taskIdList);
                paramMap.put("status", TaskStatus.WAIT_EXE.getCode());
                paramMap.put("modifyUser", reloadUser);

                taskMapper.batchUpdateStatus(paramMap);

            }

        }
    }

    /**
     * 根据任务ID查询明细
     * @param taskId
     * @return
     */
    @Override
    public List<TaskNode> queryNodeByTaskId(Long taskId){
        Map<String,Object> paramMap = new HashMap<String,Object>();
        paramMap.put("taskId", taskId);

        return taskNodeMapper.queryByParam1(paramMap);
    }



    /**
     * 更新令牌
     * @param taskNode
     * @param token
     */
    @Override
    public void updateToken(TaskNode taskNode, String token,String modifyUser){
        TaskNode modifyNode = new TaskNode();
        modifyNode.setId(taskNode.getId());
        modifyNode.setExecuteToken(token);
        modifyNode.setModifyUser(modifyUser);

        taskNodeMapper.updateToken(modifyNode);
    }


    /**
     * 设置节点失败
     * @param taskNode
     * @param eCode
     * @param msg
     */
    @Transactional(propagation = Propagation.REQUIRED,rollbackFor = Exception.class)
    @Override
    public void setNodeFail(TaskNode taskNode, ErrorCode eCode, String msg) {
        //更新状态为失败，超过长度截取
        if(!StringUtils.isEmpty(msg) && msg.length()>100){
            msg = msg.substring(0,100);
        }
        //更新节点失败
        updateStatus(taskNode.getId(),TaskNodeStatus.FAIL.getCode(),null,eCode.getCode(),msg);

        //更新任务失败
        taskService.setTaskEnd(taskNode.getTaskId(), Constant.SYSTEM_USER);
    }


    /**
     * 设置节点成功
     * @param taskNode
     */
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    @Override
    public void setNodeSucc(TaskNode taskNode) {
        //设置节点成功
        updateStatus(taskNode.getId(),TaskNodeStatus.SUCC.getCode(),null,ErrorCode.APPLY_SUCCESS.getCode(),"成功");

        //任务是否全部完成
        taskService.setTaskEnd(taskNode.getTaskId(),Constant.SYSTEM_USER);
    }

    /**
     * 设置节点处理中
     */
    @Override
    public void setNodeExeing(TaskNode taskNode) {
        updateStatus(taskNode.getId(),TaskNodeStatus.EXEING.getCode(),null,"","");
    }


    /**
     * 修改节点状态
     * @param nodeId
     * @param status
     */
    public void updateStatus(Long nodeId,String status,String modifyUser,String respCode,String respMsg){
        TaskNode taskNode = new TaskNode();
        taskNode.setId(nodeId);
        taskNode.setModifyUser(modifyUser);
        taskNode.setStatus(status);
        taskNode.setRespCode(respCode);
        taskNode.setRespMsg(respMsg);

        taskNodeMapper.updateStatus(taskNode);
    }

}
