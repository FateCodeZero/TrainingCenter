package com.trainingcenter.dao;

import com.trainingcenter.bean.Permission;
import com.trainingcenter.controller.validation.TC_Add;
import com.trainingcenter.controller.validation.TC_Update;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.springframework.validation.annotation.Validated;

import java.util.List;
import java.util.Map;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/11/12
 * Time: 16:34
 */
@Repository("permissionMapper")
public interface PermissionMapper {

    /**
     * 通过id获取权限
     * @param id：权限id
     * @return 返回对应的权限对象
     */
    public Permission getPermissionById(@Param("id") String id);

    /**
     * 分页获取所有权限
     * @param start：从第几条数据开始
     * @param number：要获取多少条数据
     * @param condition：自定义查询条件，模糊查询的 key 固定为 searchContent
     * @return 返回权限对象集合
     */
    public List<Permission> getPermissions(@Param("start") Integer start, @Param("number") Integer number,
                               @Param("condition") Map<String,Object> condition);
    /**
     * 权限添加方法
     * @param permission：要添加的权限
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer add(@Validated(value = {TC_Add.class}) @Param("permission") Permission permission);

    /**
     * 权限更新方法
     * @param permission: 要更新的权限
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer update(@Validated(value = {TC_Update.class}) @Param("permission") Permission permission);

    /**
     * 权限删除方法
     * @param id：权限id
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer delete(@Param("id") String id);

    /**
     * 通过id 获取指定 角色 所含有的全部权限
     *
     * @param roleId：角色id
     * @param start：从第几条数据开始
     * @param number：要获取多少条数据
     * @param condition：自定义查询条件，模糊查询的 key 固定为 searchContent
     * @return 返回该角色所拥有的所有权限，支持分页、模糊查询
     */
    public List<Permission> getPermissionsByRoleId(@Param("roleId") String roleId,@Param("start") Integer start,
                                                 @Param("number") Integer number, @Param("condition") Map<String,Object> condition);
}