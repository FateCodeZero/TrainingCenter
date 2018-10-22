package com.trainingcenter.utils;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/23
 * Time: 1:44
 */
public class LogUtil {
    /**
     * 注意：LogUtil类中LogManager.getLogger中的参数logTime应该和log4j2.xml中Logger name的名称完全一样。
     */
    static private Logger logger = LogManager.getLogger("logTime");

    /**
     * 追踪
     * @param object
     */
    public static void trace(Object object) {
        logger.trace(object);
    }

    /**
     * debug
     * @param object
     */
    public static void debug(Object object) {
        logger.debug(object);
    }

    /**
     * 信息
     * @param object
     */
    public static void info(Object object) {
        logger.info(object);
    }

    /**
     * 警告
     * @param object
     */
    public static void warn(Object object) {
        logger.warn(object);
    }

    /**
     * 错误
     * @param object
     */
    public static void error(Object object) {
        logger.error(object);
    }

    /**
     * 致命错误
     * @param object
     */
    public static void fatal(Object object) {
        logger.fatal(object);
    }
}