package com.trainingcenter.service;

import com.trainingcenter.bean.DevelopTeachingPoint;
import com.trainingcenter.exception.DeleteException;
import org.apache.ibatis.annotations.Param;

import javax.validation.Valid;
import java.util.List;
import java.util.Map;

/**
 * @author Liutingwei
 * @date 2018-11-6 21:34
 */
public interface DevelopTeachingPointService {
    /**
     * 通过id获取培训动态
     * @param id：培训动态id
     * @return 返回对应的培训动态对象
     */
    public DevelopTeachingPoint getDevelopTeachingPointById(String id);

    /**
     * 获取所有资源对象
     * @return 返回资源对象集合
     */
    public List<DevelopTeachingPoint> getDevelopTeachingPoints(Map<String,Object> condition);

    /**
     * 分页获取所以培训动态
     *
     * @param currentPage：当前页
     * @param rows：每页要显示的数据条数
     * @param searchContent：模糊查询内容
     * @return 返回当前页的数据集合
     */
    public List<DevelopTeachingPoint> getDevelopTeachingPoints(Integer currentPage, Integer rows, Map<String,Object> condition);

    /**
     * 培训动态添加方法
     * @param developTeachingPoint：要添加的培训动态
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer add(@Valid @Param("developTeachingPoint") DevelopTeachingPoint developTeachingPoint);

    /**
     * 培训动态更新方法
     *
     * @param developTeachingPoint:要更新的动态培训
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer update(@Valid DevelopTeachingPoint developTeachingPoint);

    /**
     * 动态培训删除方法
     *
     * @param id：动态培训id
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer delete(String id) throws DeleteException;

    /**
     * 批量删除
     *
     * @param ids：需要删除的对象的id集
     * @return 返回操作结果（true：删除成功，false：删除失败）
     * 添加事务，保证中间删除失败时可以回滚
     */
    public Integer batchDelete(String ids);
    /**
     * 通过多个动态培训ID去查询符合条件的动态培训集
     * @param developTeachingPointIds：多个动态培训ID
     * @return 返回动态培训集合
     */
}
