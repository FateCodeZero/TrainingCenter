<%--
  Created by IntelliJ IDEA.
  User: Sky
  Date: 2018/12/4
  Time: 11:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/context/mytags.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>编辑广告</title>

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
        <form class="form-horizontal" role="form" action="">
            <input type="hidden" value="" name="id" id="id">
            <div class="form-group">
                <label for="imgs" class="col-sm-2 control-label">广告图片</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" name="imgs" id="imgs" value="" placeholder="请给出图片链接">
                </div>
            </div>
            <div class="form-group">
                <label for="describe" class="col-sm-2 control-label">图片描述</label>
                <div class="col-sm-10">
                    <textarea rows="3" class="form-control" name="describe" id="describe"
                              placeholder="描述内容"></textarea>
                </div>
            </div>
            <div class="form-group">
                <label for="url" class="col-sm-2 control-label">广告链接</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" name="url" id="url" value="" placeholder="请给出广告链接">
                </div>
            </div>
            <div class="form-group">
                <label for="start" class="col-sm-2 control-label">开始时间</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" name="start" id="start">
                </div>
            </div>
            <div class="form-group">
                <label for="end" class="col-sm-2 control-label">结束时间</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" name="end" id="end">
                </div>
            </div>
            <div class="form-group">
                <label for="remark" class="col-sm-2 control-label">广告备注</label>
                <div class="col-sm-10">
                    <textarea rows="3" class="form-control" name="remark" id="remark"
                              placeholder="备注内容"></textarea>
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
    /*日期选择*/
    layui.use('laydate', function(){
        var laydate = layui.laydate;

        //执行选择日期实例
        laydate.render({
            elem: '#start' //指定元素
        });
        laydate.render({
            elem: '#end' //指定元素
        });
    });
    $(document).ready(function () {
        //页面加载完成
        //……
        /*从URL获取对象ID*/
        var advertisementId = getUrlParam('id');
        /*通过ID获取对象信息*/
        var advertisement = getAdvertisementById(advertisementId);
        /*初始化编辑数据*/
        editDataInitialization(advertisement);
    });


    /**
     * 编辑数据初始化
     * @param role：要编辑的角色对象
     */
    function editDataInitialization(advertisement) {
        if (advertisement === null || advertisement === '') {
            layer.alert('数据初始化失败，对象不能为空', {
                time: 3000,
                icon: 2
            });
            return false;
        }
        $("#id").val(advertisement.id);
        $("#imgs").val(advertisement.imgs);
        $("#describe").val(advertisement.describe);
        $("#url").val(advertisement.url);
        $("#start").val(advertisement.start);
        $("#end").val(advertisement.end);
        $("#remarks").html(advertisement.remarks);
    }

    /**
     * 通过 id 获取广告对象
     * @param id 广告id
     */
    function getAdvertisementById(id) {

        if (id === null || id === '') {
            layer.alert('id不能为空！', {
                time: 3000,
                icon: 2
            });
            return false;
        }
        var advertisement = null;
        var data = {id: id};
        $.ajax({
            url: "${webRoot}/advertisement/getAdvertisementById",
            type: "get",
            async: false,    //关闭异步请求
            data: data,
            dataType: "json",
            success: function (data) {
                var jsonData = eval(data); //数据解析
                var code = jsonData.code;
                var msg = jsonData.msg;
                if (code === 1) {
                    advertisement = jsonData.data.advertisement;
                } else {
                    layer.alert(msg, {
                        time: 3000,
                        icon: 2
                    });
                    return false;
                }
            }
        });
        return advertisement;
    }

    //提交
    $("#submit").click(function () {
        var id = $("#id").val();
        var imgs = $("#imgs").val();
        var describe = $("#describe").val();
        var url = $("#url").val();
        var start = $("#start").val();
        var end = $("#end").val();
        var remarks = $("#remarks").val();

        if (id === null || id === ''){
            var msg = '<div style="text-align: center"><span style="color: #FF5722;font-size: large">广告不存在或已被删除，</span><br>即将返回列表界面。</div>';
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

        if (imgs == null || imgs == "") {
            layer.msg("请输入图片链接！", {
                icon: 2,
                time: 2000 //2秒关闭（如果不配置，默认是3秒）
            });
            $("#imgs").css("border", "1px solid red");  //输入错误，输入框变红
            $("#imgs").focus();
            return false;
        } else {
            $("#imgs").css("border", "1px solid #009688");
            $("#imgs").blur();      //失去焦点
        }
        if (describe == null || describe == "") {
            layer.msg("请编辑广告描述！", {
                icon: 2,
                time: 2000 //2秒关闭（如果不配置，默认是3秒）
            });
            $("#describe").css("border", "1px solid red");
            $("#describe").focus();
            return false;
        } else {
            $("#describe").css("border", "1px solid #009688");
            $("#describe").blur();      //失去焦点
        }
        if (url == null || url == "") {
            layer.msg("请给出广告链接！", {
                icon: 2,
                time: 2000 //2秒关闭（如果不配置，默认是3秒）
            });
            $("#url").css("border", "1px solid red");
            $("#url").focus();
            return false;
        } else {
            $("#url").css("border", "1px solid #009688");
            $("#url").blur();      //失去焦点
        }

        var data = {
            id: id,
            imgs: imgs,
            describe: describe,
            url: url,
            start: start,
            end: end,
            remarks: remarks
        };

        $.ajax({
            url: "${webRoot}/advertisement/update",
            type: "get",
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
        });
    });

    $("#close").click(function () {
        closeView();
    });

    function closeView() {
        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
        parent.layer.close(index); //再执行关闭
    }

</script>

</html>
