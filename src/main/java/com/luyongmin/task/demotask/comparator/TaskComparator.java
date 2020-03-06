package com.luyongmin.task.demotask.comparator;

import com.luyongmin.task.demotask.domain.Task;
import org.springframework.util.StringUtils;

import java.util.Comparator;

/**
 * @author: lu.yongmin
 * @date: 2020/3/6 16:57
 * @description:
 */
public class TaskComparator implements Comparator<Task> {


    @Override
    public int compare(Task o1, Task o2) {
        String s1 = o1.getSettleDate();
        String s2 = o2.getSettleDate();

        int result = compareSettleDate(s1,s2);

        if(result == 0){
            Integer x1 = o1.getPriority();
            Integer x2 = o2.getPriority();

            result = comparePriority(x1,x2);
        }

        return result;
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


        return x1 > x2 ? 1 : -1;
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

    public static void main(String[] args){
        System.out.println("20180102".compareTo("20180102"));
    }
}
