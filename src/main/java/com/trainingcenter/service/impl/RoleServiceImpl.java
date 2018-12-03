package com.trainingcenter.service.impl;

import com.trainingcenter.bean.*;
import com.trainingcenter.controller.validation.TC_Add;
import com.trainingcenter.controller.validation.TC_Update;
import com.trainingcenter.dao.*;
import com.trainingcenter.exception.DeleteException;
import com.trainingcenter.exception.GrantException;
import com.trainingcenter.exception.InsertException;
import com.trainingcenter.service.RoleService;
import com.trainingcenter.utils.LogUtil;
import com.trainingcenter.utils.StringUtil;
import com.trainingcenter.utils.SysResourcesUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.annotation.Validated;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/31
 * Time: 14:39
 */
@Service("roleService")
public class RoleServiceImpl implements RoleService {
    @Qualifier("roleMapper")
    @Autowired
    private RoleMapper roleMapper;
    @Qualifier("permissionMapper")
    @Autowired
    private PermissionMapper permissionMapper;
    @Qualifier("rolePermissionMapper")
    @Autowired
    private RolePermissionMapper rolePermissionMapper;
    @Qualifier("userMapper")
    @Autowired
    private UserMapper userMapper;
    @Qualifier("userRoleMapper")
    @Autowired
    private UserRoleMapper userRoleMapper;

    /**
     * 通过id获取角色
     *
     * @param id：角色id
     * @return 返回对应的角色对象
     */
    @Override
    public Role getRoleById(String id) {
        return StringUtil.isEmpty(id) ? null : roleMapper.getRoleById(id);
    }

    /**
     * 通过角色名称获取角色
     *
     * @param name：角色名称
     * @return 返回对应的角色对象
     */
    @Override
    public Role getRoleByName(String name) {
        return StringUtil.isEmpty(name) ? null : roleMapper.getRoleByName(name);
    }

    /**
     * 获取所有用户，不分页
     * @param condition：自定义查询条件，模糊查询的 key 固定为 searchContent
     */
    public List<Role> getRoles(Map<String,Object> condition) {
        return getRoles(null, null, condition);
    }

    /**
     * 分页获取所有用户
     *
     * @param currentPage：当前页
     * @param rows：每页要显示的数据条数
     * @param condition：自定义查询条件，模糊查询的 key 固定为 searchContent
     * @return 返回当前页的数据集合
     */
    @Override
    public List<Role> getRoles(Integer currentPage, Integer rows, Map<String,Object> condition) {
        if (currentPage != null && rows != null) {
            if (currentPage < 0 || rows < 0) {
                return null;
            } else {
                Integer start = (currentPage - 1) * rows;   //计算当前页的数据是从第几条开始查询
                return roleMapper.getRoles(start, rows, condition);
            }
        } else {
            return roleMapper.getRoles(null, null, condition);
        }
    }

    /**
     * 获取指定登录用户所含有的全部角色
     *
     * @param loginInfoId 用户登录信息id
     * @return 返回该用户所拥有的所有角色
     */
    public List<Role> getRolesByUserId(String loginInfoId) {
        return getRolesByUserId(loginInfoId, null, null, null);
    }

    /**
     * 获取指定登录用户所含有的全部角色
     *
     * @param userId：用户登录信息id
     * @param currentPage：当前页
     * @param rows：每页要显示的数据条数
     * @param searchContent：模糊查询内容
     * @return 返回该用户所拥有的所有角色，支持分页、模糊查询
     */
    @Override
    public List<Role> getRolesByUserId(String userId, Integer currentPage, Integer rows, String searchContent) {
        if (StringUtil.isEmpty(userId)) {
            return null;
        }
        if (currentPage != null && rows != null) {
            if (currentPage < 0 || rows < 0) {
                return null;
            } else {
                Integer start = (currentPage - 1) * rows;   //计算当前页的数据是从第几条开始查询
                return roleMapper.getRolesByUserId(userId, start, rows, searchContent);
            }
        } else {
            return roleMapper.getRolesByUserId(userId, null, null, searchContent);
        }
    }

    /**
     * 获取含有指定权限的所有角色
     *
     * @param permissionId ：指定权限id
     * @return 返回含有该权限的所有角色
     */
    public List<Role> getRolesByPermissionId(String permissionId) {
        return getRolesByPermissionId(permissionId, null, null, null);
    }

    /**
     * 获取含有指定权限的所有角色
     *
     * @param permissionId         ：指定权限id
     * @param currentPage：当前页
     * @param rows：每页要显示的数据条数
     * @param searchContent：模糊查询内容
     * @return ：返回含有该权限的所有角色，支持分页
     */
    @Override
    public List<Role> getRolesByPermissionId(String permissionId, Integer currentPage, Integer rows, String searchContent) {
        if (StringUtil.isEmpty(permissionId)) {
            return null;
        }
        if (currentPage != null && rows != null) {
            if (currentPage < 0 || rows < 0) {
                return null;
            } else {
                Integer start = (currentPage - 1) * rows;   //计算当前页的数据是从第几条开始查询
                return roleMapper.getRolesByPermissionId(permissionId, start, rows, searchContent);
            }
        } else {
            return roleMapper.getRolesByPermissionId(permissionId, null, null, searchContent);
        }
    }

