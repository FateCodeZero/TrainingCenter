package com.trainingcenter.service.impl;

import com.trainingcenter.bean.DevelopTeachingPoint;
import com.trainingcenter.dao.DevelopTeachingPointMapper;
import com.trainingcenter.exception.DeleteException;
import com.trainingcenter.service.DevelopTeachingPointService;
import com.trainingcenter.utils.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.validation.Valid;
import java.util.List;
import java.util.Map;

/**
 * @author Liutingwei
 * @date 2018-11-6 21:44
 */
@Service("developTeachingPointService")
public class DevelopTeachingPointServiceImpl implements DevelopTeachingPointService {
    @Qualifier("developTeachingPointMapper")
    @Autowired
    private DevelopTeachingPointMapper developTeachingPointMapper;

    /**
     *通过id获取培训动态
     * @param id：培训动态id
     * @return 返回对应的培训动态对象
     */
    @Override
    public DevelopTeachingPoint getDevelopTeachingPointById(String id) {
        return StringUtil.isEmpty(id)?null:developTeachingPointMapper.getDevelopTeachingPointById(id);
    }

    @Override
    public List<DevelopTeachingPoint> getDevelopTeachingPoints(Map<String,Object> condition) {
        return getDevelopTeachingPoints(null, null, condition);
    }
    /**
     *分页获取所以培训动态
     * @param currentPage：当前页
     * @param rows：每页要显示的数据条数
     * @param condition：模糊查询内容
     * @return
     */
    @Override
    public List<DevelopTeachingPoint> getDevelopTeachingPoints(Integer currentPage, Integer rows, Map<String,Object> condition) {
            if(currentPage != null && rows != null) {
                if (currentPage < 0 || rows < 0) {
                    return null;
                }
                Integer start = (currentPage - 1) * rows;
                return developTeachingPointMapper.getDevelopTeachingPoints(start, rows, condition);
            }
            else {
                return developTeachingPointMapper.getDevelopTeachingPoints(null,null,condition);
            }
    }

    /**
     * 培训动态添加方法
     * @param developTeachingPoint：要添加的培训动态
     * @return 返回值大于0表示操作成功，否则操作失败
     */
    @Override
    public Integer add(@Valid DevelopTeachingPoint developTeachingPoint) {
        return developTeachingPoint == null ? 0:developTeachingPointMapper.add(developTeachingPoint);
    }

    /**
     * 培训动态更新方法
     * @param developTeachingPoint:要更新的培训动态
     * @return 返回值大于0表示操作成功，否则操作失败
     */
    @Override
    public Integer update(@Valid DevelopTeachingPoint developTeachingPoint) {
        return developTeachingPoint == null ? 0:developTeachingPointMapper.update(developTeachingPoint);
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
            if (this.getDevelopTeachingPointById(id) != null){//确保要删除对象存在
                result = developTeachingPointMapper.delete(id);
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
