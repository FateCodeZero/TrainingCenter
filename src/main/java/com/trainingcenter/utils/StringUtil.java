package com.trainingcenter.utils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/21
 * Time: 16:59
 */
public class StringUtil {

    /**
     * 判断字符串为空
     * @param string
     * @return
     */
    public static boolean isEmpty(String string){
        if(string == null || string.equals("")){
            return true;
        } else{
            return false;
        }
    }

    /**
     * 判断字符串不为空
     * @param string
     * @return
     */
    public static boolean isNotEmpty(String string){
        if(string != null && !string.equals("")){
            return true;
        } else{
            return false;
        }
    }

    /**
     * 验证邮箱是否为合法邮箱
     * @param email
     * @return
     */
    public static boolean checkEmail(String email) {
        boolean flag = false;
        try {
            String check = "^([a-z0-9A-Z]+[-|_|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";
            Pattern regex = Pattern.compile(check);
            Matcher matcher = regex.matcher(email);
            flag = matcher.matches();
        } catch (Exception e) {
            flag = false;
            e.printStackTrace();
        }
        return flag;
    }

    /**
     * 验证手机号码，11位数字，1开通，第二位数必须是3456789这些数字之一 *
     * @param mobileNumber
     * @return
     */
    public static boolean checkMobileNumber(String mobileNumber) {
        boolean flag = false;
        try {
            Pattern regex = Pattern.compile("^1[345789]\\d{9}$");
            Matcher matcher = regex.matcher(mobileNumber);
            flag = matcher.matches();
        } catch (Exception e) {
            flag = false;
            e.printStackTrace();
        }
        return flag;
    }
}