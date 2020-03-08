package com.luyongmin.task.demotask.service.impl;

import com.luyongmin.task.demotask.constant.Constant;
import com.luyongmin.task.demotask.constant.ErrorCode;
import com.luyongmin.task.demotask.constant.TaskPlanStatus;
import com.luyongmin.task.demotask.convert.TaskPlanConvert;
import com.luyongmin.task.demotask.domain.Task;
import com.luyongmin.task.demotask.domain.TaskPlan;
import com.luyongmin.task.demotask.domain.TaskPlanDetail;
import com.luyongmin.task.demotask.domain.TaskTemplate;
import com.luyongmin.task.demotask.enums.TaskPlanType;
import com.luyongmin.task.demotask.excention.BizException;
import com.luyongmin.task.demotask.mapper.TaskPlanDetailMapper;
import com.luyongmin.task.demotask.mapper.TaskPlanMapper;
import com.luyongmin.task.demotask.service.TaskPlanService;
import com.luyongmin.task.demotask.service.TaskService;
import com.luyongmin.task.demotask.service.TaskTemplateService;
import com.luyongmin.task.demotask.util.DateUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import java.util.*;

/**
 * @author: lu.yongmin
 * @date: 2020/3/6 14:06
 * @description:
 */
@Service
public class TaskPlanServiceImpl implements TaskPlanService {

    private static final Logger logger = LoggerFactory.getLogger(TaskNodeServiceImpl.class);



    @Autowired
    private TaskPlanMapper taskPlanMapper;

    @Autowired
    private TaskPlanDetailMapper taskPlanDetailMapper;

    @Autowired
    private TaskTemplateService taskTemplateService;

    @Autowired
    private TaskService taskService;





    @Override
    @Transactional(propagation= Propagation.REQUIRED,rollbackFor = Exception.class)
    public void createTask(TaskPlan plan) {

        Date settleTimeStart = parseSettleTime(plan.getSettleTimeStart());
        Date settleTimeEnd = parseSettleTime(plan.getSettleTimeEnd());

        if(settleTimeEnd.after(new Date())){
            throw new BizException(ErrorCode.CREATE_TASK_TIME_VALIDATE_FAIL,"计划清算截止时间不得超过当天");
        }

        while(settleTimeStart.compareTo(settleTimeEnd) <=0){
            String settleDate = DateUtil.formatDate(settleTimeStart, "yyyyMMdd");

            if(!CollectionUtils.isEmpty(plan.getPlanDetailList())){
                List<Task> taskList = new ArrayList<Task>();
                for(TaskPlanDetail planDetail : plan.getPlanDetailList()){
                    TaskTemplate template = taskTemplateService.queryCacheByCode(planDetail.getTaskCode());

                    if(template != null){
                        Task task = TaskPlanConvert.buildTask(planDetail,plan,template,settleDate);
                        taskList.add(task);
                    }
                }

                taskService.batchInsert(taskList);
            }

            settleTimeStart = DateUtil.addDay(settleTimeStart,1);
        }

        //更新计划
        TaskPlanType planType = TaskPlanType.getByCode(plan.getPlanType());
        if(planType != null && planType == TaskPlanType.SIGNLE){
            plan.setStatus(TaskPlanStatus.END.getCode());
        }
        plan.setModifyUser(Constant.SYSTEM_USER);
        plan.setLastExtTime(new Date());
        update(plan);




    }

    @Override
    public List<TaskPlan> queryValidPlan() {

        List<TaskPlan> taskPlanList = taskPlanMapper.queryByStatus(TaskPlanStatus.VALID.getCode());

        if(taskPlanList != null && taskPlanList.size()>0){
            for(TaskPlan taskPlan : taskPlanList){
                List<TaskPlanDetail> planDetailList = taskPlanDetailMapper.queryByPlanIdAndStatus(taskPlan.getId(),"1");
                taskPlan.setPlanDetailList(planDetailList);
            }
        }
        return taskPlanList;
    }

    @Override
    public void update(TaskPlan taskPlan) {

    }

    @Override
    public List<TaskPlan> queryTaskPlanByPage() {
        return taskPlanMapper.queryTaskPlan();
    }


    /**
     * 解析清算时间
     * @param settleTimeStr
     * @return
     */
    public Date parseSettleTime(String settleTimeStr) {
        try{
            if(isTemplate(settleTimeStr)){  //认为是模板日期
                String template = getTemplate(settleTimeStr);
                String[] templateArr = template.split(",");

                Date date = DateUtil.getToday();
                if(templateArr != null){
                    if(templateArr.length>1){
                        int count = Integer.valueOf(templateArr[1]);
                        date = DateUtil.addDay(date,count);
                    }
                }

                return date;
            }

            //否则认为是指定日期
            return DateUtil.parse(settleTimeStr, DateUtil.shortFormat);
        }catch(Exception e){
            logger.error(e.getMessage(), e);
            throw new BizException(ErrorCode.CREATE_TASK_FAIL,"解析计划清算时间失败");
        }

    }


    private boolean isTemplate(String settleTimeStr) {
        if(settleTimeStr.indexOf("@{") != -1){
            return true;
        }
        return false;
    }

    private String getTemplate(String settleTimeStr) {
        int start = settleTimeStr.indexOf("@{");
        int end = settleTimeStr.indexOf("}");
        return settleTimeStr.substring(start+2,end);
    }
}
