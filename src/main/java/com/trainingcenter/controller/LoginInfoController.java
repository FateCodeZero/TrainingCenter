package com.trainingcenter.controller;

import com.trainingcenter.bean.LoginInfo;
import com.trainingcenter.exception.DeleteException;
import com.trainingcenter.exception.FindException;
import com.trainingcenter.exception.RegisterException;
import com.trainingcenter.exception.UpdateException;
import com.trainingcenter.service.LoginInfoService;
import com.trainingcenter.utils.AjaxJson;
import com.trainingcenter.utils.HTTPUtils;
import com.trainingcenter.utils.StringUtil;
import com.trainingcenter.utils.SysResourcesUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/15
 * Time: 17:32
 */

/**
 * 本次项目需使用Rest风格的URL
 * <p>
 * 新增：/order			POST
 * 获取：/order/id		GET
 * 修改：/order/id		PUT
 * 删除：/order/id		DELETE
 * <p>
 * 表单中如何发送 PUT 和 DELETE 请求?
 * 1、需要配置HiddenHttpMethodFilter
 * 2、需要发送POST请求
 * 3、需要在发送POST请求时，携带一个隐藏域，name="_method"，value=DELETE 或是 PUT 或是 POST、GET
 * <p>
 * 如何在 SpringMVC 的目标方法中得到 id?
 * 使用@PathVariable 注解获取
 */
@RequestMapping("/user")
@Controller
public class LoginInfoController {
    @Qualifier("loginInfoService")
    @Autowired
    private LoginInfoService loginInfoService;

    /**
     * 进入注册页面
     *
     * @return loginPage
     */
    @RequestMapping(value = "/goLogin", method = RequestMethod.GET)
    public ModelAndView loginPage() {
        String viewName = "static/login";
        return new ModelAndView(viewName);
    }

    /**
     * 进入注册页面
     *
     * @return registerPage
     */
    @RequestMapping(value = "/goRegister", method = RequestMethod.GET)
    public ModelAndView registerPage() {
        String viewName = "static/register";
        return new ModelAndView(viewName);
    }

    /**
     * 进入更新页面
     *
     * @return updatePage
     */
    @RequestMapping(value = "goUpdate", method = RequestMethod.GET)
    public ModelAndView updatePage() {
        String viewName = "static/update";
        return new ModelAndView(viewName);
    }

    /**
     * 登录方法，由 自定义Security登录验证 来完成
     *
     * @param username：用户名
     * @param password：密码
     * @param request：HttpServletRequest
     * @return

     @ResponseBody
     @RequestMapping(value = "/login", method = RequestMethod.POST)
     public AjaxJson login(@RequestParam("username") String username, @RequestParam("password") String password,
     @RequestParam("v_code") String v_code,HttpServletRequest request) {
     AjaxJson ajaxJson = new AjaxJson();

     String msg;             //消息提示
     Integer code;           //状态码
     Map<String, Object> map = new ConcurrentHashMap<>(); //返回携带的数据

     if (StringUtil.isEmpty(username) || StringUtil.isEmpty(password)) {
     code = 0;
     msg = "登录失败，用户名或密码不能为空！";
     } else {
     String IP = SysUtil.getClientIpAddress(request);
     boolean login = loginInfoService.login(username, password, IP);
     if (login) {
     //获取登录用户信息
     User user = userService.getUserByUsername(username);
     if (user != null){  //防止空指针异常
     map.put("user",user);
     request.getSession().setAttribute("user",user);
     }

     code = 1;
     msg = "登录成功！";
     } else {

     code = 0;
     msg = "登录失败，用户名或密码不正确！";
     }
     }

     ajaxJson.setMsg(msg);
     ajaxJson.setCode(code);
     ajaxJson.setData(map);

     return ajaxJson;
     }*/

    /**
     * 退出登录，由 自定义Security退出 来完成
     * @param request：HttpServletRequest
     * @return

     @RequestMapping("/logout") public ModelAndView logout(HttpServletRequest request,SessionStatus sessionStatus){
     String viewName = "redirect:/index.jsp";
     ModelAndView modelAndView = new ModelAndView(viewName);

     HttpSession session = request.getSession();
     session.removeAttribute("user");
     sessionStatus.setComplete();
     session.invalidate();
     return modelAndView;
     }*/

