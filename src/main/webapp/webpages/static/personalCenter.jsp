<%--
  Created by IntelliJ IDEA.
  User: SJH
  Date: 2018/11/22
  Time: 15:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>个人中心</title>
    <!-- Animate.css -->
    <link rel="stylesheet" href="${webRoot}/plug-in/bootstrap3.3.5/css/bootstrap.min.css" media="all">
    <link rel="stylesheet" href="${webRoot}/plug-in/layui-v2.3.0/layui/css/layui.css">
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/fileinput/file-input.min.css">
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/jcrop/jquery.Jcrop.min.css">
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/sco/scojs.css">
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/sco/sco.message.css">
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/personalCenter.css">

    <!-- JS -->
    <script type="text/javascript" src="${webRoot}/plug-in/jquery-3.2.1/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/layui-v2.3.0/layui/layui.all.js"></script>
    <script type="text/javascript" src="${webRoot}/webpages/static/js/utils.js"></script>

</head>
<body onload="IFrameResize()">
<div class="row personal_background">
        <div class="overlay"></div>
        <div class="col-md-8 col-md-offset-2 personal_body">
            <%--标题--%>
            <div class="col-md-12 personal_title">
                <h2 class="col-md-12 text-center ">个人中心</h2>
                <label class="col-md-2 col-md-offset-5 bar-w3-agile"></label>
            </div>
            <%--  user_info   --%>
            <div class="col-md-12 user_info">
                <div class="col-md-2  header">
                    <img name="upload" src="../static/images/photo1.jpg" alt="" class="col-md-12 head">
                    <p name="upload" class="col-md-12 modify">修改头像</p>
                </div>
                <!---->
                <div  class="col-md-9 right_c">
                    <div  class="col-md-12 right_info">
                        <div id="username" class="col-md-6 id_card">
                            <span  class="id_name">用户名：qq_40967964</span>
                        </div>
                        <div class="col-md-12 line"></div>
                        <div class="col-md-12 nick">
                            <span id="nickname" class="col-md-4 nickname">昵称：Daisy-song</span>
                            <span  class="col-md-2 mod">修改资料</span>
                        </div>
                        <ul  class="col-md-12 ">
                            <li id="real_name" class="common">实名：</li>
                            <li id="gender" class="common">性别：女</li>
                            <li id="birthday" class="common">生日：</li>
                            <li id="motto" class="common">座右铭：</li>
                            <li id="address" class="common">地区：</li>
                            <li id="email" class="common">邮箱：</li>
                            <li id="postal_code" class="common">邮政编码：</li>
                            <li id="phone" class="common">电话号码：</li>
                            <li id="imgs">图片：</li>
                            <li id="company" class="common">公司：</li>
                            <li id="position" class="common">职位：</li>
                            <li id="career" class="common">职业：</li>
                            <li class="intro">
                                <span class="noWid">简介：</span>
                                <span id="describe" class="content"></span>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    <%--图片上传--%>
</div>



</body>
</html>