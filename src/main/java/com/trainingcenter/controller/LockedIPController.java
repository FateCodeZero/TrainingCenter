package com.trainingcenter.controller;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/12/3
 * Time: 22:33
 */

import com.trainingcenter.bean.LockedIP;
import com.trainingcenter.bean.User;
import com.trainingcenter.controller.validation.TC_Add;
import com.trainingcenter.controller.validation.TC_Update;
import com.trainingcenter.service.LockedIPService;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

/**
 * IP封禁Controller
 */
@Controller
@RequestMapping("lockedIP")
public class LockedIPController {
    @Qualifier("lockedIPService")
    @Autowired
    private LockedIPService lockedIPService;
    @Qualifier("userService")
    @Autowired
    private UserService userService;

//    @PreAuthorize("hasPermission('/webpages/admin/lockedIP_list.jsp','READ')")
    @ResponseBody
    @RequestMapping("/list")
    public AjaxJson getLockedIPs(@RequestParam("currentPage") Integer currentPage, @RequestParam("rows") Integer rows, HttpServletRequest request){
        AjaxJson ajaxJson = new AjaxJson();
        if (currentPage == null || rows == null) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("数据获取失败，页数不能为空");
            return ajaxJson;
        } else {

            //自定义查询条件，以 key-value 的形式进行条件查询，模糊查询的 key 固定为 searchContent
            Map<String, Object> condition = new ConcurrentHashMap<>();
            String conditionStr = request.getParameter("condition");
            if (StringUtil.isNotEmpty(conditionStr)){
                condition = FindConditionUtils.findConditionBuild(LockedIP.class,conditionStr);
            }
            //获取当前查询条件下的所有数据条数，分页用
            Integer total = lockedIPService.getLockedIPs(condition).size();
            //获取当前页的数据
            List<LockedIP> lockedIPS = lockedIPService.getLockedIPs(currentPage, rows, condition);
            ajaxJson.setCode(1);
            if (lockedIPS.size() == 0){
                ajaxJson.setMsg("暂无数据Ծ‸Ծ");
            }else {
                ajaxJson.setMsg("数据获取成功");
            }
            Map<String,Object> data = new ConcurrentHashMap<>();
            data.put("total",total);
            data.put("items",lockedIPS);
            ajaxJson.setData(data);
            return ajaxJson;
        }
    }

//    @PreAuthorize("hasPermission('/webpages/admin/lockedIP_list.jsp','CREATE')")
    @ResponseBody
    @RequestMapping("/add")
    public AjaxJson add(@Validated(value = {TC_Add.class}) LockedIP lockedIP){
        String currentUsername = SysResourcesUtils.getCurrentUsername();    //当前登录用户的用户名
        User currentUser = userService.getUserByUsername(currentUsername);  //当前登录用户对象

        if (currentUser == null) {
            throw new CredentialsExpiredException("登录凭证已过期");
        }
        AjaxJson ajaxJson = new AjaxJson();
        if (lockedIP == null) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("添加失败，添加对象不能为空");
            return ajaxJson;
        }
        lockedIP.setId(UUID.randomUUID().toString());
        lockedIP.setCreateUserId(currentUser.getId());
        lockedIP.setCreateDate(new Date());
        lockedIP.setUpdateUserId(currentUser.getId());
        lockedIP.setUpdateDate(new Date());

        Integer res = lockedIPService.add(lockedIP);//操作结果 flag
        if (res == 0) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("操作失败，请重试");
            return ajaxJson;
        } else {
            ajaxJson.setCode(1);
            ajaxJson.setMsg("操作成功");
            return ajaxJson;
        }
    }

//    @PreAuthorize("hasPermission('/webpages/admin/lockedIP_list.jsp','UPDATE')")
    @ResponseBody
    @RequestMapping("/update")
    public AjaxJson update(@Validated(value = {TC_Update.class}) LockedIP lockedIP){
        String currentUsername = SysResourcesUtils.getCurrentUsername();    //当前登录用户的用户名
        User currentUser = userService.getUserByUsername(currentUsername);  //当前登录用户对象
        if (currentUsername == null || currentUser == null) {
            throw new CredentialsExpiredException("登录凭证已过期");
        }
        AjaxJson ajaxJson = new AjaxJson();
        if (lockedIP == null || StringUtil.isEmpty(lockedIP.getId())) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("更新失败，请先选择要更新的对象");
            return ajaxJson;
        }
        //从数据库读取旧的对象进行更新
        LockedIP oldLockedIP = lockedIPService.getLockedIPById(lockedIP.getId());
        if (oldLockedIP == null) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("更新失败，对象不存在或已被删除");
            return ajaxJson;
        }
        String ip = lockedIP.getIp();
        if (StringUtil.isNotEmpty(ip)){
            oldLockedIP.setIp(ip);
        }
        String remarks = lockedIP.getRemarks();
        if (StringUtil.isNotEmpty(remarks)){
            oldLockedIP.setRemarks(remarks);
        }
        oldLockedIP.setUpdateUserId(currentUser.getId());
        oldLockedIP.setUpdateDate(new Date());

        Integer res = lockedIPService.update(oldLockedIP);//操作结果 flag
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
     * 删除权限，支持批量删除
     * @param ids
     * @return
     */
//    @PreAuthorize("hasPermission('/webpages/admin/lockedIP_list.jsp','DELETE')")
    @ResponseBody
    @RequestMapping(value = "/delete")
    public AjaxJson delete(@RequestParam("ids") String ids) {
        AjaxJson ajaxJson = new AjaxJson();
        if (StringUtil.isEmpty(ids)) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("请先选择要删除的对象");
            return ajaxJson;
        }
        Integer res = lockedIPService.batchDelete(ids);
        if (res == 0) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("操作失败，请重试");
            return ajaxJson;
        } else {
            ajaxJson.setCode(1);
            ajaxJson.setMsg("操作成功");
            return ajaxJson;
        }
    }

    /**
     * 通过id获取IP封禁对象
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/getLockedIPById", method = RequestMethod.GET)
    public AjaxJson getRoleById(@RequestParam("id") String id) {
        AjaxJson ajaxJson = new AjaxJson();
        if (StringUtil.isEmpty(id)) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("请先选择要查询的对象");
            return ajaxJson;
        }

        LockedIP lockedIP = lockedIPService.getLockedIPById(id);
        if (lockedIP == null) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("对象不存在或已被删除");
            return ajaxJson;
        } else {
            ajaxJson.setCode(1);
            ajaxJson.setMsg("获取成功");
            Map<String, Object> map = new ConcurrentHashMap<>();
            map.put("lockedIP", lockedIP);
            ajaxJson.setData(map);
            return ajaxJson;
        }
    }

    /**
     * 通过IP获取IP封禁对象
     * @param IP
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/getLockedIPByIP", method = RequestMethod.GET)
    public AjaxJson getLockedIPByIP(@RequestParam("IP") String IP) {
        AjaxJson ajaxJson = new AjaxJson();
        if (StringUtil.isEmpty(IP)) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("请先选择要查询的对象");
            return ajaxJson;
        }

        LockedIP lockedIP = lockedIPService.getLockedIPByIP(IP);
        if (lockedIP == null) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("对象不存在或已被删除");
            return ajaxJson;
        } else {
            ajaxJson.setCode(1);
            ajaxJson.setMsg("获取成功");
            Map<String, Object> map = new ConcurrentHashMap<>();
            map.put("lockedIP", lockedIP);
            ajaxJson.setData(map);
            return ajaxJson;
        }
    }
} 