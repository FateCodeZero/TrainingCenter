package com.trainingcenter.service.impl;

import com.trainingcenter.bean.Permission;
import com.trainingcenter.bean.Role;
import com.trainingcenter.controller.validation.TC_Add;
import com.trainingcenter.dao.PermissionMapper;
import com.trainingcenter.dao.RoleMapper;
import com.trainingcenter.exception.DeleteException;
import com.trainingcenter.exception.InsertException;
import com.trainingcenter.exception.UpdateException;
import com.trainingcenter.service.PermissionService;
import com.trainingcenter.utils.LogUtil;
import com.trainingcenter.utils.StringUtil;
import com.trainingcenter.utils.SysResourcesUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

import java.util.Collection;
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

    /**
     * 通过id获取权限
     * @param id：权限id
     * @return 返回对应的权限对象
     */
    @Override
    public Permission getPermissionById(String id) {
        return StringUtil.isEmpty(id)?null:permissionMapper.getPermissionById(id);
    }

    /**
     * @param currentPage：当前页
     * @param rows：每页要显示的数据条数
     * @param searchContent：模糊查询内容
     * @return 返回权限对象集合
     */
    @Override
    public List<Permission> getPermissions(Integer currentPage, Integer rows, String searchContent) {
        if (currentPage < 0 || rows < 0) {
            return null;
        }
        Integer start = null;
        if (currentPage != null && rows != null ) {
            if (currentPage < 0 || rows < 0){
                return null;
            }else {
                start = (currentPage - 1) * rows;   //计算当前页的数据是从第几条开始查询
            }
        }
        return permissionMapper.getPermissions(start,rows,searchContent);
    }

    /**
     * 权限添加方法
     * @param permission：要添加的权限
     * @return 返回操作成功的个数，0表示操作失败
     */
    @Override
    public Integer add(@Validated(value = {TC_Add.class}) Permission permission) {
        InsertException insertException; //添加异常
        String currentUsername = SysResourcesUtils.getCurrentUsername();    //当前登录用户的用户名
        if (permission == null){
            insertException = new InsertException("添加失败，添加对象不能为空");
            LogUtil.info(this, "权限添加", "用户【"+ currentUsername+"】添加权限【失败】，添加对象为空");
            throw insertException;
        }
        //日志记录
        LogUtil.info(this, "权限添加", "用户【"+ currentUsername+"】添加了==>权限：【" + permission.getName() + "】的相关信息");

        Integer res = permissionMapper.add(permission);
        if (res == 0){
            insertException = new InsertException("添加失败，请重试");
            LogUtil.info(this, "权限添加", "用户【"+ currentUsername+"】添加权限：【" + permission.getName() + "】【失败】");
            throw insertException;
        }

        return res;
    }

    /**
     * 权限更新方法
     * @param permission: 要更新的权限
     * @return 返回操作成功的个数，0表示操作失败
     */
    @Override
    public Integer update(Permission permission) {
        UpdateException updateException;  //更新异常
        String currentUsername = SysResourcesUtils.getCurrentUsername();    //当前登录用户的用户名

        if (permission == null){
            updateException = new UpdateException("更新失败，更新对象不能为空");
            LogUtil.info(this, "权限更新", "用户【"+ currentUsername +"】更新权限【失败】，更新对象为空");
            throw updateException;
        }
        //日志记录
        LogUtil.info(this, "权限更新", "用户【"+ currentUsername+"】更新了==>权限：【" + permission.getName() + "】的相关信息");

        Integer res = permissionMapper.add(permission);
        if (res == 0){
            updateException = new UpdateException("更新失败，请重试");
            LogUtil.info(this, "权限更新", "用户【"+ currentUsername+"】更新权限：【" + permission.getName() + "】【失败】");
            throw updateException;
        }
        return res;
    }

    /**
     * 权限删除方法
     * @param id：权限id
     * @return 返回操作成功的个数，0表示操作失败
     */
    @Override
    public Integer delete(String id) {
        DeleteException deleteException; //删除异常
        String currentUsername = SysResourcesUtils.getCurrentUsername();    //当前登录用户的用户名

        if (StringUtil.isEmpty(id)){
            deleteException = new DeleteException("删除失败，删除对象不能为空");
            LogUtil.info(this, "权限删除", "用户【"+ currentUsername +"】删除权限【失败】，删除对象为空");
            throw deleteException;
        }

        Permission permission = getPermissionById(id);
        //日志记录
        LogUtil.info(this, "权限删除", "用户【"+ currentUsername+"】删除了==>权限：【" + permission.getName() + "】的相关信息");

        Integer res = permissionMapper.delete(id);
        if (res == 0){
            deleteException = new DeleteException("删除失败，请重试");
            LogUtil.info(this, "权限删除", "用户【"+ currentUsername+"】删除权限：【" + permission.getName() + "】【失败】");
            throw deleteException;
        }
        return res;
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
    public Collection<Permission> getPermissionsByRoleId(String roleId, Integer currentPage, Integer rows, String searchContent) {
        if (StringUtil.isEmpty(roleId)){
            return null;
        }

        Integer start = null;
        if (currentPage != null && rows != null ) {
            if (currentPage < 0 || rows < 0){
                return null;
            }else {
                start = (currentPage - 1) * rows;   //计算当前页的数据是从第几条开始查询
            }
        }

        return permissionMapper.getPermissionsByRoleId(roleId,start,rows,searchContent);
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
    public Collection<Permission> getPermissionsByRoleName(String roleName, Integer currentPage, Integer rows, String searchContent) {

        if (StringUtil.isEmpty(roleName)){
            return null;
        }
        Role role = roleMapper.getRoleByName(roleName);
        if (role == null){
            return null;
        }
        Integer start = null;
        if (currentPage != null && rows != null ) {
            if (currentPage < 0 || rows < 0){
                return null;
            }else {
                start = (currentPage - 1) * rows;   //计算当前页的数据是从第几条开始查询
            }
        }
        return getPermissionsByRoleId(role.getId(),start,rows,searchContent);
    }
}