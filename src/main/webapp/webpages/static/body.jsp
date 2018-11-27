<%--
  Created by IntelliJ IDEA.
  User: YangYi
  Date: 2018/11/6
  Time: 19:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/context/mytags.jsp" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>首页内容</title>

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
<body id="" onload="IFrameResize()">

    <div id="carousel">
        <div class="layui-carousel all_scroll_map" id="carousel-body">
            <div carousel-item>
                <div style="background-image: url(${webRoot}/webpages/static/images/img_bg1.PNG)" class="scroll_map">
                        <div class="scrolls_map_text text-center">
                            <h1 class="myh1">梦  润，  知  识  从  未  如  此  有  趣</h1>
                            <h3 class="myh3">卓越人生，从梦润起航，梦润新世界 <a href="#" target="_blank">全新的学习方式</a></h3>
                            <p><a class="btn btn-primary btn-lg btn-learn" href="#">开 启 学 习！</a></p>
                        </div>
                </div>
                <div style="background-image: url(${webRoot}/webpages/static/images/img_bg3.PNG)" class="scroll_map">
                    <div class="scrolls_map_text text-center">
                        <h1 class="myh1">赋  能  人  才，从  这  里  开  始</h1>
                        <h3 class="myh3">卓越人生，从梦润起航，梦润新世界  <a href="#" target="_blank">全新的学习方式</a></h3>
                        <p><a class="btn btn-primary btn-lg btn-learn" href="#">开 启 学 习！</a></p>
                    </div>
                </div>
                <div style="background-image: url(${webRoot}/webpages/static/images/img_bg2.PNG)" class="scroll_map">
                    <div class="scrolls_map_text text-center">
                        <h1 class="myh1">梦  润， 最  新  潮  的  培  养  方  案</h1>
                        <h3 class="myh3">遇见梦润，遇见一个超乎想象的你   <a href="#" target="_blank">全新的学习方式</a></h3>
                        <p><a class="btn btn-primary btn-lg btn-learn" href="#">开 启 学 习！</a></p>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <!-- 新闻公告 -->
    <div id="fh5co-pricing" class="fh5co-bg-section">
        <div class="container">
            <div class="row animate-box">
                <div class="col-md-6 col-md-offset-3 text-center fh5co-heading">
                    <h2>新闻 &amp; 公告</h2>
                    <p>Dignissimos asperiores vitae velit veniam totam fuga molestias accusamus alias autem provident. Odit ab aliquam dolor eius.</p>
                </div>
            </div>
            <div class="row">
                <div class="pricing pricing--rabten">
                    <div class="col-md-6 animate-box">
                        <div class="pricing__item">
                            <div class="wrap-price">
                                <!-- <div class="icon icon-user2"></div> -->
                                <h3 class="pricing__title">新闻</h3>
                                <!-- <p class="pricing__sentence">Single user license</p> -->
                            </div>
                            <div class="pricing__price">
                        <span class="pricing__anim pricing__anim--1">
								<span class="pricing__currency"> &amp; </span>126
                        </span>
                                <span class="pricing__anim pricing__anim--2">
								<span class="pricing__period">条新闻</span>
                        </span>
                            </div>
                            <div class="wrap-price">
                                <ul class="pricing__feature-list">
                                    <a href="https://www.baidu.com/"><li class="pricing__feature">团泽镇妇女同胞们前往中国农民工文化陈列馆参观学习。</li></a>
                                    <a href="https://www.baidu.com/"><li class="pricing__feature">贵州省总工会到梦润集团参观学习</li></a>
                                    <a href="https://www.baidu.com/"><li class="pricing__feature">省林业厅副厅长孟广芹一行视察指导梦润集团</li></a>
                                    <a href=""><li class="pricing__feature">汇川区的梦润集团高人云集</li></a>
                                    <a href=""><li class="pricing__feature">脱贫攻坚群英谱，乡村振兴梦</li></a>
                                    <a href=""><li class="pricing__feature">汇川区的梦润集团高人云集</li></a>
                                    <a href=""><li class="pricing__feature">脱贫攻坚群英谱，乡村振兴梦</li></a>
                                </ul>
                                <a href="${webRoot}/webpages/static/allNews.jsp" >
                                    <button class="pricing__action"> 全部新闻</button>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 animate-box">
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
                                    <a href=""><li class="pricing__feature">公告1……</li></a>
                                    <a href=""><li class="pricing__feature">公告2……</li></a>
                                    <a href=""><li class="pricing__feature">公告3……</li></a>
                                    <a href=""><li class="pricing__feature">公告4……</li></a>
                                    <a href=""><li class="pricing__feature">公告5……</li></a>
                                    <a href=""><li class="pricing__feature">公告6……</li></a>
                                </ul>
                                <a href="${webRoot}/webpages/static/allNotice.jsp">
                                    <button class="pricing__action">全部公告</button>
                                </a>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <!-- 培训动态 -->
    <div id="fh5co-course">
        <div class="container">
            <div class="row animate-box">
                <div class="col-md-6 col-md-offset-3 text-center fh5co-heading">
                    <h2>培训动态</h2>
                    <p>Dignissimos asperiores vitae velit veniam totam fuga molestias accusamus alias autem provident. Odit ab aliquam dolor eius.</p>
                </div>
            </div>
            <div id="dynamic" class="row"></div>
            <div id="dynamic_pagination" class="text-center"></div>


        </div>

    </div>

    <!-- 广告 -->
    <div id="fh5co-course2">
        <div class="container">
            <div class="row animate-box">
                <div class="col-md-6 col-md-offset-3 text-center fh5co-heading">
                    <h2>相关 广告</h2>
                    <p>Dignissimos asperiores vitae velit veniam totam fuga molestias accusamus alias autem provident. Odit ab aliquam dolor eius.</p>
                </div>
            </div>
            <div class="col-md-12" style="background-image: url(${webRoot}/webpages/static/images/a1.PNG)">
                <h3 class="advertisement">我是广告1</h3>
            </div>

            <div class="col-md-12" style="height: 30px;"></div>

            <div class="col-md-12" style="background-image: url(${webRoot}/webpages/static/images/a2.PNG)">
                <h3 class="advertisement">我是广告2</h3>
            </div>

            <div class="col-md-12" style="height: 100px;"></div>


        </div>
    </div>

