package com.trainingcenter.utils;

import org.springframework.security.core.context.SecurityContextHolder;

import javax.servlet.http.HttpServletRequest;
import java.io.Serializable;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/29
 * Time: 21:58
 */
public class SysResourcesUtils implements Serializable {

    /**
     * 获取当前登录用户的用户名
     * @return username
     */
    public static String getCurrentUsername(){
        return SecurityContextHolder.getContext().getAuthentication().getName();
    }
}