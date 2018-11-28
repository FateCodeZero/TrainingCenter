
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
    <script type="text/javascript" src="${webRoot}/plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/layui-v2.4.5/layui/layui.all.js"></script>
    <script type="text/javascript" src="${webRoot}/webpages/static/js/utils.js"></script>
</head>
<body onload="IFrameResize()">
    <div class="row">
        <div class="col-md-12 about_bg">
            <h1 class="col-md-12 text-center mytitle">
                梦 润 传 承
            </h1>
            <h4 class="col-md-12 text-center mytitle2">
                梦润，致力于让每个人都能公平和便利地获取优质教育服务，实现可持续职业成长
            </h4>
            <div class="col-md-10 col-md-offset-1">
                <div class="col-md-3">
                   <div class="col-md-10 col-md-offset-1 introduce" style="background-color: rgb(248, 90, 64);">
                       <a href="#introduce1">
                       <img src="${webRoot}/webpages/static/images/introduce1.png" class="col-md-6 col-md-offset-3 introduce_img">
                       <h3 class="col-md-12 text-center" style="color: #FFFFFF; margin-top: 15px;">公司简介</h3>
                       </a>
                   </div>
                </div>
                <div class="col-md-3">
                    <div class="col-md-10 col-md-offset-1 introduce" style="background-color: rgb(244, 119, 33);">
                        <a href="#introduce2">
                        <img src="${webRoot}/webpages/static/images/introduce2.png" class="col-md-6 col-md-offset-3 introduce_img">
                        <h3 class="col-md-12 text-center" style="color: #FFFFFF; margin-top: 15px;">红色历史文化教学点</h3>
                        </a>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="col-md-10 col-md-offset-1 introduce" style="background-color: rgb(0, 153, 204);>
                        <a href="#introduce2">
                            <img src="${webRoot}/webpages/static/images/introduce2.png" class="col-md-6 col-md-offset-3 introduce_img">
                            <h3 class="col-md-12 text-center" style="color: #FFFFFF; margin-top: 15px;">绿色发展教学点</h3>
                        </a>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="col-md-10 col-md-offset-1 introduce" style="background-color: rgb(86, 46, 25);>
                        <a href="#introduce3">
                        <img src="${webRoot}/webpages/static/images/introduce3.png" class="col-md-6 col-md-offset-3 introduce_img">
                        <h3 class="col-md-12 text-center" style="color: #FFFFFF; margin-top: 15px;">挂牌单位</h3>
                        </a>
                    </div>
                </div>
            </div>
        </div>


       <%-- 公司简介--%>
        <div id="introduce1" class="col-md-12 fh5co-bg-section" style="padding: 30px 0 50px 0px">
            <div class="container">
                <div class="row animate-box">
                    <div class="col-md-6 col-md-offset-3 text-center fh5co-heading">
                        <h2>公司 &amp; 简介</h2>
                        <p>Dignissimos asperiores vitae velit veniam totam fuga molestias accusamus alias autem provident. Odit ab aliquam dolor eius.</p>
                    </div>
                </div>
                <div class="col-md-6 animate-box">
                    <span>Company introduce</span>
                    <h2 >梦润传承</h2>
                    <p>梦润集团下辖贵州张明富生态农业有限公司、贵州梦润云大数据有限公司、贵州梦丽雅化妆品有限公司</p>
                    <p>贵州梦润鹌鹑有限公司、遵义市张明富旅游服务有限公司、遵义市梦润之春建筑有限公司、遵义市梦润农民专业合作社等7家公司。现集团公司用地1000多亩，建有梦润农民工返乡下乡创业园</p>
                    <p>茅台集团梦润还原土猪养殖观光旅游示范基地、国家级梦润鹌鹑养殖示范区</p>
                    <P>全国农民工返乡下乡培训基地、农民工文化馆、党建馆、劳模创新工作室等</P>
                </div>
                <div class="col-md-6 img_height">
                    <img class="img-responsive" src="${webRoot}/webpages/static/images/building.jpg" alt="Free HTML5 Bootstrap Template">
                </div>
            </div>
        </div>

        <%--管理团队--%>
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

                        <div class="col-md-3 animate-box text-center">
                            <div class="staff">
                                <div class="staff-img" style="background-image: url(${webRoot}/webpages/static/images/staff-1.jpg);">
                                    <ul class="fh5co-social">
                                        <li><a href="#"><i class="icon-facebook2"></i></a></li>
                                        <li><a href="#"><i class="icon-twitter2"></i></a></li>
                                        <li><a href="#"><i class="icon-dribbble2"></i></a></li>
                                        <li><a href="#"><i class="icon-github"></i></a></li>
                                    </ul>
                                </div>
                                <span>Health Teacher</span>
                                <h3><a href="#">Mike Smith</a></h3>
                                <p>Nullam ac urna eu felis dapibus condimentum sit amet a augue. Sed non neque elit. Sed ut imperdiet nisi.</p>
                            </div>
                        </div>
                        <div class="col-md-3 animate-box text-center">
                            <div class="staff">
                                <div class="staff-img" style="background-image: url(${webRoot}/webpages/static/images/staff-3.jpg);">
                                    <ul class="fh5co-social">
                                        <li><a href="#"><i class="icon-facebook2"></i></a></li>
                                        <li><a href="#"><i class="icon-twitter2"></i></a></li>
                                        <li><a href="#"><i class="icon-dribbble2"></i></a></li>
                                        <li><a href="#"><i class="icon-github"></i></a></li>
                                    </ul>
                                </div>
                                <span>Health Teacher</span>
                                <h3><a href="#">Mike Smith</a></h3>
                                <p>Nullam ac urna eu felis dapibus condimentum sit amet a augue. Sed non neque elit. Sed ut imperdiet nisi.</p>
                            </div>
                        </div>
                        <div class="col-md-3 animate-box text-center">
                            <div class="staff">
                                <div class="staff-img" style="background-image: url(${webRoot}/webpages/static/images/staff-2.jpg);">
                                    <ul class="fh5co-social">
                                        <li><a href="#"><i class="icon-facebook2"></i></a></li>
                                        <li><a href="#"><i class="icon-twitter2"></i></a></li>
                                        <li><a href="#"><i class="icon-dribbble2"></i></a></li>
                                        <li><a href="#"><i class="icon-github"></i></a></li>
                                    </ul>
                                </div>
                                <span>Health Teacher</span>
                                <h3><a href="#">Mike Smith</a></h3>
                                <p>Nullam ac urna eu felis dapibus condimentum sit amet a augue. Sed non neque elit. Sed ut imperdiet nisi.</p>
                            </div>
                        </div>
                        <div class="col-md-3 animate-box text-center">
                            <div class="staff">
                                <div class="staff-img" style="background-image: url(${webRoot}/webpages/static/images/staff-3.jpg);">
                                    <ul class="fh5co-social">
                                        <li><a href="#"><i class="icon-facebook2"></i></a></li>
                                        <li><a href="#"><i class="icon-twitter2"></i></a></li>
                                        <li><a href="#"><i class="icon-dribbble2"></i></a></li>
                                        <li><a href="#"><i class="icon-github"></i></a></li>
                                    </ul>
                                </div>
                                <span>Health Teacher</span>
                                <h3><a href="#">Mike Smith</a></h3>
                                <p>Nullam ac urna eu felis dapibus condimentum sit amet a augue. Sed non neque elit. Sed ut imperdiet nisi.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%--管理团队--%>
        <div id="introduce2" class="col-md-12 fh5co-bg-section">
            <div>
                <div class="container" style="margin-top: 150px;">
                    <div class="row animate-box">
                        <div class="col-md-8 col-md-offset-2 text-center fh5co-heading">
                            <h2> &amp; 绿色发展教学点&amp; </h2>
                            <p>Dignissimos asperiores vitae velit veniam totam fuga molestias accusamus alias autem provident. Odit ab aliquam dolor eius.</p>
                        </div>
                    </div>
                    <div class="row">

                        <div class="col-md-3 animate-box text-center">
                            <div class="staff">
                                <div class="staff-img" style="background-image: url(${webRoot}/webpages/static/images/staff-1.jpg);">
                                    <ul class="fh5co-social">
                                        <li><a href="#"><i class="icon-facebook2"></i></a></li>
                                        <li><a href="#"><i class="icon-twitter2"></i></a></li>
                                        <li><a href="#"><i class="icon-dribbble2"></i></a></li>
                                        <li><a href="#"><i class="icon-github"></i></a></li>
                                    </ul>
                                </div>
                                <span>Health Teacher</span>
                                <h3><a href="#">Mike Smith</a></h3>
                                <p>Nullam ac urna eu felis dapibus condimentum sit amet a augue. Sed non neque elit. Sed ut imperdiet nisi.</p>
                            </div>
                        </div>
                        <div class="col-md-3 animate-box text-center">
                            <div class="staff">
                                <div class="staff-img" style="background-image: url(${webRoot}/webpages/static/images/staff-3.jpg);">
                                    <ul class="fh5co-social">
                                        <li><a href="#"><i class="icon-facebook2"></i></a></li>
                                        <li><a href="#"><i class="icon-twitter2"></i></a></li>
                                        <li><a href="#"><i class="icon-dribbble2"></i></a></li>
                                        <li><a href="#"><i class="icon-github"></i></a></li>
                                    </ul>
                                </div>
                                <span>Health Teacher</span>
                                <h3><a href="#">Mike Smith</a></h3>
                                <p>Nullam ac urna eu felis dapibus condimentum sit amet a augue. Sed non neque elit. Sed ut imperdiet nisi.</p>
                            </div>
                        </div>
                        <div class="col-md-3 animate-box text-center">
                            <div class="staff">
                                <div class="staff-img" style="background-image: url(${webRoot}/webpages/static/images/staff-2.jpg);">
                                    <ul class="fh5co-social">
                                        <li><a href="#"><i class="icon-facebook2"></i></a></li>
                                        <li><a href="#"><i class="icon-twitter2"></i></a></li>
                                        <li><a href="#"><i class="icon-dribbble2"></i></a></li>
                                        <li><a href="#"><i class="icon-github"></i></a></li>
                                    </ul>
                                </div>
                                <span>Health Teacher</span>
                                <h3><a href="#">Mike Smith</a></h3>
                                <p>Nullam ac urna eu felis dapibus condimentum sit amet a augue. Sed non neque elit. Sed ut imperdiet nisi.</p>
                            </div>
                        </div>
                        <div class="col-md-3 animate-box text-center">
                            <div class="staff">
                                <div class="staff-img" style="background-image: url(${webRoot}/webpages/static/images/staff-3.jpg);">
                                    <ul class="fh5co-social">
                                        <li><a href="#"><i class="icon-facebook2"></i></a></li>
                                        <li><a href="#"><i class="icon-twitter2"></i></a></li>
                                        <li><a href="#"><i class="icon-dribbble2"></i></a></li>
                                        <li><a href="#"><i class="icon-github"></i></a></li>
                                    </ul>
                                </div>
                                <span>Health Teacher</span>
                                <h3><a href="#">Mike Smith</a></h3>
                                <p>Nullam ac urna eu felis dapibus condimentum sit amet a augue. Sed non neque elit. Sed ut imperdiet nisi.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%--核心竞争力--%>
        <div class="col-md-12" style="margin-top: 150px;">
            <div class="container">
                <div class="row animate-box">
                    <div class="col-md-8 col-md-offset-2 text-center fh5co-heading">
                        <h2>挂牌 &amp; 单位</h2>
                        <p>Dignissimos asperiores vitae velit veniam totam fuga molestias accusamus alias autem provident. Odit ab aliquam dolor eius.</p>
                    </div>
                </div>
                <div class="row">
                    <div class="w3agile_gallery_grids">
                        <div class="col-md-3 w3agile_gallery_grid">
                            <div class="w3agile_gallery_image">
                                <a class="sb" href="${webRoot}/webpages/static/images/project-3.jpg" title="Agriculture">
                                    <figure>
                                        <img src="${webRoot}/webpages/static/images/project-3.jpg" alt="" class="img-responsive" />
                                        <figcaption>
                                            <h4>Sowing</h4>
                                            <p>
                                                Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
                                                tempor.
                                            </p>
                                        </figcaption>
                                    </figure>
                                </a>
                            </div>
                        </div>
                        <div class="col-md-3 w3agile_gallery_grid">
                            <div class="w3agile_gallery_image">
                                <a class="sb" title="Agriculture" href="${webRoot}/webpages/static/images/project-3.jpg">
                                    <figure>
                                        <img src="${webRoot}/webpages/static/images/project-3.jpg" alt="" class="img-responsive" />
                                        <figcaption>
                                            <h4>Sowing</h4>
                                            <p>
                                                Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
                                                tempor.
                                            </p>
                                        </figcaption>
                                    </figure>
                                </a>
                            </div>
                        </div>
                        <div class="col-md-3 w3agile_gallery_grid">
                            <div class="w3agile_gallery_image">
                                <a class="sb" title="Agriculture" href="${webRoot}/webpages/static/images/project-3.jpg">
                                    <figure>
                                        <img src="${webRoot}/webpages/static/images/project-3.jpg" alt="" class="img-responsive" />
                                        <figcaption>
                                            <h4>Sowing</h4>
                                            <p>
                                                Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
                                                tempor.
                                            </p>
                                        </figcaption>
                                    </figure>
                                </a>
                            </div>
                        </div>
                        <div class="col-md-3 w3agile_gallery_grid">
                            <div class="w3agile_gallery_image">
                                <a class="sb" title="Agriculture" href="${webRoot}/webpages/static/images/project-3.jpg">
                                    <figure>
                                        <img src="${webRoot}/webpages/static/images/project-3.jpg" alt="" class="img-responsive" />
                                        <figcaption>
                                            <h4>Sowing</h4>
                                            <p>
                                                Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
                                                tempor.
                                            </p>
                                        </figcaption>
                                    </figure>
                                </a>
                            </div>
                        </div>
                        <div class="col-md-3 w3agile_gallery_grid">
                            <div class="w3agile_gallery_image">
                                <a class="sb" title="Agriculture" href="${webRoot}/webpages/static/images/project-3.jpg">
                                    <figure>
                                        <img src="${webRoot}/webpages/static/images/project-3.jpg" alt="" class="img-responsive" />
                                        <figcaption>
                                            <h4>Sowing</h4>
                                            <p>
                                                Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
                                                tempor.
                                            </p>
                                        </figcaption>
                                    </figure>
                                </a>
                            </div>
                        </div>
                        <div class="col-md-3 w3agile_gallery_grid">
                            <div class="w3agile_gallery_image">
                                <a class="sb" title="Agriculture" href="${webRoot}/webpages/static/images/project-3.jpg">
                                    <figure>
                                        <img src="${webRoot}/webpages/static/images/project-3.jpg" alt="" class="img-responsive" />
                                        <figcaption>
                                            <h4>Sowing</h4>
                                            <p>
                                                Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
                                                tempor.
                                            </p>
                                        </figcaption>
                                    </figure>
                                </a>
                            </div>
                        </div>
                        <div class="col-md-3 w3agile_gallery_grid">
                            <div class="w3agile_gallery_image">
                                <a class="sb" title="Agriculture" href="${webRoot}/webpages/static/images/project-3.jpg">
                                    <figure>
                                        <img src="${webRoot}/webpages/static/images/project-3.jpg" alt="" class="img-responsive" />
                                        <figcaption>
                                            <h4>Sowing</h4>
                                            <p>
                                                Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
                                                tempor.
                                            </p>
                                        </figcaption>
                                    </figure>
                                </a>
                            </div>
                        </div>
                        <div class="col-md-3 w3agile_gallery_grid">
                            <div class="w3agile_gallery_image">
                                <a class="sb" title="Agriculture" href="${webRoot}/webpages/static/images/project-3.jpg">
                                    <figure>
                                        <img src="${webRoot}/webpages/static/images/project-3.jpg" alt="" class="img-responsive" />
                                        <figcaption>
                                            <h4>Sowing</h4>
                                            <p>
                                                Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
                                                tempor.
                                            </p>
                                        </figcaption>
                                    </figure>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-12" style="height: 150px; background-color: #FFFFFF"></div>
        </div>


    </div>


</body>
</html>
