package com.luyongmin.task.demotask.util;

/**
 * @author: lu.yongmin
 * @date: 2020/3/6 14:14
 * @description:
 */
public class SessionUtil {

    /**
     * @Description: 为每个线程生成唯一的sessionId
     * @return String sessionId
     * @throws
     */
    public static String getSessionId() {
        String sessionId = System.currentTimeMillis() + ""
                + (int) ((Math.random() * 10000));
        return sessionId;
    }
}
