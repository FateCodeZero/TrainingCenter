package com.trainingcenter.controller;

import com.trainingcenter.bean.Role;
import com.trainingcenter.bean.User;
import com.trainingcenter.controller.validation.TC_Add;
import com.trainingcenter.service.RoleService;
import com.trainingcenter.service.UserService;
import com.trainingcenter.utils.AjaxJson;
import com.trainingcenter.utils.StringUtil;
import com.trainingcenter.utils.SysResourcesUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/11/27
 * Time: 16:49
 */
@RequestMapping("/role")
@Controller
public class RoleController {
    @Qualifier("roleService")
    @Autowired
    private RoleService roleService;
    @Qualifier("userService")
    @Autowired
    private UserService userService;

    @ResponseBody
    @RequestMapping("/list")
    public AjaxJson getRoles(@RequestParam("currentPage") Integer currentPage, @RequestParam("rows") Integer rows, String searchContent){
        AjaxJson ajaxJson = new AjaxJson();
        if (currentPage == null || rows == null){
            ajaxJson.setCode(0);
            ajaxJson.setMsg("数据获取失败，页数不能为空");
            return ajaxJson;
        }else {
            Integer total = roleService.getRoles().size();
            List<Role> roles = roleService.getRoles(currentPage,rows,searchContent);

            ajaxJson.setCode(1);
            if (roles.size() == 0){
                ajaxJson.setMsg("暂无数据Ծ‸Ծ");
            }else {
                ajaxJson.setMsg("数据获取成功");
            }

            Map<String,Object> data = new ConcurrentHashMap<>();
            data.put("total",total);
            data.put("items",roles);
            ajaxJson.setData(data);
            return ajaxJson;
        }
    }

    /**
     * 数据添加
     * @param role
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public AjaxJson add(@Validated(value = {TC_Add.class}) Role role){
        String currentUsername = SysResourcesUtils.getCurrentUsername();    //当前登录用户的用户名
        User currentUser = userService.getUserByUsername(currentUsername);  //当前登录用户对象

        if (currentUser == null){
            throw new CredentialsExpiredException("登录凭证已过期");
        }
        AjaxJson ajaxJson = new AjaxJson();

        if (role == null){
            ajaxJson.setCode(0);
            ajaxJson.setMsg("添加失败，添加对象不能为空");
            return ajaxJson;
        }

        role.setId(UUID.randomUUID().toString());
        role.setCreateUserId(currentUser.getId());
        role.setCreateDate(new Date());
        role.setUpdateUserId(currentUser.getId());
        role.setUpdateDate(new Date());

        Integer res = roleService.add(role);//操作结果 flag
        if (res == 0){
            ajaxJson.setCode(0);
            ajaxJson.setMsg("添加失败，请重试");
            return ajaxJson;
        }else {
            ajaxJson.setCode(1);
            ajaxJson.setMsg("添加成功");
            return ajaxJson;
        }
    }

    /**
     * 数据更新
     * @param role:要更新的角色对象
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/update")
    public AjaxJson update(@Validated(value = {TC_Add.class}) Role role){
        String currentUsername = SysResourcesUtils.getCurrentUsername();    //当前登录用户的用户名
        User currentUser = userService.getUserByUsername(currentUsername);  //当前登录用户对象

        if (currentUser == null){
            throw new CredentialsExpiredException("登录凭证已过期");
        }

        AjaxJson ajaxJson = new AjaxJson();
        if (role == null || StringUtil.isEmpty(role.getId())){
            ajaxJson.setCode(0);
            ajaxJson.setMsg("更新失败，请先选择要更新的对象");
            return ajaxJson;
        }
        //从数据库读取旧的对象进行更新
        Role oldRole = roleService.getRoleById(role.getId());
        if (oldRole == null){
            ajaxJson.setCode(0);
            ajaxJson.setMsg("更新失败，对象不存在或已被删除");
            return ajaxJson;
        }

        String name = role.getName();
        if (StringUtil.isNotEmpty(name)){
            oldRole.setName(name);
        }
        Integer state = role.getState();
        if (state != null){
            oldRole.setState(state);
        }
        String describe = role.getDescribe();
        if (StringUtil.isNotEmpty(describe)){
            oldRole.setDescribe(describe);
        }
        String remarks = role.getRemarks();
        if (StringUtil.isNotEmpty(remarks)){
            oldRole.setRemarks(remarks);
        }
        oldRole.setUpdateUserId(currentUser.getId());
        oldRole.setUpdateDate(new Date());

        Integer res = roleService.update(oldRole);
        if (res == 0){
            ajaxJson.setCode(0);
            ajaxJson.setMsg("更新失败，请重试");
            return ajaxJson;
        }else {
            ajaxJson.setCode(1);
            ajaxJson.setMsg("更新成功");
            return ajaxJson;
        }
    }

    /**
     * 通过 id 获取权限对象
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/getRoleById",method = RequestMethod.GET)
    public AjaxJson getRoleById(@RequestParam("id") String id){
        AjaxJson ajaxJson = new AjaxJson();
        if (StringUtil.isEmpty(id)){
            ajaxJson.setCode(0);
            ajaxJson.setMsg("请先选择要查询的对象");
            return ajaxJson;
        }

        Role role = roleService.getRoleById(id);
        if (role == null){
            ajaxJson.setCode(0);
            ajaxJson.setMsg("对象不存在或已被删除");
            return ajaxJson;
        }else {
            ajaxJson.setCode(1);
            ajaxJson.setMsg("获取成功");
            Map<String,Object> map = new ConcurrentHashMap<>();
            map.put("role",role);
            ajaxJson.setData(map);
            return ajaxJson;
        }
    }

    /**
     * 删除权限，支持批量删除
     * @param ids
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/delete")
    public AjaxJson delete(@RequestParam("ids") String ids){
        AjaxJson ajaxJson = new AjaxJson();
        if (StringUtil.isEmpty(ids)){
            ajaxJson.setCode(0);
            ajaxJson.setMsg("请先选择要删除的对象");
            return ajaxJson;
        }
        Integer res = roleService.batchDelete(ids);
        if (res == 0){
            ajaxJson.setCode(0);
            ajaxJson.setMsg("删除失败，请重试");
            return ajaxJson;
        }else {
            ajaxJson.setCode(1);
            ajaxJson.setMsg("删除成功");
            return ajaxJson;
        }
    }
} 