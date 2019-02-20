package com.trainingcenter.security.authentication.entrypoint;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.PortMapper;
import org.springframework.security.web.PortResolver;
import org.springframework.security.web.authentication.LoginUrlAuthenticationEntryPoint;
import org.springframework.security.web.util.RedirectUrlBuilder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/11/11
 * Time: 23:00
 */

/**
 * 自定义登录前拦截类
 */
public class AuthenticationEntryPoint extends LoginUrlAuthenticationEntryPoint {

    public AuthenticationEntryPoint(String loginFormUrl) {
        super(loginFormUrl);
    }

    @Override
    public void afterPropertiesSet() throws Exception {
        super.afterPropertiesSet();
    }

    /**
     * 获取登录前请求的url
     * @param request
     * @param response
     * @param exception
     * @return
     */
    @Override
    protected String determineUrlToUseForThisRequest(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) {

        try{
            //将 登录成功后 要跳转的URL存入 session 中
            String backUrl = buildHttpReturnUrlForRequest(request);
            request.getSession().setAttribute("backUrl",backUrl);
        }catch(Exception e){
            e.printStackTrace();
        }

        return super.determineUrlToUseForThisRequest(request, response, exception);
    }

    @Override
    public void commence(HttpServletRequest request, HttpServletResponse response, AuthenticationException authException) throws IOException, ServletException {
        super.commence(request, response, authException);
    }

    @Override
    protected String buildRedirectUrlToLoginPage(HttpServletRequest request, HttpServletResponse response, AuthenticationException authException) {
        return super.buildRedirectUrlToLoginPage(request, response, authException);
    }

    @Override
    protected String buildHttpsRedirectUrlForRequest(HttpServletRequest request) throws IOException, ServletException {
        return super.buildHttpsRedirectUrlForRequest(request);
    }

    @Override
    public void setForceHttps(boolean forceHttps) {
        super.setForceHttps(forceHttps);
    }

    @Override
    protected boolean isForceHttps() {
        return super.isForceHttps();
    }

    @Override
    public String getLoginFormUrl() {
        return super.getLoginFormUrl();
    }

    @Override
    public void setPortMapper(PortMapper portMapper) {
        super.setPortMapper(portMapper);
    }

    @Override
    protected PortMapper getPortMapper() {
        return super.getPortMapper();
    }

    @Override
    public void setPortResolver(PortResolver portResolver) {
        super.setPortResolver(portResolver);
    }

    @Override
    protected PortResolver getPortResolver() {
        return super.getPortResolver();
    }

    @Override
    public void setUseForward(boolean useForward) {
        super.setUseForward(useForward);
    }

    @Override
    protected boolean isUseForward() {
        return super.isUseForward();
    }

    //构建 当前被 （登录前）被拦截的URL
    protected String buildHttpReturnUrlForRequest(HttpServletRequest request)
            throws IOException, ServletException {
        RedirectUrlBuilder urlBuilder = new RedirectUrlBuilder();

        urlBuilder.setScheme("http");                       //协议
        urlBuilder.setServerName(request.getServerName());  //域名
        urlBuilder.setPort(request.getServerPort());        //端口
        urlBuilder.setContextPath(request.getContextPath());
        urlBuilder.setServletPath(request.getServletPath());
        urlBuilder.setPathInfo(request.getPathInfo());
        urlBuilder.setQuery(request.getQueryString());

        return urlBuilder.getUrl();
    }
}