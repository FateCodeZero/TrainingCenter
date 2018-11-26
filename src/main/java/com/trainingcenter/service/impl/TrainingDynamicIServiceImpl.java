package com.trainingcenter.service.impl;

import com.trainingcenter.bean.TrainingDynamic;
import com.trainingcenter.dao.TrainingDynamicMapper;
import com.trainingcenter.exception.DeleteException;
import com.trainingcenter.exception.FindException;
import com.trainingcenter.service.TrainingDynamicService;
import com.trainingcenter.utils.LogUtil;
import com.trainingcenter.utils.StringUtil;
import com.trainingcenter.utils.SysResourcesUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.List;

/**
 * @author Liutingwei
 * @date 2018-11-6 21:44
 */
@Service("trainingDynamicService")
public class TrainingDynamicIServiceImpl implements TrainingDynamicService {
    @Qualifier("trainingDynamicMapper")
    @Autowired
    private TrainingDynamicMapper trainingDynamicMapper;

    /**
     *通过id获取培训动态
     * @param id：培训动态id
     * @return 返回对应的培训动态对象
     */
    @Override
    public TrainingDynamic getTrainingDynamicById(String id) {
        return StringUtil.isEmpty(id)?null:trainingDynamicMapper.getTrainingDynamicById(id);
    }

    @Override
    public List<TrainingDynamic> getTrainingDynamics() {
        return getTrainingDynamics(null, null, null);
    }
    /**
     *分页获取所以培训动态
     * @param currentPage：当前页
     * @param rows：每页要显示的数据条数
     * @param searchContent：模糊查询内容
     * @return
     */
    @Override
    public List<TrainingDynamic> getTrainingDynamics(Integer currentPage, Integer rows, String searchContent) {
            if(currentPage < 0 || rows < 0){
                return null;
            }
            Integer start = (currentPage - 1) * rows;
            return trainingDynamicMapper.getTrainingDynamics(start,rows,searchContent);
    }

    /**
     * 培训动态添加方法
     * @param trainingDynamic：要添加的培训动态
     * @return 返回值大于0表示操作成功，否则操作失败
     */
    @Override
    public Integer add(@Valid TrainingDynamic trainingDynamic) {
        return trainingDynamic == null ? 0:trainingDynamicMapper.add(trainingDynamic);
    }

    /**
     * 培训动态更新方法
     * @param trainingDynamic:要更新的培训动态
     * @return 返回值大于0表示操作成功，否则操作失败
     */
    @Override
    public Integer update(@Valid TrainingDynamic trainingDynamic) {
        return trainingDynamic == null ? 0:trainingDynamicMapper.update(trainingDynamic);
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
            if (this.getTrainingDynamicById(id) != null){//确保要删除对象存在
                result = trainingDynamicMapper.delete(id);
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

    /**
     *
     * @param trainingDynamicIds：多个培训动态ID
     * @return 返回培训类型对象集
     */
    @Override
    public List<TrainingDynamic> getTrainingDynamicsByTrainingDynamics(String trainingDynamicIds) {
        if (StringUtil.isEmpty(trainingDynamicIds))
            return null;
        List<TrainingDynamic> list = new ArrayList<>();
        String[] arr = trainingDynamicIds.split(",");
        for (String id : arr) {
            TrainingDynamic trainingDynamic = this.getTrainingDynamicById(id);
            list.add(trainingDynamic);
        }
        return list;
    }
}
