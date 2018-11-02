package com.trainingcenter.utils;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/29
 * Time: 22:34
 */

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 时间日期工具类
 */
public class DateUtil {
    // 各种时间格式
    public static final SimpleDateFormat date_sdf = new SimpleDateFormat(
            "yyyy-MM-dd");
    // 各种时间格式
    public static final SimpleDateFormat yyyyMMdd = new SimpleDateFormat(
            "yyyyMMdd");
    // 各种时间格式
    public static final SimpleDateFormat date_sdf_wz = new SimpleDateFormat(
            "yyyy年MM月dd日");
    public static final SimpleDateFormat time_sdf = new SimpleDateFormat(
            "yyyy-MM-dd HH:mm");
    public static final SimpleDateFormat yyyymmddhhmmss = new SimpleDateFormat(
            "yyyyMMddHHmmss");
    public static final SimpleDateFormat short_time_sdf = new SimpleDateFormat(
            "HH:mm");
    public static final SimpleDateFormat datetimeFormat = new SimpleDateFormat(
            "yyyy-MM-dd HH:mm:ss");
    // 以毫秒表示的时间
    private static final long DAY_IN_MILLIS = 24 * 3600 * 1000;
    private static final long HOUR_IN_MILLIS = 3600 * 1000;
    private static final long MINUTE_IN_MILLIS = 60 * 1000;
    private static final long SECOND_IN_MILLIS = 1000;

    /**
     * 字符串转为时间日期
     *
     * @param str：要转换的字符串
     * @param sdf：转换格式
     * @return
     */
    public static Date strToDate(String str, SimpleDateFormat sdf) {
        if (StringUtil.isEmpty(str)) {
            return null;
        }
        Date date = null;
        try {
            date = sdf.parse(str);
            return date;
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 字符串转换时间戳
     *
     * @param str
     * @return
     */
    public static Timestamp strToTimestamp(String str, SimpleDateFormat sdf) {
        Date date = strToDate(str, sdf);
        return new Timestamp(date.getTime());
    }

    /**
     * 时间日期转字符串
     *
     * @param date：时间日期
     * @param sdf：指定格式
     * @return
     */
    public static String dateToStr(Date date, SimpleDateFormat sdf) {
        return date == null ? null : sdf.format(date);
    }
} 