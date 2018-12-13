<%--
  Created by IntelliJ IDEA.
  User: SJH
  Date: 2018/11/14
  Time: 19:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/context/mytags.jsp" %>
<html>
<head>
    <title>留言</title>

    <!-- Animate.css -->
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/animate.css">
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/bootstrap.css">
    <link rel="stylesheet" href="${webRoot}/plug-in/layui-v2.4.5/layui/css/layui.css">
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/contact.css">
    <!-- JS -->
    <script type="text/javascript" src="${webRoot}/plug-in/jquery-3.2.1/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/jquery-cookie/jquery.cookie.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/layui-v2.4.5/layui/layui.all.js"></script>
    <script type="text/javascript" src="${webRoot}/webpages/static/js/jquery.flexText.js" charset="gbk"></script>
    <script type="text/javascript" src="${webRoot}/webpages/static/js/utils.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/js/utils.js"></script>

</head>
<body onload="IFrameResize()">
<!--
    此评论textarea文本框部分使用的https://github.com/alexdunphy/flexText此插件
-->
<div class="row">
    <div class="col-md-8 col-md-offset-2 commentAll">
        <!--回复区域 begin-->
        <div id="comment-show" class="col-md-12 comment-show"></div>
        <!--回复区域 end-->
        <div id="layui-page" class="text-center"></div>
        <!--评论区域 begin-->
        <div class="col-md-12 reviewArea clearfix" style="margin-top: 20px">
            <textarea id="content" class="col-md-12 content comment-input" placeholder="留下您想对我们说的话吧&hellip;"
                      onkeyup="keyUP(this)"></textarea>
            <div id="commentTip"></div>
            <a id="btn-comment" href="javascript:;" class="col-md-1 plBtn">评论</a>
        </div>
        <!--评论区域 end-->
    </div>
</div>
<div class="block" style="height: 100px"></div>

