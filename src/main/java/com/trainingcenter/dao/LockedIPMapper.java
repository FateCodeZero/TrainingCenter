package com.trainingcenter.dao;

import com.trainingcenter.bean.LockedIP;
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
 * Date: 2018/12/3
 * Time: 19:33
 */
@Repository("lockedIPMapper")
public interface LockedIPMapper {
    /**
     * 通过 id 获取锁定对象
     * @return
     */
    public LockedIP getLockedIPById(@Param("id") String id);

    /**
     * 通过 IP 获取锁定对象
     * @return
     */
    public LockedIP getLockedIPByIP(@Param("IP") String IP);

    /**
     * 分页获取所有数据
     * @param start：从第几条数据开始
     * @param number：要获取多少条数据
     * @param condition：自定义查询条件，模糊查询的 key 固定为 searchContent
     * @return 返回锁定对象集合
     */
    public List<LockedIP> getLockedIPs(@Param("start") Integer start, @Param("number") Integer number,
                                       @Param("condition") Map<String,Object> condition);

    /**
     * 数据添加
     * @param lockedIP：要添加的数据对象
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer add(@Validated(value = {TC_Add.class}) @Param("lockedIP") LockedIP lockedIP);


    /**
     * 数据更新
     * @param lockedIP：要更新的数据对象
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer update(@Validated(value = {TC_Update.class}) @Param("lockedIP") LockedIP lockedIP);

    /**
     * 数据删除
     * @param id：要删除的数据id
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer delete(@Param("id") String id);
} 