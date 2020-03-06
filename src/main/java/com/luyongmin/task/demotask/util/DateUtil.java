package com.luyongmin.task.demotask.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

/**
 * @author: lu.yongmin
 * @date: 2020/3/6 14:18
 * @description:
 */
public class DateUtil {

    public final static String  shortFormat          = "yyyyMMdd";


    public static Date getToday() {
        Date now = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat(DateUtil.shortFormat);
        String dateNowStr = sdf.format(now);
        try {
            return sdf.parse(dateNowStr);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }


    /**
     * 格式化时间
     * @param date
     * @param regex
     * @return
     */
    public static String formatDate(Date date, String regex) {
        if(null == date) return null;

        String s = new SimpleDateFormat(regex).format(date);
        return s;
    }

    public static Date addDay(Date date, int count) {
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(date);
        calendar.add(Calendar.DATE,count);//把日期往后增加一天.整数往后推,负数往前移动
        return calendar.getTime();
    }



    public static Date parse(String sDate,String format) throws ParseException {
        DateFormat dateFormat = new SimpleDateFormat(format);
        return dateFormat.parse(sDate);
    }

}
