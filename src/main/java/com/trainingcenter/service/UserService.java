package com.trainingcenter.service;

import com.trainingcenter.bean.User;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/15
 * Time: 17:26
 */
public interface UserService {

    /**
     * 用户添加方法
     * @param user
     * @return 返回值大于0表示操作成功，否则操作失败
     */
    public Integer add(User user);

    /**
     * 用户删除方法
     * @param id：用户id
     * @return
     */
    public Integer delete(String id);

    /**
     * 用户更新方法
     * @param user
     * @return
     */
    public Integer update(User user);

    /**
     * 通过id获取用户
     * @param id
     * @return
     */
    public User getUserById(String id);

    /**
     * 通过username获取用户
     * @param username
     * @return
     */
    public User getUserByUsername(String username);

    /**
     * 分页获取所有用户
     * @param start：从第几条数据开始
     * @param number：要获取多少条数据
     * @param searchContent：模糊查询内容
     * @return
     */
    public List<User> getUsers(Integer start, Integer number, String searchContent);
}
