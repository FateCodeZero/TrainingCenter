package com.trainingcenter.controller;

/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/12/13
 * Time: 22:33
 */

import com.trainingcenter.bean.LockedIP;
import com.trainingcenter.bean.SysLog;
import com.trainingcenter.service.SysLogService;
import com.trainingcenter.utils.AjaxJson;
import com.trainingcenter.utils.FindConditionUtils;
import com.trainingcenter.utils.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 系统日志Controller
 */
@Controller
@RequestMapping("/sysLog")
public class SysLogController {
    @Qualifier("sysLogService")
    @Autowired
    private SysLogService sysLogService;

    @PreAuthorize("hasPermission('/webpages/admin/sysLog_list.jsp','READ')")
    @ResponseBody
    @RequestMapping("/list")
    public AjaxJson getSysLogs(@RequestParam("currentPage") Integer currentPage, @RequestParam("rows") Integer rows, HttpServletRequest request){
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
            Integer total = sysLogService.getSysLogs(condition).size();
            //获取当前页的数据
            List<SysLog> sysLogs = sysLogService.getSysLogs(currentPage, rows, condition);
            ajaxJson.setCode(1);
            if (sysLogs.size() == 0){
                ajaxJson.setMsg("暂无数据Ծ‸Ծ");
            }else {
                ajaxJson.setMsg("数据获取成功");
            }
            Map<String,Object> data = new ConcurrentHashMap<>();
            data.put("total",total);
            data.put("items",sysLogs);
            ajaxJson.setData(data);
            return ajaxJson;
        }
    }

    /**
     * 删除权限，支持批量删除
     * @param ids
     * @return
     */
    @PreAuthorize("hasPermission('/webpages/admin/sysLog_list.jsp','DELETE')")
    @ResponseBody
    @RequestMapping(value = "/delete")
    public AjaxJson delete(@RequestParam("ids") String ids) {
        AjaxJson ajaxJson = new AjaxJson();
        if (StringUtil.isEmpty(ids)) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("请先选择要删除的对象");
            return ajaxJson;
        }
        Integer res = sysLogService.batchDelete(ids);
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
    @RequestMapping(value = "/getSysLogById")
    public AjaxJson getSysLogById(@RequestParam("id") String id) {
        AjaxJson ajaxJson = new AjaxJson();
        if (StringUtil.isEmpty(id)) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("请先选择要查询的对象");
            return ajaxJson;
        }

        SysLog sysLog = sysLogService.getSysLogById(id);
        if (sysLog == null) {
            ajaxJson.setCode(0);
            ajaxJson.setMsg("对象不存在或已被删除");
            return ajaxJson;
        } else {
            ajaxJson.setCode(1);
            ajaxJson.setMsg("获取成功");
            Map<String, Object> map = new ConcurrentHashMap<>();
            map.put("sysLog", sysLog);
            ajaxJson.setData(map);
            return ajaxJson;
        }
    }
}