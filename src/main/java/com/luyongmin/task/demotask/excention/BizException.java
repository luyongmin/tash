package com.luyongmin.task.demotask.excention;

import com.luyongmin.task.demotask.constant.ErrorCode;

/**
 * @author: lu.yongmin
 * @date: 2020/3/6 15:02
 * @description:
 */
public class BizException extends RuntimeException {

    private static final long serialVersionUID = 2815555528874261201L;

    /** 错误类型 */
    private ErrorCode errorCode;


    public BizException(ErrorCode errorCode) {
        super(errorCode.getMessage());
        this.errorCode = errorCode;
    }

    public BizException(ErrorCode errorCode, String msg) {
        super(msg);
        this.errorCode = errorCode;
    }

    public ErrorCode getErrorCode() {
        return errorCode;
    }

    public void setErrorCode(ErrorCode errorCode) {
        this.errorCode = errorCode;
    }

}
