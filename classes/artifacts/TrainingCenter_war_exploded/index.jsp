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
    <link rel="stylesheet" href="${webRoot}/plug-in/layui-v2.3.0/layui/css/layui.css">

    <script type="text/javascript" src="${webRoot}/plug-in/jquery-3.2.1/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/layui-v2.3.0/layui/layui.all.js"></script>
</head>
<body>
<div id="mian" class="row">

    <%--顶部公司log图片--%>
    <div id="top">
        <iframe id="IF-top" src="${webRoot}/webpages/static/top.jsp" frameborder="0" width="100%" scrolling="no"></iframe>
    </div>

    <%--颈部导航栏--%>
    <div class="row" id="navigation">
        <div class="col-sm-12">
            <ul class="layui-nav" lay-filter="index-nav">
                <li class="layui-nav-item">
                    <a href="" id="CT-index">首页</a>
                </li>
                <li class="layui-nav-item">
                    <a href="#">留言咨询</a>
                </li>
                <li class="layui-nav-item">
                    <a href="#">特色课程</a>
                    <dl class="layui-nav-child">
                        <dd><a >修改信息</a></dd>
                        <dd><a >安全管理</a></dd>
                        <dd><a >退了</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="#">学员风采</a>
                    <dl class="layui-nav-child">
                        <dd><a >修改信息</a></dd>
                        <dd><a >安全管理</a></dd>
                        <dd><a >退了</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="#">行程配置</a>
                    <dl class="layui-nav-child">
                        <dd><a >修改信息</a></dd>
                        <dd><a >安全管理</a></dd>
                        <dd><a >退了</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="#">样式预留1<span class="layui-badge">9</span></a>
                </li>
                <li class="layui-nav-item">
                    <a href="#">样式预留2<span class="layui-badge-dot"></span></a>
                </li>
                <li class="layui-nav-item" style="float: right">
                    <a href="#"><img src="//t.cn/RCzsdCq" class="layui-nav-img">我</a>
                    <dl class="layui-nav-child">
                        <dd><a >修改信息</a></dd>
                        <dd><a >安全管理</a></dd>
                        <dd><a >退了</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item" style="float: right">
                    <a href="${webRoot}/webpages/user/login.jsp" id="CT-login">登录</a>
                </li>
                <li class="layui-nav-item" style="float: right">
                    <a href="#">注册</a>
                </li>
            </ul>
        </div>
    </div>

    <%--身体部分,各个页面跳转显示--%>
    <div id="body">
        <iframe id="IF-body" src="${webRoot}/webpages/static/body.jsp" frameborder="0" width="100%" height="100%" marginheight="50px" scrolling="no"></iframe>
    </div>

    <%--页脚，网站相关信息--%>
    <footer id="footer">
        <iframe id="IF-footer" src="${webRoot}/webpages/static/footer.jsp" frameborder="0" width="100%" scrolling="no" ></iframe>
    </footer>
</div>
</body>

<script type="text/javascript">
    $(document).ready(function () {
        //页面加载完成……
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
            if (text === '首页'){
                loadUrl = "${webRoot}/index.jsp";
            }
            if (text === '登录'){
                loadUrl = "${webRoot}/user/goLogin";
            }
            if (text === '注册'){
                loadUrl = "${webRoot}/user/goRegister";
            }
            //通过修改 iframe 的 url 来切换页面，注：要用此方法，点击处<a>标签必须是 href="#"
            $("#IF-body").attr('src',loadUrl);
        });
        element.render("nav");
    });
</script>
</html>
