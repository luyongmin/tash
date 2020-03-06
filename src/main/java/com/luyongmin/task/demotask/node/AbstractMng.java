package com.luyongmin.task.demotask.node;

import com.luyongmin.task.demotask.constant.ErrorCode;
import com.luyongmin.task.demotask.domain.Task;
import com.luyongmin.task.demotask.domain.TaskNode;
import com.luyongmin.task.demotask.enums.TaskNodeStatus;
import com.luyongmin.task.demotask.enums.TaskStatus;
import com.luyongmin.task.demotask.excention.BizException;
import com.luyongmin.task.demotask.service.TaskNodeMngInf;
import com.luyongmin.task.demotask.service.TaskNodeService;
import com.luyongmin.task.demotask.service.TaskService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * @author: lu.yongmin
 * @date: 2020/3/6 18:07
 * @description:
 */
public  abstract  class AbstractMng  implements TaskNodeMngInf {

    /**
     * 查询的每页数量
     */
    @Value("#{jj}")
    protected String QUERY_SIZE;

    @Resource
    public TaskService taskService;

    @Resource
    public TaskNodeService taskNodeService;

    /**
     * 验证节点是否可以执行
     * @param taskNode
     * @param settleDate
     */
    @Override
    public void validateExecute(TaskNode taskNode, String settleDate){

        if(!StringUtils.isEmpty(taskNode.getFrontNode())){

            List<Task> taskList = taskService.queryBySettleDate(settleDate);

            List<String> succTaskList = new ArrayList<String>();
            List<String> failTaskList = new ArrayList<String>();

            convertTaskList(taskList,succTaskList,failTaskList);

            List<String> succNodeList = new ArrayList<String>();
            List<String> failNodeList = new ArrayList<String>();

            convertNodeList(taskList,succNodeList,failNodeList);

            String[] arr = taskNode.getFrontNode().split(",");

            if(arr != null && arr.length>0){
                for(String val : arr){
                    if(val.startsWith("TASK_")){
                        if(succTaskList.contains(val)){
                            continue;
                        }

                        if(failTaskList.contains(val)){
                            throw new BizException(ErrorCode.FRONT_TASK_FAIL,"前置任务处理失败");
                        }
                    }else{
                        if(succNodeList.contains(val)){
                            continue;
                        }

                        if(failNodeList.contains(val)){
                            throw new BizException(ErrorCode.FRONT_TASK_FAIL,"前置任务处理失败");
                        }
                    }

                    throw new BizException(ErrorCode.FRONT_TASK_UNCOMPLETE,"存在前置任务处理未完成");
                }
            }

        }

    }

    private void convertTaskList(List<Task> taskList,List<String> succTaskList,List<String> failTaskList) {

        if(taskList != null && taskList.size()>0){
            for(Task task : taskList){
                TaskStatus taskStatus = TaskStatus.getByCode(task.getStatus());

                if(taskStatus == TaskStatus.SUCC){
                    succTaskList.add(task.getTaskCode());
                    continue;
                }

                if(taskStatus == TaskStatus.FAIL){
                    failTaskList.add(task.getTaskCode());
                    continue;
                }
            }
        }

    }

    private void convertNodeList(List<Task> taskList,List<String> succNodeList,List<String> failNodeList) {

        if(taskList != null && taskList.size()>0){
            for(Task task : taskList){
                List<TaskNode> taskNodeList =	task.getTaskNodeList();
                if(taskNodeList != null && taskNodeList.size()>0){
                    for(TaskNode taskNode : taskNodeList){
                        TaskNodeStatus status =  TaskNodeStatus.getByCode(taskNode.getStatus());
                        if(status == TaskNodeStatus.SUCC){
                            succNodeList.add(taskNode.getNodeCode());
                        }
                        if(status == TaskNodeStatus.FAIL){
                            failNodeList.add(taskNode.getNodeCode());
                        }
                    }
                }
            }

        }
    }
}
