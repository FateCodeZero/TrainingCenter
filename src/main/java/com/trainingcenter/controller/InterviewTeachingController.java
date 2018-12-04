package com.trainingcenter.controller;

import com.trainingcenter.bean.InterviewTeaching;
import com.trainingcenter.bean.User;
import com.trainingcenter.controller.validation.TC_Update;
import com.trainingcenter.exception.UpdateException;
import com.trainingcenter.service.InterviewTeachingService;
import com.trainingcenter.service.UserService;
import com.trainingcenter.utils.AjaxJson;
import com.trainingcenter.utils.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
@RequestMapping("/interviewTeaching")
@Controller
public class InterviewTeachingController {


    @Qualifier("interviewTeachingService")
    @Autowired
    private InterviewTeachingService interviewTeachingService;

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
        List<InterviewTeaching> interviewTeachings = interviewTeachingService.getInterviewTeachings(currentPage, rows, searchContent);
        Integer total = interviewTeachingService.getInterviewTeachings().size();

        if (interviewTeachings.size() == 0){
            ajaxJson.setCode(0);
            ajaxJson.setMsg("暂无数据");
        }else {
            ajaxJson.setCode(1);
            ajaxJson.setMsg("操作成功");
        }

        Map<String,Object> data = new ConcurrentHashMap<>();
        data.put("total",total);
        data.put("items",interviewTeachings);
        ajaxJson.setData(data);
        return ajaxJson;
    }

    /**
     * 进入详细页面
     *
     * @return loginPage
     */
    @RequestMapping(value = "/detailsPage", method = RequestMethod.GET)
    @ResponseBody
    public AjaxJson detailsPage(@RequestParam("id") String id) {
        AjaxJson ajaxJson = new AjaxJson();
        if(StringUtil.isNotEmpty(id)){
            InterviewTeaching interviewTeaching = interviewTeachingService.getInterviewTeachingById(id);
            if (interviewTeaching == null){
                ajaxJson.setCode(1);
                ajaxJson.setMsg("暂无数据");
                return ajaxJson;
            }else{
                ajaxJson.setCode(1);
                ajaxJson.setMsg("請求成功");
                Map<String, Object> map = new ConcurrentHashMap<>(); //返回携带的数据
                map.put("items",interviewTeaching);
                ajaxJson.setData(map);
                return ajaxJson;
            }
        }else {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("id异常请检查");
        }
        return ajaxJson;
    }

    /**
     * 进入添加页面
     *
     * @return loginPage
     */
    @RequestMapping(value = "/addPage", method = RequestMethod.GET)
    public ModelAndView addPage(HttpServletRequest request) {
        String id = request.getParameter("interviewTeachingId");
        ModelAndView modelAndView =new ModelAndView();
        if(StringUtil.isNotEmpty(id)){
            String viewName = "admin/TD_addPage";
            modelAndView.addObject("interviewTeaching",interviewTeachingService.getInterviewTeachingById(id));
            modelAndView.setViewName(viewName);

        }
        return modelAndView;
    }

    /**
     * 进入更新页面
     *
     * @return loginPage
     */
    @RequestMapping(value = "/updatePage", method = RequestMethod.GET)
    public ModelAndView updatePage(HttpServletRequest request) {
        String id = request.getParameter("interviewTeachingId");
        ModelAndView modelAndView =new ModelAndView();
        if(StringUtil.isNotEmpty(id)){
            String viewName = "admin/TD_updatePage";
            modelAndView.addObject("interviewTeaching",interviewTeachingService.getInterviewTeachingById(id));
            modelAndView.setViewName(viewName);
        }
        return modelAndView;
    }

    @RequestMapping(value = "/update",method = RequestMethod.GET)
    @ResponseBody
    public AjaxJson update(@Validated(value = {TC_Update.class}) InterviewTeaching interviewTeaching){
        AjaxJson ajaxJson = new AjaxJson();
        Integer res;    //操作结果 flag


        //获取当前用户
        String currentName = getCurrentUsername();
        User user = userService.getUserByUsername(currentName);

        if (user == null){
            throw new CredentialsExpiredException("登录凭证已过期");
        }

        if (interviewTeaching == null){
            ajaxJson.setCode(0);
            ajaxJson.setMsg("操作失败，对象不能为空");
            return ajaxJson;

        }
        //更新操作
        InterviewTeaching newTD = interviewTeachingService.getInterviewTeachingById(interviewTeaching.getId());
        if (newTD == null){
            throw new UpdateException("更新失败，对象不存在或已被删除");
        }
        newTD.setTitle(interviewTeaching.getTitle());
        newTD.setRemarks(interviewTeaching.getRemarks());
        newTD.setContent(interviewTeaching.getContent());
        newTD.setImgs(interviewTeaching.getImgs());
        newTD.setUpdateDate(new Date());
        newTD.setUpdateUserId(user.getId());

        res=interviewTeachingService.update(newTD);
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


    public AjaxJson add(@RequestParam("title") String title, @RequestParam("imgs") String imgs
            , @RequestParam("content") String content, String remarks){
        AjaxJson ajaxJson = new AjaxJson();

        //获取当前用户
        String currentName = getCurrentUsername();

        User user = userService.getUserByUsername(currentName);

        //非空验证
        if (StringUtil.isEmpty(title)) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("标题不能为空");
            return ajaxJson;
        }
        if (StringUtil.isEmpty(imgs)) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("图片不能为空");
            return ajaxJson;
        }
        if (StringUtil.isEmpty(content)) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("内容不能为空");
            return ajaxJson;
        }
        //资料添加
        InterviewTeaching interviewTeaching = new InterviewTeaching();
        interviewTeaching.setId(UUID.randomUUID().toString());
        interviewTeaching.setImgs(imgs);
        interviewTeaching.setContent(content);
        interviewTeaching.setRemarks(remarks);
        interviewTeaching.setCreateUserId(user.getId());
        interviewTeaching.setCreateDate(new Date());
        Integer add = interviewTeachingService.add(interviewTeaching);
        if (add==1){
            ajaxJson.setCode(1);
            ajaxJson.setMsg("添加成功");
        }else {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("添加失败，请稍后重试");
        }

        return ajaxJson;
    }

    @RequestMapping(value = "/delete", method = RequestMethod.GET)
    public AjaxJson delete(@RequestParam("ids") String ids) {
        AjaxJson ajaxJson = new AjaxJson();

        if (StringUtil.isEmpty(ids)){
            ajaxJson.setCode(0);
            ajaxJson.setMsg("删除失败，请先选择要删除的对象");
            return ajaxJson;
        }

        Integer delete = interviewTeachingService.batchDelete(ids);
        if (delete==1){
            ajaxJson.setCode(1);
            ajaxJson.setMsg("删除成功");
        }else {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("删除失败，请稍后重试");
        }

        return ajaxJson;
    }
}
