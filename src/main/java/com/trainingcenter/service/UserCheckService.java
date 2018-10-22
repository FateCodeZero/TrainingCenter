package com.trainingcenter.service;

import com.trainingcenter.bean.UserCheck;

import java.util.List;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/15
 * Time: 17:27
 *
 * 用户检验服务类，用以检验用户的各种信息
 */
public interface UserCheckService {

    /**
     * 登录验证
     * @param username
     * @param password
     * @return 返回登录是否成功
     */
    public boolean login(String username, String password);

    /**
     * 验证用户名是否可用
     * @param username：用户名
     * @return 用户名是否已被使用
     */
    public boolean isExist(String username);

    /**
     * 注册/添加
     * @param username：用户名
     * @param password：密码
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer add(String username, String password);

    /**
     * 批量添加
     * @param map：要添加的对象信息map集合，需以 username 为 key，以 password 为 value
     * @return 返回操作成功的数目与操作失败的对象
     */
    public ConcurrentHashMap<String,Object> batchAdd(ConcurrentHashMap<String, String> map);

    /**
     * 注销/删除
     * @param id：需要删除对象的id
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer delete(String id);

    /**
     * 批量删除
     * @param ids：需要删除的对象的id集
     * @return 返回操作成功的数目与操作失败的对象
     */
    public ConcurrentHashMap<String,Object> batchDelete(List<String> ids);

    /**
     * 修改密码
     * @param userCheck
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer update(UserCheck userCheck);

    /**
     * 批量修改
     * @param userChecks：要修改的对象list
     * @return 返回操作成功的个数，0表示操作失败
     */
    public ConcurrentHashMap<String,Object> batchUpdate(List<UserCheck> userChecks);

    /**
     * 通过id获取登录信息
     * @param id
     * @return
     */
    public UserCheck getUserCheckById(String id);
}
