<%--
  Created by IntelliJ IDEA.
  User: YangYi
  Date: 2018/11/22
  Time: 15:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/context/mytags.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>日志详情</title>

    <link rel="stylesheet" href="${webRoot}/plug-in/layui-v2.4.5/layui/css/layui.css">
    <link rel="stylesheet" href="${webRoot}/plug-in/bootstrap3.3.5/css/bootstrap.min.css">

    <script src="${webRoot}/plug-in/jquery-3.2.1/jquery-3.2.1.min.js"></script>
    <script src="${webRoot}/plug-in/jquery-cookie/jquery.cookie.js"></script>
    <script src="${webRoot}/plug-in/layui-v2.4.5/layui/layui.all.js"></script>
    <script src="${webRoot}/plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
    <script src="${webRoot}/plug-in/js/utils.js"></script>
</head>
<body>
<br>
<div class="row">
    <div class="col-sm-1"></div>
    <div class="text-left col-sm-10 panel panel-primary">
        <br>
        <div class="form-horizontal">
            <input type="hidden" value="" name="id" id="id">
            <div class="form-group">
                <label for="opUserId" class="col-sm-2 control-label">操作人</label>
                <div class="col-sm-10">
                    <input type="hidden" class="form-control" name="opUserId" id="opUserId" value="" disabled="disabled"
                           placeholder="操作人id">
                    <input type="text" class="form-control" name="opUsername" id="opUsername" value="" disabled="disabled"
                           placeholder="操作人">
                </div>
            </div>
            <div class="form-group">
                <label for="opContent" class="col-sm-2 control-label">操作内容</label>
                <div class="col-sm-10">
                    <textarea rows="3" class="form-control" name="opContent" id="opContent"
                              placeholder="操作内容"></textarea>
                </div>
            </div>
            <div class="form-group">
                <label for="opType" class="col-sm-2 control-label">操作类型</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" name="opType" id="opType" value="" disabled="disabled"
                           placeholder="操作类型">
                </div>
            </div>
            <div class="form-group">
                <label for="opTime" class="col-sm-2 control-label">操作时间</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" name="opTime" id="opTime" value="" disabled="disabled"
                           placeholder="操作时间">
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10 text-center">
                    <div class="col-sm-2"></div>
                    <button type="button" class="layui-btn layui-btn-normal col-sm-6" id="close">确定</button>
                    <div class="col-sm-2"></div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-sm-1"></div>
</div>
</body>

<script type="text/javascript">
    $(document).ready(function () {
        //页面加载完成
        //……

        /*从URL获取对象ID*/
        var sysLogId = getUrlParam('id');
        /*通过ID获取对象信息*/
        var sysLog = getSysLogById(sysLogId);
        /*初始化编辑数据*/
        editDataInitialization(sysLog);
        laydate();
    });

    /*日期*/
    function laydate() {
        layui.use(['laydate'], function () {
            var laydate = layui.laydate;
            //执行选择日期实例
            laydate.render({
                elem: '#createDate' //指定元素
            });
        });
    }

    /**
     * 编辑数据初始化
     * @param role：要编辑的角色对象
     */
    function editDataInitialization(sysLog) {
        if (sysLog === null || sysLog === '') {
            layer.alert('数据初始化失败，对象不能为空', {
                time: 3000,
                icon: 2
            });
            return false;
        }

        $("#id").val(sysLog.id);
        $("#opContent").val(sysLog.opContent);
        $("#opType").val(sysLog.opType);

        var opUserId = sysLog.opUserId;
        $("#opUserId").val(opUserId);
        var user = getUserById(opUserId);
        $("#opUsername").val(user.username);

        $("#opTime").val(new Date(sysLog.opTime).toLocaleString('chinese', {hour12: false}).replace(/:d{1,2}$/, ' '));
    }

    /**
     * 通过 id 获取日志对象
     * @param id
     */
    function getSysLogById(id) {
        if (id === null || id === '') {
            layer.alert('请先选择要查询的数据', {
                time: 3000,
                icon: 2
            });
            return false;
        }
        var sysLog = null;
        var data = {id: id};
        $.ajax({
            url: "${webRoot}/sysLog/getSysLogById",
            type: "get",
            async: false,    //关闭异步请求
            data: data,
            dataType: "json",
            success: function (data) {
                var jsonData = eval(data); //数据解析
                var code = jsonData.code;
                var msg = jsonData.msg;
                if (code === 1) {
                    sysLog = jsonData.data.sysLog;
                } else {
                    layer.alert(msg, {
                        time: 3000,
                        icon: 2
                    });
                    return false;
                }
            }
            , error: function (jqXHR, textStatus, errorThrown) {
                ajaxErrorHandler(jqXHR); //ajax请求异常统一处理
            }
        });
        return sysLog;
    }

    $("#close").click(function () {
        closeView();
    });

    function closeView() {
        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
        parent.layer.close(index); //再执行关闭
    }

    /**
     * 通过 id 获取用户
     * @param id
     * @returns {*}
     */
    function getUserById(id) {
        if (id === null || id === '') {
            layer.alert('id不能为空！', {
                time: 3000,
                icon: 2
            });
            return false;
        }
        var user = null;
        var data = {id: id};
        $.ajax({
            url: "${webRoot}/user/getUserById",
            type: "get",
            async: false,    //关闭异步请求
            data: data,
            dataType: "json",
            success: function (data) {
                var jsonData = eval(data); //数据解析
                var code = jsonData.code;
                var msg = jsonData.msg;
                if (code === 1) {
                    user = jsonData.data.user;
                } else {
                    layer.alert(msg, {
                        time: 3000,
                        icon: 2
                    });
                    return false;
                }
            }
            , error: function (jqXHR, textStatus, errorThrown) {
                ajaxErrorHandler(jqXHR); //ajax请求异常统一处理
            }
        });
        return user;
    }

</script>

</html>
