<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/context/mytags.jsp" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>梦润首页</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Free HTML5 Website Template by freehtml5.co"/>
    <meta name="keywords"
          content="free website templates, free html5, free template, free bootstrap, free website template, html5, css3, mobile first, responsive"/>


    <!-- Facebook and Twitter integration -->
    <meta property="og:title" content=""/>
    <meta property="og:image" content=""/>
    <meta property="og:url" content=""/>
    <meta property="og:site_name" content=""/>
    <meta property="og:description" content=""/>
    <meta name="twitter:title" content=""/>
    <meta name="twitter:image" content=""/>
    <meta name="twitter:url" content=""/>
    <meta name="twitter:card" content=""/>

    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Roboto+Slab:300,400" rel="stylesheet">
    <link rel="stylesheet" href="${webRoot}/plug-in/css/animate.css">
    <link rel="stylesheet" href="${webRoot}/plug-in/css/icomoon.css">
    <link rel="stylesheet" href="${webRoot}/plug-in/css/bootstrap.css">
    <link rel="stylesheet" href="${webRoot}/plug-in/css/magnific-popup.css">
    <link rel="stylesheet" href="${webRoot}/plug-in/css/owl.carousel.min.css">
    <link rel="stylesheet" href="${webRoot}/plug-in/css/owl.theme.default.min.css">
    <link rel="stylesheet" href="${webRoot}/plug-in/css/flexslider.css">
    <link rel="stylesheet" href="${webRoot}/plug-in/css/pricing.css">
    <link rel="stylesheet" href="${webRoot}/plug-in/css/style.css">
    <link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/css/mr_home.css">

    <%--jQuery--%>
    <script src="${webRoot}/plug-in/jquery-3.2.1/jquery-3.2.1.min.js"></script>
    <%--BootStrap--%>
    <link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/bootstrap3.3.5/css/bootstrap.min.css">
    <script src="${webRoot}/plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
    <%--layui--%>
    <link rel="stylesheet" type="text/css" href="${webRoot}/plug-in/layui-v2.3.0/layui/css/layui.css">
    <script src="${webRoot}/plug-in/layui-v2.3.0/layui/layui.all.js"></script>

    <script src="${webRoot}/plug-in/js/modernizr-2.6.2.min.js"></script>


</head>
<body>

<div class="fh5co-loader"></div>

