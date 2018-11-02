package com.trainingcenter.controller;

import com.trainingcenter.bean.User;
import com.trainingcenter.bean.LoginInfo;
import com.trainingcenter.exception.RegisterException;
import com.trainingcenter.service.LoginInfoService;
import com.trainingcenter.service.UserService;
import com.trainingcenter.utils.AjaxJson;
import com.trainingcenter.utils.StringUtil;
import com.trainingcenter.utils.SysUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
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
@SessionAttributes("user")
@RequestMapping("/loginInfo")
@Controller
public class LoginInfoController {
    @Qualifier("loginInfoService")
    @Autowired
    private LoginInfoService loginInfoService;

    @Qualifier("userService")
    @Autowired
    private UserService userService;

    /**
     * 进入注册页面
     *
     * @return loginPage
     */
    @RequestMapping(value = "/loginPage", method = RequestMethod.GET)
    public ModelAndView loginPage() {
        String viewName = "loginPage";
        return new ModelAndView(viewName);
    }

    /**
     * 进入注册页面
     *
     * @return registerPage
     */
    @RequestMapping(value = "registerPage", method = RequestMethod.GET)
    public ModelAndView registerPage() {
        String viewName = "registerPage";
        return new ModelAndView(viewName);
    }

    /**
     * 进入更新页面
     *
     * @return updatePage
     */
    @RequestMapping(value = "updatePage", method = RequestMethod.GET)
    public ModelAndView updatePage() {
        String viewName = "updatePage";
        return new ModelAndView(viewName);
    }

    /**
     * 登录方法
     *
     * @param username：用户名
     * @param password：密码
     * @param request：HttpServletRequest
     * @return
     */
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
    }

    /**
     * 退出登录
     * @param request：HttpServletRequest
     * @return
     */
    @RequestMapping("/logout")
    public ModelAndView logout(HttpServletRequest request,SessionStatus sessionStatus){
        String viewName = "redirect:/index.jsp";
        ModelAndView modelAndView = new ModelAndView(viewName);

        HttpSession session = request.getSession();
        session.removeAttribute("user");
        sessionStatus.setComplete();
        session.invalidate();
        return modelAndView;
    }

    /**
     * 验证用户名是否可用
     *
     * @param username:用户名
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/usernameCheck/{username}", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public AjaxJson checkUsername(@PathVariable("username") String username) {
        AjaxJson ajaxJson = new AjaxJson();
        if (StringUtil.isNotEmpty(username)) {
            boolean exist = loginInfoService.checkUsername(username);
            if (exist) {
                ajaxJson.setCode(0);
                ajaxJson.setMsg("用户名已被使用!");
            } else {
                ajaxJson.setCode(1);
                ajaxJson.setMsg("用户名可用！");
            }
        } else {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("用户名不能为空！");
        }
        return ajaxJson;
    }

    /**
     * 用户注册方法，需要传入 username 与 password 参数
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(method = RequestMethod.POST)
    public AjaxJson register(@RequestParam("username") String username, @RequestParam("password") String password,
                             @RequestParam("re_password") String re_password, HttpServletRequest request) {
        AjaxJson ajaxJson = new AjaxJson();
        if (StringUtil.isNotEmpty(username) && StringUtil.isNotEmpty(password)) {
            boolean exist = loginInfoService.checkUsername(username);
            if (exist) {
                ajaxJson.setCode(0);
                ajaxJson.setMsg("用户名已存在！");
            } else {
                if (!re_password.equals(password)){
                    ajaxJson.setCode(0);
                    ajaxJson.setMsg("两次密码输入不一致!");
                }else {
                    String ipAddress = SysUtil.getClientIpAddress(request);
                    Integer res = 0;
                    try {
                        res = loginInfoService.register(username, password, ipAddress);
                    } catch (RegisterException e) {
                        ajaxJson.setCode(0);
                        ajaxJson.setMsg(e.getMessage());
                        e.printStackTrace();
                    }
                    if (res > 0) {
                        ajaxJson.setCode(1);
                        ajaxJson.setMsg("注册成功！");
                    } else {
                        ajaxJson.setCode(0);
                        ajaxJson.setMsg("注册失败！");
                    }
                }
            }
        } else {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("用户名或密码不能为空！");
        }
        return ajaxJson;
    }

    /**
     * 用户更新方法
     *
     * @param id：用户id
     * @return
     */
    @RequestMapping(value = "/userCheck/{id}", method = RequestMethod.PUT)
    public AjaxJson update(@PathVariable("id") String id) {
        AjaxJson ajaxJson = new AjaxJson();
        if (StringUtil.isNotEmpty(id)) {
            LoginInfo userCheck = loginInfoService.getLoginInfoById(id);
            Integer res = loginInfoService.update(userCheck);
            if (res > 0) {
                ajaxJson.setCode(1);
                ajaxJson.setMsg("修改成功！");
            } else {
                ajaxJson.setCode(0);
                ajaxJson.setMsg("修改失败！");
            }
        } else {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("修改失败，该用户不存在或已被删除！");
        }
        return ajaxJson;
    }

    /**
     * 用户删除方法，支持批量删除
     *
     * @param ids：用户ids
     * @return 返回操作成功的数目与操作失败的对象及消息提示
     */
    @RequestMapping(value = "/userCheck/{ids}", method = RequestMethod.DELETE)
    public AjaxJson delete(@PathVariable("ids") String ids) {
        AjaxJson ajaxJson = new AjaxJson();
        if (StringUtil.isNotEmpty(ids)) {
            Map<String, Object> map = loginInfoService.batchDelete(ids);

            Integer success = (Integer) map.get("success");
            Map<String, Object> fail = (Map<String, Object>)map.get("fail");

            if (success == 0){
                ajaxJson.setCode(0);
                ajaxJson.setMsg("操作失败！");
            }else {
                if (fail.size() > 0){
                    ajaxJson.setCode(2);
                    ajaxJson.setMsg("操作成功，但有部分删除失败！");
                }else {
                    ajaxJson.setCode(1);
                    ajaxJson.setMsg("操作成功！");
                    ajaxJson.setData(map);
                }
            }
        } else {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("操作失败，请先选择要删除的对象！");
        }
        return ajaxJson;
    }
} 