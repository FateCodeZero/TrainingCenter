package com.trainingcenter.utils;

import org.springframework.security.core.Authentication;
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
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null){
            return null;
        }else {
            return authentication.getName();
        }
    }
}