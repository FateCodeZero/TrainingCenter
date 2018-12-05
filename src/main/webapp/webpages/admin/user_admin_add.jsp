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
    <script src="${webRoot}/plug-in/js/utils.js" type="text/javascript"></script>

</head>
<body>
<br>
<div class="row">
    <div class="col-sm-1"></div>
    <div class="text-left col-sm-10 panel panel-primary">
        <br>
        <div class="form-horizontal">
            <div class="form-group">
                <label for="username" class="col-sm-2 control-label">管理员账号</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" name="username" id="username" value="" placeholder="请填写管理员账号">
                    <div id="usernameMsg"></div>
                </div>
            </div>
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
        </div>
    </div>
    <div class="col-sm-1"></div>
</div>
</body>

<script type="text/javascript">
    $(document).ready(function () {
        //页面加载完成
        //……
    });
    /*验证用户名*/
    $("#username").blur(function () {
        var username = $("#username").val();
        var msg = '';
        if (username === null || username === '') {
            msg = '账号不能为空';
            $("#usernameMsg").html("<span style='color:#FF5722'>"+msg+"</span>");
            $("#username").css("border", "1px solid red");
        } else {
            $("#usernameMsg").html("");
            msg = '账号不是合法的手机号或者邮箱';

            if(!usernameCheck(username.trim())) {
                $("#usernameMsg").html("<span style='color:#FF5722'>"+msg+"</span>");
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

    /*验证密码*/
    $("#password").blur(function () {
        var password = $("#password").val();
        var msg = '';
        if (password === null || password === '') {
            msg = '密码不能为空';
            $("#passwordMsg").html("<span style='color:#FF5722'>"+msg+"</span>");
            $("#password").css("border", "1px solid red");
        } else {
            $("#passwordMsg").html("");
            msg = '密码需以字母开头，且长度是6~18位,只能包含字母、数字和下划线';

            if(!passwordCheck(password.trim())) {
                $("#passwordMsg").html("<span style='color:#FF5722'>"+msg+"</span>");
                $("#password").css("border", "1px solid red");
            }else {
                $("#passwordMsg").html("");
                $("#password").css("border", "1px solid #009688");
            }
        }
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

        var msg = null;
        if (roleIds === null || roleIds === "") {
            msg = '<span style="color: #FF5722;">请先选择要授给该管理员的角色</span>';
            layer.msg(msg, {
                icon: 2,
                time: 2000 //2秒关闭（如果不配置，默认是3秒）
            });
            $("#roleNamesMsg").html(msg);
            $("#roleNames").css("border", "1px solid red");  //输入错误，输入框变红
            return false;
        } else {
            $("#roleNamesMsg").html('');
            $("#roleNames").css("border", "1px solid #009688");
        }
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
            if(!usernameCheck(username.trim())) {
                msg = '<span style="color: #FF5722;">账号不是合法的手机号或者邮箱</span>';
                layer.msg(msg, {
                    icon: 2,
                    time: 2000 //2秒关闭（如果不配置，默认是3秒）
                });
                $("#usernameMsg").html(msg);
                $("#username").css("border", "1px solid red");
                return false;
            }else {
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
            if(!passwordCheck(password.trim())) {
                msg = '<span style="font-size: large">密码格式不安全</span>';
                layer.msg(msg, {
                    icon: 2,
                    time: 2000 //2秒关闭（如果不配置，默认是3秒）
                });
                var tip = '<span style="color: #FF5722">密码需以字母开头，且长度是6~18位,只能包含字母、数字和下划线</span>'
                $("#passwordMsg").html(tip);
                $("#password").css("border", "1px solid red");
                return false;
            }else {
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
</script>

</html>
