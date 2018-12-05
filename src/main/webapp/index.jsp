<%--
  Created by IntelliJ IDEA.
  User: YangYi
  Date: 2018/11/6
  Time: 18:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/context/mytags.jsp" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>首页</title>

    <link rel="stylesheet" href="${webRoot}/plug-in/bootstrap3.3.5/css/bootstrap.min.css">
    <link rel="stylesheet" href="${webRoot}/plug-in/layui-v2.4.5/layui/css/layui.css">
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/index.css">

    <script type="text/javascript" src="${webRoot}/plug-in/jquery-3.2.1/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/layui-v2.4.5/layui/layui.all.js"></script>
</head>
<body >
<div id="mian">

    <%--顶部公司log图片--%>
    <div id="top">
        <iframe id="IF-top" src="${webRoot}/webpages/static/top.jsp" frameborder="0" width="100%"
                scrolling="no"></iframe>
    </div>

    <%--颈部导航栏--%>
    <div class="row " id="navigation">
        <div class="col-sm-12">
            <ul class="layui-nav" lay-filter="index-nav">
                <li class="layui-nav-item">
                    <a href="" id="CT-index">首页</a>
                </li>
                <li class="layui-nav-item">
                    <a href="#">关于我们</a>
                </li>
                <li class="layui-nav-item">
                    <a href="#">特色课程</a>
                    <dl class="layui-nav-child">
                        <dd><a href="#">体验式教学</a></dd>
                        <dd><a href="#">访谈教学</a></dd>
                        <dd><a href="#">现场讲解</a></dd>
                        <dd><a href="#">影音教学</a></dd>
                        <dd><a href="#">与创业名人/团队交流调研</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="#">学员风采</a>
                    <dl class="layui-nav-child">
                        <dd><a href="#">学员学习照</a></dd>
                        <dd><a href="#">最佳学员</a></dd>
                        <dd><a href="#">往期学员故事</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="#">行程配置</a>
                    <dl class="layui-nav-child">
                        <dd><a href="#">红色圣地</a></dd>
                        <dd><a href="#">交通工具</a></dd>
                        <dd><a href="#">特色美食</a></dd>
                        <dd><a href="#">文化产品</a></dd>
                        <dd><a href="#">特此介绍</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="#">留言咨询</a>
                </li>

                <c:if test="${not empty user}">
                    <li class="layui-nav-item" style="float: right">
                        <a href="#"><img src="//t.cn/RCzsdCq" class="layui-nav-img">用户A</a>
                        <dl class="layui-nav-child">
                            <dd><a>个人中心</a></dd>
                            <dd><a>消息通知</a></dd>
                            <dd><a href="${webRoot}/user/admin">后台管理系统</a></dd>
                            <dd><a href="${webRoot}/user/logout">退出</a></dd>
                        </dl>
                    </li>
                </c:if>
                <c:if test="${empty user}">
                    <li class="layui-nav-item" style="float: right">
                        <a href="${webRoot}/webpages/static/login.jsp" id="CT-login">登录</a>
                    </li>
                    <li class="layui-nav-item" style="float: right">
                        <a href="${webRoot}/webpages/static/register.jsp">注册</a>
                    </li>
                </c:if>
            </ul>
        </div>
    </div>

    <%--身体部分,各个页面跳转显示--%>
    <div id="body">
        <iframe id="IF-body" src="${webRoot}/webpages/static/body.jsp" frameborder="0" width="100%"
                 scrolling="no" > </iframe>
    </div>

    <%--页脚，网站相关信息--%>
    <footer id="footer">
        <iframe id="IF-footer" src="${webRoot}/webpages/static/footer.jsp" frameborder="0" width="100%"
                scrolling="no"></iframe>
    </footer>
</div>
</body>

<script type="text/javascript">
    $(document).ready(function () {
        ajaxErrorHandler(); //ajax请求错误统一处理
    });

    //使用 element 模块
    layui.use('element', function () {
        var element = layui.element; //导航的hover效果、二级菜单等功能，需要依赖element模块
        //监听导航点击
        element.on('nav(index-nav)', function (elem) {
            //console.log(elem)
            layer.msg(elem.text());//弹出提示
            var text = elem.text();
            var loadUrl = '';
            if (text === '首页') {
                loadUrl = "${webRoot}/index.jsp";
            }
            if (text === '关于我们') {
                loadUrl = "${webRoot}/webpages/static/aboutUs.jsp";
            }
            if (text === '留言咨询') {
                loadUrl = "${webRoot}/webpages/static/contact.jsp";
            }
            if (text === '体验式教学') {
                loadUrl = "${webRoot}/webpages/static/experientialTeaching.jsp";
            }
            if (text === '访谈教学') {
                loadUrl = "${webRoot}/webpages/static/interviewTeaching.jsp";
            }
            if (text === '现场讲解') {
                loadUrl = "${webRoot}/webpages/static/spotTeaching.jsp";
            }
            if (text === '影音教学') {
                loadUrl = "${webRoot}/webpages/static/videoTeaching.jsp";
            }
            if (text === '与创业名人/团队交流调研') {
                loadUrl = "${webRoot}/webpages/static/communicationTeaching.jsp";
            }
            if (text === '学员学习照') {
                loadUrl = "${webRoot}/webpages/static/studentPhotos.jsp";
            }
            if (text === '最佳学员') {
                loadUrl = "${webRoot}/webpages/static/bestStudent.jsp";
            }
            if(text === '往期学员故事'){
                loadUrl = "${webRoot}/webpages/static/studentStory.jsp";
            }
            if(text === '红色圣地'){
                loadUrl = "${webRoot}/webpages/static/revolutionarySite.jsp";
            }
            if(text === '交通工具'){
                loadUrl = "${webRoot}/webpages/static/transportation.jsp";
            }
            if(text === '特色美食'){
                loadUrl = "${webRoot}/webpages/static/specialFood.jsp";
            }
            if(text === '文化产品'){
                loadUrl = "${webRoot}/webpages/static/culturalProducts.jsp";
            }
            if(text === '特此介绍'){
                loadUrl = "${webRoot}/webpages/static/Introduce.jsp";
            }
            if(text === '个人中心'){
                loadUrl = "${webRoot}/webpages/static/personalCenter.jsp";
            }
            //通过修改 iframe 的 url 来切换页面，注：要用此方法，点击处<a>标签必须是 href="#"
            $("#IF-body").attr('src', loadUrl);
        });
        element.render("nav");


    });

</script>
</html>
