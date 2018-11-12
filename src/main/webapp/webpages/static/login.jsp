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
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/login.css">


    <%--JS--%>
    <script type="text/javascript" src="${webRoot}/plug-in/jquery-3.2.1/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/layui-v2.3.0/layui/layui.all.js"></script>
<%--    <script type="text/javascript" src="${webRoot}/webpages/static/js/login.js"></script>
    <script type="text/javascript" src="${webRoot}/webpages/static/js/PageJumpHandle.js"></script>--%>
</head>
<body >
<<a href="http://localhost:8080/index.jsp" ></a>
<h1>梦润传承</h1>
<div class="w3layouts">
    <!-- Sign in -->
    <div class="signin-agile">
        <h2>登陆</h2>
        <label class="bar-w3-agile"></label>
        <form  role="form" action="${webRoot}/user/login" id="loginFrom" method="post">
            <input type="text" name="username" id="username" class="name" placeholder="请填写用户名" required="" />
                <div class="text-center" id="usernameMsg"></div>
            <input type="password" name="password" id="password" class="password" placeholder="请填写密码" required="" />
                <div class="text-center" id="passwordMsg"></div>
            <input type="text" name="kaptcha" id="kaptcha" class="kaptcha"  placeholder="请填写验证码"/>
                <div class="text-center" id="kaptchaMsg"></div>
            <div class="col-lg-4">
                <img id="kaptchaImg" src="${webRoot}/except/kaptcha" height="40"/>
            </div>
            <div>
                <a href="" id="refreshImg">看不清楚？换一张…</a>
            </div>
            <div class="clear"></div>
            <input type="submit" id="submit" value="登陆">
        </form>
    </div>

    <%--右样式--%>
    <div class="signup-agileinfo">
        <p>奋斗不息，追梦不止。为了不辜负党和政府、社会各界的重托，为了带领更多的乡亲实现自己的小康梦想。</p>
        <h6>人世间的美好梦想,只有通过诚实劳动才能实现.</h6>
    </div>
    <div class="clear"></div>
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
                    }else {
                        window.location = "/index.jsp";
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
