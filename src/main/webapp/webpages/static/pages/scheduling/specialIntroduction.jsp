<%--
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/context/mytags.jsp" %>
<html>
<head>
    <title>特此介绍</title>
    <link rel="stylesheet" href="${webRoot}/plug-in/layui-v2.4.5/layui/css/layui.css">
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/dynamic.css">
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

<div  id="fh5co-about">
    <div id="introduction" class="container"></div>
    <div class="col-md-12" style="height: 100px;"></div>
</div>
</body>

<script>

    $(document).ready(function () {

        $.ajax({
            type: 'GET',
            url: "${webRoot}/culturalProducts/detailsPage",
            data: '',
            dataType: "json",
            success:function (data) {
                var jsonData = eval(data);
                var code = jsonData.code;
                var msg = jsonData.msg;

                if(code == 1){
                    var details = jsonData.data.items;
                    var id = details.id;
                    var title = details.title;
                    var content = details.content;
                    var imgs = details.imgs;

                    var introduction_div = '    <div id="'+id+' " class="container">' +
                        '        <div class="row animate-box">' +
                        '            <div class="col-md-6 col-md-offset-3 text-center fh5co-heading">' +
                        '                <h2>特此介绍</h2>' +
                        '                <p>Dignissimos asperiores vitae velit veniam totam fuga molestias accusamus alias autem provident. Odit ab aliquam dolor eius.</p>\n' +
                        '            </div>' +
                        '        </div>' +
                        '        <div class="col-md-6 animate-box">' +
                        '            <span>About Our Class</span>' +
                        '            <h2>'+title+'</h2>' +
                        '            <p>'+content+'</p>' +
                        '        </div>\n' +
                        '        <div class="col-md-6 img_height">' +
                        '            <img class="img-responsive" style="height:380px;"  src="'+imgs+'">' +
                        '        </div>' +
                        '    </div>';

                    $("#introduction").html(introduction_div);
                    IFrameResize();

                }else {
                    $("#introduction").html('<h3 class="col-md-12 text-center">'+msg+'</h3>');
                }
            },
            error:function (msg) {
                $("#introduction").html('<h3 class="col-md-12 text-center">'+msg+'</h3>');
            }
        })
    })

</script>
</html>
--%>
