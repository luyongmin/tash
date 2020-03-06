package com.luyongmin.task.demotask.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * @author: lu.yongmin
 * @date: 2020/3/6 15:12
 * @description: 任务模板
 */
@Getter
@Setter
@ToString
public class TaskTemplate implements Serializable {

    /**
     * 主键
     */
    private Long id;
    /**
     * 任务名称
     */
    private String taskName;
    /**
     * 任务编号
     */
    private String taskCode;
    /**
     * 任务说明
     */
    private String taskDesc;
    /**
     * 任务参数（暂定逗号分隔）
     */
    private String taskParam;
    /**
     * 状态
     */
    private String status;
    /**
     * 创建用户
     */
    private String createUser;
    /**
     * 创建时间
     */
    private Date createTime;
    /**
     * 修改用户
     */
    private String modifyUser;
    /**
     * 修改时间
     */
    private Date modifyTime;
    /**
     * 节点模板列表
     */
    private List<TaskNodeTemplate> nodeTemplateList;
}
