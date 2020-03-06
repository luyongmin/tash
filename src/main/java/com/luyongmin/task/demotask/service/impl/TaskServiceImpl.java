package com.luyongmin.task.demotask.service.impl;

import com.luyongmin.task.demotask.comparator.TaskComparator;
import com.luyongmin.task.demotask.constant.Constant;
import com.luyongmin.task.demotask.constant.ErrorCode;
import com.luyongmin.task.demotask.convert.TaskConvert;
import com.luyongmin.task.demotask.domain.*;
import com.luyongmin.task.demotask.enums.TaskNodeCode;
import com.luyongmin.task.demotask.enums.TaskNodeStatus;
import com.luyongmin.task.demotask.enums.TaskStatus;
import com.luyongmin.task.demotask.excention.BizException;
import com.luyongmin.task.demotask.mapper.TaskMapper;
import com.luyongmin.task.demotask.mapper.TaskPlanDetailMapper;
import com.luyongmin.task.demotask.mapper.TaskPlanMapper;
import com.luyongmin.task.demotask.service.TaskNodeService;
import com.luyongmin.task.demotask.service.TaskService;
import com.luyongmin.task.demotask.enums.TaskReloadStrategy;
import com.luyongmin.task.demotask.util.StringUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.util.*;

/**
 * @author: lu.yongmin
 * @date: 2020/3/6 15:34
 * @description:
 */
@Service
public class TaskServiceImpl implements TaskService {

    private static final Logger logger = LoggerFactory.getLogger(TaskServiceImpl.class);

    @Resource
    private TaskMapper taskMapper;

    @Resource
    private TaskNodeService taskNodeService;

    @Resource
    private TaskPlanMapper taskPlanMapper;

    @Resource
    private TaskPlanDetailMapper taskPlanDetailMapper;

    /**
     * 根据条件查询
     * @param taskQuery
     * @return
     */
    @Override
    public List<Task> queryByParam(TaskQuery taskQuery){
        Map<String,Object> paramMap = new HashMap<String,Object>();
        paramMap.put("planId", taskQuery.getPlanId());
        paramMap.put("taskCode", taskQuery.getTaskCode());
        paramMap.put("status", taskQuery.getStatus());
        paramMap.put("taskIdList", taskQuery.getTaskIdList());
        paramMap.put("settleDate", taskQuery.getSettleDate());
        paramMap.put("_start_time", taskQuery.get_start_time());
        paramMap.put("_end_time", taskQuery.get_end_time());

        List<Task> taskList = taskMapper.queryByParam(paramMap);

        if(!CollectionUtils.isEmpty(taskList)){  //填充节点列表
            Map<String,Object> pMap = new HashMap<String,Object>();
            pMap.put("taskIdList", TaskConvert.convertIdList(taskList));
            List<TaskNode> nodeList = taskNodeService.queryByParam(pMap);
            TaskConvert.merge(taskList,nodeList);
        }

        return taskList;
    }

    /**
     * 重载任务
     * @param taskReload
     */
    @Override
    @Transactional(propagation= Propagation.REQUIRED)
    public void reloadTask(TaskReload taskReload){
        if(taskReload.getPlanId() != null){
            Assert.isTrue(!StringUtil.isEmpty(taskReload.getSettleDate()), "重载执行任务,结算时间不能为空");
            reloadTaskByPlan(taskReload);
        }

        if(!CollectionUtils.isEmpty(taskReload.getTaskIdList())){
            TaskQuery taskQuery = new TaskQuery();
            taskQuery.setTaskIdList(taskReload.getTaskIdList());
            List<Task> taskList = queryByParam(taskQuery);
            reloadTaskList(taskList,taskReload.getStrategy(),taskReload.getReloadUser());
        }

        if(!CollectionUtils.isEmpty(taskReload.getTaskNodeIdList())){
            taskNodeService.reloadTaskNode(taskReload.getTaskNodeIdList(),taskReload.getReloadUser(),true);
        }

    }

    /**
     * 按计划重载任务
     * @param taskReload
     */
    private void reloadTaskByPlan(TaskReload taskReload) {
        TaskQuery taskQuery  = new TaskQuery();
        taskQuery.setPlanId(taskReload.getPlanId());
        taskQuery.setSettleDate(taskReload.getSettleDate());
        List<Task> taskList = queryByParam(taskQuery);

        if(CollectionUtils.isEmpty(taskList)){
            throw new BizException(ErrorCode.RELOAD_PLAN_FAIL,"计划在结算时间内不存在任务");
        }
        reloadTaskList(taskList,taskReload.getStrategy(),taskReload.getReloadUser());
    }

