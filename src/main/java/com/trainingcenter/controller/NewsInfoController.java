package com.trainingcenter.controller;

import com.trainingcenter.bean.NewsInfo;
import com.trainingcenter.bean.User;
import com.trainingcenter.controller.validation.TC_Add;
import com.trainingcenter.controller.validation.TC_Update;
import com.trainingcenter.exception.UpdateException;
import com.trainingcenter.service.NewsInfoService;
import com.trainingcenter.service.UserService;
import com.trainingcenter.utils.AjaxJson;
import com.trainingcenter.utils.FindConditionUtils;
import com.trainingcenter.utils.StringUtil;
import com.trainingcenter.utils.SysResourcesUtils;
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
@RequestMapping("/newsInfo")
@Controller
public class NewsInfoController {


    @Qualifier("newsInfoService")
    @Autowired
    private NewsInfoService newsInfoService;

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
                condition = FindConditionUtils.findConditionBuild(NewsInfo.class, conditionStr);
            }

            //获取当前查询条件下的所有数据条数，分页用
            Integer total = newsInfoService.getNewsInfos(condition).size();
            //获取当前页的数据
            List<NewsInfo> resources = newsInfoService.getNewsInfos(currentPage, rows, condition);

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
     * 进入详细页面
     *
     * @return loginPage
     */
    @RequestMapping(value = "/detailsPage")
    @ResponseBody
    public AjaxJson detailsPage(@RequestParam("id") String id) {
        AjaxJson ajaxJson = new AjaxJson();
        if(StringUtil.isNotEmpty(id)){
            NewsInfo newsInfo = newsInfoService.getNewsInfoById(id);
            if (newsInfo == null){
                ajaxJson.setCode(1);
                ajaxJson.setMsg("暂无数据");
                return ajaxJson;
            }else{
                ajaxJson.setCode(1);
                ajaxJson.setMsg("請求成功");
                Map<String, Object> map = new ConcurrentHashMap<>(); //返回携带的数据
                map.put("items",newsInfo);
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
     * 通过 id 获取资源对象
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/getNewsInfoById")
    public AjaxJson getStudentMienById(@RequestParam("id") String id) {
        AjaxJson ajaxJson = new AjaxJson();
        if (StringUtil.isEmpty(id)) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("请先选择要查询的对象");
            return ajaxJson;
        }

        NewsInfo resource = newsInfoService.getNewsInfoById(id);
        if (resource == null) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("对象不存在或已被删除");
            return ajaxJson;
        } else {
            ajaxJson.setCode(1);
            ajaxJson.setMsg("获取成功");
            Map<String, Object> map = new ConcurrentHashMap<>();
            map.put("newsInfo", resource);
            ajaxJson.setData(map);
            return ajaxJson;
        }
    }


    @RequestMapping(value = "/update")
    @ResponseBody
    public AjaxJson update(@Validated(value = {TC_Update.class}) NewsInfo newsInfo){
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

        if (newsInfo == null){
            ajaxJson.setCode(0);
            ajaxJson.setMsg("操作失败，对象不能为空");
            return ajaxJson;

        }
        //更新操作
        //当前ID
        NewsInfo newAd = newsInfoService.getNewsInfoById(newsInfo.getId());
        if (newAd == null){
            throw new UpdateException("更新失败，对象不存在或已被删除");
        }else {
            if (StringUtil.isNotEmpty(newsInfo.getImgs())) {
                newAd.setImgs(newsInfo.getImgs());
            }
            if (StringUtil.isNotEmpty(newsInfo.getRemarks())) {
                newAd.setRemarks(newsInfo.getRemarks());
            }
            if (StringUtil.isNotEmpty(newsInfo.getContent())) {
                newAd.setContent(newsInfo.getContent());
            }
            if(StringUtil.isNotEmpty(newsInfo.getTitle())){
                newAd.setTitle(newsInfo.getTitle());
            }
            newAd.setUpdateUserId(user.getId());
            newAd.setUpdateDate(new Date());

            res = newsInfoService.update(newAd);
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


    @RequestMapping(value = "/add")
    @ResponseBody
    public AjaxJson add(@Validated(value = {TC_Add.class}) NewsInfo newsInfo){
        AjaxJson ajaxJson = new AjaxJson();

        User user = null;
        //获取当前用户
        String currentUsername = SysResourcesUtils.getCurrentUsername(); //当前登录人账号
        if (!"anonymousUser".equals(currentUsername)){
            user = userService.getUserByUsername(currentUsername); //当前登录对象
        }

        //非空验证
        if(newsInfo==null){
            ajaxJson.setCode(0);
            ajaxJson.setMsg("操作对象为空，操作失败");
        }
        //资料添加

        newsInfo.setId(UUID.randomUUID().toString());
        newsInfo.setCreateUserId(user.getId());
        newsInfo.setCreateDate(new Date());
        Integer add = newsInfoService.add(newsInfo);
        if (add==1){
            ajaxJson.setCode(1);
            ajaxJson.setMsg("添加成功");
        }else {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("添加失败，请稍后重试");
        }

        return ajaxJson;
    }

    @RequestMapping(value = "/delete")
    @ResponseBody
    public AjaxJson delete(@RequestParam("ids") String ids) {
        AjaxJson ajaxJson = new AjaxJson();

        if (StringUtil.isEmpty(ids)){
            ajaxJson.setCode(0);
            ajaxJson.setMsg("删除失败，请先选择要删除的对象");
            return ajaxJson;
        }

        boolean delete = newsInfoService.batchDelete(ids);
        if (delete){
            ajaxJson.setCode(1);
            ajaxJson.setMsg("删除成功");
        }else {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("删除失败，请稍后重试");
        }

        return ajaxJson;
    }
}
