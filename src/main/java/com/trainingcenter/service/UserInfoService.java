package com.trainingcenter.service;

import com.trainingcenter.bean.UserInfo;
import com.trainingcenter.controller.validation.TC_Add;
import com.trainingcenter.controller.validation.TC_Update;
import com.trainingcenter.exception.DeleteException;
import org.springframework.validation.annotation.Validated;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/15
 * Time: 17:26
 */
public interface UserInfoService {

    /**
     * 通过id获取用户
     *
     * @param id
     * @return
     */
    public UserInfo getUserInfoById(String id);

    /**
     * 通过username获取用户
     *
     * @param username
     * @return
     */
    public UserInfo getUserInfoByUsername(String username);

    /**
     * 分页获取所有用户
     *
     * @param currentPage：当前页
     * @param rows：每页要显示的数据条数
     * @param searchContent：模糊查询内容
     * @return 返回当前页的数据集合
     */
    public List<UserInfo> getUserInfos(Integer currentPage, Integer rows, String searchContent);

    /**
     * 用户添加方法
     *
     * @param user
     * @return 返回值大于0表示操作成功，否则操作失败
     */
    public Integer add(@Validated(value = {TC_Add.class}) UserInfo user);

    /**
     * 用户更新方法
     *
     * @param user
     * @return
     */
    public Integer update(@Validated(value = {TC_Update.class}) UserInfo user);

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
     * @return 返回操作结果状态（1：成功，0：失败）
     */
    public Integer batchDelete(String ids);
}
