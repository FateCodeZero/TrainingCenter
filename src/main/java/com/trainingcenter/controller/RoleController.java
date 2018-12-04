package com.trainingcenter.controller;

import com.trainingcenter.bean.Permission;
import com.trainingcenter.bean.Role;
import com.trainingcenter.bean.User;
import com.trainingcenter.controller.validation.TC_Add;
import com.trainingcenter.service.PermissionService;
import com.trainingcenter.service.RoleService;
import com.trainingcenter.service.UserService;
import com.trainingcenter.utils.AjaxJson;
import com.trainingcenter.utils.FindConditionUtils;
import com.trainingcenter.utils.StringUtil;
import com.trainingcenter.utils.SysResourcesUtils;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.*;
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
    @Qualifier("permissionService")
    @Autowired
    private PermissionService permissionService;
    @Qualifier("userService")
    @Autowired
    private UserService userService;

    /**
     * 分页获取角色数据（获取全部，（已启用 + 已禁用 + 已删除（软删除）），供管理用）
     *
     * @param currentPage：当前页
     * @param rows：每页展示的数据条数
     * @param request：传过来的其他参数
     */
    @ResponseBody
    @RequestMapping("/list")
    public AjaxJson getRoles_all(@RequestParam("currentPage") Integer currentPage, @RequestParam("rows") Integer rows, HttpServletRequest request) {
        AjaxJson ajaxJson = new AjaxJson();
        if (currentPage == null || rows == null) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("数据获取失败，页数不能为空");
            return ajaxJson;
        } else {

            //自定义查询条件，以 key-value 的形式进行条件查询，模糊查询的 key 固定为 searchContent
            Map<String, Object> condition = new ConcurrentHashMap<>();
            String conditionStr = request.getParameter("condition");
            if (StringUtil.isNotEmpty(conditionStr)){
                condition = FindConditionUtils.findConditionBuild(Role.class,conditionStr);
            }

            Integer total = roleService.getRoles(condition).size();
            List<Role> roles = roleService.getRoles(currentPage, rows, condition);

            ajaxJson.setCode(1);
            if (roles.size() == 0) {
                ajaxJson.setMsg("暂无数据Ծ‸Ծ");
            } else {
                ajaxJson.setMsg("数据获取成功");
            }

            Map<String, Object> data = new ConcurrentHashMap<>();
            data.put("total", total);
            data.put("items", roles);
            ajaxJson.setData(data);
            return ajaxJson;
        }
    }

    /**
     * 分页获取角色数据（获取只获取已启用的，供选择用）
     *
     * @param currentPage：当前页
     * @param rows：每页展示的数据条数
     * @param request：传过来的其他参数
     */
    @ResponseBody
    @RequestMapping("/select")
    public AjaxJson getRoles_select(@RequestParam("currentPage") Integer currentPage, @RequestParam("rows") Integer rows, HttpServletRequest request) {
        AjaxJson ajaxJson = new AjaxJson();
        if (currentPage == null || rows == null) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("数据获取失败，页数不能为空");
            return ajaxJson;
        } else {
            //自定义查询条件，以 key-value 的形式进行条件查询，模糊查询的 key 固定为 searchContent
            Map<String, Object> condition = new ConcurrentHashMap<>();
            String conditionStr = request.getParameter("condition");
            if (StringUtil.isNotEmpty(conditionStr)){
                condition = FindConditionUtils.findConditionBuild(Role.class,conditionStr);
            }
            condition.put("state", 1);   //只查询已启用的数据

            //获取当前查询条件下的所有数据条数，分页用
            Integer total = roleService.getRoles(condition).size();
            //获取当前页的数据
            List<Role> roles = roleService.getRoles(currentPage, rows, condition);

            ajaxJson.setCode(1);
            if (roles.size() == 0) {
                ajaxJson.setMsg("暂无数据Ծ‸Ծ");
            } else {
                ajaxJson.setMsg("数据获取成功");
            }

            Map<String, Object> data = new ConcurrentHashMap<>();
            data.put("total", total);
            data.put("items", roles);
            ajaxJson.setData(data);
            return ajaxJson;
        }
    }

    /**
     * 数据添加
     *
     * @param role 角色对象
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public AjaxJson add(@Validated(value = {TC_Add.class}) Role role) {
        String currentUsername = SysResourcesUtils.getCurrentUsername();    //当前登录用户的用户名
        User currentUser = userService.getUserByUsername(currentUsername);  //当前登录用户对象

        if (currentUser == null) {
            throw new CredentialsExpiredException("登录凭证已过期");
        }
        AjaxJson ajaxJson = new AjaxJson();

        if (role == null) {
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
        if (res == 0) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("添加失败，请重试");
            return ajaxJson;
        } else {
            ajaxJson.setCode(1);
            ajaxJson.setMsg("添加成功");
            return ajaxJson;
        }
    }

    /**
     * 数据更新
     *
     * @param role:要更新的角色对象
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/update")
    public AjaxJson update(@Validated(value = {TC_Add.class}) Role role) {
        String currentUsername = SysResourcesUtils.getCurrentUsername();    //当前登录用户的用户名
        User currentUser = userService.getUserByUsername(currentUsername);  //当前登录用户对象
        if (currentUsername == null || currentUser == null) {
            throw new CredentialsExpiredException("登录凭证已过期");
        }
        AjaxJson ajaxJson = new AjaxJson();
        if (role == null || StringUtil.isEmpty(role.getId())) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("更新失败，请先选择要更新的对象");
            return ajaxJson;
        }
        //从数据库读取旧的对象进行更新
        Role oldRole = roleService.getRoleById(role.getId());
        if (oldRole == null) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("更新失败，对象不存在或已被删除");
            return ajaxJson;
        }

        String name = role.getName();
        if (StringUtil.isNotEmpty(name)) {
            oldRole.setName(name);
        }
        Integer state = role.getState();
        if (state != null) {
            oldRole.setState(state);
        }
        String describe = role.getDescribe();
        if (StringUtil.isNotEmpty(describe)) {
            oldRole.setDescribe(describe);
        }
        String remarks = role.getRemarks();
        if (StringUtil.isNotEmpty(remarks)) {
            oldRole.setRemarks(remarks);
        }
        oldRole.setUpdateUserId(currentUser.getId());
        oldRole.setUpdateDate(new Date());

        Integer res = roleService.update(oldRole);
        if (res == 0) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("更新失败，请重试");
            return ajaxJson;
        } else {
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
    @RequestMapping(value = "/getRoleById")
    public AjaxJson getRoleById(@RequestParam("id") String id) {
        AjaxJson ajaxJson = new AjaxJson();
        if (StringUtil.isEmpty(id)) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("请先选择要查询的对象");
            return ajaxJson;
        }

        Role role = roleService.getRoleById(id);
        if (role == null) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("对象不存在或已被删除");
            return ajaxJson;
        } else {
            ajaxJson.setCode(1);
            ajaxJson.setMsg("获取成功");
            Map<String, Object> map = new ConcurrentHashMap<>();
            map.put("role", role);
            ajaxJson.setData(map);
            return ajaxJson;
        }
    }

    /**
     * 删除权限，支持批量删除
     *
     * @param ids
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/delete")
    public AjaxJson delete(@RequestParam("ids") String ids) {
        AjaxJson ajaxJson = new AjaxJson();
        if (StringUtil.isEmpty(ids)) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("请先选择要删除的对象");
            return ajaxJson;
        }
        Integer res = roleService.batchDelete(ids);
        if (res == 0) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("删除失败，请重试");
            return ajaxJson;
        } else {
            ajaxJson.setCode(1);
            ajaxJson.setMsg("删除成功");
            return ajaxJson;
        }
    }

    /**
     * 角色授权方法
     * @param request
     * @return
     */
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
            ajaxJson.setMsg("授权失败，授权数据不能为空");
            return ajaxJson;
        }

        String roleId = (String) grantData.get("roleId");   //授权角色id
        String resourceIds = (String) grantData.get("resourceIds"); //角色含有权限的所有菜单
        Map<String,Object> permissionData = (Map<String, Object>) grantData.get("permissionData"); //当前菜单的授权信息

        if (StringUtil.isEmpty(roleId)) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("授权失败，授权对象不能为空");
            return ajaxJson;
        }

        //授权结果
        Integer res = 0;

        //若授权信息为空，则是取消一个角色的所有权限
        if (StringUtil.isEmpty(resourceIds)) {
            res = roleService.grantPermission(roleId, null);
        } else {
            String currentResourceId = null; //当前授权页面的id
            String currentPermissionIds = null; //当前授权页面的权限ids
            if (permissionData !=null){
                currentResourceId = (String) permissionData.get("resourceId");
                currentPermissionIds = (String) permissionData.get("permissionIds");
            }

            //先添加当前角色在所接收页面中的所有权限信息
            if (StringUtil.isNotEmpty(resourceIds)) {
                String[] rids = resourceIds.trim().split(",");

                //读取所有被选中的页面,查询出当前角色在这些页面中含有的所有权限
                Set<Permission> newPermissions = Collections.synchronizedSet(new HashSet<>());
                for (String resourceId : rids) {
                    //存储当前页面的新权限信息
                    if (StringUtil.isNotEmpty(currentResourceId) && resourceId.equals(currentResourceId)){
                        if (StringUtil.isNotEmpty(currentPermissionIds)){
                            String[] permissionIdArr = currentPermissionIds.split(",");
                            for (String pid : permissionIdArr) {
                                Permission permission = permissionService.getPermissionById(pid);
                                newPermissions.add(permission);
                            }
                        }else {
                            //当前页面被选中，而当前页面的却没有授予任何权限时，默认授予 READ 权限
                            Map<String, Object> condition = new ConcurrentHashMap<>();
                            condition.put("state", 1);
                            condition.put("resourceId", resourceId);
                            condition.put("operations",Permission.READ);
                            List<Permission> permissions = permissionService.getPermissions(condition);
                            newPermissions.addAll(permissions);
                        }
                    }else {
                        //存储其他页面的权限信息
                        Map<String, Object> condition = new ConcurrentHashMap<>();
                        condition.put("state", 1);
                        condition.put("resourceId", resourceId);
                        List<Permission> permissionList = permissionService.getPermissions(condition);
                        //页面被选中了，但当前角色该页面中没有任何权限，默认授予 Read 权限
                        if (permissionList.size() == 0){
                            Map<String, Object> con = new ConcurrentHashMap<>();
                            con.put("state",1);
                            condition.put("resourceId", resourceId);
                            con.put("operations",Permission.READ);
                            List<Permission> ps = permissionService.getPermissions(con);
                            permissionList.addAll(ps);
                        }
                        newPermissions.addAll(permissionList);
                    }
                }

                //遍历新权限，组成新权限ids
                StringBuffer newPermissionIds = new StringBuffer();
                for (Permission permission:newPermissions) {
                    if (newPermissionIds.length() == 0){
                        newPermissionIds.append(permission.getId());
                    }else {
                        newPermissionIds.append(",");
                        newPermissionIds.append(permission.getId());
                    }
                }
                //新权限授权
                res = roleService.grantPermission(roleId,newPermissionIds.toString());
            }
        }

        if (res == 1) {
            ajaxJson.setCode(1);
            ajaxJson.setMsg("授权保存成功");
        } else {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("授权保存失败，请重试");
        }
        return ajaxJson;
    }

    /**
     * 获取指定用户所含有的所有角色
     * @param userId：指定用户id
     */
    @ResponseBody
    @RequestMapping(value = "/getRolesByUserId")
    public AjaxJson getRolesByUserId(@RequestParam("userId") String userId){
        AjaxJson ajaxJson = new AjaxJson();
        if (StringUtil.isEmpty(userId)){
            ajaxJson.setCode(0);
            ajaxJson.setMsg("请先选择查询对象");
            return ajaxJson;
        }
        List<Role> roles = roleService.getRolesByUserId(userId, null);
        ajaxJson.setCode(1);
        ajaxJson.setMsg("数据获取成功");
        Map<String,Object> data = new ConcurrentHashMap<>();
        data.put("items",roles);
        ajaxJson.setData(data);

        return ajaxJson;
    }
} 