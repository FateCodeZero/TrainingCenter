package com.trainingcenter.controller;

import com.trainingcenter.bean.Comment;
import com.trainingcenter.bean.User;
import com.trainingcenter.controller.validation.TC_Add;
import com.trainingcenter.controller.validation.TC_Update;
import com.trainingcenter.exception.UpdateException;
import com.trainingcenter.service.CommentService;
import com.trainingcenter.service.UserService;
import com.trainingcenter.utils.AjaxJson;
import com.trainingcenter.utils.FindConditionUtils;
import com.trainingcenter.utils.StringUtil;
import com.trainingcenter.utils.SysResourcesUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.access.prepost.PreAuthorize;
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
@RequestMapping("/comment")
@Controller
public class CommentController {
    @Qualifier("commentService")
    @Autowired
    private CommentService commentService;
    @Qualifier("userService")
    @Autowired
    private UserService userService;

    /**
     * 获取数据总数分页用
     * @return
     */
    @ResponseBody
    @RequestMapping("/getTotal")
    public AjaxJson getTotal(HttpServletRequest request){
        AjaxJson ajaxJson = new AjaxJson();
        //自定义查询条件，以 key-value 的形式进行条件查询，模糊查询的 key 固定为 searchContent
        Map<String, Object> condition = new ConcurrentHashMap<>();
        String conditionStr = request.getParameter("condition");
        if (StringUtil.isNotEmpty(conditionStr)){
            condition = FindConditionUtils.findConditionBuild(Comment.class,conditionStr);
        }
        String currentUsername = SysResourcesUtils.getCurrentUsername();
        if (StringUtil.isEmpty(currentUsername) || "anonymousUser".equals(currentUsername)){
            //保证未通过审批的评论不展示
            condition.put("state",1);
        }else {
            User user = userService.getUserByUsername(currentUsername);
            if (user != null){
                //保证评论用户可以看到自己所发的评论
                condition.put("currentUserId",user.getId());
            }else {
                //保证未通过审批的评论不展示
                condition.put("state",1);
            }
        }
        //获取当前查询条件下的所有数据条数，分页用
        Integer total = commentService.getComments(condition).size();

        ajaxJson.setCode(1);
        ajaxJson.setMsg("获取成功");
        Map<String,Object> data = new ConcurrentHashMap<>();
        data.put("total",total);
        ajaxJson.setData(data);
        return ajaxJson;
    }

    /**
     * 获取未审核的留言条数
     * @return
     */
    @ResponseBody
    @RequestMapping("/getUnEnableCount")
    public AjaxJson getUnEnableCount(){
        //自定义查询条件，以 key-value 的形式进行条件查询，模糊查询的 key 固定为 searchContent
        Map<String, Object> condition = new ConcurrentHashMap<>();
        condition.put("state",0);

        //获取当前查询条件下的所有数据条数，分页用
        Integer total = commentService.getComments(condition).size();
        AjaxJson ajaxJson = new AjaxJson();
        ajaxJson.setCode(1);
        ajaxJson.setMsg("查询成功");
        Map<String,Object> data = new ConcurrentHashMap<>();
        data.put("total",total);
        ajaxJson.setData(data);
        return ajaxJson;
    }

    /**
     * 分页获取资源数据（获取全部，（已启用 + 已禁用 + 已删除（软删除）））
     * @param currentPage：当前页
     * @param rows：每页展示的数据条数
     * @param request：其他参数，如模糊查询等
     */
    @PreAuthorize("hasPermission('/webpages/admin/comment_list.jsp','READ')")
    @ResponseBody
    @RequestMapping("/all")
    public AjaxJson getComments_all(@RequestParam("currentPage") Integer currentPage, @RequestParam("rows") Integer rows, HttpServletRequest request) {
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
                condition = FindConditionUtils.findConditionBuild(Comment.class,conditionStr);
            }

            //获取当前查询条件下的所有数据条数，分页用
            Integer total = commentService.getComments(condition).size();
            //获取当前页的数据
            List<Comment> comments = commentService.getComments(currentPage, rows, condition);

            ajaxJson.setCode(1);
            if (comments.size() == 0) {
                ajaxJson.setMsg("暂无数据Ծ‸Ծ");
            } else {
                ajaxJson.setMsg("数据获取成功");
            }

