package com.trainingcenter.controller;

import com.trainingcenter.bean.User;
import com.trainingcenter.bean.VideoTeaching;
import com.trainingcenter.controller.validation.TC_Update;
import com.trainingcenter.exception.UpdateException;
import com.trainingcenter.service.UserService;
import com.trainingcenter.service.VideoTeachingService;
import com.trainingcenter.utils.AjaxJson;
import com.trainingcenter.utils.FindConditionUtils;
import com.trainingcenter.utils.StringUtil;
import com.trainingcenter.utils.SysResourcesUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

/**
 * @author Liutingwei
 * @date 2018-11-9 19:45
 */
@RequestMapping("/videoTeaching")
@Controller
public class VideoTeachingController {


    @Qualifier("videoTeachingService")
    @Autowired
    private VideoTeachingService videoTeachingService;

    @Qualifier("userService")
    @Autowired
    private UserService userService;

    @RequestMapping(value = "/listPage")
    @ResponseBody
    public AjaxJson listPage(@RequestParam("currentPage") Integer currentPage, @RequestParam("rows") Integer rows, HttpServletRequest request) {
        AjaxJson ajaxJson = new AjaxJson();
        if (currentPage == null || rows == null) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("数据获取失败，页数不能为空");
            return ajaxJson;
        } else {
            //自定义查询条件，以 key-value 的形式进行条件查询，模糊查询的 key 固定为 searchContent
            Map<String, Object> condition = new ConcurrentHashMap<>();
            String conditionStr = request.getParameter("condition");
            if (StringUtil.isNotEmpty(conditionStr)) {
                condition = FindConditionUtils.findConditionBuild(VideoTeaching.class, conditionStr);
            }

            //获取当前查询条件下的所有数据条数，分页用
            Integer total = videoTeachingService.getVideoTeachings(condition).size();
            //获取当前页的数据
            List<VideoTeaching> resources = videoTeachingService.getVideoTeachings(currentPage, rows, condition);

            ajaxJson.setCode(1);
            if (resources.size() == 0) {
                ajaxJson.setMsg("暂无数据Ծ‸Ծ");
            } else {
                ajaxJson.setMsg("数据获取成功");
            }

            Map<String, Object> data = new ConcurrentHashMap<>();
            data.put("total", total);
            data.put("items", resources);
            ajaxJson.setData(data);
            return ajaxJson;
        }
    }
    /**
     * 通过 id 获取资源对象
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/getVideoTeachingById")
    public AjaxJson getVideoTeachingById(@RequestParam("id") String id) {
        AjaxJson ajaxJson = new AjaxJson();
        if (StringUtil.isEmpty(id)) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("请先选择要查询的对象");
            return ajaxJson;
        }

        VideoTeaching resource = videoTeachingService.getVideoTeachingById(id);
        if (resource == null) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("对象不存在或已被删除");
            return ajaxJson;
        } else {
            ajaxJson.setCode(1);
            ajaxJson.setMsg("获取成功");
            Map<String, Object> map = new ConcurrentHashMap<>();
            map.put("videoTeaching", resource);
            ajaxJson.setData(map);
            return ajaxJson;
        }
    }
    /**
     * 进入详细页面
     *
     * @return loginPage
     */
    @RequestMapping(value = "/detailsPage")
    @ResponseBody
    public AjaxJson detailsPage(@RequestParam("id") String id) {
        AjaxJson ajaxJson = new AjaxJson();
        if(StringUtil.isNotEmpty(id)){
            VideoTeaching videoTeaching = videoTeachingService.getVideoTeachingById(id);
            if (videoTeaching == null){
                ajaxJson.setCode(1);
                ajaxJson.setMsg("暂无数据");
                return ajaxJson;
            }else{
                ajaxJson.setCode(1);
                ajaxJson.setMsg("請求成功");
                Map<String, Object> map = new ConcurrentHashMap<>(); //返回携带的数据
                map.put("items",videoTeaching);
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

    @RequestMapping(value = "/addPage")
    public ModelAndView addPage(HttpServletRequest request) {
        String id = request.getParameter("videoTeachingId");
        ModelAndView modelAndView =new ModelAndView();
        if(StringUtil.isNotEmpty(id)){
            String viewName = "admin/TD_addPage";
            modelAndView.addObject("videoTeaching",videoTeachingService.getVideoTeachingById(id));
            modelAndView.setViewName(viewName);

        }
        return modelAndView;
    }

    /**
     * 进入更新页面
     *
     * @return loginPage
     */
    @RequestMapping(value = "/updatePage")
    public ModelAndView updatePage(HttpServletRequest request) {
        String id = request.getParameter("videoTeachingId");
        ModelAndView modelAndView =new ModelAndView();
        if(StringUtil.isNotEmpty(id)){
            String viewName = "admin/TD_updatePage";
            modelAndView.addObject("videoTeaching",videoTeachingService.getVideoTeachingById(id));
            modelAndView.setViewName(viewName);
        }
        return modelAndView;
    }

    @RequestMapping(value = "/update")
    @ResponseBody
    public AjaxJson update(@Validated(value = {TC_Update.class}) VideoTeaching videoTeaching){
        AjaxJson ajaxJson = new AjaxJson();
        Integer res;    //操作结果 flag


        User user = null;
        //获取当前用户
        String currentUsername = SysResourcesUtils.getCurrentUsername(); //当前登录人账号
        if (!"anonymousUser".equals(currentUsername)){
            user = userService.getUserByUsername(currentUsername); //当前登录对象
        }

        if (user == null){
            throw new CredentialsExpiredException("登录凭证已过期");
        }

        if (videoTeaching == null){
            ajaxJson.setCode(0);
            ajaxJson.setMsg("操作失败，对象不能为空");
            return ajaxJson;

        }
        //更新操作
        VideoTeaching newTD = videoTeachingService.getVideoTeachingById(videoTeaching.getId());
        if (newTD == null){
            throw new UpdateException("更新失败，对象不存在或已被删除");
        }
        newTD.setTitle(videoTeaching.getTitle());
        newTD.setRemarks(videoTeaching.getRemarks());
        newTD.setContent(videoTeaching.getContent());
        newTD.setImgs(videoTeaching.getImgs());
        newTD.setUpdateDate(new Date());
        newTD.setUpdateUserId(user.getId());

        res=videoTeachingService.update(newTD);
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

    @RequestMapping(value = "/add")
    @ResponseBody
    public AjaxJson add(@RequestParam("title") String title, @RequestParam("imgs") String imgs
            , @RequestParam("content") String content, String remarks){
        AjaxJson ajaxJson = new AjaxJson();

        User user = null;
        //获取当前用户
        String currentUsername = SysResourcesUtils.getCurrentUsername(); //当前登录人账号
        if (!"anonymousUser".equals(currentUsername)){
            user = userService.getUserByUsername(currentUsername); //当前登录对象
        }

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
        VideoTeaching videoTeaching = new VideoTeaching();
        videoTeaching.setId(UUID.randomUUID().toString());
        videoTeaching.setImgs(imgs);
        videoTeaching.setTitle(title);
        videoTeaching.setContent(content);
        videoTeaching.setRemarks(remarks);
        videoTeaching.setCreateUserId(user.getId());
        videoTeaching.setCreateDate(new Date());
        Integer add = videoTeachingService.add(videoTeaching);
        if (add==1){
            ajaxJson.setCode(1);
            ajaxJson.setMsg("添加成功");
        }else {
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

        Integer delete = videoTeachingService.batchDelete(ids);
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
