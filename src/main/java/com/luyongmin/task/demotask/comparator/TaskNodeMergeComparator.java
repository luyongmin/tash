package com.luyongmin.task.demotask.comparator;

import com.luyongmin.task.demotask.domain.TaskNode;
import org.springframework.util.StringUtils;

import java.util.Comparator;

/**
 * @author: lu.yongmin
 * @date: 2020/3/6 18:00
 * @description:
 */
public class TaskNodeMergeComparator implements Comparator<TaskNode> {

    @Override
    public int compare(TaskNode o1, TaskNode o2) {
        String s1 = o1.getSettleDate();
        String s2 = o2.getSettleDate();

        int result = compareSettleDate(s1,s2);

        if(result != 0){
            return result;
        }

        //先比较任务优先级
        result = comparePriority(o1.getTaskPriority(),o2.getTaskPriority());

        if(result != 0){ //平手比较节点优先级
            return result;
        }

        result = comparePriority(o1.getPriority(),o2.getPriority());

        return result;
    }

    private int compareSettleDate(String s1, String s2) {
        if(StringUtils.isEmpty(s1) && StringUtils.isEmpty(s2)){
            return 0;
        }

        if(StringUtils.isEmpty(s2)){
            return 1;
        }

        if(StringUtils.isEmpty(s1)){
            return -1;
        }

        return s1.compareTo(s2);
    }

    private int comparePriority(Integer x1, Integer x2) {
        if(x1 == null && x2 == null){
            return 0;
        }

        if(x2 == null){
            return 1;
        }

        if(x1 == null){
            return -1;
        }

        return x1.compareTo(x2);
    }
}
