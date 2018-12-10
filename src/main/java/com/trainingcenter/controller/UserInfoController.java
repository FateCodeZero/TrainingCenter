package com.trainingcenter.controller;

import com.trainingcenter.bean.User;
import com.trainingcenter.bean.UserInfo;
import com.trainingcenter.controller.validation.TC_Update;
import com.trainingcenter.service.UserInfoService;
import com.trainingcenter.utils.AjaxJson;
import com.trainingcenter.utils.DateUtil;
import com.trainingcenter.utils.FindConditionUtils;
import com.trainingcenter.utils.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/12/8
 * Time: 20:40
 */
@RequestMapping("/userInfo")
@Controller
public class UserInfoController {
    @Qualifier("userInfoService")
    @Autowired
    private UserInfoService userInfoService;

    @PreAuthorize("hasPermission('/webpages/user/userInfo.jsp','READ')")
    @ResponseBody
    @RequestMapping("/getUserInfoById")
    public AjaxJson getUserInfoById(@RequestParam("id") String id){
        AjaxJson ajaxJson = new AjaxJson();
        if (StringUtil.isEmpty(id)){
            ajaxJson.setCode(0);
            ajaxJson.setMsg("查询错误，请先选择要查询的对象");
            return ajaxJson;
        }

        UserInfo userInfo = userInfoService.getUserInfoById(id);
        if (userInfo == null){
            ajaxJson.setCode(0);
            ajaxJson.setMsg("查询错误，对象不存在或已被删除");
            return ajaxJson;
        }else {
            ajaxJson.setCode(1);
            ajaxJson.setMsg("查询成功");
            Map<String,Object> data = new ConcurrentHashMap<>();
            data.put("userInfo",userInfo);
            ajaxJson.setData(data);
        }
        return ajaxJson;
    }

    @PreAuthorize("hasPermission('/webpages/user/userInfo.jsp','READ')")
    @ResponseBody
    @RequestMapping("/getUserInfoByUsername")
    public AjaxJson getUserInfoByUsername(@RequestParam("username") String username){
        AjaxJson ajaxJson = new AjaxJson();
        if (StringUtil.isEmpty(username)){
            ajaxJson.setCode(0);
            ajaxJson.setMsg("查询错误，请先选择要查询的对象");
            return ajaxJson;
        }

        UserInfo userInfo = userInfoService.getUserInfoByUsername(username);
        if (userInfo == null){
            ajaxJson.setCode(0);
            ajaxJson.setMsg("查询错误，对象不存在或已被删除");
            return ajaxJson;
        }else {
            ajaxJson.setCode(1);
            ajaxJson.setMsg("查询成功");
            Map<String,Object> data = new ConcurrentHashMap<>();
            data.put("userInfo",userInfo);
            ajaxJson.setData(data);
        }
        return ajaxJson;
    }

    @PreAuthorize("hasPermission('/webpages/admin/userInfo_list.jsp','READ')")
    @ResponseBody
    @RequestMapping("/list")
    public AjaxJson getUserInfos(@RequestParam("currentPage") Integer currentPage, @RequestParam("rows") Integer rows, HttpServletRequest request){
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
                condition = FindConditionUtils.findConditionBuild(UserInfo.class, conditionStr);
            }
            //获取当前查询条件下的所有数据条数，分页用
            Integer total = userInfoService.getUserInfos(condition).size();
            //获取当前页的数据
            List<UserInfo> userInfos = userInfoService.getUserInfos(currentPage, rows, condition);
            ajaxJson.setCode(1);
            if (userInfos.size() == 0) {
                ajaxJson.setMsg("暂无数据Ծ‸Ծ");
            } else {
                ajaxJson.setMsg("数据获取成功");
            }
            Map<String, Object> data = new ConcurrentHashMap<>();
            data.put("total", total);
            data.put("items", userInfos);
            ajaxJson.setData(data);
            return ajaxJson;
        }
    }

    @PreAuthorize("hasPermission('/webpages/user/userInfo.jsp','UPDATE')")
    @ResponseBody
    @RequestMapping("/update")
    public AjaxJson update(HttpServletRequest request){
        AjaxJson ajaxJson = new AjaxJson();
        UserInfo userInfo;

        String id = request.getParameter("id");
        String username = request.getParameter("username");
        //从数据库读取旧的对象进行更新
        if (StringUtil.isNotEmpty(id)){
            //按id查找
            userInfo = userInfoService.getUserInfoById(id);
        }else if (StringUtil.isNotEmpty(username)){
            //按 username 查找
            userInfo = userInfoService.getUserInfoByUsername(username);
        }else {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("更新失败，请先选择要更新的对象");
            return ajaxJson;
        }

        if (userInfo == null) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("更新失败，对象不存在或已被删除");
            return ajaxJson;
        }

        String nickname = request.getParameter("nickname");
        if (StringUtil.isNotEmpty(nickname)){
            userInfo.setNickname(nickname);
        }
        String realName = request.getParameter("realName");
        if (realName != null){
            userInfo.setRealName(realName);
        }
        String genderStr = request.getParameter("gender");
        Integer gender;
        if (StringUtil.isNotEmpty(genderStr)){
            gender = Integer.valueOf(genderStr);
            userInfo.setGender(gender);
        }
        String birthdayStr = request.getParameter("birthday");
        Date birthday;
        if (StringUtil.isNotEmpty(birthdayStr)){
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            birthday = DateUtil.strToDate(birthdayStr,sdf);
            if (birthday != null){
                userInfo.setBirthday(birthday);
            }
        }
        String address = request.getParameter("address");
        if (address != null){
            userInfo.setAddress(address);
        }
        String postalCode = request.getParameter("postalCode");
        if (postalCode != null ){
            userInfo.setPostalCode(postalCode);
        }
        String email = request.getParameter("email");
        if (StringUtil.isNotEmpty(email)){
            userInfo.setEmail(email);
        }
        String phone = request.getParameter("phone");
        if (StringUtil.isNotEmpty(phone)){
            userInfo.setPhone(phone);
        }
        String motto = request.getParameter("motto");
        if (motto != null){
            userInfo.setMotto(motto);
        }
        String describe = request.getParameter("describe");
        if (describe != null){
            userInfo.setDescribe(describe);
        }
        String company = request.getParameter("company");
        if (company != null){
            userInfo.setCompany(company);
        }
        String position = request.getParameter("position");
        if (position != null){
            userInfo.setPosition(position);
        }
        String career = request.getParameter("career");
        if (career != null){
            userInfo.setCareer(career);
        }

        //更新结果
        Integer res = userInfoService.update(userInfo);
        if (res > 0) {
            ajaxJson.setCode(1);
            ajaxJson.setMsg("更新成功");
        } else {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("更新失败，请重试");
        }
        return ajaxJson;
    }
} 