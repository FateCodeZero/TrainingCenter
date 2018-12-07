package com.trainingcenter.controller;

import com.trainingcenter.bean.LockedIP;
import com.trainingcenter.bean.User;
import com.trainingcenter.service.LockedIPService;
import com.trainingcenter.service.UserService;
import com.trainingcenter.utils.*;
import org.apache.ibatis.annotations.Param;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/15
 * Time: 17:32
 */

@RequestMapping("/user")
@Controller
public class UserController {
    @Qualifier("userService")
    @Autowired
    private UserService userService;
    @Qualifier("lockedIPService")
    @Autowired
    private LockedIPService lockedIPService;

    /**
     * 进入登录页面
     *
     * @return loginPage
     */
    @RequestMapping(value = "/goLogin")
    public ModelAndView loginPage() {
        String viewName = "static/login";
        return new ModelAndView(viewName);
    }

    /**
     * 进入注册页面
     *
     * @return registerPage
     */
    @RequestMapping(value = "/goRegister")
    public ModelAndView registerPage() {
        String viewName = "static/register";
        return new ModelAndView(viewName);
    }

    /**
     * 进入更新页面
     *
     * @return updatePage
     */
    @PreAuthorize("hasPermission('/webpages/user/userInfo.jsp','READ')")
    @RequestMapping(value = "/goUpdate")
    public ModelAndView updatePage() {
        String viewName = "static/update";
        return new ModelAndView(viewName);
    }

    /**
     * 进入后台管理系统首页
     *
     * @return
     */
    @PreAuthorize(value = "hasPermission('/webpages/admin/index.jsp','READ')")
    @RequestMapping(value = "/admin")
    public ModelAndView adminIndex() {
        return new ModelAndView("admin/index");
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
     boolean login = userService.login(username, password, IP);
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
    @RequestMapping(value = "/usernameCheck")
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

        boolean exist = userService.checkUsername(username);
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
                             @RequestParam("rePassword") String rePassword) {
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
        boolean exist = userService.checkUsername(username);
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

        User user = new User();
        user.setId(UUID.randomUUID().toString());
        user.setUsername(username);
        user.setPassword(MD5Util.md5Encrypt(password));
        user.setUnlockedFlag(1);
        user.setState(1);
        user.setRegisterTime(new Date());
        user.setLastLoginTime(new Date());

        //异常抛给 SpringMVC 统一异常处理器处理
        Integer res = userService.register(user);

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
     * @param user：要更新的用户
     * @return
     */
    @PreAuthorize("hasPermission('/webpages/user/userInfo.jsp','UPDATE')")
    @ResponseBody
    @RequestMapping(value = "/update")
    public AjaxJson update(User user, HttpServletRequest request) {
        AjaxJson ajaxJson = new AjaxJson();

        //更新结果
        Integer res;
        //id与username不能都为空
        if (user == null || (StringUtil.isEmpty(user.getId()) && StringUtil.isEmpty(user.getUsername()))) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("更新失败，请先选择更新对象");
            return ajaxJson;
        }

        //从数据库读取旧的对象进行更新
        User oldUser;
        if (StringUtil.isNotEmpty(user.getId())){
            //按id查找
            oldUser = userService.getUserById(user.getId());
        }else {
            //按 username 查找
            oldUser = userService.getUserByUsername(user.getUsername());
        }
        if (oldUser == null) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("更新失败，对象不存在或已被删除");
            return ajaxJson;
        }

        //最后登录时间与登录IP在登录成功后修改
        String password = user.getPassword();
        if (StringUtil.isNotEmpty(password)) {
            oldUser.setPassword(MD5Util.md5Encrypt(password));
        }
        //维护IP锁定表
        Integer unlockedFlag = user.getUnlockedFlag();
        if (unlockedFlag != null) {
            String loginIP = user.getLoginIP();
            if (StringUtil.isEmpty(loginIP)) {
                user.setLoginIP(HTTPUtils.getClientIpAddress(request));
            }
            //封禁IP的对象
            LockedIP lockedIP = lockedIPService.getLockedIPByIP(user.getLoginIP());

            //解锁被封禁的IP
            if (unlockedFlag == 1) {
                //被封禁则删除该封禁对象进行解封
                if (lockedIP != null) {
                    res = lockedIPService.delete(lockedIP.getId());
                    if (res == 0) {
                        ajaxJson.setCode(0);
                        ajaxJson.setMsg("操作失败，请重试");
                        return ajaxJson;
                    }
                }
            } else {
                //若该IP已被封禁，则不进行操作了
                if (lockedIP == null) {
                    String currentUsername = SysResourcesUtils.getCurrentUsername();
                    User currentUser = userService.getUserByUsername(currentUsername);

                    LockedIP locked = new LockedIP();
                    locked.setId(UUID.randomUUID().toString());
                    locked.setIp(user.getLoginIP());
                    if (currentUser != null) {
                        locked.setCreateUserId(currentUser.getId());
                        locked.setCreateDate(new Date());
                        locked.setUpdateUserId(currentUser.getId());
                        locked.setUpdateDate(new Date());
                    }
                    res = lockedIPService.add(locked);
                    if (res == 0) {
                        ajaxJson.setCode(0);
                        ajaxJson.setMsg("操作失败，请重试");
                        return ajaxJson;
                    }
                }
            }
            //更新当前用户的IP锁定状态
            oldUser.setUnlockedFlag(unlockedFlag);
        }
        Integer state = user.getState();
        if (state != null) {
            oldUser.setState(state);
        }

