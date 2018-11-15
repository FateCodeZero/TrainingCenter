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
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/register.css">

    <%--JS--%>
    <script type="text/javascript" src="${webRoot}/plug-in/jquery-3.2.1/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/layui-v2.3.0/layui/layui.all.js"></script>
</head>
<body >
<a href="http://localhost:8080/index.jsp" ></a>
<h1>梦润传承</h1>
<div class="w3layouts" >
    <!-- Sign in -->
    <div class="signin-agile">
        <h2>注册</h2>
        <label class="bar-w3-agile"></label>
        <form  role="form" action="${webRoot}/user/login" id="loginFrom" method="post">
            <input type="text" name="username" id="username" class="name" placeholder="请填写用户名" required="" />
                <div class="text-center" id="usernameMsg"></div>
            <input type="password" name="password" id="password" class="password" placeholder="请填写密码" required="" />
                <div class="text-center" id="passwordMsg"></div>
            <input type="password" class="password" name="password" id="rePassword" value="" placeholder="重复密码">
                <div class="text-center" id="rePasswordMsg"></div>
            <div class="clear"></div>
            <input type="button" value="注册" id="submit" class="btn btn-primary" onclick="javascript:check();"/>
        </form>
    </div>
</div>
</body>

<script type="text/javascript">
    $(document).ready(function () {
        //页面加载完成
        //……

        $("#username").blur(function () {
            var username = $("#username").val();
            checkUsername(username); //检查用户名是否可用
        })
    });

    /**
     邮箱： 第一部分@第二部分
     第一部分 ： 由字母、数字、下划线、短线 - 、点号 . 组成
     第二部分： 域名，域名由字母、数字、短线 - 域名后缀组成
     * */
    //验证邮箱
    function checkEmail(str) {
        var emailReg = /^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/;
        if (emailReg.test(str)){
            return true;
        }else {
            return false;
        }
    }

    /**
     ^ 1 以数字1 开头
     [3-578] 手机号第二位允许是 3 、4 、5、6、7、8 中的任意一位
     \d{9} 任意9位数字组合
     $ 只能以数字作为结尾
     **/
    //验证手机号
    function checkPhone(str) {
        var phoneReg = /^1[345678]\d{9}$/;
        if (phoneReg.test(str)){
            return true;
        }else {
            return false;
        }
    }

    //后台验证用户名
    function checkUsername(username) {

        if (username == null || username == "") {
            $("#usernameMsg").html(
                "<span style='color:#FF5722'>用户名不能为空！</span>"
            );
            $("#username").css("border", "1px solid red");  //输入框变红
            $("#username").focus();
            return false;
        } else if ( !checkEmail(username) && !checkPhone(username)){
            $("#usernameMsg").html(
                "<span style='color:#FF5722'>用户名必须是合法的手机号或邮箱！</span>"
            );
            $("#username").css("border", "1px solid red");  //输入框变红
            $("#username").focus();

            return false;
        }else {
            //Restful风格的get请求
            var data = {
                username:username
            };
            $.ajax({
                url: "${webRoot}/user/usernameCheck",
                type: "get",
                data: data,
                dataType: "json",
                success: function (data) {
                    var jsonData = eval(data);
                    var code = jsonData.code;
                    var msg = jsonData.msg;
                    if (code == 1) {
                        $("#usernameMsg").html(
                            "<span style='color:#009688'>" + msg + "</span>"
                        );
                        $("#username").css("border", "1px solid #009688");
                    } else {
                        $("#usernameMsg").html(
                            "<span style='color:#FF5722'>" + msg + "</span>"
                        );
                        $("#username").css("border", "1px solid red");  //输入框变红
                    }
                }
            });
        }
    }


    //提交
    $("#submit").click(function () {
        var username = $("#username").val();
        var password = $("#password").val();
        var rePassword = $("#rePassword").val();

        checkUsername(username); //检查用户名是否可用
        //验证密码合法性
        if (password === null || password === '' || rePassword === null || rePassword === '') {
            $("#passwordMsg").html(
                "<span style='color:#FF5722'>密码不能为空！</span>"
            );
            $("#password").css("border", "1px solid red");  //输入框变红
            $("#rePassword").css("border", "1px solid red");  //输入框变红
            $("#password").focus();
            return false;
        } else {
            $("#password").css("border", "1px solid #009688");
            $("#rePassword").css("border", "1px solid #009688");
            $("#password").blur();      //失去焦点
        }

        //密码一致性验证
        if(rePassword !== password){
            $("#passwordMsg").html(
                "<span style='color:#FF5722'>两次密码输入不一致！</span>"
            );
            $("#password").css("border", "1px solid red");  //输入框变红
            $("#rePassword").css("border", "1px solid red");  //输入框变红
            return false;
        }else {
            $("#password").css("border", "1px solid #009688");
            $("#rePassword").css("border", "1px solid #009688");
        }

        //Restful风格的get请求
        var data = {
            _method: "POST",
            username: username,
            password: password,
            rePassword: rePassword
        };

        $.ajax({
            url: "${webRoot}/user/register",
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
