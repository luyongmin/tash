package com.luyongmin.task.demotask.service.impl;

import com.alibaba.fastjson.JSON;
import com.luyongmin.task.demotask.comparator.TaskNodeMergeComparator;
import com.luyongmin.task.demotask.constant.Constant;
import com.luyongmin.task.demotask.constant.ErrorCode;
import com.luyongmin.task.demotask.domain.Task;
import com.luyongmin.task.demotask.domain.TaskNode;
import com.luyongmin.task.demotask.enums.TaskNodeStatus;
import com.luyongmin.task.demotask.excention.BizException;
import com.luyongmin.task.demotask.factory.TaskNodeMngFactory;
import com.luyongmin.task.demotask.service.TaskNodeExecuteService;
import com.luyongmin.task.demotask.service.TaskNodeMngInf;
import com.luyongmin.task.demotask.service.TaskNodeService;
import com.luyongmin.task.demotask.service.TaskService;
import com.luyongmin.task.demotask.util.IPUtils;
import com.luyongmin.task.demotask.util.SessionUtil;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.slf4j.MDC;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.util.*;

/**
 * @author: lu.yongmin
 * @date: 2020/3/6 17:46
 * @description:
 */
@Service
public class TaskNodeExecuteServiceImpl implements TaskNodeExecuteService {


    private static final Log logger = LogFactory.getLog(TaskNodeExecuteServiceImpl.class);

    @Resource
    private TaskService taskService;

    @Resource
    private TaskNodeService taskNodeService;

    @Resource
    private TaskNodeMngFactory taskNodeMngFactory;

    /**
     * 执行任务节点
     * @param taskNode
     */
    @Override
    public void execute(TaskNode taskNode){
        logger.info("taskNode-execute,参数:taskNode="+ JSON.toJSONString(taskNode));

        try{
            Task task = taskService.queryById(taskNode.getTaskId());  //获取任务信息
            if(!validateExe(taskNode,task)){  //验证节点是否可执行
                return;
            }

            setParam(taskNode,task);  //设置节点参数

            String settleDate = task.getSettleDate();

            TaskNodeMngInf taskNodeMngInf = taskNodeMngFactory.getManager(taskNode);

            if(taskNodeMngInf == null){
                throw new BizException(ErrorCode.TASK_NODE_MANAGER_NULL);
            }

            //验证前置节点
            try{
                taskNodeMngInf.validateExecute(taskNode, settleDate);
            }catch(BizException e){
                ErrorCode eCode = e.getErrorCode() ;

                if(eCode == ErrorCode.FRONT_TASK_UNCOMPLETE){  //如果是前置节点未完成,不做处理
                    return;
                }

                throw e;
            }

            //更新状态为处理中
            taskNodeService.setNodeExeing(taskNode);
            logger.info("节点执行");
            //节点执行
            taskNodeMngInf.execute(taskNode, settleDate);

            //设置节点成功
            taskNodeService.setNodeSucc(taskNode);

        }catch(Exception e){
            ErrorCode eCode = ErrorCode.SYSTEM_ERROR;
            String msg = e.getMessage();
            if(e instanceof BizException){
                eCode = ((BizException) e).getErrorCode() ;
            }

            taskNodeService.setNodeFail(taskNode,eCode,msg);
        }

    }

    private void setParam(TaskNode taskNode, Task task) {
        if(!StringUtils.isEmpty(task.getTaskParam())){
            Map<String,Object> param = new HashMap<String,Object>();

            String[] mapArr = task.getTaskParam().split("\\@");

            if(mapArr != null && mapArr.length>0){
                for(String mapStr : mapArr){
                    String[] arr = mapStr.split("=");
                    if(arr != null && arr.length>2){
                        param.put(arr[0], arr[1]);
                    }
                }
            }

            taskNode.setNodeParamMap(param);
        }

    }

    /**
     * 验证是否能执行
     * @param taskNode
     * @param
     * @return
     */
    private boolean validateExe(TaskNode taskNode,Task task) {
        Date nodeStartTime = taskNode.getNodeStartTime();

        if(nodeStartTime != null && nodeStartTime.compareTo(new Date())>0){
            return false;
        }

        if(task == null || StringUtils.isEmpty(task.getSettleDate())){
            return false;
        }

        Date taskStartTime = task.getTaskStartTime();

        if(taskStartTime != null && taskStartTime.compareTo(new Date())>0){
            return false;
        }

        return true;
    }

    /**
     * 排序任务节点
     * @param taskList
     * @return
     */
    @Override
    public List<TaskNode> sortTaskNode(List<Task> taskList, Integer maxCount) {
        List<TaskNode> taskNodeList = new ArrayList<TaskNode>();

        String ip = getIp();

        if(taskList != null && taskList.size()>0){
            if(maxCount == null){
                maxCount = taskList.size();  //默认任务全部取完
            }
            int i = 1;
            for (Task task : taskList){
                List<TaskNode> tempList = task.getTaskNodeList();
                if(tempList != null && tempList.size()>0){
                    for(TaskNode taskNode : tempList){
                        String token = taskNode.getExecuteToken();
                        if(StringUtils.isEmpty(token) || !token.equals(ip)){  //令牌不为本机IP的，本机不处理
                            continue;
                        }

                        TaskNodeStatus nodeStatus = TaskNodeStatus.getByCode(taskNode.getStatus());

                        if(nodeStatus != TaskNodeStatus.WAIT_EXE){  //非成功或者等待执行的记录，返回错误
                            continue;
                        }


                        taskNode.setTaskPriority(task.getPriority());
                        taskNode.setSettleDate(task.getSettleDate());
                        taskNodeList.add(taskNode);
                    }
                }

                if(i >= maxCount){
                    break;
                }

                i++;
            }
        }

        Collections.sort(taskNodeList, new TaskNodeMergeComparator());
        return taskNodeList;
    }

    private String getIp() {
        String ip = "";
        try {
            ip = IPUtils.getLocalIP();
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }

        return ip;
    }

    @Override
    public void execute(List<TaskNode> taskNodeList,int waitTime) {
        if(taskNodeList != null && taskNodeList.size()>0){
            for(TaskNode taskNode : taskNodeList){
                logger.info("now excuteTask = "+ taskNode.getId() + ",code="+taskNode.getNodeCode()
                        +",settleDate="+taskNode.getSettleDate()+",Tpriority="+taskNode.getTaskPriority()+",Priority="+taskNode.getPriority());

                //打印日志的sessionID
                String sessionId = SessionUtil.getSessionId();
                MDC.put(Constant.LOG_KEY, sessionId);

                try{
                    execute(taskNode);

                    //完成一个节点后等待X秒钟
                    if(waitTime>0){
                        Thread.sleep(waitTime*1000);
                    }
                }catch(Exception e){
                    logger.error(e.getMessage(),e);
                }
            }
        }
    }

}
