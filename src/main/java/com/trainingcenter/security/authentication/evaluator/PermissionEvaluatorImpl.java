package com.trainingcenter.security.authentication.evaluator;

import com.trainingcenter.bean.Resource;
import com.trainingcenter.bean.User;
import com.trainingcenter.bean.Permission;
import com.trainingcenter.bean.Role;
import com.trainingcenter.service.ResourceService;
import com.trainingcenter.utils.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.access.PermissionEvaluator;
import org.springframework.security.core.Authentication;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;

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
        // 1、获得loadUserByUsername()方法的结果
        User user = (User) authentication.getPrincipal();

        // 2、获得loadUserByUsername()中注入的角色
        Collection<Role> roles = (Collection<Role>) user.getAuthorities();

        //遍历所有角色
        for (Role role:roles) {

            //3、获取到角色中的注入的所有权限
            Collection<Permission> permissionList = role.getPermissions();

            //遍历所有权限，提取里面的url与操作
            for (Permission permission:permissionList) {
                //权限的操作集合
                List<String> operations = permission.getOperationList();
                String resourceId = permission.getResourceId();
                if (StringUtil.isEmpty(resourceId)){
                    return false;
                }

                //获取权限对应的资源
                Resource resource = resourceService.getResourceById(resourceId);
                if (resource == null){
                    return false;
                }

                // 4、认证url与操作权限，如果访问的Url和权限用户符合的话，返回true
                if (targetUrl.equals(resource.getUrl()) && operations.contains(targetPermission.toString())){
                    return true;
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