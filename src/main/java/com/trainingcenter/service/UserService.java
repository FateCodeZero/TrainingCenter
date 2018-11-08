package com.trainingcenter.service;

import com.trainingcenter.bean.User;
import com.trainingcenter.bean.UserType;
import com.trainingcenter.controller.validation.TC_Add;
import com.trainingcenter.controller.validation.TC_Update;
import com.trainingcenter.exception.DeleteException;
import org.springframework.validation.annotation.Validated;

import javax.validation.Valid;
import java.util.List;
import java.util.Map;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/15
 * Time: 17:26
 */
public interface UserService {

    /**
     * 通过id获取用户
     *
     * @param id
     * @return
     */
    public User getUserById(String id);

    /**
     * 通过username获取用户
     *
     * @param username
     * @return
     */
    public User getUserByUsername(String username);

    /**
     * 分页获取所有用户
     *
     * @param currentPage：当前页
     * @param rows：每页要显示的数据条数
     * @param searchContent：模糊查询内容
     * @return 返回当前页的数据集合
     */
    public List<User> getUsers(Integer currentPage, Integer rows, String searchContent);

    /**
     * 用户添加方法
     *
     * @param user
     * @return 返回值大于0表示操作成功，否则操作失败
     */
    public Integer add(@Validated(value = {TC_Add.class}) User user);

    /**
     * 用户更新方法
     *
     * @param user
     * @return
     */
    public Integer update(@Validated(value = {TC_Update.class}) User user);

    /**
     * 用户删除方法
     *
     * @param id：用户id
     * @return
     */
    public Integer delete(String id) throws DeleteException;

    /**
     * 批量删除
     *
     * @param ids：需要删除的对象的id集
     * @return 返回操作成功的数目与操作失败的对象
     */
    public Map<String, Object> batchDelete(String ids);

    /**
     * 获取当前用户的用户类型
     * @param userId：用户id
     * @return 返回用户类型对象
     */
    public UserType getUserTypeByUserId(String userId);
}
