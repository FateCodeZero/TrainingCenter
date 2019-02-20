package com.trainingcenter.dao;

import com.trainingcenter.bean.UserInfo;
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
@Repository("userInfoMapper")
public interface UserInfoMapper {

    /**
     * 通过id获取用户
     * @param id：用户id
     * @return 返回用户对象
     */
    public UserInfo getUserInfoById(@Param("id") String id);

    /**
     * 通过username获取用户
     * @param username：用户账号
     * @return 返回用户对象
     */
    public UserInfo getUserInfoByUsername(@Param("username") String username);

    /**
     * 分页获取所有用户
     * @param start：从第几条数据开始
     * @param number：要获取多少条数据
     * @param condition：自定义查询条件，模糊查询的 key 固定为 searchContent
     * @return 返回用户对象集合
     */
    public List<UserInfo> getUserInfos(@Param("start") Integer start, @Param("number") Integer number,
                                   @Param("condition") Map<String,Object> condition);

    /**
     * 用户添加方法
     * @param userInfo：要添加的用户
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer add(@Validated(value = {TC_Add.class}) @Param("userInfo") UserInfo userInfo);

    /**
     * 用户更新方法
     * @param userInfo：要更新的用户
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer update(@Validated(value = {TC_Update.class}) @Param("userInfo") UserInfo userInfo);

    /**
     * 用户删除方法
     * @param id：用户id
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer delete(@Param("id") String id);
}