            Map<String, Object> data = new ConcurrentHashMap<>();
            data.put("total", total);
            data.put("items", comments);
            ajaxJson.setData(data);
            return ajaxJson;
        }
    }

    /**
     * 分页获取资源数据，首页显示
     * @param currentPage：当前页
     * @param rows：每页展示的数据条数
     * @param request：其他参数，如模糊查询等
     */
    @ResponseBody
    @RequestMapping("/list")
    public AjaxJson getComments(@RequestParam("currentPage") Integer currentPage, @RequestParam("rows") Integer rows, HttpServletRequest request) {
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
                condition = FindConditionUtils.findConditionBuild(Comment.class,conditionStr);
            }
            String currentUsername = SysResourcesUtils.getCurrentUsername();
            if (StringUtil.isEmpty(currentUsername) || currentUsername.equals("anonymousUser")){
                //保证未通过审批的评论不展示
                condition.put("state",1);
            }else {
                User user = userService.getUserByUsername(currentUsername);
                if (user != null){
                    //保证评论用户可以看到自己所发的评论
                    condition.put("currentUserId",user.getId());
                }else {
                    //保证未通过审批的评论不展示
                    condition.put("state",1);
                }
            }

            //获取当前查询条件下的所有数据条数，分页用
            Integer total = commentService.getComments(condition).size();
            //获取当前页的数据
            List<Comment> comments = commentService.getComments(currentPage, rows, condition);

            ajaxJson.setCode(1);
            if (comments.size() == 0) {
                ajaxJson.setMsg("暂无数据Ծ‸Ծ");
            } else {
                ajaxJson.setMsg("数据获取成功");
            }

            Map<String, Object> data = new ConcurrentHashMap<>();
            data.put("total", total);
            data.put("items", comments);
            ajaxJson.setData(data);
            return ajaxJson;
        }
    }

    @PreAuthorize("hasPermission('/webpages/admin/comment_list.jsp','CREATE')")
    @ResponseBody
    @RequestMapping("/add")
    public AjaxJson add(@Validated(value = {TC_Add.class}) Comment comment) {
        AjaxJson ajaxJson = new AjaxJson(); //返回的Json数据封装对象
        User user = null;
        //获取当前用户
        String currentUsername = SysResourcesUtils.getCurrentUsername(); //当前登录人账号
        if (!"anonymousUser".equals(currentUsername)){
            user = userService.getUserByUsername(currentUsername); //当前登录对象
        }
        if (user == null) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("只有登录后才能评论哟");
            return ajaxJson;
        }

        if (comment == null) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("请稍微写点什么吧");
            return ajaxJson;
        }

        comment.setId(UUID.randomUUID().toString());
        comment.setReplyCount(0);
        comment.setPraiseCount(0);
        comment.setState(0); //默认不显示，需要审核
        comment.setCreateUserId(user.getId());
        comment.setCreateDate(new Date());
        comment.setUpdateUserId(user.getId());
        comment.setUpdateDate(new Date());

        Integer res = commentService.add(comment);

        if (res == 0) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("评论失败，请重试");
            return ajaxJson;
        } else {
            ajaxJson.setCode(1);
            ajaxJson.setMsg("评论成功");
            return ajaxJson;
        }
    }

    @PreAuthorize("hasPermission('/webpages/admin/comment_list.jsp','UPDATE')")
    @ResponseBody
    @RequestMapping("/update")
    public AjaxJson update(@Validated(value = {TC_Update.class}) Comment comment) {
        String currentUsername = SysResourcesUtils.getCurrentUsername();    //当前登录用户的用户名
        User currentUser = userService.getUserByUsername(currentUsername);  //当前登录用户对象

        if (currentUser == null) {
            throw new CredentialsExpiredException("登录凭证已过期");
        }

        AjaxJson ajaxJson = new AjaxJson(); //返回的Json数据封装对象

        if (comment == null || StringUtil.isEmpty(comment.getId())) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("更新失败，更新对象不能为空");
            return ajaxJson;
        }

        String id = comment.getId(); //更新对象的ID

        //从数据库读取旧的对象进行更新
        Comment oldComment = commentService.getCommentById(id);
        if (oldComment == null) {
            throw new UpdateException("更新失败，对象不存在或已被删除");
        }
        if (StringUtil.isNotEmpty(comment.getContent())) {
            oldComment.setContent(comment.getContent());
        }
        if (StringUtil.isNotEmpty(comment.getTitle())) {
            oldComment.setTitle(comment.getTitle());  //注意：URL在上线时应不能更改
        }
        if (comment.getState() != null) {
            oldComment.setState(comment.getState());
        }
        oldComment.setUpdateUserId(currentUser.getId());
        oldComment.setUpdateDate(new Date());

        Integer res = commentService.update(oldComment); //操作结果 flag

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
    @PreAuthorize("hasPermission('/webpages/admin/comment_list.jsp','UPDATE')")
    @ResponseBody
    @RequestMapping("/delete")
    public AjaxJson delete(@RequestParam("ids") String ids) {
        AjaxJson ajaxJson = new AjaxJson();
        if (StringUtil.isEmpty(ids)) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("请先选择要删除的对象");
            return ajaxJson;
        }

        Integer res = commentService.batchDelete(ids);
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
    @RequestMapping("/getCommentById")
    public AjaxJson getCommentById(@RequestParam("id") String id) {
        AjaxJson ajaxJson = new AjaxJson();
        if (StringUtil.isEmpty(id)) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("请先选择要查询的对象");
            return ajaxJson;
        }

        Comment comment = commentService.getCommentById(id);
        if (comment == null) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("对象不存在或已被删除");
            return ajaxJson;
        } else {
            ajaxJson.setCode(1);
            ajaxJson.setMsg("获取成功");
            Map<String, Object> map = new ConcurrentHashMap<>();
            map.put("comment", comment);
            ajaxJson.setData(map);
            return ajaxJson;
        }
    }

} 