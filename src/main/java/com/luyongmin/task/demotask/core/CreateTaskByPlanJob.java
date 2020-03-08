package com.luyongmin.task.demotask.core;

import com.luyongmin.task.demotask.constant.Constant;
import com.luyongmin.task.demotask.domain.TaskPlan;
import com.luyongmin.task.demotask.service.TaskPlanService;
import com.luyongmin.task.demotask.util.DateUtil;
import com.luyongmin.task.demotask.util.SessionUtil;
import org.quartz.JobExecutionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.MDC;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.scheduling.support.CronSequenceGenerator;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import java.util.Date;
import java.util.List;

/**
 * @author: lu.yongmin
 * @date: 2020/3/6 14:08
 * @description:
 */
@Component
public class CreateTaskByPlanJob {

    private static final Logger logger = LoggerFactory.getLogger(CreateTaskByPlanJob.class);


    @Autowired
    private TaskPlanService taskPlanService;

    @Scheduled(cron="0 0/10 * * * ?")
    public void run(){

        logger.info(  " started...");
        long start = System.currentTimeMillis();
        try {
            //打印日志的sessionID
            String sessionId = SessionUtil.getSessionId();
            MDC.put(Constant.LOG_KEY, sessionId);
            this.execute();
        } catch (Exception e) {
            logger.error(e.getMessage(),e);
        } finally{
            MDC.clear();
        }
        long end = System.currentTimeMillis();
        logger.info(  " finished, cost " + (end - start) + "ms");

    }


    private void execute(){
        List<TaskPlan> taskPlanList =  taskPlanService.queryValidPlan();
        if(taskPlanList != null && taskPlanList.size()>0){
            for(TaskPlan taskPlan : taskPlanList){
                String executeCron = taskPlan.getExecuteCron();
                if(!StringUtils.isEmpty(executeCron)){
                    CronSequenceGenerator cronSequenceGenerator = new CronSequenceGenerator(executeCron);
                    //上次执行时间
                    Date lastExtTime = taskPlan.getLastExtTime();
                    if(lastExtTime == null){
                        //今天0点0分
                        lastExtTime = DateUtil.getToday();
                    }
                    //下次执行时间
                    Date nextTimePoint = cronSequenceGenerator.next(lastExtTime);
                    //到了执行时间
                    if(nextTimePoint.compareTo(new Date()) < 0){
                        //创建任务
                        taskPlanService.createTask(taskPlan);
                    }
                }
            }
        }
    }
}
