package com.trainingcenter.service;

import com.trainingcenter.bean.Resource;
import com.trainingcenter.controller.validation.TC_Add;
import com.trainingcenter.controller.validation.TC_Update;
import org.springframework.validation.annotation.Validated;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/11/18
 * Time: 5:20
 */
public interface ResourceService {
    /**
     * 通过 id 获取资源信息
     * @param id ：资源ID
     * @return 返回资源对象
     */
    public Resource getResourceById(String id);

    /**
     * 获取所有资源对象
     * @return 返回资源对象集合
     */
    public List<Resource> getResources();

    /**
     * 获取所有资源对象，支持分页
     * @param currentPage：当前页
     * @param rows：每页要显示的数据条数
     * @param searchContent：模糊查询内容
     * @return 返回资源对象集合
     */
    public List<Resource> getResources(Integer currentPage, Integer rows,String searchContent);

    /**
     * 添加方法
     */
    public Integer add(@Validated(value = {TC_Add.class})Resource resource);

    /**
     * 更新方法
     */
    public Integer update(@Validated(value = {TC_Update.class}) Resource resource);

    /**
     * 删除方法
     */
    public Integer delete(String id);
}
