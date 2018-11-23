<%--
  Created by IntelliJ IDEA.
  User: YangYi
  Date: 2018/11/6
  Time: 19:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/context/mytags.jsp" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>首页顶部</title>

    <link rel="stylesheet" href="${webRoot}/plug-in/bootstrap3.3.5/css/bootstrap.min.css">
    <link rel="stylesheet" href="${webRoot}/plug-in/layui-v2.4.5/layui/css/layui.css">
    <link rel="stylesheet" href="./css/top.css">

    <script type="text/javascript" src="${webRoot}/plug-in/jquery-3.2.1/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/layui-v2.4.5/layui/layui.all.js"></script>
</head>
<body>
<h3 class="col-md-3 col-md-offset-1 top_text" ></h3>
</body>
<script type="text/javascript">
    $(document).ready(function () {
        //页面加载完成……

    });
    //使用 element 模块
    layui.use('element', function () {
        var element = layui.element; //导航的hover效果、二级菜单等功能，需要依赖element模块
        //监听导航点击
        element.on('nav(index-nav)', function (elem) {
            //console.log(elem)
            layer.msg(elem.text());//弹出提示
        });
        element.render("nav");
    });

</script>
</html>
