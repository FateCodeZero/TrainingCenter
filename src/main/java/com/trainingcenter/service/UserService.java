package com.trainingcenter.service;

import com.trainingcenter.bean.User;
import com.trainingcenter.controller.validation.TC_Add;
import com.trainingcenter.controller.validation.TC_Update;
import com.trainingcenter.exception.DeleteException;
import com.trainingcenter.exception.FindException;
import org.springframework.validation.annotation.Validated;

import java.util.List;
import java.util.Map;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/15
 * Time: 17:27
 *
 * 用户登录信息服务类，用以检验用户登录的各种信息
 */
public interface UserService {

    /**
     * 检查用户名是否可用
     * @param username：用户名
     * @return 用户名是否已被使用 true：账号已存在，false：账号不存在，可用
     */
    public boolean checkUsername(String username);

    /**
     * 通过id获取登录信息
     * @param id：对象id
     * @return
     */
    public User getUserById(String id);

    /**
     * 通过username获取登录信息
     * @param username：账号
     * @return
     */
    public User getUserByUsername(String username);

    /**
     * 查询所有普通用户
     * @param condition：自定义查询条件，模糊查询的 key 固定为 searchContent
     * @return 返回所有数据
     */
    public List<User> getUsers(Map<String,Object> condition);

    /**
     * 分页查询普通用户
     * @param currentPage：当前页
     * @param rows：每页要显示的数据条数
     * @param condition：自定义查询条件，模糊查询的 key 固定为 searchContent
     * @return 返回当前页的数据集合
     */
    public List<User> getUsers(Integer currentPage, Integer rows, Map<String,Object> condition);

    /**
     * 获取所有管理员数据
     * @param condition：自定义查询条件，模糊查询的 key 固定为 searchContent
     * @return 返回所有数据
     */
    public List<User> getUsersForAdmin(Map<String,Object> condition);

    /**
     * 分页查询管理员用户
     * @param currentPage：当前页
     * @param rows：每页要显示的数据条数
     * @param condition：自定义查询条件，模糊查询的 key 固定为 searchContent
     * @return 返回当前页的数据集合
     */
    public List<User> getUsersForAdmin(Integer currentPage, Integer rows, Map<String,Object> condition);

    /**
     * 获取含有指定 角色 的所有用户
     * @param roleId
     * @return
     */
    public List<User> getUsersByRoleId( String roleId);

    /**
     * 分页获取含有指定 角色 的所有用户
     * @param roleId 指定角色id
     * @param currentPage：当前页
     * @param rows：每页要显示的数据条数
     * @param searchContent：模糊查询内容
     * @return 返回含有该角色的所有用户，支持分页与模糊查询
     */
    public List<User> getUsersByRoleId( String roleId,Integer currentPage,Integer rows,String searchContent);

    /**
     * 注册/添加
     * @param user：用户对象
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer register(@Validated(value = {TC_Add.class}) User user);

    /**
     * 添加管理员用户
     * @param user:添加的管理员对象
     * @param roleIds：添加管理员时授给该管理员用户的角色
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer add(@Validated(value = {TC_Add.class}) User user,String roleIds);

    /**
     * 修改
     * @param user：被修改的对象
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer update(@Validated(value = {TC_Update.class}) User user);

    /**
     * 注销/删除
     * @param id：需要删除对象的id
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer delete(String id) throws DeleteException, FindException;

    /**
     * 批量删除
     *
     * @param ids：需要删除的对象的id集
     * @return 返回操作结果（true：删除成功，false：删除失败）
     * 添加事务，保证中间删除失败时可以回滚
     */
    public Integer batchDelete(String ids);

    /**
     * 给用户授角色，添加事务保证授权统一成功或失败
     * @param userId ：用户登录信息id
     * @param roleIds ：授予的角色id集
     * 返回授权成功的个数，0表示授权失败
     */
    public Integer grantRoles(String userId, String roleIds);

}
