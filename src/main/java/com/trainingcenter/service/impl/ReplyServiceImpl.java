package com.trainingcenter.service.impl;

import com.trainingcenter.bean.Reply;
import com.trainingcenter.controller.validation.TC_Add;
import com.trainingcenter.controller.validation.TC_Update;
import com.trainingcenter.dao.ReplyMapper;
import com.trainingcenter.exception.DeleteException;
import com.trainingcenter.exception.FindException;
import com.trainingcenter.exception.InsertException;
import com.trainingcenter.exception.UpdateException;
import com.trainingcenter.service.ReplyService;
import com.trainingcenter.utils.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.annotation.Validated;

import java.util.List;
import java.util.Map;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/11/18
 * Time: 5:24
 */
@Service("replyService")
public class ReplyServiceImpl implements ReplyService {
    @Qualifier("replyMapper")
    @Autowired
    ReplyMapper replyMapper;

    /**
     * 通过 id 获取资源信息
     * @param id ：资源ID
     * @return 返回资源对象
     */
    @Override
    public Reply getReplyById(String id) {
        return StringUtil.isEmpty(id) ? null : replyMapper.getReplyById(id);
    }

    /**
     * 获取所有资源对象
     * @param condition：自定义查询条件，模糊查询的 key 固定为 searchContent
     * @return 返回资源对象集合
     */
    @Override
    public List<Reply> getReplys(Map<String,Object> condition) {
        return getReplys(null, null, condition);
    }

    /**
     * 获取所有资源对象，支持分页
     * @param currentPage：当前页
     * @param rows：每页要显示的数据条数
     * @param condition：自定义查询条件，模糊查询的 key 固定为 searchContent
     * @return 返回资源对象集合
     */
    @Override
    public List<Reply> getReplys(Integer currentPage, Integer rows, Map<String,Object> condition) {
        if (currentPage != null && rows != null) {
            if (currentPage < 0 || rows < 0) {
                return null;
            } else {
                Integer start = (currentPage - 1) * rows;   //计算当前页的数据是从第几条开始查询
                return replyMapper.getReplys(start, rows, condition);
            }
        } else {
            return replyMapper.getReplys(null, null, condition);
        }
    }


    @Override
    public List<Reply> getReplyByCommentId(String commentId,Map<String,Object> condition) {
        return replyMapper.getReplysByCommentId(commentId,null,null,condition);
    }

    @Override
    public List<Reply> getReplyByCommentId(String commentId, Integer currentPage, Integer rows, Map<String, Object> condition) {
        FindException findException;
        if (StringUtil.isEmpty(commentId)){
            return null;
        }

        if (currentPage != null && rows != null) {
            if (currentPage < 0 || rows < 0) {
                findException = new FindException("分页查询不能的页数或查询数量小于0");
                throw findException;
            } else {
                Integer start = (currentPage - 1) * rows;   //计算当前页的数据是从第几条开始查询
                return replyMapper.getReplysByCommentId(commentId,start,rows,condition);
            }
        } else {
            return replyMapper.getReplysByCommentId(commentId,null, null, condition);
        }
    }

    @Override
    public Integer add(@Validated(value = {TC_Add.class}) Reply reply) {
        InsertException insertException;
        if (reply == null){
            insertException = new InsertException("添加失败，添加对象不能为空");
            throw insertException;
        }
        Integer add = replyMapper.add(reply);
        if (add == 0) {
            insertException = new InsertException("添加失败，请重试");
            throw insertException;
        }
        return add;
    }

    @Override
    public Integer update(@Validated(value = {TC_Update.class}) Reply reply) {
        UpdateException updateException;
        if (reply == null){
            updateException = new UpdateException("更新失败，请先选择更新对象");
            throw updateException;
        }
        Integer update = replyMapper.update(reply);
        if (update == 0){
            updateException = new UpdateException("更新失败，请重试");
            throw updateException;
        }
        return update;
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
            if (this.getReplyById(id) != null){//确保要删除对象存在
                result = replyMapper.delete(id);
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