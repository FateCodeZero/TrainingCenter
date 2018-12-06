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
<head >
    <title>留言</title>

    <!-- Animate.css -->
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/animate.css">
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/bootstrap.css">
    <link rel="stylesheet" href="${webRoot}/plug-in/layui-v2.4.5/layui/css/layui.css">
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/contact.css">
    <!-- JS -->
    <script type="text/javascript" src="${webRoot}/plug-in/jquery-3.2.1/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/layui-v2.4.5/layui/layui.all.js"></script>
    <script type="text/javascript" src="${webRoot}/webpages/static/js/jquery.flexText.js" charset="gbk" ></script>
    <script type="text/javascript" src="${webRoot}/webpages/static/js/utils.js"></script>

</head>
<body onload="IFrameResize()">
<!--
    此评论textarea文本框部分使用的https://github.com/alexdunphy/flexText此插件
-->
<div class="row">
    <div class="col-md-8 col-md-offset-2 commentAll">
        <!--评论区域 begin-->
        <div class="col-md-12 reviewArea clearfix">
            <textarea class="col-md-12 content comment-input" placeholder="留下您想对我们说的话吧&hellip;" onkeyup="keyUP(this)"></textarea>
            <a id="submit" href="javascript:;" class="col-md-1 plBtn">评论</a>
        </div>
        <!--评论区域 end-->
        <!--回复区域 begin-->
        <div class="col-md-12 comment-show"></div>
        <!--回复区域 end-->
    </div>
</div>
<div class="block"  style="height: 100px"></div>

