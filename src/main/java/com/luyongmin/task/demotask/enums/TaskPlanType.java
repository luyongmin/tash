package com.luyongmin.task.demotask.enums;

/**
 * @author: lu.yongmin
 * @date: 2020/3/6 16:12
 * @description: 任务计划类型
 */
public enum TaskPlanType {


    LOOP("1","循环执行"),
    SIGNLE("2","单次执行"),
    ;

    private String code;
    private String message;

    /**
     *
     */
    private TaskPlanType(String code,String message) {
        this.code = code;
        this.message = message;
    }


    public static TaskPlanType getByCode(String code) {
        if(code == null) return null;
        for(TaskPlanType status : TaskPlanType.values()) {
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
