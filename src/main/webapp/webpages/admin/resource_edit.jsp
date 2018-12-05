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
    <title>编辑菜单</title>

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
                <label for="parentId" class="col-sm-2 control-label">父级菜单</label>
                <div class="col-sm-8">
                    <input type="hidden" name="parentId" id="parentId"/>
                    <input type="text" class="form-control" name="parentName" id="parentName" value=""
                           disabled="disabled"
                           placeholder="选择父级菜单，顶级菜单为管理系统首页">
                </div>
                <div class="col-sm-2">
                    <button id="parentResource_btn" class="layui-btn layui-btn-sm">选择父级菜单</button>
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
                <label for="orderNumber" class="col-sm-2 control-label">菜单排序</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" name="orderNumber" id="orderNumber" value=""
                           placeholder="请填写菜单顺序">
                </div>
            </div>
            <div class="form-group">
                <label for="iconStyle" class="col-sm-2 control-label">菜单图标</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" name="iconStyle" id="iconStyle" value=""
                           placeholder="请填写菜单图标icon">
                </div>
                <a href="https://getbootstrap.com/docs/3.3/components/" style="color: #009688" target="_blank">查看图标</a>
            </div>
            <div class="form-group">
                <label for="describe" class="col-sm-2 control-label">菜单描述</label>
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
        </div>
    </div>
    <div class="col-sm-1"></div>
</div>
</body>

<script type="text/javascript">
    $(document).ready(function () {
        //页面加载完成
        //……
        ajaxErrorHandler(); //ajax请求错误统一处理

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
        var parentId = resource.parentId;
        //父菜单对象
        if (parentId == 0 || parentId === '0'){
            //顶级菜单的父对象id为0,父对象名称显示自己
            $("#parentId").val("0");
            $("#parentName").val(resource.name);
        }else {
            var parent = getResourceById(resource.parentId);
            $("#parentId").val(parent.id);
            $("#parentName").val(parent.name);
        }

        $("#orderNumber").val(resource.orderNumber);
        $("#iconStyle").val(resource.iconStyle);
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
        if (id === null || id === '') {
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
                if (code === 1) {
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
        var parentId = $("#parentId").val();
        var orderNumber = $("#orderNumber").val();
        var iconStyle = $("#iconStyle").val();
        var describe = $("#describe").val();
        var remarks = $("#remarks").val();

        if (id === null || id === ''){
            var msg = '<div style="text-align: center"><span style="color: #FF5722;font-size: large">对象不存在或已被删除，</span><br>即将返回列表界面。</div>';
            layer.confirm(msg, {
                    btn: ['确定', '取消']//按钮
                }
                , function () { //确定之后执行
                    closeView();    //关闭当前窗口
                }, function () { //取消之后执行
                    closeView();    //关闭当前窗口
                }
            );
        }

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
        if (orderNumber === null || orderNumber === "") {
            layer.msg("请填写菜单顺序！", {
                icon: 2,
                time: 2000 //2秒关闭（如果不配置，默认是3秒）
            });
            $("#orderNumber").css("border", "1px solid red");
            $("#orderNumber").focus();
            return false;
        } else {
            $("#orderNumber").css("border", "1px solid #009688");
            $("#orderNumber").blur();      //失去焦点
        }

        var data = {
            id: id,
            name: name,
            url: url,
            state: state,
            parentId: parentId,
            orderNumber:orderNumber,
            iconStyle: iconStyle,
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
        });
    });

    $("#parentResource_btn").click(function () {
        parent.layer.open({		//从本页的父页面打开
            title: '选择父级菜单',
            type: 2,
            area: ['1000px', '500px'],
            fix: false, //不固定
            maxmin: true,
            content: '${webRoot}/webpages/admin/resource_select.jsp',
        });
    });

    //设置资源的值，此方法由该弹出窗口的父窗口调用
    function setResourceData(jsonData) {
        $("#parentId").val(jsonData.id);
        $("#parentName").val(jsonData.name);
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
