<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/context/mytags.jsp" %>
<html>
<head>
    <title>梦润公告</title>

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
    <!-- 新闻公告 -->
    <div id="fh5co-pricing" class="fh5co-bg-section">
        <div class="container">
            <div class="row">
                <div class="pricing pricing--rabten">

                    <div class="col-md-10  animate-box">
                        <div class="pricing__item">
                            <div class="wrap-price">
                                <!-- <div class="icon icon-store"></div> -->
                                <h3 class="pricing__title">公告</h3>
                                <!-- <p class="pricing__sentence">Up to 5 users</p> -->
                            </div>
                            <div class="pricing__price">
                            <span class="pricing__anim pricing__anim--1">
                                    <span class="pricing__currency"> &amp; </span>79
                            </span>
                                <span class="pricing__anim pricing__anim--2">
                                    <span class="pricing__period">条公告</span>
                            </span>
                            </div>
                            <div class="wrap-price">
                                <ul class="pricing__feature-list">
                                    <a href=""><li class="pricing__feature">获得全国森林康养基地试点建设基地</li></a>
                                    <a href=""><li class="pricing__feature">公告2……</li></a>
                                    <a href=""><li class="pricing__feature">公告3……</li></a>
                                    <a href=""><li class="pricing__feature">公告4……</li></a>
                                    <a href=""><li class="pricing__feature">公告5……</li></a>
                                    <a href=""><li class="pricing__feature">公告6……</li></a>
                                    <a href=""><li class="pricing__feature">公告7……</li></a>
                                    <a href=""><li class="pricing__feature">公告8……</li></a>
                                    <a href=""><li class="pricing__feature">公告9……</li></a>
                                    <a href=""><li class="pricing__feature">公告10……</li></a>
                                </ul>
                                <div id="notice_pagination"></div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>


</body>
<script>







    //使用 layui 分页模块
    layui.use('laypage', function () {
        var laypage = layui.laypage;


        //执行一个laypage实例
        laypage.render({
            elem: 'notice_pagination'      //注意，这里的 test1 是 ID，不用加 # 号
            , count: 200        //数据总数，从服务端得到
            , limit: 10              //每页显示数据条数
            , limits: [4, 8, 16, 32, 64]
            , groups: 3             //连续出现的页码数
            , theme: '#437be2'           //自定义主题颜色
            , jump: function (obj, first) {    //页码切换回调
                //obj包含了当前分页的所有参数，比如：
//                console.log(obj.curr); //得到当前页，以便向服务端请求对应页的数据。
//                console.log(obj.limit); //得到每页显示的条数


            }
        });



    });
</script>
</html>