    /**
     * 重载任务列表
     * @param taskList
     */
    private void reloadTaskList(List<Task> taskList,TaskReloadStrategy strategy,String reloadUser) {
        if(!CollectionUtils.isEmpty(taskList)){
            List<Long> reloadTaskIdList = new ArrayList<Long>();
            List<Long> reloadTaskNodeIdList = new ArrayList<Long>();
            for(Task task : taskList){
                reloadTaskIdList.add(task.getId());

                if(!CollectionUtils.isEmpty(task.getTaskNodeList())){
                    for(TaskNode node : task.getTaskNodeList()){
                        if(strategy == TaskReloadStrategy.PUSH){
                            TaskNodeStatus status = TaskNodeStatus.getByCode(node.getStatus());

                            if(status != TaskNodeStatus.SUCC){
                                reloadTaskNodeIdList.add(node.getId());
                            }
                        }else if(strategy == TaskReloadStrategy.RE_EXE){
                            reloadTaskNodeIdList.add(node.getId());
                        }
                    }
                }


            }

            reloadTask(reloadTaskIdList,reloadUser);

            taskNodeService.reloadTaskNode(reloadTaskNodeIdList,reloadUser,false);
        }

    }

    /**
     * 重载任务
     * @param reloadTaskIdList
     * @param reloadUser
     */
    private void reloadTask(List<Long> reloadTaskIdList,String reloadUser) {
        if(!CollectionUtils.isEmpty(reloadTaskIdList)){
//			List<Task> reloadTaskList = new ArrayList<Task>();
//			for(Long taskId : reloadTaskIdList){
//				Task task = new Task();
//				task.setId(taskId);
//				task.setModifyUser(reloadUser);
//				task.setModifyTime(new Date());
//				task.setStatus(TaskStatus.WAIT_EXE.getCode());
//				reloadTaskList.add(task);
//			}
//
//			if(reloadTaskList != null && reloadTaskList.size()>0){
//				taskMapper.batchUpdateStatus(reloadTaskList);
//			}
            Map<String,Object> paramMap = new HashMap<String,Object>();
            paramMap.put("taskIdList", reloadTaskIdList);
            paramMap.put("status", TaskStatus.WAIT_EXE.getCode());
            paramMap.put("modifyUser", reloadUser);

            taskMapper.batchUpdateStatus(paramMap);
        }
    }

    /**
     * 根据主键查询任务信息
     * @param id
     * @return
     */
    @Override
    public Task queryById(Long id){
        Task task = taskMapper.queryById(id);

        if(task != null){
            List<TaskNode> nodeList = taskNodeService.queryByTask(id);
            task.setTaskNodeList(nodeList);
        }

        return task;
    }

    /**
     * 批量插入任务信息
     * @param taskList
     */
    @Override
    @Transactional(propagation=Propagation.REQUIRED)
    public void batchInsert(List<Task> taskList){
        if(taskList != null && taskList.size()>0){
            for (Task task : taskList){
                taskMapper.add(task);
                taskNodeService.batchInsert(task.getTaskNodeList(),task.getId());
            }
        }
    }

    /**
     * 根据主键查询计划信息
     * @param planId
     * @return
     */
    @Override
    public TaskPlan queryPlanById(Long planId) {
        TaskPlan taskPlan = taskPlanMapper.queryById(planId);
        Map<String,Object> paramMap = new HashMap<String,Object>();
        paramMap.put("planId", planId);
        if(taskPlan != null){
            List<TaskPlanDetail> taskPlanDetails = taskPlanDetailMapper.queryByParam(paramMap);
            taskPlan.setPlanDetailList(taskPlanDetails);
        }

        return taskPlan;
    }

    @Override
    public List<TaskPlanDetail> queryPlanDetailListByParam(TaskQuery taskQuery) {
        Map<String,Object> paramMap = new HashMap<String,Object>();
        paramMap.put("planId", taskQuery.getPlanId());
        paramMap.put("taskCode", taskQuery.getTaskCode());
        paramMap.put("status", taskQuery.getStatus());
        paramMap.put("taskIdList", taskQuery.getTaskIdList());
        paramMap.put("settleDate", taskQuery.getSettleDate());
        paramMap.put("_start_time", taskQuery.get_start_time());
        paramMap.put("_end_time", taskQuery.get_end_time());

        List<TaskPlanDetail> taskList = taskPlanDetailMapper.queryByParam(paramMap);

        return taskList;
    }

    @Override
    @Transactional(propagation=Propagation.REQUIRED)
    public void copyPlan(TaskPlan taskPlan) {
        taskPlanMapper.add(taskPlan);
        if (taskPlan.getPlanDetailList()!=null&&taskPlan.getPlanDetailList().size()!=0) {
            for (TaskPlanDetail taskPlanDetail : taskPlan.getPlanDetailList()) {
                taskPlanDetail.setPlanId(taskPlan.getId());
                taskPlanDetail.setCreateTime(new Date());
                taskPlanDetail.setModifyTime(new Date());
            }
            taskPlanDetailMapper.batchInsert(taskPlan.getPlanDetailList());
        }

    }


