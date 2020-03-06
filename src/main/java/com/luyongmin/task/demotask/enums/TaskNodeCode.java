package com.luyongmin.task.demotask.enums;

/**
 * @author: lu.yongmin
 * @date: 2020/3/6 17:05
 * @description:
 */
public enum  TaskNodeCode {

    COUPON_SETTLE_TABLE_SYS("COUPON_SETTLE_TABLE_SYS"," 用户优惠券结算"),
    ORDER_TABLE_SYS("ORDER_TABLE_SYS"," 同步业务订单表信息同步"),
    POINTS_ACCOUNT_TABLE_SYS("POINTS_ACCOUNT_TABLE_SYS","账户信息同步"),
    ACCOUNT_LOG_TABLE_SYN("ACCOUNT_LOG_TABLE_SYN","账户明细同步"),
    POINT_TXN_TABLE_SYN("POINT_TXN_TABLE_SYN","用户交易信息同步"),
    MEMBER_INFO_TABLE_SYN("MEMBER_INFO_TABLE_SYN","会员表同步"),
    POINT_CORE_ORIGIN_TABLE_SYN("POINT_CORE_ORIGIN_TABLE_SYN","积分核心交易溯源表同步 "),
    MALL_ORIGIN_TABLE_SYN("MALL_ORIGIN_TABLE_SYN","商城溯源表同步"),
    POINT_CORE_TXN_TABLE_SYN("POINT_CORE_TXN_TABLE_SYN","积分核心交易表同步"),
    CASHIER_PAY_TRANS_SYN("CASHIER_PAY_TRANS_SYN","收银台支付记录同步"),
    BUTLER_POINTS_ORDER_SYN("BUTLER_POINTS_ORDER_SYN","管家订单表同步"),
    POINTS_ACC_RDM_TABLE_SYS("POINTS_ACC_RDM_TABLE_SYS","加减分三张表同步"),

    ALIPAY_COLLATE("ALIPAY_COLLATE","支付宝对账"),
    WXPAY_COLLATE("WXPAY_COLLATE","微信对账"),
    JFPAY_COLLATE("JFPAY_COLLATE","积分核心对账"),
    ZHPAY_COLLATE("ZHPAY_COLLATE","中行对账"),

    OUTER_EXCHANGE_CMCC_COLLATE("OUTER_EXCHANGE_CMCC_COLLATE","股东方兑换-移动对账"),
    OUTER_EXCHANGE_MU_COLLATE("OUTER_EXCHANGE_MU_COLLATE","股东方兑换-东航对账"),
    OUTER_CONSUME_CMCC_COLLATE("OUTER_CONSUME_CMCC_COLLATE","股东方消费-移动对账"),
    OUTER_CONSUME_MU_COLLATE("OUTER_CONSUME_MU_COLLATE","股东方消费-东航对账"),

    JFZC_ORDER_TABLE_SYN("JFZC_ORDER_TABLE_SYN","众筹订单表同步"),
    CASHIER_JFZC_FILE("CASHIER_JFZC_FILE","收银台众筹生成文件"),
    MER_JFZC_COLLATE("MER_JFZC_COLLATE","众筹对账"),
    MALL_ORDER_TABLE_SYN("MALL_ORDER_TABLE_SYN","商城订单表同步"),
    CASHIER_MALL_FILE("CASHIER_MALL_FILE","收银台商城生成文件"),
    MER_MALL_COLLATE("MER_MALL_COLLATE","商城对账"),

    CASHIER_BUTLER_EX_SYN("CASHIER_BUTLER_EX_SYN","收银台积分管家交易同步"),
    MER_BUTLER_COLLATE("MER_BUTLER_COLLATE","收营台-积分管家对账"),

    CONSUME_SPLIT("CONSUME_SPLIT","消费数据拆分"),

    MER_ORDER_CLEAR("MER_ORDER_CLEAR","商户订单清分"),
    ADD_PROVIDER_ORDER("ADD_PROVIDER_ORDER","添加供应商订单号"),
    MER_ECard_CLEAR("MER_ECard_CLEAR","商户卡券核销清分"),
    MER_PRODUCT_CLEAR("MER_PRODUCT_CLEAR","商户商品清分"),
    MER_ORDER_FILE("MER_ORDER_FILE","生成商户订单对账文件"),
    MER_PRODUCT_FILE("MER_PRODUCT_FILE","生成商户商品对账文件"),
    MER_TOTEL_CLEAR("MER_TOTEL_CLEAR","商户汇总清分"),

    OUTER_TRANS_DETAIL_CLEAR("OUTER_TRANS_DETAIL_CLEAR","股东方交易明细清分"),
    OUTER_TRANS_TOTAL_CLEAR("OUTER_TRANS_TOTAL_CLEAR","股东方交易汇总清分"),
    JFDR_CLEAR("JFDR_CLEAR","积分兑入清分"),

    BOSC_PAY_DETAIL_FILE("BOSC_PAY_DETAIL_FILE","上海银行交易明细文件"),

    POINT_TRIAL_BALANCE("POINT_TRIAL_BALANCE_COLLATE","账户积分试算平衡"),

    SECOND_TRACE_COLLATE("SECOND_TRACE_COLLATE","二次溯源对账"),

    OCCURRENCE_AMOUNT_COLLATE("OCCURRENCE_AMOUNT_COLLATE","日发生额对账"),

    ROC_EXR_FILE_FETCH("ROC_EXR_FILE_FETCH","中行兑换量取文件"),