</body>

<script type="text/javascript">

    layui.use(['carousel','laypage'], function(){


        var carousel = layui.carousel;
        var laypage = layui.laypage;
        //建造实例
        carousel.render({
            elem: '#carousel-body'
            ,width: '100%' //设置容器宽度
            ,height:'600px'//设置容器高度
            ,arrow: 'always' //始终显示箭头
            ,anim: 'default' //切换动画方式
        });

        //执行一个laypage实例
        laypage.render({
            elem: 'dynamic_pagination'      //注意，这里的 test1 是 ID，不用加 # 号
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

        $(document).ready(function(){

            $.ajax({
                type: 'GET',
                url: "${webRoot}/trainingDynamic/listPage",
                data: {currentPage:1,rows:4},
                dataType: "json",
                success: function (data) {
                    var jsonData = eval(data);
                    var code = jsonData.code;
                    var msg = jsonData.msg;
                    if(code == 1){
                        var trainingDynamics = jsonData.data.items;
                        var dynamicsTotal = jsonData.data.total;

                        $.each(trainingDynamics,function (index,trainingDynamic) {
                            var id = trainingDynamic.id;
                            var title = trainingDynamic.title;
                            var content = trainingDynamic.content;
                            var imgs = trainingDynamic.imgs;
                            var remarks = trainingDynamic.remarks;
                            var createUserId = trainingDynamic.createUserId;
                            var createData = trainingDynamic.createData;
                            var updateUserId = trainingDynamic.updateUserId;
                            var updateData = trainingDynamic.updateData;

                            /*截取字符串，p标签里面的文字长度必须一样长，否则页面会乱码*/
                            if(content.length > 60 ){
                                content = content.substring(0,60);
                            }

                            var dynamic_div = ' <div class="col-md-6 animate-box"><div class="course"><a href="#" class="course-img" style="background-image: url('+imgs+');"></a>' +
                                '                        <div class="desc">' +
                                '                            <h3><a href="#">'+title+'</a></h3>' +
                                '                            <p>'+content+'</p>' +
                                '                            <span><a id="'+id+'" target="dynamic_a"  class="btn btn-primary btn-sm btn-course">&amp; 了解 更多</a></span>' +
                                '                        </div>' +
                                '                    </div>' +
                                '                </div>';


                            if (index == 0) {
                                $("#dynamic").html(dynamic_div);
                            }else {
                                $("#dynamic").append(dynamic_div);
                            }

                            $("a[target='dynamic_a']").on('click',function () {
                                //获取当前被点击的条数ID，携带ID跳转到动态培训详情页面
                                var dynamic_id = $(this).attr("id");
                                window.location.href = "dynamic.jsp?id="+dynamic_id+"";
                            });

                        });
                    }else {
                        $("#dynamic").html('<h3>暂无数据</h3>');
                    }
                }
            });

            //再次计算高度，包含ajax新增的数据流
            IFrameResize();
        });
    });

</script>

</html>