<div id="page">
    <nav class="fh5co-nav" role="navigation">

        <div class="top-menu" name="top-menu">
            <div class="container">
                <div class="row">
                    <div class="col-xs-1">
                        <div id="fh5co-logo"><a href="index.jsp"><i class="icon-study"></i>Educ<span>.</span></a></div>
                    </div>
                    <div class="col-xs-4">
                        <input id="search_box" class="col-xs-10 search_box_css" type="text" placeholder="请输入搜索关键字">
                        <input id="search_sub " class="col-xs-2 search_sub_css" type="image" value=" ">
                    </div>
                    <div class="col-xs-7 text-right menu-1">
                        <ul>
                            <li class="active"><a href="index.jsp">首页</a></li>
                            <li><a href="${webRoot}/WEB-INF/pages/courses.jsp">特色课程</a></li>
                            <li><a href="${webRoot}/WEB-INF/pages/teacher.jsp">学员风采</a></li>
                            <li><a href="${webRoot}/WEB-INF/pages/about.jsp">公司简介</a></li>
                            <li class="has-dropdown">
                                <a href="${webRoot}/WEB-INF/pages/blog.jsp">行程配置</a>
                                <ul class="dropdown">
                                    <li><a href="#">Web Design</a></li>
                                    <li><a href="#">eCommerce</a></li>
                                    <li><a href="#">Branding</a></li>
                                    <li><a href="#">API</a></li>
                                </ul>
                            </li>
                            <li><a href="${webRoot}/WEB-INF/pages/contact.jsp">留言咨询</a></li>
                            <c:if test="${empty user}">
                                <li class="btn-cta"><a href="#a_login"><span>登录/注册</span></a></li>
                            </c:if>
                            <c:if test="${not empty user}">
                                <li class="has-dropdown">
                                    <a href="">${user.nickname}</a>
                                    <ul class="dropdown">
                                        <li><a href="#">Web Design</a></li>
                                        <li><a href="#">eCommerce</a></li>
                                        <li><a href="#">Branding</a></li>
                                        <li><a href="${webRoot}/loginInfo/logout">退出</a></li>
                                    </ul>
                                </li>
                            </c:if>
                        </ul>
                    </div>
                </div>

            </div>
        </div>
    </nav>

    <aside id="fh5co-hero">
        <div class="flexslider">
            <ul class="slides">
                <li style="background-image: url(${webRoot}/plug-in/images/img_bg_1.jpg);">
                    <div class="overlay-gradient"></div>
                    <div class="container">
                        <div class="row">
                            <div class="col-md-8 col-md-offset-2 text-center slider-text">
                                <div class="slider-text-inner">
                                    <h1>The Roots of Education are Bitter, But the Fruit is Sweet</h1>
                                    <h2>Brought to you by <a href="#" target="_blank">freehtml5.co</a></h2>
                                    <p><a class="btn btn-primary btn-lg" href="#">Start Learning Now!</a></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
                <li style="background-image: url(${webRoot}/plug-in/images/img_bg_2.jpg);">
                    <div class="overlay-gradient"></div>
                    <div class="container">
                        <div class="row">
                            <div class="col-md-8 col-md-offset-2 text-center slider-text">
                                <div class="slider-text-inner">
                                    <h1>The Great Aim of Education is not Knowledge, But Action</h1>
                                    <h2>Brought to you by <a href="#" target="_blank">freehtml5.co</a></h2>
                                    <p><a class="btn btn-primary btn-lg btn-learn" href="#">Start Learning Now!</a></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
                <li style="background-image: url(${webRoot}/plug-in/images/img_bg_3.jpg);">
                    <div class="overlay-gradient"></div>
                    <div class="container">
                        <div class="row">
                            <div class="col-md-8 col-md-offset-2 text-center slider-text">
                                <div class="slider-text-inner">
                                    <h1>We Help You to Learn New Things</h1>
                                    <h2>Brought to you by <a href="#" target="_blank">freehtml5.co</a></h2>
                                    <p><a class="btn btn-primary btn-lg btn-learn" href="#">Start Learning Now!</a></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
    </aside>


    <!-- 新闻公告 -->
    <div class="copyrights">Collect from <a href="http://www.cssmoban.com/" title="网站模板">网站模板</a></div>

    <div id="fh5co-pricing" class="fh5co-bg-section">
        <div class="container">
            <div class="row animate-box">
                <div class="col-md-6 col-md-offset-3 text-center fh5co-heading">
                    <h2>新闻 &amp; 公告</h2>
                    <p>Dignissimos asperiores vitae velit veniam totam fuga molestias accusamus alias autem provident.
                        Odit ab aliquam dolor eius.</p>
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
								<span class="pricing__currency">*</span>126
                        </span>
                                <span class="pricing__anim pricing__anim--2">
								<span class="pricing__period">条新闻</span>
                        </span>
                            </div>
                            <div class="wrap-price">
                                <ul class="pricing__feature-list">
                                    <a href="https://www.baidu.com/">
                                        <li class="pricing__feature">One Day Trial</li>
                                    </a>
                                    <a href="https://www.baidu.com/">
                                        <li class="pricing__feature">Limited Courses</li>
                                    </a>
                                    <a href="https://www.baidu.com/">
                                        <li class="pricing__feature">Free 3 Lessons</li>
                                    </a>
                                    <a href="">
                                        <li class="pricing__feature">No Supporter</li>
                                    </a>
                                    <a href="">
                                        <li class="pricing__feature">No Tutorial</li>
                                    </a>
                                    <a href="">
                                        <li class="pricing__feature">No Ebook</li>
                                    </a>
                                    <a href="">
                                        <li class="pricing__feature">Limited Registered User</li>
                                    </a>
                                </ul>
                                <button class="pricing__action">下一页</button>
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
								<span class="pricing__currency">$</span>79
                        </span>
                                <span class="pricing__anim pricing__anim--2">
								<span class="pricing__period">per year</span>
                        </span>
                            </div>
                            <div class="wrap-price">
                                <ul class="pricing__feature-list">
                                    <li class="pricing__feature">One Year Standard Access</li>
                                    <li class="pricing__feature">Limited Courses</li>
                                    <li class="pricing__feature">300+ Lessons</li>
                                    <li class="pricing__feature">Random Supporter</li>
                                    <li class="pricing__feature">View Only Ebook</li>
                                    <li class="pricing__feature">Standard Tutorials</li>
                                    <li class="pricing__feature">Unlimited Registered User</li>
                                </ul>
                                <button class="pricing__action">Choose plan</button>
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
                    <p>Dignissimos asperiores vitae velit veniam totam fuga molestias accusamus alias autem provident.
                        Odit ab aliquam dolor eius.</p>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 animate-box">
                    <div class="course">
                        <a href="#" class="course-img"
                           style="background-image: url(${webRoot}/plug-in/images/project-1.jpg);">
                        </a>
                        <div class="desc">
                            <h3><a href="#">Web Master</a></h3>
                            <p>Dignissimos asperiores vitae velit veniam totam fuga molestias accusamus alias autem
                                provident. Odit ab aliquam dolor eius molestias accusamus alias autem provident. Odit ab
                                aliquam dolor eius.</p>
                            <span><a href="#" class="btn btn-primary btn-sm btn-course">Take A Course</a></span>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 animate-box">
                    <div class="course">
                        <a href="#" class="course-img"
                           style="background-image: url(${webRoot}/plug-in/images/project-2.jpg);">
                        </a>
                        <div class="desc">
                            <h3><a href="#">Business &amp; Accounting</a></h3>
                            <p>Dignissimos asperiores vitae velit veniam totam fuga molestias accusamus alias autem
                                provident. Odit ab aliquam dolor eius molestias accusamus alias autem provident. Odit ab
                                aliquam dolor eius.</p>
                            <span><a href="#" class="btn btn-primary btn-sm btn-course">Take A Course</a></span>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 animate-box">
                    <div class="course">
                        <a href="#" class="course-img"
                           style="background-image: url(${webRoot}/plug-in/images/project-3.jpg);">
                        </a>
                        <div class="desc">
                            <h3><a href="#">Science &amp; Technology</a></h3>
                            <p>Dignissimos asperiores vitae velit veniam totam fuga molestias accusamus alias autem
                                provident. Odit ab aliquam dolor eius molestias accusamus alias autem provident. Odit ab
                                aliquam dolor eius.</p>
                            <span><a href="#" class="btn btn-primary btn-sm btn-course">Take A Course</a></span>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 animate-box">
                    <div class="course">
                        <a href="#" class="course-img"
                           style="background-image: url(${webRoot}/plug-in/images/project-4.jpg);">
                        </a>
                        <div class="desc">
                            <h3><a href="#">Health &amp; Psychology</a></h3>
                            <p>Dignissimos asperiores vitae velit veniam totam fuga molestias accusamus alias autem
                                provident. Odit ab aliquam dolor eius molestias accusamus alias autem provident. Odit ab
                                aliquam dolor eius.</p>
                            <span><a href="#" class="btn btn-primary btn-sm btn-course">Take A Course</a></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%--登录成功后隐藏--%>
    <c:if test="${empty user}">
        <!-- 登录注册 -->
        <div class="row animate-box">
            <div class="col-md-6 col-md-offset-3 text-center fh5co-heading">
                <h2>登陆与注册</h2>
                <p>Dignissimos asperiores vitae velit veniam totam fuga molestias accusamus alias autem provident. Odit
                    ab
                    aliquam dolor eius.</p>
            </div>
        </div>
        <div id="fh5co-register" style="background-image: url(${webRoot}/plug-in/images/img_bg_2.jpg);">
            <a name="a_login" target="_blank"></a>
            <div class="overlay"></div>
            <div class="row">
                <br>
                <div class="col-md-6">
                    <div class="col-md-1"></div>
                    <div class="col-md-10 news_box">
                        <h3 class="col-md-2 col-md-offset-5">登录</h3>
                        <input type="text" id="user_name" placeholder="请输入用户名"
                               class="col-md-10 col-md-offset-1 input_css"
                               value="">
                        <div id="user_name_msg"></div>
                        <input type="password" id="user_pwd" placeholder="请输入密码"
                               class="col-md-10 col-md-offset-1 input_css"
                               value="">
                        <div id="user_pwd_msg"></div>
                        <input type="text" id="v_code" placeholder="请输入验证码" class="col-md-5 col-md-offset-1 input_css"
                               value="">
                        <div id="v_code_msg"></div>
                        <img id='imgVcode' class="col-md-4 col-md-offset-1 v_code_css"
                             src="${webRoot}/plug-in/images/v_code.png"/>
                        <p><a id="login_submit" href="#"
                              class="col-md-5 col-md-offset-6 btn btn-primary btn-lg btn-reg login_css">登录</a></p>
                    </div>
                    <div class="col-md-1"></div>
                </div>
                <div class="col-md-6">
                    <div class="col-md-1"></div>
                    <div class="col-md-10 news_box">
                        <h3 class="col-md-2 col-md-offset-5">注册</h3>
                        <input type="text" id="r_name" placeholder="请输入用户名" class="col-md-10 col-md-offset-1 input_css"
                               value="">
                        <div id="r_name_msg"></div>
                        <input type="password" id="r_pwd" placeholder="请输入密码"
                               class="col-md-10 col-md-offset-1 input_css"
                               value="">
                        <div id="r_pwd_msg"></div>
                        <input type="password" id="r_pwd_confirm" placeholder="确认密码"
                               class="col-md-10 col-md-offset-1 input_css" value="">
                        <div id="r_pwd_confirm_msg"></div>
                        <p><a href="#" class="col-md-5 col-md-offset-6 btn btn-primary btn-lg btn-reg login_css"
                              id="register_submit">提交</a></p>
                    </div>
                    <div class="col-md-1"></div>
                </div>

            </div>
        </div>
    </c:if>


    <!-- 广告 -->
    <div class="row animate-box">
        <div class="col-md-6 col-md-offset-3 text-center fh5co-heading">
            <h2>广告</h2>
            <p>Dignissimos asperiores vitae velit veniam totam fuga molestias accusamus alias autem provident. Odit ab
                aliquam dolor eius.</p>
        </div>
    </div>

    <div id="fh5co-gallery" class="fh5co-bg-section">
        <!-- 		<div class="row text-center">
            <h2><span>广告</span></h2>
        </div> -->
        <div class="row">
            <div class="col-md-3 col-padded">
                <a href="#" class="gallery" style="background-image: url(${webRoot}/plug-in/images/project-5.jpg);"></a>
            </div>
            <div class="col-md-3 col-padded">
                <a href="#" class="gallery" style="background-image: url(${webRoot}/plug-in/images/project-2.jpg);"></a>
            </div>
            <div class="col-md-3 col-padded">
                <a href="#" class="gallery" style="background-image: url(${webRoot}/plug-in/images/project-3.jpg);"></a>
            </div>
            <div class="col-md-3 col-padded">
                <a href="#" class="gallery" style="background-image: url(${webRoot}/plug-in/images/project-4.jpg);"></a>
            </div>
        </div>
    </div>


    <!-- 关于我们 -->
    <footer id="fh5co-footer" role="contentinfo" style="background-image: url(${webRoot}/plug-in/images/img_bg_4.jpg);">
        <div class="overlay"></div>
        <div class="container">
            <div class="row row-pb-md">
                <div class="col-md-3 fh5co-widget">
                    <h3>关于我们</h3>
                    <p>梦润目标：发展五百年！
                        梦润精神：敢打硬仗，敢打恶仗，保证打赢！
                        梦润发展要求：硬要发展才是大道理！发展不忘世代根：立足家乡报春晖。</p>
                </div>
                <div class="col-md-2 col-sm-4 col-xs-6 col-md-push-1 fh5co-widget">
                    <h3>-课程-</h3>
                    <ul class="fh5co-footer-links">
                        <li><a href="#">Course</a></li>
                        <li><a href="#">Blog</a></li>
                        <li><a href="#">Contact</a></li>
                        <li><a href="#">Terms</a></li>
                        <li><a href="#">Meetups</a></li>
                    </ul>
                </div>

                <div class="col-md-2 col-sm-4 col-xs-6 col-md-push-1 fh5co-widget">
                    <h3>Learn &amp; Grow</h3>
                    <ul class="fh5co-footer-links">
                        <li><a href="#">Blog</a></li>
                        <li><a href="#">Privacy</a></li>
                        <li><a href="#">Testimonials</a></li>
                        <li><a href="#">Handbook</a></li>
                        <li><a href="#">Held Desk</a></li>
                    </ul>
                </div>

                <div class="col-md-2 col-sm-4 col-xs-6 col-md-push-1 fh5co-widget">
                    <h3>Engage us</h3>
                    <ul class="fh5co-footer-links">
                        <li><a href="#">Marketing</a></li>
                        <li><a href="#">Visual Assistant</a></li>
                        <li><a href="#">System Analysis</a></li>
                        <li><a href="#">Advertise</a></li>
                    </ul>
                </div>

                <div class="col-md-2 col-sm-4 col-xs-6 col-md-push-1 fh5co-widget">
                    <h3>Legal</h3>
                    <ul class="fh5co-footer-links">
                        <li><a href="#">Find Designers</a></li>
                        <li><a href="#">Find Developers</a></li>
                        <li><a href="#">Teams</a></li>
                        <li><a href="#">Advertise</a></li>
                        <li><a href="#">API</a></li>
                    </ul>
                </div>
            </div>

            <div class="row copyright">
                <div class="col-md-12 text-center">
                    <p>
                        <small class="block">&copy; 2018 FateCode项目组出品 遵义市梦润培训中心 官方网页 欢迎关注我们 <a
                                href="http://www.cssmoban.com/" target="_blank" title="模板之家">梦润课程</a> - 梦润之家 <a
                                href="http://www.cssmoban.com/" title="网页模板" target="_blank">梦润风采</a> &amp; <a
                                href="https://www.pexels.com/" target="_blank">梦润团队</a></small>
                    </p>
                </div>
            </div>

        </div>
    </footer>
