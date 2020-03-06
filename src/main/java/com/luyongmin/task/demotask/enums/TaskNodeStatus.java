package com.luyongmin.task.demotask.enums;

/**
 * @author: lu.yongmin
 * @date: 2020/3/6 16:07
 * @description:
 */
public enum TaskNodeStatus {

    WAIT_EXE("0","等待执行"),
    EXEING("2","执行中"),
    SUCC("1","成功"),
    FAIL("3","失败")
    ;

    private String code;
    private String message;

    /**
     *
     */
    private TaskNodeStatus(String code,String message) {
        this.code = code;
        this.message = message;
    }


    public static TaskNodeStatus getByCode(String code) {
        if(code == null) return null;
        for(TaskNodeStatus status : TaskNodeStatus.values()) {
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
