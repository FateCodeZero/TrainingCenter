package com.trainingcenter.dao;

import com.trainingcenter.bean.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import javax.validation.Valid;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/15
 * Time: 17:22
 */
@Repository("userMapper")
public interface UserMapper {

    /**
     * 通过id获取用户
     * @param id：用户id
     * @return 返回用户对象
     */
    public User getUserById(@Param("id") String id);

    /**
     * 通过username获取用户
     * @param username：用户账号
     * @return 返回用户对象
     */
    public User getUserByUsername(@Param("username") String username);

    /**
     * 分页获取所有用户
     * @param start：从第几条数据开始
     * @param number：要获取多少条数据
     * @param searchContent：模糊查询内容
     * @return 返回用户对象集合
     */
    public List<User> getUsers(@Param("start") Integer start, @Param("number") Integer number,
                               @Param("searchContent") String searchContent);

    /**
     * 用户添加方法
     * @param user：要添加的用户
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer add(@Valid @Param("user") User user);

    /**
     * 用户更新方法
     * @param user：要更新的用户
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer update(@Valid @Param("user") User user);

    /**
     * 用户删除方法
     * @param id：用户id
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer delete(@Param("id") String id);
}