</div>

<div class="gototop js-top">
    <a href="#" class="js-gotop"><i class="icon-arrow-up"></i></a>
</div>

</body>
<!-- jQuery -->
<script src="${webRoot}/plug-in/js/jquery.min.js"></script>
<!-- jQuery Easing -->
<script src="${webRoot}/plug-in/js/jquery.easing.1.3.js"></script>
<!-- Bootstrap -->
<script src="${webRoot}/plug-in/js/bootstrap.min.js"></script>
<!-- Waypoints -->
<script src="${webRoot}/plug-in/js/jquery.waypoints.min.js"></script>
<!-- Stellar Parallax -->
<script src="${webRoot}/plug-in/js/jquery.stellar.min.js"></script>
<!-- Carousel -->
<script src="${webRoot}/plug-in/js/owl.carousel.min.js"></script>
<!-- Flexslider -->
<script src="${webRoot}/plug-in/js/jquery.flexslider-min.js"></script>
<!-- countTo -->
<script src="${webRoot}/plug-in/js/jquery.countTo.js"></script>
<!-- Magnific Popup -->
<script src="${webRoot}/plug-in/js/jquery.magnific-popup.min.js"></script>
<script src="${webRoot}/plug-in/js/magnific-popup-options.js"></script>
<!-- Count Down -->
<script src="${webRoot}/plug-in/js/simplyCountdown.js"></script>
<!-- Main -->
<script src="${webRoot}/plug-in/js/main.js"></script>
<script src="${webRoot}/plug-in/js/index.js"></script>

