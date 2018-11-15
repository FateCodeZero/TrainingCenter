<%--
  Created by IntelliJ IDEA.
  User: SJH
  Date: 2018/11/14
  Time: 19:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>留言</title>

    <!-- Animate.css -->
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/animate.css">
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/bootstrap.css">
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/magnific-popup.css">
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/owl.carousel.min.css">
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/owl.theme.default.min.css">
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/flexslider.css">
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/pricing.css">
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/style.css">
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/contact.css">
    <link href="css/popup-box.css" rel="stylesheet" type="text/css" media="all" />
    <!-- JS -->
    <script type="text/javascript" src="${webRoot}/plug-in/jquery-3.2.1/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/layui-v2.3.0/layui/layui.all.js"></script>
    <script type="text/javascript" src="${webRoot}/webpages/static/js/contact.js" charset="gbk" ></script>

</head>
<body onload="IFrameResize()">
<!-- 留言 -->
<div id="fh5co-testimonial" style="background-image: url(images/school.jpg);">
    <div class="overlay"></div>
    <div  class="w3layouts">
    <!-- 留言表单 -->
    <div class="signin-agile">
        <h2>留言</h2>
        <label class="bar-w3-agile"></label>
        <form action="#">
            <div class="row form-group">
                <div class="col-md-12">
                    <!-- <label for="email">Email</label> -->
                    <input type="text" id="title" class="form-control" onblur="checkTitle(this.value);"placeholder="留言标题">
                    <span id="checkTitleResult" style="color: red "></span>
                </div>
            </div>
            <div class="row form-group">
                <div class="col-md-12">
                    <!-- <label for="message">Message</label> -->
                    <textarea id="message" cols="30" rows="10" class="form-control" onblur="checkMessage(this.value);"placeholder="写下您想对我们说的话吧" ></textarea>
                    <span id="checkMessageResult" style="color: red "></span>
                </div>
            </div>
            <div align="center" class="form-group">
                <input type="button" value="提交" id="submit" class="btn btn-primary" onclick="javascript:check();"/>
            </div>
        </form>
    </div>
    <!-- Sign up -->
    <div class="signup-agileinfo">
        <p>联系地址: 贵州省遵义市汇川区团泽镇梦润大道梦润源89号</p>
        <h6>客服电话: 400-0852-339</h6>
        <h6>E-mail:mengrun@gzmrjt.com</h6>
    </div>
    <div class="clear"></div>
</div>

</div>
</body>

<script>
    //动态设置iframe高度，让子页面撑开父页面，注意子页面顶部和底部不要设置margin和padding，因为计算高度时会被忽略
    function IFrameResize(){
        //alert($(document.body).height()); //弹出当前页面的高度
        var obj = parent.document.getElementById("IF-body"); //取得父页面IFrame对象
        //alert(parent.document.getElementById("IF-body").height); //弹出父页面中IFrame中设置的高度
        obj.height = $(document.body).height(); //调整父页面中IFrame的高度为此页面的高度
    }

    /*处理判断输入内容是否合法*/
    function checkTitle(obj){
        var title = obj;
        var checkTitleResult = document.getElementById("checkTitleResult");
        if(title.trim().length==0){
            checkTitleResult.innerHTML = "标题不能为空";
        }else{
            checkTitleResult.innerHTML = "";
        }
    }
    function checkMessage(obj){
        var message = obj;
        var checkMessageResult = document.getElementById("checkMessageResult");
        if(message.trim().length==0){
            checkMessageResult.innerHTML = "内容不能为空";
        }else{
            checkMessageResult.innerHTML = "";
        }
    }

</script>
</html>
