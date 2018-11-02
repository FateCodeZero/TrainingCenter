package com.trainingcenter.dao;

import com.trainingcenter.bean.Role;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import javax.validation.Valid;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/31
 * Time: 14:29
 */
@Repository("roleMapper")
public interface RoleMapper {

    /**
i     * 通过id获取角色
     * @param id：角色id
     * @return 返回对应的角色对象
     */
    public Role getRoleById(@Param("id") String id);

    /**
     * 分页获取所有用户
     * @param start：从第几条数据开始
     * @param number：要获取多少条数据
     * @param searchContent：模糊查询内容
     * @return 返回用户对象集合
     */
    public List<Role> getRoles(@Param("start") Integer start, @Param("number") Integer number,
                               @Param("searchContent") String searchContent);
    /**
     * 角色添加方法
     * @param role：要添加的角色
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer add(@Valid @Param("role") Role role);

    /**
     * 角色更新方法
     * @param role: 要更新的角色
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer update(@Valid @Param("role") Role role);

    /**
     * 角色删除方法
     * @param id：角色id
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer delete(@Param("id") String id);

} 