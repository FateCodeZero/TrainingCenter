package com.trainingcenter.security.handler;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/11/8
 * Time: 17:17
 */

import com.trainingcenter.utils.AjaxJson;
import com.trainingcenter.utils.HTTPUtils;
import com.trainingcenter.utils.LogUtil;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.util.UrlUtils;
import org.springframework.util.Assert;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 自定义 Security 异常响应处理器
 * 目的：添加处理 Ajax 请求
 */
public class SimpleUrlAuthenticationFailureHandler implements AuthenticationFailureHandler {
    protected final Log logger = LogFactory.getLog(this.getClass());
    private String defaultFailureUrl;               //默认错误url
    private boolean forwardToDestination = false;   //使用forward
    private boolean allowSessionCreation = true;    //允许创建 session
    private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();  //重定向策略

    public SimpleUrlAuthenticationFailureHandler() {
    }

    public SimpleUrlAuthenticationFailureHandler(String defaultFailureUrl) {
        this.setDefaultFailureUrl(defaultFailureUrl);
    }

    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException, ServletException {

        //如果是 ajax 请求
        if (HTTPUtils.isAjaxRequest(request)) {
            if (this.defaultFailureUrl == null) {
                LogUtil.error(this, "SecurityAjax异常处理", "401错误，没有配置相应的failure URL", exception);
                this.logger.debug("No failure URL set, sending 401 Unauthorized error");
                response.sendError(403);
            } else {

                //是ajax请求时，不再将异常信息保存到 session 中，而是直接响应
                //将响应数据封装成 json 格式
                //ConcurrentHashMap：线程安全
                Map<String, Object> data = new ConcurrentHashMap<>();
                data.put("exception", exception);

                AjaxJson ajaxJson = new AjaxJson();
                ajaxJson.setCode(0);
                ajaxJson.setMsg(exception.getMessage());
                ajaxJson.setData(data);

                this.logger.debug("Forwarding to " + this.defaultFailureUrl);
                LogUtil.error(this, "SecurityAjax异常处理", "请求错误，异常响应至【" + this.defaultFailureUrl + "】页面", exception);

                //响应 ajax请求的信息
                PrintWriter printWriter = response.getWriter();
                printWriter.print(ajaxJson);

            }
        } else {
            if (this.defaultFailureUrl == null) {
                this.logger.debug("No failure URL set, sending 401 Unauthorized error");
                response.sendError(HttpStatus.UNAUTHORIZED.value(), HttpStatus.UNAUTHORIZED.getReasonPhrase());
            } else {
                this.saveException(request, exception);
                if (this.forwardToDestination) {
                    this.logger.debug("Forwarding to " + this.defaultFailureUrl);
                    request.getRequestDispatcher(this.defaultFailureUrl).forward(request, response);
                } else {
                    this.logger.debug("Redirecting to " + this.defaultFailureUrl);
                    this.redirectStrategy.sendRedirect(request, response, this.defaultFailureUrl);
                }
            }
        }
    }

    protected final void saveException(HttpServletRequest request, AuthenticationException exception) {
        if (this.forwardToDestination) {
            request.setAttribute("SPRING_SECURITY_LAST_EXCEPTION", exception);
        } else {
            HttpSession session = request.getSession(false);
            if (session != null || this.allowSessionCreation) {
                request.getSession().setAttribute("SPRING_SECURITY_LAST_EXCEPTION", exception);
            }
        }

    }

    public void setDefaultFailureUrl(String defaultFailureUrl) {
        Assert.isTrue(UrlUtils.isValidRedirectUrl(defaultFailureUrl), "'" + defaultFailureUrl + "' is not a valid redirect URL");
        this.defaultFailureUrl = defaultFailureUrl;
    }

    protected boolean isUseForward() {
        return this.forwardToDestination;
    }

    public void setUseForward(boolean forwardToDestination) {
        this.forwardToDestination = forwardToDestination;
    }

    public void setRedirectStrategy(RedirectStrategy redirectStrategy) {
        this.redirectStrategy = redirectStrategy;
    }

    protected RedirectStrategy getRedirectStrategy() {
        return this.redirectStrategy;
    }

    protected boolean isAllowSessionCreation() {
        return this.allowSessionCreation;
    }

    public void setAllowSessionCreation(boolean allowSessionCreation) {
        this.allowSessionCreation = allowSessionCreation;
    }
} 