package com.trainingcenter.security.authentication.evaluator;

import com.trainingcenter.bean.Resource;
import com.trainingcenter.bean.User;
import com.trainingcenter.bean.Permission;
import com.trainingcenter.bean.Role;
import com.trainingcenter.service.PermissionService;
import com.trainingcenter.service.ResourceService;
import com.trainingcenter.utils.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.access.PermissionEvaluator;
import org.springframework.security.core.Authentication;

import java.io.Serializable;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/11/13
 * Time: 17:21
 */
public class PermissionEvaluatorImpl implements PermissionEvaluator {
    @Qualifier("resourceService")
    @Autowired
    private ResourceService resourceService;
    @Qualifier("permissionService")
    @Autowired
    private PermissionService permissionService;

    /**
     * 方法作用：验证用户是否有权执行某个资源（url）下的某个操作（即增删改查对应的方法）
     * 步骤：
     *      1、从 SecurityContext 中取出认证对象 Authentication
     *      2、从认证对象 Authentication 中取出其所有权限对象Authorities，我这里是Role
     *      3、从角色（Role）中取出其所有权限的 url与操作（c、r、u、d）
     *      4、认证该认证对象是否包含 访问的目标 url 与该 url 所需的权限
     * @param authentication：认证信息对象
     * @param targetUrl：访问的目标对象url
     * @param targetPermission：访问目标对象需要的权限
     * @return 返回是否有权访问
     */
    @Override
    public boolean hasPermission(Authentication authentication, Object targetUrl, Object targetPermission) {
        Object principal = authentication.getPrincipal();
        //不允许匿名用户进行操作
        if (principal.toString().equals("anonymousUser")){
            return false;
        }
        // 1、获得loadUserByUsername()方法的结果
        User user = (User) authentication.getPrincipal();

        // 2、获得loadUserByUsername()中注入的角色
        Collection<Role> roles = (Collection<Role>) user.getAuthorities();

        //3、遍历所有角色，获取每个角色所含有的所有权限
        for (Role role:roles) {

            //获取到角色中的注入的所有权限
            Collection<Permission> permissions = Collections.synchronizedCollection(role.getPermissions());

            //4、遍历所有权限，提取每个权限对应的资源url进匹配验证
            for (Permission permission:permissions) {
                //提取权限对应的资源
                String resourceId = permission.getResourceId();
                if (StringUtil.isNotEmpty(resourceId)){
                    //获取权限对应的资源
                    Resource resource = resourceService.getResourceById(resourceId);
                    if (resource != null){
                        //提取资源的URL
                        String url = resource.getUrl();
                        //5、进行URL匹配，若是该URL与方法需要的URL一致，则对当前用户进行可操作权限验证
                        if (targetUrl.equals(url)){
                            Map<String,Object> condition = new ConcurrentHashMap<>();
                            condition.put("state",1);
                            condition.put("resourceId",resource.getId());

                            //6、查询当前用户在当前页面的所有权限
                            List<Permission> permissionList = permissionService.getPermissionsByRoleId(role.getId(), condition);

                            //7、提取当前用户在当前页面的所有可操作权限
                            Set<String> opts = Collections.synchronizedSet(new HashSet<>());
                            for (Permission p: permissionList) {
                                opts.add(p.getOperations());
                            }
                            //若是当前用户在当前页面所含有的可操作权限包含有当前方法需要的可操作权限，则放行
                            if (opts.contains(targetPermission.toString())){
                                return true;
                            }
                        }
                    }
                }
            }
        }
        return false;
    }

    /**
     * 不实现该方法
     * @param authentication：认证对象
     * @param serializable：序列化
     * @param targetType：访问目标类型
     * @param permission：访问目标所需权限
     * @return
     */
    @Override
    public boolean hasPermission(Authentication authentication, Serializable serializable, String targetType, Object permission) {
        return false;
    }
}