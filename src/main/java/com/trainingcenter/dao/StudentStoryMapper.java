package com.trainingcenter.dao;

import com.trainingcenter.bean.StudentStory;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import javax.validation.Valid;
import java.util.List;
import java.util.Map;

/**
 * @author Liutingwei
 * @date 2018-11-7 15:44
 */
@Repository("studentStoryMapper")
public interface StudentStoryMapper {
    /**
     *
     * @param id 学员风采的ID
     * @return 学员风采
     */
    public StudentStory getStudentStoryById(@Param("id") String id);

    /**
     * 分页获取所有学员风采
     * @param start：从第几条数据开始
     * @param number：要获取多少条数据
     * @param searchContent：模糊查询内容
     * @return 返回学员风采对象集合
     */
    public List<StudentStory> getStudentStorys(@Param("start") Integer start, @Param("number") Integer number,
                                               @Param("condition") Map<String,Object> condition);


    /**
     * 学员风采添加方法
     * @param studentStory 学员风采
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer add(@Valid @Param("studentStory") StudentStory studentStory);


    /**
     * 学员风采更新方法
     * @param studentStory：要更新的学员风采
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer update(@Valid @Param("studentStory") StudentStory studentStory);

    /**
     * 学员风采删除方法
     * @param id：学员风采id
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer delete(@Param("id") String id);


}
