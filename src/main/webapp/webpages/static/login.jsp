<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/context/mytags.jsp" %>
<html>
<head>
    <title>登录</title>
    <%--CSS--%>
    <link rel="stylesheet" href="${webRoot}/plug-in/bootstrap3.3.5/css/bootstrap.min.css" media="all">
    <link rel="stylesheet" href="${webRoot}/plug-in/layui-v2.4.5/layui/css/layui.css">
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/login.css">

    <%--JS--%>
    <script type="text/javascript" src="${webRoot}/plug-in/jquery-3.2.1/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/jquery-cookie/jquery.cookie.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/layui-v2.4.5/layui/layui.all.js"></script>
    <script src="${webRoot}/plug-in/js/utils.js"></script>
</head>
<body style="background-image: url(${webRoot}/webpages/static/images/22.jpg); background-repeat: no-repeat;background-size: cover;">
<h1 class="col-md-12 my_title text-center">梦润传承</h1>
<div class="row">
    <div class="col-md-8 col-md-offset-2 login_body">
        <div class="col-md-6 login_div">
            <h3 class="col-md-12 text-center my_title2">登录</h3>

            <input type="text" name="username" id="username" class="col-md-10 col-md-offset-1  login_input" placeholder="请填写用户名" required="" />
            <div class="col-md-10 col-md-offset-1 text-left" id="usernameMsg"></div>

            <input type="password" name="password" id="password" class="col-md-10 col-md-offset-1  login_input" placeholder="请填写密码" required="" />
            <div class="col-md-10 col-md-offset-1 text-left" id="passwordMsg"></div>

            <input type="text" name="kaptcha" id="kaptcha" class="col-md-5 col-md-offset-1 login_input" placeholder="请填写验证码" required="" />
            <img id="kaptchaImg" src="${webRoot}/except/kaptcha" class="col-md-4 col-md-offset-1 captcha_css"/>
            <a id="refreshImg" class="col-md-4 col-md-offset-7 text-center refreshImg_css">点此刷新验证码</a>
            <div class="col-md-10 col-md-offset-1 text-left" id="kaptchaMsg"></div>

            <button  id="submit" type="button"  class="col-md-10 col-md-offset-1 login_submit" >登录</button>

        </div>
        <div class="col-md-6 img_div">
            <h5 class="col-md-12 text-center my_context1"> 赋能人才，从这里开始 </h5>
            <h5 class="col-md-12 text-center my_context2"> 最科学的培养方案,最新潮的前沿技术，最超乎想象的你</h5>
            <h5 class="col-md-12 text-center my_context2">卓越人生，从梦润起航，全新的学习方式</h5>
            <h3 class="col-md-12 text-center my_context3">梦润新世界  梦润新时代 </h3>

        </div>
    </div>
</div>

</body>
<script type="text/javascript">

    //ajax刷新验证码
    $("#refreshImg").click(function () {
        $("#kaptchaImg").attr("src","${webRoot}/except/kaptcha?flag="+Math.random());
    });

    /*输入控制*/
    $(document).ready(function(){

        $('#username').blur(function () {
            if ($('#username').val() =='')
            {
                $("#usernameMsg").html("<span style='color:#FF5722'>账号不能为空！</span>" );
                $("#username").focus(); //获取焦点
            }else {
                $("#usernameMsg").html("");
            }
        });
        $('#password').blur(function () {
            if ($('#password').val() == '') {
                $("#passwordMsg").html("<span style='color:#FF5722'>密码不能为空！</span>");
                $("#password").focus();
            }else {
                $("#passwordMsg").html("");
            }
        });
        $('#kaptcha').blur(function () {
            if ($('#kaptcha').val() == '') {
                $("#kaptchaMsg").html("<span style='color:#FF5722'>验证码不能为空！</span>");
                $("#kaptcha").focus();
            }else {
                $("#kaptchaMsg").html("");
            }
        });
    });


    //提交登录
    $("#submit").click(function () {
        var username = $("#username").val();
        var password = $("#password").val();
        var kaptcha = $("#kaptcha").val();

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
                var responseData = null;
                var username = null;

                if (code === 1) {
                    layer.alert(msg, {
                        time: 3000,
                        icon: 1
                    });
                    responseData = jsonData.data;    //获取返回的数据集
                    if (responseData !== null && responseData !== "") {
                        url = responseData.url;
                        username = responseData.username;
                        $.cookie('username',username , { expires: 7, path: '/' });//有效时间为7天
                    }
                    if (url !== null) {
                        //登录成功后跳转
                        window.location = url;
                    }else {
                        window.location = "/index.jsp";
                    }
                } else {
                    layer.alert(msg, {
                        time: 3000,
                        icon: 2
                    });
                    $("#username").css("border", "1px solid #cccccc");
                    $("#password").css("border", "1px solid #cccccc");
                    $("#kaptcha").css("border", "1px solid #cccccc");

                    //显示错误信息
                    $("#kaptchaMsg").html('<span style="color: #b92c28">' + msg + '</span>');
                    //刷新验证码
                    $("#kaptchaImg").attr("src","${webRoot}/except/kaptcha?flag="+Math.random());
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

