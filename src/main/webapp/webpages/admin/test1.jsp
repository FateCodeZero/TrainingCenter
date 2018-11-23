<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/context/mytags.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/my_layui.css">
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/tree.css">
    <link rel="stylesheet" href="${webRoot}/plug-in/layui-v2.4.5/layui/css/layui.css">
    <link rel="stylesheet" href="${webRoot}/plug-in/bootstrap3.3.5/css/bootstrap.min.css">

    <script src="${webRoot}/plug-in/jquery-3.2.1/jquery-3.2.1.min.js"></script>
    <script src="${webRoot}/plug-in/layui-v2.4.5/layui/layui.all.js"></script>
    <script src="${webRoot}/plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>

</head>

<body>
<div class="layui-tab layui-tab-brief" lay-filter="demoTitle">
    <ul class="my-title layui-tab-title site-demo-title">
        <li class="layui-this">预览</li>
        <li class="">查看代码</li>
        <li class="">帮助</li>
    </ul>
    <div class="my-layui-body layui-body layui-tab-content site-demo site-demo-body">

        <div class="layui-tab-item layui-show">
            <div class="layui-main">
                <h3>test1</h3>
            </div>
        </div>
    </div>
</div>
</body>
<script type="text/javascript">
    //JavaScript代码区域
    layui.use('element', function () {
        var element = layui.element;
        //监听导航点击
        element.on('nav', function (elem) {
            //console.log(elem)
            layer.msg(elem.text()); //弹出提示
            var text = elem.text();
        });
        element.render("nav");

    });
</script>

</html>