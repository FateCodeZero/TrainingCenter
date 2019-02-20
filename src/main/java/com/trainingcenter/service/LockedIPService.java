package com.trainingcenter.service;

import com.trainingcenter.bean.LockedIP;
import com.trainingcenter.controller.validation.TC_Add;
import com.trainingcenter.controller.validation.TC_Update;
import org.springframework.validation.annotation.Validated;

import java.util.List;
import java.util.Map;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/12/3
 * Time: 20:03
 */
public interface LockedIPService {
    /**
     * 通过 id 获取锁定对象
     * @return
     */
    public LockedIP getLockedIPById(String id);

    /**
     * 通过 IP 获取锁定对象
     * @return
     */
    public LockedIP getLockedIPByIP(String IP);

    /**
     * 获取所有数据
     * @param condition：自定义查询条件，模糊查询的 key 固定为 searchContent
     * @return 返回锁定对象集合
     */
    public List<LockedIP> getLockedIPs(Map<String,Object> condition);
    
    /**
     * 分页获取所有数据
     * @param currentPage：当前页
     * @param rows：每页要显示的数据条数
     * @param condition：自定义查询条件，模糊查询的 key 固定为 searchContent
     * @return 返回锁定对象集合
     */
    public List<LockedIP> getLockedIPs(Integer currentPage, Integer rows, Map<String,Object> condition);

    /**
     * 数据添加
     * @param lockedIP：要添加的数据对象
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer add(@Validated(value = {TC_Add.class}) LockedIP lockedIP);


    /**
     * 数据更新
     * @param lockedIP：要更新的数据对象
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer update(@Validated(value = {TC_Update.class}) LockedIP lockedIP);

    /**
     * 数据删除
     * @param id：要删除的数据id
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer delete(String id);

    /**
     * 批量删除
     *
     * @param ids：需要删除的对象的id集
     * @return 返回操作结果（1：删除成功，0：删除失败）
     * 添加事务，保证中间删除失败时可以回滚
     */
    public Integer batchDelete(String ids);
}
