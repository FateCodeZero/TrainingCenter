package com.trainingcenter.controller;

import com.trainingcenter.bean.Permission;
import com.trainingcenter.bean.User;
import com.trainingcenter.controller.validation.TC_Add;
import com.trainingcenter.service.PermissionService;
import com.trainingcenter.service.UserService;
import com.trainingcenter.utils.AjaxJson;
import com.trainingcenter.utils.FindConditionUtils;
import com.trainingcenter.utils.StringUtil;
import com.trainingcenter.utils.SysResourcesUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/11/26
 * Time: 16:37
 */
@RequestMapping("/permission")
@Controller
public class PermissionController {
    @Qualifier("permissionService")
    @Autowired
    private PermissionService permissionService;
    @Qualifier("userService")
    @Autowired
    private UserService userService;

    /**
     * 分页获取权限数据（获取全部，（已启用 + 已禁用 + 已删除（软删除）），供管理用）
     * @param currentPage：当前页
     * @param rows：每页展示的数据条数
     * @param request: HttpServletRequest
     */
    @PreAuthorize("hasPermission('/webpages/admin/permission_list.jsp','READ')")
    @ResponseBody
    @RequestMapping(value = "/list")
    public AjaxJson getPermissions_all(@RequestParam("currentPage") Integer currentPage, @RequestParam("rows") Integer rows, HttpServletRequest request){
        AjaxJson ajaxJson = new AjaxJson();
        if (currentPage == null || rows == null){
            ajaxJson.setCode(0);
            ajaxJson.setMsg("数据获取失败，页数不能为空");
            return ajaxJson;
        }else {
            //自定义查询条件，以 key-value 的形式进行条件查询，模糊查询的 key 固定为 searchContent
            Map<String, Object> condition = new ConcurrentHashMap<>();
            String conditionStr = request.getParameter("condition");
            if (StringUtil.isNotEmpty(conditionStr)){
                condition = FindConditionUtils.findConditionBuild(Permission.class,conditionStr);
            }

            //获取当前查询条件下的所有数据条数，分页用
            Integer total = permissionService.getPermissions(condition).size();
            //获取当前页的数据
            List<Permission> permissions = permissionService.getPermissions(currentPage,rows,condition);

            ajaxJson.setCode(1);
            if (permissions.size() == 0){
                ajaxJson.setMsg("暂无数据Ծ‸Ծ");
            }else {
                ajaxJson.setMsg("数据获取成功");
            }

            Map<String,Object> data = new ConcurrentHashMap<>();
            data.put("total",total);
            data.put("items",permissions);
            ajaxJson.setData(data);
            return ajaxJson;
        }
    }

    /**
     * 分页获取权限数据（获取只获取已启用的，供选择用）
     * @param currentPage：当前页
     * @param rows：每页展示的数据条数
     * @param request: HttpServletRequest
     */
    @ResponseBody
    @RequestMapping("/select")
    public AjaxJson getPermissions_select(@RequestParam("currentPage") Integer currentPage, @RequestParam("rows") Integer rows, HttpServletRequest request){
        AjaxJson ajaxJson = new AjaxJson();
        if (currentPage == null || rows == null){
            ajaxJson.setCode(0);
            ajaxJson.setMsg("数据获取失败，页数不能为空");
            return ajaxJson;
        }else {
            //自定义查询条件，以 key-value 的形式进行条件查询，模糊查询的 key 固定为 searchContent
            Map<String, Object> condition = new ConcurrentHashMap<>();
            String conditionStr = request.getParameter("condition");
            if (StringUtil.isNotEmpty(conditionStr)){
                condition = FindConditionUtils.findConditionBuild(Permission.class,conditionStr);
            }
            condition.put("state", 1);   //只查询已启用的数据

            //获取当前查询条件下的所有数据条数，分页用
            Integer total = permissionService.getPermissions(condition).size();
            //获取当前页的数据
            List<Permission> permissions = permissionService.getPermissions(currentPage,rows,condition);

            ajaxJson.setCode(1);
            if (permissions.size() == 0){
                ajaxJson.setMsg("暂无数据Ծ‸Ծ");
            }else {
                ajaxJson.setMsg("数据获取成功");
            }

            Map<String,Object> data = new ConcurrentHashMap<>();
            data.put("total",total);
            data.put("items",permissions);
            ajaxJson.setData(data);
            return ajaxJson;
        }
    }

    /**
     * 获取一个角色所拥有的所有权限
     * @param roleId：角色id
     * @return
     */
    @ResponseBody
    @RequestMapping("/getPermissionsByRoleId")
    public AjaxJson getPermissionsByRoleId(@RequestParam("roleId") String roleId){
        AjaxJson ajaxJson = new AjaxJson();
        if (StringUtil.isEmpty(roleId)){
            ajaxJson.setCode(0);
            ajaxJson.setMsg("数据获取失败，查询对象不能为空");
            return ajaxJson;
        }
        Map<String,Object> condition = new ConcurrentHashMap<>();
        condition.put("state",1);
        List<Permission> permissions = permissionService.getPermissionsByRoleId(roleId,condition);
        ajaxJson.setCode(1);
        ajaxJson.setMsg("数据获取成功");
        Map<String,Object> data = new ConcurrentHashMap<>();
        data.put("items",permissions);
        ajaxJson.setData(data);
        return ajaxJson;
    }

