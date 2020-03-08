package com.luyongmin.task.demotask.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.Map;

/**
 * @program: demotask
 * @author: lu.yongmin
 * @create: 2020-03-06 21:15
 * @description:
 **/
@Controller
public class LogController {

    @GetMapping("/index")
    public String index(){
        return "workbench/index.html";
    }



}
