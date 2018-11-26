package com.trainingcenter.controller;

import com.trainingcenter.bean.Advertisement;
import com.trainingcenter.bean.User;
import com.trainingcenter.controller.validation.TC_Add;
import com.trainingcenter.controller.validation.TC_Update;
import com.trainingcenter.exception.UpdateException;
import com.trainingcenter.service.AdvertisementService;
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
@RequestMapping("/advertisement")
@Controller
public class AdvertisementController {

    @Qualifier("advertisementService")
    @Autowired
    private AdvertisementService advertisementService;

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
            return ajaxJson;
        }
        List<Advertisement> advertisements = advertisementService.getAdvertisements(currentPage, rows, searchContent);
        Integer total = advertisementService.getAdvertisements().size();

        if (advertisements.size() == 0){
            ajaxJson.setCode(1);
            ajaxJson.setMsg("暂无数据");
        }else {
            ajaxJson.setCode(1);
            ajaxJson.setMsg("操作成功");
        }

        Map<String,Object> data = new ConcurrentHashMap<>();
        data.put("total",total);
        data.put("items",advertisements);
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
            Advertisement advertisement = advertisementService.getAdvertisementById(id);
            if (advertisement == null){
                ajaxJson.setCode(1);
                ajaxJson.setMsg("暂无数据");
                return ajaxJson;
            }else{
                ajaxJson.setCode(1);
                ajaxJson.setMsg("請求成功");
                Map<String, Object> map = new ConcurrentHashMap<>(); //返回携带的数据
                map.put("items",advertisement);
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
        String id = request.getParameter("advertisementId");
        ModelAndView modelAndView =new ModelAndView();
        if(StringUtil.isNotEmpty(id)){
            String viewName = "admin/Ad_addPage";
            modelAndView.addObject("advertisement",advertisementService.getAdvertisementById(id));
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
        String id = request.getParameter("advertisementId");
        ModelAndView modelAndView =new ModelAndView();
        if(StringUtil.isNotEmpty(id)){
            String viewName = "admin/Ad_updatePage";
            modelAndView.addObject("advertisement",advertisementService.getAdvertisementById(id));
            modelAndView.setViewName(viewName);
        }
        return modelAndView;
    }

    @RequestMapping(value = "/update",method = RequestMethod.GET)
    @ResponseBody
    public AjaxJson update(@Validated(value = {TC_Update.class}) Advertisement advertisement){
        AjaxJson ajaxJson = new AjaxJson();
        Integer res;    //操作结果 flag


        //获取当前用户
        String currentName = getCurrentUsername();
        User user = userService.getUserByUsername(currentName);

        if (user == null){
            throw new CredentialsExpiredException("登录凭证已过期");
        }

        if (advertisement == null){
            ajaxJson.setCode(0);
            ajaxJson.setMsg("操作失败，对象不能为空");
            return ajaxJson;

        }
        //更新操作
        //当前ID
        Advertisement newAd = advertisementService.getAdvertisementById(advertisement.getId());
        if (newAd == null){
            throw new UpdateException("更新失败，对象不存在或已被删除");
        }else {
            if (StringUtil.isNotEmpty(advertisement.getImgs())) {
                newAd.setImgs(advertisement.getImgs());
            }
            if (StringUtil.isNotEmpty(advertisement.getUrl())) {
                newAd.setUrl(advertisement.getUrl());  //注意：URL在上线时应不能更改
            }
            if (StringUtil.isNotEmpty(advertisement.getDescribe())) {
                newAd.setDescribe(advertisement.getDescribe());
            }
            if (StringUtil.isNotEmpty(advertisement.getRemarks())) {
                newAd.setRemarks(advertisement.getRemarks());
            }
            if(advertisement.getStart()!=null){
                newAd.setStart(advertisement.getStart());
            }
            if(advertisement.getEnd()!=null){
                newAd.setEnd(advertisement.getEnd());
            }
            newAd.setUpdateUserId(user.getId());
            newAd.setUpdateDate(new Date());

            res = advertisementService.update(newAd);
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


    public AjaxJson add(@Validated(value = {TC_Add.class}) Advertisement advertisement){
        AjaxJson ajaxJson = new AjaxJson();

        //获取当前用户
        String currentName = getCurrentUsername();

        User user = userService.getUserByUsername(currentName);

        //非空验证
        if(advertisement==null){
            ajaxJson.setCode(0);
            ajaxJson.setMsg("操作对象为空，操作失败");
        }
        //资料添加

        advertisement.setId(UUID.randomUUID().toString());
        advertisement.setCreateUserId(user.getId());
        advertisement.setCreateDate(new Date());
        Integer add = advertisementService.add(advertisement);
        if (add==1){
            ajaxJson.setCode(1);
            ajaxJson.setMsg("添加成功");
        }else {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("添加失败，请稍后重试");
        }

        return ajaxJson;
    }

    @RequestMapping(value = "/delete", method = RequestMethod.DELETE)
    public AjaxJson delete(@PathVariable("ids") String ids) {
        AjaxJson ajaxJson = new AjaxJson();

        if (StringUtil.isEmpty(ids)){
            ajaxJson.setCode(0);
            ajaxJson.setMsg("删除失败，请先选择要删除的对象");
            return ajaxJson;
        }

        boolean delete = advertisementService.batchDelete(ids);
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
