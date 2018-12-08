<%--
  Created by IntelliJ IDEA.
  User: YangYi
  Date: 2018/11/22
  Time: 15:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/context/mytags.jsp" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>添加封禁IP</title>

    <link rel="stylesheet" href="${webRoot}/plug-in/layui-v2.4.5/layui/css/layui.css">
    <link rel="stylesheet" href="${webRoot}/plug-in/bootstrap3.3.5/css/bootstrap.min.css">

    <script src="${webRoot}/plug-in/jquery-3.2.1/jquery-3.2.1.min.js"></script>
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
            <input type="hidden" id="id">
            <div class="form-group">
                <label for="ip" class="col-sm-2 control-label">封禁IP</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" name="ip" id="ip" value="" placeholder="请填写要封禁的IP">
                </div>
            </div>
            <div class="form-group">
                <label for="remarks" class="col-sm-2 control-label">备注</label>
                <div class="col-sm-10">
                    <textarea rows="3" class="form-control" name="remarks" id="remarks"
                              placeholder="备注内容"></textarea>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10 text-center">
                    <button type="button" class="layui-btn col-sm-4" id="submit">提交</button>
                    <div class="col-sm-1"></div>
                    <button type="button" class="layui-btn layui-btn-normal col-sm-4" id="close">关闭并回返</button>
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
        var lockedIPId = getUrlParam('id');
        /*通过ID获取对象信息*/
        var lockedIP = getLockedIPById(lockedIPId);
        /*初始化编辑数据*/
        editDataInitialization(lockedIP);
    });

    /**
     * 编辑数据初始化
     * @param lockedIP：要编辑的角色对象
     */
    function editDataInitialization(lockedIP) {
        if (lockedIP === null || lockedIP === '') {
            layer.alert('数据初始化失败，对象不能为空', {
                time: 3000,
                icon: 2
            });
            return false;
        }
        $("#id").val(lockedIP.id);
        $("#ip").val(lockedIP.ip);
        $("#remarks").val(lockedIP.remarks);
    }

    //提交
    $("#submit").click(function () {
        var id = $("#id").val();
        var ip = $("#ip").val();
        var remarks = $("#remarks").val();

        if (ip === null || ip === "") {
            layer.msg("请先填写要封禁IP", {
                icon: 2,
                time: 2000 //2秒关闭（如果不配置，默认是3秒）
            });
            $("#ip").css("border", "1px solid red");  //输入错误，输入框变红
            $("#ip").focus();
            return false;
        } else {
            $("#ip").css("border", "1px solid #009688");
            $("#ip").blur();      //失去焦点
        }

        var data = {
            id:id,
            ip: ip,
            remarks: remarks
        };

        $.ajax({
            url: "${webRoot}/lockedIP/update",
            type: "post",
            data: data,
            dataType: "json",
            success: function (data) {
                var jsonData = eval(data);   //数据解析
                var code = jsonData.code;
                var msg = jsonData.msg;
                if (code === 1) {
                    layer.alert(msg, {
                        time: 3000,
                        icon: 1
                    });
                    closeView();    //关闭窗口
                } else {
                    layer.alert(msg, {
                        time: 3000,
                        icon: 2
                    });
                }
            }
            , error: function (jqXHR, textStatus, errorThrown) {
                ajaxErrorHandler(jqXHR); //ajax请求异常统一处理
            }
        });
    });

    /**
     * 通过id获取IP锁定对象
     * @param id
     */
    function getLockedIPById(id) {
        if (id === null || id === '') {
            layer.alert('请先选择要查询的数据', {
                time: 3000,
                icon: 2
            });
            return false;
        }
        var lockedIP = null;
        var data = {id: id};
        $.ajax({
            url: "${webRoot}/lockedIP/getLockedIPById",
            type: "get",
            async: false,    //关闭异步请求
            data: data,
            dataType: "json",
            success: function (data) {
                var jsonData = eval(data); //数据解析
                var code = jsonData.code;
                var msg = jsonData.msg;
                if (code === 1) {
                    lockedIP = jsonData.data.lockedIP;
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
        return lockedIP;
    }

    $("#close").click(function () {
        closeView();
    });

    function closeView() {
        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
        parent.layer.close(index); //再执行关闭
    }

</script>

</html>
