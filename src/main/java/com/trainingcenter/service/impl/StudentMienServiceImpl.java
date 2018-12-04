package com.trainingcenter.service.impl;

import com.trainingcenter.bean.StudentMien;
import com.trainingcenter.dao.StudentMienMapper;
import com.trainingcenter.exception.DeleteException;
import com.trainingcenter.service.StudentMienService;
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
import java.util.concurrent.ConcurrentHashMap;

/**
 * @author Liutingwei
 * @date 2018-11-6 21:44
 */
@Service("studentMienService")
public class StudentMienServiceImpl implements StudentMienService {
    @Qualifier(value = "studentMienMapper")
    @Autowired
    private StudentMienMapper studentMienMapper;

    /**
     *通过id获取学生风采
     * @param id：学生风采id
     * @return 返回对应的学生风采对象
     */
    @Override
    public StudentMien getStudentMienById(String id) {
        return StringUtil.isEmpty(id)?null:studentMienMapper.getStudentMienById(id);
    }

    public List<StudentMien> getStudentMiens(){
        return getStudentMiens(null,null,null);
    }
    /**
     *分页获取所以学生风采
     * @param currentPage：当前页
     * @param rows：每页要显示的数据条数
     * @param searchContent：模糊查询内容
     * @return
     */
    public List<StudentMien> getStudentMiens(Integer currentPage, Integer rows, String searchContent) {
        if(currentPage != null && rows != null) {
            if (currentPage < 0 || rows < 0) {
                return null;
            }
            Integer start = (currentPage - 1) * rows;
            return studentMienMapper.getStudentMiens(start, rows, searchContent);
        }
        else {
            return studentMienMapper.getStudentMiens(null,null,searchContent);
        }
    }

    /**
     * 学生风采添加方法
     * @param studentMien：要添加的学生风采
     * @return 返回值大于0表示操作成功，否则操作失败
     */
    @Override
    public Integer add(@Valid StudentMien studentMien) {
        return studentMien == null ? 0:studentMienMapper.add(studentMien);
    }

    /**
     * 学生风采更新方法
     * @param studentMien:要更新的学生风采
     * @return 返回值大于0表示操作成功，否则操作失败
     */
    @Override
    public Integer update(@Valid StudentMien studentMien) {
        return studentMien == null ? 0:studentMienMapper.update(studentMien);
    }

    /**
     * 学生风采删除方法
     * @param id：学生风采id
     * @return 返回值大于0表示操作成功，否则操作失败
     * @throws DeleteException
     */
    @Override
    public Integer delete(String id) throws DeleteException {
        Integer result = 0;
        if (StringUtil.isNotEmpty(id)){
            if (this.getStudentMienById(id) != null){//确保要删除对象存在
                result = studentMienMapper.delete(id);
                if (result == 0){
                    throw new DeleteException("删除失败，请稍后重试！");
                }
            }else {
                throw new DeleteException("删除失败，学生风采不存在或已被删除！");
            }
        }else {
            throw new DeleteException("删除失败，删除学生风采id不能为空！");
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

        //获取当前登录用户
        String currentUsername = SysResourcesUtils.getCurrentUsername();
        LogUtil.info(this, "资源批量删除", "用户：【" + currentUsername + "】正在批量删除IDS为：【" + ids + "】的资源");

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
