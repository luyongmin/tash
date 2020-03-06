package com.luyongmin.task.demotask.convert;

import com.luyongmin.task.demotask.domain.TaskNode;

import java.util.ArrayList;
import java.util.List;

/**
 * @author: lu.yongmin
 * @date: 2020/3/6 16:19
 * @description:
 */
public class TaskNodeConvert {

    public static List<Long> convertIdList(List<TaskNode> taskNodeList) {
        if(taskNodeList != null && taskNodeList.size()>0){
            List<Long> taskIdList = new ArrayList<Long>();
            for(TaskNode taskNode : taskNodeList){
                taskIdList.add(taskNode.getTaskId());
            }
            return taskIdList;
        }

        return null;
    }
}
