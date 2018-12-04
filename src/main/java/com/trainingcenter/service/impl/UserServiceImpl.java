package com.trainingcenter.service.impl;

import com.trainingcenter.bean.*;
import com.trainingcenter.controller.validation.TC_Add;
import com.trainingcenter.controller.validation.TC_Update;
import com.trainingcenter.dao.*;
import com.trainingcenter.exception.*;
import com.trainingcenter.service.LockedIPService;
import com.trainingcenter.service.UserService;
import com.trainingcenter.utils.LogUtil;
import com.trainingcenter.utils.StringUtil;
import com.trainingcenter.utils.SysResourcesUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.annotation.Validated;

import java.util.*;
import java.util.List;

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
    @Qualifier("lockedIPService")
    @Autowired
    private LockedIPService lockedIPService;

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
     * 查询所有普通用户
     *@param condition：自定义查询条件，模糊查询的 key 固定为 searchContent
     * @return
     */
    public List<User> getUsers(Map<String,Object> condition) {
        return getUsers(null, null, condition);
    }

    /**
     * 分页查询普通用户
     * @param currentPage：当前页
     * @param rows：每页要显示的数据条数
     * @param condition：自定义查询条件，模糊查询的 key 固定为 searchContent
     * @return 返回当前页的数据集合
     */
    @Override
    public List<User> getUsers(Integer currentPage, Integer rows, Map<String,Object> condition) {
        FindException findException;

        if (currentPage != null && rows != null) {
            if (currentPage < 0 || rows < 0) {
                findException = new FindException("分页查询不能的页数或查询数量小于0");
                LogUtil.info(this, "查询用户登录信息", "查询失败，分页查询不能的页数或查询数量小于0");
                throw findException;
            } else {
                Integer start = (currentPage - 1) * rows;   //计算当前页的数据是从第几条开始查询
                return userMapper.getUsers(start, rows, condition);
            }
        } else {
            return userMapper.getUsers(null, null, condition);
        }
    }

    /**
     * 获取所有管理员数据
     * @param condition：自定义查询条件，模糊查询的 key 固定为 searchContent
     * @return 返回所有数据
     */
    public List<User> getUsersForAdmin(Map<String,Object> condition){
        return getUsersForAdmin(null,null,condition);
    }

    /**
     * 分页查询管理员用户
     * @param currentPage：当前页
     * @param rows：每页要显示的数据条数
     * @param condition：自定义查询条件，模糊查询的 key 固定为 searchContent
     * @return 返回当前页的数据集合
     */
    public List<User> getUsersForAdmin(Integer currentPage, Integer rows, Map<String,Object> condition){
        FindException findException;

        if (currentPage != null && rows != null) {
            if (currentPage < 0 || rows < 0) {
                findException = new FindException("分页查询不能的页数或查询数量小于0");
                LogUtil.info(this, "查询用户登录信息", "查询失败，分页查询不能的页数或查询数量小于0");
                throw findException;
            } else {
                Integer start = (currentPage - 1) * rows;   //计算当前页的数据是从第几条开始查询
                return userMapper.getUsersForAdmin(start, rows, condition);
            }
        } else {
            return userMapper.getUsersForAdmin(null, null, condition);
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

        if (user == null || StringUtil.isEmpty(user.getUsername())) {
            registerException = new RegisterException("注册失败，账号不能为空");
            LogUtil.warn(this, "用户注册", "注册失败，注册对象的账号为空，效验规则没有起到应有的作用！");
            throw registerException;
        }
        String username = user.getUsername();
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
     * 添加管理员
     * @param user：添加的管理员对象
     * @param roleIds：添加管理员时授给该管理员用户的角色
     * @return 返回操作成功的数量，0表示操作失败
     * @Transactional 添加事务：保证用户账号密码与用户信息同时生成，只要其中一个失败便回滚
     */
    @Transactional
    @Override
    public Integer add(@Validated(value = {TC_Add.class}) User user,String roleIds) {
        Integer result;     //注册结果状态
        RegisterException registerException;    //注册异常
        String currentUsername = SysResourcesUtils.getCurrentUsername();

        if (user == null || StringUtil.isEmpty(user.getUsername())) {
            registerException = new RegisterException("添加失败，账号不能为空");
            LogUtil.warn(this, "添加管理员", "添加失败，注册对象的账号为空，效验规则没有起到应有的作用！");
            throw registerException;
        }
        String username = user.getUsername();
        if (checkUsername(username)) {
            registerException = new RegisterException("添加失败，用户名已被使用");
            throw registerException;
        }

        //日志记录
        LogUtil.info(this, "添加管理员", "用户【"+currentUsername+"】正在添加用户：【" + username + "】登录信息……");
        //1、添加登录信息
        result = userMapper.add(user);
        if (result == 0) {
            registerException = new RegisterException("添加失败，请重试");
            //日志记录
            LogUtil.warn(this, "添加管理员", "未知错误，用户【"+currentUsername+"】添加用户：【" + username + "】的登录信息【失败】！");
            throw registerException;
        }

        //2、设置用户基本信息：id、账号等默认信息
        UserInfo userInfo = new UserInfo();
        userInfo.setId(UUID.randomUUID().toString());
        userInfo.setUsername(username);
        userInfo.setNickname(username); //昵称默认为username
        userInfo.setGender(1);  //性别默认为男

        //日志记录
        LogUtil.info(this, "添加管理员", "用户【"+currentUsername+"】正在添加用户：【" + username + "】的基本信息……");

        result = userInfoMapper.add(userInfo);
        if (result == 0) {
            registerException = new RegisterException("添加失败，请重试");
            //日志记录
            LogUtil.warn(this, "添加管理员", "未知错误，用户【"+currentUsername+"】添加用户：【" + username + "】的基本信息【失败】！");
            throw registerException;
        }

        //3、若添加该管理员用户时，授予的权限ids为空，则默认授予它 USER 权限
        if (StringUtil.isEmpty(roleIds)){
            Role role = roleMapper.getRoleByName("USER");
            if (role == null) {
                registerException = new RegisterException("添加失败，请重试");

                LogUtil.warn(this, "添加管理员", "添加失败，获取【USER】角色【失败】，数据库中可能缺失USER角色！");
                throw registerException;
            }
            roleIds = role.getId();
        }

        //4、给添加的管理员用户授权
        String[] idArr = roleIds.trim().split(",");
        for (String id :idArr) {
            Role role = roleMapper.getRoleById(id);
            if (role != null){
                UserRole userRole = new UserRole();
                userRole.setId(UUID.randomUUID().toString());
                userRole.setUserId(user.getId());
                userRole.setRoleId(role.getId());

                //日志记录
                LogUtil.info(this, "添加管理员", "用户【"+currentUsername+"】正在给用户：【" + username + "】授【"+role.getName()+"】权限……");

                result = userRoleMapper.add(userRole);
                if (result == 0) {
                    registerException = new RegisterException("添加管理员失败，请重试");
                    //日志记录
                    LogUtil.warn(this, "添加管理员", "未知原因，用户【"+currentUsername+"】给用户：【" + username + "】授【"+role.getName()+"】权限【失败】");
                    throw registerException;
                }
            }
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

            //判断用户IP是否被锁定
            List<LockedIP> lockedIPs = lockedIPService.getLockedIPs(null);
            Set<String> ips = Collections.synchronizedSet(new HashSet<>());
            for (LockedIP lockedIP:lockedIPs) {
                ips.add(lockedIP.getIP());
            }
            if (ips.contains(user.getLoginIP())){
                if (user.getUnlockedFlag() == 1){
                    user.setUnlockedFlag(0);
                    update(user);
                }
            }else {
                if (user.getUnlockedFlag() == 0){
                    user.setUnlockedFlag(1);
                    update(user);
                }
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
        Integer result = 0;  //授权结果

        //获取当前登录用户
        String currentUsername = SysResourcesUtils.getCurrentUsername();
        if (currentUsername == null) {
            throw new CredentialsExpiredException("登录凭证已过期");
        }

        if (StringUtil.isEmpty(userId)) {
            grantException = new GrantException("授权保存失败，请先选择授权对象");
            throw grantException;
        }

        User user = userMapper.getUserById(userId);
        //确保授权对象存在
        if (user == null) {
            grantException = new GrantException("授权保存失败，被授权用户不存在或已被删除");
            throw grantException;
        }

        LogUtil.info(this,"用户授权","用户：【"+currentUsername+"】在给用户【"+user.getUsername()+"】授权……");

        //获取当前用户的所有角色
        List<Role> roles = roleMapper.getRolesByUserId(user.getId(), null, null, null);
        //遍历当前用户所拥有的角色，组装成旧角色IDS
        Set<String> oldRoleIds = Collections.synchronizedSet(new HashSet<>());
        for (Role role : roles) {
            oldRoleIds.add(role.getId());
        }

        //若授权的角色IDS为空，则表示回收该用户的所有已授权角色
        if (StringUtil.isEmpty(roleIds)){
            for (String roleId : oldRoleIds) {
                UserRole userRole = userRoleMapper.getUserRoleByUserIdAndRoleId(userId,roleId);
                //删除授权信息
                if (userRole != null){
                    result = userRoleMapper.delete(userRole.getId());

                    if (result == 0){
                        grantException = new GrantException("授权保存失败，请重试");
                        LogUtil.warn(this,"用户角色回收","未知原因：角色存在，但删除失败");
                        throw grantException;
                    }
                }
            }
        }else {
            //若授权的角色IDS不为空，需要做判断是新增角色授权还是回收角色授权

            //组装当前要授权的角色新IDS
            String[] idArr = roleIds.trim().split(",");
            Set<String> newRoleIds = Collections.synchronizedSet(new HashSet<>());
            for (String id : idArr) {
                //保证要授权的角色存在
                Role role = roleMapper.getRoleById(id);
                if (role != null){
                    newRoleIds.add(role.getId());
                }
            }

            //遍历旧角色IDS，删除掉不存在于新角色IDS集合中的角色（不能存在表示该角色已经被取消授权）
            for (String roleId :oldRoleIds) {
                if (!newRoleIds.contains(roleId)){
                    UserRole userRole = userRoleMapper.getUserRoleByUserIdAndRoleId(userId, roleId);
                    if (userRole != null){
                        result = userRoleMapper.delete(userRole.getId());

                        if (result == 0){
                            grantException = new GrantException("授权保存失败，请重试");
                            LogUtil.warn(this,"用户角色回收","未知原因：角色存在，但删除失败");
                            throw grantException;
                        }
                    }
                }
            }
            //取出当前用户经过之前删除后的所有角色对象
            List<Role> tempRoles = roleMapper.getRolesByUserId(userId, null, null, null);
            //遍历这些中间角色，组成中间角色IDS
            Set<String> tempRoleIds = Collections.synchronizedSet(new HashSet<>());
            for (Role tempRole :tempRoles) {
                tempRoleIds.add(tempRole.getId());
            }

            //遍历新授权角色IDS集合，将不存在于中间角色IDS中的角色进行新增授权
            for (String newRoleId :newRoleIds) {
                if (!tempRoleIds.contains(newRoleId)){
                    Role newRole = roleMapper.getRoleById(newRoleId);
                    //确保被授权角色存在
                    if (newRole == null){
                        grantException = new GrantException("授权保存失败，授予的角色不存在或已被删除");
                        throw grantException;
                    }
                    UserRole userRole = new UserRole();
                    userRole.setId(UUID.randomUUID().toString());
                    userRole.setUserId(userId);
                    userRole.setRoleId(newRole.getId());

                    //日志记录
                    LogUtil.info(this,"用户授权","用户：【"+currentUsername+"】授予了【"+user.getUsername()+"】用户【"+newRole.getName()+"】角色……");

                    //执行授权
                    result = userRoleMapper.add(userRole);

                    if (result == 0){
                        grantException = new GrantException("授权保存失败，请重试");
                        LogUtil.warn(this,"用户授权","未知原因，给用户：【"+user.getUsername()+"】授予【"+newRole.getName()+"】角色时失败！");
                        throw grantException;
                    }
                }
            }
        }

        return result;
    }
}