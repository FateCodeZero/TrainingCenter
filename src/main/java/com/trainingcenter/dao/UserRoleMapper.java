package com.trainingcenter.dao;

import com.trainingcenter.bean.UserRole;
import com.trainingcenter.controller.validation.TC_Add;
import com.trainingcenter.controller.validation.TC_Update;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.springframework.validation.annotation.Validated;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/11/5
 * Time: 20:41
 */

/**
 * 只有增删改，用来维护 用户与角色的对应关系表
 */
@Repository("userRoleMapper")
public interface UserRoleMapper {

    /**
     * 添加，在给用户赋权限时调用
     * @param userRole
     * @return
     */
    public Integer add(@Validated(value = {TC_Add.class}) @Param("userRole") UserRole userRole);

    /**
     * 删除，取消用户角色时调用
     * @param id
     * @return
     */
    public Integer delete(@Param("id") String id);

    /**
     * 更新，更新用户角色信息时调用
     * @param userRole
     * @return
     */
    public Integer update(@Validated(value = {TC_Update.class}) @Param("userRole") UserRole userRole);

    /**
     * 通过 用户id 与 角色id 获取授权信息对象
     * @param userId：用户id
     * @param roleId：角色id
     * @return 授权信息对象
     */
    public UserRole getUserRoleByUserIdAndRoleId(@Param("userId") String userId, @Param("roleId") String roleId);
    
    /**
     * 通过 用户id
     * @param userId：用户id
     * @return 授权信息对象
     */
    public List<UserRole> getUserRoleByUserId(@Param("userId") String userId);

    /**
     * 通过 角色id 获取授权信息对象
     * @param roleId：角色id
     * @return 授权信息对象
     */
    public List<UserRole> getUserRoleByRoleId(@Param("roleId") String roleId);

}