package com.trainingcenter.service.impl;

import com.trainingcenter.bean.Role;
import com.trainingcenter.dao.RoleMapper;
import com.trainingcenter.exception.DeleteException;
import com.trainingcenter.service.RoleService;
import com.trainingcenter.utils.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
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

    @Override
    public Role getRoleById(String id) {
        return StringUtil.isEmpty(id)?null:roleMapper.getRoleById(id);
    }

    @Override
    public List<Role> getRoles(Integer currentPage, Integer rows, String searchContent) {
        if (currentPage < 0 || rows < 0) {
            return null;
        }
        Integer start = (currentPage - 1) * rows;   //计算当前页的数据是从第几条开始查询
        return roleMapper.getRoles(start, rows, searchContent);
    }

    @Override
    public Integer add(@Valid Role role) {
        return role == null ? 0 : roleMapper.add(role);
    }

    /**
     * 用户更新方法
     *
     * @param role：用户对象
     * @return 返回值大于0表示操作成功，否则操作失败
     */
    @Override
    public Integer update(@Valid Role role) {
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
        if (StringUtil.isNotEmpty(id)){
            if (this.getRoleById(id) != null){//确保要删除对象存在
                result = roleMapper.delete(id);
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
    public Map<String, Object> batchDelete(String ids) {
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
            } catch (DeleteException e) {   //删除失败
                res = 0;
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