package com.trainingcenter.service;

import com.trainingcenter.bean.LoginInfo;
import com.trainingcenter.controller.validation.TC_Update;
import com.trainingcenter.exception.DeleteException;
import com.trainingcenter.exception.FindException;
import com.trainingcenter.exception.RegisterException;
import com.trainingcenter.exception.UpdateException;
import org.springframework.validation.annotation.Validated;

import javax.validation.Valid;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/15
 * Time: 17:27
 *
 * 用户登录信息服务类，用以检验用户登录的各种信息
 */
public interface LoginInfoService {

    /**
     * 检查用户名是否可用
     * @param username：用户名
     * @return 用户名是否已被使用 true：账号已存在，false：账号不存在，可用
     */
    public boolean checkUsername(String username);

    /**
     * 登录验证
     * @param username：账号
     * @param password：密码
     * @param IP：用户IP
     * @return 返回登录是否成功
     */
    public boolean login(String username, String password, String IP);

    /**
     * 注册/添加
     * @param username：用户名
     * @param password：密码
     * @param IP：用户IP
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer register(String username, String password, String IP);

    /**
     * 修改
     * @param loginInfo：被修改的对象
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer update(@Validated(value = {TC_Update.class}) LoginInfo loginInfo);

    /**
     * 注销/删除
     * @param id：需要删除对象的id
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer delete(String id) throws DeleteException, FindException;

    /**
     * 批量删除
     * @param ids：需要删除的对象的id集
     * @return 返回操作成功的数目与操作失败的对象
     */
    public Map<String,Object> batchDelete(String ids);

    /**
     * 通过id获取登录信息
     * @param id：对象id
     * @return
     */
    public LoginInfo getLoginInfoById(String id);

    /**
     * 通过username获取登录信息
     * @param username：账号
     * @return
     */
    public LoginInfo getLoginInfoByUsername(String username);

    /**
     * 分页获取数据
     * @param currentPage：当前页
     * @param rows：每页要显示的数据条数
     * @param searchContent：模糊查询内容
     * @return 返回当前页的数据集合
     */
    public List<LoginInfo> getLoginInfos(Integer currentPage, Integer rows, String searchContent);

    /**
     * 给用户授角色，添加事务保证授权统一成功或失败
     * @param loginInfoId ：用户登录信息id
     * @param roleIds ：授予的角色id集
     * 返回授权成功的个数，0表示授权失败
     */
    public Integer grantRoles(String loginInfoId, String roleIds);
}
