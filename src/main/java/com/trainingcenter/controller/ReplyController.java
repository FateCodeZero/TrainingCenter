package com.trainingcenter.controller;

import com.trainingcenter.bean.Reply;
import com.trainingcenter.bean.Reply;
import com.trainingcenter.bean.User;
import com.trainingcenter.controller.validation.TC_Add;
import com.trainingcenter.controller.validation.TC_Update;
import com.trainingcenter.exception.UpdateException;
import com.trainingcenter.service.ReplyService;
import com.trainingcenter.service.ReplyService;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
@RequestMapping("/reply")
@Controller
public class ReplyController {
    @Autowired
    private UserService userService;
    @Qualifier("replyService")
    @Autowired
    private ReplyService replyService;

    /**
     * 分页获取资源数据（获取全部，（已启用 + 已禁用 + 已删除（软删除）））
     *
     * @param currentPage：当前页
     * @param rows：每页展示的数据条数
     * @param request：其他参数，如模糊查询等
     */
    @ResponseBody
    @RequestMapping("/listPage")
    public AjaxJson getReplys_all(@RequestParam("currentPage") Integer currentPage, @RequestParam("rows") Integer rows, HttpServletRequest request) {
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
                condition = FindConditionUtils.findConditionBuild(Reply.class,conditionStr);
            }

            //获取当前查询条件下的所有数据条数，分页用
            Integer total = replyService.getReplys(condition).size();
            //获取当前页的数据
            List<Reply> replys = replyService.getReplys(currentPage, rows, condition);

            ajaxJson.setCode(1);
            if (replys.size() == 0) {
                ajaxJson.setMsg("暂无数据Ծ‸Ծ");
            } else {
                ajaxJson.setMsg("数据获取成功");
            }

            Map<String, Object> data = new ConcurrentHashMap<>();
            data.put("total", total);
            data.put("items", replys);
            ajaxJson.setData(data);
            return ajaxJson;
        }
    }

    /**
     * 分页获取资源数据（获取只获取已启用的）
     *
     * @param currentPage：当前页
     * @param rows：每页展示的数据条数
     */
    @ResponseBody
    @RequestMapping("/select")
    public AjaxJson getReplys_select(@RequestParam("currentPage") Integer currentPage, @RequestParam("rows") Integer rows, HttpServletRequest request) {
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
                condition = FindConditionUtils.findConditionBuild(Reply.class,conditionStr);
            }
            condition.put("state", 1);   //只查询已启用的数据

            //获取当前查询条件下的所有数据条数，分页用
            Integer total = replyService.getReplys(condition).size();
            //获取当前页的数据
            List<Reply> replys = replyService.getReplys(currentPage, rows, condition);

            ajaxJson.setCode(1);
            if (replys.size() == 0) {
                ajaxJson.setMsg("暂无数据Ծ‸Ծ");
            } else {
                ajaxJson.setMsg("数据获取成功");
            }

            Map<String, Object> data = new ConcurrentHashMap<>();
            data.put("total", total);
            data.put("items", replys);
            ajaxJson.setData(data);
            return ajaxJson;
        }
    }


    @ResponseBody
    @RequestMapping("/add")
    public AjaxJson add(@Validated(value = {TC_Add.class}) Reply reply) {
        User user = null;
        //获取当前用户
        String currentUsername = SysResourcesUtils.getCurrentUsername(); //当前登录人账号
        if (!"anonymousUser".equals(currentUsername)){
            user = userService.getUserByUsername(currentUsername); //当前登录对象
        }
        if (user == null) {
            throw new CredentialsExpiredException("登录凭证已过期");
        }

        AjaxJson ajaxJson = new AjaxJson(); //返回的Json数据封装对象
        if (reply == null) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("添加失败，添加对象不能为空");
            return ajaxJson;
        }
        reply.setId(UUID.randomUUID().toString());
        reply.setCreateUserId(user.getId());
        reply.setCreateDate(new Date());

        Integer res = replyService.add(reply);

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
    public AjaxJson update(@Validated(value = {TC_Update.class}) Reply reply) {
        User user = null;
        //获取当前用户
        String currentUsername = SysResourcesUtils.getCurrentUsername(); //当前登录人账号
        if (!"anonymousUser".equals(currentUsername)){
            user = userService.getUserByUsername(currentUsername); //当前登录对象
        }

        if (user == null) {
            throw new CredentialsExpiredException("登录凭证已过期");
        }

        AjaxJson ajaxJson = new AjaxJson(); //返回的Json数据封装对象

        if (reply == null || StringUtil.isEmpty(reply.getId())) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("更新失败，更新对象不能为空");
            return ajaxJson;
        }

        String id = reply.getId(); //更新对象的ID

        //从数据库读取旧的对象进行更新
        Reply oldReply = replyService.getReplyById(id);
        if (oldReply == null) {
            throw new UpdateException("更新失败，对象不存在或已被删除");
        }
        if (StringUtil.isNotEmpty(reply.getContent())) {
            oldReply.setContent(reply.getContent());
        }

        Integer res = replyService.update(oldReply); //操作结果 flag

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

        Integer res = replyService.batchDelete(ids);
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
    @RequestMapping("/getReplyById")
    public AjaxJson getReplyById(@RequestParam("id") String id) {
        AjaxJson ajaxJson = new AjaxJson();
        if (StringUtil.isEmpty(id)) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("请先选择要查询的对象");
            return ajaxJson;
        }

        Reply reply = replyService.getReplyById(id);
        if (reply == null) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("对象不存在或已被删除");
            return ajaxJson;
        } else {
            ajaxJson.setCode(1);
            ajaxJson.setMsg("获取成功");
            Map<String, Object> map = new ConcurrentHashMap<>();
            map.put("reply", reply);
            ajaxJson.setData(map);
            return ajaxJson;
        }
    }

    /**
     * 通过 id 获取资源对象
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/getReplyByCommentId")
    public AjaxJson getReplyByReplyId(@RequestParam("id") String id,@RequestParam("currentPage") Integer currentPage, @RequestParam("rows") Integer rows,
                                        HttpServletRequest request) {
        AjaxJson ajaxJson = new AjaxJson();
        if (currentPage == null || rows == null) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("数据获取失败，页数不能为空");
            return ajaxJson;
        } else {
        }
            //自定义查询条件，以 key-value 的形式进行条件查询，模糊查询的 key 固定为 searchContent
            Map<String, Object> condition = new ConcurrentHashMap<>();
            String conditionStr = request.getParameter("condition");
            if (StringUtil.isNotEmpty(conditionStr)){
                condition = FindConditionUtils.findConditionBuild(Reply.class,conditionStr);
            }
            condition.put("state", 1);   //只查询已启用的数据

            //获取当前查询条件下的所有数据条数，分页用
            Integer total = replyService.getReplyByCommentId(id,condition).size();
            //获取当前页的数据
            List<Reply> replies = replyService.getReplyByCommentId(id,currentPage, rows, condition);

            ajaxJson.setCode(1);
            if (replies.size() == 0) {
                ajaxJson.setMsg("暂无数据Ծ‸Ծ");
            } else {
                ajaxJson.setMsg("数据获取成功");
            }

            Map<String, Object> data = new ConcurrentHashMap<>();
            data.put("total", total);
            data.put("items", replies);
            ajaxJson.setData(data);
            return ajaxJson;
        }
} 