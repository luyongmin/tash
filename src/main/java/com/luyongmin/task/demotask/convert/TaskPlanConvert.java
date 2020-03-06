package com.luyongmin.task.demotask.convert;

import com.luyongmin.task.demotask.constant.Constant;
import com.luyongmin.task.demotask.domain.*;
import com.luyongmin.task.demotask.enums.TaskNodeStatus;
import com.luyongmin.task.demotask.enums.TaskStatus;
import com.luyongmin.task.demotask.util.DateUtil;
import org.springframework.scheduling.support.CronSequenceGenerator;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @author: lu.yongmin
 * @date: 2020/3/6 15:30
 * @description:
 */
public class TaskPlanConvert {


    public static Task buildTask(TaskPlanDetail planDetail, TaskPlan plan, TaskTemplate template, String settleDate) {
        Task task = new Task();
        task.setTaskCode(planDetail.getTaskCode());
        task.setTaskName(template.getTaskName());
        task.setPlanId(plan.getId());
        task.setSettleDate(settleDate);
        task.setPriority(planDetail.getPriority());
        task.setStatus(TaskStatus.WAIT_EXE.getCode());

        task.setTaskParam(planDetail.getTaskParam());

        if(!StringUtils.isEmpty(planDetail.getTaskCron())){
            try{
                CronSequenceGenerator cronSequenceGenerator = new CronSequenceGenerator(planDetail.getTaskCron());

                Date date = DateUtil.addDay(DateUtil.parse(settleDate, DateUtil.shortFormat), 1);
                Date nextTimePoint = cronSequenceGenerator.next(date); //下次执行时间
                task.setTaskStartTime(nextTimePoint);
            }catch(Exception e){
                throw new RuntimeException(e);
            }

        }

        task.setCreateUser(Constant.SYSTEM_USER);
        task.setModifyUser(Constant.SYSTEM_USER);
        task.setCreateTime(new Date());
        task.setModifyTime(new Date());

        List<TaskNode> taskNodeList = buildTaskNodeList(template.getNodeTemplateList(),task);
        task.setTaskNodeList(taskNodeList);

        return task;
    }

    private static List<TaskNode> buildTaskNodeList(List<TaskNodeTemplate> nodeTemplateList,Task task) {
        if(nodeTemplateList != null && nodeTemplateList.size()>0){
            List<TaskNode> nodeList = new ArrayList<TaskNode>();
            for(TaskNodeTemplate nodeTemplate : nodeTemplateList){
                TaskNode taskNode = buildTaskNode(nodeTemplate,task);
                nodeList.add(taskNode);
            }

            return nodeList;
        }

        return null;
    }

    private static TaskNode buildTaskNode(TaskNodeTemplate nodeTemplate,Task task) {
        TaskNode node = new TaskNode();
        node.setTaskId(task.getId());
        node.setNodeCode(nodeTemplate.getNodeCode());
        node.setNodeName(nodeTemplate.getNodeName());
        node.setPriority(nodeTemplate.getPriority());

        if(!StringUtils.isEmpty(nodeTemplate.getStartTimeCron())){
            try{
                CronSequenceGenerator cronSequenceGenerator = new CronSequenceGenerator(nodeTemplate.getStartTimeCron());
                Date date = DateUtil.addDay(DateUtil.parse(task.getSettleDate(), DateUtil.shortFormat), 1);
                Date nextTimePoint = cronSequenceGenerator.next(date); //下次执行时间
                node.setNodeStartTime(nextTimePoint);
            }catch(Exception e){
                throw new RuntimeException(e);
            }
        }

        node.setStatus(TaskNodeStatus.WAIT_EXE.getCode());
        node.setCreateUser(task.getCreateUser());
        node.setModifyUser(task.getModifyUser());
        node.setCreateTime(new Date());
        node.setModifyTime(new Date());

        return node;
    }
}
