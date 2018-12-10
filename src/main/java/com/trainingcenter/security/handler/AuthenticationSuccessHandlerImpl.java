package com.trainingcenter.security.handler;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/11/4
 * Time: 18:51
 */

import com.trainingcenter.bean.User;
import com.trainingcenter.bean.UserInfo;
import com.trainingcenter.exception.UpdateException;
import com.trainingcenter.service.UserService;
import com.trainingcenter.service.UserInfoService;
import com.trainingcenter.utils.HTTPUtils;
import com.trainingcenter.utils.LogUtil;
import com.trainingcenter.utils.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 *  Security 登录成功后跳转及响应统一处理器
 * 该类继承了SavedRequestAwareAuthenticationSuccessHandler，它会从缓存中提取请求，从而可以恢复之前请求的数据。
 */
public class AuthenticationSuccessHandlerImpl extends SavedRequestAwareAuthenticationSuccessHandler {
    @Qualifier("userInfoService")
    @Autowired
    private UserInfoService userInfoService;    //可用来获取用户基本信息

    @Qualifier("userService")
    @Autowired
    private UserService userService;  //可做更新用户IP、最后登录时间等操作

    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {

        UserDetails userDetails; //认证信息
        UserInfo userInfo = null;       //用户个人信息
        User user = null;               //用户登录信息
        userDetails = (UserDetails) authentication.getPrincipal();

        //避免空指针异常
        if (userDetails != null){
            userInfo = userInfoService.getUserInfoByUsername(userDetails.getUsername());
            user = userService.getUserByUsername(userDetails.getUsername());

            // 认证成功后，获取用户个人信息并添加到session中
            request.getSession().setAttribute("user", userInfo);

            //更新用户的登录IP与最后登录时间
            if (user != null){
                user.setLastLoginTime(new Date());
                user.setLoginIP(HTTPUtils.getClientIpAddress(request));
                try {
                    userService.update(user);
                } catch (UpdateException e) {
                    LogUtil.info(this,"登录成功后处理","更新用户登录IP与最后登录时间失败");
                    e.printStackTrace();
                }
                LogUtil.info(this,"登录成功后处理","用户【"+user.getUsername()+"】登录成功");
            }

            if (HTTPUtils.isAjaxRequest(request)){

                Map<String,Object> data = new ConcurrentHashMap<>(); //要返回的数据

                //获取登录前拦截时存入的 url
                String url = (String) request.getSession().getAttribute("backUrl");

                //若记录的url不为空，且不是直接请求的登录页面，就跳转到之前用户请求的页面，否则跳到首页
                if (StringUtil.isNotEmpty(url) && !(url.endsWith("/user/login") || url.endsWith("/static/login.jsp"))){
                    data.put("url",url);
                }else {
                    url = request.getContextPath() + "/index.jsp";   //设置默认跳转的url
                    data.put("url",url);
                }
                data.put("username",userDetails.getUsername());
                Map<String,Object> map = new ConcurrentHashMap<>();
                map.put("code",1);
                map.put("msg","登录成功");
                map.put("data",data);

                //向前端响应
                HTTPUtils.responseByJacson(request,response,map);
            }else {
                //带有用户请求记忆的跳转，但在使用 ajax 请求时跳不过去
                super.onAuthenticationSuccess(request, response, authentication);
            }
        }
    }
}