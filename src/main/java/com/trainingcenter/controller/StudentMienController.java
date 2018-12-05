package com.trainingcenter.controller;

import com.trainingcenter.bean.StudentMien;
import com.trainingcenter.bean.StudentMien;
import com.trainingcenter.bean.User;
import com.trainingcenter.controller.validation.TC_Add;
import com.trainingcenter.controller.validation.TC_Update;
import com.trainingcenter.exception.UpdateException;
import com.trainingcenter.service.StudentMienService;
import com.trainingcenter.service.StudentMienService;
import com.trainingcenter.service.UserService;
import com.trainingcenter.utils.AjaxJson;
import com.trainingcenter.utils.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

import static com.trainingcenter.utils.SysResourcesUtils.getCurrentUsername;

/**
 * @author Liutingwei
 * @date 2018-11-9 19:45
 */
@RequestMapping("/studentMien")
@Controller
public class StudentMienController {


    @Qualifier("studentMienService")
    @Autowired
    private StudentMienService studentMienService;

    @Qualifier("userService")
    @Autowired
    private UserService userService;

    @RequestMapping(value = "/listPage",method = RequestMethod.GET)
    @ResponseBody
    public AjaxJson listPage(@RequestParam("currentPage") Integer currentPage, @RequestParam("rows") Integer rows, String searchContent){
        AjaxJson ajaxJson = new AjaxJson();
        if(currentPage < 0 || rows < 0 ){
            ajaxJson.setCode(0);
            ajaxJson.setMsg("参数异常");
            return ajaxJson;        }
        List<StudentMien> studentMiens = studentMienService.getStudentMiens(currentPage, rows, searchContent);
        Integer total = studentMienService.getStudentMiens().size();

        if (studentMiens.size() == 0){
            ajaxJson.setCode(0);
            ajaxJson.setMsg("暂无数据");
        }else {
            ajaxJson.setCode(1);
            ajaxJson.setMsg("操作成功");
        }

        Map<String,Object> data = new ConcurrentHashMap<>();
        data.put("total",total);
        data.put("items",studentMiens);
        ajaxJson.setData(data);
        return ajaxJson;
    }

    /**
     * 通过 id 获取资源对象
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/getStudentMienById")
    public AjaxJson getStudentMienById(@RequestParam("id") String id) {
        AjaxJson ajaxJson = new AjaxJson();
        if (StringUtil.isEmpty(id)) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("请先选择要查询的对象");
            return ajaxJson;
        }

        StudentMien resource = studentMienService.getStudentMienById(id);
        if (resource == null) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("对象不存在或已被删除");
            return ajaxJson;
        } else {
            ajaxJson.setCode(1);
            ajaxJson.setMsg("获取成功");
            Map<String, Object> map = new ConcurrentHashMap<>();
            map.put("studentMien", resource);
            ajaxJson.setData(map);
            return ajaxJson;
        }
    }

    @RequestMapping(value = "/update",method = RequestMethod.GET)
    @ResponseBody
    public AjaxJson update(@Validated(value = {TC_Update.class}) StudentMien studentMine){
        AjaxJson ajaxJson = new AjaxJson();
        Integer res;    //操作结果 flag


        //获取当前用户
        String currentName = getCurrentUsername();
        User user = userService.getUserByUsername(currentName);

        if (user == null){
            throw new CredentialsExpiredException("登录凭证已过期");
        }

        if (studentMine == null){
            ajaxJson.setCode(0);
            ajaxJson.setMsg("操作失败，对象不能为空");
            return ajaxJson;

        }
        //更新操作
        //当前ID
        StudentMien newAd = studentMienService.getStudentMienById(studentMine.getId());
        if (newAd == null){
            throw new UpdateException("更新失败，对象不存在或已被删除");
        }else {
            if (StringUtil.isNotEmpty(studentMine.getImgs())) {
                newAd.setImgs(studentMine.getImgs());
            }
            if (StringUtil.isNotEmpty(studentMine.getRemarks())) {
                newAd.setRemarks(studentMine.getRemarks());
            }
            if (StringUtil.isNotEmpty(studentMine.getContent())) {
                newAd.setContent(studentMine.getContent());
            }
            if(StringUtil.isNotEmpty(studentMine.getTitle())){
                newAd.setTitle(studentMine.getTitle());
            }
            newAd.setUpdateUserId(user.getId());
            newAd.setUpdateDate(new Date());

            res = studentMienService.update(newAd);
        }
        if (res == 0){
            ajaxJson.setCode(0);
            ajaxJson.setMsg("操作失败，请重试");
            return ajaxJson;
        }else {
            ajaxJson.setCode(1);
            ajaxJson.setMsg("操作成功");
            return ajaxJson;
        }
    }


    @RequestMapping(value = "/add",method = RequestMethod.GET)
    @ResponseBody
    public AjaxJson add(@Validated(value = {TC_Add.class}) StudentMien studentMien){
        AjaxJson ajaxJson = new AjaxJson();
            //获取当前用户
            String currentName = getCurrentUsername();

            User user = userService.getUserByUsername(currentName);

            //非空验证
            if (studentMien == null) {
                ajaxJson.setCode(0);
                ajaxJson.setMsg("操作对象为空，操作失败");
            }
            //资料添加

            studentMien.setId(UUID.randomUUID().toString());
            studentMien.setCreateUserId(user.getId());
            studentMien.setCreateDate(new Date());

            if(StringUtil.length(studentMien.getContent())>100) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("内容过长，请重新编辑");
            return ajaxJson;
            }
            Integer add = studentMienService.add(studentMien);
            if (add == 1) {
                ajaxJson.setCode(1);
                ajaxJson.setMsg("添加成功");
            } else {
                ajaxJson.setCode(0);
                ajaxJson.setMsg("添加失败，请稍后重试");
            }

        return ajaxJson;
    }

    @ResponseBody
    @RequestMapping(value = "/delete")
    public AjaxJson delete(@RequestParam("ids") String ids) {
        AjaxJson ajaxJson = new AjaxJson();

        if (StringUtil.isEmpty(ids)){
            ajaxJson.setCode(0);
            ajaxJson.setMsg("删除失败，请先选择要删除的对象");
            return ajaxJson;
        }

        Integer delete = studentMienService.batchDelete(ids);
        if (delete == 1){
            ajaxJson.setCode(1);
            ajaxJson.setMsg("删除成功");
        }else {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("删除失败，请稍后重试");
        }

        return ajaxJson;
    }
}
