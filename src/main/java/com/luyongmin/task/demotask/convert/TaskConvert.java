package com.luyongmin.task.demotask.convert;

import com.luyongmin.task.demotask.domain.Task;
import com.luyongmin.task.demotask.domain.TaskNode;

import java.util.ArrayList;
import java.util.List;

/**
 * @author: lu.yongmin
 * @date: 2020/3/6 15:51
 * @description:
 */
public class TaskConvert {


    public static List<Long> convertIdList(List<Task> taskList) {
        if(taskList != null && taskList.size()>0){
            List<Long> taskIdList = new ArrayList<Long>();
            for(Task task : taskList){
                taskIdList.add(task.getId());
            }
            return taskIdList;
        }
        return null;
    }

    public static void merge(List<Task> taskList, List<TaskNode> nodeList) {
        if(taskList != null && taskList.size()>0){
            for(Task task : taskList){
                task.setTaskNodeList(getByTaskId(nodeList,task.getId()));
            }
        }

    }

    private static List<TaskNode> getByTaskId(List<TaskNode> nodeList,Long taskId) {
        if(nodeList != null && nodeList.size()>0){
            List<TaskNode> result = new ArrayList<TaskNode>();
            for(TaskNode taskNode : nodeList){
                if(taskNode.getTaskId() != null && taskNode.getTaskId().equals(taskId)){
                    result.add(taskNode);
                }
            }
            return result;
        }
        return null;
    }



}
