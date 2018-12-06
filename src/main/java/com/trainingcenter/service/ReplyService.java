package com.trainingcenter.service;

import com.trainingcenter.bean.Reply;
import com.trainingcenter.exception.DeleteException;
import org.apache.ibatis.annotations.Param;

import javax.validation.Valid;
import java.util.List;
import java.util.Map;

/**
 * @author Liutingwei
 * @date 2018-11-6 21:34
 */
public interface ReplyService {
    /**
     * 通过id获取培训动态
     * @param id：培训动态id
     * @return 返回对应的培训动态对象
     */
    public Reply getReplyById(String id);
    /**
     * 获取所有资源对象，不分页
     * @param condition：自定义查询条件，模糊查询的 key 固定为 searchContent
     * @return 返回资源对象集合
     */
    public List<Reply> getReplys(Map<String,Object> condition);

    /**
     * 获取所有资源对象，支持分页
     * @param currentPage：当前页
     * @param rows：每页要显示的数据条数
     * @param condition：自定义查询条件，模糊查询的 key 固定为 searchContent
     * @return 返回资源对象集合
     */
    public List<Reply> getReplys(Integer currentPage, Integer rows, Map<String,Object> condition);


    /**
     * 培训动态添加方法
     * @param reply：要添加的培训动态
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer add(@Valid @Param("reply") Reply reply);

    /**
     * 培训动态更新方法
     *
     * @param reply:要更新的动态培训
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer update(@Valid Reply reply);

    /**
     * 动态培训删除方法
     *
     * @param id：动态培训id
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer delete(String id) throws DeleteException;

    /**
     * 批量删除
     *
     * @param ids：需要删除的对象的id集
     * @return 返回操作结果（true：删除成功，false：删除失败）
     * 添加事务，保证中间删除失败时可以回滚
     */
    public Integer batchDelete(String ids);

    public List<Reply> getReplyByCommentId(String commentId,Map<String,Object> condition);

    /**
     * 获取指定登录用户所含有的全部角色
     *
     * @param commentId：用户登录信息id
     * @param currentPage：当前页
     * @param rows：每页要显示的数据条数
     * @param condition：自定义查询条件，模糊查询的 key 固定为 searchContent
     * @return 返回该用户所拥有的所有角色，支持分页、模糊查询
     */
    public List<Reply> getReplyByCommentId(String commentId,Integer currentPage, Integer rows, Map<String,Object> condition);
}
