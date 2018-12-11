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
    <title>访谈教学</title>

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
    <script type="text/javascript" src="${webRoot}/webpages/static/js/utils.js"></script>
</head>
<body onload="IFrameResize()">

<!-- 访谈教学 -->
<div id="fh5co-course">
    <div class="container">
        <div class="row animate-box">
            <div class="col-md-6 col-md-offset-3 text-center fh5co-heading">
                <h2>访谈教学</h2>
                <p>Dignissimos asperiores vitae velit veniam totam fuga molestias accusamus alias autem provident. Odit ab aliquam dolor eius.</p>
            </div>
        </div>
        <div class="row">
            <div id="interview"></div>
            <div id="interview_pagination" class="col-md-12 text-center"></div>

        </div>
    </div>
</div>

</body>

<script>

    layui.use('laypage', function(){

        $(document).ready(function loading(){
            getInterviewListPage(1);
            IFrameResize();
        });

        //获取InterviewListPage数据，完成DIV追加，返回总条数
        function getInterviewListPage(currentPage){

            $.ajax({
                type: 'GET',
                url: "${webRoot}/interviewTeaching/listPage",
                data: {currentPage:currentPage,rows:4},
                dataType: "json",
                success: function (data) {
                    var jsonData = eval(data);
                    var code = jsonData.code;
                    var msg = jsonData.msg;
                    if(code === 1){
                        var interviewListPages = jsonData.data.items;
                        var interviewTotal = Math.ceil((jsonData.data.total)/4);
                        if(interviewListPages.length === 0){
                            $("#interview").html('<h3 class="col-md-12 text-center">'+msg+'</h3>');
                        }

                        $.each(interviewListPages,function (index,interviewListPage) {
                            var id = interviewListPage.id;
                            var title = interviewListPage.title;
                            var content = interviewListPage.content;
                            var imgs = interviewListPage.imgs;
                            var remarks = interviewListPage.remarks;
                            var createUserId = interviewListPage.createUserId;
                            var createData = interviewListPage.createData;
                            var updateUserId = interviewListPage.updateUserId;
                            var updateData = interviewListPage.updateData;

                            /*处理当前字符串，p标签里面的文字长度必须一样长，否则页面会乱码*/
                            title = titleSubstring(title);
                            content = contentSubstring(pageContent(content));

                            var interview_div = '<div id="'+id+'" class="col-md-6 animate-box">\n' +
                                '                <div class="course">\n' +
                                '                    <a href="#" class="course-img" style="background-image: url('+imgs+');">\n' +
                                '                    </a>\n' +
                                '                    <div class="desc">\n' +
                                '                        <h3><a href="#">'+title+'</a></h3>\n' +
                                '                        <p>'+content+'</p>\n' +
                                '                        <span><a id="'+id+'" target="interview_a"  class="btn btn-primary btn-sm btn-course">&amp; 了解 更多</a></span>\n' +
                                '                    </div>\n' +
                                '                </div>\n' +
                                '            </div>';


                            if (index == 0) {
                                $("#interview").html(interview_div);
                            }else {
                                $("#interview").append(interview_div);
                            }

                            $("#"+id).on('click',function () {
                                //获取当前被点击的条数ID，携带ID跳转到体验式教学详情页面
                                var interview_id = $(this).attr("id");
                                window.location.href = "${webRoot}/webpages/static/pages/characteristicCourses/interviewDetails.jsp?id="+interview_id;
                            })

                        });

                        //生成分页
                        createlayPage(interviewTotal,currentPage);
                        //再次计算高度，包含ajax新增的数据流
                        IFrameResize();
                    }else {
                        $("#interview").html('<h3 class="col-md-12 text-center">'+msg+'</h3>');
                    }
                }
                , error: function (jqXHR, textStatus, errorThrown) {
                    ajaxErrorHandler(jqXHR); //ajax请求异常统一处理
                }
            });

        }

        /*生成分页*/
        function createlayPage(interviewTotal,currentPage) {

            var laypage = layui.laypage;
            laypage.render({
                elem: 'interview_pagination'      //div的ID
                , count: interviewTotal        //数据总数，从服务端得到
                , limit: 1              //每页显示数据条数
                , groups: 3             //连续出现的页码数
                , theme: '#437be2'           //自定义主题颜色
                ,curr:currentPage             //当前页
                , jump: function (obj, first) {
                    //页码切换回调
                    if(!first){
                        //重新获取新分页数据
                        getInterviewListPage(obj.curr);
                    }

                }
            });
        }
        IFrameResize();

    });

</script>
</html>
