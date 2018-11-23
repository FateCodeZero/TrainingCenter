package com.trainingcenter.controller;

import com.trainingcenter.bean.Resource;
import com.trainingcenter.bean.User;
import com.trainingcenter.controller.validation.TC_Add;
import com.trainingcenter.controller.validation.TC_Update;
import com.trainingcenter.exception.UpdateException;
import com.trainingcenter.service.ResourceService;
import com.trainingcenter.service.UserService;
import com.trainingcenter.utils.AjaxJson;
import com.trainingcenter.utils.HTTPUtils;
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
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/11/21
 * Time: 18:33
 */
@RequestMapping("/resource")
@Controller
public class ResourceController {
    @Qualifier("resourceService")
    @Autowired
    private ResourceService resourceService;
    @Qualifier("userService")
    @Autowired
    private UserService userService;

    @ResponseBody
    @RequestMapping("/listPage")
    public AjaxJson getResources(@RequestParam("currentPage") Integer currentPage, @RequestParam("rows") Integer rows, String searchContent){
        AjaxJson ajaxJson = new AjaxJson();
        if (currentPage == null || rows == null){
            ajaxJson.setCode(0);
            ajaxJson.setMsg("操作失败，页数不能为空");
            return ajaxJson;
        }else {
            Integer total = resourceService.getResources().size();
            List<Resource> resources = resourceService.getResources(currentPage,rows,searchContent);

            ajaxJson.setCode(1);
            if (resources.size() == 0){
                ajaxJson.setMsg("暂无数据Ծ‸Ծ");
            }else {
                ajaxJson.setMsg("操作成功");

                Map<String,Object> data = new ConcurrentHashMap<>();
                data.put("total",total);
                data.put("data",resources);
                ajaxJson.setData(data);
            }
            return ajaxJson;
        }
    }

    @RequestMapping("/addOrUpdatePage")
    public ModelAndView addOrUpdatePage(HttpServletRequest request){
        ModelAndView modelAndView = new ModelAndView();
        String id = request.getParameter("resourceId");
        if (StringUtil.isNotEmpty(id)){
            Resource resource = resourceService.getResourceById(id);
            modelAndView.addObject("resource",resource);
        }
        modelAndView.setViewName("admin/resource_add");
        return modelAndView;
    }

    @ResponseBody
    @RequestMapping("/addOrUpdate")
    public AjaxJson addOrUpdate(@Validated(value = {TC_Add.class, TC_Update.class}) Resource resource){
        String currentUsername = SysResourcesUtils.getCurrentUsername();    //当前登录用户的用户名
        User currentUser = userService.getUserByUsername(currentUsername);  //当前登录用户对象

        if (currentUser == null){
            throw new CredentialsExpiredException("登录凭证已过期");
        }

        AjaxJson ajaxJson = new AjaxJson(); //返回的Json数据封装对象

        if (resource == null){
            ajaxJson.setCode(0);
            ajaxJson.setMsg("操作失败，对象不能为空");
            return ajaxJson;
        }

        String id = resource.getId(); //更新对象的ID
        Integer res;    //操作结果 flag

        // 对象 id 为空时执行 添加操作
        if (StringUtil.isEmpty(id)){
            resource.setId(UUID.randomUUID().toString());
            resource.setCreateUserId(currentUser.getId());
            resource.setCreateDate(new Date());
            resource.setUpdateUserId(currentUser.getId());
            resource.setUpdateDate(new Date());

             res = resourceService.add(resource);

        }else {     //对象 id 不为空时执行 更新操作

            Resource newResource = resourceService.getResourceById(id);
            if (newResource == null){
                throw new UpdateException("更新失败，对象不存在或已被删除");
            }
            newResource.setName(resource.getName());
            newResource.setUrl(resource.getUrl());  //注意：URL在上线时应不能更改
            newResource.setState(resource.getState());
            newResource.setDescribe(resource.getDescribe());
            newResource.setRemarks(resource.getRemarks());
            newResource.setUpdateUserId(currentUser.getId());
            newResource.setUpdateDate(new Date());

            res = resourceService.update(newResource);
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

    @RequestMapping("/delete")
    public AjaxJson delete(@RequestParam("ids") String ids){
        AjaxJson ajaxJson = new AjaxJson();
        if(StringUtil.isEmpty(ids)){
            ajaxJson.setCode(0);
            ajaxJson.setMsg("请先选择要删除的对象");
            return ajaxJson;
        }

        Integer res = resourceService.batchDelete(ids);
        if (res == 0){
            ajaxJson.setCode(0);
            ajaxJson.setMsg("删除失败，请重试");
            return ajaxJson;
        }else {
            ajaxJson.setCode(1);
            ajaxJson.setMsg("删除成功");
            return ajaxJson;
        }
    }
} 