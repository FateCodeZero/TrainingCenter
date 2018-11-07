package com.trainingcenter.security.handler;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/11/4
 * Time: 18:51
 */

import com.trainingcenter.service.UserService;
import com.trainingcenter.utils.SysUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 认证成功后处理器
 */
public class AuthenticationSuccessHandlerImpl implements AuthenticationSuccessHandler{
    @Qualifier("userService")
    @Autowired
    UserService userService;    //可做更新用户IP、最后登录时间等操作

    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
//        String path = request.getContextPath();

        /**
         * Spring Security默认使用的RequestCache是HttpSessionRequestCache，
         * 其会将HttpServletRequest相关信息封装为一个SavedRequest保存在HttpSession中。
         */
        //先从缓存里获取用户请求的URL
        RequestCache requestCache = new HttpSessionRequestCache();
        HttpServletRequest matchingRequest = requestCache.getMatchingRequest(request, response);//获取到用户请求的url

        //若缓存的request不为空则使用缓存的request
        if (matchingRequest != null){
            matchingRequest.getSession().setAttribute("username", SysUtil.getCurrentUsername());
            request.getRequestDispatcher("/index.jsp").forward(request,response);
        }else {
            request.getSession().setAttribute("username", SysUtil.getCurrentUsername());
            request.getRequestDispatcher("/index.jsp").forward(request,response);
        }
    }
}