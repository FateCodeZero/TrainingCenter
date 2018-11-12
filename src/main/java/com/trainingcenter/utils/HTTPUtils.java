package com.trainingcenter.utils;

import net.sf.json.JSONObject;
import org.codehaus.jackson.map.ObjectMapper;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Serializable;
import java.util.Map;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/11/8
 * Time: 16:43
 */
public class HTTPUtils implements Serializable {
    private static final String[] HEADERS_TO_TRY = {
            "X-Forwarded-For",
            "Proxy-Client-IP",
            "WL-Proxy-Client-IP",
            "HTTP_X_FORWARDED_FOR",
            "HTTP_X_FORWARDED",
            "HTTP_X_CLUSTER_CLIENT_IP",
            "HTTP_CLIENT_IP",
            "HTTP_FORWARDED_FOR",
            "HTTP_FORWARDED",
            "HTTP_VIA",
            "REMOTE_ADDR",
            "X-Real-IP"
    };

    /***
     * 获取客户端ip地址(可以穿透代理)
     * @param request
     * @return
     */
    public static String getClientIpAddress(HttpServletRequest request) {
        for (String header : HEADERS_TO_TRY) {
            String ip = request.getHeader(header);
            if (ip != null && ip.length() != 0 && !"unknown".equalsIgnoreCase(ip)) {
                return ip;
            }
        }
        return request.getRemoteAddr();
    }

    /**
     *  判断是否为ajax请求
     */
    public static boolean isAjaxRequest(HttpServletRequest request) {
        if (request.getHeader("accept").indexOf("application/json") > -1
                || (request.getHeader("X-Requested-With") != null && request.getHeader("X-Requested-With").equals(
                "XMLHttpRequest"))) {
            return true;
        }
        return false;
    }

    /**
     * 通过net.sf.json
     * 使用 原生 HttpServletResponse 给前端响应 Ajax 请求，返回 Json格式的数据
     *
     * @param response        HttpServletResponse
     * @param responseDataMap 要返回给前端的数据
     */
    public static void responseByJson(HttpServletRequest request, HttpServletResponse response, Map<String, Object> responseDataMap) {
        JSONObject jsonObject = null;
        try {
            jsonObject = new JSONObject();
            jsonObject.putAll(responseDataMap);
        } catch (Exception e) {
            LogUtil.error(JSONObject.class, "原生response AjaxJson 数据响应", "json格式转换出错", e);
        }
        PrintWriter writer = null;
        try {
            writer = response.getWriter();
            writer.print(jsonObject);
            writer.close();     //关闭资源
        } catch (IOException e) {
            LogUtil.error(PrintWriter.class, "原生response AjaxJson 数据响应", "向前端响应数据时失败", e);
            e.printStackTrace();
        } finally {
            //就算出错了，也要将资源关闭掉
            if (writer != null) {
                writer.close();
            }
        }
    }

    /**
     * 通过 org.codehaus.jackson
     *   使用 原生 HttpServletResponse 给前端响应 Ajax 请求，返回 Json格式的数据
     *
     * @param request HttpServletRequest
     * @param response HttpServletResponse
     * @param responseDataMap 要返回给前端的数据
     */
    public static void responseByJacson(HttpServletRequest request, HttpServletResponse response, Map<String, Object> responseDataMap) {
        ObjectMapper mapper = null;
        String jsonData = null;
        try {
            mapper = new ObjectMapper();
            jsonData = mapper.writeValueAsString(responseDataMap); //转为 json 格式的字符串
        } catch (IOException e) {
            LogUtil.error(ObjectMapper.class, "原生response AjaxJson 数据响应", "jackson格式转换出错", e);
            e.printStackTrace();
        }

        PrintWriter writer = null;
        try {
            writer = response.getWriter();
            writer.print(jsonData);
            writer.close();     //关闭资源
        } catch (IOException e) {
            LogUtil.error(PrintWriter.class, "原生response AjaxJson 数据响应", "向前端响应数据时失败", e);
            e.printStackTrace();
        } finally {
            //就算出错了，也要将资源关闭掉
            if (writer != null) {
                writer.close();
            }
        }
    }
}