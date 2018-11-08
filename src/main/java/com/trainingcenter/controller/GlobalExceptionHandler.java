package com.trainingcenter.controller;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/11/8
 * Time: 15:43
 */

import com.trainingcenter.exception.OperationException;
import com.trainingcenter.utils.AjaxJson;
import com.trainingcenter.utils.LogUtil;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * SpringMVC全局统一异常处理
 */
@ControllerAdvice
public class GlobalExceptionHandler {

    /**
     * 处理Controller层的所有业务异常
     * @param e
     * @return
     */
    @ExceptionHandler(OperationException.class)
    @ResponseBody
    AjaxJson handleBusinessException(OperationException e){
        LogUtil.error(this,"业务处理",e.getMessage(),e);

        AjaxJson ajaxJson = new AjaxJson();
        ajaxJson.setCode(0);
        ajaxJson.setMsg(e.getMessage());
        return ajaxJson;
    }

    /**
     * 处理所有接口数据验证异常
     * @param e
     * @return
     */
    @ExceptionHandler(MethodArgumentNotValidException.class)
    @ResponseBody
    AjaxJson handleMethodArgumentNotValidException(MethodArgumentNotValidException e){
        LogUtil.error(this,"数据效验",e.getMessage(),e);

        AjaxJson ajaxJson = new AjaxJson();
        ajaxJson.setCode(0);
        ajaxJson.setMsg(e.getMessage());
        return ajaxJson;
    }

    /**
     * 处理所有不可知的异常
     * @param e
     * @return
     */
    @ExceptionHandler(Exception.class)
    @ResponseBody
    AjaxJson handleException(Exception e){
        LogUtil.error(this,"未知异常",e.getMessage(),e);

        AjaxJson ajaxJson = new AjaxJson();
        ajaxJson.setCode(0);
        ajaxJson.setMsg("操作失败");
        return ajaxJson;
    }
}