    /**
     * 数据添加
     * @param permission 添加的权限对象
     * @return
     */
    @PreAuthorize("hasPermission('/webpages/admin/permission_list.jsp','CREATE')")
    @ResponseBody
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public AjaxJson add(@Validated(value = {TC_Add.class}) Permission permission){
        String currentUsername = SysResourcesUtils.getCurrentUsername();    //当前登录用户的用户名
        User currentUser = userService.getUserByUsername(currentUsername);  //当前登录用户对象

        if (currentUser == null){
            throw new CredentialsExpiredException("登录凭证已过期");
        }
        AjaxJson ajaxJson = new AjaxJson();

        if (permission == null){
            ajaxJson.setCode(0);
            ajaxJson.setMsg("添加失败，添加对象不能为空");
            return ajaxJson;
        }

        permission.setId(UUID.randomUUID().toString());
        permission.setCreateUserId(currentUser.getId());
        permission.setCreateDate(new Date());
        permission.setUpdateUserId(currentUser.getId());
        permission.setUpdateDate(new Date());

        Integer res = permissionService.add(permission);//操作结果 flag
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
     * @param permission 要更新的权限对象
     * @return
     */
    @PreAuthorize("hasPermission('/webpages/admin/permission_list.jsp','UPDATE')")
    @ResponseBody
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public AjaxJson update(@Validated(value = {TC_Add.class}) Permission permission){
        String currentUsername = SysResourcesUtils.getCurrentUsername();    //当前登录用户的用户名
        User currentUser = userService.getUserByUsername(currentUsername);  //当前登录用户对象

        if (currentUser == null){
            throw new CredentialsExpiredException("登录凭证已过期");
        }

        AjaxJson ajaxJson = new AjaxJson();
        if (permission == null || StringUtil.isEmpty(permission.getId())){
            ajaxJson.setCode(0);
            ajaxJson.setMsg("更新失败，请先选择要更新的对象");
            return ajaxJson;
        }
        //从数据库读取旧的对象进行更新
        Permission oldPermission = permissionService.getPermissionById(permission.getId());
        if (oldPermission == null){
            ajaxJson.setCode(0);
            ajaxJson.setMsg("更新失败，对象不存在或已被删除");
            return ajaxJson;
        }

        String name = permission.getName();
        if (StringUtil.isNotEmpty(name)){
            oldPermission.setName(name);
        }
        String resourceId = permission.getResourceId();
        if (StringUtil.isNotEmpty(resourceId)){
            oldPermission.setResourceId(resourceId);
        }
        String operations = permission.getOperations();
        if (StringUtil.isNotEmpty(operations)){
            oldPermission.setOperations(operations);
        }
        Integer state = permission.getState();
        if (state != null){
            oldPermission.setState(state);
        }
        String describe = permission.getDescribe();
        if (StringUtil.isNotEmpty(describe)){
            oldPermission.setDescribe(describe);
        }
        String remarks = permission.getRemarks();
        if (StringUtil.isNotEmpty(remarks)){
            oldPermission.setRemarks(remarks);
        }
        oldPermission.setUpdateUserId(currentUser.getId());
        oldPermission.setUpdateDate(new Date());

        Integer res = permissionService.update(oldPermission);
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
    @RequestMapping(value = "/getPermissionById")
    public AjaxJson getPermissionById(@RequestParam("id") String id){
        AjaxJson ajaxJson = new AjaxJson();
        if (StringUtil.isEmpty(id)){
            ajaxJson.setCode(0);
            ajaxJson.setMsg("请先选择要查询的对象");
            return ajaxJson;
        }

        Permission permission = permissionService.getPermissionById(id);
        if (permission == null){
            ajaxJson.setCode(0);
            ajaxJson.setMsg("对象不存在或已被删除");
            return ajaxJson;
        }else {
            ajaxJson.setCode(1);
            ajaxJson.setMsg("获取成功");
            Map<String,Object> map = new ConcurrentHashMap<>();
            map.put("permission",permission);
            ajaxJson.setData(map);
            return ajaxJson;
        }
    }

    /**
     * 删除权限，支持批量删除
     * @param ids
     * @return
     */
    @PreAuthorize("hasPermission('/webpages/admin/permission_list.jsp','DELETE')")
    @ResponseBody
    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    public AjaxJson delete(@RequestParam("ids") String ids){
        AjaxJson ajaxJson = new AjaxJson();
        if (StringUtil.isEmpty(ids)){
            ajaxJson.setCode(0);
            ajaxJson.setMsg("请先选择要删除的对象");
            return ajaxJson;
        }
        Integer res = permissionService.batchDelete(ids);
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