    /**
     * 角色添加方法
     *
     * @param role：要添加的角色
     * @return 返回操作成功的个数，0表示操作失败
     */
    @Override
    public Integer add(@Validated(value = {TC_Add.class}) Role role) throws InsertException {
        if (role == null)
            return 0;

        Role checkName = this.getRoleByName(role.getName());
        if (checkName != null)
            throw new InsertException("角色名已存在");

        return roleMapper.add(role);
    }

    /**
     * 用户更新方法
     *
     * @param role：用户对象
     * @return 返回值大于0表示操作成功，否则操作失败
     */
    @Override
    public Integer update(@Validated(value = {TC_Update.class}) Role role) {
        return role == null ? 0 : roleMapper.update(role);
    }

    /**
     * 角色删除方法，级联删除其关联信息
     *
     * @param id：角色id
     * @return 返回值大于0表示操作成功，否则操作失败
     * <p>
     * 添加事务，保证中间删除失败时可以回滚
     */
    @Transactional
    @Override
    public Integer delete(String id) throws DeleteException {
        DeleteException deleteException;
        String currentUsername = SysResourcesUtils.getCurrentUsername();

        if (StringUtil.isEmpty(id)) {
            deleteException = new DeleteException("删除失败，请先选择对象");
            throw deleteException;
        }
        Role role = this.getRoleById(id);
        //确保要删除的对象存在
        if (role == null) {
            deleteException = new DeleteException("删除失败，对象不存在或已被删除");
            throw deleteException;
        }

        LogUtil.info(this, "角色删除", "用户：【" + currentUsername + "】在删除角色【" + role.getName() + "】的相关信息");

        Integer result; //操作结果
        //删除角色前，先删除该角色已被授权的所有授权信息
        //1、先删除该角色所含的所有权限信息
        List<RolePermission> rolePermissions = rolePermissionMapper.getRolePermissionByRoleId(role.getId());
        for (RolePermission rp : rolePermissions) {
            if (rp == null) {
                deleteException = new DeleteException("删除失败，对象不存在或已被删除");
                throw deleteException;
            }
            Permission permission = permissionMapper.getPermissionById(rp.getPermissionId());
            LogUtil.info(this, "权限回收", "用户：【" + currentUsername + "】回收了角色【" + role.getName() + "】的【" + permission.getName() + "】权限");

            result = rolePermissionMapper.delete(rp.getId());
            if (result == 0){
                deleteException = new DeleteException("删除失败，请重试");
                LogUtil.warn(this, "权限回收", "未知错误：对象存在却删除失败！");
                throw deleteException;
            }
        }

        //2、删除该角色被授予给用户的所有相关信息
        List<UserRole> userRoles = userRoleMapper.getUserRoleByRoleId(role.getId());
        for (UserRole up:userRoles) {
            if (up == null){
                deleteException = new DeleteException("删除失败，对象不存在或已被删除");
                throw deleteException;
            }
            User user = userMapper.getUserById(up.getUserId());
            LogUtil.info(this, "角色回收", "用户：【" + currentUsername + "】回收了用户【" + user.getUsername() + "】的【" + role.getName() + "】角色");

            result = userRoleMapper.delete(up.getId());
            if (result == 0){
                deleteException = new DeleteException("删除失败，请重试");
                LogUtil.warn(this, "角色回收", "未知错误：对象存在却删除失败！");
                throw deleteException;
            }
        }

        //3、再删除该角色的信息
        result = roleMapper.delete(id);
        if (result == 0) {
            deleteException = new DeleteException("删除失败，请重试");
            LogUtil.warn(this, "角色删除", "未知错误：对象存在却删除失败！");
            throw deleteException;
        }

        return result;
    }

