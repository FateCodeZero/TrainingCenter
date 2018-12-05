<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/context/mytags.jsp" %>
<html>
<head>
    <title>梦润公告</title>

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
    <!-- 新闻公告 -->
    <div id="fh5co-pricing" class="fh5co-bg-section">
        <div class="container">
            <div class="row">
                <div class="pricing pricing--rabten">

                    <div class="col-md-6 animate-box">
                        <div class="pricing__item">
                            <div class="wrap-price">
                                <!-- <div class="icon icon-store"></div> -->
                                <h3 class="pricing__title">公告</h3>
                                <!-- <p class="pricing__sentence">Up to 5 users</p> -->
                            </div>
                            <div class="pricing__price">
                        <span id="noticeTotal" class="pricing__anim pricing__anim--1">
                        </span>
                                <span class="pricing__anim pricing__anim--2">
								<span class="pricing__period">条公告</span>
                        </span>
                            </div>
                            <div class="wrap-price">
                                <ul class="pricing__feature-list">
                                    <a id="notices"></a>
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

        $(document).ready(function loading(){
            getNotices();
            IFrameResize();
        });


        /*获取notices数据，完成DIV追加，返回总条数*/
        function getNotices(currentPage) {
            //首次加载，当前页为第一页时传入参数为空
            if (currentPage == null){
                currentPage = 1;
            }
            $.ajax({
                type: 'GET',
                url: "${webRoot}/annunciation/listPage",
                data: {currentPage:currentPage,rows:10},
                dataType: "json",
                success: function (data) {
                    var jsonData = eval(data);
                    var code = jsonData.code;
                    var msg = jsonData.msg;
                    if(code == 1){
                        var notice = jsonData.data.items;
                        var noticeTotal = Math.ceil((jsonData.data.total)/10);

                        $.each(notice,function (index,notices) {
                            var id = notices.id;
                            var notice_title = notices.title;
                            var noticeTotal = Math.ceil(jsonData.data.total);

                            if(notice_title.length > 25 ){
                                notice_title = notice_title.substring(0,25) +"…";
                            }

                            //alert("数据id:"+news_id+"标题："+news_title);
                            var noticeTotal_div = '<span class="pricing__currency"> &amp; </span>'+noticeTotal+'';
                            var notice_div = '<li id="'+id+'" target="noticeContent" class="pricing__feature">'+notice_title+'</li>';

                            if (index == 0) {
                                $("#notices").html(notice_div);
                            }else {
                                $("#notices").append(notice_div);
                            }
                            $("#noticeTotal").html(noticeTotal_div);

                            $("li[target='noticeContent']").on('click',function () {
                                //获取当前被点击的条数ID，携带ID跳转到新闻详情页面
                                var notice_id = $(this).attr("id");
                                window.location.href = "notice.jsp?id="+notice_id+"";
                            });

                        });
                        //生成分页
                        createlayPage(noticeTotal,currentPage);
                        //再次计算高度，包含ajax新增的数据流
                        IFrameResize();
                    }else {
                        $("#notices").html('<h3>暂无数据</h3>');
                    }
                }
            });
        }

        /*生成分页*/
        function createlayPage(noticeTotal,currentPage) {

            var laypage = layui.laypage;
            laypage.render({
                elem: 'notice_pagination'      //div的ID
                , count: noticeTotal        //数据总数，从服务端得到
                , limit: 1              //每页显示数据条数
                , groups: 3             //连续出现的页码数
                , theme: '#437be2'           //自定义主题颜色
                ,curr:currentPage             //当前页
                , jump: function (obj, first) {
                    //页码切换回调
                    if(!first){
                        //重新获取新分页数据
                        getNotices(obj.curr);
                    }

                }
            });
        }

        IFrameResize();
    });
</script>
</html>
