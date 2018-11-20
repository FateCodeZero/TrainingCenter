package com.trainingcenter.dao;

import com.trainingcenter.bean.SysLog;
import com.trainingcenter.controller.validation.TC_Add;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.springframework.validation.annotation.Validated;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/11/19
 * Time: 16:55
 */
@Repository("sysLogMapper")
public interface SysLogMapper {

    /**
     * 通过 Id 获取系统日志
     * @param id：日志id
     * @return 返回日志对象
     */
    public SysLog getSysLogById(@Param("id") String id);

    /**
     * 分页获取数据
     * @param start：从第几条数据开始查
     * @param number：查询多少条数据
     * @param searchContent：模糊查询内容
     * @return 返回当前页的数据集合
     */
    public List<SysLog> getSysLogs(@Param("start") Integer start, @Param("number") Integer number, @Param("searchContent") String searchContent);

    /**
     * 添加日志
     * @param sysLog：日志对象
     * @return 返回操作成功的条数，0表示操作失败
     */
    public Integer add(@Validated(value = {TC_Add.class}) @Param("sysLog") SysLog sysLog);

    /**
     * 通过 id 删除日志
     * @param id ：日志对象ID
     * @return 返回操作成功的条数，0表示操作失败
     */
    public Integer delete(@Param("id") String id);
}