    /**
     * 批量删除
     *
     * @param ids：需要删除的对象的id集
     * @return 返回操作结果（true：删除成功，false：删除失败）
     * 添加事务，保证中间删除失败时可以回滚
     */
    @Override
    @Transactional
    public Integer batchDelete(String ids) {
        if (StringUtil.isEmpty(ids))
            return 0;

        //获取当前登录用户
        String currentUsername = SysResourcesUtils.getCurrentUsername();
        if (currentUsername == null) {
            throw new CredentialsExpiredException("登录凭证已过期");
        }
        LogUtil.info(this, "角色批量删除", "用户：【" + currentUsername + "】正在批量删除IDS为：【" + ids + "】的角色");

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
     * 给角色授权，添加事务保证授权统一成功或失败
     *
     * @param roleId ：角色id
     * @param newPermissionIds ：授予的新权限id集
     * @return 返回授权成功的个数，0表示授权失败
     */
    @Override
    @Transactional
    public Integer grantPermission(String roleId, String newPermissionIds) {
        GrantException grantException;  //授权失败异常
        Integer result = 0;     //授权结果
        if (StringUtil.isEmpty(roleId)) {
            grantException = new GrantException("授权失败，请先选择授权对象");
            throw grantException;
        }

        //被授权的角色
        Role role = roleMapper.getRoleById(roleId);
        if (role == null) {
            grantException = new GrantException("授权失败，角色不存在或已被删除");
            throw grantException;
        }

        //获取当前登录用户
        String currentUsername = SysResourcesUtils.getCurrentUsername();
        if (currentUsername == null) {
            throw new CredentialsExpiredException("登录凭证已过期");
        }

        LogUtil.info(this, "角色授权", "用户：【" + currentUsername + "】正在给【" + role.getId() + "】授权……");

        //先回收该角色之前的所有权限，再逐一授权
        //1、获取该角色的所有旧权限
        List<Permission> oldPermissions = permissionMapper.getPermissionsByRoleId(role.getId(),null, null, null);

        //2、判断授予的新权限是否为空，为空便取消当前角色的所有权限信息
        if (StringUtil.isEmpty(newPermissionIds)){
            //遍历删除当前角色的所有已授权信息
            for (Permission permission : oldPermissions) {
                RolePermission rolePermission = rolePermissionMapper.getRolePermissionByRoleIdAndPermissionId(role.getId(), permission.getId());
                if (rolePermission == null) {
                    grantException = new GrantException("授权失败，对象不存在或已被删除");
                    throw grantException;
                }
                //删除授权对象
                result = rolePermissionMapper.delete(rolePermission.getId());

                //日志记录
                LogUtil.info(this, "角色授权", "用户：【" + currentUsername + "】回收了【" + role.getName() + "】角色的【" + permission.getName() + "】授权……");

                if (result == 0) {
                    grantException = new GrantException("授权失败，请稍后重试");
                    LogUtil.warn(this, "角色权限回收", "未知原因：权限存在，但删除失败");
                    throw grantException;
                }
            }
        }else {
            //3新授予权限不为空时，需判断是删除部分权限还是新增部分权限

            //(1)、遍历旧权限，取出旧权限id，组成Set
            Set<String> oldPermissionSet = Collections.synchronizedSet(new HashSet<>());
            for (Permission permission : oldPermissions) {
                oldPermissionSet.add(permission.getId());
            }

            //(2)、将新权限ids组装成Set
            Set<String> newPermissionSet = Collections.synchronizedSet(new HashSet<>());
            String[] idArr = newPermissionIds.split(",");
            newPermissionSet.addAll(Arrays.asList(idArr));

            //(3)、遍历旧权限，取出不在新授权集合中的权限进行删除
            for (String oldId:oldPermissionSet) {
                if (!newPermissionSet.contains(oldId)){
                    //确保对应权限存在
                    Permission permission = permissionMapper.getPermissionById(oldId);
                    if (permission != null){
                        RolePermission rolePermission = rolePermissionMapper.getRolePermissionByRoleIdAndPermissionId(roleId, permission.getId());
                        //确保删除的权限存在
                        if (rolePermission != null){
                            //日志记录
                            LogUtil.info(this, "角色授权", "用户：【" + currentUsername + "】回收了【" + role.getName() + "】角色的【" + permission.getName() + "】授权……");
                            result = rolePermissionMapper.delete(rolePermission.getId());

                            if (result == 0){
                                grantException = new GrantException("授权失败，请重试");
                                LogUtil.warn(this, "角色授权", "未知原因，给用户：【" + role.getName() + "】授权失败！");
                                throw grantException;
                            }
                        }
                    }
                }
            }

            //（4）、取出当前角色在删除了相关权限后的所有权限
            List<Permission> tempPermissions = permissionMapper.getPermissionsByRoleId(roleId, null, null, null);

            //当前角色在权限删除后，新权限授权前的所有权限id
            Set<String> tempPermissionIds = Collections.synchronizedSet(new HashSet<>());
            for (Permission temp :tempPermissions) {
                tempPermissionIds.add(temp.getId());
            }

            //(5)、遍历新权限，对需要新增的权限进行授权
            for (String newId :newPermissionSet) {
                if (!tempPermissionIds.contains(newId)){

                    Permission permission = permissionMapper.getPermissionById(newId);
                    //确保授予的权限存在
                    if (permission != null){
                        RolePermission rolePermission = new RolePermission();
                        rolePermission.setId(UUID.randomUUID().toString());
                        rolePermission.setRoleId(roleId);
                        rolePermission.setPermissionId(newId);

                        //日志记录
                        LogUtil.info(this, "角色授权", "用户：【" + currentUsername + "】授予了【" + role.getName() + "】角色【" + permission.getName() + "】权限……");

                        //新增授权
                        result = rolePermissionMapper.add(rolePermission);

                        if (result == 0) {
                            grantException = new GrantException("授权失败，请重试");
                            LogUtil.warn(this, "角色授权", "未知原因，给用户：【" + role.getName() + "】授权失败！");
                            throw grantException;
                        }
                    }
                }
            }
        }
        return result;
    }
}
