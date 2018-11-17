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
import org.springframework.validation.annotation.Validated;

import java.util.List;

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

    @Override
    public Resource getResourceById(String id) {
        return StringUtil.isEmpty(id) ? null : resourceMapper.getResourceById(id);
    }

    @Override
    public List<Resource> getResources() {
        return getResources(null, null, null);
    }

    @Override
    public List<Resource> getResources(Integer currentPage, Integer rows, String searchContent) {
        if (currentPage != null && rows != null) {
            if (currentPage < 0 || rows < 0) {
                return null;
            } else {
                Integer start = (currentPage - 1) * rows;   //计算当前页的数据是从第几条开始查询
                return resourceMapper.getResources(start, rows, searchContent);
            }
        } else {
            return resourceMapper.getResources(null, null, searchContent);
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

        Resource resource = getResourceById(id);
        if (resource == null){
            deleteException = new DeleteException("删除失败，对象不存在或已被删除");
            throw deleteException;
        }
        LogUtil.info(this,"资源删除","用户：【"+currentUsername+"删除了【"+resource.getName()+"资源");
        Integer delete = resourceMapper.delete(id);

        if (delete == 0){
            deleteException = new DeleteException("删除失败，请稍后重试");
            LogUtil.warn(this,"资源删除","未知错误：对象存在但删除失败！");
            throw deleteException;
        }
        return delete;
    }
}