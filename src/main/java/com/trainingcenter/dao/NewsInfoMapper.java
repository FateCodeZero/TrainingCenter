package com.trainingcenter.dao;

import com.trainingcenter.bean.NewsInfo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import javax.validation.Valid;
import java.util.List;

/**
 * @author Liutingwei
 * @date 2018-11-6 15:27
 */
@Repository("newsInfoMapper")
public interface NewsInfoMapper {
    /**
     *
     * @param id 新闻的ID
     * @return 新闻
     */
    public NewsInfo getNewsInfoById(@Param("id") String id);

    /**
     * 分页获取所有培训
     * @param start：从第几条数据开始
     * @param number：要获取多少条数据
     * @param searchContent：模糊查询内容
     * @return 返回新闻对象集合
     */
    public List<NewsInfo> getNewsInfos(@Param("start") Integer start, @Param("number") Integer number,
                                                     @Param("searchContent") String searchContent);


    /**
     * 新闻添加方法
     * @param newsInfo 培训新闻
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer add(@Valid @Param("newsInfo") NewsInfo newsInfo);


    /**
     * 新闻更新方法
     * @param newsInfo：要更新的培训新闻
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer update(@Valid @Param("newsInfo") NewsInfo newsInfo);

    /**
     * 新闻删除方法
     * @param id：新闻id
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer delete(@Param("id") String id);


}