<script type="text/javascript">
    /*从cookie里提取username*/
    var username = $.cookie('username');
    var laypage = null; //layui分页模块
    var total = null; //数据总数
    var rows = 10; //每页显示的数据条数
    var currentPage = 1; //当前页

    //    textarea高度自适应
    $(document).ready(function () {
        $('.content').flexText();
        total = getTotal();
        layuiPage();
        getPageData(null, currentPage, rows);
    });

    function layuiPage() {
        layui.use('laypage', function () {
            laypage = layui.laypage;
            laypage.render({
                elem: 'layui-page'      //div的ID
                , count: total        //数据总数，从服务端得到
                , limit: rows              //每页显示数据条数
                , groups: 5             //连续出现的页码数
                , layout: ['prev', 'page', 'next']    //自定义排版，需要显示的组件
                , theme: '#437be2'           //自定义主题颜色
                , jump: function (obj, first) {
                    //页码切换回调
                    if (!first) {
                        currentPage = obj.curr; //修改当前页
                        //重新获取新分页数据
                        getPageData(obj, currentPage, rows);
                    }
                }
            });
        });
    }

    function getTotal() {
        var count = 0;
        $.ajax({
            type: 'GET',
            url: "${webRoot}/comment/getTotal",
            async: false,    //关闭异步请求
            dataType: "json",
            success: function (data) {
                var jsonData = eval(data);
                var code = jsonData.code;
                var msg = jsonData.msg;
                if (code === 1) {
                    count = jsonData.data.total;
                } else {
                    layer.alert(msg, {
                        time: 3000,
                        icon: 2
                    });
                }
            }
        });
        return count;
    }

    //获取Comment数据，完成DIV追加，返回总条数
    function getPageData(obj, currentPage, rows) {
        //首次加载，当前页为第一页时传入参数为空
        if (currentPage === null) {
            currentPage = 1;
        }
        if (rows === null) {
            rows = 10;
        }
        $.ajax({
            type: 'GET',
            url: "${webRoot}/comment/list",
            data: {
                currentPage: currentPage,
                rows: rows,
                condition: JSON.stringify({searchContent: ''})
            },
            dataType: "json",
            success: function (data) {
                var jsonData = eval(data);
                var code = jsonData.code;
                var msg = jsonData.msg;

                if (code === 1) {
                    var items = jsonData.data.items;
                    if (items.length === 0) {
                        $("#comment-show").html('<h3 class="col-md-12 text-center">' + msg + '</h3>');
                    } else {
                        pageRender(items); //渲染页面数据
                    }
                } else {
                    layer.alert(msg, {
                        time: 3000,
                        icon: 2
                    });
                }

                if (obj !== null) {
                    obj.count = jsonData.data.total;
                }
                layui.laypage.render(obj);    //重新渲染分页组件
                IFrameResize();//再次计算高度，包含ajax新增的数据流
            }, error: function (jqXHR, textStatus, errorThrown) {
                ajaxErrorHandler(jqXHR); //ajax请求异常统一处理
            }
        });
    }

    /**
     * 渲染页面数据
     * @param items
     */
    function pageRender(items) {
        var comments = items;
        if (comments.length === 0){
            $("#comment-show").html('<h3 class="col-md-12 text-center">暂无数据</h3>');
            return;
        }
        var commentContent = '';
        $.each(comments, function (index, comment) {
            var id = comment.id;
            var content = comment.content;
            var replyCount = comment.replyCount;
            var praiseCount = comment.praiseCount;
            var createUserId = comment.createUserId;
            var user = getUserById(createUserId);
            var userInfo = getUserInfoByUsername(user.username);
            var nickname = userInfo.nickname;
            var portraitImg = userInfo.portraitImg; //头像url
            var createDate = new Date(comment.createDate).toLocaleString('chinese', {hour12: false}).replace(/:d{1,2}$/, ' ');

            commentContent += '<div class="col-md-12 comment-show-con clearfix">' +
                '           <div class="col-md-1 comment-show-con-img pull-left"><img style=" border-radius: 50%;overflow:display: flex; hidden;" class="col-md-12 person_img" src="${webRoot}/' + portraitImg + '" alt=""></div>' +
                '           <div class="col-md-11  comment-show-con-list pull-left clearfix">' +
                '               <div class="col-md-12 pl-text clearfix">' +
                '                   <a href="#" class="comment-size-name">' + nickname + ' : </a>' +
                '                   <span class="my-pl-con">&nbsp;' + content + '</span>' +
                '               </div>' +
                '               <div class="col-md-12 date-dz">' +
                '                   <span class="col-md-3 date-dz-left pull-left comment-time">' + createDate + '</span>' +
               /* '                   <div class="col-md-3 date-dz-right pull-right comment-pl-block">' +
                '                       <a href="javascript:;" class="col-md-2 removeBlock">删除</a>' +
                '                       <a href="javascript:;" class="col-md-2 date-dz-pl pl-hf hf-con-block pull-left">回复</a>' +
                '                   </div>' +*/
                '               </div>' +
                '               <div class="col-md-12 hf-list-con"></div>' +
                '           </div>' +
                '       </div>';
        });

        $("#comment-show").html(commentContent);
    }

    <!--textarea限制字数-->
    function keyUP(t) {
        var len = $(t).val().length;
        if (len > 200) {
            $(t).val($(t).val().substring(0, 200));
        }
    }

    //提交评论到后台数据库
    $("#btn-comment").click(function () {

        var username = $.cookie('username');
        if (username === null || username === '') {
            //询问框
            layer.confirm("只有登录才能评论哟，现在要去登录吗？", {
                    btn: ['确定', '取消']//按钮
                }
                , function () { //确定之后执行
                    window.location = "${webRoot}/webpages/static/login.jsp";
                }
                , function () {
                    return false;
                })
            return false;
        }

        //获取输入内容
        var content = $("#content").val();

        if (content === null || content === '') {
            $("#commentTip").html('<span style="color: #FF5722">请稍微写点什么吧</span>');
            return false;
        } else {
            $("#commentTip").html('');
        }
        var data = {
            content: content
        };
        $.ajax({
            url: "${webRoot}/comment/add",
            type: "post",
            data: data,
            dataType: "json",
            success: function (data) {
                var jsonData = eval(data);   //数据解析
                var code = jsonData.code;   //状态码
                var msg = jsonData.msg;     //提示信息
                if (code === 1) {
                    $("#content").val('');//输入框置空，防止恶意回复
                    getPageData(null, currentPage, rows);
                } else {
                    //显示错误信息
                    layer.alert(msg, {
                        time: 3000,
                        icon: 2
                    });
                }
            }
            , error: function (jqXHR, textStatus, errorThrown) {
                ajaxErrorHandler(jqXHR); //ajax请求异常统一处理
            }
        });
    });

    <!--点击回复动态创建回复块-->
    $('.comment-show').on('click', '.pl-hf', function () {
        //获取回复人的名字
        var fhName = $(this).parents('.date-dz-right').parents('.date-dz').siblings('.pl-text').find('.comment-size-name').html();
        //回复@
        var fhN = '回复@' + fhName;
        //var oInput = $(this).parents('.date-dz-right').parents('.date-dz').siblings('.hf-con');
        var fhHtml = '<div class="hf-con pull-left"> ' +
            '               <textarea id="replyContent" class="content comment-input hf-input" placeholder="" onkeyup="keyUP(this)"></textarea>' +
            '               <a id="btn-reply" href="javascript:;" class="hf-pl">回复</a>' +
            '         </div>';

        //显示回复
        if ($(this).is('.hf-con-block')) {
            $(this).parents('.date-dz-right').parents('.date-dz').append(fhHtml);
            $(this).removeClass('hf-con-block');
            $('.content').flexText();
            $(this).parents('.date-dz-right').siblings('.hf-con').find('.pre').css('padding', '6px 15px');
            //console.log($(this).parents('.date-dz-right').siblings('.hf-con').find('.pre'))
            //input框自动聚焦
            $(this).parents('.date-dz-right').siblings('.hf-con').find('.hf-input').val('').focus().val(fhN);
        } else {
            $(this).addClass('hf-con-block');
            $(this).parents('.date-dz-right').siblings('.hf-con').remove();
        }
        IFrameResize();
    });

    <!--评论回复块创建-->
    $('.comment-show').on('click', '.hf-pl', function () {
        var oThis = $(this);

        //获取输入内容
        var oHfVal = $(this).siblings('.flex-text-wrap').find('.hf-input').val();
        console.log(oHfVal);

        var oHfName = $(this).parents('.hf-con').parents('.date-dz').siblings('.pl-text').find('.comment-size-name').html();
        var oAllVal = '回复@' + oHfName;
        var username = '回复人';
        if (oHfVal.replace(/^ +| +$/g, '') === '' || oHfVal === oAllVal) {

        } else {
            $.getJSON("json/pl.json", function (data) {
                var oAt = '';
                var oHf = '';
                $.each(data, function (n, v) {
                    delete v.hfContent;
                    delete v.atName;
                    var arr;
                    var ohfNameArr;
                    if (oHfVal.indexOf("@") === -1) {
                        data['atName'] = '';
                        data['hfContent'] = oHfVal;
                    } else {
                        arr = oHfVal.split(':');
                        ohfNameArr = arr[0].split('@');
                        data['hfContent'] = arr[1];
                        data['atName'] = ohfNameArr[1];
                    }

                    if (data.atName === '') {
                        oAt = data.hfContent;
                    } else {
                        oAt = '回复<a href="#" class="atName">@' + data.atName + '</a> : ' + data.hfContent;
                    }
                    oHf = data.hfName;
                });

                var replyDiv = '<div class="col-md-11 all-pl-con">' +
                    '    <div class="col-md-12 pl-text hfpl-text clearfix">' +
                    '        <a href="#" class="comment-size-name">' + username + ' : </a>' +
                    '        <span class="my-pl-con">' + oAt + '</span>' +
                    '    </div>' +
                    '    <div class="col-md-12 date-dz">' +
                    '        <span class="col-md-3 date-dz-left pull-left comment-time"></span>' +
                    '        <div class="col-md-3 date-dz-right pull-right comment-pl-block">' +
                    '            <a href="javascript:;" class="col-md-2 removeBlock">删除</a>' +
                    '            <a href="javascript:;" class="col-md-2 date-dz-pl pl-hf hf-con-block pull-left">回复</a>' +
                    '        </div>' +
                    '    </div>' +
                    '</div>';
                oThis.parents('.hf-con').parents('.comment-show-con-list').find('.hf-list-con').css('display', 'block').prepend(replyDiv) && oThis.parents('.hf-con').siblings('.date-dz-right').find('.pl-hf').addClass('hf-con-block') && oThis.parents('.hf-con').remove();
            });
        }
        IFrameResize();
    });

    /*<!--删除评论块-->
    $('.commentAll').on('click', '.removeBlock', function () {
        var oT = $(this).parents('.date-dz-right').parents('.date-dz').parents('.all-pl-con');
        if (oT.siblings('.all-pl-con').length >= 1) {
            oT.remove();
        } else {
            $(this).parents('.date-dz-right').parents('.date-dz').parents('.all-pl-con').parents('.hf-list-con').css('display', 'none')
            oT.remove();
        }
        $(this).parents('.date-dz-right').parents('.date-dz').parents('.comment-show-con-list').parents('.comment-show-con').remove();

    });*/

    /**
     * 通过 id 获取用户
     * @param id
     * @returns {*}
     */
    function getUserById(id) {
        if (id === null || id === '') {
            layer.alert('id不能为空！', {
                time: 3000,
                icon: 2
            });
            return false;
        }
        var user = '';
        var data = {id: id};
        $.ajax({
            url: "${webRoot}/user/getUserById",
            type: "get",
            async: false,    //关闭异步请求
            data: data,
            dataType: "json",
            success: function (data) {
                var jsonData = eval(data); //数据解析
                var code = jsonData.code;
                var msg = jsonData.msg;
                if (code === 1) {
                    user = jsonData.data.user;
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
        return user;
    }

    /**
     * 通过 username 获取用户
     * @param username
     * @returns {*}
     */
    function getUserInfoByUsername(username) {
        if (username === null || username === '') {
            layer.alert('请先选择要查询的数据', {
                time: 3000,
                icon: 2
            });
            return false;
        }
        var userInfo = null;
        var data = {username: username};
        $.ajax({
            url: "${webRoot}/userInfo/getUserInfoByUsername",
            type: "get",
            async: false,    //关闭异步请求
            data: data,
            dataType: "json",
            success: function (data) {
                var jsonData = eval(data); //数据解析
                var code = jsonData.code;
                var msg = jsonData.msg;
                if (code === 1) {
                    userInfo = jsonData.data.userInfo;
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
        return userInfo;
    }
</script>

</body>
</html>