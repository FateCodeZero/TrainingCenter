package com.trainingcenter.dao;

import com.trainingcenter.bean.CulturalTeachingPoint;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import javax.validation.Valid;
import java.util.List;

/**
 * @author Liutingwei
 * @date 2018-11-6 15:27
 */
@Repository("culturalTeachingPointMapper")
public interface CulturalTeachingPointMapper {
    /**
     *
     * @param id 动态培训的ID
     * @return 动态培训
     */
    public CulturalTeachingPoint getCulturalTeachingPointById(@Param("id") String id);

    /**
     * 分页获取所有培训
     * @param start：从第几条数据开始
     * @param number：要获取多少条数据
     * @param searchContent：模糊查询内容
     * @return 返回动态培训对象集合
     */
    public List<CulturalTeachingPoint> getCulturalTeachingPoints(@Param("start") Integer start, @Param("number") Integer number,
                                                     @Param("searchContent") String searchContent);


    /**
     * 动态培训添加方法
     * @param culturalTeachingPoint 培训新闻
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer add(@Valid @Param("culturalTeachingPoint") CulturalTeachingPoint culturalTeachingPoint);


    /**
     * 动态培训更新方法
     * @param culturalTeachingPoint：要更新的培训新闻
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer update(@Valid @Param("culturalTeachingPoint") CulturalTeachingPoint culturalTeachingPoint);

    /**
     * 动态培训删除方法
     * @param id：动态培训id
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer delete(@Param("id") String id);


}
