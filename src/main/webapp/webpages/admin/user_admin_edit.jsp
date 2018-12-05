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
    <script src="${webRoot}/plug-in/js/utils.js"></script>

</head>
<body>
<br>
<div class="row">
    <div class="col-sm-1"></div>
    <div class="text-left col-sm-10 panel panel-primary">
        <br>
        <div class="form-horizontal">
            <input type="hidden" id="id">
            <div class="form-group">
                <label for="username" class="col-sm-2 control-label">管理员账号</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" name="username" id="username" value="" disabled="disabled">
                    <div id="usernameMsg"></div>
                </div>
            </div>
            <div class="form-group">
                <label for="password" class="col-sm-2 control-label">重置密码</label>
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
    var userId = null;
    var user = null;
    var roles = null;
    $(document).ready(function () {
        //页面加载完成
        //……

        /*从URL获取对象ID*/
        userId = getUrlParam('id');
        /*通过ID获取对象信息*/
        user = getUserById(userId);
        roles = getRolesByUserId(userId);

        /*初始化编辑数据*/
        editDataInitialization(user,roles);
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

    //提交
    $("#submit").click(function () {
        var id = $("#id").val();
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
            id:id,
            roleIds: roleIds,
            username: username,
            password: password,
            rePassword: rePassword
        };
        $.ajax({
            url: "${webRoot}/user/update",
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

    $("#close").click(function () {
        closeView();
    });

    function closeView() {
        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
        parent.layer.close(index); //再执行关闭
    }

    /**
     * 获取指定用户所含有的所有角色
     * */
    function getRolesByUserId(userId) {
        var roles = null;
        var data = {
            userId:userId
        };
        $.ajax({
            url: "${webRoot}/role/getRolesByUserId",
            type: "post",
            async: false,    //关闭异步请求
            data: data,
            dataType: "json",
            success: function (data) {
                var jsonData = eval(data);
                var code = jsonData.code;
                var msg = jsonData.msg;
                if (code === 1) {
                    roles = jsonData.data.items;
                } else {
                    layer.alert(msg, {
                        time: 3000,
                        icon: 2
                    });
                }
            }
        });
        return roles;
    }

    /**
     * 通过 id 获取用户
     * @param id
     */
    function getUserById(id) {
        if (id === null || id === '') {
            layer.alert('id不能为空！', {
                time: 3000,
                icon: 2
            });
            return null;
        }
        var user = null;
        var data = {id: id};
        $.ajax({
            url: "${webRoot}/user/getUserById",
            type: "get",
            async: false,    //关闭异步请求
            data: data,
            dataType: "json",
            success: function (data) {
                var jsonData = eval(data); //数据解析
                var code = jsonData.code;
                var msg = jsonData.msg;
                if (code === 1) {
                    user = jsonData.data.user;
                } else {
                    layer.alert(msg, {
                        time: 3000,
                        icon: 2
                    });
                    return null;
                }
            }
        });
        return user;
    }

    /**
     * 编辑数据初始化
     * @param user：要编辑的管理员对象
     * @param roles：管理员所含有的角色
     */
    function editDataInitialization(user,roles) {
        if (user === null || user === '') {
            layer.alert('数据初始化失败，初始化数据为空', {
                time: 3000,
                icon: 2
            });
            return null;
        }
        $("#id").val(user.id);
        $("#username").val(user.username);
        var roleIds = '';
        var roleNames = '';
        if (roles !== null){
            $.each(roles,function (index, role) {
               if (index === 0){
                   roleIds += role.id;
                   roleNames += role.name;
               }else {
                   roleIds += ',';
                   roleIds += role.id;
                   roleNames += ',';
                   roleNames += role.name;
               }
            });
        }
        $("#roleIds").val(roleIds);
        $("#roleNames").val(roleNames);
    }

    /**
     * 账号合法性验证
     * */
    function usernameCheck(username) {
        if (!(checkEmail(username) || checkPhone(username))){
            return false;
        }
        return true;
    }

    /**
     * 密码合法性验证
     * 以字母开头，长度在6-18之间，只能包含字符、数字和下划线。
     * */
    function passwordCheck(password) {
        var usernameReg = /^[a-zA-Z]\w{5,17}$/;
        if (usernameReg.test(password)){
            return true;
        }else {
            return false;
        }
    }

    /**
     邮箱验证： 第一部分@第二部分
     第一部分 ： 由字母、数字、下划线、短线 - 、点号 . 组成
     第二部分： 域名，域名由字母、数字、短线 - 域名后缀组成
     * */
    function checkEmail(str) {
        var emailReg = /^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/;
        if (emailReg.test(str)){
            return true;
        }else {
            return false;
        }
    }

    /**
     * 手机号验证：
     ^ 1 以数字1 开头
     [3-578] 手机号第二位允许是 3 、4 、5、6、7、8 中的任意一位
     \d{9} 任意9位数字组合
     $ 只能以数字作为结尾
     **/
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
