package com.trainingcenter.service.impl;

import com.trainingcenter.bean.Permission;
import com.trainingcenter.bean.Role;
import com.trainingcenter.bean.RolePermission;
import com.trainingcenter.controller.validation.TC_Add;
import com.trainingcenter.dao.PermissionMapper;
import com.trainingcenter.dao.RoleMapper;
import com.trainingcenter.dao.RolePermissionMapper;
import com.trainingcenter.exception.DeleteException;
import com.trainingcenter.exception.FindException;
import com.trainingcenter.exception.InsertException;
import com.trainingcenter.exception.UpdateException;
import com.trainingcenter.service.PermissionService;
import com.trainingcenter.utils.LogUtil;
import com.trainingcenter.utils.StringUtil;
import com.trainingcenter.utils.SysResourcesUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.annotation.Validated;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/11/12
 * Time: 17:19
 */
@Service("permissionService")
public class PermissionServiceImpl implements PermissionService {
    @Qualifier("permissionMapper")
    @Autowired
    private PermissionMapper permissionMapper;
    @Qualifier("roleMapper")
    @Autowired
    private RoleMapper roleMapper;
    @Qualifier("rolePermissionMapper")
    @Autowired
    private RolePermissionMapper rolePermissionMapper;

    /**
     * 通过id获取权限
     *
     * @param id：权限id
     * @return 返回对应的权限对象
     */
    @Override
    public Permission getPermissionById(String id) {
        return StringUtil.isEmpty(id) ? null : permissionMapper.getPermissionById(id);
    }

    /**
     * @return 返回权限对象集合
     */
    public List<Permission> getPermissions() {
        return getPermissions(null, null, null);
    }

    /**
     * @param currentPage：当前页
     * @param rows：每页要显示的数据条数
     * @param searchContent：模糊查询内容
     * @return 返回权限对象集合
     */
    @Override
    public List<Permission> getPermissions(Integer currentPage, Integer rows, String searchContent) {
        FindException findException;

        if (currentPage != null && rows != null) {
            if (currentPage < 0 || rows < 0) {
                findException = new FindException("分页查询不能的页数或查询数量小于0");
                LogUtil.info(this, "查询权限信息", "查询失败，分页查询的页数或查询数量小于0");
                throw findException;
            }
            Integer start = (currentPage - 1) * rows;   //计算当前页的数据是从第几条开始查询
            return permissionMapper.getPermissions(start, rows, searchContent);
        }else {
            return permissionMapper.getPermissions(null, null, searchContent);
        }
    }

    /**
     * 通过id 获取指定 角色 所含有的全部权限
     *
     * @param roleId 角色id
     * @return
     */
    @Override
    public List<Permission> getPermissionsByRoleId(String roleId) {
        return getPermissionsByRoleId(roleId,null,null,null);
    }

    /**
     * 通过id 获取指定 角色 所含有的全部权限
     *
     * @param roleId：角色id
     * @param currentPage：当前页
     * @param rows：每页要显示的数据条数
     * @param searchContent：模糊查询内容
     * @return 返回该角色所拥有的所有权限，支持分页、模糊查询
     */
    @Override
    public List<Permission> getPermissionsByRoleId(String roleId, Integer currentPage, Integer rows, String searchContent) {
        FindException findException;

        if (StringUtil.isEmpty(roleId)){
            return null;
        }

        if (currentPage != null && rows != null) {
            if (currentPage < 0 || rows < 0) {
                findException = new FindException("分页查询不能的页数或查询数量小于0");
                LogUtil.info(this, "查询角色的权限信息", "查询失败，分页查询的页数或查询数量小于0");
                throw findException;
            }
            Integer start = (currentPage - 1) * rows;   //计算当前页的数据是从第几条开始查询
            return permissionMapper.getPermissionsByRoleId(roleId,start, rows, searchContent);
        }else {
            return permissionMapper.getPermissionsByRoleId(roleId,null, null, searchContent);
        }
    }

    /**
     * 通过 角色名称 获取指定 角色 所含有的全部权限
     * @param roleName 角色名称
     * @return
     */
    public List<Permission> getPermissionsByRoleName( String roleName){
        return getPermissionsByRoleName(roleName,null,null,null);
    }

    /**
     * 通过 角色名称 获取指定 角色 所含有的全部权限
     *
     * @param roleName：角色名称
     * @param currentPage：当前页
     * @param rows：每页要显示的数据条数
     * @param searchContent：模糊查询内容
     * @return 返回该角色所拥有的所有权限，支持分页、模糊查询
     */
    @Override
    public List<Permission> getPermissionsByRoleName(String roleName, Integer currentPage, Integer rows, String searchContent) {

        if (StringUtil.isEmpty(roleName)) {
            return null;
        }
        Role role = roleMapper.getRoleByName(roleName);
        if (role == null) {
            return null;
        }
        return this.getPermissionsByRoleId(role.getId(),currentPage,rows,searchContent);
    }

