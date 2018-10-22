package com.trainingcenter.service.impl;

import com.trainingcenter.bean.User;
import com.trainingcenter.dao.UserMapper;
import com.trainingcenter.service.UserService;
import com.trainingcenter.utils.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/15
 * Time: 17:29
 */
@Service("userService")
public class UserServiceImpl implements UserService {
    @Qualifier(value = "userMapper")
    @Autowired
    private UserMapper userMapper;

    /**
     * 用户添加方法
     * @param user：用户对象
     * @return  返回值大于0表示操作成功，否则操作失败
     */
    @Override
    public Integer add(User user) {
        return user == null ? 0:userMapper.add(user);
    }

    /**
     * 用户更新方法
     * @param user：用户对象
     * @return 返回值大于0表示操作成功，否则操作失败
     */
    @Override
    public Integer update(User user) {
        return user == null ? 0:userMapper.update(user);
    }

    /**
     * 用户删除方法
     * @param id：用户id
     * @return 返回值大于0表示操作成功，否则操作失败
     */
    @Override
    public Integer delete(String id) {
        return StringUtil.isNotEmpty(id)?userMapper.delete(id):0;
    }

    /**
     * 通过id获取用户
     * @param id
     * @return
     */
    @Override
    public User getUserById(String id) {
        return StringUtil.isNotEmpty(id)?userMapper.getUserById(id):null;
    }

    /**
     * 通过username获取用户
     * @param username
     * @return
     */
    @Override
    public User getUserByUsername(String username) {
        return StringUtil.isNotEmpty(username)?userMapper.getUserById(username):null;
    }

    /**
     * 分页查询所有用户
     * @param start：从第几条数据开始
     * @param number：要获取多少条数据
     * @param searchContent：模糊查询内容
     * @return
     */
    @Override
    public List<User> getUsers(Integer start, Integer number, String searchContent) {
        return userMapper.getUsers(start,number,searchContent);
    }
}