package com.trainingcenter.controller;

import com.trainingcenter.bean.RevolutionarySite;
import com.trainingcenter.bean.User;
import com.trainingcenter.controller.validation.TC_Update;
import com.trainingcenter.exception.UpdateException;
import com.trainingcenter.service.RevolutionarySiteService;
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
@RequestMapping("/revolutionarySite")
@Controller
public class RevolutionarySiteController {


    @Qualifier("revolutionarySiteService")
    @Autowired
    private RevolutionarySiteService revolutionarySiteService;

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
        List<RevolutionarySite> revolutionarySites = revolutionarySiteService.getRevolutionarySites(currentPage, rows, searchContent);
        Integer total = revolutionarySiteService.getRevolutionarySites().size();

        if (revolutionarySites.size() == 0){
            ajaxJson.setCode(0);
            ajaxJson.setMsg("暂无数据");
        }else {
            ajaxJson.setCode(1);
            ajaxJson.setMsg("操作成功");
        }

        Map<String,Object> data = new ConcurrentHashMap<>();
        data.put("total",total);
        data.put("items",revolutionarySites);
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
            RevolutionarySite revolutionarySite = revolutionarySiteService.getRevolutionarySiteById(id);
            if (revolutionarySite == null){
                ajaxJson.setCode(1);
                ajaxJson.setMsg("暂无数据");
                return ajaxJson;
            }else{
                ajaxJson.setCode(1);
                ajaxJson.setMsg("請求成功");
                Map<String, Object> map = new ConcurrentHashMap<>(); //返回携带的数据
                map.put("items",revolutionarySite);
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
    @RequestMapping("/getRevolutionarySiteById")
    public AjaxJson getRevolutionarySiteById(@RequestParam("id") String id) {
        AjaxJson ajaxJson = new AjaxJson();
        if (StringUtil.isEmpty(id)) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("请先选择要查询的对象");
            return ajaxJson;
        }

        RevolutionarySite resource = revolutionarySiteService.getRevolutionarySiteById(id);
        if (resource == null) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("对象不存在或已被删除");
            return ajaxJson;
        } else {
            ajaxJson.setCode(1);
            ajaxJson.setMsg("获取成功");
            Map<String, Object> map = new ConcurrentHashMap<>();
            map.put("revolutionarySite", resource);
            ajaxJson.setData(map);
            return ajaxJson;
        }
    }
    @RequestMapping(value = "/update",method = RequestMethod.GET)
    @ResponseBody
    public AjaxJson update(@Validated(value = {TC_Update.class}) RevolutionarySite revolutionarySite){
        AjaxJson ajaxJson = new AjaxJson();
        Integer res;    //操作结果 flag


        //获取当前用户
        String currentName = getCurrentUsername();
        User user = userService.getUserByUsername(currentName);

        if (user == null){
            throw new CredentialsExpiredException("登录凭证已过期");
        }

        if (revolutionarySite == null){
            ajaxJson.setCode(0);
            ajaxJson.setMsg("操作失败，对象不能为空");
            return ajaxJson;

        }
        //更新操作
        RevolutionarySite newTD = revolutionarySiteService.getRevolutionarySiteById(revolutionarySite.getId());
        if (newTD == null){
            throw new UpdateException("更新失败，对象不存在或已被删除");
        }
        newTD.setTitle(revolutionarySite.getTitle());
        newTD.setRemarks(revolutionarySite.getRemarks());
        newTD.setContent(revolutionarySite.getContent());
        newTD.setImgs(revolutionarySite.getImgs());
        newTD.setUpdateDate(new Date());
        newTD.setUpdateUserId(user.getId());

        res=revolutionarySiteService.update(newTD);
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
        RevolutionarySite revolutionarySite = new RevolutionarySite();
        revolutionarySite.setId(UUID.randomUUID().toString());
        revolutionarySite.setImgs(imgs);
        revolutionarySite.setContent(content);
        revolutionarySite.setRemarks(remarks);
        revolutionarySite.setCreateUserId(user.getId());
        revolutionarySite.setCreateDate(new Date());
        Integer add = revolutionarySiteService.add(revolutionarySite);
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
    @RequestMapping(value = "/delete", method = RequestMethod.GET)
    public AjaxJson delete(@RequestParam("ids") String ids) {
        AjaxJson ajaxJson = new AjaxJson();

        if (StringUtil.isEmpty(ids)){
            ajaxJson.setCode(0);
            ajaxJson.setMsg("删除失败，请先选择要删除的对象");
            return ajaxJson;
        }

        Integer delete = revolutionarySiteService.batchDelete(ids);
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