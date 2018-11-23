package com.trainingcenter.controller;

import com.trainingcenter.bean.TrainingDynamic;
import com.trainingcenter.bean.User;
import com.trainingcenter.controller.validation.TC_Update;
import com.trainingcenter.exception.UpdateException;
import com.trainingcenter.service.TrainingDynamicService;
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
@RequestMapping("/trainingDynamic")
@Controller
public class TrainingDynamicController {


    @Qualifier("trainingDynamicService")
    @Autowired
    private TrainingDynamicService trainingDynamicService;

    @Qualifier("userService")
    @Autowired
    private UserService userService;

    @RequestMapping(value = "/listPage",method = RequestMethod.GET)
    @ResponseBody
    public AjaxJson listPage(@RequestParam("currentPage") Integer currentPage, @RequestParam("rows") Integer rows, String searchContent){
        AjaxJson ajaxJson = new AjaxJson();
        if(currentPage < 0 || rows < 0 ){
            return null;
        }
        List<TrainingDynamic> trainingDynamics = trainingDynamicService.getTrainingDynamics(currentPage, rows, searchContent);

        if(trainingDynamics.size() == 0){
            ajaxJson.setCode(1);
            ajaxJson.setMsg("暂无数据");
            return ajaxJson;
        }else {
            ajaxJson.setCode(1);
            ajaxJson.setMsg("請求成功");
            Map<String, Object> map = new ConcurrentHashMap<>();
            map.put("data",trainingDynamics);
            ajaxJson.setData(map);
            return ajaxJson;
        }
    }

    /**
     * 进入详细页面
     *
     * @return loginPage
     */
    @RequestMapping(value = "/detailsPage", method = RequestMethod.GET)
    public ModelAndView detailsPage(@RequestParam("id") String id) {
        String viewName = "static/detailsPage";
        return new ModelAndView(viewName);
    }

    /**
     * 进入添加页面
     *
     * @return loginPage
     */
    @RequestMapping(value = "/addPage", method = RequestMethod.GET)
    public ModelAndView addPage() {
        String viewName = "static/addPage";
        return new ModelAndView(viewName);
    }

    /**
     * 进入更新页面
     *
     * @return loginPage
     */
    @RequestMapping(value = "/updatePage", method = RequestMethod.GET)
    public ModelAndView updatePage(HttpServletRequest request) {
        String id = request.getParameter("trainingDynamicId");
        ModelAndView modelAndView =new ModelAndView();
        if(StringUtil.isNotEmpty(id)){
            String viewName = "static/updatePage";
            modelAndView.addObject("trainingDynamic",trainingDynamicService.getTrainingDynamicById(id));
            modelAndView.setViewName(viewName);

        }
        return modelAndView;
    }

    @RequestMapping(value = "/update",method = RequestMethod.GET)
    @ResponseBody
    public AjaxJson update(@Validated(value = {TC_Update.class}) TrainingDynamic trainingDynamic){
        AjaxJson ajaxJson = new AjaxJson();

        //获取当前用户
        String currentName = getCurrentUsername();
        User user = userService.getUserByUsername(currentName);

        if (user == null){
            throw new CredentialsExpiredException("登录凭证已过期");
        }

        if (trainingDynamic == null){
            ajaxJson.setCode(0);
            ajaxJson.setMsg("操作失败，对象不能为空");
            return ajaxJson;

        }
        //更新操作
        TrainingDynamic newTD = trainingDynamicService.getTrainingDynamicById(trainingDynamic.getId());
        if (newTD == null){
            throw new UpdateException("更新失败，对象不存在或已被删除");
        }
        newTD.setTitle(trainingDynamic.getTitle());
        newTD.setRemarks(trainingDynamic.getRemarks());
        newTD.setContent(trainingDynamic.getContent());
        newTD.setImgs(trainingDynamic.getImgs());
        newTD.setUpdateDate(new Date());
        newTD.setUpdateUserId(user.getId());

        return ajaxJson;
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
        TrainingDynamic trainingDynamic = new TrainingDynamic();
        trainingDynamic.setId(UUID.randomUUID().toString());
        trainingDynamic.setImgs(imgs);
        trainingDynamic.setContent(content);
        trainingDynamic.setRemarks(remarks);
        trainingDynamic.setCreateUserId(user.getId());
        trainingDynamic.setCreateDate(new Date());
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

        boolean delete = trainingDynamicService.batchDelete(ids);
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
