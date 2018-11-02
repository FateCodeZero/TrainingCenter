package com.trainingcenter.service.impl;

import com.trainingcenter.bean.LoginInfo;
import com.trainingcenter.bean.User;
import com.trainingcenter.dao.LoginInfoMapper;
import com.trainingcenter.dao.UserMapper;
import com.trainingcenter.exception.DeleteException;
import com.trainingcenter.exception.RegisterException;
import com.trainingcenter.service.LoginInfoService;
import com.trainingcenter.utils.MD5Util;
import com.trainingcenter.utils.StringUtil;
import com.trainingcenter.utils.SysUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.validation.Valid;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/15
 * Time: 17:29
 */
@Service("loginInfoService")
public class LoginInfoServiceImpl implements LoginInfoService {
    @Qualifier("loginInfoMapper")
    @Autowired
    private LoginInfoMapper loginInfoMapper;

    @Qualifier("userMapper")
    @Autowired
    private UserMapper userMapper;

    /**
     * 验证用户名是否已存在
     *
     * @param username：用户名
     * @return true：账号已存在，false：账号不存在，可用
     */
    @Override
    public boolean checkUsername(String username) {
        LoginInfo loginInfo;

        if (StringUtil.isNotEmpty(username)) {
            loginInfo = loginInfoMapper.getLoginInfoByUsername(username);
        } else {
            return true;    //用户名不能为空！
        }
        return loginInfo != null;
    }

    /**
     * 登录验证
     *
     * @param username：用户账号
     * @param password：用户密码
     * @param IP：用户IP
     * @return
     */
    @Override
    public boolean login(String username, String password, String IP) {
        LoginInfo loginInfo;

        if (StringUtil.isNotEmpty(username) && StringUtil.isNotEmpty(password)){
            loginInfo = loginInfoMapper.getLoginInfoByUsernameAndPassword(username, MD5Util.md5Encrypt(password));//md5加密
        }else {
            return false;
        }

        return loginInfo != null;
    }

    /**
     * 添加/注册
     * @Transactional 添加事务：保证用户账号密码与用户信息同时生成，只要其中一个失败便回滚
     * @param username：用户名
     * @param password：密码
     * @param IP：用户IP
     * @return 返回操作成功的数量，0表示操作失败
     */
    @Transactional
    @Override
    public Integer register(String username, String password, String IP) throws RegisterException {
        Integer result = 0;

        if (StringUtil.isNotEmpty(username) && StringUtil.isNotEmpty(password)) {

            if (!checkUsername(username)){  //确保账号不存在，即账号可用
                Integer step1,step2;
                //添加登录信息
                LoginInfo loginInfo = new LoginInfo();
                loginInfo.setId(UUID.randomUUID().toString());
                loginInfo.setUsername(username);
                loginInfo.setPassword(MD5Util.md5Encrypt(password)); //md5加密
                loginInfo.setLoginIP(IP);
                loginInfo.setLastLoginTime(new Date());
                step1 = loginInfoMapper.add(loginInfo);

                //设置用户基本信息：id与账号，其他的取默认值
                User user = new User();
                user.setId(UUID.randomUUID().toString());
                user.setUsername(username);
                user.setNickname(username); //昵称默认为username
                user.setGender(1);  //性别默认为男
                user.setBirthday(new Date());  //生日默认为当前时间
                user.setState(1);   //使用状态：默认启用
                user.setRegisterTime(new Date());//注册时间为当前时间

                step2 = userMapper.add(user);

                result = Math.min(step1,step2);     //取小值，保证两个一起成功
                if (result == 0){
                    throw new RegisterException("注册失败，请重试！");
                }
            }else {
                throw new RegisterException("注册失败，用户名已被使用！");
            }
        }else {
            throw new RegisterException("注册失败，用户名或密码不能为空！");
        }
        return result;
    }

    /**
     * 更新
     * @param loginInfo：要修改的对象
     * @return 返回操作成功的数量，返回0表示操作失败
     */
    @Override
    public Integer update(@Valid LoginInfo loginInfo) {
        return loginInfo == null?0:loginInfoMapper.update(loginInfo);
    }

    /**
     * 根据id删除/注销对象
     * @Transactional 添加事务：保证删除一起成功，若有一个失败，则回滚
     * @param id：删除/注销的id
     * @return 返回操作成功的数量，返回0表示操作失败
     */
    @Transactional
    @Override
    public Integer delete(String id) throws DeleteException {
        Integer result = 0;
        if (StringUtil.isNotEmpty(id)){

            if (this.getLoginInfoById(id) != null){//确保要删除对象存在
                Integer step1,step2;
                //1、先删除用户信息
                step1 = userMapper.delete(id);
                //2、再删除账号密码
                step2 = loginInfoMapper.delete(id);

                result = Math.min(step1,step2);  //取小值

                if (result == 0){
                    throw new DeleteException("删除失败，请稍后重试！");
                }
            }else {
                throw new DeleteException("删除失败，对象不存在或已被删除！");
            }
        }else {
            throw new DeleteException("删除失败，删除对象id不能为空！");
        }
        return result;
    }

    /**
     * 批量删除
     * @param ids：需要删除的对象的id集
     * @return 返回操作成功的数目与操作失败的对象
     */
    @Override
    public Map<String,Object> batchDelete(String ids){
        if (StringUtil.isEmpty(ids))
            return null;

        Map<String, Object> result = new ConcurrentHashMap<>();  //返回结果map

        Integer success = 0; //操作成功的个数
        Map<String, Object> fail = new ConcurrentHashMap<>();  //操作失败的对象

        String[] arr = ids.split(",");  //分割成数组
        for (String id : arr) {
            Integer res = null;
            try {
                res = this.delete(id);
            } catch (DeleteException e) { //删除失败
                res = 0;
                e.printStackTrace();
            }
            if (res > 0) {
                success += 1;
            } else {
                fail.put(id, this.getLoginInfoById(id));
            }
        }

        result.put("success", success);
        result.put("fail", fail);

        return result;
    }

    /**
     * 通过id获取登录信息
     * @param id：id
     * @return 返回登录信息
     */
    @Override
    public LoginInfo getLoginInfoById(String id){
        return StringUtil.isNotEmpty(id)?loginInfoMapper.getLoginInfoById(id):null;
    }

    /**
     * 通过username获取登录信息
     * @param username
     * @return
     */
    @Override
    public LoginInfo getLoginInfoByUsername(String username){
        return StringUtil.isNotEmpty(username)?loginInfoMapper.getLoginInfoByUsername(username):null;
    }

    /**
     * 分页获取数据
     * @param currentPage：当前页
     * @param rows：每页要显示的数据条数
     * @param searchContent：模糊查询内容
     * @return 返回当前页的数据集合
     */
    @Override
    public List<LoginInfo> getLoginInfos(Integer currentPage, Integer rows, String searchContent){
        Integer start = (currentPage - 1) * rows;   //计算当前页的数据是从第几条开始查询
        return loginInfoMapper.getLoginInfos(start,rows,searchContent);
    }
}