    /**
     * 验证用户名是否可用
     *
     * @param username:用户名
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/usernameCheck", method = RequestMethod.GET)
    public AjaxJson checkUsername(@RequestParam("username") String username) {
        AjaxJson ajaxJson = new AjaxJson();

        if (StringUtil.isEmpty(username)) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("账号不能为空！");
            return ajaxJson;
        }
        if (!StringUtil.checkEmail(username) && !StringUtil.checkMobileNumber(username)) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("账号格式不是一个正确的邮箱或手机号");
            return ajaxJson;
        }

        boolean exist = loginInfoService.checkUsername(username);
        if (exist) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("该账号已被使用");
        } else {
            ajaxJson.setCode(1);
            ajaxJson.setMsg("账号可用");
        }
        return ajaxJson;
    }

    /**
     * 用户注册方法，需要传入 username 与 password 参数
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public AjaxJson register(@RequestParam("username") String username, @RequestParam("password") String password,
                             @RequestParam("rePassword") String rePassword, HttpServletRequest request) {
        AjaxJson ajaxJson = new AjaxJson();

        //非空验证
        if (StringUtil.isEmpty(username) || StringUtil.isEmpty(password)) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("用户名或密码不能为空");
            return ajaxJson;
        }

        //账号可用性验证
        if (!StringUtil.checkEmail(username) && !StringUtil.checkMobileNumber(username)) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("账号格式不是一个正确的邮箱或手机号");
            return ajaxJson;
        }
        boolean exist = loginInfoService.checkUsername(username);
        if (exist) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("用户名已存在");
            return ajaxJson;
        }

        //重复密码一致性验证
        if (!rePassword.equals(password)) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("两次密码输入不一致!");
            return ajaxJson;
        }

        //添加注册信息
        String ipAddress = HTTPUtils.getClientIpAddress(request);
        Integer res = 0;

        //异常抛给 SpringMVC 统一异常处理器处理
        res = loginInfoService.register(username, password, ipAddress);

        if (res > 0) {
            ajaxJson.setCode(1);
            ajaxJson.setMsg("注册成功");
        } else {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("注册失败，请重试");
        }

        return ajaxJson;
    }

    /**
     * 用户更新方法
     *
     * @param id：用户id
     * @return
     */
    @RequestMapping(value = "/loginInfo/{id}", method = RequestMethod.PUT)
    public AjaxJson update(@PathVariable("id") String id) {
        AjaxJson ajaxJson = new AjaxJson();

        if (StringUtil.isEmpty(id)) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("更新失败，用户不存在或已注销");
            return ajaxJson;
        }

        //异常抛给 SpringMVC 统一异常处理器处理
        LoginInfo loginInfo = loginInfoService.getLoginInfoById(id);

        if (loginInfo == null) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("更新失败，用户不存在或已注销");
            return ajaxJson;
        }

        //异常抛给 SpringMVC 统一异常处理器处理
        Integer res = loginInfoService.update(loginInfo);

        if (res > 0) {
            ajaxJson.setCode(1);
            ajaxJson.setMsg("修改成功");
        } else {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("修改失败，请重试");
        }
        return ajaxJson;
    }

    /**
     * 用户删除方法，支持批量删除
     *
     * @param ids：用户ids
     * @return 返回操作成功的数目与操作失败的对象及消息提示
     */
    @RequestMapping(value = "/loginInfo/{ids}", method = RequestMethod.DELETE)
    public AjaxJson delete(@PathVariable("ids") String ids) {
        AjaxJson ajaxJson = new AjaxJson();
        if (StringUtil.isNotEmpty(ids)) {
            Map<String, Object> map = loginInfoService.batchDelete(ids);

            if (map == null){
                ajaxJson.setCode(0);
                ajaxJson.setMsg("操作失败");
                return ajaxJson;
            }

            Integer success = (Integer) map.get("success");
            Map<String, Object> fail = (Map<String, Object>) map.get("fail");

            if (success == 0) {
                ajaxJson.setCode(0);
                ajaxJson.setMsg("操作失败");
            } else {
                if (fail.size() > 0) {
                    ajaxJson.setCode(2);
                    ajaxJson.setMsg("操作成功，但有部分删除失败");
                } else {
                    ajaxJson.setCode(1);
                    ajaxJson.setMsg("操作成功");
                    ajaxJson.setData(map);
                }
            }
        } else {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("操作失败，请先选择要删除的对象");
        }
        return ajaxJson;
    }

    /**
     * 验证码错误
     *
     * @return
     */
    @RequestMapping(value = "/kaptchaError")
    public ModelAndView kaptchaError() {
        return new ModelAndView("static/login");
    }
}