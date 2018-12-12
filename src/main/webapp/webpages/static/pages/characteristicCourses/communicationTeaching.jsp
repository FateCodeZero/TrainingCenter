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
    <title>与创业名人/团队交流调研</title>

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
    <script type="text/javascript" src="${webRoot}/plug-in/jquery-cookie/jquery.cookie.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/layui-v2.4.5/layui/layui.all.js"></script>
    <script type="text/javascript" src="${webRoot}/webpages/static/js/utils.js"></script>
</head>
<body onload="IFrameResize()">

<!-- 与创业名人/团队交流调研 -->
<div id="fh5co-course">
    <div class="container">
        <div class="row animate-box">
            <div class="col-md-6 col-md-offset-3 text-center fh5co-heading">
                <h2>与创业名人/团队交流调研</h2>
                <p>Dignissimos asperiores vitae velit veniam totam fuga molestias accusamus alias autem provident. Odit ab aliquam dolor eius.</p>
            </div>
        </div>
        <div class="row">
            <div id="communication"></div>
            <div id="communication_pagination" class="col-md-12 text-center"></div>
        </div>
    </div>
</div>

</body>

<script>

    layui.use('laypage', function(){

        $(document).ready(function loading(){
            getListPage(1);
            IFrameResize();
        });

        //获取lListPage数据，完成DIV追加，返回总条数
        function getListPage(currentPage){

            $.ajax({
                type: 'GET',
                url: "${webRoot}/communicationTeaching/listPage",
                data: {currentPage:currentPage,
                    rows:4,
                    condition: JSON.stringify({searchContent: ''})
                },
                dataType: "json",
                success: function (data) {
                    var jsonData = eval(data);
                    var code = jsonData.code;
                    var msg = jsonData.msg;
                    if(code === 1){
                        var ListPages = jsonData.data.items;
                        var Total = Math.ceil((jsonData.data.total)/4);
                        if(ListPages.length === 0){
                            $("#communication").html('<h3 class="col-md-12 text-center">'+msg+'</h3>');
                        }
                        $.each(ListPages,function (index,ListPage) {
                            var id = ListPage.id;
                            var title = ListPage.title;
                            var content = ListPage.content;
                            var imgs = ListPage.imgs;
                            var remarks = ListPage.remarks;
                            var createUserId = ListPage.createUserId;
                            var createData = ListPage.createData;
                            var updateUserId = ListPage.updateUserId;
                            var updateData = ListPage.updateData;

                            /*处理当前字符串，p标签里面的文字长度必须一样长，否则页面会乱码*/

                            title = titleSubstring(title);
                            content = contentSubstring(pageContent(content));

                            var communication_div = '<div id="'+id+'" class="col-md-6 animate-box">\n' +
                                '                <div class="course">\n' +
                                '                    <a href="#" class="course-img" style="background-image: url('+imgs+');">\n' +
                                '                    </a>\n' +
                                '                    <div class="desc">\n' +
                                '                        <h3><a href="#">'+title+'</a></h3>\n' +
                                '                        <p>'+content+'</p>\n' +
                                '                        <span><a id="'+id+'" target="communication_a"  class="btn btn-primary btn-sm btn-course">&amp; 了解 更多</a></span>\n' +
                                '                    </div>\n' +
                                '                </div>\n' +
                                '            </div>';


                            if (index === 0) {
                                $("#communication").html(communication_div);
                            }else {
                                $("#communication").append(communication_div);
                            }

                            $("#"+id).on('click',function () {
                                //获取当前被点击的条数ID，携带ID跳转到体验式教学详情页面
                                var spot_id = $(this).attr("id");
                                window.location.href = "${webRoot}/webpages/static/pages/characteristicCourses/communicationDetails.jsp?id="+spot_id;
                            })

                        });

                        //生成分页
                        createlayPage(Total,currentPage);
                        //再次计算高度，包含ajax新增的数据流
                        IFrameResize();
                    }else {
                        $("#communication").html('<h3 class="col-md-12 text-center">'+msg+'</h3>');
                    }
                }
                , error: function (jqXHR, textStatus, errorThrown) {
                    ajaxErrorHandler(jqXHR); //ajax请求异常统一处理
                }
            });

        }

        /*生成分页*/
        function createlayPage(Total,currentPage) {

            var laypage = layui.laypage;
            laypage.render({
                elem: 'communication_pagination'      //div的ID
                , count: Total        //数据总数，从服务端得到
                , limit: 1              //每页显示数据条数
                , groups: 3             //连续出现的页码数
                , theme: '#437be2'           //自定义主题颜色
                ,curr:currentPage             //当前页
                , jump: function (obj, first) {
                    //页码切换回调
                    if(!first){
                        //重新获取新分页数据
                        getListPage(obj.curr);
                    }

                }
            });
        }
        IFrameResize();



    });

</script>
</html>
