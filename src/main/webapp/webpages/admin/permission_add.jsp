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
    <title>添加权限</title>

    <link rel="stylesheet" href="${webRoot}/plug-in/layui-v2.4.5/layui/css/layui.css">
    <link rel="stylesheet" href="${webRoot}/plug-in/bootstrap3.3.5/css/bootstrap.min.css">

    <script src="${webRoot}/plug-in/jquery-3.2.1/jquery-3.2.1.min.js"></script>
    <script src="${webRoot}/plug-in/layui-v2.4.5/layui/layui.all.js"></script>
    <script src="${webRoot}/plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
    <script src="${webRoot}/webpages/static/js/utils.js"></script>
</head>
<body>
<br>
<div class="row">
    <div class="col-sm-1"></div>
    <div class="text-left col-sm-10 panel panel-primary">
        <br>
        <form class="form-horizontal" role="form" action="">
            <input type="hidden" value="" name="id" id="id">
            <div class="form-group">
                <label for="name" class="col-sm-2 control-label">权限名称</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" name="name" id="name" value="" placeholder="请填写权限名称">
                </div>
            </div>
            <div class="form-group">
                <label for="resourceId" class="col-sm-2 control-label">权限对应资源</label>
                <div class="col-sm-8">
                    <input type="hidden" name="resourceId" id="resourceId"/>
                    <input class="form-control" name="resourceName" id="resourceName" disabled="disabled"/>
                </div>
                <div class="col-sm-2">
                    <button id="selectResource_btn" class="layui-btn layui-btn-sm">选择资源</button>
                </div>
            </div>
            <div class="form-group">
                <label for="operations" class="col-sm-2 control-label">可操作权限</label>
                <div class="col-sm-10">
                    <select class="form-control" name="operations" id="operations" multiple="multiple">
                        <option value="READ">可查看</option>
                        <option value="CREATE">可添加</option>
                        <option value="UPDATE">可更新</option>
                        <option value="DELETE">可删除</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label for="state" class="col-sm-2 control-label">权限使用状态</label>
                <div class="col-sm-10">
                    <select class="form-control" name="state" id="state">
                        <option value="1">选择状态</option>
                        <option value="1">启用</option>
                        <option value="0">禁用</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label for="describe" class="col-sm-2 control-label">权限描述</label>
                <div class="col-sm-10">
                    <textarea rows="3" class="form-control" name="describe" id="describe"
                              placeholder="描述内容"></textarea>
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
        </form>
    </div>
    <div class="col-sm-1"></div>
</div>
</body>

<script type="text/javascript">
    $(document).ready(function () {
        //页面加载完成
        //……
    });

    //选择权限对应的资源
    $("#selectResource_btn").click(function () {
        parent.layer.open({		//从本页的父页面打开
            title: '编辑菜单',
            type: 2,
            area: ['1000px', '500px'],
            fix: false, //不固定
            maxmin: true,
            content: '${webRoot}/webpages/admin/resource_select.jsp'
        });
    });

    //设置资源的值，此方法由该弹出窗口的父窗口调用
    function setResourceData(jsonData) {
        $("#resourceId").val(jsonData.id);
        $("#resourceName").val(jsonData.name);
    }

    //提交
    $("#submit").click(function () {
        var id = $("#id").val();
        var name = $("#name").val();
        var resourceId = $("#resourceId").val();
        var operations = $("#operations").val().toString();
        var state = $("#state").val();
        var describe = $("#describe").val();
        var remarks = $("#remarks").val();

        if (name == null || name == "") {
            layer.msg("请填写权限名称！", {
                icon: 2,
                time: 2000 //2秒关闭（如果不配置，默认是3秒）
            });
            $("#name").css("border", "1px solid red");  //输入错误，输入框变红
            $("#name").focus();
            return false;
        } else {
            $("#name").css("border", "1px solid #009688");
            $("#name").blur();      //失去焦点
        }
        if (resourceId == null || resourceId == "") {
            layer.msg("请选择权限对应的资源！", {
                icon: 2,
                time: 2000 //2秒关闭（如果不配置，默认是3秒）
            });
            $("#resourceId").css("border", "1px solid red");
            $("#resourceId").focus();
            return false;
        } else {
            $("#resourceId").css("border", "1px solid #009688");
            $("#resourceId").blur();      //失去焦点
        }
        if (state == null || state == "") {
            layer.msg("请选择权限使用状态！", {
                icon: 2,
                time: 2000 //2秒关闭（如果不配置，默认是3秒）
            });
            $("#state").css("border", "1px solid red");
            $("#state").focus();
            return false;
        } else {
            $("#state").css("border", "1px solid #009688");
            $("#state").blur();      //失去焦点
        }

        var data = {
            id: id,
            name: name,
            resourceId: resourceId,
            operations: operations,
            state: state,
            describe: describe,
            remarks: remarks
        };

        $.ajax({
            url: "${webRoot}/permission/add",
            type: "post",
            data: data,
            dataType: "json",
            success: function (data) {
                var jsonData = eval(data);   //数据解析
                var code = jsonData.code;
                var msg = jsonData.msg;
                if (code == 1) {
                    layer.alert(msg, {
                        time: 3000,
                        icon: 1
                    });
                    close();    //关闭窗口
                } else {
                    layer.alert(msg, {
                        time: 3000,
                        icon: 2
                    });
                }
            }
        });
    });

    $("#close").click(function () {
        close();
    });

    function close() {
        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
        parent.layer.close(index); //再执行关闭
    }
</script>

</html>
