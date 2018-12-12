<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/context/mytags.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>梦润-后台管理系统</title>
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/tree.css">
    <link rel="stylesheet" href="${webRoot}/plug-in/layui-v2.4.5/layui/css/layui.css">
    <link rel="stylesheet" href="${webRoot}/plug-in/bootstrap3.3.5/css/bootstrap.min.css">

    <script src="${webRoot}/plug-in/jquery-3.2.1/jquery-3.2.1.min.js"></script>
    <script src="${webRoot}/plug-in/jquery-cookie/jquery.cookie.js"></script>
    <script src="${webRoot}/plug-in/layui-v2.4.5/layui/layui.all.js"></script>
    <script src="${webRoot}/plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
    <script src="${webRoot}/plug-in/js/utils.js"></script>
    <script src="${webRoot}/plug-in/js/bootstrap-treeview.min.js"></script>

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
        <div class="layui-logo">梦润后台管理系统</div>
        <!-- 头部区域（可配合layui已有的水平导航） -->
        <%--<ul class="layui-nav layui-layout-left" lay-filter="nav-top">
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
        </ul>--%>
        <ul class="layui-nav layui-layout-right" lay-filter="nav-user">
            <li class="layui-nav-item" style="float: right">
                <a href="#"><img src="${webRoot}/${user.portraitImg}" class="layui-nav-img">${user.nickname}</a>
                <dl class="layui-nav-child">
                    <dd><a href="${webRoot}/webpages/user/userInfo.jsp">个人中心</a></dd>
                    <dd><a>消息通知</a></dd>
                    <dd><a href="${webRoot}/index.jsp">网站首页</a></dd>
                    <dd><a href="${webRoot}/user/logout">退出</a></dd>
                </dl>
            </li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div id="treeview-selectable" class=""></div>
    </div>

    <!-- 主体内容 -->
    <div class="layui-body" id="LAY_app_body">
        <div class="layadmin-tabsbody-item layui-show">
            <iframe id="index-body" src="" class="layadmin-iframe" frameborder="0" width="100%"
                    height="600px"></iframe>
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
    var resourceData = null;
    var unEnableCount = 0;
    var treeData = null;
    $(document).ready(function () {
        resourceData = getResourceData();
        unEnableCount = getCommentUnEnableCount();
        treeData = buildTreeData(resourceData);
        initSelectableTree(treeData);
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
            //通过修改 iframe 的 url 来切换页面，注：要用此方法，点击处<a>标签必须是 href="#"
            $("#index-body").attr('src', loadUrl);
        });
        element.render("nav");
    });

    /*获取菜单数据*/
    function getResourceData() {
        var returnData = null;
        $.ajax({
            url: "${webRoot}/resource/tree",
            type: "get",
            async: false,    //关闭异步请求
            data: null,
            dataType: "json",
            success: function (data) {
                var jsonData = eval(data); //数据解析
                var code = jsonData.code;
                var msg = jsonData.msg;
                if (code === 1) {
                    returnData = jsonData.data.items;
                } else {
                    layer.alert(msg, {
                        time: 3000,
                        icon: 2
                    });
                    return false;
                }
            }
            , error: function (jqXHR, textStatus, errorThrown) {
                ajaxErrorHandler(jqXHR); //ajax请求异常统一处理
            }
        });
        return returnData;
    }

    /**
     * 获取未审核的留言条数
     * */
    function getCommentUnEnableCount() {
        var total = null;
        $.ajax({
            url: "${webRoot}/comment/getUnEnableCount",
            type: "get",
            async: false,    //关闭异步请求
            dataType: "json",
            success: function (data) {
                var jsonData = eval(data); //数据解析
                var code = jsonData.code;
                var msg = jsonData.msg;
                if (code === 1) {
                    total = jsonData.data.total;
                } else {
                    layer.alert(msg, {
                        time: 3000,
                        icon: 2
                    });
                    return false;
                }
            }
            , error: function (jqXHR, textStatus, errorThrown) {
                ajaxErrorHandler(jqXHR); //ajax请求异常统一处理
            }
        });
        return total;
    }

    /*构建树形数据*/
    function buildTreeData(data) {
        var tree = [];
        $.each(data, function (index, item) {
            /*本节点菜单id*/
            var id = item.id;
            /*本节点菜单名称*/
            var name = item.name;
            /*本节点的父节点菜单id*/
            var parentId = item.parentId;
            /*本节点排序，可忽略*/
            var order = item.order;
            /*本节点层级*/
            var level = item.level;
            /*本节点url*/
            var url = item.data.url;
            /*本节点iocn*/
            var iconStyle = item.data.iconStyle;
            /*子节点*/
            var children = item.children;

            var tags = [];
            if (name === '信息管理' || name === '用户留言') {
                tags[0] = '<span style="color: #FF5722;font-size: larger">' + unEnableCount + '</span>'; //显示未审核留言数目
            }

            //使用递归方式解析数据
            tree[index] = {
                id: id,
                pid: parentId,
                order: order,
                text: name,
                icon: iconStyle, /*当前节点上的图标*/
                selectedIcon: iconStyle, /*当前节点被选择后的图标*/
                href: url,
                tags: tags,
                nodes: buildTreeData(children)
            };
        });
        return tree;
    }

    /*初始化选择树*/
    function initSelectableTree(data) {
        return $('#treeview-selectable').treeview({
            data: data,
            backColor: '#32353E',    //树所有节点的背景颜色
            onhoverColor: '#009688', //节点在用户鼠标滑过时的背景颜色
            selectedBackColor: '#009688', //节点被选中后的背景颜色
            showBorder: false,       //不显示边框
            showIcon: true, /*开启节点图标*/
            showTags: true, /*显示 tags*/
            enableLinks: false, /*不启用当前节点的超链接*/
            multiSelect: $('#chk-select-multi').is(':checked'),
            onNodeSelected: function (event, node) {
                console.log(node);
                var id = node.id; //节点数据id
                var href = node.href;
                var jspReg = /\/\w+\.jsp$/;   //以 / 开头，中间至少有一个字符，以.jsp结尾
                if (jspReg.test(href)) {
                    $("#index-body").attr('src', "${webRoot}" + href);
                }
            },
            onNodeUnselected: function (event, node) {
                /*取消节点选中事件*/
            }
        });
    }
</script>

</html>