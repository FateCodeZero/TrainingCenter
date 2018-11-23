<%--
  Created by IntelliJ IDEA.
  User: YMM
  Date: 2018/11/13
  Time: 15:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/context/mytags.jsp" %>
<html>
<head>
    <title>体验式教学</title>

    <link rel="stylesheet" href="${webRoot}/plug-in/bootstrap3.3.5/css/bootstrap.min.css">
    <link rel="stylesheet" href="${webRoot}/plug-in/layui-v2.4.5/layui/css/layui.css">
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/animate.css">
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/bootstrap.css">
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/magnific-popup.css">
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/owl.carousel.min.css">
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/owl.theme.default.min.css">
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/flexslider.css">
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/pricing.css">
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/style.css">

    <script type="text/javascript" src="${webRoot}/plug-in/jquery-3.2.1/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/layui-v2.4.5/layui/layui.all.js"></script>
</head>
<body onload="IFrameResize()">

<!-- 体验式教学 -->
<div id="fh5co-course">
    <div class="container">
        <div class="row animate-box">
            <div class="col-md-6 col-md-offset-3 text-center fh5co-heading">
                <h2>体验式教学</h2>
                <p>Dignissimos asperiores vitae velit veniam totam fuga molestias accusamus alias autem provident. Odit ab aliquam dolor eius.</p>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6 animate-box">
                <div class="course">
                    <a href="#" class="course-img" style="background-image: url(${webRoot}/webpages/static/images/project-1.jpg);">
                    </a>
                    <div class="desc">
                        <h3><a href="#">大数据挖掘与分析</a></h3>
                        <p>Dignissimos asperiores vitae velit veniam totam fuga molestias accusamus alias autem provident. Odit ab aliquam dolor eius molestias accusamus alias autem provident. Odit ab aliquam dolor eius.</p>
                        <span><a href="#" class="btn btn-primary btn-sm btn-course">&amp; 了解 更多</a></span>
                    </div>
                </div>
            </div>
            <div class="col-md-6 animate-box">
                <div class="course">
                    <a href="#" class="course-img" style="background-image: url(${webRoot}/webpages/static/images/project-2.jpg);">
                    </a>
                    <div class="desc">
                        <h3><a href="#">云计算虚拟化技术</a></h3>
                        <p>Dignissimos asperiores vitae velit veniam totam fuga molestias accusamus alias autem provident. Odit ab aliquam dolor eius molestias accusamus alias autem provident. Odit ab aliquam dolor eius.</p>
                        <span><a href="#" class="btn btn-primary btn-sm btn-course">&amp; 了解 更多</a></span>
                    </div>
                </div>
            </div>
            <div class="col-md-6 animate-box">
                <div class="course">
                    <a href="#" class="course-img" style="background-image: url(${webRoot}/webpages/static/images/project-3.jpg);">
                    </a>
                    <div class="desc">
                        <h3><a href="#">Oracle数据库系统</a></h3>
                        <p>Dignissimos asperiores vitae velit veniam totam fuga molestias accusamus alias autem provident. Odit ab aliquam dolor eius molestias accusamus alias autem provident. Odit ab aliquam dolor eius.</p>
                        <span><a href="#" class="btn btn-primary btn-sm btn-course">&amp; 了解 更多</a></span>
                    </div>
                </div>
            </div>
            <div class="col-md-6 animate-box">
                <div class="course">
                    <a href="#" class="course-img" style="background-image: url(${webRoot}/webpages/static/images/project-4.jpg);">
                    </a>
                    <div class="desc">
                        <h3><a href="#">WebUI设计与实践</a></h3>
                        <p>Dignissimos asperiores vitae velit veniam totam fuga molestias accusamus alias autem provident. Odit ab aliquam dolor eius molestias accusamus alias autem provident. Odit ab aliquam dolor eius.</p>
                        <span><a href="#" class="btn btn-primary btn-sm btn-course">&amp; 了解 更多</a></span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>

<script>

    //动态设置iframe高度，让子页面撑开父页面，注意子页面顶部和底部不要设置margin和padding，因为计算高度时会被忽略
    function IFrameResize(){
        //alert($(document.body).height()); //弹出当前页面的高度
        var obj = parent.document.getElementById("IF-body"); //取得父页面IFrame对象
        //alert(parent.document.getElementById("IF-body").height); //弹出父页面中IFrame中设置的高度
        obj.height = $(document.body).height(); //调整父页面中IFrame的高度为此页面的高度
    }


</script>
</html>
