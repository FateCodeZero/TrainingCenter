<%--
  Created by IntelliJ IDEA.
  User: YangYi
  Date: 2018/11/12
  Time: 0:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/context/mytags.jsp" %>
<html>
<head>
    <title>401</title>
    <link rel="stylesheet" href="${webRoot}/plug-in/bootstrap3.3.5/css/bootstrap.min.css">
    <link rel="stylesheet" href="${webRoot}/webpages/errorpage/css/errorTips.css">

    <script type="text/javascript" src="${webRoot}/plug-in/jquery-3.2.1/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/layui-v2.4.5/layui/layui.all.js"></script>
</head>
<body onload="IFrameResize()">
    <div class="col-md-12 bg_css">
        <div class="col-md-3"></div>
        <div class="col-md-6 center-vertical text-center">
            <p class="notFond1">401</p>
            <h1 class="notFond2">访问路径异常</h1>
            <h2 class="notFond3">非常抱歉，您的访问路径异常，您可以选择重新
                <a  href="#" >&nbsp;登录&nbsp;</a>或者
                <a href="#" >&nbsp;联系我们&nbsp;</a></h2>

        </div>
        <div class="col-md-3"></div>
    </div>
</body>
<script>
    function IFrameResize(){
        var obj = parent.document.getElementById("IF-body"); //取得父页面IFrame对象
        obj.height = 700; //调整父页面中IFrame的高度为700px
    }
</script>
</html>
