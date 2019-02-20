package com.trainingcenter.service;

import com.trainingcenter.bean.StudentMien;
import com.trainingcenter.exception.DeleteException;
import org.apache.ibatis.annotations.Param;

import javax.validation.Valid;
import java.util.List;
import java.util.Map;

/**
 * @author Liutingwei
 * @date 2018-11-6 21:34
 */
public interface StudentMienService {

    /**
     * 通过id获取学生风采
     * @param id：学生风采id
     * @return 返回对应的学生风采对象
     */
    public StudentMien getStudentMienById(String id);

    public List<StudentMien> getStudentMiens(Map<String,Object> condition);
    /**
     * 分页获取所有学生风采
     *
     * @param currentPage：当前页
     * @param rows：每页要显示的数据条数
     * @param condition：模糊查询内容
     * @return 返回当前页的数据集合
     */
    public List<StudentMien> getStudentMiens(Integer currentPage, Integer rows, Map<String,Object> condition);

    /**
     * 学生风采添加方法
     * @param studentMien：要添加的学生风采
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer add(@Valid @Param("studentMien") StudentMien studentMien);

    /**
     * 学生风采更新方法
     *
     * @param sysLog:要更新的学生风采
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer update(@Valid StudentMien sysLog);

    /**
     * 学生风采删除方法
     *
     * @param id：学生风采id
     * @return 返回操作成功的个数，0表示操作失败
     */
    public Integer delete(String id) throws DeleteException;

    /**
     * 批量删除
     * @param ids：需要删除的对象的id集
     * @return 返回操作成功的数目与操作失败的对象
     */
    public Integer batchDelete(String ids);

}
