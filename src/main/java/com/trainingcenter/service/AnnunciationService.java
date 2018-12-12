package com.trainingcenter.service;

import com.trainingcenter.bean.Annunciation;
import com.trainingcenter.exception.DeleteException;
import org.apache.ibatis.annotations.Param;

import javax.validation.Valid;
import java.util.List;
import java.util.Map;

/**
 * @author Liutingwei
 * @date 2018-11-6 21:34
 */
public interface AnnunciationService {
    /**
     * 通过id获取新闻信息
     * @param id：新闻信息id
     * @return 返回对应的新闻信息对象
     */
    public Annunciation getAnnunciationById(String id);

    /**
     * 获取所有资源对象
     * @return 返回资源对象集合
     */
    public List<Annunciation> getAnnunciations(Map<String,Object> condition);

    /**
     * 分页获取所以新闻信息
     *
     * @param currentPage：当前页
     * @param rows：每页要显示的数据条数
     * @param condition：模糊查询内容
     * @return 返回当前页的数据集合
     */
    public List<Annunciation> getAnnunciations(Integer currentPage, Integer rows, Map<String,Object> condition);

    /**
     * 新闻信息添加方法
     * @param annunciation：要添加的新闻信息
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer add(@Valid @Param("annunciation") Annunciation annunciation);

    /**
     * 新闻信息更新方法
     *
     * @param annunciation:要更新的动态培训
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer update(@Valid Annunciation annunciation);

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
    public boolean batchDelete(String ids);
    /**
     * 通过多个动态培训ID去查询符合条件的动态培训集
     * @param annunciationIds：多个动态培训ID
     * @return 返回动态培训集合
     */
}
