<%--
  Created by IntelliJ IDEA.
  User: YangYi
  Date: 2018/10/22
  Time: 2:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/context/mytags.jsp" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>注册</title>
    <%--CSS--%>
    <link rel="stylesheet" href="${webRoot}/plug-in/bootstrap3.3.5/css/bootstrap.min.css" media="all">
    <link rel="stylesheet" href="${webRoot}/plug-in/layui-v2.3.0/layui/css/layui.css">

    <%--JS--%>
    <script type="text/javascript" src="${webRoot}/plug-in/jquery-3.2.1/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/layui-v2.3.0/layui/layui.all.js"></script>
</head>
<body>
<br>
<div class="text-center row">
    <div class="col-sm-1"></div>
    <div class="text-left col-sm-10 panel panel-primary">
        <br>
        <form class="form-horizontal" role="form" action="">
            <%--Restful风格的请求--%>
            <input type="hidden" value="POST" name="_method" id="_method">

            <div class="form-group">
                <label for="username" class="col-sm-2 control-label">用户名</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" name="username" id="username" value="" placeholder="请填写用户名">
                </div>
                <div class="text-center" id="usernameMsg"></div>
            </div>
            <div class="form-group">
                <label for="password" class="col-sm-2 control-label">密码</label>
                <div class="col-sm-10">
                    <input type="password" class="form-control" name="password" id="password" value="" placeholder="请填写密码">
                </div>
                <div class="text-center" id="passwordMsg"></div>
            </div>

            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10 text-center">
                    <button type="button" class="layui-btn col-sm-4" id="submit">提交</button>
                    <div class="col-sm-1"></div>
                    <button type="reset" class="layui-btn layui-btn-normal col-sm-4" id="close">重置</button>
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

        //检查用户名是否可用
        $("#username").blur(function () {
            var username = $("#username").val();
            if (username == null || username == ""){
                $("#usernameMsg").html(
                    "<span style='color:#FF5722'>用户名不能为空！</span>"
                );
                $("#username").css("border", "1px solid red");  //输入框变红
                $("#username").focus();

                return false;
            }else {
                checkUsername(username);
            }

        })
    });

    function checkUsername(username) {
        //Restful风格的get请求
        var data = {
        };
        $.ajax({
            url: "${webRoot}/userCheck/"+username,
            type: "get",
            data: data,
            dataType: "json",
            success: function (data) {
                var jsonData = eval(data);
                var code = jsonData.code;
                var msg = jsonData.msg;
                if (code == 1){
                    $("#usernameMsg").html(
                        "<span style='color:#009688'>"+msg+"</span>"
                    );
                    $("#username").css("border", "1px solid #009688");
                }else {
                    $("#usernameMsg").html(
                        "<span style='color:#FF5722'>"+msg+"</span>"
                    );
                    $("#username").css("border", "1px solid red");  //输入框变红
                }
            }
        });
    }

    //提交
    $("#submit").click(function () {
        var username = $("#username").val();
        var password = $("#password").val();

        if (username == null || username == "") {
            $("#usernameMsg").html(
                "<span style='color:#FF5722'>用户名不能为空！</span>"
            );
            $("#username").css("border", "1px solid red");  //输入框变红
            $("#username").focus();
            return false;
        } else {
            $("#username").css("border", "1px solid #009688");
        }

        if (password == null || password == "") {
            $("#passwordMsg").html(
                "<span style='color:#FF5722'>密码不能为空！</span>"
            );
            $("#password").css("border", "1px solid red");  //输入框变红
            $("#password").focus();
            return false;
        } else {
            $("#password").css("border", "1px solid #009688");
        }

        //Restful风格的get请求
        var data = {
            _method : "POST",
            username:username ,
            password:password
        };

        $.ajax({
            url: "${webRoot}/userCheck",
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
        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
        parent.layer.close(index); //再执行关闭
    });
</script>
</html>
