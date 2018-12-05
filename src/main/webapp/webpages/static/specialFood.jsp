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
    <title>红色圣地</title>

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

<!-- 特色美食 -->
<div id="fh5co-course">
    <div class="container">
        <div class="row animate-box">
            <div class="col-md-6 col-md-offset-3 text-center fh5co-heading">
                <h2>特色美食</h2>
                <p>Dignissimos asperiores vitae velit veniam totam fuga molestias accusamus alias autem provident. Odit ab aliquam dolor eius.</p>
            </div>
        </div>
        <div class="row">
            <div id="special"></div>
            <div id="special_pagination" class="col-md-12 text-center"></div>

        </div>
    </div>
</div>

</body>

<script>

    layui.use('laypage', function(){

        $(document).ready(function loading(){
            getListPage();
            IFrameResize();
        });
        //获取ListPage数据，完成DIV追加，返回总条数
        function getListPage(currentPage){
            //首次加载，当前页为第一页时传入参数为空
            if (currentPage == null){
                currentPage = 1;
            }

            $.ajax({
                type: 'GET',
                url: "${webRoot}/specialFood/listPage",
                data: {currentPage:currentPage,rows:3},
                dataType: "json",
                success: function (data) {
                    var jsonData = eval(data);
                    var code = jsonData.code;
                    var msg = jsonData.msg;
                    if(code == 1){
                        var ListPages = jsonData.data.items;
                        var Total = Math.ceil((jsonData.data.total)/3);

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

                            /*截取字符串，p标签里面的文字长度必须一样长，否则页面会乱码*/
                            if(content.length > 60 ){
                                content = content.substring(0,60)+"…";
                            }

                            var special_div = '<div id="'+id+'" class="col-lg-4 col-md-4">\n' +
                                '                <div class="fh5co-blog animate-box">\n' +
                                '                    <a href="#" class="blog-img-holder" style="background-image: url('+imgs+');"></a>\n' +
                                '                    <div class="blog-text">\n' +
                                '                        <h3><a id="'+id+'" target="special_a" >'+title+'</a></h3>\n' +
                                '                        <span class="posted_on">March. 15th</span>\n' +
                                '                        <span class="comment"><a href="">21<i class="icon-speech-bubble"></i></a></span>\n' +
                                '                        <p>'+content+'</p>\n' +
                                '                    </div>\n' +
                                '                </div>\n' +
                                '            </div>';


                            if (index == 0) {
                                $("#special").html(special_div);
                            }else {
                                $("#special").append(special_div);
                            }

                            $("a[target='special_a']").on('click',function () {
                                //获取当前被点击的条数ID，携带ID跳转到详情页面
                                var special_id = $(this).attr("id");
                                window.location.href = "specialFoodDetails.jsp?id="+special_id+"";
                            });
                        });

                        //生成分页
                        createlayPage(Total,currentPage);
                        //再次计算高度，包含ajax新增的数据流
                        IFrameResize();
                    }else {
                        $("#special").html('<h3 class="col-md-12 text-center">暂无数据</h3>');
                    }
                }
            });

        }

        /*生成分页*/
        function createlayPage(Total,currentPage) {

            var laypage = layui.laypage;
            laypage.render({
                elem: 'special_pagination'      //div的ID
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
