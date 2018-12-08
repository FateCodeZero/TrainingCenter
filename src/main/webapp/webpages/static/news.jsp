<%--
  Created by IntelliJ IDEA.
  User: YMM
  Date: 2018/11/14
  Time: 20:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/context/mytags.jsp" %>
<html>
<head>
    <title>新闻详情页面</title>
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
<div  id="fh5co-about">
    <div id="news_details" class="container"></div>
    <div class="col-md-12" ></div>
</div>


</body>
<script>

    $(document).ready(function () {

        var id = $.Request('id');
        $.ajax({
            type: 'GET',
            url: "${webRoot}/newsInfo/detailsPage",
            data: {id:id},
            dataType: "json",
            success:function (data) {
                var jsonData = eval(data);
                var code = jsonData.code;
                var msg = jsonData.msg;

                if(code === 1){
                    var news_details = jsonData.data.items;

                    if (news_details.length === 0){
                        $("#news_details").html('<h3 class="col-md-12 text-center">'+msg+'</h3>');
                    }
                    var id = news_details.id;
                    var title = news_details.title;
                    var content = news_details.content;
                    var imgs = news_details.imgs;
                    var createDate = news_details.createDate;

                    var news_details_div = '    <div id="'+id+' " class="container" style="padding-bottom: 30px">' +
                        '        <div class="row animate-box">' +
                        '            <div class="col-md-6 col-md-offset-3 text-center fh5co-heading">' +
                        '                <h2>新闻详情</h2>' +
                        '                <p>Dignissimos asperiores vitae velit veniam totam fuga molestias accusamus alias autem provident. Odit ab aliquam dolor eius.</p>\n' +
                        '            </div>' +
                        '        </div>' +
                        '        <div class="col-md-6 animate-box">' +
                        '            <h2>'+title+'</h2>' +
                        '            <span>发布时间：'+new Date(createDate).toLocaleString('chinese', {hour12: false}).replace(/:d{1,2}$/, ' ')+'</span>' +
                        '            <p>'+content+'</p>' +
                        '        </div>\n' +
                        '        <div class="col-md-6 img_height">' +
                        '            <img class="img-responsive"  src="'+imgs+'">' +
                        '        </div>' +
                        '    </div>';

                    $("#news_details").html(news_details_div);
                    IFrameResize();

                }else {
                    $("#news_details").html('<h3 class="col-md-12 text-center">'+msg+'</h3>');
                }
            }
            , error: function (jqXHR, textStatus, errorThrown) {
                ajaxErrorHandler(jqXHR); //ajax请求异常统一处理
            }
        });
        IFrameResize();
    })
</script>

</html>