    /**
     * 权限添加方法
     *
     * @param permission：要添加的权限
     * @return 返回操作成功的个数，0表示操作失败
     */
    @Override
    public Integer add(@Validated(value = {TC_Add.class}) Permission permission) {
        InsertException insertException; //添加异常
        String currentUsername = SysResourcesUtils.getCurrentUsername();    //当前登录用户的用户名
        if (permission == null) {
            insertException = new InsertException("添加失败，添加对象不能为空");
            LogUtil.warn(this, "权限添加", "用户【" + currentUsername + "】添加权限【失败】，添加对象为空，数据效验没起到应有的作用！");
            throw insertException;
        }
        //日志记录
        LogUtil.info(this, "权限添加", "用户【" + currentUsername + "】添加了==>权限：【" + permission.getName() + "】的相关信息");

        Integer res = permissionMapper.add(permission);
        if (res == 0) {
            insertException = new InsertException("添加失败，请重试");
            LogUtil.warn(this, "权限添加", "未知原因，用户【" + currentUsername + "】添加权限：【" + permission.getName() + "】【失败】！");
            throw insertException;
        }

        return res;
    }

    /**
     * 权限更新方法
     *
     * @param permission: 要更新的权限
     * @return 返回操作成功的个数，0表示操作失败
     */
    @Override
    public Integer update(Permission permission) {
        UpdateException updateException;  //更新异常
        String currentUsername = SysResourcesUtils.getCurrentUsername();    //当前登录用户的用户名

        if (permission == null) {
            updateException = new UpdateException("更新失败，更新对象不能为空");
            LogUtil.warn(this, "权限更新", "用户【" + currentUsername + "】更新权限【失败】，更新对象为空，数据效验没起到应有的作用！");
            throw updateException;
        }

        if (StringUtil.isEmpty(permission.getId()) || permissionMapper.getPermissionById(permission.getId()) == null){
            updateException = new UpdateException("更新失败，对象不存在或已被删除");
            LogUtil.warn(this, "权限更新", "用户【" + currentUsername + "】更新权限【失败】，更新对象为空，数据效验没起到应有的作用！");
            throw updateException;
        }

        //日志记录
        LogUtil.info(this, "权限更新", "用户【" + currentUsername + "】更新了==>权限：【" + permission.getName() + "】的相关信息");

        Integer res = permissionMapper.update(permission);
        if (res == 0) {
            updateException = new UpdateException("更新失败，请重试");
            LogUtil.info(this, "权限更新", "未知原因，用户【" + currentUsername + "】更新权限：【" + permission.getName() + "】【失败】！");
            throw updateException;
        }
        return res;
    }

    /**
     * 权限删除方法，级联删除其关联的所有信息
     *
     * @param id：权限id
     * @return 返回操作成功的个数，0表示操作失败
     */
    @Transactional
    @Override
    public Integer delete(String id) {
        DeleteException deleteException; //删除异常
        String currentUsername = SysResourcesUtils.getCurrentUsername();    //当前登录用户的用户名

        if (StringUtil.isEmpty(id)) {
            deleteException = new DeleteException("删除失败，删除对象不能为空");
            throw deleteException;
        }

        Permission permission = getPermissionById(id);
        if (permission == null){
            deleteException = new DeleteException("删除失败，对象不存在或已被删除");
            throw deleteException;
        }

        //日志记录
        LogUtil.info(this, "权限删除", "用户【" + currentUsername + "】在删除==>权限：【" + permission.getName() + "】的相关信息");
        Integer result; //操作结果

        //删除权限之前，先删除该权限已被授权的所有授权信息
        //1、获取该权限已被授权的信息
        List<RolePermission> rolePermissions = rolePermissionMapper.getRolePermissionByPermissionId(permission.getId());
        //2、逐一删除这些授权信息
        for (RolePermission rolePermission:rolePermissions) {
            if (rolePermission == null){
                deleteException = new DeleteException("删除失败，对象不存在或已被删除");
                throw deleteException;
            }
            Role role = roleMapper.getRoleById(rolePermission.getRoleId());
            LogUtil.info(this,"权限回收","用户：【"+currentUsername+"】回收了角色【"+role.getName()+"】的【"+permission.getName()+"】权限");

            result = rolePermissionMapper.delete(rolePermission.getId());
            if (result == 0){
                deleteException = new DeleteException("删除失败，请重试");
                LogUtil.warn(this, "权限回收", "未知错误：对象存在却删除失败！");
                throw deleteException;
            }
        }

        //删除该权限的信息
        Integer res = permissionMapper.delete(id);
        if (res == 0) {
            deleteException = new DeleteException("删除失败，请重试");
            LogUtil.warn(this, "权限删除", "未知原因，用户【" + currentUsername + "】删除权限：【" + permission.getName() + "】【失败】");
            throw deleteException;
        }
        return res;
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
    public Integer batchDelete(String ids) {
        if (StringUtil.isEmpty(ids))
            return 0;

        //获取当前登录用户
        String currentUsername = SysResourcesUtils.getCurrentUsername();
        LogUtil.info(this, "权限批量删除", "用户：【" + currentUsername + "】正在批量删除IDS为：【" + ids + "】的权限");

        String[] arr = ids.split(",");  //分割成数组
        for (String id : arr) {
            Integer res = this.delete(id);
            if (res == 0) {
                return 0;
            }
        }
        return 1;
    }
}