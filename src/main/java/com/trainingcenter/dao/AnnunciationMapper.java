package com.trainingcenter.dao;

import com.trainingcenter.bean.Annunciation;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import javax.validation.Valid;
import java.util.List;
import java.util.Map;

/**
 * @author Liutingwei
 * @date 2018-11-6 15:27
 */
@Repository("annunciationMapper")
public interface AnnunciationMapper {
    /**
     *
     * @param id 新闻的ID
     * @return 新闻
     */
    public Annunciation getAnnunciationById(@Param("id") String id);

    /**
     * 分页获取所有培训
     * @param start：从第几条数据开始
     * @param number：要获取多少条数据
     * @param condition：模糊查询内容
     * @return 返回新闻对象集合
     */
    public List<Annunciation> getAnnunciations(@Param("start") Integer start, @Param("number") Integer number,
                                               @Param("condition")  Map<String,Object> condition);


    /**
     * 新闻添加方法
     * @param annunciation 培训新闻
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer add(@Valid @Param("annunciation") Annunciation annunciation);


    /**
     * 新闻更新方法
     * @param annunciation：要更新的培训新闻
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer update(@Valid @Param("annunciation") Annunciation annunciation);

    /**
     * 新闻删除方法
     * @param id：新闻id
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer delete(@Param("id") String id);


}
