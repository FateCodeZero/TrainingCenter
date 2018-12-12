package com.trainingcenter.service;

import com.trainingcenter.bean.Advertisement;
import com.trainingcenter.exception.DeleteException;
import org.apache.ibatis.annotations.Param;

import javax.validation.Valid;
import java.util.List;
import java.util.Map;

/**
 * @author Liutingwei
 * @date 2018-11-6 21:34
 */
public interface AdvertisementService {

    /**
     * 通过id获取广告
     * @param id：广告id
     * @return 返回对应的广告对象
     */
    public Advertisement getAdvertisementById(String id);

    public List<Advertisement> getAdvertisements(Map<String,Object> condition);

    /**
     * 分页获取所有广告
     *
     * @param currentPage：当前页
     * @param rows：每页要显示的数据条数
     * @param condition：模糊查询内容
     * @return 返回当前页的数据集合
     */
    public List<Advertisement> getAdvertisements(Integer currentPage, Integer rows, Map<String,Object> condition);

    /**
     * 广告添加方法
     * @param advertisement：要添加的广告
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer add(@Valid @Param("advertisement") Advertisement advertisement);

    /**
     * 广告更新方法
     *
     * @param advertisement:要更新的广告
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer update(@Valid Advertisement advertisement);

    /**
     * 广告删除方法
     *
     * @param id：广告id
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer delete(String id) throws DeleteException;

    /**
     * 批量删除
     * @param ids：需要删除的对象的id集
     * @return 返回操作成功的数目与操作失败的对象
     */
    public boolean batchDelete(String ids);

    /**
     * 通过多个广告ID去查询符合条件的广告集
     * @param sysLogIds：多个广告ID
     * @return 返回广告集合
     */
}
