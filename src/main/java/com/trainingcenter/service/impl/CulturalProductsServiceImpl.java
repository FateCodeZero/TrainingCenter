package com.trainingcenter.service.impl;

import com.trainingcenter.bean.CulturalProducts;
import com.trainingcenter.dao.CulturalProductsMapper;
import com.trainingcenter.exception.DeleteException;
import com.trainingcenter.service.CulturalProductsService;
import com.trainingcenter.utils.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.validation.Valid;
import java.util.List;

/**
 * @author Liutingwei
 * @date 2018-11-6 21:44
 */
@Service("culturalProductsService")
public class CulturalProductsServiceImpl implements CulturalProductsService {
    @Qualifier("culturalProductsMapper")
    @Autowired
    private CulturalProductsMapper culturalProductsMapper;

    /**
     *通过id获取培训动态
     * @param id：培训动态id
     * @return 返回对应的培训动态对象
     */
    @Override
    public CulturalProducts getCulturalProductsById(String id) {
        return StringUtil.isEmpty(id)?null:culturalProductsMapper.getCulturalProductsById(id);
    }

    @Override
    public List<CulturalProducts> getCulturalProductss() {
        return getCulturalProductss(null, null, null);
    }
    /**
     *分页获取所以培训动态
     * @param currentPage：当前页
     * @param rows：每页要显示的数据条数
     * @param searchContent：模糊查询内容
     * @return
     */
    @Override
    public List<CulturalProducts> getCulturalProductss(Integer currentPage, Integer rows, String searchContent) {
            if(currentPage != null && rows != null) {
                if (currentPage < 0 || rows < 0) {
                    return null;
                }
                Integer start = (currentPage - 1) * rows;
                return culturalProductsMapper.getCulturalProductss(start, rows, searchContent);
            }
            else {
                return culturalProductsMapper.getCulturalProductss(null,null,searchContent);
            }
    }

    /**
     * 培训动态添加方法
     * @param culturalProducts：要添加的培训动态
     * @return 返回值大于0表示操作成功，否则操作失败
     */
    @Override
    public Integer add(@Valid CulturalProducts culturalProducts) {
        return culturalProducts == null ? 0:culturalProductsMapper.add(culturalProducts);
    }

    /**
     * 培训动态更新方法
     * @param culturalProducts:要更新的培训动态
     * @return 返回值大于0表示操作成功，否则操作失败
     */
    @Override
    public Integer update(@Valid CulturalProducts culturalProducts) {
        return culturalProducts == null ? 0:culturalProductsMapper.update(culturalProducts);
    }

    /**
     * 培训动态删除方法
     * @param id：培训动态id
     * @return 返回值大于0表示操作成功，否则操作失败
     * @throws DeleteException
     */
    @Override
    public Integer delete(String id) throws DeleteException {
        Integer result = 0;
        if (StringUtil.isNotEmpty(id)){
            if (this.getCulturalProductsById(id) != null){//确保要删除对象存在
                result = culturalProductsMapper.delete(id);
                if (result == 0){
                    throw new DeleteException("删除失败，请稍后重试！");
                }
            }else {
                throw new DeleteException("删除失败，动态培训不存在或已被删除！");
            }
        }else {
            throw new DeleteException("删除失败，删除动态培训id不能为空！");
        }
        return result;
    }

    /**
     * 批量删除
     *
     * @param ids：需要删除的对象的id集
     * @return 返回操作结果（1：删除成功，0：删除失败）
     * 添加事务，保证中间删除失败时可以回滚
     */
    @Transactional
    @Override
    public Integer batchDelete(String ids) {
        if (StringUtil.isEmpty(ids))
            return 0;
        String[] arr = ids.split(",");  //分割成数组
        for (String id : arr) {
            Integer res = this.delete(id);
            if (res == 0) {
                return 0;
            }
        }
        return 1;
    }

}
