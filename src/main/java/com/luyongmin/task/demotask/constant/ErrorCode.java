package com.luyongmin.task.demotask.constant;

/**
 * @author: lu.yongmin
 * @date: 2020/3/6 15:03
 * @description:错误编码
 */
public enum ErrorCode {

    /** 提交成功*/
    APPLY_SUCCESS("APPLY_SUCCESS","提交成功"),

    /** 系统错误*/
    SYSTEM_ERROR("SYSTEM_ERROR", "系统错误"),

    /** 请求参数校验失败*/
    REQUEST_PARAM_VALIDATE_ERROR("REQUEST_PARAM_VALIDATE_ERROR", "请求参数校验失败"),

    /** 参数校验未通过*/
    ILLEGAL_ARGUMENT("ILLEGAL_ARGUMENT", "参数校验未通过"),

    /** 列表为空*/
    LIST_IS_NULL("LIST_IS_NULL", "列表为空"),

    /** 创建任务失败*/
    CREATE_TASK_TIME_VALIDATE_FAIL("CREATE_TASK_TIME_VALIDATE_FAIL","创建任务时间验证失败"),

    /** 创建任务失败*/
    CREATE_TASK_FAIL("CREATE_TASK_FAIL","创建任务失败"),

    /** 重载任务失败*/
    RELOAD_PLAN_FAIL("RELOAD_PLAN_FAIL","重载任务失败"),

    /** 不是已核销商户 */
    NOT_VERI_MER("NOT_VERI_MER","不是已核销商户"),








    QUERY_MALL_MEMBER_FAIL("QUERY_MALL_MEMBER_FAIL","查询商圈会员信息失败"),

    /** 任务节点状态错误 */
    TASK_NODE_STATUS_ERROR("TASK_NODE_STATUS_ERROR","任务节点状态错误"),

    /** 任务节点无法处理 */
    TASK_NODE_MANAGER_NULL("TASK_NODE_MANAGER_NULL","任务节点无法处理"),

    /** 前置任务失败 */
    FRONT_TASK_FAIL("FRONT_TASK_FAIL","前置任务失败"),

    /** 前置任务未完成 */
    FRONT_TASK_UNCOMPLETE("FRONT_TASK_UNCOMPLETE","前置任务未完成"),

    /** 任务未到开始时间 */
    TASK_START_TIME_FAIL("TASK_START_TIME_FAIL","任务未到开始时间"),

    /** 任务节点未到开始时间 */
    TASK_NODE_START_TIME_FAIL("TASK_NODE_START_TIME_FAIL","任务节点未到开始时间"),

    TASK_DISPATH_SERVICE_NULL("TASK_DISPATH_SERVICE_NULL","任务调度未配属可用服务"),

    QUERY_TASK_NULL("QUERY_TASK_NULL","未查到任务信息"),

    CALC_PRODUCTS_SETTLE_AMOUNT_FAIL("CALC_PRODUCTS_SETTLE_AMOUNT_FAIL","计算商品结算金额失败"),

    CALC_SETTLE_AMOUNT_FAIL("CALC_SETTLE_AMOUNT_FAIL","计算结算金额失败"),

    SETTLE_SHEET_SEND_MAIL_FAIL("SETTLE_SHEET_SEND_MAIL_FAIL","结算单发送邮件失败"),

    COLLECT_ENTRY_MESSAGE_FAIL("COLLECT_ENTRY_MESSAGE_FAIL","采集入账消息失败"),

    COLLECT_ENTRY_VALIDE_FAIL("COLLECT_ENTRY_VALIDE_FAIL","采集命令校验失败"),


    // 处理中
    APPLY_IN_PROCESS("2222", "处理中")

    ;

    /** 代码 */
    private String code;

    /** 信息 */
    private String message;

    ErrorCode(String code, String message) {
        this.code = code;
        this.message = message;
    }

    /**
     * 根据代码获取ENUM
     * @param code
     * @return
     */
    public static ErrorCode getByCode(String code) {
        for (ErrorCode e : ErrorCode.values()) {
            if (e.getCode().equals(code)) {
                return e;
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
