package com.trainingcenter.controller;

import com.trainingcenter.bean.User;
import com.trainingcenter.bean.UserCheck;
import com.trainingcenter.service.UserCheckService;
import com.trainingcenter.service.UserService;
import com.trainingcenter.utils.AjaxJson;
import com.trainingcenter.utils.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.Arrays;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/15
 * Time: 17:32
 */

/**
 * 本次项目需使用Rest风格的URL
 *
 * 新增：/order			POST
 * 获取：/order/id		GET
 * 修改：/order/id		PUT
 * 删除：/order/id		DELETE
 *
 * 表单中如何发送 PUT 和 DELETE 请求?
 * 		1、需要配置HiddenHttpMethodFilter
 * 		2、需要发送POST请求
 * 		3、需要在发送POST请求时，携带一个隐藏域，name="_method"，value=DELETE 或是 PUT 或是 POST、GET
 *
 * 如何在 SpringMVC 的目标方法中得到 id?
 * 		使用@PathVariable 注解获取
 */
@Controller
public class UserController {

    @Qualifier("userService")
    @Autowired
    private UserService userService;
}