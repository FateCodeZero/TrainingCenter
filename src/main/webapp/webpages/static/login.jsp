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
    <title>登录</title>
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
<div class="text-center row" style="margin-top: 10%">
    <div class="col-sm-1"></div>
    <div class="text-left col-sm-10 panel panel-primary">
        <br>
        <form class="form-horizontal" role="form" action="${webRoot}/user/login" id="loginFrom" method="post">
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
                    <input type="password" class="form-control" name="password" id="password" value=""
                           placeholder="请填写密码">
                </div>
                <div class="text-center" id="passwordMsg"></div>
            </div>

            <div class="form-group">
                <label for="kaptcha" class="col-sm-2 control-label">验证码</label>
                <div class="col-sm-10">
                    <div class="row">
                        <div class="col-sm-8">
                            <input type="text" class="col-sm-6 form-control" id="kaptcha" name="kaptcha"
                                   placeholder="请填写验证码"/>
                        </div>
                        <div class="col-lg-4">
                            <button id="flush-kaptcha"><img src="${webRoot}/except/kaptcha" height="40"/></button>
                        </div>
                    </div>
                </div>
                <div class="text-center" id="kaptchaMsg" ><span style="color: #b92c28">${SPRING_SECURITY_LAST_EXCEPTION.message}</span></div>
            </div>

            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10 text-center">
                    <button type="submit" class="layui-btn col-sm-4" id="submit">提交</button>
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
    });

    //刷新验证码
    $("#flush-kaptcha").click(function () {
        $("#flush-kaptcha").html('<img src="${webRoot}/except/kaptcha" height="40"/>');
        $("#flush-kaptcha").blur(); //去除图片边框
    });

    //提交登录
    $("#submit").click(function () {
        var username = $("#username").val();
        var password = $("#password").val();
        var kaptcha = $("#kaptcha").val();

        if (username === null || username === '') {
            $("#usernameMsg").html(
                "<span style='color:#FF5722'>请先填写账号！</span>"
            );
            $("#username").css("border", "1px solid red");  //输入框变红
            $("#username").focus();     //获取焦点
            return false;
        } else {
            $("#username").css("border", "1px solid #009688");
            $("#usernameMsg").html('');
            $("#username").blur();      //失去焦点
        }

        if (password === null || password === '') {
            $("#passwordMsg").html(
                "<span style='color:#FF5722'>请先填写密码！</span>"
            );
            $("#password").css("border", "1px solid red");  //输入框变红
            $("#password").focus();
            return false;
        } else {
            $("#password").css("border", "1px solid #009688");
            $("#passwordMsg").html('');
            $("#password").blur();      //失去焦点
        }

        if (kaptcha === null || kaptcha === '') {
            $("#kaptchaMsg").html(
                "<span style='color:#FF5722'>请先填写验证码！</span>"
            );
            $("#kaptcha").css("border", "1px solid red");  //输入框变红
            $("#kaptcha").focus();
            return false;
        } else {
            $("#kaptcha").css("border", "1px solid #009688");
            $("#kaptchaMsg").html('');
            $("#kaptcha").blur();      //失去焦点
        }
        var form = $("#loginFrom");
        form.attr('action',"${webRoot}/user/login");
        form.attr('method',"POST");
        form.submit();

//        //Restful风格的get请求
//        var data = {
//            _method: "POST",
//            username: username,
//            password: password,
//            kaptcha: kaptcha
//        };
        <%--$.ajax({--%>
            <%--url: "${webRoot}/user/login",--%>
            <%--type: "post",--%>
            <%--data: data,--%>
            <%--dataType: "json",--%>
            <%--success: function (data) {--%>
                    <%--alert("返回");--%>
                    <%--$("#kaptchaMsg").html('<span>${SPRING_SECURITY_LAST_EXCEPTION.message}</span>');--%>
                <%--var jsonData = eval(data);   //数据解析--%>
                <%--var code = jsonData.code;--%>
                <%--var msg = jsonData.msg;--%>

                <%--if (code == 1) {--%>
                    <%--layer.alert(msg, {--%>
                        <%--time: 3000,--%>
                        <%--icon: 1--%>
                    <%--});--%>
                <%--} else {--%>
                    <%--layer.alert(msg, {--%>
                        <%--time: 3000,--%>
                        <%--icon: 2--%>
                    <%--});--%>
                <%--}--%>
            <%--}--%>
        <%--});--%>
    });

    $("#close").click(function () {
        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
        parent.layer.close(index); //再执行关闭
    });
</script>
</html>
