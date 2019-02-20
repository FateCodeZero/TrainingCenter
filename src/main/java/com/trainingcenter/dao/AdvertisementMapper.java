package com.trainingcenter.dao;

import com.trainingcenter.bean.Advertisement;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import javax.validation.Valid;
import java.util.List;
import java.util.Map;

/**
 * @author Liutingwei
 * @date 2018-11-7 15:44
 */
@Repository("advertisementMapper")
public interface AdvertisementMapper {
    /**
     *
     * @param id 广告的ID
     * @return 广告
     */
    public Advertisement getAdvertisementById(@Param("id") String id);


    public List<Advertisement> getAdvertisements();
    /**
     * 分页获取所有广告
     * @param start：从第几条数据开始
     * @param number：要获取多少条数据
     * @param condition：模糊查询内容
     * @return 返回广告对象集合
     */
    public List<Advertisement> getAdvertisements(@Param("start") Integer start, @Param("number") Integer number,
                                                 @Param("condition") Map<String,Object> condition);

    /**
     * 广告添加方法
     * @param advertisement 广告
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer add(@Valid @Param("advertisement") Advertisement advertisement);


    /**
     * 广告更新方法
     * @param advertisement：要更新的广告
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer update(@Valid @Param("advertisement") Advertisement advertisement);

    /**
     * 广告删除方法
     * @param id：广告id
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer delete(@Param("id") String id);


}
