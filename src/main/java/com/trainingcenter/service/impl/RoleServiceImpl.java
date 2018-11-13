package com.trainingcenter.service.impl;

import com.trainingcenter.bean.LoginInfo;
import com.trainingcenter.bean.Permission;
import com.trainingcenter.bean.Role;
import com.trainingcenter.bean.RolePermission;
import com.trainingcenter.controller.validation.TC_Add;
import com.trainingcenter.controller.validation.TC_Update;
import com.trainingcenter.dao.LoginInfoMapper;
import com.trainingcenter.dao.PermissionMapper;
import com.trainingcenter.dao.RoleMapper;
import com.trainingcenter.dao.RolePermissionMapper;
import com.trainingcenter.exception.DeleteException;
import com.trainingcenter.exception.GrantException;
import com.trainingcenter.exception.InsertException;
import com.trainingcenter.service.RoleService;
import com.trainingcenter.utils.StringUtil;
import com.trainingcenter.utils.SysResourcesUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.annotation.Validated;

import javax.validation.Valid;
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
    @Qualifier("loginInfoMapper")
    @Autowired
    private LoginInfoMapper loginInfoMapper;

    /**
     * 通过id获取角色
     * @param id：角色id
     * @return 返回对应的角色对象
     */
    @Override
    public Role getRoleById(String id) {
        return StringUtil.isEmpty(id)?null:roleMapper.getRoleById(id);
    }

    /**
     * 通过角色名称获取角色
     * @param name：角色名称
     * @return 返回对应的角色对象
     */
    @Override
    public Role getRoleByName(String name) {
        return StringUtil.isEmpty(name)?null:roleMapper.getRoleByName(name);
    }

    /**
     * 分页获取所有用户
     *
     * @param currentPage：当前页
     * @param rows：每页要显示的数据条数
     * @param searchContent：模糊查询内容
     * @return 返回当前页的数据集合
     */
    @Override
    public Collection<Role> getRoles(Integer currentPage, Integer rows, String searchContent) {
        Integer start = null;
        if (currentPage != null && rows != null ) {
            if (currentPage < 0 || rows < 0){
                return null;
            }else {
                start = (currentPage - 1) * rows;   //计算当前页的数据是从第几条开始查询
            }
        }
        return roleMapper.getRoles(start, rows, searchContent);
    }

    /**
     * 获取指定登录用户所含有的全部角色
     *
     * @param loginInfoId：用户登录信息id
     * @param currentPage：当前页
     * @param rows：每页要显示的数据条数
     * @param searchContent：模糊查询内容
     * @return 返回该用户所拥有的所有角色，支持分页、模糊查询
     */
    @Override
    public Collection<Role> getRolesByLoginInfoId(String loginInfoId, Integer currentPage, Integer rows, String searchContent) {
        if (StringUtil.isEmpty(loginInfoId)){
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
        return roleMapper.getRolesByLoginInfoId(loginInfoId,start,rows,searchContent);
    }

    /**
     * 获取含有指定权限的所有角色
     *
     * @param permissionId ：指定权限id
     * @param currentPage：当前页
     * @param rows：每页要显示的数据条数
     * @param searchContent：模糊查询内容
     * @return ：返回含有该权限的所有角色，支持分页
     */
    @Override
    public Collection<Role> getRolesByPermissionId(String permissionId, Integer currentPage, Integer rows, String searchContent) {
        if (StringUtil.isEmpty(permissionId)){
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
        return roleMapper.getRolesByPermissionId(permissionId,start,rows,searchContent);
    }

    /**
     * 角色添加方法
     * @param role：要添加的角色
     * @return 返回操作成功的个数，0表示操作失败
     */
    @Override
    public Integer add(@Validated(value = {TC_Add.class})  Role role) throws InsertException {
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
     * 角色删除方法
     *
     * @param id：角色id
     * @return 返回值大于0表示操作成功，否则操作失败
     */
    @Override
    public Integer delete(String id) throws DeleteException {
        Integer result = 0;
        if (StringUtil.isEmpty(id)){
            return result;
        }

        //确保要删除的对象存在
        if (this.getRoleById(id) == null){
            return result;
        }

        result = roleMapper.delete(id);

        return result;
    }

    /**
     * 批量删除
     * @param ids：需要删除的对象的id集
     * @return 返回操作成功的数目与操作失败的对象
     */
    @Override
    public Map<String, Object> batchDelete(String ids) {
        if (StringUtil.isEmpty(ids))
            return null;

        Map<String, Object> result = new ConcurrentHashMap<>();  //返回结果map

        Integer success = 0; //操作成功的个数
        Map<String, Object> fail = new ConcurrentHashMap<>();  //操作失败的对象

        String[] arr = ids.split(",");  //分割成数组
        for (String id : arr) {
            Integer res = 0;
            try {
                res = this.delete(id);
            } catch (DeleteException e) {   //删除失败
                e.printStackTrace();
            }
            if (res > 0) {
                success += 1;
            } else {
                fail.put(id, this.getRoleById(id));
            }
        }

        result.put("success", success);
        result.put("fail", fail);

        return result;
    }

    /**
     * 给角色授权，添加事务保证授权统一成功或失败
     * @param roleId ：角色id
     * @param permissionIds ：授予的权限id集
     * 返回授权成功的个数，0表示授权失败
     */
    @Transactional
    public Integer grantPermission(String roleId, String permissionIds){
        GrantException grantException;  //授权失败异常
        Integer result = 0;     //授权结果
        if (StringUtil.isEmpty(roleId) || StringUtil.isEmpty(permissionIds)){
            grantException = new GrantException("授予角色权限失败，角色或所授权限不能为空");
            throw grantException;
        }

        //获取当前登录用户
        String username = SysResourcesUtils.getCurrentUsername();
        LoginInfo loginInfo = loginInfoMapper.getLoginInfoByUsername(username);

        String[] arr = permissionIds.split(",");
        for (String permissionId : arr) {
            Permission permission = permissionMapper.getPermissionById(permissionId);
            //确保授予的权限存在
            if (permission == null){
                grantException = new GrantException("授权失败，所授权限不存在或已被删除");
                throw grantException;
            }

            //逐一授权
            RolePermission rolePermission = new RolePermission();
            rolePermission.setId(UUID.randomUUID().toString());
            rolePermission.setRoleId(roleId);
            rolePermission.setPermissionId(permissionId);
            rolePermission.setCreateUserId(loginInfo.getId());
            rolePermission.setCreateDate(new Date());

            result = rolePermissionMapper.add(rolePermission);
            if (result == 0){
                grantException = new GrantException("授权失败，请重试");
                throw grantException;
            }
        }
        return result;
    }

    /**
     * 通过多个角色ID去查询符合条件的角色集
     * @param roleIds：多个角色ID
     * @return 返回角色集合
     */
    @Override
    public List<Role> getRolesByRoleIds(String roleIds) {
        if (StringUtil.isEmpty(roleIds))
            return null;
        List<Role> list = new ArrayList<>();
        String[] arr = roleIds.split(",");
        for (String id : arr) {
            Role role = this.getRoleById(id);
            list.add(role);
        }
        return list;
    }
}