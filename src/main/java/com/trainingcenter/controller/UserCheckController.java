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
@SessionAttributes("user")
@Controller
public class UserCheckController {
    @Qualifier("userCheckService")
    @Autowired
    private UserCheckService userCheckService;

    @Qualifier("userService")
    @Autowired
    private UserService userService;
    /**
     * 用户登录方法
     * @return
     */
    @RequestMapping(value = "/userCheck/login",method = RequestMethod.GET)
    public ModelAndView login(@RequestParam("username") String username, @RequestParam("password") String password){
        ModelAndView modelAndView = new ModelAndView();
        String viewName = "login";
        if (StringUtil.isNotEmpty(username) && StringUtil.isNotEmpty(password)){
            boolean login = userCheckService.login(username, password);
            if (login){
                //获取登录用户信息
                User user = userService.getUserByUsername(username);
                modelAndView.addObject("user",user);
                viewName = "index";
            }else {
                viewName = "login";
            }
        }
        modelAndView.setViewName(viewName);
        return modelAndView;
    }

    /**
     * 进入注册页面
     * @return
     */
    @RequestMapping("/userCheck/registerPage")
    public ModelAndView registerPage(){
        String viewName = "register";
        ModelAndView modelAndView = new ModelAndView(viewName);
        return modelAndView;
    }

    /**
     * 验证用户名是否可用
     * @param username
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/userCheck/{username}", method = RequestMethod.GET, produces="application/json;charset=UTF-8")
    public AjaxJson checkUsername(@PathVariable("username") String username){
        AjaxJson ajaxJson = new AjaxJson();
        if (StringUtil.isNotEmpty(username)){
            boolean exist = userCheckService.isExist(username);
            if (exist){
                ajaxJson.setCode(0);
                ajaxJson.setMsg("用户名已被使用!");
            }else {
                ajaxJson.setCode(1);
                ajaxJson.setMsg("用户名可用！");
            }
        }else {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("用户名不能为空！");
        }
        return ajaxJson;
    }

    /**
     * 用户注册方法，需要传入 username 与 password 参数
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/userCheck",method = RequestMethod.POST)
    public AjaxJson register(@RequestParam("username") String username, @RequestParam("password") String password){
        AjaxJson ajaxJson = new AjaxJson();
        if (StringUtil.isNotEmpty(username) && StringUtil.isNotEmpty(password)){
            boolean exist = userCheckService.isExist(username);
            if (exist){
                ajaxJson.setCode(0);
                ajaxJson.setMsg("用户名已存在！");
            }else {
                Integer res = userCheckService.add(username, password);
                if (res > 0){
                    ajaxJson.setCode(1);
                    ajaxJson.setMsg("注册成功！");
                }else {
                    ajaxJson.setCode(0);
                    ajaxJson.setMsg("注册失败！");
                }
            }
        }else {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("用户名或密码不能为空！");
        }
        return ajaxJson;
    }

    /**
     * 用户更新方法
     * @param id：用户id
     * @return
     */
    @RequestMapping(value = "/userCheck/{id}",method = RequestMethod.PUT)
    public AjaxJson update(@PathVariable("id") String id){
        AjaxJson ajaxJson = new AjaxJson();
        if (StringUtil.isNotEmpty(id)){
            UserCheck userCheck = userCheckService.getUserCheckById(id);
            Integer res = userCheckService.update(userCheck);
            if (res > 0){
                ajaxJson.setCode(1);
                ajaxJson.setMsg("修改成功！");
            }else {
                ajaxJson.setCode(0);
                ajaxJson.setMsg("修改失败！");
            }
        }else {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("修改失败，该用户不存在或已被删除！");
        }
        return ajaxJson;
    }

    /**
     * 用户删除方法，支持批量删除
     * @param ids：用户ids
     * @return
     */
    @RequestMapping(value = "/userCheck/{ids}",method = RequestMethod.DELETE)
    public AjaxJson delete(@PathVariable("ids") String ids){
        AjaxJson ajaxJson = new AjaxJson();
        if (StringUtil.isNotEmpty(ids)){
            String[] arr = ids.split(",");
            if (arr.length > 0){
                ConcurrentHashMap<String, Object> map = userCheckService.batchDelete(Arrays.asList(arr));
                ajaxJson.setCode(1);
                ajaxJson.setMsg("操作成功！");
                ajaxJson.setData(map);
            }else {
                ajaxJson.setCode(0);
                ajaxJson.setMsg("操作失败！");
            }
        }else {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("操作失败！");
        }
        return ajaxJson;
    }
} 