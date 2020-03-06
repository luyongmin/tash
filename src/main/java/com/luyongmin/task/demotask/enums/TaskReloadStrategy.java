package com.luyongmin.task.demotask.enums;

/**
 * @author: lu.yongmin
 * @date: 2020/3/6 15:41
 * @description: 任务重载策略
 */
public enum TaskReloadStrategy {
    PUSH("PUSH","推进"),
    RE_EXE("RE_EXE","重新执行"),
    ;

    private String code;
    private String message;

    /**
     *
     */
    private TaskReloadStrategy(String code,String message) {
        this.code = code;
        this.message = message;
    }


    public static TaskReloadStrategy getByCode(String code) {
        if(code == null) return null;
        for(TaskReloadStrategy status : TaskReloadStrategy.values()) {
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
