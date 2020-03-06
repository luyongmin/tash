package com.luyongmin.task.demotask.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.List;

/**
 * @author: lu.yongmin
 * @date: 2020/3/6 15:37
 * @description:
 */
@Getter
@Setter
@ToString
public class TaskQuery extends BaseModel {


    private static final long serialVersionUID = 6808825819244395788L;
    /**
     * 计划ID
     */
    private Long planId;
    /**
     * 清算日期
     */
    private String settleDate;
    /**
     * 任务列表
     */
    private List<Long> taskIdList;
    /**
     * 任务编号
     */
    private String taskCode;
    /**
     * 状态
     */
    private String status;
}
