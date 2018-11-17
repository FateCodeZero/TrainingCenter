package com.trainingcenter.service.impl;

import com.trainingcenter.bean.UserInfo;
import com.trainingcenter.controller.validation.TC_Add;
import com.trainingcenter.controller.validation.TC_Update;
import com.trainingcenter.dao.UserInfoMapper;
import com.trainingcenter.exception.DeleteException;
import com.trainingcenter.service.UserInfoService;
import com.trainingcenter.utils.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/15
 * Time: 17:29
 */
@Service("userInfoService")
public class UserInfoServiceImpl implements UserInfoService {
    @Qualifier(value = "userInfoMapper")
    @Autowired
    private UserInfoMapper userInfoMapper;

    /**
     * 通过id获取用户信息
     *
     * @param id
     * @return
     */
    @Override
    public UserInfo getUserInfoById(String id) {
        return StringUtil.isNotEmpty(id) ? userInfoMapper.getUserInfoById(id) : null;
    }

    /**
     * 通过username获取用户
     *
     * @param username
     * @return
     */
    @Override
    public UserInfo getUserInfoByUsername(String username) {
        return StringUtil.isNotEmpty(username) ? userInfoMapper.getUserInfoByUsername(username) : null;
    }

    /**
     * 分页获取所有用户
     *
     * @param currentPage：当前页
     * @param rows：每页要显示的数据条数
     * @param searchContent：模糊查询内容
     * @return 返回当前页的数据集合
     */
    @Override
    public List<UserInfo> getUserInfos(Integer currentPage, Integer rows, String searchContent) {
        Integer start = null;
        if (currentPage != null && rows != null ) {
            if (currentPage < 0 || rows < 0){
                return null;
            }else {
                start = (currentPage - 1) * rows;   //计算当前页的数据是从第几条开始查询
            }
        }
        return userInfoMapper.getUserInfos(start, rows, searchContent);
    }

    /**
     * 用户添加方法
     *
     * @param user：用户对象
     * @return 返回值大于0表示操作成功，否则操作失败
     */
    @Override
    public Integer add(@Validated(value = {TC_Add.class}) UserInfo user) {
        return user == null ? 0 : userInfoMapper.add(user);
    }

    /**
     * 用户更新方法
     *
     * @param user：用户对象
     * @return 返回值大于0表示操作成功，否则操作失败
     */
    @Override
    public Integer update(@Validated(value = {TC_Update.class}) UserInfo user) {
        return user == null ? 0 : userInfoMapper.update(user);
    }

    /**
     * 用户删除方法
     *
     * @param id：用户id
     * @return 返回值大于0表示操作成功，否则操作失败
     */
    @Override
    public Integer delete(String id) throws DeleteException {
        return StringUtil.isEmpty(id)?0:userInfoMapper.delete(id);
    }

    /**
     * 批量删除
     *
     * @param ids：需要删除的对象的id集
     * @return 返回操作结果状态（true：成功，false：失败）
     */
    @Override
    public boolean batchDelete(String ids){
        DeleteException deleteException;
        if (StringUtil.isEmpty(ids))
            return false;

        String[] arr = ids.split(",");  //分割成数组
        Integer res;
        for (String id : arr) {
            res = this.delete(id);
            if (res == 0) {
                deleteException = new DeleteException("删除失败");
                throw deleteException;
            }
        }
        return true;
    }
}