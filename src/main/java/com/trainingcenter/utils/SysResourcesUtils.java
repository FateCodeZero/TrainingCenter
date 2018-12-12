package com.trainingcenter.utils;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;

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

    /**
     * 获取文件上传路径，默认是操作系统下用户目录
    * @return
     */
    public static String getWebUploadPath(){
        String userHome = System.getProperty("user.home");
        String parentDir = "uploadFiles";
        File file = new File(userHome + File.separator + parentDir);
        return file.toString();
    }
}