package com.trainingcenter.utils;

import org.apache.commons.logging.LogFactory;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/23
 * Time: 1:44
 */

/**
 * log4j再封装
 *
 * 使用如下：
 *      Log.info(this, "过滤链接地址", "servletPath:" + servletPath);
 */
public class LogUtil {
    private static Logger log = LogManager.getLogger("logTime");

    public static void info(Object object, String tittle, String text) {
        org.apache.commons.logging.Log logger = LogFactory.getLog(object.getClass());

        String infoStart = "\n————————————————————————————————————————————————————————[Info Start]——\n";
        StringBuffer stringBuffer = new StringBuffer(infoStart);
        String infoEnd = "————————————————————————————————————————————————————————[Info   End]——\n";
        stringBuffer.append("标题:" + tittle + "\n内容:")
                .append(text + "\n")
                .append(infoEnd);
        logger.info(stringBuffer.toString());
        log.info(stringBuffer.toString());
    }

    public static void warn(Object object, String tittle, String text) {
        org.apache.commons.logging.Log logger = LogFactory.getLog(object.getClass());

        String infoStart = "\n————————————————————————————————————————————————————————[Info Start]——\n";
        StringBuffer stringBuffer = new StringBuffer(infoStart);
        String infoEnd = "————————————————————————————————————————————————————————[Info   End]——\n";
        stringBuffer.append("标题:" + tittle + "\n内容:")
                .append(text + "\n")
                .append(infoEnd);
        logger.info(stringBuffer.toString());
        log.warn(stringBuffer.toString());
    }

    public static void error(Object object, String tittle, String text, Throwable t) {
        org.apache.commons.logging.Log logger = LogFactory.getLog(object.getClass());
        String infoStart = "\n————————————————————————————————————————————————————————[Info Start]——\n";
        String infoEnd = "————————————————————————————————————————————————————————[Info   End]——\n";
        StringBuffer stringBuffer = new StringBuffer(infoStart);
        stringBuffer.append("标题:" + tittle + "\n内容:")
                .append(text + "\n")
                .append(infoEnd);
        logger.error(stringBuffer.toString(), t);
        log.error(stringBuffer.toString());
    }

    public static void debug(Object object, String tittle, String text) {
        org.apache.commons.logging.Log logger = LogFactory.getLog(object.getClass());
        String infoStart = "\n————————————————————————————————————————————————————————[Info Start]——\n";
        String infoEnd = "————————————————————————————————————————————————————————[Info   End]——\n";
        StringBuffer stringBuffer = new StringBuffer(infoStart);
        stringBuffer.append("标题:" + tittle + "\n内容:")
                .append(text + "\n")
                .append(infoEnd);
        logger.debug(stringBuffer.toString());
        log.debug(stringBuffer.toString());
    }
}