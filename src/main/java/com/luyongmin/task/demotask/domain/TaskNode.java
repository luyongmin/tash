package com.luyongmin.task.demotask.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.io.Serializable;
import java.util.Date;
import java.util.Map;

/**
 * @author: lu.yongmin
 * @date: 2020/3/6 15:08
 * @description:
 */
@Getter
@Setter
@ToString
public class TaskNode  implements Serializable {

    private static final long serialVersionUID = -7461365188512000104L;
    /**
     * 主键
     */
    private Long id;
    /**
     * 任务编号
     */
    private Long taskId;
    /**
     * 节点编号
     */
    private String nodeCode;
    /**
     * 节点名称
     */
    private String nodeName;
    /**
     * 执行令牌
     */
    private String executeToken;
    /**
     * 响应编号
     */
    private String respCode;
    /**
     * 响应信息
     */
    private String respMsg;
    /**
     * 节点开始时间
     */
    private Date nodeStartTime;
    /**
     * 优先级
     */
    private Integer priority;
    /**
     * 前置节点
     */
    private String frontNode;
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
     * 节点参数
     */
    private Map<String,Object> nodeParamMap;
    /**
     * 任务优先级
     */
    private Integer taskPriority;
    /**
     * 结算日期
     */
    private String settleDate;

    /**
     * 是否全量重新执行
     */
    private boolean clearAll;

}
