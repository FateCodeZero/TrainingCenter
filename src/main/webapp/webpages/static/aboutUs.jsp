
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/context/mytags.jsp" %>
<html>
<head>
    <title>关于我们</title>


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
    <script type="text/javascript" src="${webRoot}/plug-in/jquery-cookie/jquery.cookie.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/layui-v2.4.5/layui/layui.all.js"></script>
    <script type="text/javascript" src="${webRoot}/webpages/static/js/utils.js"></script>
</head>
<body onload="IFrameResize()">
    <div class="row">
        <div class="col-md-12 about_bg">
            <h1 class="col-md-12 text-center mytitle">梦 润 传 承</h1>
            <h4 class="col-md-12 text-center mytitle2">
                梦润，致力于让每个人都能公平和便利地获取优质教育服务，实现可持续职业成长
            </h4>
            <div class="col-md-10 col-md-offset-1">
                <div class="col-md-3">
                   <div class="col-md-10 col-md-offset-1 introduce bg1">
                       <a target="introduce1">
                       <img src="${webRoot}/webpages/static/images/introduce1.png" class="col-md-6 col-md-offset-3 introduce_img">
                       <h3 class="col-md-12 text-center" style="color: #FFFFFF; margin-top: 15px;">公司简介</h3>
                       </a>
                   </div>
                </div>
                <div class="col-md-3">
                    <div class="col-md-10 col-md-offset-1 introduce bg2">
                        <a target="introduce2">
                            <img src="${webRoot}/webpages/static/images/introduce2.png" class="col-md-6 col-md-offset-3 introduce_img">
                            <h3 class="col-md-12 text-center" style="color: #FFFFFF; margin-top: 15px;">红色文化</h3>
                            <h3 class="col-md-12 text-center" style="color: #FFFFFF; margin-top: 2px;">教学点</h3>
                        </a>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="col-md-10 col-md-offset-1 introduce bg3">
                        <a target="introduce3">
                            <img src="${webRoot}/webpages/static/images/introduce3.png" class="col-md-6 col-md-offset-3 introduce_img">
                            <h3 class="col-md-12 text-center" style="color: #FFFFFF; margin-top: 15px;">绿色发展</h3>
                            <h3 class="col-md-12 text-center" style="color: #FFFFFF; margin-top: 2px;">教学点</h3>
                        </a>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="col-md-10 col-md-offset-1 introduce bg4">
                        <a target="introduce4">
                            <img src="${webRoot}/webpages/static/images/introduce4.png" class="col-md-6 col-md-offset-3 introduce_img">
                            <h3 class="col-md-12 text-center" style="color: #FFFFFF; margin-top: 15px;">挂牌单位</h3>
                        </a>
                    </div>
                </div>
            </div>
        </div>


       <%-- 公司简介--%>
        <div id="introduce2" class="col-md-12 fh5co-bg-section" style="padding-top: 50px;">
            <div id="">
                <div class="container">
                    <div class="row animate-box">
                        <div class="col-md-8 col-md-offset-2 text-center fh5co-heading">
                            <h2>  公司&amp;简介 </h2>
                            <p>Dignissimos asperiores vitae velit veniam totam fuga molestias accusamus alias autem provident. Odit ab aliquam dolor eius.</p>
                        </div>
                    </div>
                    <div class="row">
                        <div id="company" style="height:12%"></div>
                    </div>
                </div>
            </div>
        </div>


        <%--红色历史文化教学点--%>
        <div id="introduce2" class="col-md-12">
            <div id="fh5co-staff">
                <div class="container">
                    <div class="row animate-box">
                        <div class="col-md-8 col-md-offset-2 text-center fh5co-heading">
                            <h2> &amp; 红色历史文化教学点&amp; </h2>
                            <p>Dignissimos asperiores vitae velit veniam totam fuga molestias accusamus alias autem provident. Odit ab aliquam dolor eius.</p>
                        </div>
                    </div>
                    <div class="row">
                        <div id="culturalTeachingPoint" ></div>
                    </div>
                </div>
            </div>
        </div>


        <%--绿色发展教学点--%>
        <div id="introduce3" class="col-md-12 fh5co-bg-section">
            <div>
                <div class="container" style="margin-top: 150px;">
                    <div class="row animate-box">
                        <div class="col-md-8 col-md-offset-2 text-center fh5co-heading">
                            <h2> &amp; 绿色发展教学点&amp; </h2>
                            <p>Dignissimos asperiores vitae velit veniam totam fuga molestias accusamus alias autem provident. Odit ab aliquam dolor eius.</p>
                        </div>
                    </div>
                    <div class="row">
                        <div id="developTeachingPoint"></div>
                    </div>
                </div>
            </div>
        </div>

        <%--挂牌单位--%>
        <div id="introduce4" class="col-md-12 " style="margin-top: 150px;">
            <div class="container">
                <div class="row animate-box">
                    <div class="col-md-8 col-md-offset-2 text-center fh5co-heading">
                        <h2>挂牌 &amp; 单位</h2>
                        <p>Dignissimos asperiores vitae velit veniam totam fuga molestias accusamus alias autem provident. Odit ab aliquam dolor eius.</p>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <img src="${webRoot}/webpages/static/images/cooperate_company.png">
                    </div>

                </div>
            </div>
            <div class="col-md-12" style="height: 150px; background-color: #FFFFFF"></div>
        </div>
    </div>


