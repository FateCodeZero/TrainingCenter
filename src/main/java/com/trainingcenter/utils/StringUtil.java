package com.trainingcenter.utils;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/21
 * Time: 16:59
 */
public class StringUtil {

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
}