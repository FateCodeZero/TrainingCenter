package com.trainingcenter.dao;

import com.trainingcenter.bean.LoginInfoRole;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/11/5
 * Time: 20:41
 */

/**
 * 只有增删改，用来维护 用户与角色的对应关系表
 */
@Repository("loginInfoRoleMapper")
public interface LoginInfoRoleMapper {

    /**
     * 添加，在给用户赋权限时调用
     * @param loginInfoRole
     * @return
     */
    public Integer add(@Param("loginInfoRole") LoginInfoRole loginInfoRole);

    /**
     * 删除，取消用户角色时调用
     * @param id
     * @return
     */
    public Integer delete(@Param("id") String id);

    /**
     * 更新，更新用户角色信息时调用
     * @param loginInfoRole
     * @return
     */
    public Integer update(@Param("loginInfoRole") LoginInfoRole loginInfoRole);

    /**
     * 通过 用户登录信息id 与 角色id 获取授权信息对象
     * @param loginInfoId：用户登录信息id
     * @param roleId：角色id
     * @return 授权信息对象
     */
    public LoginInfoRole getLoginInfoRoleByLoginInfoIdAndRoleId(@Param("loginInfoId") String loginInfoId, @Param("roleId") String roleId);
} 