package com.trainingcenter.service.impl;

import com.trainingcenter.bean.Resource;
import com.trainingcenter.controller.validation.TC_Add;
import com.trainingcenter.controller.validation.TC_Update;
import com.trainingcenter.dao.ResourceMapper;
import com.trainingcenter.exception.DeleteException;
import com.trainingcenter.exception.InsertException;
import com.trainingcenter.exception.UpdateException;
import com.trainingcenter.service.ResourceService;
import com.trainingcenter.utils.LogUtil;
import com.trainingcenter.utils.StringUtil;
import com.trainingcenter.utils.SysResourcesUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.annotation.Validated;

import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/11/18
 * Time: 5:24
 */
@Service("resourceService")
public class ResourceServiceImpl implements ResourceService {
    @Qualifier("resourceMapper")
    @Autowired
    ResourceMapper resourceMapper;

    /**
     * 通过 id 获取资源信息
     * @param id ：资源ID
     * @return 返回资源对象
     */
    @Override
    public Resource getResourceById(String id) {
        return StringUtil.isEmpty(id) ? null : resourceMapper.getResourceById(id);
    }

    /**
     * 获取所有资源对象
     * @param condition：自定义查询条件，模糊查询的 key 固定为 searchContent
     * @return 返回资源对象集合
     */
    @Override
    public List<Resource> getResources(Map<String,Object> condition) {
        return getResources(null, null, condition);
    }

    /**
     * 获取所有资源对象，支持分页
     * @param currentPage：当前页
     * @param rows：每页要显示的数据条数
     * @param condition：自定义查询条件，模糊查询的 key 固定为 searchContent
     * @return 返回资源对象集合
     */
    @Override
    public List<Resource> getResources(Integer currentPage, Integer rows, Map<String,Object> condition) {
        if (currentPage != null && rows != null) {
            if (currentPage < 0 || rows < 0) {
                return null;
            } else {
                Integer start = (currentPage - 1) * rows;   //计算当前页的数据是从第几条开始查询
                return resourceMapper.getResources(start, rows, condition);
            }
        } else {
            return resourceMapper.getResources(null, null, condition);
        }
    }

    @Override
    public Integer add(@Validated(value = {TC_Add.class}) Resource resource) {
        InsertException insertException;
        if (resource == null){
            insertException = new InsertException("添加失败，添加对象不能为空");
            throw insertException;
        }
        return resourceMapper.add(resource);
    }

    @Override
    public Integer update(@Validated(value = {TC_Update.class}) Resource resource) {
        UpdateException updateException;
        if (resource == null){
            updateException = new UpdateException("更新失败，请先选择更新对象");
            throw updateException;
        }
        return resourceMapper.update(resource);
    }

    @Override
    public Integer delete(String id) {
        String currentUsername = SysResourcesUtils.getCurrentUsername();
        DeleteException deleteException;
        if (StringUtil.isEmpty(id)){
            deleteException = new DeleteException("删除失败，请先选择要删除的对象");
            throw deleteException;
        }

        //保证删除对象存在
        Resource resource = getResourceById(id);
        if (resource == null){
            deleteException = new DeleteException("删除失败，对象不存在或已被删除");
            throw deleteException;
        }

        LogUtil.info(this,"资源删除","用户：【"+currentUsername+"删除了【"+resource.getName()+"】资源");
        //实行软删除
        resource.setState(-1);
        Integer delete = resourceMapper.update(resource);

        if (delete == 0){
            deleteException = new DeleteException("删除失败，请稍后重试");
            LogUtil.warn(this,"资源删除","未知错误：对象存在但删除失败！");
            throw deleteException;
        }

        return delete;
    }

    /**
     * 批量删除
     *
     * @param ids：需要删除的对象的id集
     * @return 返回操作结果（1：删除成功，0：删除失败）
     * 添加事务，保证中间删除失败时可以回滚
     */
    @Transactional
    @Override
    public Integer batchDelete(String ids) {
        if (StringUtil.isEmpty(ids))
            return 0;

        //获取当前登录用户
        String currentUsername = SysResourcesUtils.getCurrentUsername();
        LogUtil.info(this, "资源批量删除", "用户：【" + currentUsername + "】正在批量删除IDS为：【" + ids + "】的资源");

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