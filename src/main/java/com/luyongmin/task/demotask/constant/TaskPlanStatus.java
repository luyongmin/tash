package com.luyongmin.task.demotask.constant;

/**
 * @author: lu.yongmin
 * @date: 2020/3/6 14:21
 * @description:任务计划状态
 */
public enum  TaskPlanStatus {



    VALID("1","有效"),
    END("2","完成"),
            ;

    private String code;
    private String message;

    /**
     *
     */
    private TaskPlanStatus(String code,String message) {
        this.code = code;
        this.message = message;
    }


    public static TaskPlanStatus getByCode(String code) {
        if(code == null) return null;
        for(TaskPlanStatus status : TaskPlanStatus.values()) {
            if(status.getCode().equals(code)) {
                return status;
            }
        }
        return null;
    }

    public String getCode() {
        return code;
    }


    public String getMessage() {
        return message;
    }
}
