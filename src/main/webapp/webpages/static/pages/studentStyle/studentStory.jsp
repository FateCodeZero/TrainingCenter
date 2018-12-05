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
    <title>往期学员故事</title>

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
                    <h2>往期 &amp; 学员 &amp; 故事</h2>
                    <p>Dignissimos asperiores vitae velit veniam totam fuga molestias accusamus alias autem provident. Odit ab aliquam dolor eius.</p>
                </div>
            </div>
            <div class="row">
                <div id="student_story"></div>
            </div>
        </div>
    </div>



</body>

<script>
    $(document).ready(function loading(){

        //加载往期学员故事列表
        $.ajax({
            type: 'GET',
            url: "${webRoot}/studentStory/listPage",
            data: {currentPage:1,rows:8},
            dataType: "json",
            success: function (data) {
                var jsonData = eval(data);
                var code = jsonData.code;
                var msg = jsonData.msg;
                if(code == 1){
                    var studentStories = jsonData.data.items;
                    $.each(studentStories,function (index,studentstory) {
                        var id = studentstory.id;
                        var title = studentstory.title;
                        var content = studentstory.content;
                        var imgs = studentstory.imgs;
                        var remarks = studentstory.remarks;
                        var createUserId = studentstory.createUserId;
                        var createData = studentstory.createData;
                        var updateUserId = studentstory.updateUserId;
                        var updateData = studentstory.updateData;

                        /*截取字符串，p标签里面的文字长度必须一样长，否则页面会乱码*/
                        if(title.length > 20 ){
                            title = title.substring(0,20);
                        }
                        if(content.length > 60 ){
                            content = content.substring(0,60);
                        }

                        var story_div = '<div id="'+id+'" class="col-md-3 animate-box text-center">\n' +
                            '                    <div class="staff">\n' +
                            '                        <div class="staff-img" style="background-image: url('+imgs+');">\n' +
                            '                            <ul class="fh5co-social">\n' +
                            '                                <li><a href="#"><i class="icon-facebook2"></i></a></li>\n' +
                            '                                <li><a href="#"><i class="icon-twitter2"></i></a></li>\n' +
                            '                                <li><a href="#"><i class="icon-dribbble2"></i></a></li>\n' +
                            '                                <li><a href="#"><i class="icon-github"></i></a></li>\n' +
                            '                            </ul>\n' +
                            '                        </div>\n' +
                            '                        <span>Health Teacher</span>\n' +
                            '                        <h3><a href="#">'+title+'</a></h3>\n' +
                            '                        <p>'+content+'</p>\n' +
                            '                    </div>\n' +
                            '                </div>';


                        if (index == 0) {
                            $("#student_story").html(story_div);
                        }else {
                            $("#student_story").append(story_div);
                        }

                    });

                    //再次计算高度，包含ajax新增的数据流
                    IFrameResize();
                }else {
                    $("#student_story").html('<h3 class="col-md-12 text-center">暂无数据</h3>');
                }
            }
        });
    });

</script>

</html>
