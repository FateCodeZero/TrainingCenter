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
    <title>留言详情</title>

    <link rel="stylesheet" href="${webRoot}/plug-in/layui-v2.4.5/layui/css/layui.css">
    <link rel="stylesheet" href="${webRoot}/plug-in/bootstrap3.3.5/css/bootstrap.min.css">

    <script src="${webRoot}/plug-in/jquery-3.2.1/jquery-3.2.1.min.js"></script>
    <script src="${webRoot}/plug-in/jquery-cookie/jquery.cookie.js"></script>
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
            <input type="hidden" value="" name="id" id="id">
            <div class="form-group">
                <label for="title" class="col-sm-2 control-label">留言标题</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" name="title" id="title" value="" disabled="disabled">
                </div>
            </div>
            <div class="form-group">
                <label for="content" class="col-sm-2 control-label">留言内容</label>
                <div class="col-sm-10">
                    <textarea rows="3" class="form-control" name="content" id="content" disabled="disabled"
                              placeholder="留言内容"></textarea>
                </div>
            </div>
            <div class="form-group">
                <label for="replyCount" class="col-sm-2 control-label">回复数</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" name="replyCount" id="replyCount" value="" disabled="disabled"
                           placeholder="回复数">
                </div>
            </div>
            <div class="form-group">
                <label for="praiseCount" class="col-sm-2 control-label">点赞数</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" name="praiseCount" id="praiseCount" value="" disabled="disabled"
                           placeholder="点赞数">
                </div>
            </div>
            <div class="form-group">
                <label for="state" class="col-sm-2 control-label">留言审核状态</label>
                <div class="col-sm-10">
                    <select class="form-control" name="state" id="state" disabled="disabled">
                        <option value="1">选择状态</option>
                        <option value="1" id="enable">已通过</option>
                        <option value="0" id="unEnable">未审核</option>
                        <option value="-1" id="deleted">已删除</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label for="createUserId" class="col-sm-2 control-label">留言人</label>
                <div class="col-sm-10">
                    <input type="hidden" class="form-control" name="createUserId" id="createUserId" value="" disabled="disabled"
                           placeholder="留言人id">
                    <input type="text" class="form-control" name="createUsername" id="createUsername" value="" disabled="disabled"
                           placeholder="留言人">
                </div>
            </div>
            <div class="form-group">
                <label for="createDate" class="col-sm-2 control-label">留言时间</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" name="createDate" id="createDate" value="" disabled="disabled"
                           placeholder="留言时间">
                </div>
            </div>
            <%--<div class="form-group">
                <label for="updateUserId" class="col-sm-2 control-label">更新人</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" name="updateUserId" id="updateUserId" value=""
                           placeholder="更新人">

                </div>
            </div>
            <div class="form-group">
                <label for="updateDate" class="col-sm-2 control-label">更新时间</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" name="updateDate" id="updateDate" value=""
                           placeholder="更新时间">
                </div>
            </div>--%>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10 text-center">
                    <div class="col-sm-2"></div>
                    <button type="button" class="layui-btn layui-btn-normal col-sm-6" id="close">确定</button>
                    <div class="col-sm-2"></div>
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

        /*从URL获取对象ID*/
        var commentId = getUrlParam('id');
        /*通过ID获取对象信息*/
        var comment = getCommentById(commentId);
        /*初始化编辑数据*/
        editDataInitialization(comment);
        laydate();
    });

    /*日期*/
    function laydate() {
        layui.use(['laydate'], function () {
            var laydate = layui.laydate;
            //执行选择日期实例
            laydate.render({
                elem: '#createDate' //指定元素
            });
        });
    }

    /**
     * 编辑数据初始化
     * @param role：要编辑的角色对象
     */
    function editDataInitialization(comment) {
        if (comment === null || comment === '') {
            layer.alert('数据初始化失败，对象不能为空', {
                time: 3000,
                icon: 2
            });
            return false;
        }
        $("#id").val(comment.id);
        $("#title").val(comment.title);
        $("#content").val(comment.content);
        $("#replyCount").val(comment.replyCount);
        $("#praiseCount").val(comment.praiseCount);

        var state = comment.state;
        if (state === 1) {
            $("#enable").attr('selected', 'selected')
        } else if (state === 0){
            $("#unEnable").attr('selected', 'selected')
        }else {
            $("#deleted").attr('selected', 'selected')
        }
        var createUserId = comment.createUserId;
        $("#createUserId").val(createUserId);
        var user = getUserById(createUserId);
        $("#createUsername").val(user.username);

        $("#createDate").val(new Date(comment.createDate).toLocaleString('chinese', {hour12: false}).replace(/:d{1,2}$/, ' '));
    }

    /**
     * 通过 id 获取留言对象
     * @param id 留言id
     */
    function getCommentById(id) {
        if (id === null || id === '') {
            layer.alert('请先选择要查询的数据', {
                time: 3000,
                icon: 2
            });
            return false;
        }
        var comment = null;
        var data = {id: id};
        $.ajax({
            url: "${webRoot}/comment/getCommentById",
            type: "get",
            async: false,    //关闭异步请求
            data: data,
            dataType: "json",
            success: function (data) {
                var jsonData = eval(data); //数据解析
                var code = jsonData.code;
                var msg = jsonData.msg;
                if (code === 1) {
                    comment = jsonData.data.comment;
                } else {
                    layer.alert(msg, {
                        time: 3000,
                        icon: 2
                    });
                    return false;
                }
            }
            , error: function (jqXHR, textStatus, errorThrown) {
                ajaxErrorHandler(jqXHR); //ajax请求异常统一处理
            }
        });
        return comment;
    }

    //提交
    $("#submit").click(function () {
        var id = $("#id").val();
        var name = $("#name").val();
        var state = $("#state").val();
        var describe = $("#describe").val();
        var remarks = $("#remarks").val();

        if (id === null || id === '') {
            var msg = '<div style="text-align: center"><span style="color: #FF5722;font-size: large">对象不存在或已被删除，</span><br>即将返回列表界面。</div>';
            layer.confirm(msg, {
                    btn: ['确定', '取消']//按钮
                }
                , function () { //确定之后执行
                    closeView();    //关闭当前窗口
                }, function () { //取消之后执行
                    closeView();    //关闭当前窗口
                }
            );
        }

        if (name === null || name === '') {
            layer.msg("请填写角色名称！", {
                icon: 2,
                time: 2000 //2秒关闭（如果不配置，默认是3秒）
            });
            $("#name").css("border", "1px solid red");  //输入错误，输入框变红
            $("#name").focus();
            return false;
        } else {
            $("#name").css("border", "1px solid #009688");
            $("#name").blur();      //失去焦点
        }
        if (state === null || state === '') {
            layer.msg("请选择角色使用状态！", {
                icon: 2,
                time: 2000 //2秒关闭（如果不配置，默认是3秒）
            });
            $("#state").css("border", "1px solid red");
            $("#state").focus();
            return false;
        } else {
            $("#state").css("border", "1px solid #009688");
            $("#state").blur();      //失去焦点
        }

        var data = {
            id: id,
            name: name,
            state: state,
            describe: describe,
            remarks: remarks
        };

        $.ajax({
            url: "${webRoot}/comment/update",
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
                    closeView();    //关闭窗口
                } else {
                    layer.alert(msg, {
                        time: 3000,
                        icon: 2
                    });
                }
            }
            , error: function (jqXHR, textStatus, errorThrown) {
                ajaxErrorHandler(jqXHR); //ajax请求异常统一处理
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
     * 通过 id 获取用户
     * @param id
     * @returns {*}
     */
    function getUserById(id) {
        if (id === null || id === '') {
            layer.alert('id不能为空！', {
                time: 3000,
                icon: 2
            });
            return false;
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
                    return false;
                }
            }
            , error: function (jqXHR, textStatus, errorThrown) {
                ajaxErrorHandler(jqXHR); //ajax请求异常统一处理
            }
        });
        return user;
    }

</script>

</html>
