package com.trainingcenter.dao;

import com.trainingcenter.bean.UserCheck;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/15
 * Time: 17:22
 */
@Repository("userCheckMapper")
public interface UserCheckMapper {
    /**
     * 登录校验
     * @param username：用户名
     * @param password：密码
     * @return
     */
    public UserCheck login(@Param("username") String username, @Param("password") String password);

    /**
     * 验证用户名是否可用
     * @param username：用户名
     * @return
     */
    public UserCheck isExist(@Param("username") String username);

    /**
     * 注册/添加
     * @param userCheck :注册对象
     * @return
     */
    public Integer add(@Param("userCheck") UserCheck userCheck);

    /**
     * 注销/删除
     * @param id
     * @return
     */
    public Integer delete(@Param("id") String id);

    /**
     * 修改密码
     * @param userCheck
     * @return
     */
    public Integer update(@Param("userCheck") UserCheck userCheck);

    /**
     * 通过id获取登录信息
     * @param id
     * @return
     */
    public UserCheck getUserCheckById(@Param("id") String id);
}