    /**
     * 查询未完成的任务
     * @return
     */
    @Override
    public List<Task> queryWaitingTask(){
        Map<String,Object> paramMap = new HashMap<String,Object>();
        paramMap.put("status", TaskStatus.WAIT_EXE.getCode());

        List<Task> taskList = queryByParam(paramMap);

        if(!CollectionUtils.isEmpty(taskList)){
            /* 任务排序 */
            Collections.sort(taskList, new TaskComparator());
        }
        return taskList;
    }

    /**
     * 根据条件查询
     * @param paramMap
     * @return
     */
    public List<Task> queryByParam(Map<String,Object> paramMap){
        List<Task> taskList = taskMapper.queryByParam(paramMap);

        if(!CollectionUtils.isEmpty(taskList)){
            for(Task task : taskList){
                List<TaskNode> taskNodeList = taskNodeService.queryNodeByTaskId(task.getId());
                task.setTaskNodeList(taskNodeList);
            }
        }

        return taskList;
    }


    /**
     * 分配任务令牌
     * @param task
     * @param ipList
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED)
    public void allocationToken(Task task, List<String> ipList) {
        List<TaskNode> nodeList = task.getTaskNodeList();
        if(nodeList != null && nodeList.size()>0){
            int i = 1;
            for(TaskNode taskNode : nodeList){

                TaskNodeStatus status = TaskNodeStatus.getByCode(taskNode.getStatus());

                if(status == TaskNodeStatus.WAIT_EXE && StringUtils.isEmpty(taskNode.getExecuteToken())){
                    String token = getToken(ipList,i,taskNode);

                    if(isForce(taskNode.getNodeCode())){  //强制
                        token = ipList.get(0);
                    }

                    taskNodeService.updateToken(taskNode,token, Constant.SYSTEM_USER);

                    i++;
                }

            }
        }

        updateStatus(task.getId(),TaskStatus.DISPATH,Constant.SYSTEM_USER);

    }

    private boolean isForce(String nodeCode) {
        TaskNodeCode nodeCodeEnum = TaskNodeCode.getByCode(nodeCode);

        if(nodeCodeEnum == TaskNodeCode.MER_ORDER_CLEAR){
            return true;
        }

        return false;
    }



    /**
     * 获取执行令牌
     * @param ipList
     * @param i
     * @param taskNode
     * @return
     */
    private String getToken(List<String> ipList, int i, TaskNode taskNode) {
        int max = ipList.size();
        int min = 1;

        Random random = new Random();

        int s = random.nextInt(max)%(max-min+1) + min;

        if(s>max){
            s = max;
        }
        return ipList.get(s-1);
    }


    /**
     * 更新状态
     * @param taskId
     * @param taskStatus
     * @param modifyUser
     */
    public void updateStatus(Long taskId,TaskStatus taskStatus,String modifyUser){
        Task task = new Task();
        task.setId(taskId);
        task.setStatus(taskStatus.getCode());
        task.setModifyUser(modifyUser);

        taskMapper.updateStatus(task);
    }


    /**
     * 查询已调度任务
     * @return
     */
    @Override
    public List<Task> queryDispatchTask(){
        Map<String,Object> paramMap = new HashMap<String,Object>();
        paramMap.put("status", TaskStatus.DISPATH.getCode());

        List<Task> taskList = queryByParam(paramMap);

        if(!CollectionUtils.isEmpty(taskList)){
            /* 任务排序 */
            Collections.sort(taskList, new TaskComparator());
        }

        return taskList;
    }


    /**
     * 设置任务结束
     * @param taskId
     * @param modifyUser
     */
    @Override
    public void setTaskEnd(Long taskId,String modifyUser){
        Task task = queryById(taskId);

        if(task == null){
            return;
        }

        boolean flag = true;
        List<TaskNode> taskNodeList = task.getTaskNodeList();
        if(taskNodeList != null && taskNodeList.size()>0){
            for(TaskNode taskNode : taskNodeList){
                TaskNodeStatus status = TaskNodeStatus.getByCode(taskNode.getStatus());
                if(status != TaskNodeStatus.FAIL && status != TaskNodeStatus.SUCC){  //有状态未到终点的不做处理
                    return;
                }

                if(status  == TaskNodeStatus.FAIL){  //有错误的需要设置成任务错误状态，否则就是成功
                    flag = false;
                }
            }
        }

        if(flag){
            updateStatus(taskId,TaskStatus.SUCC,modifyUser);
        }else{
            updateStatus(taskId,TaskStatus.FAIL,modifyUser);
        }
    }

    /**
     * 根据清算日期查询任务信息
     * @param
     * @return
     */
    @Override
    public List<Task> queryBySettleDate(String settleDate){
        List<Task> taskList = taskMapper.queryBySettleDate(settleDate);

        if(taskList != null && taskList.size()>0){
            for(Task task : taskList){
                List<TaskNode> taskNodeList = taskNodeService.queryNodeByTaskId(task.getId());

                task.setTaskNodeList(taskNodeList);
            }
        }

        return taskList;
    }

}
