package com.trainingcenter.service.impl;

import com.trainingcenter.bean.User;
import com.trainingcenter.bean.UserType;
import com.trainingcenter.dao.UserMapper;
import com.trainingcenter.dao.UserTypeMapper;
import com.trainingcenter.exception.DeleteException;
import com.trainingcenter.service.UserService;
import com.trainingcenter.utils.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import javax.validation.Valid;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/10/15
 * Time: 17:29
 */
@Service("userService")
public class UserServiceImpl implements UserService {
    @Qualifier(value = "userMapper")
    @Autowired
    private UserMapper userMapper;

    @Qualifier(value = "userTypeMapper")
    @Autowired
    private UserTypeMapper userTypeMapper;

    /**
     * 通过id获取用户
     *
     * @param id
     * @return
     */
    @Override
    public User getUserById(String id) {
        return StringUtil.isNotEmpty(id) ? userMapper.getUserById(id) : null;
    }

    /**
     * 通过username获取用户
     *
     * @param username
     * @return
     */
    @Override
    public User getUserByUsername(String username) {
        return StringUtil.isNotEmpty(username) ? userMapper.getUserByUsername(username) : null;
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
    public List<User> getUsers(Integer currentPage, Integer rows, String searchContent) {
        if (currentPage < 0 || rows < 0) {
            return null;
        }
        Integer start = (currentPage - 1) * rows;   //计算当前页的数据是从第几条开始查询
        return userMapper.getUsers(start, rows, searchContent);
    }

    /**
     * 用户添加方法
     *
     * @param user：用户对象
     * @return 返回值大于0表示操作成功，否则操作失败
     */
    @Override
    public Integer add(@Valid User user) {
        return user == null ? 0 : userMapper.add(user);
    }

    /**
     * 用户更新方法
     *
     * @param user：用户对象
     * @return 返回值大于0表示操作成功，否则操作失败
     */
    @Override
    public Integer update(@Valid User user) {
        return user == null ? 0 : userMapper.update(user);
    }

    /**
     * 用户删除方法
     *
     * @param id：用户id
     * @return 返回值大于0表示操作成功，否则操作失败
     */
    @Override
    public Integer delete(String id) throws DeleteException {
        Integer result = 0;
        if (StringUtil.isNotEmpty(id)){
            if (this.getUserById(id) != null){//确保要删除对象存在
                result = userMapper.delete(id);
                if (result == 0){
                    throw new DeleteException("删除失败，请稍后重试！");
                }
            }else {
                throw new DeleteException("删除失败，对象不存在或已被删除！");
            }
        }else {
            throw new DeleteException("删除失败，删除对象id不能为空！");
        }
        return result;
    }

    /**
     * 批量删除
     *
     * @param ids：需要删除的对象的id集
     * @return 返回操作成功的数目与操作失败的对象
     */
    @Override
    public Map<String, Object> batchDelete(String ids){

        if (StringUtil.isEmpty(ids))
            return null;

        Map<String, Object> result = new ConcurrentHashMap<>();  //返回结果map

        Integer success = 0; //操作成功的个数
        Map<String, Object> fail = new ConcurrentHashMap<>();  //操作失败的对象

        String[] arr = ids.split(",");  //分割成数组
        for (String id : arr) {
            Integer res = null;
            try {
                res = this.delete(id);
            } catch (DeleteException e) {   //删除失败
                res = 0;
                e.printStackTrace();
            }
            if (res > 0) {
                success += 1;
            } else {
                fail.put(id, this.getUserById(id));
            }
        }

        result.put("success", success);
        result.put("fail", fail);

        return result;
    }

    /**
     * 获取当前用户的用户类型
     *
     * @param userId：用户id
     * @return 返回用户类型对象
     */
    @Override
    public UserType getUserTypeByUserId(String userId) {
        if (StringUtil.isEmpty(userId)) {
            return null;
        }
        User user = this.getUserById(userId);

        return user == null ? null : userTypeMapper.getUserTypeById(user.getUserTypeId());
    }
}