package com.luyongmin.task.demotask.domain;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * @author: lu.yongmin
 * @date: 2020/3/6 15:36
 * @description:
 */
@Getter
@Setter
public class BaseModel implements Serializable {

    private static final long serialVersionUID = 1L;

    /** 时间区间 */
    private String _start_time;
    private String _end_time;

    /** 分页 */
    private Integer page;
    private Integer rows;

    /** 价格区间  */
    private BigDecimal _start_price;
    private BigDecimal _end_price;
}
