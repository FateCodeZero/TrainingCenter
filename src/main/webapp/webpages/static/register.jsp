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
    <link rel="stylesheet" href="${webRoot}/plug-in/layui-v2.4.5/layui/css/layui.css">
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/register.css">

    <%--JS--%>
    <script type="text/javascript" src="${webRoot}/plug-in/jquery-3.2.1/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/jquery-cookie/jquery.cookie.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/layui-v2.4.5/layui/layui.all.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/js/utils.js"></script>

</head>
<body>
<a href="http://localhost:8080/index.jsp"></a>
<h1>梦润传承</h1>

<div class="row">
    <div class="col-md-4 col-md-offset-4 register_body">
        <div class="col-md-12 register_title">
            <h2 class="col-md-12 text-center ">注册</h2>
            <label class="col-md-2 col-md-offset-5 bar-w3-agile"></label>
        </div>
        <input type="text" name="username" id="username" class="col-md-10 col-md-offset-1  register_input"
               placeholder="请填写用户名" required=""/>
        <div class="col-md-10 col-md-offset-1 text-left" id="usernameMsg"></div>
        <input type="password" name="password" id="password" class="col-md-10 col-md-offset-1  register_input"
               placeholder="请填写密码" required=""/>
        <div class="col-md-10 col-md-offset-1 text-left" id="passwordMsg"></div>
        <input type="password" name="password" id="rePassword" class="col-md-10 col-md-offset-1  register_input"
               value="" placeholder="重复密码">
        <div class="col-md-10 col-md-offset-1 text-left" id="rePasswordMsg"></div>
        <div class="clear"></div>
        <button type="button" id="submit" class="col-md-10 col-md-offset-1  btn_submit" onclick="javascript:;">注册
        </button>
    </div>
</div>
</body>
<script type="text/javascript">

    $(document).ready(function () {

    });

    /*验证用户名*/
    $("#username").blur(function () {
        var username = $("#username").val();
        var msg = '';
        if (username === null || username === '') {
            msg = '账号不能为空';
            $("#usernameMsg").html("<span style='color:#FF5722'>" + msg + "</span>");
            $("#username").css("border", "1px solid red");
        } else {
            $("#usernameMsg").html("");
            msg = '账号不是合法的手机号或者邮箱';

            if (!usernameCheck(username.trim())) {
                $("#usernameMsg").html("<span style='color:#FF5722'>" + msg + "</span>");
                $("#username").css("border", "1px solid red");
            } else {
                $("#usernameMsg").html("");

                var data = {
                    username: username
                };
                $.ajax({
                    url: "${webRoot}/user/usernameCheck",
                    type: "get",
                    data: data,
                    dataType: "json",
                    success: function (data) {
                        var jsonData = eval(data);   //数据解析
                        var code = jsonData.code;
                        var msg = jsonData.msg;

                        if (code === 1) {
                            $("#usernameMsg").html('<span style="color:#009688">' + msg + '</span>');
                            $("#username").css("border", "1px solid #009688");
                        } else {
                            $("#usernameMsg").html('<span style="color:#FF5722">' + msg + '</span>');
                            $("#username").css("border", "1px solid red");
                        }
                    }
                    , error: function (jqXHR, textStatus, errorThrown) {
                        ajaxErrorHandler(jqXHR); //ajax请求异常统一处理
                    }
                });
            }
        }
    });

    /*验证密码*/
    $("#password").blur(function () {
        var password = $("#password").val();
        var msg = '';
        if (password === null || password === '') {
            msg = '密码不能为空';
            $("#passwordMsg").html("<span style='color:#FF5722'>" + msg + "</span>");
            $("#password").css("border", "1px solid red");
        } else {
            $("#passwordMsg").html("");
            msg = '密码需以字母开头，且长度是6~18位,只能包含字母、数字和下划线';

            if (!passwordCheck(password.trim())) {
                $("#passwordMsg").html("<span style='color:#FF5722'>" + msg + "</span>");
                $("#password").css("border", "1px solid red");
            } else {
                $("#passwordMsg").html("");
                $("#password").css("border", "1px solid #009688");
            }
        }
    });

    //提交
    $("#submit").click(function () {
        var username = $("#username").val();
        var password = $("#password").val();
        var rePassword = $("#rePassword").val();

        var msg = null;
        if (username === null || username === "") {
            msg = '<span style="color: #FF5722;">请先填写管理员账号</span>';
            layer.msg(msg, {
                icon: 2,
                time: 2000 //2秒关闭（如果不配置，默认是3秒）
            });
            $("#usernameMsg").html(msg);
            $("#username").css("border", "1px solid red");
            return false;
        } else {
            $("#usernameMsg").html('');
            if (!usernameCheck(username.trim())) {
                msg = '<span style="color: #FF5722;">账号不是合法的手机号或者邮箱</span>';
                layer.msg(msg, {
                    icon: 2,
                    time: 2000 //2秒关闭（如果不配置，默认是3秒）
                });
                $("#usernameMsg").html(msg);
                $("#username").css("border", "1px solid red");
                return false;
            } else {
                $("#usernameMsg").html('');
                $("#username").css("border", "1px solid #009688");
            }
        }
        if (password === null || password === "") {
            msg = '<span style="color: #FF5722;">密码不能为空</span>';
            layer.msg(msg, {
                icon: 2,
                time: 2000 //2秒关闭（如果不配置，默认是3秒）
            });
            $("#passwordMsg").html(msg);
            $("#password").css("border", "1px solid red");
            return false;
        } else {
            $("#passwordMsg").html('');
            if (!passwordCheck(password.trim())) {
                msg = '<span style="font-size: large">密码格式不安全</span>';
                layer.msg(msg, {
                    icon: 2,
                    time: 2000 //2秒关闭（如果不配置，默认是3秒）
                });
                var tip = '<span style="color: #FF5722">密码需以字母开头，且长度是6~18位,只能包含字母、数字和下划线</span>'
                $("#passwordMsg").html(tip);
                $("#password").css("border", "1px solid red");
                return false;
            } else {
                $("#passwordMsg").html('');
                $("#password").css("border", "1px solid #009688");
            }
        }

        if (password !== rePassword) {
            msg = '<span style="color: #FF5722;">两次密码输入不一致</span>';
            layer.msg(msg, {
                icon: 2,
                time: 2000 //2秒关闭（如果不配置，默认是3秒）
            });
            $("#password").css("border", "1px solid red");
            $("#rePassword").css("border", "1px solid red");
            $("#rePasswordMsg").html(msg);
            return false;
        } else {
            $("#password").css("border", "1px solid #009688");
            $("#rePassword").css("border", "1px solid #009688");
            $("#rePasswordMsg").html('');
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

                if (code === 1) {
                    layer.alert(msg, {
                        time: 3000,
                        icon: 1
                    });
                    window.location = "${webRoot}/user/goLogin";
                } else if (code === 0) {
                    layer.alert(msg, {
                        time: 3000,
                        icon: 2
                    });
                    $("#username").css("border", "1px solid #cccccc");
                    $("#password").css("border", "1px solid #cccccc");
                    $("#rePassword").css("border", "1px solid #cccccc");
                } else {
                    $("#username").css("border", "1px solid #cccccc");
                    $("#password").css("border", "1px solid #cccccc");
                    $("#rePassword").css("border", "1px solid #cccccc");
                }
            }
            , error: function (jqXHR, textStatus, errorThrown) {
                ajaxErrorHandler(jqXHR); //ajax请求异常统一处理
            }
        });
    });

    $("#close").click(function () {
        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
        parent.layer.close(index); //再执行关闭
    });
</script>
</html>
