package com.trainingcenter.utils;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/23
 * Time: 1:44
 */

/**
 * log4j2再封装
 */
public class LogUtil {
    private static Logger log = LogManager.getLogger("logTime");

    public static void info(Object object, String tittle, String text) {

        String infoStart = "\n————————————————————————————————————————————————————————[Info Start]——\n";
        StringBuffer stringBuffer = new StringBuffer(infoStart);
        String infoEnd = "————————————————————————————————————————————————————————[Info   End]——\n";
        stringBuffer.append("标题:").append(tittle).append("\n")
                .append("内容:").append(text).append("\n")
                .append(infoEnd);
        log.info(stringBuffer.toString());
    }

    public static void warn(Object object, String tittle, String text) {

        String infoStart = "\n————————————————————————————————————————————————————————[Info Start]——\n";
        StringBuffer stringBuffer = new StringBuffer(infoStart);
        String infoEnd = "————————————————————————————————————————————————————————[Info   End]——\n";
        stringBuffer.append("标题:").append(tittle).append("\n")
                .append("内容:").append(text).append("\n")
                .append(infoEnd);
        log.warn(stringBuffer.toString());
    }

    public static void error(Object object, String tittle, String text, Throwable t) {
        String infoStart = "\n————————————————————————————————————————————————————————[Info Start]——\n";
        String infoEnd = "————————————————————————————————————————————————————————[Info   End]——\n";
        StringBuffer stringBuffer = new StringBuffer(infoStart);
        stringBuffer.append("标题:").append(tittle).append("\n")
                .append("内容:").append(text).append("\n")
                .append("错误信息：\n").append(t.fillInStackTrace()).append("\n")
                .append(infoEnd);
        log.error(stringBuffer.toString());
    }

    public static void debug(Object object, String tittle, String text) {
        String infoStart = "\n————————————————————————————————————————————————————————[Info Start]——\n";
        String infoEnd = "————————————————————————————————————————————————————————[Info   End]——\n";
        StringBuffer stringBuffer = new StringBuffer(infoStart);
        stringBuffer.append("标题:").append(tittle).append("\n")
                .append("内容:").append(text).append("\n")
                .append(infoEnd);
        log.debug(stringBuffer.toString());
    }
}