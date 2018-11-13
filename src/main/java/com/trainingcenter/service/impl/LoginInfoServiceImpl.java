package com.trainingcenter.service.impl;

import com.trainingcenter.bean.*;
import com.trainingcenter.controller.validation.TC_Update;
import com.trainingcenter.dao.*;
import com.trainingcenter.exception.*;
import com.trainingcenter.service.LoginInfoService;
import com.trainingcenter.utils.LogUtil;
import com.trainingcenter.utils.MD5Util;
import com.trainingcenter.utils.StringUtil;
import com.trainingcenter.utils.SysResourcesUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.annotation.Validated;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/15
 * Time: 17:29
 */
@Service("loginInfoService")
public class LoginInfoServiceImpl implements LoginInfoService, UserDetailsService {
    @Qualifier("loginInfoMapper")
    @Autowired
    private LoginInfoMapper loginInfoMapper;

    @Qualifier("userMapper")
    @Autowired
    private UserMapper userMapper;

    @Qualifier("loginInfoRoleMapper")
    @Autowired
    private LoginInfoRoleMapper loginInfoRoleMapper;

    @Qualifier("roleMapper")
    @Autowired
    private RoleMapper roleMapper;
    @Qualifier("permissionMapper")
    @Autowired
    private PermissionMapper permissionMapper;

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

        if (StringUtil.isNotEmpty(username) && StringUtil.isNotEmpty(password)) {
            LogUtil.info(this,"用户登录","用户【"+username+"】登录了");
            loginInfo = loginInfoMapper.getLoginInfoByUsernameAndPassword(username, MD5Util.md5Encrypt(password));//md5加密
        } else {
            return false;
        }

