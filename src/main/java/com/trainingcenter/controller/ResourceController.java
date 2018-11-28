package com.trainingcenter.controller;

import com.trainingcenter.bean.Resource;
import com.trainingcenter.bean.User;
import com.trainingcenter.controller.validation.TC_Add;
import com.trainingcenter.controller.validation.TC_Update;
import com.trainingcenter.exception.UpdateException;
import com.trainingcenter.service.ResourceService;
import com.trainingcenter.service.UserService;
import com.trainingcenter.utils.AjaxJson;
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

    /**
     * 分页获取资源数据（获取全部，（已启用 + 已禁用 + 已删除（软删除）））
     * @param currentPage：当前页
     * @param rows：每页展示的数据条数
     * @param searchContent：模糊查询
     */
    @ResponseBody
    @RequestMapping("/list")
    public AjaxJson getResources_all(@RequestParam("currentPage") Integer currentPage, @RequestParam("rows") Integer rows, String searchContent) {
        AjaxJson ajaxJson = new AjaxJson();
        if (currentPage == null || rows == null) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("数据获取失败，页数不能为空");
            return ajaxJson;
        } else {
            //自定义查询条件，以 key-value 的形式进行条件查询，模糊查询的 key 固定为 searchContent
            Map<String,Object> condition = new ConcurrentHashMap<>();
            // 此处注意：ConcurrentHashMap 不允许 NULL 值
            if (StringUtil.isNotEmpty(searchContent)){
                condition.put("searchContent",searchContent);
            }
            //获取当前查询条件下的所有数据条数，分页用
            Integer total = resourceService.getResources(condition).size();
            //获取当前页的数据
            List<Resource> resources = resourceService.getResources(currentPage, rows, condition);

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
     * 分页获取资源数据（获取只获取已启用的）
     * @param currentPage：当前页
     * @param rows：每页展示的数据条数
     * @param searchContent：模糊查询
     */
    @ResponseBody
    @RequestMapping("/select")
    public AjaxJson getResources_select(@RequestParam("currentPage") Integer currentPage, @RequestParam("rows") Integer rows, String searchContent) {
        AjaxJson ajaxJson = new AjaxJson();
        if (currentPage == null || rows == null) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("数据获取失败，页数不能为空");
            return ajaxJson;
        } else {
            //自定义查询条件，以 key-value 的形式进行条件查询，模糊查询的 key 固定为 searchContent
            Map<String,Object> condition = new ConcurrentHashMap<>();
            condition.put("state",1);   //只查询已启用的数据

            // 此处注意：ConcurrentHashMap 不允许 NULL 值
            if (StringUtil.isNotEmpty(searchContent)){
                condition.put("searchContent",searchContent);
            }

            //获取当前查询条件下的所有数据条数，分页用
            Integer total = resourceService.getResources(condition).size();
            //获取当前页的数据
            List<Resource> resources = resourceService.getResources(currentPage, rows, condition);

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

    @ResponseBody
    @RequestMapping("/add")
    public AjaxJson add(@Validated(value = {TC_Add.class}) Resource resource) {
        String currentUsername = SysResourcesUtils.getCurrentUsername();    //当前登录用户的用户名
        User currentUser = userService.getUserByUsername(currentUsername);  //当前登录用户对象
        if (currentUser == null) {
            throw new CredentialsExpiredException("登录凭证已过期");
        }

        AjaxJson ajaxJson = new AjaxJson(); //返回的Json数据封装对象
        if (resource == null) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("添加失败，添加对象不能为空");
            return ajaxJson;
        }
        resource.setId(UUID.randomUUID().toString());
        resource.setCreateUserId(currentUser.getId());
        resource.setCreateDate(new Date());
        resource.setUpdateUserId(currentUser.getId());
        resource.setUpdateDate(new Date());

        Integer res = resourceService.add(resource);

        if (res == 0) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("添加失败，请重试");
            return ajaxJson;
        } else {
            ajaxJson.setCode(1);
            ajaxJson.setMsg("添加成功");
            return ajaxJson;
        }
    }

    @ResponseBody
    @RequestMapping("/update")
    public AjaxJson update(@Validated(value = {TC_Update.class}) Resource resource) {
        String currentUsername = SysResourcesUtils.getCurrentUsername();    //当前登录用户的用户名
        User currentUser = userService.getUserByUsername(currentUsername);  //当前登录用户对象

        if (currentUser == null) {
            throw new CredentialsExpiredException("登录凭证已过期");
        }

        AjaxJson ajaxJson = new AjaxJson(); //返回的Json数据封装对象

        if (resource == null || StringUtil.isEmpty(resource.getId())) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("更新失败，更新对象不能为空");
            return ajaxJson;
        }

        String id = resource.getId(); //更新对象的ID

        //从数据库读取旧的对象进行更新
        Resource oldResource = resourceService.getResourceById(id);
        if (oldResource == null) {
            throw new UpdateException("更新失败，对象不存在或已被删除");
        }
        if (StringUtil.isNotEmpty(resource.getName())) {
            oldResource.setName(resource.getName());
        }
        if (StringUtil.isNotEmpty(resource.getUrl())) {
            oldResource.setUrl(resource.getUrl());  //注意：URL在上线时应不能更改
        }
        if (resource.getState() != null) {
            oldResource.setState(resource.getState());
        }
        if (StringUtil.isNotEmpty(resource.getDescribe())) {
            oldResource.setDescribe(resource.getDescribe());
        }
        if (StringUtil.isNotEmpty(resource.getRemarks())) {
            oldResource.setRemarks(resource.getRemarks());
        }
        oldResource.setUpdateUserId(currentUser.getId());
        oldResource.setUpdateDate(new Date());

        Integer res = resourceService.update(oldResource); //操作结果 flag

        if (res == 0) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("更新失败，请重试");
            return ajaxJson;
        } else {
            ajaxJson.setCode(1);
            ajaxJson.setMsg("更新成功");
            return ajaxJson;
        }
    }

    /**
     * 删除资源，支持批量删除
     *
     * @param ids
     * @return
     */
    @ResponseBody
    @RequestMapping("/delete")
    public AjaxJson delete(@RequestParam("ids") String ids) {
        AjaxJson ajaxJson = new AjaxJson();
        if (StringUtil.isEmpty(ids)) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("请先选择要删除的对象");
            return ajaxJson;
        }

        Integer res = resourceService.batchDelete(ids);
        if (res == 0) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("删除失败，请重试");
            return ajaxJson;
        } else {
            ajaxJson.setCode(1);
            ajaxJson.setMsg("删除成功");
            return ajaxJson;
        }
    }

    /**
     * 通过 id 获取资源对象
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/getResourceById")
    public AjaxJson getResourceById(@RequestParam("id") String id) {
        AjaxJson ajaxJson = new AjaxJson();
        if (StringUtil.isEmpty(id)) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("请先选择要查询的对象");
            return ajaxJson;
        }

        Resource resource = resourceService.getResourceById(id);
        if (resource == null) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("对象不存在或已被删除");
            return ajaxJson;
        } else {
            ajaxJson.setCode(1);
            ajaxJson.setMsg("获取成功");
            Map<String, Object> map = new ConcurrentHashMap<>();
            map.put("resource", resource);
            ajaxJson.setData(map);
            return ajaxJson;
        }
    }
} 