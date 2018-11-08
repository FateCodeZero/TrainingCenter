package com.trainingcenter.dao;

import com.trainingcenter.bean.UserType;
import com.trainingcenter.controller.validation.TC_Add;
import com.trainingcenter.controller.validation.TC_Update;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.springframework.validation.annotation.Validated;

import javax.validation.Valid;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/15
 * Time: 17:22
 */
@Repository("userTypeMapper")
public interface UserTypeMapper {
    /**
     * 通过id获取用户类型信息
     * @param id：用户类型id
     * @return 返回用户类型对象
     */
    public UserType getUserTypeById(@Param("id") String id);

    /**
     * 分页获取用户类型
     * @param start：从第几条数据开始查询
     * @param number：一个查询多少条数据
     * @param searchContent：模糊查询内容
     * @return
     */
    public List<UserType> getUserTypes(@Param("start") Integer start, @Param("number") Integer number,
                                       @Param("searchContent") String searchContent);

    /**
     * 添加
     * @param userType：用户类型对象
     * @return 返回操作成功的条数，0表示操作失败
     */
    public Integer add(@Validated(value = {TC_Add.class}) @Param("userType") UserType userType);

    /**
     * 更新
     * @param userType：用户类型对象
     * @return 返回操作成功的条数，0表示操作失败
     */
    public Integer update(@Validated(value = {TC_Update.class}) @Param("userType") UserType userType);

    /**
     * 删除
     * @param id：要删除的用户类型对象id
     * @return 返回操作成功的条数，0表示操作失败
     */
    public Integer delete(@Param("id") String id);
}
