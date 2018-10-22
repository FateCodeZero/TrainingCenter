package com.trainingcenter.service.impl;

import com.trainingcenter.bean.User;
import com.trainingcenter.bean.UserCheck;
import com.trainingcenter.dao.UserCheckMapper;
import com.trainingcenter.dao.UserMapper;
import com.trainingcenter.service.UserCheckService;
import com.trainingcenter.utils.MD5Util;
import com.trainingcenter.utils.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/15
 * Time: 17:29
 */
@Service("userCheckService")
public class UserCheckServiceImpl implements UserCheckService {
    @Qualifier("userCheckMapper")
    @Autowired
    private UserCheckMapper userCheckMapper;

    @Qualifier("userMapper")
    @Autowired
    private UserMapper userMapper;

    /**
     * 登录验证
     *
     * @param username：用户账号
     * @param password：用户密码
     * @return
     */
    @Override
    public boolean login(String username, String password) {
        UserCheck userCheck = userCheckMapper.login(username, MD5Util.md5Encrypt(password));//md5加密
        return userCheck != null;
    }

    /**
     * 验证用户名是否可用
     *
     * @param username
     * @return
     */
    @Override
    public boolean isExist(String username) {
        UserCheck userCheck;

        if (StringUtil.isNotEmpty(username)) {
            userCheck = userCheckMapper.isExist(username);
        } else {
            return true;    //用户名不能为空！
        }
        return userCheck != null;
    }

    /**
     * 添加/注册
     *添加事务：保证用户账号密码与用户信息同时生成，只要其中一个失败便回滚
     * @param username：用户名
     * @param password：密码
     * @return 返回操作成功的数量，0表示操作失败
     */
    @Transactional
    @Override
    public Integer add(String username, String password) {
        Integer result = 0;

        if (StringUtil.isNotEmpty(username) && StringUtil.isNotEmpty(password)) {
            Integer step1,step2;
            //添加用户账号密码
            UserCheck userCheck = new UserCheck();
            userCheck.setId(UUID.randomUUID().toString());
            userCheck.setUsername(username);
            userCheck.setPassword(MD5Util.md5Encrypt(password)); //md5加密
            step1 = userCheckMapper.add(userCheck);

            //设置用户基本信息：id与账号，其他的取默认值
            User user = new User();
            user.setId(UUID.randomUUID().toString());
            user.setUsername(username);
            user.setUserTypeId("0");
            step2 = userMapper.add(user);

            result = Math.min(step1,step2);     //取小值，保证两个一起成功
        }
        return result;
    }

    /**
     * 批量添加
     * @param map：要添加的对象信息map集合，需以 username 为 key，以 password 为 value
     * @return 返回操作成功的数目与操作失败的对象
     */
    @Override
    public ConcurrentHashMap<String,Object> batchAdd(ConcurrentHashMap<String, String> map) {
        ConcurrentHashMap result = new ConcurrentHashMap();  //返回结果map

        Integer success = 0; //操作成功的个数
        ConcurrentHashMap<String,String> fail = new ConcurrentHashMap<>();  //操作失败的对象

        for (String username : map.keySet()) {
            Integer res = add(username, map.get(username));
            if (res > 0){
                success += 1;
            }else {
                fail.put(username,map.get(username));
            }
        }
        result.put("success",success);
        result.put("fail",fail);

        return result;
    }

    /**
     * 根据id删除/注销对象
     * 添加事务：保证删除一起成功，若有一个失败，则回滚
     * @param id：删除/注销的id
     * @return 返回操作成功的数量，返回0表示操作失败
     */
    @Transactional
    @Override
    public Integer delete(String id) {
        Integer result = 0;
        if (StringUtil.isNotEmpty(id)){
            Integer step1,step2;
            //先删除用户信息
            step1 = userMapper.delete(id);
            //再删除账号密码
            step2 = userCheckMapper.delete(id);

            result = Math.min(step1,step2);
        }
        return result;
    }

    /**
     * 批量删除
     * @param ids：需要删除的对象的id集
     * @return 返回操作成功的数目与操作失败的对象
     */
    @Override
    public ConcurrentHashMap<String,Object> batchDelete(List<String> ids) {
        ConcurrentHashMap result = new ConcurrentHashMap();  //返回结果map

        Integer success = 0; //操作成功的个数
        ConcurrentHashMap<String,String> fail = new ConcurrentHashMap<>();  //操作失败的对象

        for (String id:ids){
            Integer res = delete(id);
            if (res > 0){
                success += 1;
            }else {
                fail.put(id,id);
            }
        }
        result.put("success",success);
        result.put("fail",fail);

        return result;
    }

    /**
     * 更新
     * @param userCheck：要修改的对象
     * @return 返回操作成功的数量，返回0表示操作失败
     */
    @Override
    public Integer update(UserCheck userCheck) {
        return userCheck == null?0:userCheckMapper.update(userCheck);
    }

    /**
     * 批量更新
     * @param userChecks：要修改的对象list
     * @return 返回操作成功的数目与操作失败的对象
     */
    @Override
    public ConcurrentHashMap<String,Object> batchUpdate(List<UserCheck> userChecks) {
        ConcurrentHashMap result = new ConcurrentHashMap();  //返回结果map

        Integer success = 0; //操作成功的个数
        ConcurrentHashMap<String,Object> fail = new ConcurrentHashMap<>();  //操作失败的对象

        for (UserCheck userCheck : userChecks) {
            Integer res = update(userCheck);
            if (res > 0){
                success += 1;
            }else {
                fail.put(userCheck.getId(),userCheck);
            }
        }

        result.put("success",success);
        result.put("fail",fail);

        return result;
    }

    /**
     * 通过id获取登录信息
     * @param id：id
     * @return 返回登录信息
     */
    @Override
    public UserCheck getUserCheckById(String id) {
        return StringUtil.isNotEmpty(id)?userCheckMapper.getUserCheckById(id):null;
    }
}