package com.trainingcenter.dao;

import com.trainingcenter.bean.User;
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
 * Date: 2018/10/15
 * Time: 17:22
 */
@Repository("userMapper")
public interface UserMapper {

    /**
     * 通过id获取登录信息
     * @param id : 对象id
     * @return 返回 User 对象
     */
    public User getUserById(@Param("id") String id);

    /**
     * 通过username获取登录信息
     * @param username : 对象username
     * @return 返回 User 对象
     */
    public User getUserByUsername(@Param("username") String username);

    /**
     * 分页获取数据
     * @param start：从第几条数据开始查
     * @param number：查询多少条数据
     * @param condition：自定义查询条件，模糊查询的 key 固定为 searchContent
     * @return 返回当前页的数据集合
     */
    public List<User> getUsers(@Param("start") Integer start, @Param("number") Integer number, @Param("condition") Map<String,Object> condition);

    /**
     * 分页获取数据
     * @param start：从第几条数据开始查
     * @param number：查询多少条数据
     * @param condition：自定义查询条件，模糊查询的 key 固定为 searchContent
     * @return 返回当前页的数据集合
     */
    public List<User> getUsersForAdmin(@Param("start") Integer start, @Param("number") Integer number, @Param("condition") Map<String,Object> condition);

    /**
     * 注册/添加
     * @param user :注册对象
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer add(@Validated(value = {TC_Add.class}) @Param("user") User user);

    /**
     * 修改密码
     * @param user
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer update(@Validated(value = {TC_Update.class}) @Param("user") User user);

    /**
     * 注销/删除
     * @param id : 删除对象的id
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer delete(@Param("id") String id);

    /**
     * 获取含有指定 角色 的所有用户
     * @param roleId 指定角色id
     * @param start：从第几条数据开始
     * @param number：要获取多少条数据
     * @param searchContent：模糊查询内容
     * @return 返回含有该角色的所有用户，支持分页与模糊查询
     */
    public List<User> getUsersByRoleId(@Param("roleId") String roleId, @Param("start") Integer start,
                                                  @Param("number") Integer number, @Param("searchContent") String searchContent);

}
