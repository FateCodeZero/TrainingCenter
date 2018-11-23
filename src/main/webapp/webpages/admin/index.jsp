<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/context/mytags.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>layout 后台大布局 - Layui</title>
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/tree.css">
    <link rel="stylesheet" href="${webRoot}/plug-in/layui-v2.4.5/layui/css/layui.css">
    <link rel="stylesheet" href="${webRoot}/plug-in/bootstrap3.3.5/css/bootstrap.min.css">

    <script src="${webRoot}/plug-in/jquery-3.2.1/jquery-3.2.1.min.js"></script>
    <script src="${webRoot}/plug-in/layui-v2.4.5/layui/layui.all.js"></script>
    <script src="${webRoot}/plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>

    <style>
        body .layui-tree-skin-my_tree .layui-tree-branch {
            background-color: #ffffff;
            color: #FFFFFF;
        }
    </style>
</head>

<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">layui 后台布局</div>
        <!-- 头部区域（可配合layui已有的水平导航） -->
        <ul class="layui-nav layui-layout-left" lay-filter="nav-top">
            <li class="layui-nav-item">
                <a href="">控制台</a>
            </li>
            <li class="layui-nav-item">
                <a href="">商品管理</a>
            </li>
            <li class="layui-nav-item">
                <a href="">用户</a>
            </li>
            <li class="layui-nav-item">
                <a href="javascript:;">其它系统</a>
                <dl class="layui-nav-child">
                    <dd>
                        <a href="">邮件管理</a>
                    </dd>
                    <dd>
                        <a href="">消息管理</a>
                    </dd>
                    <dd>
                        <a href="">授权管理</a>
                    </dd>
                </dl>
            </li>
        </ul>
        <ul class="layui-nav layui-layout-right" lay-filter="nav-user">
            <li class="layui-nav-item">
                <a href="javascript:;">
                    <img src="http://t.cn/RCzsdCq" class="layui-nav-img"> 贤心
                </a>
                <dl class="layui-nav-child">
                    <dd>
                        <a href="">基本资料</a>
                    </dd>
                    <dd>
                        <a href="">安全设置</a>
                    </dd>
                </dl>
            </li>
            <li class="layui-nav-item">
                <a href="">退了</a>
            </li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <%--<ul class="layui-nav layui-nav-tree" lay-filter="nav-left">--%>
            <%--<li class="layui-nav-item layui-nav-itemed">--%>
            <%--<a class="" href="javascript:;">系统管理</a>--%>
            <%--<div class="layui-nav-child">--%>
            <%--<div>--%>
            <%--<a href="javascript:;">菜单管理</a>--%>
            <%--<div class="layui-nav-child">--%>
            <%--<a href="javascript:;">列表一</a>--%>
            <%--</div>--%>
            <%--</div>--%>
            <%--<div>--%>
            <%--<a href="javascript:;">角色管理</a>--%>
            <%--<div class="layui-nav-child">--%>
            <%--<a href="javascript:;">列表一</a>--%>
            <%--</div>--%>
            <%--</div>--%>
            <%--<div>--%>
            <%--<a href="javascript:;">权限管理</a>--%>
            <%--<div class="layui-nav-child">--%>
            <%--<a href="javascript:;">列表一</a>--%>
            <%--</div>--%>
            <%--</div>--%>
            <%--<div>--%>
            <%--<a href="">超链接</a>--%>
            <%--</div>--%>
            <%--</div>--%>
            <%--</li>--%>

            <%--<li class="layui-nav-item layui-nav-itemed">--%>
            <%--<a class="" href="javascript:;">所有商品</a>--%>
            <%--<dl class="layui-nav-child">--%>
            <%--<dd>--%>
            <%--<a href="javascript:;">列表一</a>--%>
            <%--</dd>--%>
            <%--<dd>--%>
            <%--<a href="javascript:;">列表二</a>--%>
            <%--</dd>--%>
            <%--<dd>--%>
            <%--<a href="javascript:;">列表三</a>--%>
            <%--</dd>--%>
            <%--<dd>--%>
            <%--<a href="">超链接</a>--%>
            <%--</dd>--%>
            <%--</dl>--%>
            <%--</li>--%>
            <%--<li class="layui-nav-item">--%>
            <%--<a href="javascript:;">解决方案</a>--%>
            <%--<dl class="layui-nav-child">--%>
            <%--<dd>--%>
            <%--<a href="javascript:;">列表一</a>--%>
            <%--</dd>--%>
            <%--<dd>--%>
            <%--<a href="javascript:;">列表二</a>--%>
            <%--</dd>--%>
            <%--<dd>--%>
            <%--<a href="">超链接</a>--%>
            <%--</dd>--%>
            <%--</dl>--%>
            <%--</li>--%>
            <%--<li class="layui-nav-item">--%>
            <%--<a href="">云市场</a>--%>
            <%--</li>--%>
            <%--<li class="layui-nav-item">--%>
            <%--<a href="">发布商品</a>--%>
            <%--</li>--%>
            <%--</ul>--%>
            <ul id="nav-left" lay-filter="nav-left"></ul>
        </div>
    </div>

    <!-- 主体内容 -->
    <div class="layui-body" id="LAY_app_body">
        <div class="layadmin-tabsbody-item layui-show">
            <iframe id="index-body" src="" class="layadmin-iframe" frameborder="0" width="100%"
                    height="800px"></iframe>
        </div>
    </div>
    <!-- 辅助元素，一般用于移动设备下遮罩 -->
    <div class="layadmin-body-shade" layadmin-event="shade"></div>

    <div class="layui-footer">
        <!-- 底部固定区域 -->
        © layui.com - 底部固定区域
    </div>
</div>

</body>
<script>
    $(document).ready(function () {
        //页面加载完成……
    });

    //JavaScript代码区域
    layui.use('element', function () {
        var element = layui.element;
        //监听导航点击
        element.on('nav', function (elem) {
            //console.log(elem)
            layer.msg(elem.text()); //弹出提示
            var text = elem.text();
            var loadUrl = "";

            if (text === '控制台') {
                loadUrl = "${webRoot}/webpages/admin/index.jsp";
            }
            if (text === '列表一') {
                loadUrl = "${webRoot}/webpages/admin/test1.jsp";
            }
            if (text === '列表二') {
                loadUrl = "${webRoot}/webpages/admin/resource_list.jsp";
            }
            if (text === '列表三') {
                loadUrl = "${webRoot}/webpages/admin/test3.jsp";
            }
            //通过修改 iframe 的 url 来切换页面，注：要用此方法，点击处<a>标签必须是 href="#"
            $("#index-body").attr('src', loadUrl);
        });
        element.render("nav");
    });

    layui.tree({
        elem: '#nav-left' //传入元素选择器
        , skin: 'sidebar'
        , nodes: [{ //节点
            name: '系统管理'
            , children: [{
                name: '菜单管理'
                , url: "${webRoot}/webpages/admin/resource_list.jsp"
            }, {
                name: '角色管理'
                , url: "${webRoot}/webpages/admin/resource_list.jsp"
            }]
        }, {
            name: '父节点2（可以点左侧箭头，也可以双击标题）'
            , children: [{
                name: '子节点21'
                , children: [{
                    name: '子节点211'
                }]
            }]
        }]
        , click: function (node) {
            console.log(node) //node即为当前点击的节点数据
            var loadUrl = node.url;
            $("#index-body").attr('src', loadUrl);
        }
    });

</script>

</html>