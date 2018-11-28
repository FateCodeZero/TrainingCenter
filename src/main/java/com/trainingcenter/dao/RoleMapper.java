package com.trainingcenter.dao;

import com.trainingcenter.bean.Role;
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
 * Date: 2018/10/31
 * Time: 14:29
 */
@Repository("roleMapper")
public interface RoleMapper {

    /**
     * 通过id获取角色
     * @param id：角色id
     * @return 返回对应的角色对象
     */
    public Role getRoleById(@Param("id") String id);

    /**
     * 通过 角色名称 获取角色
     * @param name：角色名称
     * @return 返回对应的角色对象
     */
    public Role getRoleByName(@Param("name") String name);

    /**
     * 分页获取所有角色
     * @param start：从第几条数据开始
     * @param number：要获取多少条数据
     * @param condition：自定义查询条件，模糊查询的 key 固定为 searchContent
     * @return 返回角色对象集合
     */
    public List<Role> getRoles(@Param("start") Integer start, @Param("number") Integer number,
                               @Param("condition") Map<String,Object> condition);
    /**
     * 角色添加方法
     * @param role：要添加的角色
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer add(@Validated(value = {TC_Add.class}) @Param("role") Role role);

    /**
     * 角色更新方法
     * @param role: 要更新的角色
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer update(@Validated(value = {TC_Update.class}) @Param("role") Role role);

    /**
     * 角色删除方法
     * @param id：角色id
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer delete(@Param("id") String id);

    /**
     * 获取指定登录用户所含有的全部角色
     *
     * @param userId：用户登录信息id
     * @param start：从第几条数据开始
     * @param number：要获取多少条数据
     * @param searchContent：模糊查询内容
     * @return 返回该用户所拥有的所有角色，支持分页、模糊查询
     */
    public List<Role> getRolesByUserId(@Param("userId") String userId,@Param("start") Integer start,
                                                 @Param("number") Integer number, @Param("searchContent") String searchContent);

    /**
     * 获取含有指定权限的所有角色
     *
     * @param permissionId ：指定权限id
     * @param start：从第几条数据开始
     * @param number：要获取多少条数据
     * @param searchContent：模糊查询内容
     * @return ：返回含有该权限的所有角色，支持分页
     */
    public List<Role> getRolesByPermissionId(@Param("permissionId") String permissionId, @Param("start") Integer start,
                                                         @Param("number") Integer number, @Param("searchContent") String searchContent);

} 