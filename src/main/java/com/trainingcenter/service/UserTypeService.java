package com.trainingcenter.service;

import com.trainingcenter.bean.UserType;
import com.trainingcenter.exception.DeleteException;

import javax.validation.Valid;
import java.util.List;
import java.util.Map;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/15
 * Time: 17:27
 */
public interface UserTypeService {
    /**
     * 通过id获取用户类型信息
     * @param id：用户类型id
     * @return 返回用户类型对象
     */
    public UserType getUserTypeById(String id);

    /**
     * 分页获取所有用户
     *
     * @param currentPage：当前页
     * @param rows：每页要显示的数据条数
     * @param searchContent：模糊查询内容
     * @return 返回当前页的数据集合
     */
    public List<UserType> getUserTypes(Integer currentPage, Integer rows, String searchContent);

    /**
     * 添加
     * @param userType：用户类型对象
     * @return 返回操作成功的条数，0表示操作失败
     */
    public Integer add(@Valid UserType userType);

    /**
     * 更新
     * @param userType：用户类型对象
     * @return 返回操作成功的条数，0表示操作失败
     */
    public Integer update(@Valid UserType userType);

    /**
     * 删除
     * @param id：要删除的用户类型对象id
     * @return 返回操作成功的条数，0表示操作失败
     */
    public Integer delete(String id) throws DeleteException;

    /**
     * 批量删除
     *
     * @param ids：需要删除的对象的id集
     * @return 返回操作成功的数目与操作失败的对象
     */
    public Map<String, Object> batchDelete(String ids);
}