        return loginInfo != null;
    }

    /**
     * 添加/注册
     *
     * @param username：用户名
     * @param password：密码
     * @param IP：用户IP
     * @return 返回操作成功的数量，0表示操作失败
     * @Transactional 添加事务：保证用户账号密码与用户信息同时生成，只要其中一个失败便回滚
     */
    @Transactional
    @Override
    public Integer register(String username, String password, String IP) throws RegisterException {
        Integer result = 0;     //注册结果状态
        RegisterException registerException;    //注册异常

        if (StringUtil.isNotEmpty(username) && StringUtil.isNotEmpty(password)) {

            if (!checkUsername(username)) {  //确保账号不存在，即账号可用
                Integer step1, step2, step3;
                //1、添加登录信息
                LoginInfo loginInfo = new LoginInfo();
                loginInfo.setId(UUID.randomUUID().toString());
                loginInfo.setUsername(username);
                loginInfo.setPassword(MD5Util.md5Encrypt(password)); //md5加密
                loginInfo.setLoginIP(IP);
                loginInfo.setLastLoginTime(new Date());
                loginInfo.setState(1);  //默认使用状态为启用
                loginInfo.setIsUnlocked(1); //默认未锁定

                //日志记录
                LogUtil.info(this, "用户注册", "添加用户：【" + username + "】登录信息");

                step1 = loginInfoMapper.add(loginInfo);
                result = step1;
                if (result == 0) {
                    registerException = new RegisterException("注册失败，请重试");
                    //日志记录
                    LogUtil.info(this, "用户注册", "添加用户：【" + username + "】登录信息【失败】");
                    throw registerException;
                }

                //2、设置用户基本信息：id与账号，其他的取默认值
                User user = new User();
                user.setId(UUID.randomUUID().toString());
                user.setUsername(username);
                user.setNickname(username); //昵称默认为username
                user.setGender(1);  //性别默认为男
                user.setBirthday(new Date());  //生日默认为当前时间
                user.setState(1);   //使用状态：默认启用
                user.setRegisterTime(new Date());//注册时间为当前时间

                //日志记录
                LogUtil.info(this, "用户注册", "添加用户：【" + username + "】基本信息");

                step2 = userMapper.add(user);
                result = step2;
                if (result == 0) {
                    registerException = new RegisterException("注册失败，请重试");
                    //日志记录
                    LogUtil.info(this, "用户注册", "添加用户：【" + username + "】基本信息【失败】");
                    throw registerException;
                }

                //3、给用户授默认的用户权限
                Role role = roleMapper.getRoleByName("USER");
                if (role == null) {
                    registerException = new RegisterException("注册失败，请重试");

                    LogUtil.info(this, "用户注册", "获取【USER】权限【失败】");
                    throw registerException;
                }
                LoginInfoRole loginInfoRole = new LoginInfoRole();
                loginInfoRole.setId(UUID.randomUUID().toString());
                loginInfoRole.setLoginInfoId(loginInfo.getId());
                loginInfoRole.setRoleId(role.getId());

                //日志记录
                LogUtil.info(this, "用户注册", "给用户：【" + username + "】授USER权限");

                step3 = loginInfoRoleMapper.add(loginInfoRole);
                result = step3;
                if (result == 0) {
                    registerException = new RegisterException("注册失败，请重试");

                    //日志记录
                    LogUtil.info(this, "用户注册", "给用户：【" + username + "】授USER权限【失败】");
                    throw registerException;
                }
            } else {
                registerException = new RegisterException("注册失败，用户名已被使用！");

                LogUtil.info(this, "用户注册", "注册【失败】，用户名已被使用");
                throw registerException;
            }
        } else {
            registerException = new RegisterException("注册失败，用户名或密码不能为空！");
            LogUtil.info(this, "用户注册", "注册【失败】，用户名或密码为空");

            throw registerException;
        }
        return result;
    }

    /**
     * 更新
     *
     * @param loginInfo：要修改的对象
     * @return 返回操作成功的数量，返回0表示操作失败
     */
    @Override
    public Integer update(@Validated(value = {TC_Update.class}) LoginInfo loginInfo) throws UpdateException {
        UpdateException updateException;

        if (loginInfo == null) {
            throw new UpdateException("更新失败，用户不存在或已被删除");
        }
        //日志记录
        LogUtil.info(this, "用户登录信息更新", "用户：【" + SysResourcesUtils.getCurrentUsername() + "】更新了==》用户：【" + loginInfo.getUsername() + "】的登录信息");
        Integer res = loginInfoMapper.update(loginInfo);
        if (res == 0) {
            updateException = new UpdateException("更新失败，请重试");
            //日志记录
            LogUtil.info(this, "用户登录信息更新", "用户：【" + SysResourcesUtils.getCurrentUsername() + "】更新==》用户：【" + loginInfo.getUsername() + "】登录信息【失败】");
            throw updateException;
        }
        return res;
    }

    /**
     * 根据id删除/注销对象
     *
     * @param id：删除/注销的id
     * @return 返回操作成功的数量，返回0表示操作失败
     * @Transactional 添加事务：保证删除一起成功，若有一个失败，则回滚
     */
    @Transactional
    @Override
    public Integer delete(String id) throws DeleteException, FindException {
        DeleteException deleteException;
        Integer result = 0;
        if (StringUtil.isNotEmpty(id)) {

            if (this.getLoginInfoById(id) != null) {//确保要删除对象存在
                Integer step1, step2, step3;
                //1、先删除用户信息
                LoginInfo loginInfo = loginInfoMapper.getLoginInfoById(id);
                User user = userMapper.getUserByUsername(loginInfo.getUsername());

                LogUtil.info(this,"用户删除","用户【"+SysResourcesUtils.getCurrentUsername()+"】在删除==》用户【"+loginInfo.getUsername()+"】的信息……");

                //日志记录
                LogUtil.info(this, "删除用户基本信息", "用户：【" + SysResourcesUtils.getCurrentUsername() + "】删除了==》用户：" + loginInfo.getUsername() + "的基本信息");

                step1 = userMapper.delete(user.getId());
                result = step1;
                if (result == 0) {
                    deleteException = new DeleteException("删除失败，请稍后重试");
                    //日志记录
                    LogUtil.info(this, "删除用户基本信息", "用户：【" + SysResourcesUtils.getCurrentUsername() + "】删除==》用户：" + loginInfo.getUsername() + "的基本信息【失败】");
                    throw deleteException;
                }

                //2、删除用户权限信息
                Collection<Role> roles = roleMapper.getRolesByLoginInfoId(loginInfo.getId(), null, null, null);
                for (Role role : roles) {

                    //日志记录
                    LogUtil.info(this, "删除用户权限", "用户：【" + SysResourcesUtils.getCurrentUsername() + "】删除了==》用户：" + loginInfo.getUsername() + "的【" + role.getName() + "】权限");

                    step2 = loginInfoRoleMapper.delete(role.getId());
                    result = step2;
                    if (result == 0) {
                        deleteException = new DeleteException("删除失败，请稍后重试");

                        LogUtil.info(this, "删除用户权限",
                                "用户：【" + SysResourcesUtils.getCurrentUsername() + "】删除==》用户：" + loginInfo.getUsername() + "的【" + role.getName() + "】权限【失败】");
                        throw deleteException;
                    }
                }

                //3、再删除账号密码
                LogUtil.info(this, "删除用户登录信息", "用户：【" + SysResourcesUtils.getCurrentUsername() + "】删除了==》用户：" + loginInfo.getUsername() + "的登录信息");
                step3 = loginInfoMapper.delete(id);
                result = step3;
                if (step3 == 0) {
                    deleteException = new DeleteException("删除失败，请稍后重试");
                    LogUtil.info(this, "删除用户登录信息", "用户：【" + SysResourcesUtils.getCurrentUsername() + "】删除==》用户：" + loginInfo.getUsername() + "的登录信息【失败】");
                    throw deleteException;
                }
            } else {
                deleteException = new DeleteException("删除失败，删除对象不存在或已被删除");

                LogUtil.info(this, "用户删除", "用户【"+SysResourcesUtils.getCurrentUsername()+"】执行用户删除【失败】，删除对象不存在或已被删除");
                throw deleteException;
            }
        } else {
            deleteException = new DeleteException("删除失败，删除对象id不能为空");
            LogUtil.info(this, "用户删除", "用户【"+SysResourcesUtils.getCurrentUsername()+"】执行用户删除【失败】，删除对象id为空");
            throw deleteException;
        }
        return result;
    }

    /**
     * 批量删除
     *
     * @param ids：需要删除的对象的id集
     * @return 返回操作成功的数目与操作失败的对象
     */
    @Override
    public Map<String, Object> batchDelete(String ids) throws FindException, DeleteException {
        DeleteException deleteException;
        if (StringUtil.isEmpty(ids)){
            deleteException = new DeleteException("删除失败，批量删除ids不能为空");
            LogUtil.info(this,"批量删除","用户："+SysResourcesUtils.getCurrentUsername()+"执行批量删除，删除【失败】，批量删除ids为空");
            throw deleteException;
        }

        Map<String, Object> result = new ConcurrentHashMap<>();  //返回结果map

        Integer success = 0; //操作成功的个数
        Map<String, Object> fail = new ConcurrentHashMap<>();  //操作失败的对象

        LogUtil.info(this,"批量删除","用户："+SysResourcesUtils.getCurrentUsername()+"执行批量删除，删除对象ids：【"+ids+"】");

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
     *
     * @param id：id
     * @return 返回登录信息
     */
    @Override
    public LoginInfo getLoginInfoById(String id) throws FindException {
        return StringUtil.isEmpty(id)?null:loginInfoMapper.getLoginInfoById(id);
    }

    /**
     * 通过username获取登录信息
     *
     * @param username
     * @return
     */
    @Override
    public LoginInfo getLoginInfoByUsername(String username) {
        return StringUtil.isEmpty(username) ? null : loginInfoMapper.getLoginInfoByUsername(username);
    }

    /**
     * 分页获取数据
     *
     * @param currentPage：当前页
     * @param rows：每页要显示的数据条数
     * @param searchContent：模糊查询内容
     * @return 返回当前页的数据集合
     */
    @Override
    public List<LoginInfo> getLoginInfos(Integer currentPage, Integer rows, String searchContent) throws FindException {
        FindException findException;

        Integer start = null;
        if (currentPage != null && rows != null ) {
            if (currentPage < 0 || rows < 0) {
                findException = new FindException("分页查询不能的页数或查询数量小于0");
                LogUtil.info(this,"查询用户登录信息","查询失败，分页查询不能的页数或查询数量小于0");
                throw findException;
            }else {
                start = (currentPage - 1) * rows;   //计算当前页的数据是从第几条开始查询
            }
        }
        return loginInfoMapper.getLoginInfos(start, rows, searchContent);
    }

    /**
     * 加载用户信息，security用
     *
     * @param username：用户名
     * @return
     * @throws UsernameNotFoundException
     */
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        UsernameNotFoundException exception;
        LoginInfo loginInfo;
        if (StringUtil.isNotEmpty(username)) {
            loginInfo = this.getLoginInfoByUsername(username);

            if (loginInfo == null) {
                exception = new UsernameNotFoundException("用户不存在或已注销");
                LogUtil.info(this,"加载用户权限","加载失败，用户不存在或已注销");
                throw exception;
            }

            LogUtil.info(this,"加载用户权限","正在加载用户【"+username+"】的相关权限及用户信息……");
            //获取用户的所有角色
            Collection<Role> roles = roleMapper.getRolesByLoginInfoId(loginInfo.getId(), null, null, null);

            //获取该用户所有角色的所有权限
            for (Role role:roles) {
                Collection<Permission> permissions = permissionMapper.getPermissionsByRoleId(role.getId(), null, null, null);
                //给角色注入权限
                role.setPermissions(permissions);
            }

            //给用户注入角色
            loginInfo.setAuthorities(roles);
        } else {
            exception = new UsernameNotFoundException("用户名不存在");
            LogUtil.info(this,"加载用户权限","加载失败，用户名不存在");
            throw exception;
        }
        return loginInfo;
    }

    /**
     * 给用户授角色，添加事务保证授权统一成功或失败
     * @param loginInfoId ：用户登录信息id
     * @param roleIds ：授予的角色id集
     * @return 返回授权成功的个数，0表示授权失败
     */
    @Transactional
    @Override
    public Integer grantRoles(String loginInfoId, String roleIds) {
        GrantException grantException;  //授权异常
        DeleteException deleteException; //删除异常
        Integer result = 0;

        if (StringUtil.isEmpty(loginInfoId) || StringUtil.isEmpty(roleIds)){
            grantException = new GrantException("授予用户角色失败，用户或所授角色不能为空");
            throw grantException;
        }

        LoginInfo loginInfo = loginInfoMapper.getLoginInfoById(loginInfoId);
        //确保授权对象存在
        if (loginInfo == null){
            grantException = new GrantException("授予用户角色失败，用户不存在或已被删除");
            throw grantException;
        }

        //清空该用户之前的角色，再重新授予
        Collection<Role> roles = roleMapper.getRolesByLoginInfoId(loginInfo.getId(), null, null, null);
        for (Role r : roles) {
            //逐一清除该用户之前的角色
            LoginInfoRole loginInfoRole = loginInfoRoleMapper.getLoginInfoRoleByLoginInfoIdAndRoleId(loginInfo.getId(), r.getId());
            result = loginInfoRoleMapper.delete(loginInfoRole.getId());
            if (result == 0){
                deleteException = new DeleteException("授予用户角色失败，请重试");
                throw deleteException;
            }
        }

        //获取当前登录用户
        String username = SysResourcesUtils.getCurrentUsername();
        LoginInfo user = loginInfoMapper.getLoginInfoByUsername(username);

        //逐一授权
        String[] arr = roleIds.split(",");
        for (String roleId : arr) {
            Role role = roleMapper.getRoleById(roleId);
            //确保被授角色存在
            if (role == null){
                grantException = new GrantException("授予用户角色失败，所授角色不存在或已被删除");
                throw grantException;
            }

            //授予用户角色
            LoginInfoRole loginInfoRole = new LoginInfoRole();
            loginInfoRole.setId(UUID.randomUUID().toString());
            loginInfoRole.setLoginInfoId(loginInfoId);
            loginInfoRole.setRoleId(roleId);
            loginInfoRole.setCreateUserId(user.getId());
            loginInfoRole.setCreateDate(new Date());

            result = loginInfoRoleMapper.add(loginInfoRole);
            if (result == 0){
                grantException = new GrantException("授予用户角色失败，请重试");
                throw grantException;
            }
        }

        return result;
    }

}