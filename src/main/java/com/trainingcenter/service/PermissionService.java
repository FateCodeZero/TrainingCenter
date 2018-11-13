package com.trainingcenter.service;

import com.trainingcenter.bean.Permission;
import com.trainingcenter.controller.validation.TC_Add;
import com.trainingcenter.controller.validation.TC_Update;
import org.springframework.validation.annotation.Validated;

import java.util.Collection;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/11/12
 * Time: 17:15
 */
public interface PermissionService {
    /**
     * 通过id获取权限
     * @param id：权限id
     * @return 返回对应的权限对象
     */
    public Permission getPermissionById(String id);

    /**
     * @param currentPage：当前页
     * @param rows：每页要显示的数据条数
     * @param searchContent：模糊查询内容
     * @return 返回权限对象集合
     */
    public List<Permission> getPermissions(Integer currentPage, Integer rows, String searchContent);
    /**
     * 权限添加方法
     * @param permission：要添加的权限
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer add(@Validated(value = {TC_Add.class}) Permission permission);

    /**
     * 权限更新方法
     * @param permission: 要更新的权限
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer update(@Validated(value = {TC_Update.class}) Permission permission);

    /**
     * 权限删除方法
     * @param id：权限id
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer delete(String id);

    /**
     * 通过id 获取指定 角色 所含有的全部权限
     *
     * @param roleId：角色id
     * @param currentPage：当前页
     * @param rows：每页要显示的数据条数
     * @param searchContent：模糊查询内容
     * @return 返回该角色所拥有的所有权限，支持分页、模糊查询
     */
    public Collection<Permission> getPermissionsByRoleId( String roleId, Integer currentPage, Integer rows, String searchContent);

    /**
     * 通过 角色名称 获取指定 角色 所含有的全部权限
     *
     * @param roleName：角色名称
     * @param currentPage：当前页
     * @param rows：每页要显示的数据条数
     * @param searchContent：模糊查询内容
     * @return 返回该角色所拥有的所有权限，支持分页、模糊查询
     */
    public Collection<Permission> getPermissionsByRoleName( String roleName, Integer currentPage, Integer rows, String searchContent);
}
