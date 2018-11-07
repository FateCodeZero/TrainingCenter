package com.trainingcenter.dao;

import com.trainingcenter.bean.LoginInfo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import javax.validation.Valid;
import java.util.Collection;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/15
 * Time: 17:22
 */
@Repository("loginInfoMapper")
public interface LoginInfoMapper {

    /**
     * 通过id获取登录信息
     * @param id : 对象id
     * @return 返回 LoginInfo 对象
     */
    public LoginInfo getLoginInfoById(@Param("id") String id);

    /**
     * 通过username获取登录信息
     * @param username : 对象username
     * @return 返回 LoginInfo 对象
     */
    public LoginInfo getLoginInfoByUsername(@Param("username") String username);

    /**
     * 通过用户名与密码获取登录信息
     * @param username：用户名
     * @param password：密码
     * @return 返回登录信息 LoginInfo 对象
     */
    public LoginInfo getLoginInfoByUsernameAndPassword(@Param("username") String username, @Param("password") String password);

    /**
     * 分页获取数据
     * @param start：从第几条数据开始查
     * @param number：查询多少条数据
     * @param searchContent：模糊查询内容
     * @return 返回当前页的数据集合
     */
    public List<LoginInfo> getLoginInfos(@Param("start") Integer start, @Param("number") Integer number, @Param("searchContent") String searchContent);


    /**
     * 注册/添加
     * @param loginInfo :注册对象
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer add(@Valid @Param("loginInfo") LoginInfo loginInfo);

    /**
     * 注销/删除
     * @param id : 删除对象的id
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer delete(@Param("id") String id);

    /**
     * 修改密码
     * @param loginInfo
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer update(@Valid @Param("loginInfo") LoginInfo loginInfo);

    /**
     * 获取含有指定 角色 的所有用户
     * @param roleId 指定角色id
     * @param start：从第几条数据开始
     * @param number：要获取多少条数据
     * @param searchContent：模糊查询内容
     * @return 返回含有该角色的所有用户，支持分页与模糊查询
     */
    public Collection<LoginInfo> getLoginInfosByRoleId(@Param("roleId") String roleId,@Param("start") Integer start,
                                                       @Param("number") Integer number, @Param("searchContent") String searchContent);

}
