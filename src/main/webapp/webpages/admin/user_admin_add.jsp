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
    <title>添加管理员</title>

    <link rel="stylesheet" href="${webRoot}/plug-in/layui-v2.4.5/layui/css/layui.css">
    <link rel="stylesheet" href="${webRoot}/plug-in/bootstrap3.3.5/css/bootstrap.min.css">

    <script src="${webRoot}/plug-in/jquery-3.2.1/jquery-3.2.1.min.js"></script>
    <script src="${webRoot}/plug-in/layui-v2.4.5/layui/layui.all.js"></script>
    <script src="${webRoot}/plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
</head>
<body>
<br>
<div class="row">
    <div class="col-sm-1"></div>
    <div class="text-left col-sm-10 panel panel-primary">
        <br>
        <form class="form-horizontal" role="form" action="">
            <div class="form-group">
                <label for="roleIds" class="col-sm-2 control-label">管理员角色</label>
                <div class="col-sm-8">
                    <input type="hidden" name="roleIds" id="roleIds"/>
                    <input class="form-control" name="roleNames" id="roleNames" disabled="disabled"/>
                    <div id="roleNamesMsg"></div>
                </div>
                <div class="col-sm-2">
                    <button id="selectRole_btn" class="layui-btn layui-btn-sm">选择管理员角色</button>
                </div>
            </div>
            <div class="form-group">
                <label for="username" class="col-sm-2 control-label">管理员账号</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" name="username" id="username" value="" placeholder="请填写管理员账号">
                    <div id="usernameMsg"></div>
                </div>
            </div>
            <div class="form-group">
                <label for="password" class="col-sm-2 control-label">管理员密码</label>
                <div class="col-sm-10">
                    <input type="password" class="form-control" name="password" id="password" value="" placeholder="请填写管理员密码">
                    <div id="passwordMsg"></div>
                </div>
            </div>
            <div class="form-group">
                <label for="rePassword" class="col-sm-2 control-label">重复密码</label>
                <div class="col-sm-10">
                    <input type="password" class="form-control" name="rePassword" id="rePassword" value="" placeholder="请重复管理员密码">
                    <div id="rePasswordMsg"></div>
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
        /*验证用户名*/
        $("#username").blur(function () {
            var username = $("#username").val();
            if (username === null || username === '') {
                $("#usernameMsg").html("<span style='color:#FF5722'>账号不能为空！</span>");
                $("#username").css("border", "1px solid red");
            } else {
                $("#usernameMsg").html("");
                if(!checkPhone($("#username").val().trim()) && !checkEmail($("#username").val().trim()))
                {
                    $("#usernameMsg").html("<span style='color:#FF5722'>账号必须为手机号或者邮箱！</span>");
                    $("#username").css("border", "1px solid red");
                }else {
                    $("#usernameMsg").html("");

                    var data = {
                        username:username
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
                                $("#usernameMsg").html('<span style="color:#009688">'+msg+'</span>');
                                $("#username").css("border", "1px solid #009688");
                            }else {
                                $("#usernameMsg").html('<span style="color:#FF5722">'+msg+'</span>');
                                $("#username").css("border", "1px solid red");
                            }
                        }
                    });
                }
            }
        });
    });

    /*选择角色*/
    $("#selectRole_btn").click(function () {
        parent.layer.open({		//从本页的父页面打开
            title: '选择父级菜单',
            type: 2,
            area: ['800px', '400px'],
            fix: false, //不固定
            maxmin: true,
            content: '${webRoot}/webpages/admin/role_select.jsp'
        });
    });

    //提交
    $("#submit").click(function () {
        var roleIds = $("#roleIds").val();
        var username = $("#username").val();
        var password = $("#password").val();
        var rePassword = $("#rePassword").val();

        if (roleIds === null || roleIds === "") {
            layer.msg("请先选择要授给该管理员的角色！", {
                icon: 2,
                time: 2000 //2秒关闭（如果不配置，默认是3秒）
            });
            $("#roleNames").css("border", "1px solid red");  //输入错误，输入框变红
            return false;
        } else {
            $("#roleNames").css("border", "1px solid #009688");
        }
        if (username === null || username === "") {
            layer.msg("请添加管理员账号！", {
                icon: 2,
                time: 2000 //2秒关闭（如果不配置，默认是3秒）
            });
            $("#username").css("border", "1px solid red");
            return false;
        } else {
            $("#username").css("border", "1px solid #009688");
        }
        if (password === null || password === "") {
            layer.msg("请填写管理员密码！", {
                icon: 2,
                time: 2000 //2秒关闭（如果不配置，默认是3秒）
            });
            $("#password").css("border", "1px solid red");
            return false;
        } else {
            $("#password").css("border", "1px solid #009688");
        }

        if (password !== rePassword) {
            layer.msg("两次密码输入不一致！", {
                icon: 2,
                time: 2000 //2秒关闭（如果不配置，默认是3秒）
            });
            $("#password").css("border", "1px solid red");
            $("#rePassword").css("border", "1px solid red");
            return false;
        } else {
            $("#password").css("border", "1px solid #009688");
            $("#rePassword").css("border", "1px solid #009688");
        }

        var data = {
            roleIds: roleIds,
            username: username,
            password: password,
            rePassword: rePassword
        };
        console.log(data);
        $.ajax({
            url: "${webRoot}/user/adminAdd",
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
                    $("#roleNames").css("border", "1px solid #cccccc");
                    $("#username").css("border", "1px solid #cccccc");
                    $("#password").css("border", "1px solid #cccccc");
                    $("#rePassword").css("border", "1px solid #cccccc");
                } else {
                    layer.alert(msg, {
                        time: 3000,
                        icon: 2
                    });
                    $("#roleNames").css("border", "1px solid #cccccc");
                    $("#username").css("border", "1px solid #cccccc");
                    $("#password").css("border", "1px solid #cccccc");
                    $("#rePassword").css("border", "1px solid #cccccc");
                }
            }
        });
    });

    //设置资源的值，此方法由该弹出窗口的父窗口调用
    function setRoleData(jsonData) {
        $("#roleIds").val(jsonData.id);
        $("#roleNames").val(jsonData.name);
    }

    $("#close").click(function () {
        closeView();
    });

    function closeView() {
        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
        parent.layer.close(index); //再执行关闭
    }

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

</script>

</html>
