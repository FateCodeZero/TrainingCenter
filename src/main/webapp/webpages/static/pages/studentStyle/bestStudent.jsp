<%--
  Created by IntelliJ IDEA.
  User: YMM
  Date: 2018/11/14
  Time: 22:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/context/mytags.jsp" %>
<html>
<head>
    <title>最佳学员</title>

    <link rel="stylesheet" href="${webRoot}/plug-in/bootstrap3.3.5/css/bootstrap.min.css">
    <link rel="stylesheet" href="${webRoot}/plug-in/layui-v2.4.5/layui/css/layui.css">
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/body.css">
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
    <script type="text/javascript" src="${webRoot}/webpages/static/js/utils.js"></script>

</head>
<body onload="IFrameResize()">

<div id="fh5co-staff">
    <div class="container">
        <div class="row animate-box">
            <div class="col-md-8 col-md-offset-2 text-center fh5co-heading">
                <h2>最佳 &amp; 学员</h2>
                <p>Dignissimos asperiores vitae velit veniam totam fuga molestias accusamus alias autem provident. Odit ab aliquam dolor eius.</p>
            </div>
        </div>
        <div class="row">
            <div id="best_student"></div>
        </div>
    </div>
</div>

</body>
<script>
    $(document).ready(function loading(){
        ajaxErrorHandler();//ajax请求错误统一处理
        //加载最佳学员列表
        $.ajax({
            type: 'GET',
            url: "${webRoot}/bestStudent/listPage",
            data: {currentPage:1,rows:8},
            dataType: "json",
            success: function (data) {
                var jsonData = eval(data);
                var code = jsonData.code;
                var msg = jsonData.msg;
                if(code == 1){
                    var bestStudents = jsonData.data.items;

                    if(bestStudents.length == 0){
                        $("#best_student").html('<h3 class="col-md-12 text-center">'+msg+'</h3>');
                    }
                    $.each(bestStudents,function (index,bestStudent) {
                        var id = bestStudent.id;
                        var title = bestStudent.title;
                        var content = bestStudent.content;
                        var imgs = bestStudent.imgs;
                        var remarks = bestStudent.remarks;
                        var createUserId = bestStudent.createUserId;
                        var createData = bestStudent.createData;
                        var updateUserId = bestStudent.updateUserId;
                        var updateData = bestStudent.updateData;

                        /*截取字符串，p标签里面的文字长度必须一样长，否则页面会乱码*/
                        if(title.length > 20 ){
                            title = title.substring(0,20);
                        }
                        if(content.length > 60 ){
                            content = content.substring(0,60);
                        }

                        var story_div = '<div id="'+id+'" class="col-md-3 animate-box text-center">' +
                            '                <div class="staff">' +
                            '                    <div class="staff-img" style="background-image: url('+imgs+');">' +
                            '                        <ul class="fh5co-social">' +
                            '                            <li><a href="#"><i class="icon-facebook2"></i></a></li>' +
                            '                            <li><a href="#"><i class="icon-twitter2"></i></a></li>' +
                            '                            <li><a href="#"><i class="icon-dribbble2"></i></a></li>' +
                            '                            <li><a href="#"><i class="icon-github"></i></a></li>' +
                            '                        </ul>' +
                            '                    </div>' +
                            '                    <span>Health Teacher</span>' +
                            '                    <h3><a href="#">'+title+'</a></h3>' +
                            '                    <p>'+content+'</p>' +
                            '                </div>' +
                            '            </div>';


                        if (index == 0) {
                            $("#best_student").html(story_div);
                        }else {
                            $("#best_student").append(story_div);
                        }
                    });

                    //再次计算高度，包含ajax新增的数据流
                    IFrameResize();
                }else {
                    $("#best_student").html('<h3 class="col-md-12 text-center">'+msg+'</h3>');
                }
                IFrameResize();
            }
        });
    });

</script>
</html>