    ROC_AOU_FILE_FETCH("ROC_AOU_FILE_FETCH","中行消费量取文件"),

    SEND_ROC_EXR_FILE_FETCH("SEND_ROC_EXR_FILE_FETCH","中行兑换量发文件"),

    SEND_ROC_AOU_FILE_FETCH("SEND_ROC_AOU_FILE_FETCH","中行消费量发文件"),

    SYS_DIFF_HANDLE("SYS_DIFF_HANDLE","系统差异处理"),

    MER_ORDER_INTEGRATION_CLEAR("MER_ORDER_INTEGRATION_CLEAR","商户订单整合清分"),


    CHECK_DATA_MNG("CHECK_DATA_MNG","同步数据检查"),
    CHECK_DATA_DIF_MNG("CHECK_DATA_DIF_MNG","同步数据检查"),

    SYN_COLLECT_COLLAGE_TEAM_DATA_MNG("SYN_COLLECT_COLLAGE_TEAM_MNG","同步拼团订单"),

    SYN_MALL_DATA_MNG("SYN_MALL_DATA_MNG","同步商城订单"),


    SYN_TRHOTELDB_DATA_MNG("SYN_TRHOTELDB_DATA_MNG","同步出行订单"),
    SYN_TR_FLIGHT_TB_DATA_MNG("SYN_TR_FLIGHT_TB_DATA_MNG","同步机票tb订单"),
    SYN_TR_FLIGHT_TC_DATA_MNG("SYN_TR_FLIGHT_TC_DATA_MNG","同步机票tc订单"),
    SYN_TR_FOOD_DATA_MNG("SYN_TR_FOOD_DATA_MNG","同步美食订单"),



    SYN_PARTNER_TB_DATA("SYN_PARTNER_TB_DATA","同步合作方订单"),

    TOTLE_MER_POINT("TOTLE_MER_POINT","花分入分统计"),

    SYN_MER_CHANT_MNG("SYN_MER_CHANT_MNG","积分扫描付"),
    SYN_WALLET_DATA_MNG("SYN_WALLET_DATA_MNG","钱包"),
    STATISTICS_SYN_DATA("STATISTICS_SYN_DATA","统计数据"),
    ALARM_POINTSTRANS_TOTAL_MONTH("ALARM_POINTS_TOTAL_MONTH","股东方消费汇总月统计"),
    SEND_DIF_FILE_EXR_MNG("SEND_DIF_FILE_EXR_MNG","处理兑换差异文件"),
    SYN_COLLECT_COUPON_DATA("SYN_COLLECT_COUPON_DATA","收集优惠券信息"),
    ALARM_TASK_NODE("ALARM_TASK_NODE","任务节点执行情况告警"),
    ACCOUNT_DAY_CUT("ACCOUNT_DAY_CUT","账务核心日切"),
    GEN_EXCEL_FILE("GEN_EXCEL_FILE","生成excel文件"),

    ACCOUNT_SETTLE_MONITOR_MNG("ACCOUNT_SETTLE_MONITOR_MNG","核心账务记账监测"),

    // 清分采集器
    COLLECT_CASHSETTLE("COLLECT_CASHSETTLE","支付渠道清分采集"),
    // 积分过期采集器
    COLLECT_EXPIRE_POINT("COLLECT_EXPIRE_POINT","积分过期采集器"),
    // 结算清分采集器
    COLLECT_SETTLE_CLEAR("COLLECT_SETTLE_CLEAR","结算清分采集器"),

    CYP_SETTLE_CLEAR("CYP_SETTLE_CLEAR","畅由积分源清分"),
    GD_SETTLE_CLEAR("GD_SETTLE_CLEAR","非畅由积分源清分"),
    // 商城优惠券
    COLLCECT_MALL_COUPON("COLLCECT_MALL_COUPON","商城优惠券"),
    MER_ORDER_WITH_ACCOUNT_CLEAR("MER_ORDER_WITH_ACCOUNT_CLEAR","商户订单清分与账务"),
    CLEAR_WARNING_EMAIL("CLEAR_WARNING_EMAIL","清分比对告警"),
    POINTS_EXCHANGE_SYN("POINTS_EXCHANGE_SYN","兑出数据同步"),
    SCANPAY_SYN("SCANPAY_SYN","银联商务数据同步"),
    FILE_SCANPAY_ORDER_FILE("FILE_SCANPAY_ORDER_FILE","推送银联商务明细文件"),
    CLEAR_PRODUCT_TOTAL("CLEAR_PRODUCT_TOTAL","商品清分和汇总清分"),
    CREATE_EXCEL_FILE("CREATE_EXCEL_FILE","生成结算单和文件"),
    FETCH_SCANPAY_FILE_MNG("FETCH_SCANPAY_FILE_MNG","获取银联对账文件"),
    FILE_RUI_XIAN_MNG("FILE_RUI_XIAN_MNG","江苏瑞祥积分"),
    CLEAR_SETTLE_MONITOR("CLEAR_SETTLE_MONITOR","统计T日清分明细中结算价为0元的总笔数"),

            ;



    private String code;
    private String message;

    /**
     *
     */
    private TaskNodeCode(String code,String message) {
        this.code = code;
        this.message = message;
    }


    public static TaskNodeCode getByCode(String code) {
        if(code == null) {
            return null;
        }
        for(TaskNodeCode type : TaskNodeCode.values()) {
            if(type.getCode().equals(code)) {
                return type;
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
