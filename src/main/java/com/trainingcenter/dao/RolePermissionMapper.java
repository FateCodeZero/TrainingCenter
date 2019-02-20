package com.trainingcenter.dao;

import com.trainingcenter.bean.RolePermission;
import com.trainingcenter.controller.validation.TC_Add;
import com.trainingcenter.controller.validation.TC_Update;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.springframework.validation.annotation.Validated;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/11/12
 * Time: 19:14
 */
@Repository("rolePermissionMapper")
public interface RolePermissionMapper {
    /**
     * 添加，在给角色授权时调用
     * @param rolePermission
     * @return
     */
    public Integer add(@Validated(value = {TC_Add.class}) @Param("rolePermission") RolePermission rolePermission);

    /**
     * 更新，更新角色权限信息时调用
     * @param rolePermission
     * @return
     */
    public Integer update(@Validated(value = {TC_Update.class})@Param("rolePermission") RolePermission rolePermission);

    /**
     * 删除，取消角色权限时调用
     * @param id
     * @return
     */
    public Integer delete(@Param("id") String id);

    /**
     * 通过 角色id 与 权限id 获取 角色-权限信息对象
     * @param roleId：角色ID
     * @param permissionId：权限ID
     * @return
     */
    public RolePermission getRolePermissionByRoleIdAndPermissionId(@Param("roleId") String roleId, @Param("permissionId") String permissionId);

    /**
     * 通过 角色id 获取 角色-权限信息对象
     * @param roleId ：角色ID
     * @return
     */
    public List<RolePermission> getRolePermissionByRoleId(@Param("roleId") String roleId);

    /**
     * 通过 权限id 获取 角色-权限信息对象
     * @param permissionId ：权限ID
     * @return
     */
    public List<RolePermission> getRolePermissionByPermissionId(@Param("permissionId") String permissionId);
} 