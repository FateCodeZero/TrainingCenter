package com.trainingcenter.service.impl;

import com.trainingcenter.bean.Comment;
import com.trainingcenter.controller.validation.TC_Add;
import com.trainingcenter.controller.validation.TC_Update;
import com.trainingcenter.dao.CommentMapper;
import com.trainingcenter.exception.DeleteException;
import com.trainingcenter.exception.InsertException;
import com.trainingcenter.exception.UpdateException;
import com.trainingcenter.service.CommentService;
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
@Service("commentService")
public class CommentServiceImpl implements CommentService {
    @Qualifier("commentMapper")
    @Autowired
    CommentMapper commentMapper;

    /**
     * 通过 id 获取资源信息
     * @param id ：资源ID
     * @return 返回资源对象
     */
    @Override
    public Comment getCommentById(String id) {
        return StringUtil.isEmpty(id) ? null : commentMapper.getCommentById(id);
    }

    /**
     * 获取所有资源对象
     * @param condition：自定义查询条件，模糊查询的 key 固定为 searchContent
     * @return 返回资源对象集合
     */
    @Override
    public List<Comment> getComments(Map<String,Object> condition) {
        return getComments(null, null, condition);
    }

    /**
     * 获取所有资源对象，支持分页
     * @param currentPage：当前页
     * @param rows：每页要显示的数据条数
     * @param condition：自定义查询条件，模糊查询的 key 固定为 searchContent
     * @return 返回资源对象集合
     */
    @Override
    public List<Comment> getComments(Integer currentPage, Integer rows, Map<String,Object> condition) {
        if (currentPage != null && rows != null) {
            if (currentPage < 0 || rows < 0) {
                return null;
            } else {
                Integer start = (currentPage - 1) * rows;   //计算当前页的数据是从第几条开始查询
                return commentMapper.getComments(start, rows, condition);
            }
        } else {
            return commentMapper.getComments(null, null, condition);
        }
    }

    @Override
    public Integer add(@Validated(value = {TC_Add.class}) Comment comment) {
        InsertException insertException;
        if (comment == null){
            insertException = new InsertException("添加失败，添加对象不能为空");
            throw insertException;
        }
        Integer add = commentMapper.add(comment);
        if (add == 0) {
            insertException = new InsertException("添加失败，请重试");
            throw insertException;
        }
        return add;
    }

    @Override
    public Integer update(@Validated(value = {TC_Update.class}) Comment comment) {
        UpdateException updateException;
        if (comment == null){
            updateException = new UpdateException("更新失败，请先选择更新对象");
            throw updateException;
        }
        Integer update = commentMapper.update(comment);
        if (update == 0){
            updateException = new UpdateException("更新失败，请重试");
            throw updateException;
        }
        return update;
    }

    @Override
    public Integer delete(String id) {
        DeleteException deleteException;
        if (StringUtil.isEmpty(id)){
            deleteException = new DeleteException("删除失败，请先选择要删除的对象");
            throw deleteException;
        }

        //保证删除对象存在
        Comment comment = getCommentById(id);
        if (comment == null){
            deleteException = new DeleteException("删除失败，对象不存在或已被删除");
            throw deleteException;
        }

        //实行软删除
        comment.setState(-1);
        Integer delete = commentMapper.update(comment);

        if (delete == 0){
            deleteException = new DeleteException("删除失败，请稍后重试");
            throw deleteException;
        }
        
        return delete;
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