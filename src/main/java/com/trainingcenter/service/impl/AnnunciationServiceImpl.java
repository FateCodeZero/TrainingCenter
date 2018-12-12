package com.trainingcenter.service.impl;

import com.trainingcenter.bean.Annunciation;
import com.trainingcenter.dao.AnnunciationMapper;
import com.trainingcenter.exception.DeleteException;
import com.trainingcenter.exception.FindException;
import com.trainingcenter.service.AnnunciationService;
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

/**
 * @author Liutingwei
 * @date 2018-11-6 21:44
 */
@Service("annunciationService")
public class AnnunciationServiceImpl implements AnnunciationService {
    @Qualifier("annunciationMapper")
    @Autowired
    private AnnunciationMapper annunciationMapper;

    /**
     *通过id获取培训动态
     * @param id：培训动态id
     * @return 返回对应的培训动态对象
     */
    @Override
    public Annunciation getAnnunciationById(String id) {
        return StringUtil.isEmpty(id)?null:annunciationMapper.getAnnunciationById(id);
    }

    @Override
    public List<Annunciation> getAnnunciations(Map<String,Object> condition) {
        return getAnnunciations(null, null, condition);
    }
    /**
     *分页获取所以培训动态
     * @param currentPage：当前页
     * @param rows：每页要显示的数据条数
     * @param condition：模糊查询内容
     * @return
     */
    @Override
    public List<Annunciation> getAnnunciations(Integer currentPage, Integer rows, Map<String,Object> condition) {
            if(currentPage != null && rows != null) {
                if (currentPage < 0 || rows < 0) {
                    return null;
                }
                Integer start = (currentPage - 1) * rows;
                return annunciationMapper.getAnnunciations(start, rows, condition);
            }
            else {
                return annunciationMapper.getAnnunciations(null,null,condition);
            }
    }

    /**
     * 培训动态添加方法
     * @param annunciation：要添加的培训动态
     * @return 返回值大于0表示操作成功，否则操作失败
     */
    @Override
    public Integer add(@Valid Annunciation annunciation) {
        return annunciation == null ? 0:annunciationMapper.add(annunciation);
    }

    /**
     * 培训动态更新方法
     * @param annunciation:要更新的培训动态
     * @return 返回值大于0表示操作成功，否则操作失败
     */
    @Override
    public Integer update(@Valid Annunciation annunciation) {
        return annunciation == null ? 0:annunciationMapper.update(annunciation);
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
            if (this.getAnnunciationById(id) != null){//确保要删除对象存在
                result = annunciationMapper.delete(id);
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

}
