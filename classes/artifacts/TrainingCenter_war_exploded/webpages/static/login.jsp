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
                            <img id="kaptchaImg" src="${webRoot}/except/kaptcha" height="40"/>
                            <div><a href="" id="refreshImg">看不清楚？换一张…</a></div>
                        </div>
                    </div>
                </div>
                <div class="text-center" id="kaptchaMsg"></div>
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

<script type="text/javascript" src="${webRoot}/webpages/static/js/PageJumpHandle.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        //页面加载完成
        //……
    });

    //ajax刷新验证码
    $("#refreshImg").click(function () {
        $("#kaptchaImg").attr("src","${webRoot}/except/kaptcha?flag="+Math.random());
        <%--alert("进入");--%>
        <%--$.ajax({--%>
            <%--type: "get",--%>
            <%--url: "${webRoot}/except/kaptcha",--%>
            <%--dataType: "text",--%>
            <%--success: function (img, status) {--%>
                <%--alert(img);--%>
                <%--$("#kaptchaImg").attr("src", "data:image/png;base64," + img);--%>
            <%--},--%>
            <%--error: function (data) {--%>
                <%--alert('响应失败！');--%>
            <%--}--%>
        <%--});--%>
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
//        from表单请求
            <%--var form = $("#loginFrom");--%>
            <%--form.attr('action',"${webRoot}/user/login");--%>
            <%--form.attr('method',"POST");--%>
            <%--form.submit();--%>

            //Restful风格的Ajax Post请求
            var data = {
                _method: "POST",
                username: username,
                password: password,
                kaptcha: kaptcha
            };
            $.ajax({
                url: "${webRoot}/user/login",
                type: "post",
                data: data,
                dataType: "json",
                success: function (data) {
                    var jsonData = eval(data);   //数据解析
                    var code = jsonData.code;   //状态码
                    var msg = jsonData.msg;     //提示信息
                    var url = null;

                    var responseData = jsonData.data;    //获取返回的数据集
                    if (responseData != null && responseData != "") {
                        url = responseData.url;
                    }

                    if (code == 1) {
                        layer.alert(msg, {
                            time: 3000,
                            icon: 1
                        });

                        if (url != null) {
                            //登录成功后跳转
                            window.location = url;
                        }
                    } else if (code == 0) {
                        layer.alert(msg, {
                            time: 3000,
                            icon: 2
                        });
                        $("#username").css("border", "1px solid #ccc");
                        $("#password").css("border", "1px solid #ccc");
                        $("#kaptcha").css("border", "1px solid #ccc");

                        //显示错误信息
                        $("#kaptchaMsg").html('<span style="color: #b92c28">' + msg + '</span>');
                    } else {
                        $("#username").css("border", "1px solid #ccc");
                        $("#password").css("border", "1px solid #ccc");
                        $("#kaptcha").css("border", "1px solid #ccc");

                        //错误错误状态码统一跳转
                        errorPageJump("${webRoot}", code);
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
