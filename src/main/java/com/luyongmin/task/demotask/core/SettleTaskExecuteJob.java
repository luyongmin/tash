package com.luyongmin.task.demotask.core;

import com.luyongmin.task.demotask.domain.Task;
import com.luyongmin.task.demotask.domain.TaskNode;
import com.luyongmin.task.demotask.service.TaskNodeExecuteService;
import com.luyongmin.task.demotask.service.TaskService;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * @author: lu.yongmin
 * @date: 2020/3/6 17:40
 * @description:
 */
@Component
public class SettleTaskExecuteJob {

    private static final Log logger = LogFactory.getLog(SettleTaskExecuteJob.class);

    @Autowired
    private TaskService taskService;

    @Autowired
    private TaskNodeExecuteService taskNodeExecuteService;


    @Value("${SETTLE_TASK_WAIT_TIME:20}")
    private int waitTime;


    @Scheduled(cron = "")
    public void run(){

        try {

            List<Task> taskList = taskService.queryDispatchTask();

            if(taskList == null || taskList.size()<=0){
                return;
            }

            //一批次取前20个任务排序,任务已经排序
            int maxCount = 20;
            List<TaskNode> taskNodeList = taskNodeExecuteService.sortTaskNode(taskList,maxCount);
            for(TaskNode taskNode:taskNodeList){
                logger.info(taskNode.getNodeCode());
            }
            taskNodeExecuteService.execute(taskNodeList,waitTime);
        } catch (Exception e) {
            logger.error(e.getMessage(),e);
        }

    }












}
