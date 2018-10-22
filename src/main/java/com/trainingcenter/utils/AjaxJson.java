package com.trainingcenter.utils;

import java.util.concurrent.ConcurrentHashMap;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/21
 * Time: 21:25
 */
public class AjaxJson {
    private String msg;     //返回的提示信息
    private Integer code;   //返回的操作代码
    private ConcurrentHashMap<String,Object> data;    //返回的数据

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public ConcurrentHashMap<String, Object> getData() {
        return data;
    }

    public void setData(ConcurrentHashMap<String, Object> data) {
        this.data = data;
    }
}