<script type="text/javascript">

    <!--textarea高度自适应-->
    $(function () {
        $('.content').flexText();
    });
    <!--textarea限制字数-->
    function keyUP(t){
        var len = $(t).val().length;
        if(len > 139){
            $(t).val($(t).val().substring(0,140));
        }
    }

    //提交评论到后台数据库
    $("#submit").click(function () {
        //获取输入内容
        var comment = $(this).siblings('.flex-text-wrap').find('.comment-input').val();
        var reply = $(this).siblings('.flex-text-wrap').find('.hf-input').val();
        var username = '用户名';

        //Restful风格的Ajax Post请求
        var data = {
            _method: "POST",
            comment: comment,
            reply:reply,
            username:username,
        };
        $.ajax({
            url: "${webRoot}/user/login",
            type: "post",
            data: data,
            dataType: "json",
            success: function (data) {
                var jsonData = eval(data);   //数据解析
                var code = jsonData.code;   //状态码
                var msg = jsonData.msg;     //提示信息
                var url = null;

                var responseData = jsonData.data.items;    //获取返回的数据集
                if (responseData == 0){
                    $("#responseData").html('<h3 class="col-md-12 text-center">'+msg+'</h3>');
                }

                if (responseData != null && responseData != "") {
                    url = responseData.url;
                }



                if (code == 1) {
                    layer.alert(msg, {
                        time: 3000,
                        icon: 1
                    });

                } else if (code == 0) {
                    //显示错误信息
                    $("#kaptchaMsg").html('<span style="color: #b92c28">' + msg + '</span>');
                } else {
                    //错误错误状态码统一跳转
                    ajaxErrorHandler("${webRoot}", code);
                }
            }
        });
    });


    <!--点击评论创建评论条-->
    $('.commentAll').on('click','.plBtn',function(){
        var myDate = new Date();
        //获取当前年
        var year=myDate.getFullYear();
        //获取当前月
        var month=myDate.getMonth()+1;
        //获取当前日
        var date=myDate.getDate();
        var h=myDate.getHours();       //获取当前小时数(0-23)
        var m=myDate.getMinutes();     //获取当前分钟数(0-59)
        if(m<10) m = '0' + m;
        var s=myDate.getSeconds();
        if(s<10) s = '0' + s;
        var now=year+'-'+month+"-"+date+" "+h+':'+m+":"+s;
        //获取输入内容
        var comment = $(this).siblings('.flex-text-wrap').find('.comment-input').val();
        var portrait = '${webRoot}/webpages/static/images/header-img-comment_03.png';
        var username = '评论人';
        console.log(comment);
        //动态创建评论模块
        commentDiv = '<div class="col-md-12 comment-show-con clearfix">' +
            '           <div class="col-md-1 comment-show-con-img pull-left"><img src="'+portrait+'" alt=""></div>' +
            '           <div class="col-md-11  comment-show-con-list pull-left clearfix">' +
            '               <div class="col-md-12 pl-text clearfix">' +
            '                   <a href="#" class="comment-size-name">'+username+' : </a>' +
            '                   <span class="my-pl-con">&nbsp;'+ comment +'</span>' +
            '               </div>\n' +
            '               <div class="col-md-12 date-dz">' +
            '                   <span class="col-md-3 date-dz-left pull-left comment-time">'+now+'</span>' +
            '                   <div class="col-md-3 date-dz-right pull-right comment-pl-block">' +
            '                       <a href="javascript:;" class="col-md-2 removeBlock">删除</a>' +
            '                       <a href="javascript:;" class="col-md-2 date-dz-pl pl-hf hf-con-block pull-left">回复</a>' +
            '                   </div>' +
            '               </div>' +
            '               <div class="col-md-12 hf-list-con"></div>' +
            '           </div>' +
            '       </div>';
        if(comment.replace(/(^\s*)|(\s*$)/g, "") != ''){
            $(this).parents('.reviewArea ').siblings('.comment-show').prepend(commentDiv);
            $(this).siblings('.flex-text-wrap').find('.comment-input').prop('value','').siblings('pre').find('span').text('');
        }
        IFrameResize();
    });

    <!--点击回复动态创建回复块-->
    $('.comment-show').on('click','.pl-hf',function(){
        //获取回复人的名字
        var fhName = $(this).parents('.date-dz-right').parents('.date-dz').siblings('.pl-text').find('.comment-size-name').html();
        //回复@
        var fhN = '回复@'+fhName;
        //var oInput = $(this).parents('.date-dz-right').parents('.date-dz').siblings('.hf-con');
        var fhHtml = '<div class="hf-con pull-left"> ' +
            '               <textarea class="content comment-input hf-input" placeholder="" onkeyup="keyUP(this)"></textarea>' +
            '               <a href="javascript:;" class="hf-pl">评论</a>' +
            '         </div>';
        //显示回复
        if($(this).is('.hf-con-block')){
            $(this).parents('.date-dz-right').parents('.date-dz').append(fhHtml);
            $(this).removeClass('hf-con-block');
            $('.content').flexText();
            $(this).parents('.date-dz-right').siblings('.hf-con').find('.pre').css('padding','6px 15px');
            //console.log($(this).parents('.date-dz-right').siblings('.hf-con').find('.pre'))
            //input框自动聚焦
            $(this).parents('.date-dz-right').siblings('.hf-con').find('.hf-input').val('').focus().val(fhN);
        }else {
            $(this).addClass('hf-con-block');
            $(this).parents('.date-dz-right').siblings('.hf-con').remove();
        }
        IFrameResize();
    });

    <!--评论回复块创建-->
    $('.comment-show').on('click','.hf-pl',function(){
        var oThis = $(this);
        var myDate = new Date();
        //获取当前年
        var year=myDate.getFullYear();
        //获取当前月
        var month=myDate.getMonth()+1;
        //获取当前日
        var date=myDate.getDate();
        var h=myDate.getHours();       //获取当前小时数(0-23)
        var m=myDate.getMinutes();     //获取当前分钟数(0-59)
        if(m<10) m = '0' + m;
        var s=myDate.getSeconds();
        if(s<10) s = '0' + s;
        var now=year+'-'+month+"-"+date+" "+h+':'+m+":"+s;
        //获取输入内容
        var oHfVal = $(this).siblings('.flex-text-wrap').find('.hf-input').val();
        console.log(oHfVal)
        var oHfName = $(this).parents('.hf-con').parents('.date-dz').siblings('.pl-text').find('.comment-size-name').html();
        var oAllVal = '回复@'+oHfName;
        var username= '回复人';
        if(oHfVal.replace(/^ +| +$/g,'') == '' || oHfVal == oAllVal){

        }else {
            $.getJSON("json/pl.json",function(data){
                var oAt = '';
                var oHf = '';
                $.each(data,function(n,v){
                    delete v.hfContent;
                    delete v.atName;
                    var arr;
                    var ohfNameArr;
                    if(oHfVal.indexOf("@") == -1){
                        data['atName'] = '';
                        data['hfContent'] = oHfVal;
                    }else {
                        arr = oHfVal.split(':');
                        ohfNameArr = arr[0].split('@');
                        data['hfContent'] = arr[1];
                        data['atName'] = ohfNameArr[1];
                    }

                    if(data.atName == ''){
                        oAt = data.hfContent;
                    }else {
                        oAt = '回复<a href="#" class="atName">@'+data.atName+'</a> : '+data.hfContent;
                    }
                    oHf = data.hfName;
                });

                var replyDiv = '<div class="col-md-11 all-pl-con">\n' +
                    '    <div class="col-md-12 pl-text hfpl-text clearfix">\n' +
                    '        <a href="#" class="comment-size-name">'+username+' : </a>\n' +
                    '        <span class="my-pl-con">'+oAt+'</span>\n' +
                    '    </div>\n' +
                    '    <div class="col-md-12 date-dz">\n' +
                    '        <span class="col-md-3 date-dz-left pull-left comment-time"></span>\n' +
                    '        <div class="col-md-3 date-dz-right pull-right comment-pl-block">\n' +
                    '            <a href="javascript:;" class="col-md-2 removeBlock">删除</a>\n' +
                    '            <a href="javascript:;" class="col-md-2 date-dz-pl pl-hf hf-con-block pull-left">回复</a>\n' +
                    '        </div>\n' +
                    '    </div>\n' +
                    '</div>\n';
                oThis.parents('.hf-con').parents('.comment-show-con-list').find('.hf-list-con').css('display','block').prepend(replyDiv) && oThis.
                parents('.hf-con').siblings('.date-dz-right').find('.pl-hf').addClass('hf-con-block') && oThis.parents('.hf-con').remove();
            });
        }
        IFrameResize();
    });


    layui.use('laypage', function(){

        $(document).ready(function loading(){
            ajaxErrorHandler(); //ajax请求错误统一处理

            getCommentListPage();
            IFrameResize();
        });

        //获取getCommentListPage数据，完成DIV追加，返回总条数
        function getCommentListPage(currentPage){
            //首次加载，当前页为第一页时传入参数为空
            if (currentPage == null){
                currentPage = 1;
            }

            $.ajax({
                type: 'GET',
                url: "${webRoot}/comment/listPage",
                data: {currentPage:currentPage,rows:20},
                dataType: "json",
                success: function (data) {
                    var jsonData = eval(data);
                    var code = jsonData.code;
                    var msg = jsonData.msg;

                    if(code == 1){

                        var allComment = jsonData.data.items;
                        var commentTotal = Math.ceil((jsonData.data.total)/20);

                        if (allComment == 0){
                            $("#allComment").html('<h3 class="col-md-12 text-center">'+msg+'</h3>');
                        }

                        $.each(allComment,function (index,allComment) {
                            var id = contact.id;
                            var portrait = contact.portrait;
                            var comment = contact.commnet;
                            var reply = contact.reply;


                            var allNews_div = '';

                            if (index == 0) {
                                $("#allNews").html(allNews_div);
                            }else {
                                $("#allNews").append(allNews_div);
                            }
                        });
                        //生成分页
                        createlayPage(commentTotal,currentPage);
                        //再次计算高度，包含ajax新增的数据流
                        IFrameResize();
                    }else {
                        $("#allComment").html('<h3 class="col-md-12 text-center">'+msg+'</h3>');
                    }

                }
            });
        }

        /*生成分页*/
        function createlayPage(newsTotal,currentPage) {

            var laypage = layui.laypage;
            laypage.render({
                elem: 'allNews_pagination'      //div的ID
                , count: newsTotal        //数据总数，从服务端得到
                , limit: 1              //每页显示数据条数
                , groups: 3             //连续出现的页码数
                , theme: '#437be2'           //自定义主题颜色
                ,curr:currentPage             //当前页
                , jump: function (obj, first) {
                    //页码切换回调
                    if(!first){
                        //重新获取新分页数据
                        getNewsListPage(obj.curr);
                    }

                }
            });
        }
    });

    <!--删除评论块-->
    $('.commentAll').on('click','.removeBlock',function(){
        var oT = $(this).parents('.date-dz-right').parents('.date-dz').parents('.all-pl-con');
        if(oT.siblings('.all-pl-con').length >= 1){
            oT.remove();
        }else {
            $(this).parents('.date-dz-right').parents('.date-dz').parents('.all-pl-con').parents('.hf-list-con').css('display','none')
            oT.remove();
        }
        $(this).parents('.date-dz-right').parents('.date-dz').parents('.comment-show-con-list').parents('.comment-show-con').remove();

    });
</script>

</body>
</html>