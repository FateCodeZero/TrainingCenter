package com.trainingcenter.security.filter;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/11/3
 * Time: 17:06
 */

import com.google.code.kaptcha.Constants;
import com.trainingcenter.utils.HTTPUtils;
import org.springframework.security.authentication.InsufficientAuthenticationException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AbstractAuthenticationProcessingFilter;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 验证码效验过滤器
 * 使用google的kaptcha生成验证码
 */
public class KaptchaAuthenticationFilter extends AbstractAuthenticationProcessingFilter {
    private String servletPath; //请求路径
    /**
     * 构造函数
     * @param servletPath：请求路径
     * @param failureUrl：错误处理路径
     */
    public KaptchaAuthenticationFilter(String servletPath, String failureUrl) {
        super(servletPath);
        this.servletPath=servletPath;
        setAuthenticationFailureHandler(new SimpleUrlAuthenticationFailureHandler(failureUrl));
    }

    /**
     * 过滤机制
     * @param request
     * @param response
     * @param chain
     * @throws IOException
     * @throws ServletException
     */
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res=(HttpServletResponse)response;

        //只处理 POST 方法的登录url
        if ("POST".equalsIgnoreCase(req.getMethod()) && servletPath.equals(req.getServletPath())){

            //验证码，使用谷歌的验证码生成器生成
            String expect = (String) req.getSession().getAttribute(Constants.KAPTCHA_SESSION_KEY);

            //判断用户填写的验证码与生存的验证码是否一致
            if(expect!=null && !expect.equalsIgnoreCase(req.getParameter("kaptcha"))){

                //若是 Ajax 请求就直接向前端响应错误信息
                if (HTTPUtils.isAjaxRequest(req)){
                    Map<String,Object> map = new ConcurrentHashMap<>();
                    map.put("code",0);
                    map.put("msg","输入的验证码不正确");
                    HTTPUtils.responseByJacson(req,res,map);
                }else {
                    //否则抛出异常让 security 去处理
                    unsuccessfulAuthentication(req, res, new InsufficientAuthenticationException("输入的验证码不正确"));
                }
                return;
            }
        }
        chain.doFilter(request,response);
    }

    /**
     * attemptAuthentication 的回调不用理,重写了doFilter方法,它不会被调用
     * @param request
     * @param response
     * @return
     * @throws AuthenticationException
     * @throws IOException
     * @throws ServletException
     */
    @Override
    public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response) throws AuthenticationException, IOException, ServletException {
        return null;
    }
}