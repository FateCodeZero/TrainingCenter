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
    <title>学员学习照</title>

    <link rel="stylesheet" href="${webRoot}/plug-in/bootstrap3.3.5/css/bootstrap.min.css">
    <link rel="stylesheet" href="${webRoot}/plug-in/layui-v2.4.5/layui/css/layui.css">
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/aboutUs.css">
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/animate.css">
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/bootstrap.css">
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/magnific-popup.css">
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/owl.carousel.min.css">
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/owl.theme.default.min.css">
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/flexslider.css">
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/pricing.css">
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/style.css">
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/style2.css">

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
                <h2>学员 &amp; 学习照</h2>
                <p>Dignissimos asperiores vitae velit veniam totam fuga molestias accusamus alias autem provident. Odit ab aliquam dolor eius.</p>
            </div>
        </div>
        <div class="row">
            <div class="w3agile_gallery_grids">
                <div id="student_photo"></div>
            </div>
        </div>
    </div>
</div>




</body>
<script>
    IFrameResize();

    $(document).ready(function loading(){
        IFrameResize();
        ajaxErrorHandler();//ajax请求错误统一处理
        //加载学员学习照列表
        $.ajax({
            type: 'GET',
            url: "${webRoot}/studentMien/listPage",
            data: {currentPage:1,rows:8},
            dataType: "json",
            success: function (data) {
                var jsonData = eval(data);
                var code = jsonData.code;
                var msg = jsonData.msg;
                if(code == 1){
                    var studentPhotos = jsonData.data.items;

                    if(studentPhotos.length == 0){
                        $("#student_photo").html('<h3 class="col-md-12 text-center">'+msg+'</h3>');
                    }
                    $.each(studentPhotos,function (index,studentPhoto) {
                        var id = studentPhoto.id;
                        var title = studentPhoto.title;
                        var content = studentPhoto.content;
                        var imgs = studentPhoto.imgs;
                        var remarks = studentPhoto.remarks;
                        var createUserId = studentPhoto.createUserId;
                        var createData = studentPhoto.createData;
                        var updateUserId = studentPhoto.updateUserId;
                        var updateData = studentPhoto.updateData;

                        /*截取字符串，p标签里面的文字长度必须一样长，否则页面会乱码*/
                        if(title.length > 20 ){
                            title = title.substring(0,20);
                        }
                        //处理context文本换行
/*                        var my_content = "";
                        if(content.length > 100){
                            for (var i = 0;i < 4;i++){
                                my_content = my_content + content.substring(i*25,(i+1)*25)+"\n";
                            }
                        }else if(content.length < 25){
                            my_content = content;
                        }else {
                            for (var i = 0;i < Math.floor(content.length/25);i++){
                                my_content = my_content + content.substring(i*25,(i+1)*25)+"\n";
                            }
                        }*/

                        var photo_div = '<div id="student_photo"  class="col-md-3 w3agile_gallery_grid">' +
                            '                    <div class="w3agile_gallery_image">' +
                            '                        <a class="sb" href="'+imgs+'" title="Agriculture">' +
                            '                            <figure>' +
                            '                                <img src="'+imgs+'" alt="" class="img-responsive" />' +
                            '                                <figcaption>' +
                            '                                    <h4>'+title+'</h4>' +
                            '                                    <p>'+content+'</p>' +
                            '                                </figcaption>' +
                            '                            </figure>' +
                            '                        </a>' +
                            '                    </div>' +
                            '                </div>';


                        if (index == 0) {
                            $("#student_photo").html(photo_div);
                        }else {
                            $("#student_photo").append(photo_div);
                        }

                    });

                    //再次计算高度，包含ajax新增的数据流
                    IFrameResize();
                }else {
                    $("#student_photo").html('<h3 class="col-md-12 text-center">'+msg+'</h3>');
                }
                IFrameResize();
            }
        });
    });

</script>
</html>
