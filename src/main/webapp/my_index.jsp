<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/context/mytags.jsp" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>首页</title>

    <link rel="stylesheet" href="${webRoot}/plug-in/bootstrap3.3.5/css/bootstrap.min.css">
    <link rel="stylesheet" href="${webRoot}/plug-in/layui-v2.3.0/layui/css/layui.css">

    <script type="text/javascript" src="${webRoot}/plug-in/jquery-3.2.1/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/layui-v2.3.0/layui/layui.all.js"></script>
</head>
<body>
<div style="height: 100px;width: auto">公司logo图</div>
<div class="row">
    <ul class="layui-nav" lay-filter="index-nav">
        <li class="layui-nav-item">
            <a href="">控制台<span class="layui-badge">9</span></a>
        </li>
        <li class="layui-nav-item">
            <a href="">控制台<span class="layui-badge">9</span></a>
        </li>
        <li class="layui-nav-item">
            <a href="">控制台<span class="layui-badge">9</span></a>
        </li>
        <li class="layui-nav-item">
            <a href="">控制台<span class="layui-badge">9</span></a>
        </li>
        <li class="layui-nav-item">
            <a href="${}/">登录<span class="layui-badge">9</span></a>
        </li>
        <li class="layui-nav-item">
            <a href="">注册<span class="layui-badge">9</span></a>
        </li>
        <li class="layui-nav-item">
            <a href="">个人中心<span class="layui-badge-dot"></span></a>
        </li>
        <li class="layui-nav-item" lay-unselect="">
            <a href="javascript:;"><img src="//t.cn/RCzsdCq" class="layui-nav-img">我</a>
            <dl class="layui-nav-child">
                <dd><a href="javascript:;">修改信息</a></dd>
                <dd><a href="javascript:;">安全管理</a></dd>
                <dd><a href="javascript:;">退了</a></dd>
            </dl>
        </li>
    </ul>
</div>
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