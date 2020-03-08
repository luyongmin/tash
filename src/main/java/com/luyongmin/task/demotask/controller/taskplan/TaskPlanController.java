package com.luyongmin.task.demotask.controller.taskplan;

import com.luyongmin.task.demotask.core.CreateTaskByPlanJob;
import com.luyongmin.task.demotask.domain.TaskPlan;
import com.luyongmin.task.demotask.service.TaskPlanService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

/**
 * @program: demotask
 * @author: lu.yongmin
 * @create: 2020-03-08 15:45
 * @description:
 **/
@Controller
@RequestMapping("/taskplan/")
public class TaskPlanController {

    private static final Logger logger = LoggerFactory.getLogger(TaskPlanController.class);

    @Autowired
    private TaskPlanService taskPlanService;


    @RequestMapping("/list")
    public String list(Model model){
        List<TaskPlan> list = taskPlanService.queryTaskPlanByPage();
        model.addAttribute("list",list);
        return "workbench/taskplan/index.html";
    }







}
