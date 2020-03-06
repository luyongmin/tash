package com.luyongmin.task.demotask.core;

import com.luyongmin.task.demotask.constant.ErrorCode;
import com.luyongmin.task.demotask.domain.Task;
import com.luyongmin.task.demotask.excention.BizException;
import com.luyongmin.task.demotask.service.TaskService;
import com.luyongmin.task.demotask.util.IPUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.JobExecutionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.List;

/**
 * @author: lu.yongmin
 * @date: 2020/3/6 16:53
 * @description: 任务调度
 */
@Component
public class SettleTaskDispatchJob {

    private static final Log logger = LogFactory.getLog(SettleTaskDispatchJob.class);

    /**
     * 任务节点查询服务
     */
    @Autowired
    private TaskService taskService;

    /**
     * 目前批处理服务节点ip集合
     */
    @Value("#{SERVICE_IP}")
    private static String service_ip;

    @Scheduled(cron = "0 0/2 * * * ?")
    public void run() {
        logger.info("SettleTaskDispatchJob start");


        // 查询待调度的任务节点
        List<Task> taskList = taskService.queryWaitingTask();

        // 获取可使用的任务执行服务器IP
        List<String> ipList = getDispatchServiceIp();

        // 判断任务执行服务器IP集合是否为空
        if(CollectionUtils.isEmpty(ipList)){
            throw new BizException(ErrorCode.TASK_DISPATH_SERVICE_NULL);
        }

        // 开始为待调度的任务节点分配令牌
        if(taskList != null && taskList.size()>0){
            for	(Task task : taskList){
                taskService.allocationToken(task,ipList);
            }
        }

    }

    /**
     * 获取调度服务IP
     * @return
     */
    private List<String> getDispatchServiceIp() {
        List<String> ipList = new ArrayList<String>();

        if(StringUtils.isEmpty(service_ip)){
            try{
                //取当前服务器IP作为默认IP
                String ip = IPUtils.getLocalIP();

                if(!StringUtils.isEmpty(ip)){
                    ipList.add(ip);
                }
            } catch (Exception e) {
                logger.error(e.getMessage(), e);
            }
        }else{
            String[] ipArr = service_ip.split(",");
            if(ipArr != null && ipArr.length>0){
                for(String ip : ipArr){
                    ipList.add(ip);
                }
            }
        }

        return ipList;
    }




}
