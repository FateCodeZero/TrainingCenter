package com.trainingcenter.dao;

import com.trainingcenter.bean.Resource;
import com.trainingcenter.controller.validation.TC_Add;
import com.trainingcenter.controller.validation.TC_Update;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.springframework.validation.annotation.Validated;

import java.util.List;
import java.util.Map;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/11/18
 * Time: 5:01
 */
@Repository("resourceMapper")
public interface ResourceMapper {

    /**
     * 通过 id 获取资源信息
     * @param id ：资源ID
     * @return 返回资源对象
     */
    public Resource getResourceById(@Param("id") String id);

    /**
     * 获取所有资源对象，支持分页
     * @param start：从第几条数据开始查询
     * @param number：一个查询多少条数据
     * @param condition：自定义查询条件，模糊查询的 key 固定为 searchContent
     * @return 返回资源对象集合
     */
    public List<Resource> getResources(@Param("start") Integer start, @Param("number") Integer number,
                                       @Param("condition") Map<String,Object> condition);

    /**
     * 添加方法
     */
    public Integer add(@Validated(value = {TC_Add.class}) @Param("resource") Resource resource);

    /**
     * 更新方法
     */
    public Integer update(@Validated(value = {TC_Update.class}) @Param("resource") Resource resource);

    /**
     * 删除方法
     */
    public Integer delete(@Param("id") String id);
}
