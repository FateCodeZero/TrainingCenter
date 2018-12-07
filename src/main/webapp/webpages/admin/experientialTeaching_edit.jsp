<%--
  Created by IntelliJ IDEA.
  User: Sky
  Date: 2018/12/6
  Time: 18:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/context/mytags.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>编辑体验式教学</title>

    <link rel="stylesheet" href="${webRoot}/plug-in/layui-v2.4.5/layui/css/layui.css">
    <link rel="stylesheet" href="${webRoot}/plug-in/bootstrap3.3.5/css/bootstrap.min.css">

    <script src="${webRoot}/plug-in/jquery-3.2.1/jquery-3.2.1.min.js"></script>
    <script src="${webRoot}/plug-in/layui-v2.4.5/layui/layui.all.js"></script>
    <script src="${webRoot}/plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
    <script src="${webRoot}/plug-in/js/utils.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/js/wangEditor.min.js"></script>
    <style type="text/css">
        .toolbar {
            border: 1px solid #ccc;
        }
        .text {
            border: 1px solid #ccc;
            height: 300px;
        }
    </style>
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
                <label for="title" class="col-sm-2 control-label">教学标题</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" name="name" id="title" value="" placeholder="请输入教学标题">
                </div>
            </div>
            <div class="form-group">
                <label for="content" class="col-sm-2 control-label">教学内容</label>
                <div class="col-sm-10">
                    <div id="toolbar" class="toolbar"></div>
                    <div id="content" class="text">
                        <h4 >请在此编辑教学内容</h4>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for="imgs" class="col-sm-2 control-label">教学图片</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" name="imgs" id="imgs" value="" placeholder="请给出图片链接">
                </div>
            </div>
            <div class="form-group">
                <label for="remark" class="col-sm-2 control-label">教学备注</label>
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
    $(document).ready(function () {
        ajaxErrorHandler(); //ajax请求错误统一处理
        //页面加载完成
        //……
        /*富文本*/
        wangEditorGet();
        /*从URL获取对象ID*/
        var experientialTeachingId = getUrlParam('id');
        /*通过ID获取对象信息*/
        var experientialTeaching = getExperientialTeachingById(experientialTeachingId);
        /*初始化编辑数据*/
        editDataInitialization(experientialTeaching);
    });

    /*创建富文本*/
    function wangEditorGet() {
        var E = window.wangEditor
        var editor = new E('#toolbar','#content')
        editor.create()
    }

    /**
     * 编辑数据初始化
     * @param role：要编辑的角色对象
     */
    function editDataInitialization(experientialTeaching) {
        if (experientialTeaching === null || experientialTeaching === '') {
            layer.alert('数据初始化失败，对象不能为空', {
                time: 3000,
                icon: 2
            });
            return false;
        }
        $("#id").val(experientialTeaching.id);
        $("#title").val(experientialTeaching.title);
        $("#content").html(experientialTeaching.content);
        $("#imgs").val(experientialTeaching.imgs);
        $("#remarks").val(experientialTeaching.remarks);
    }

    /**
     * 通过 id 获取新闻对象
     * @param id 新闻id
     */
    function getExperientialTeachingById(id) {

        if (id === null || id === '') {
            layer.alert('id不能为空！', {
                time: 3000,
                icon: 2
            });
            return false;
        }
        var experientialTeaching = null;
        var data = {id: id};
        $.ajax({
            url: "${webRoot}/experientialTeaching/getExperientialTeachingById",
            type: "get",
            async: false,    //关闭异步请求
            data: data,
            dataType: "json",
            success: function (data) {
                var jsonData = eval(data); //数据解析
                var code = jsonData.code;
                var msg = jsonData.msg;
                if (code === 1) {
                    experientialTeaching = jsonData.data.experientialTeaching;
                } else {
                    layer.alert(msg, {
                        time: 3000,
                        icon: 2
                    });
                    return false;
                }
            }
        });
        return experientialTeaching;
    }

    //提交
    $("#submit").click(function () {
        var id = $("#id").val();
        var title = $("#title").val();
        var content = $("#content").html();
        var imgs = $("#imgs").val();
        var remarks = $("#remarks").val();

        if (id === null || id === ''){
            var msg = '<div style="text-align: center"><span style="color: #FF5722;font-size: large">体验式教学不存在或已被删除，</span><br>即将返回列表界面。</div>';
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

        if (title == null || title == "") {
            layer.msg("请填写教学标题！", {
                icon: 2,
                time: 2000 //2秒关闭（如果不配置，默认是3秒）
            });
            $("#title").css("border", "1px solid red");  //输入错误，输入框变红
            $("#title").focus();
            return false;
        } else {
            $("#title").css("border", "1px solid #009688");
            $("#title").blur();      //失去焦点
        }
        if (content == null || content == "") {
            layer.msg("请编辑教学内容！", {
                icon: 2,
                time: 2000 //2秒关闭（如果不配置，默认是3秒）
            });
            $("#content").css("border", "1px solid red");
            $("#content").focus();
            return false;
        } else {
            $("#content").css("border", "1px solid #009688");
            $("#content").blur();      //失去焦点
        }
        if (imgs == null || imgs == "") {
            layer.msg("请给出图片链接！", {
                icon: 2,
                time: 2000 //2秒关闭（如果不配置，默认是3秒）
            });
            $("#imgs").css("border", "1px solid red");
            $("#imgs").focus();
            return false;
        } else {
            $("#imgs").css("border", "1px solid #009688");
            $("#imgs").blur();      //失去焦点
        }

        var data = {
            id: id,
            title: title,
            content: content,
            imgs: imgs,
            remarks: remarks
        };

        $.ajax({
            url: "${webRoot}/experientialTeaching/update",
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
