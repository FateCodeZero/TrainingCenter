package com.trainingcenter.service.impl;

import com.trainingcenter.bean.Advertisement;
import com.trainingcenter.dao.AdvertisementMapper;
import com.trainingcenter.exception.DeleteException;
import com.trainingcenter.exception.FindException;
import com.trainingcenter.service.AdvertisementService;
import com.trainingcenter.utils.LogUtil;
import com.trainingcenter.utils.StringUtil;
import com.trainingcenter.utils.SysResourcesUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.validation.Valid;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * @author Liutingwei
 * @date 2018-11-6 21:44
 */
@Service("advertisementService")
public class AdvertisementServiceImpl implements AdvertisementService {
    @Qualifier(value = "advertisementMapper")
    @Autowired
    private AdvertisementMapper advertisementMapper;

    /**
     *通过id获取广告
     * @param id：广告id
     * @return 返回对应的广告对象
     */
    @Override
    public Advertisement getAdvertisementById(String id) {
        return StringUtil.isEmpty(id)?null:advertisementMapper.getAdvertisementById(id);
    }

    @Override
    public List<Advertisement> getAdvertisements(Map<String,Object> condition){return getAdvertisements(null, null, condition);}

    /**
     *分页获取所以广告
     * @param currentPage：当前页
     * @param rows：每页要显示的数据条数
     * @param condition：模糊查询内容
     * @return
     */
    @Override
    public List<Advertisement> getAdvertisements(Integer currentPage, Integer rows, Map<String,Object> condition) {
        if (currentPage != null && rows != null) {
            if (currentPage < 0 || rows < 0) {
                return null;
            } else {
                Integer start = (currentPage - 1) * rows;   //计算当前页的数据是从第几条开始查询
                return advertisementMapper.getAdvertisements(start, rows, condition);
            }
        } else {
            return advertisementMapper.getAdvertisements(null, null, condition);
        }
    }

    /**
     * 广告添加方法
     * @param advertisement：要添加的广告
     * @return 返回值大于0表示操作成功，否则操作失败
     */
    @Override
    public Integer add(@Valid Advertisement advertisement) {
        return advertisement == null ? 0:advertisementMapper.add(advertisement);
    }

    /**
     * 广告更新方法
     * @param advertisement:要更新的广告
     * @return 返回值大于0表示操作成功，否则操作失败
     */
    @Override
    public Integer update(@Valid Advertisement advertisement) {
        return advertisement == null ? 0:advertisementMapper.update(advertisement);
    }

    /**
     * 广告删除方法
     * @param id：广告id
     * @return 返回值大于0表示操作成功，否则操作失败
     * @throws DeleteException
     */
    @Override
    public Integer delete(String id) throws DeleteException {
        Integer result = 0;
        if (StringUtil.isNotEmpty(id)){
            if (this.getAdvertisementById(id) != null){//确保要删除对象存在
                result = advertisementMapper.delete(id);
                if (result == 0){
                    throw new DeleteException("删除失败，请稍后重试！");
                }
            }else {
                throw new DeleteException("删除失败，广告不存在或已被删除！");
            }
        }else {
            throw new DeleteException("删除失败，删除广告id不能为空！");
        }
        return result;
    }

    /**
     * 批量删除
     *
     * @param ids：需要删除的对象的id集
     * @return 返回操作结果（true：删除成功，false：删除失败）
     * 添加事务，保证中间删除失败时可以回滚
     */
    @Override
    @Transactional
    public boolean batchDelete(String ids) throws FindException, DeleteException {
        if (StringUtil.isEmpty(ids))
            return false;

        //获取当前登录用户
        String currentUsername = SysResourcesUtils.getCurrentUsername();
        LogUtil.info(this, "角色批量删除", "用户：【" + currentUsername + "】正在批量删除IDS为：【" + ids + "】的角色");

        String[] arr = ids.split(",");  //分割成数组
        for (String id : arr) {
            Integer res = this.delete(id);
            if (res == 0) {
                return false;
            }
        }
        return true;
    }


}