</body>

<script>

        $(document).ready(function loading(){
            getCompanyIntroduction();
            getRedHistory();
            getGreenDevelopment();
            IFrameResize();
            getDivScroll();
        });

        /*获取目录块点击跳转*/
        function getDivScroll() {
            $("a[target='introduce1']").on('click',function () {
                document.getElementById("introduce1").scrollIntoView();
            });
            $("a[target='introduce2']").on('click',function () {
                document.getElementById("introduce2").scrollIntoView();
            });
            $("a[target='introduce3']").on('click',function () {
                document.getElementById("introduce3").scrollIntoView();
            });
            $("a[target='introduce4']").on('click',function () {
                document.getElementById("introduce4").scrollIntoView();
            });

        }


        /*获取公司简介*/
        function getCompanyIntroduction() {

            $.ajax({
                type: 'GET',
                url: "${webRoot}/aboutMe/listPage",
                data:{
                    currentPage:1,
                    rows:1,
                    condition: JSON.stringify({searchContent: ''})
                },
                dataType: "json",
                success:function (data) {
                    var jsonData = eval(data);
                    var code = jsonData.code;
                    var msg = jsonData.msg;

                    if(code === 1){
                        var company = jsonData.data.items;
                        $.each(company,function (index,companyOne) {

                            var id = companyOne.id;
                            var title = companyOne.title;
                            var content = companyOne.content;
                            var imgs = companyOne.imgs;

                            var details_div = '<div class="col-md-6 animate-box">\n' +
                                '                    <span>Company introduce</span>\n' +
                                '                    <h2 >'+title+'</h2>\n' +
                                '                    <p>'+content+'</p>\n' +
                                '                </div>\n' +
                                '                <div class="col-md-6 img_height">\n' +
                                '                    <img class="img-responsive" src="'+imgs+'" >\n' +
                                '                </div>';

                            $("#company").html(details_div);
                            IFrameResize();

                        });

                    }else {
                        $("#company").html('<h3 class="col-md-12 text-center">'+msg+'</h3>');
                    }

                }
                , error: function (jqXHR, textStatus, errorThrown) {
                    ajaxErrorHandler(jqXHR); //ajax请求异常统一处理
                }
            })
        }


        //获取红色历史文化教学点
        function getRedHistory(){

            $.ajax({
                type: 'GET',
                url: "${webRoot}/culturalTeachingPoint/listPage",
                data: {currentPage:1,
                        rows:4,
                        condition: JSON.stringify({searchContent: ''})
                },
                dataType: "json",
                success: function (data) {
                    var jsonData = eval(data);
                    var code = jsonData.code;
                    var msg = jsonData.msg;
                    if(code === 1){
                        var redPoints = jsonData.data.items;

                        if(redPoints.length === 0){
                            $("#culturalTeachingPoint").html('<h3 class="col-md-12 text-center">'+msg+'</h3>');
                        }

                        $.each(redPoints,function (index,redPoint) {
                            var id = redPoint.id;
                            var title = redPoint.title;
                            var content = redPoint.content;
                            var imgs = redPoint.imgs;

                            /*截取字符串，p标签里面的文字长度必须一样长，否则页面会乱码*/
                            if(content.length > 60 ){
                                content = content.substring(0,60);
                            }
                            var red_div = '<div id="'+id+'" class="col-md-3 animate-box text-center">\n' +
                                '                            <div class="staff">\n' +
                                '                                <div class="staff-img" style="background-image: url('+imgs+');">\n' +
                                '                                    <ul class="fh5co-social">\n' +
                                '                                        <li><a href="#"><i class="icon-facebook2"></i></a></li>\n' +
                                '                                        <li><a href="#"><i class="icon-twitter2"></i></a></li>\n' +
                                '                                        <li><a href="#"><i class="icon-dribbble2"></i></a></li>\n' +
                                '                                        <li><a href="#"><i class="icon-github"></i></a></li>\n' +
                                '                                    </ul>\n' +
                                '                                </div>\n' +
                                '                                <span>Health Teacher</span>\n' +
                                '                                <h3><a href="#">'+title+'</a></h3>\n' +
                                '                                <p>'+content+'</p>\n' +
                                '                            </div>\n' +
                                '                        </div>';


                            if (index == 0) {
                                $("#culturalTeachingPoint").html(red_div);
                            }else {
                                $("#culturalTeachingPoint").append(red_div);
                            }
                        });
                        //再次计算高度，包含ajax新增的数据流
                        IFrameResize();
                    }else {
                        $("#culturalTeachingPoint").html('<h3 class="col-md-12 text-center">'+msg+'</h3>');
                    }
                }
                , error: function (jqXHR, textStatus, errorThrown) {
                    ajaxErrorHandler(jqXHR); //ajax请求异常统一处理
                }
            });

        }


        /*获取绿色发展教学点*/
        function getGreenDevelopment() {
            $.ajax({
                type: 'GET',
                url: "${webRoot}/developTeachingPoint/listPage",
                data: {currentPage:1,
                    rows:4,
                    condition: JSON.stringify({searchContent: ''})
                },
                dataType: "json",
                success: function (data) {
                    var jsonData = eval(data);
                    var code = jsonData.code;
                    var msg = jsonData.msg;
                    if(code === 1){
                        var greenPoints = jsonData.data.items;

                        if(greenPoints.length === 0){
                            $("#culturalTeachingPoint").html('<h3 class="col-md-12 text-center">'+msg+'</h3>');
                        }

                        $.each(greenPoints,function (index,greenPoint) {
                            var id = greenPoint.id;
                            var title = greenPoint.title;
                            var content = greenPoint.content;
                            var imgs = greenPoint.imgs;

                            /*截取字符串，p标签里面的文字长度必须一样长，否则页面会乱码*/
                            if(content.length > 60 ){
                                content = content.substring(0,60);
                            }
                            var green_div = '<div id="'+id+'" class="col-md-3 animate-box text-center">\n' +
                                '                            <div class="staff">\n' +
                                '                                <div class="staff-img" style="background-image: url('+imgs+');">\n' +
                                '                                    <ul class="fh5co-social">\n' +
                                '                                        <li><a href="#"><i class="icon-facebook2"></i></a></li>\n' +
                                '                                        <li><a href="#"><i class="icon-twitter2"></i></a></li>\n' +
                                '                                        <li><a href="#"><i class="icon-dribbble2"></i></a></li>\n' +
                                '                                        <li><a href="#"><i class="icon-github"></i></a></li>\n' +
                                '                                    </ul>\n' +
                                '                                </div>\n' +
                                '                                <span>Health Teacher</span>\n' +
                                '                                <h3><a href="#">'+title+'</a></h3>\n' +
                                '                                <p>'+content+'</p>\n' +
                                '                            </div>\n' +
                                '                        </div>';


                            if (index === 0) {
                                $("#developTeachingPoint").html(green_div);
                            }else {
                                $("#developTeachingPoint").append(green_div);
                            }
                        });
                        //再次计算高度，包含ajax新增的数据流
                        IFrameResize();
                    }else {
                        $("#developTeachingPoint").html('<h3 class="col-md-12 text-center">'+msg+'</h3>');
                    }
                }
                , error: function (jqXHR, textStatus, errorThrown) {
                    ajaxErrorHandler(jqXHR); //ajax请求异常统一处理
                }
            });
        }
        IFrameResize();

</script>
</html>
