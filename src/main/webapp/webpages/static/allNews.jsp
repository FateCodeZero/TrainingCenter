<%--
  Created by IntelliJ IDEA.
  User: YMM
  Date: 2018/11/14
  Time: 20:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/context/mytags.jsp" %>
<html>
<head>
    <title>梦润新闻页面</title>
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
    <script type="text/javascript" src="${webRoot}/plug-in/js/utils.js"></script>
</head>
<body onload="IFrameResize()">

<div id="fh5co-blog">
    <div class="container">
        <div class="row animate-box">
            <div class="col-md-8 col-md-offset-2 text-center fh5co-heading">
                <h2>梦润 &amp; 新闻</h2>
                <p>Dignissimos asperiores vitae velit veniam totam fuga molestias accusamus alias autem provident. Odit ab aliquam dolor eius.</p>
            </div>
        </div>
        <div id="allNews" class="row"></div>
        <div id="allNews_pagination" class="text-center"></div>
    </div>
</div>

</body>
<script type="text/javascript">

    layui.use('laypage', function(){

        $(document).ready(function loading(){

            getNewsListPage(1);
            IFrameResize();
        });

        //获取getNewsListPage数据，完成DIV追加，返回总条数
        function getNewsListPage(currentPage){

            $.ajax({
                type: 'GET',
                url: "${webRoot}/newsInfo/listPage",
                data: {currentPage:currentPage,rows:9},
                dataType: "json",
                success: function (data) {
                    var jsonData = eval(data);
                    var code = jsonData.code;
                    var msg = jsonData.msg;

                    if(code === 1){

                        var allNews = jsonData.data.items;
                        var newsTotal = Math.ceil((jsonData.data.total)/9);

                        if (allNews === 0){
                            $("#allNews").html('<h3 class="col-md-12 text-center">'+msg+'</h3>');
                        }

                        $.each(allNews,function (index,allNews) {
                            var id = allNews.id;
                            var title = allNews.title;
                            var content = allNews.content;
                            var imgs = allNews.imgs;
                            var remarks = allNews.remarks;
                            var createUserId = allNews.createUserId;
                            var createDate = allNews.createDate;
                            var updateUserId = allNews.updateUserId;
                            var updateDate = allNews.updateDate;

                            /*截取字符串，p标签里面的文字长度必须一样长，否则页面会乱码*/
                            if(content.length > 60 ){
                                content = content.substring(0,60);
                            }
                            if(title.length > 25 ){
                                title = title.substring(0,25) +"…";
                            }


                            var allNews_div = ' <div class="col-lg-4 col-md-4"> '+
                                '                      <div class="fh5co-blog animate-box">'+
                                '                              <a id="'+id+'" target="news" class="blog-img-holder" style="background-image: url('+imgs+');"></a>' +
                                '                          <div class="blog-text">' +
                                '                              <h3><a id="'+id+'" target="news">'+title+'</a></h3>' +
                                '                              <span class="posted_on">'+new Date(createDate).toLocaleString('chinese', {hour12: false}).replace(/:d{1,2}$/, ' ')+'</span>' +
                                '                              <p>'+content+'</p>'+
                                '                          </div>' +
                                '                      </div>' +
                                '              </div>';

                            if (index == 0) {
                                $("#allNews").html(allNews_div);
                            }else {
                                $("#allNews").append(allNews_div);
                            }

                            $("a[target='news']").on('click',function () {
                                //获取当前被点击的条数ID，携带ID跳转到动态培训详情页面
                                var news_id = $(this).attr("id");
                                window.location.href = "news.jsp?id="+news_id+"";
                            });
                        });
                        //生成分页
                        createlayPage(newsTotal,currentPage);
                        //再次计算高度，包含ajax新增的数据流
                        IFrameResize();
                    }else {
                        $("#allNews").html('<h3 class="col-md-12 text-center">'+msg+'</h3>');
                    }
                }
                , error: function (jqXHR, textStatus, errorThrown) {
                    ajaxErrorHandler(jqXHR); //ajax请求异常统一处理
                }
            });
        }

        /*生成分页*/
        function createlayPage(newsTotal,currentPage) {

            var laypage = layui.laypage;
            laypage.render({
                elem: 'allNews_pagination'      //div的ID
                , count: newsTotal        //数据总数，从服务端得到
                , limit: 1              //每页显示数据条数
                , groups: 3             //连续出现的页码数
                , theme: '#437be2'           //自定义主题颜色
                ,curr:currentPage             //当前页
                , jump: function (obj, first) {
                    //页码切换回调
                    if(!first){
                        //重新获取新分页数据
                        getNewsListPage(obj.curr);
                    }
                }
            });
        }
    });
</script>

</html>
