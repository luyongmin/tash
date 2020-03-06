package com.luyongmin.task.demotask.enums;

/**
 * @author: lu.yongmin
 * @date: 2020/3/6 15:32
 * @description: 任务状态
 */
public enum TaskStatus {


    WAIT_EXE("0","等待执行"),
    DISPATH("2","已调度"),
    SUCC("1","成功"),
    FAIL("3","失败")
            ;

    private String code;
    private String message;

    /**
     *
     */
    private TaskStatus(String code,String message) {
        this.code = code;
        this.message = message;
    }


    public static TaskStatus getByCode(String code) {
        if(code == null) {
            return null;
        }
        for(TaskStatus status : TaskStatus.values()) {
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
