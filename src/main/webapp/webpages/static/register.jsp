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

    <div class="row">
        <div class="col-md-4 col-md-offset-4 register_body">
            <div class="col-md-12 register_title">
                <h2 class="col-md-12 text-center ">注册</h2>
                <label class="col-md-2 col-md-offset-5 bar-w3-agile"></label>
            </div>
            <input type="text" name="username" id="username" class="col-md-10 col-md-offset-1  register_input" placeholder="请填写用户名" required="" />
            <div class="col-md-10 col-md-offset-1 text-left" id="usernameMsg"></div>
            <input type="password" name="password" id="password" class="col-md-10 col-md-offset-1  register_input" placeholder="请填写密码" required="" />
            <div class="col-md-10 col-md-offset-1 text-left" id="passwordMsg"></div>
            <input type="password" name="password" id="rePassword" class="col-md-10 col-md-offset-1  register_input" value="" placeholder="重复密码">
            <div class="col-md-10 col-md-offset-1 text-left" id="rePasswordMsg"></div>
            <div class="clear"></div>
            <button type="button"  id="submit" class="col-md-10 col-md-offset-1  btn_submit" onclick="javascript:;">注册</button>
        </div>
    </div>
</body>
<script type="text/javascript">
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

    $(document).ready( function(){
        /*验证用户名*/
        $("#username").blur(function () {
            if ($("#username").val() == '') {
                $("#usernameMsg").html("<span style='color:#FF5722'>账号不能为空！</span>");
                $("#username").focus(); //获取焦点
            } else {
                $("#usernameMsg").html("");
                if(!checkPhone($("#username").val().trim()) && !checkEmail($("#username").val().trim()))
                {
                    $("#usernameMsg").html("<span style='color:#FF5722'>账号必须为手机号或者邮箱！</span>");
                    $("#username").focus(); //获取焦点
                }else {
                    $("#usernameMsg").html("");
                }

            }
        })

        /*验证密码不能为空*/
        $("#password").blur(function () {
            if ($("#password").val() == "") {
                $("#passwordMsg").html("<span style='color:#FF5722'>密码不能为空！</span>");
                $("#password").focus(); //获取焦点
            } else {
                $("#passwordMsg").html("");
            }
        })
        /*验证重复密码不能为空*/
        $("#rePassword").blur(function () {
            if ($("#rePassword").val() == "") {
                $("#rePasswordMsg").html("<span style='color:#FF5722'>密码不能为空！</span>");
                $("#rePassword").focus(); //获取焦点
            } else {
                $("#rePasswordMsg").html("");
            }
        })

        /*密码一致性验证*/
        $("#rePassword").blur(function () {
            if ($("#rePassword").val() !== $("#password").val() ) {
                $("#rePasswordMsg").html("<span style='color:#FF5722'>两次密码输入不一致！</span>");
                $("#rePassword").focus(); //获取焦点
            } else {
                $("#rePasswordMsg").html("");
            }
        })
    });

    //提交
    $("#submit").click(function () {
        var username = $("#username").val();
        var password = $("#password").val();
        var rePassword = $("#rePassword").val();

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
                    window.location="${webRoot}/user/goLogin";
                }else if (code == 0) {
                    layer.alert(msg, {
                        time: 3000,
                        icon: 2
                    });
                    $("#username").css("border", "1px solid #cccccc");
                    $("#password").css("border", "1px solid #cccccc");
                    $("#rePassword").css("border", "1px solid #cccccc");
                }
                else {
                    $("#username").css("border", "1px solid #cccccc");
                    $("#password").css("border", "1px solid #cccccc");
                    $("#rePassword").css("border", "1px solid #cccccc");

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
