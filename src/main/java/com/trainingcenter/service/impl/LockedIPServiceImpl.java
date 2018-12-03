package com.trainingcenter.service.impl;

import com.trainingcenter.bean.LockedIP;
import com.trainingcenter.dao.LockedIPMapper;
import com.trainingcenter.exception.DeleteException;
import com.trainingcenter.exception.InsertException;
import com.trainingcenter.exception.UpdateException;
import com.trainingcenter.service.LockedIPService;
import com.trainingcenter.utils.LogUtil;
import com.trainingcenter.utils.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/12/3
 * Time: 20:07
 */
@Service("lockedIPService")
public class LockedIPServiceImpl implements LockedIPService {
    @Qualifier("lockedIPMapper")
    @Autowired
    private LockedIPMapper lockedIPMapper;

    /**
     * 通过 id 获取锁定对象
     * @return
     */
    @Override
    public LockedIP getLockedIPById(String id) {
        return StringUtil.isEmpty(id) ? null:lockedIPMapper.getLockedIPById(id);
    }

    /**
     * 通过 IP 获取锁定对象
     * @return
     */
    @Override
    public LockedIP getLockedIPByIP(String IP) {
        return StringUtil.isEmpty(IP) ? null:lockedIPMapper.getLockedIPByIP(IP);
    }

    /**
     * 获取所有数据
     * @param condition：自定义查询条件，模糊查询的 key 固定为 searchContent
     * @return 返回锁定对象集合
     */
    @Override
    public List<LockedIP> getLockedIPs(Map<String, Object> condition) {
        return getLockedIPs(null,null,condition);
    }

    /**
     * 分页获取所有数据
     * @param currentPage：当前页
     * @param rows：每页要显示的数据条数
     * @param condition：自定义查询条件，模糊查询的 key 固定为 searchContent
     * @return 返回锁定对象集合
     */
    @Override
    public List<LockedIP> getLockedIPs(Integer currentPage, Integer rows, Map<String, Object> condition) {
        if (currentPage != null && rows != null) {
            if (currentPage < 0 || rows < 0) {
                return null;
            } else {
                Integer start = (currentPage - 1) * rows;   //计算当前页的数据是从第几条开始查询
                return lockedIPMapper.getLockedIPs(start, rows, condition);
            }
        } else {
            return lockedIPMapper.getLockedIPs(null, null, condition);
        }
    }

    /**
     * 数据添加
     * @param lockedIP：要添加的数据对象
     * @return 返回操作成功的个数，0表示操作失败
     */
    @Override
    public Integer add(LockedIP lockedIP) {
        InsertException insertException;
        if (lockedIP == null){
            insertException = new InsertException("添加失败，添加对象不能为空");
            throw insertException;
        }
        return lockedIPMapper.add(lockedIP);
    }

    /**
     * 数据更新
     * @param lockedIP：要更新的数据对象
     * @return 返回操作成功的个数，0表示操作失败
     */
    @Override
    public Integer update(LockedIP lockedIP) {
        UpdateException updateException;
        if (lockedIP == null){
            updateException = new UpdateException("更新失败，请先选择更新对象");
            throw updateException;
        }
        return lockedIPMapper.update(lockedIP);
    }

    /**
     * 数据删除
     * @param id：要删除的数据id
     * @return 返回操作成功的个数，0表示操作失败
     */
    @Override
    public Integer delete(String id) {
        DeleteException deleteException; //删除异常
        if (StringUtil.isEmpty(id)) {
            deleteException = new DeleteException("删除失败，删除对象不能为空");
            throw deleteException;
        }
        LockedIP lockedIP = lockedIPMapper.getLockedIPById(id);
        if (lockedIP == null){
            deleteException = new DeleteException("删除失败，对象不存在或已被删除");
            throw deleteException;
        }
        Integer delete = lockedIPMapper.delete(id);
        if (delete == 0){
            deleteException = new DeleteException("删除失败，请重试");
            LogUtil.warn(this, "IP解封", "未知错误：对象存在却删除失败！");
            throw deleteException;
        }

        return delete;
    }

    /**
     * 批量删除
     * @param ids：需要删除的对象的id集
     * @return
     */
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