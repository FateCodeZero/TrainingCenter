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
    <title>添加菜单</title>

    <link rel="stylesheet" href="${webRoot}/plug-in/layui-v2.4.5/layui/css/layui.css">
    <link rel="stylesheet" href="${webRoot}/plug-in/bootstrap3.3.5/css/bootstrap.min.css">

    <script src="${webRoot}/plug-in/jquery-3.2.1/jquery-3.2.1.min.js"></script>
    <script src="${webRoot}/plug-in/layui-v2.4.5/layui/layui.all.js"></script>
    <script src="${webRoot}/plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
    <script src="${webRoot}/webpages/admin/js/utils.js"></script>
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
                <label for="name" class="col-sm-2 control-label">菜单名称</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" name="name" id="name" value="" placeholder="请填写菜单名称">
                </div>
            </div>
            <div class="form-group">
                <label for="url" class="col-sm-2 control-label">URL</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" name="url" id="url" value="" placeholder="请填写菜单URL">
                </div>
            </div>
            <div class="form-group">
                <label for="state" class="col-sm-2 control-label">菜单使用状态</label>
                <div class="col-sm-10">
                    <select class="form-control" name="state" id="state">
                        <option value="1">选择状态</option>
                        <option value="1" id="enable">启用</option>
                        <option value="0" id="unEnable">禁用</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label for="describe" class="col-sm-2 control-label">资源描述</label>
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

        /*从URL获取对象ID*/
        var resourceId = getUrlParam('id');
        /*通过ID获取对象信息*/
        var resource = getResourceById(resourceId);
        /*初始化编辑数据*/
        editDataInitialization(resource);
    });

    /**
     * 编辑数据初始化
     * @param resource：要编辑的资源对象
     */
    function editDataInitialization(resource) {
        if (resource === null || resource === '') {
            layer.alert('数据初始化失败，对象不能为空', {
                time: 3000,
                icon: 2
            });
            return false;
        }
        $("#id").val(resource.id);
        $("#name").val(resource.name);
        $("#url").val(resource.url);
        var state = resource.state;
        if(state === 1){
            $("#enable").attr('selected','selected')
        }else {
            $("#unEnable").attr('selected','selected')
        }
        $("#describe").html(resource.describe);
        $("#remarks").html(resource.remarks);
    }

    /**
     * 通过 id 获取资源
     * @param id
     * @returns {*}
     */
    function getResourceById(id) {
        if (id == null || id == '') {
            layer.alert('id不能为空！', {
                time: 3000,
                icon: 2
            });
            return false;
        }
        var resource = null;
        var data = {id: id};
        $.ajax({
            url: "${webRoot}/resource/getResourceById",
            type: "get",
            async: false,    //关闭异步请求
            data: data,
            dataType: "json",
            success: function (data) {
                var jsonData = eval(data); //数据解析
                var code = jsonData.code;
                var msg = jsonData.msg;
                if (code == 1) {
                    resource = jsonData.data.resource;
                } else {
                    layer.alert(msg, {
                        time: 3000,
                        icon: 2
                    });
                    return false;
                }
            }
        });
        return resource;
    }

    //提交
    $("#submit").click(function () {
        var id = $("#id").val();
        var name = $("#name").val();
        var url = $("#url").val();
        var state = $("#state").val();
        var describe = $("#describe").val();
        var remarks = $("#remarks").val();

        if (name === null || name === '') {
            layer.msg("请填写菜单名称！", {
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
        if (url === null || url === '') {
            layer.msg("请填写菜单URL！", {
                icon: 2,
                time: 2000 //2秒关闭（如果不配置，默认是3秒）
            });
            $("#url").css("border", "1px solid red");
            $("#url").focus();
            return false;
        } else {
            $("#url").css("border", "1px solid #009688");
            $("#url").blur();      //失去焦点
        }
        if (state === null || state === '') {
            layer.msg("请选择菜单使用状态！", {
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
            url: url,
            state: state,
            describe: describe,
            remarks: remarks
        };

        $.ajax({
            url: "${webRoot}/resource/update",
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
                    /*close();*/    //关闭窗口
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