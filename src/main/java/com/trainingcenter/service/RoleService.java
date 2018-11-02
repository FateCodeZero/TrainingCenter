package com.trainingcenter.service;

import com.trainingcenter.bean.Role;
import com.trainingcenter.exception.DeleteException;
import org.apache.ibatis.annotations.Param;

import javax.validation.Valid;
import java.util.List;
import java.util.Map;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/31
 * Time: 14:38
 */
public interface RoleService {
    /**
     * 通过id获取角色
     * @param id：角色id
     * @return 返回对应的角色对象
     */
    public Role getRoleById(String id);
    /**
     * 分页获取所有用户
     *
     * @param currentPage：当前页
     * @param rows：每页要显示的数据条数
     * @param searchContent：模糊查询内容
     * @return 返回当前页的数据集合
     */
    public List<Role> getRoles(Integer currentPage,Integer rows,String searchContent);

    /**
     * 角色添加方法
     * @param role：要添加的角色
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer add(@Valid @Param("role") Role role);

    /**
     * 角色更新方法
     *
     * @param role
     * @return
     */
    public Integer update(@Valid Role role);

    /**
     * 角色删除方法
     *
     * @param id：角色id
     * @return
     */
    public Integer delete(String id) throws DeleteException;

    /**
     * 批量删除
     * @param ids：需要删除的对象的id集
     * @return 返回操作成功的数目与操作失败的对象
     */
    public Map<String,Object> batchDelete(String ids);

    /**
     * 通过多个角色ID去查询符合条件的角色集
     * @param roleIds：多个角色ID
     * @return 返回角色集合
     */
    public List<Role> getRolesByRoleIds(@Param("roleIds") String roleIds);
}