        res = userService.update(oldUser);

        if (res > 0) {
            ajaxJson.setCode(1);
            ajaxJson.setMsg("更新成功");
        } else {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("更新失败，请重试");
        }
        return ajaxJson;
    }

    /**
     * 用户删除方法，支持批量删除
     *
     * @param ids：用户ids
     * @return 返回操作成功的数目与操作失败的对象及消息提示
     */
    @PreAuthorize("hasPermission('/webpages/admin/user_admin_list.jsp','DELETE')")
    @ResponseBody
    @RequestMapping(value = "/delete")
    public AjaxJson delete(@RequestParam("ids") String ids) {
        AjaxJson ajaxJson = new AjaxJson();

        if (StringUtil.isEmpty(ids)) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("删除失败，请先选择要删除的对象");
            return ajaxJson;
        }

        Integer delete = userService.batchDelete(ids);
        if (delete == 1) {
            ajaxJson.setCode(1);
            ajaxJson.setMsg("删除成功");
        } else {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("删除失败，请稍后重试");
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

    /**
     * 通过id获取用户
     *
     * @param id：用户id
     * @return 返回用户对象，只包含 id 与 username
     */
    @ResponseBody
    @RequestMapping(value = "/getUserById")
    public AjaxJson getUserById(@RequestParam("id") String id) {
        AjaxJson ajaxJson = new AjaxJson();
        if (StringUtil.isEmpty(id)) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("请先选择要查询的对象");
            return ajaxJson;
        }

        User user = userService.getUserById(id);
        if (user == null) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("对象不存在或已被删除");
            return ajaxJson;
        } else {
            ajaxJson.setCode(1);
            ajaxJson.setMsg("获取成功");
            Map<String, Object> data = new ConcurrentHashMap<>();

            //为保用户数据安全，只返回用户的id与username
            Map<String, Object> u = new ConcurrentHashMap<>();
            u.put("id", user.getId());
            u.put("username", user.getUsername());

            data.put("user", u);
            ajaxJson.setData(data);
            return ajaxJson;
        }
    }

    /**
     * 分页获取普通用户数据（获取全部，（已启用 + 已禁用 + 已删除（软删除）），供管理用）
     *
     * @param currentPage：当前页
     * @param rows：每页展示的数据条数
     * @param request：HttpServletRequest
     * @return
     */
    @PreAuthorize("hasPermission('/webpages/admin/user_list.jsp','READ')")
    @ResponseBody
    @RequestMapping("/list")
    public AjaxJson list(@RequestParam("currentPage") Integer currentPage, @RequestParam("rows") Integer rows, HttpServletRequest request) {
        AjaxJson ajaxJson = new AjaxJson();
        if (currentPage == null || rows == null) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("数据获取失败，页数不能为空");
            return ajaxJson;
        } else {

            //自定义查询条件，以 key-value 的形式进行条件查询，模糊查询的 key 固定为 searchContent
            Map<String, Object> condition = new ConcurrentHashMap<>();
            String conditionStr = request.getParameter("condition");
            if (StringUtil.isNotEmpty(conditionStr)) {
                condition = FindConditionUtils.findConditionBuild(User.class, conditionStr);
            }
            //获取当前查询条件下的所有数据条数，分页用
            Integer total = userService.getUsers(condition).size();
            //获取当前页的数据
            List<User> users = userService.getUsers(currentPage, rows, condition);
            ajaxJson.setCode(1);
            if (users.size() == 0) {
                ajaxJson.setMsg("暂无数据Ծ‸Ծ");
            } else {
                ajaxJson.setMsg("数据获取成功");
            }
            Map<String, Object> data = new ConcurrentHashMap<>();
            data.put("total", total);
            data.put("items", users);
            ajaxJson.setData(data);
            return ajaxJson;
        }
    }

    /**
     * 分页获取管理员用户数据（获取全部，（已启用 + 已禁用 + 已删除（软删除）），供管理用）
     *
     * @param currentPage：当前页
     * @param rows：每页展示的数据条数
     * @param request：HttpServletRequest
     * @return
     */
    @PreAuthorize("hasPermission('/webpages/admin/user_admin_list.jsp','READ')")
    @ResponseBody
    @RequestMapping("/list_admin")
    public AjaxJson list_admin(@RequestParam("currentPage") Integer currentPage, @RequestParam("rows") Integer rows, HttpServletRequest request) {
        AjaxJson ajaxJson = new AjaxJson();
        if (currentPage == null || rows == null) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("数据获取失败，页数不能为空");
            return ajaxJson;
        } else {

            //自定义查询条件，以 key-value 的形式进行条件查询，模糊查询的 key 固定为 searchContent
            Map<String, Object> condition = new ConcurrentHashMap<>();
            String conditionStr = request.getParameter("condition");
            if (StringUtil.isNotEmpty(conditionStr)) {
                condition = FindConditionUtils.findConditionBuild(User.class, conditionStr);
            }
            //获取当前查询条件下的所有数据条数，分页用
            Integer total = userService.getUsersForAdmin(condition).size();
            //获取当前页的数据
            List<User> users = userService.getUsersForAdmin(currentPage, rows, condition);
            ajaxJson.setCode(1);
            if (users.size() == 0) {
                ajaxJson.setMsg("暂无数据Ծ‸Ծ");
            } else {
                ajaxJson.setMsg("数据获取成功");
            }
            Map<String, Object> data = new ConcurrentHashMap<>();
            data.put("total", total);
            data.put("items", users);
            ajaxJson.setData(data);
            return ajaxJson;
        }
    }

    /**
     * 用户授权方法
     *
     * @param request：HttpServletRequest
     */
    @PreAuthorize("hasPermission('/webpages/admin/user_admin_list.jsp','UPDATE')")
    @ResponseBody
    @RequestMapping("/grant")
    public AjaxJson grant(HttpServletRequest request) {
        AjaxJson ajaxJson = new AjaxJson();
        String grantDataStr = request.getParameter("grantData");

        if (StringUtil.isEmpty(grantDataStr)) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("授权失败，授权数据不能为空");
            return ajaxJson;
        }

        ObjectMapper mapper = new ObjectMapper();
        Map<String, Object> grantData;
        try {
            grantData = mapper.readValue(grantDataStr, ConcurrentHashMap.class);
        } catch (IOException e) {
            e.printStackTrace();

            ajaxJson.setCode(0);
            ajaxJson.setMsg("授权保存失败，json转换异常");
            return ajaxJson;
        }

        if (grantData == null || grantData.size() == 0) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("授权保存失败，授权数据不能为空");
            return ajaxJson;
        }

        String userId = (String) grantData.get("userId");
        String roleIds = (String) grantData.get("roleIds");

        if (StringUtil.isEmpty(userId)) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("授权保存失败，授权对象不能为空");
            return ajaxJson;
        }
        //角色数据为空，表示回收当前用户的所有角色
        Integer res = userService.grantRoles(userId, roleIds);
        if (res > 0){
            ajaxJson.setCode(1);
            ajaxJson.setMsg("授权保存成功");
        }else {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("授权保存失败，请稍后重试");
        }
        return ajaxJson;
    }

    /**
     * 添加管理员
     * @param roleIds：添加管理员时授给该管理员用户的角色
     */
    @PreAuthorize("hasPermission('/webpages/admin/user_admin_list.jsp','CREATE')")
    @ResponseBody
    @RequestMapping(value = "/adminAdd")
    public AjaxJson adminAdd(@RequestParam("username") String username, @RequestParam("password") String password,
                             @RequestParam("rePassword") String rePassword, @Param("roleIds") String roleIds){
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

        boolean exist = userService.checkUsername(username);
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

        User user = new User();
        user.setId(UUID.randomUUID().toString());
        user.setUsername(username);
        user.setPassword(MD5Util.md5Encrypt(password));
        user.setUnlockedFlag(1); //IP锁定状态
        user.setState(1);       //使用状态
        user.setRegisterTime(new Date());
        user.setLastLoginTime(new Date());

        //异常抛给 SpringMVC 统一异常处理器处理
        Integer res = userService.add(user,roleIds);

        if (res > 0) {
            ajaxJson.setCode(1);
            ajaxJson.setMsg("添加成功");
        } else {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("添加成功，请重试");
        }
        return ajaxJson;
    }
}
