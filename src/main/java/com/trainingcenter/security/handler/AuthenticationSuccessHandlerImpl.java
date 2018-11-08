package com.trainingcenter.security.handler;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/11/4
 * Time: 18:51
 */

import com.trainingcenter.bean.LoginInfo;
import com.trainingcenter.bean.User;
import com.trainingcenter.exception.UpdateException;
import com.trainingcenter.service.LoginInfoService;
import com.trainingcenter.service.UserService;
import com.trainingcenter.utils.HTTPUtils;
import com.trainingcenter.utils.LogUtil;
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

/**
 *  Security 登录成功后跳转及响应统一处理器
 * 该类继承了SavedRequestAwareAuthenticationSuccessHandler，它会从缓存中提取请求，从而可以恢复之前请求的数据。
 */
public class AuthenticationSuccessHandlerImpl extends SavedRequestAwareAuthenticationSuccessHandler {
    @Qualifier("userService")
    @Autowired
    private UserService userService;    //可用来获取用户基本信息

    @Qualifier("loginInfoService")
    @Autowired
    private LoginInfoService loginInfoService;  //可做更新用户IP、最后登录时间等操作

    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {

        UserDetails userDetails = null;
        User user = null;
        LoginInfo loginInfo = null;
        userDetails = (UserDetails) authentication.getPrincipal();

        //避免空指针异常
        if (userDetails != null){
            user = userService.getUserByUsername(userDetails.getUsername());
            loginInfo = loginInfoService.getLoginInfoByUsername(userDetails.getUsername());
        }

        // 认证成功后，获取用户信息并添加到session中
        request.getSession().setAttribute("user", user);

        //更新用户的登录IP与最后登录时间
        if (loginInfo != null){
            loginInfo.setLastLoginTime(new Date());
            loginInfo.setLoginIP(HTTPUtils.getClientIpAddress(request));
            try {
                loginInfoService.update(loginInfo);
            } catch (UpdateException e) {
                LogUtil.error(this,"登录成功后处理","更新用户登录IP与最后登录时间失败",e);
                e.printStackTrace();
            }
            LogUtil.info(this,"登录成功后处理","用户【"+loginInfo.getUsername()+"】登录成功");
        }

        super.onAuthenticationSuccess(request, response, authentication);
    }
}