package com.trainingcenter.service.impl;

import com.trainingcenter.bean.*;
import com.trainingcenter.controller.validation.TC_Add;
import com.trainingcenter.controller.validation.TC_Update;
import com.trainingcenter.dao.*;
import com.trainingcenter.exception.*;
import com.trainingcenter.service.UserService;
import com.trainingcenter.utils.LogUtil;
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

import java.util.List;
import java.util.List;
import java.util.UUID;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/15
 * Time: 17:29
 */
@Service("userService")
public class UserServiceImpl implements UserService, UserDetailsService {
    @Qualifier("userMapper")
    @Autowired
    private UserMapper userMapper;

    @Qualifier("userInfoMapper")
    @Autowired
    private UserInfoMapper userInfoMapper;

    @Qualifier("userRoleMapper")
    @Autowired
    private UserRoleMapper userRoleMapper;

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
        User user;

        if (StringUtil.isNotEmpty(username)) {
            user = userMapper.getUserByUsername(username);
        } else {
            return true;    //用户名不能为空！
        }
        return user != null;
    }

    /**
     * 通过id获取登录信息
     *
     * @param id：id
     * @return 返回登录信息
     */
    @Override
    public User getUserById(String id) {
        return StringUtil.isEmpty(id) ? null : userMapper.getUserById(id);
    }

    /**
     * 通过username获取登录信息
     *
     * @param username：用户账号
     * @return
     */
    @Override
    public User getUserByUsername(String username) {
        return StringUtil.isEmpty(username) ? null : userMapper.getUserByUsername(username);
    }

    /**
     * 获取所有数据
     *
     * @return
     */
    public List<User> getUsers() {
        return getUsers(null, null, null);
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
    public List<User> getUsers(Integer currentPage, Integer rows, String searchContent) {
        FindException findException;

        if (currentPage != null && rows != null) {
            if (currentPage < 0 || rows < 0) {
                findException = new FindException("分页查询不能的页数或查询数量小于0");
                LogUtil.info(this, "查询用户登录信息", "查询失败，分页查询不能的页数或查询数量小于0");
                throw findException;
            } else {
                Integer start = (currentPage - 1) * rows;   //计算当前页的数据是从第几条开始查询
                return userMapper.getUsers(start, rows, searchContent);
            }
        } else {
            return userMapper.getUsers(null, null, searchContent);
        }
    }

    /**
     * 获取含有指定 角色 的所有用户
     * @param roleId：指定角色id
     * @return 返回含有该角色的所有用户
     */
    public List<User> getUsersByRoleId( String roleId){
        return userMapper.getUsersByRoleId(roleId,null, null, null);
    }

    /**
     * 分页获取含有指定 角色 的所有用户
     * @param roleId 指定角色id
     * @param currentPage：当前页
     * @param rows：每页要显示的数据条数
     * @param searchContent：模糊查询内容
     * @return 返回含有该角色的所有用户，支持分页与模糊查询
     */
    @Override
    public List<User> getUsersByRoleId(String roleId, Integer currentPage, Integer rows, String searchContent) {
        FindException findException;
        if (StringUtil.isEmpty(roleId)){
            return null;
        }

        if (currentPage != null && rows != null) {
            if (currentPage < 0 || rows < 0) {
                findException = new FindException("分页查询不能的页数或查询数量小于0");
                throw findException;
            } else {
                Integer start = (currentPage - 1) * rows;   //计算当前页的数据是从第几条开始查询
                return userMapper.getUsersByRoleId(roleId,start, rows, searchContent);
            }
        } else {
            return userMapper.getUsersByRoleId(roleId,null, null, searchContent);
        }
    }

    /**
     * 添加/注册
     *
     * @param user：注册对象信息
     * @return 返回操作成功的数量，0表示操作失败
     * @Transactional 添加事务：保证用户账号密码与用户信息同时生成，只要其中一个失败便回滚
     */
    @Transactional
    @Override
    public Integer register(@Validated(value = {TC_Add.class}) User user) {
        Integer result;     //注册结果状态
        RegisterException registerException;    //注册异常

        if (user == null) {
            registerException = new RegisterException("注册失败，注册对象的信息不能为空");
            LogUtil.warn(this, "用户注册", "注册失败，注册对象的信息为空，可能存在【系统漏洞】！");
            throw registerException;
        }
        String username = user.getUsername();
        if (StringUtil.isEmpty(username)) {
            registerException = new RegisterException("注册失败，账号不能为空");
            LogUtil.warn(this, "用户注册", "注册失败，注册对象的账号为空，效验规则没有起到应有的作用！");
            throw registerException;
        }

        if (checkUsername(username)) {
            registerException = new RegisterException("注册失败，用户名已被使用");
            throw registerException;
        }

        //日志记录
        LogUtil.info(this, "用户注册", "添加用户：【" + username + "】登录信息");
        //1、添加登录信息
        result = userMapper.add(user);
        if (result == 0) {
            registerException = new RegisterException("注册失败，请重试");
            //日志记录
            LogUtil.warn(this, "用户注册", "未知原因，添加用户：【" + username + "】的登录信息【失败】！");
            throw registerException;
        }

        //2、设置用户基本信息：id、账号等默认信息
        UserInfo userInfo = new UserInfo();
        userInfo.setId(UUID.randomUUID().toString());
        userInfo.setUsername(username);
        userInfo.setNickname(username); //昵称默认为username
        userInfo.setGender(1);  //性别默认为男

        //日志记录
        LogUtil.info(this, "用户注册", "添加用户：【" + username + "】的基本信息");

        result = userInfoMapper.add(userInfo);
        if (result == 0) {
            registerException = new RegisterException("注册失败，请重试");
            //日志记录
            LogUtil.warn(this, "用户注册", "未知原因，添加用户：【" + username + "】的基本信息【失败】！");
            throw registerException;
        }

        //3、给用户授默认的用户权限
        Role role = roleMapper.getRoleByName("USER");
        if (role == null) {
            registerException = new RegisterException("注册失败，请重试");

            LogUtil.warn(this, "用户注册", "获取【USER】权限【失败】，数据库中可能缺失USER权限！");
            throw registerException;
        }

        UserRole userRole = new UserRole();
        userRole.setId(UUID.randomUUID().toString());
        userRole.setUserId(user.getId());
        userRole.setRoleId(role.getId());

        //日志记录
        LogUtil.info(this, "用户注册", "给用户：【" + username + "】授USER权限");

        result = userRoleMapper.add(userRole);
        if (result == 0) {
            registerException = new RegisterException("注册失败，请重试");

            //日志记录
            LogUtil.warn(this, "用户注册", "未知原因，给用户：【" + username + "】授USER权限【失败】");
            throw registerException;
        }
        return result;
    }

    /**
     * 更新
     *
     * @param user：要修改的对象
     * @return 返回操作成功的数量，返回0表示操作失败
     */
    @Override
    public Integer update(@Validated(value = {TC_Update.class}) User user) throws UpdateException {
        UpdateException updateException;
        String username = SysResourcesUtils.getCurrentUsername(); //当前登录用户

        if (user == null) {
            updateException = new UpdateException("更新失败，用户不存在或已被删除");
            LogUtil.warn(this, "用户登录信息更新", "用户：【" + username + "】更新登录信息失败，用户不存在或已被删除，数据效验没有起到应有的作用");
            throw updateException;
        }

        //日志记录
        LogUtil.info(this, "用户登录信息更新", "用户：【" + username + "】更新了==》用户：【" + user.getUsername() + "】的登录信息");
        Integer res = userMapper.update(user);
        if (res == 0) {
            updateException = new UpdateException("更新失败，请重试");
            //日志记录
            LogUtil.warn(this, "未知原因，用户登录信息更新", "用户：【" + username + "】更新==》用户：【" + user.getUsername() + "】登录信息【失败】");
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
        String currentUsername = SysResourcesUtils.getCurrentUsername();//当前登录用户

        if (StringUtil.isEmpty(id)) {
            deleteException = new DeleteException("删除失败，删除对象id不能为空");
            throw deleteException;
        }
        User user = this.getUserById(id);
        if (user == null) {
            deleteException = new DeleteException("删除失败，删除对象不存在或已被删除");
            throw deleteException;
        }

        LogUtil.info(this, "用户注销", "用户【" + currentUsername + "】注销了==》用户：【" + user.getUsername() + "】的登录信息");
        //对用户执行软删除
        user.setState(-1);  //使其使用状态变为“已注销”
        Integer result = this.update(user);
        if (result == 0) {
            deleteException = new DeleteException("删除失败，删除对象不存在或已被删除");
            LogUtil.warn(this, "用户注销", "未知原因，用户：【" + user.getUsername() + "】注销失败！");
            throw deleteException;
        }
        return result;
    }

    /**
     * 批量删除
     *
     * @param ids：需要删除的对象的id集
     * @return 返回操作结果（1：删除成功，0：删除失败）
     * 添加事务，保证中间删除失败时可以回滚
     */
    @Override
    @Transactional
    public Integer batchDelete(String ids) throws FindException, DeleteException {
        if (StringUtil.isEmpty(ids))
            return 0;

        //获取当前登录用户
        String currentUsername = SysResourcesUtils.getCurrentUsername();
        LogUtil.info(this, "用户批量删除", "用户：【" + currentUsername + "】正在批量删除IDS为：【" + ids + "】的用户");

        String[] arr = ids.split(",");  //分割成数组
        for (String id : arr) {
            Integer res = this.delete(id);
            if (res == 0) {
                return 0;
            }
        }
        return 1;
    }

    /**
     * 加载用户信息，security用
     *
     * @param username：用户名
     * @return 返回授权后的用户登录信息对象
     * @throws UsernameNotFoundException
     */
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        UsernameNotFoundException exception;
        User user;

        if (StringUtil.isNotEmpty(username)) {
            user = this.getUserByUsername(username);

            if (user == null) {
                exception = new UsernameNotFoundException("用户不存在或已注销");
                LogUtil.info(this, "加载用户权限", "加载失败，用户不存在或已注销");
                throw exception;
            }

            LogUtil.info(this, "加载用户权限", "正在加载用户【" + username + "】的相关权限及用户信息……");
            //获取用户的所有角色
            List<Role> roles = roleMapper.getRolesByUserId(user.getId(), null, null, null);

            //获取该用户所有角色的所有权限
            for (Role role : roles) {
                List<Permission> permissions = permissionMapper.getPermissionsByRoleId(role.getId(), null, null, null);
                //给角色注入权限
                role.setPermissions(permissions);
            }

            //给用户注入角色
            user.setAuthorities(roles);
        } else {
            exception = new UsernameNotFoundException("用户名不存在");
            LogUtil.info(this, "加载用户权限", "加载失败，用户名不存在");
            throw exception;
        }
        return user;
    }

    /**
     * 给用户授角色，添加事务保证授权统一成功或失败
     *
     * @param userId  ：用户登录信息id
     * @param roleIds ：授予的角色id集
     * @return 返回授权成功的个数，0表示授权失败
     */
    @Transactional
    @Override
    public Integer grantRoles(String userId, String roleIds) {
        GrantException grantException;  //授权异常
        DeleteException deleteException; //删除异常
        Integer result = 0;

        //获取当前登录用户
        String currentUsername = SysResourcesUtils.getCurrentUsername();

        if (StringUtil.isEmpty(userId)) {
            grantException = new GrantException("授予失败，请先选择授权对象");
            throw grantException;
        }

        User user = userMapper.getUserById(userId);
        //确保授权对象存在
        if (user == null) {
            grantException = new GrantException("授予失败，用户不存在或已被删除");
            throw grantException;
        }

        LogUtil.info(this,"用户授权","用户：【"+currentUsername+"】在给用户【"+user.getUsername()+"】授权……");

        //授权之前，先回收该用户之前的角色，再重新授予
        List<Role> roles = roleMapper.getRolesByUserId(user.getId(), null, null, null);
        for (Role role : roles) {
            //逐一清除该用户之前的角色
            UserRole userRole = userRoleMapper.getUserRoleByUserIdAndRoleId(user.getId(), role.getId());
            if (userRole == null){
                grantException = new GrantException("授权失败，对象不存在或已被删除");
                throw grantException;
            }
            result = userRoleMapper.delete(userRole.getId());

            //日志记录
            LogUtil.info(this,"用户授权","用户：【"+currentUsername+"】回收了【"+user.getUsername()+"】用户的【"+role.getName()+"】角色……");

            if (result == 0) {
                deleteException = new DeleteException("授权失败，请重试");
                LogUtil.warn(this,"用户角色回收","未知原因：权限存在，但删除失败");
                throw deleteException;
            }
        }

        if (StringUtil.isNotEmpty(roleIds)){
            //逐一授权
            String[] arr = roleIds.split(",");
            for (String roleId : arr) {
                Role role = roleMapper.getRoleById(roleId);
                //确保被授角色存在
                if (role == null) {
                    grantException = new GrantException("授权失败，所授角色不存在或已被删除");
                    throw grantException;
                }

                //授予用户角色
                UserRole userRole = new UserRole();
                userRole.setId(UUID.randomUUID().toString());
                userRole.setUserId(userId);
                userRole.setRoleId(roleId);

                //日志记录
                LogUtil.info(this,"用户授权","用户：【"+currentUsername+"】授予了【"+user.getUsername()+"】用户【"+role.getName()+"】角色……");

                result = userRoleMapper.add(userRole);
                if (result == 0) {
                    grantException = new GrantException("授予用户角色失败，请重试");
                    LogUtil.warn(this,"用户授权","未知原因，给用户：【"+user.getUsername()+"】授角色失败！");
                    throw grantException;
                }
            }
        }
        return result;
    }
}