<script src="${webRoot}/plug-in/layui-v2.3.0/layui/layui.all.js"></script>

<script type="text/javascript">
    var d = new Date(new Date().getTime() + 1000 * 120 * 120 * 2000);

    // default example
    //    simplyCountdown('.simply-countdown-one', {
    //        year: d.getFullYear(),
    //        month: d.getMonth() + 1,
    //        day: d.getDate()
    //    });

    //jQuery example
    $('#simply-countdown-losange').simplyCountdown({
        year: d.getFullYear(),
        month: d.getMonth() + 1,
        day: d.getDate(),
        enableUtc: false
    });

    $(document).ready(function () {
        //页面加载完成
        //……
    });

    //检查用户名是否可用
    $("#r_name").blur(function () {
        var username = $("#r_name").val();
        if (username == null || username == "") {
            $("#r_name_msg").html(
                "<span style='color:#FF5722'>用户名不能为空！</span>"
            );
            $("#r_name").css("border", "1px solid red");  //输入框变红
            $("#r_name").focus();

            return false;
        } else {
            checkUsername(username);
        }

    });

    //检查用户名是否可用
    function checkUsername(username) {
        //Restful风格的get请求
        var data = {
            _method:"GET"
        };
        $.ajax({
            url: "${webRoot}/loginInfo/usernameCheck/" + username,
            type: "get",
            data: data,
            dataType: "json",
            success: function (data) {
                var jsonData = eval(data);
                var code = jsonData.code;
                var msg = jsonData.msg;
                if (code == 1) {
                    $("#r_name_msg").html(
                        "<span style='color:#009688'>" + msg + "</span>"
                    );
                    $("#r_name").css("border", "1px solid #009688");
                } else {
                    $("#r_name_msg").html(
                        "<span style='color:#FF5722'>" + msg + "</span>"
                    );
                    $("#r_name").css("border", "1px solid red");  //输入框变红
                }
            }
        });
    }

    //登录
    $("#login_submit").click(function () {
        var username = $("#user_name").val();
        var password = $("#user_pwd").val();
        var v_code = $("#v_code").val();

        if (username == null || username == "") {
            $("#user_name_msg").html(
                "<span style='color:#FF5722'>用户名不能为空！</span>"
            );
            $("#user_name").css("border", "1px solid red");  //输入框变红
            $("#user_name").focus();
            return false;
        } else {
            $("#user_name").css("border", "1px solid #009688");
        }

        if (password == null || password == "") {
            $("#user_pwd_msg").html(
                "<span style='color:#FF5722'>密码不能为空！</span>"
            );
            $("#user_pwd").css("border", "1px solid red");  //输入框变红
            $("#user_pwd").focus();
            return false;
        } else {
            $("#user_pwd").css("border", "1px solid #009688");
        }

        if (v_code == null || v_code == "") {
            $("#v_code_msg").html(
                "<span style='color:#FF5722'>密码不能为空！</span>"
            );
            $("#v_code").css("border", "1px solid red");  //输入框变红
            $("#v_code").focus();
            return false;
        } else {
            $("#v_code").css("border", "1px solid #009688");
        }

        //Restful风格的Post请求
        var data = {
            _method: "POST",
            username: username,
            password: password,
            v_code: v_code
        };

        $.ajax({
            url: "${webRoot}/loginInfo/login",
            type: "post",
            data: data,
            dataType: "json",
            success: function (data) {
                var jsonData = eval(data);   //数据解析
                var code = jsonData.code;
                var msg = jsonData.msg;

                if (code == 1) {
                    layer.alert(msg, {
                        time: 3000,
                        icon: 1
                    });
                    location.reload();  //刷新当前页面
                } else {
                    layer.alert(msg, {
                        time: 3000,
                        icon: 2
                    });
                }
                window.location.href = "/index.jsp#top-menu";   //定位到顶部
            }
        });
    });

    //注册
    $("#register_submit").click(function () {
        var username = $("#r_name").val();
        var password = $("#r_pwd").val();
        var re_password = $("#r_pwd_confirm").val();

        if (username == null || username == "") {
            $("#r_name_msg").html(
                "<span style='color:#FF5722'>用户名不能为空！</span>"
            );
            $("#r_name").css("border", "1px solid red");  //输入框变红
            $("#r_name").focus();
            return false;
        } else {
            $("#r_name").css("border", "1px solid #009688");
        }

        if (password == null || password == "") {
            $("#r_pwd_msg").html(
                "<span style='color:#FF5722'>密码不能为空！</span>"
            );
            $("#r_pwd").css("border", "1px solid red");  //输入框变红
            $("#r_pwd").focus();
            return false;
        } else {
            $("#r_pwd").css("border", "1px solid #009688");
        }

        if (password != re_password) {
            $("#r_pwd_confirm_msg").html(
                "<span style='color:#FF5722'>两次输入的密码不一致！</span>"
            );
            $("#r_pwd").css("border", "1px solid red");  //输入框变红
            $("#r_pwd_confirm").css("border", "1px solid red");  //输入框变红
            return false;
        } else {
            $("#r_pwd").css("border", "1px solid #009688");
            $("#r_pwd_confirm").css("border", "1px solid #009688");
        }

        //Restful风格的get请求
        var data = {
            _method: "POST",
            username: username,
            password: password,
            re_password: re_password
        };

        $.ajax({
            url: "${webRoot}/loginInfo",
            type: "post",
            data: data,
            dataType: "json",
            success: function (data) {
                var jsonData = eval(data);   //数据解析
                var code = jsonData.code;
                var msg = jsonData.msg;

                if (code == 1) {
                    layer.alert(msg, {
                        time: 3000,
                        icon: 1
                    });
                } else {
                    layer.alert(msg, {
                        time: 3000,
                        icon: 2
                    });
                }
            }
        });
    });

    $("#close").click(function () {
        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
        parent.layer.close(index); //再执行关闭
    });
</script>
</html>

