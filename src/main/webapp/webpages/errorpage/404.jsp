<%--
  Created by IntelliJ IDEA.
  User: YangYi
  Date: 2018/11/8
  Time: 16:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/context/mytags.jsp" %>
<html>
<head>
    <title>404</title>
    <link rel="stylesheet" href="${webRoot}/plug-in/bootstrap3.3.5/css/bootstrap.min.css">
    <link rel="stylesheet" href="${webRoot}/webpages/errorpage/css/errorTips.css">

    <script type="text/javascript" src="${webRoot}/plug-in/jquery-3.2.1/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/layui-v2.4.5/layui/layui.all.js"></script>
    <script type="text/javascript" src="${webRoot}/webpages/static/js/utils.js"></script>
</head>
<body onload="IFrameResize()">
    <div class="row">
        <div class="col-md-12 bg_css">
            <div class="col-md-3"></div>
            <div class="col-md-6 center-vertical text-center">
                <p class="notFond1">404</p>
                <h1 class="notFond2">找不到页面</h1>
                <h2 class="notFond3">非常抱歉，网页出现未知故障，&nbsp;&nbsp;&nbsp;您可以选择
                    <a  href="#" >&nbsp;返回&nbsp;</a>或者<a href="#" >&nbsp;联系我们&nbsp;</a></h2>

            </div>
            <div class="col-md-3"></div>
        </div>
    </div>




    </div>



</body>


<script>
    function IFrameResize(){
        var obj = parent.document.getElementById("IF-body"); //取得父页面IFrame对象
        obj.height = 700; //调整父页面中IFrame的高度为此页面的高度
    }
</script>
</html>
