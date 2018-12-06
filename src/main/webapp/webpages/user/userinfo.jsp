<%--
  Created by IntelliJ IDEA.
  User: SJH
  Date: 2018/11/22
  Time: 15:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/context/mytags.jsp" %>
<html>
<head>
    <title>个人中心</title>
    <!-- Animate.css -->
    <link rel="stylesheet" href="${webRoot}/plug-in/bootstrap3.3.5/css/bootstrap.min.css" media="all">
    <link rel="stylesheet" href="${webRoot}/plug-in/layui-v2.4.5/layui/css/layui.css">
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/personalCenter.css">
    <link href="${webRoot}/webpages/static/css/uploadPhoto/cropper.min.css" rel="stylesheet">
    <link href="${webRoot}/webpages/static/css/uploadPhoto/sitelogo.css" rel="stylesheet">

    <!-- JS -->
    <script type="text/javascript" src="${webRoot}/plug-in/jquery-3.2.1/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/layui-v2.4.5/layui/layui.js"></script>
    <script type="text/javascript" src="${webRoot}/webpages/static/js/utils.js"></script>
    <script src="${webRoot}/webpages/static/js/uploadPhoto/cropper.js"></script>
    <script src="${webRoot}/webpages/static/js/uploadPhoto/cropper.min.js"></script>
    <script src="${webRoot}/webpages/static/js/uploadPhoto/sitelogo.js"></script>
    <script src="${webRoot}/webpages/static/js/uploadPhoto/html2canvas.min.js" type="text/javascript"
            charset="utf-8"></script>

</head>
<body onload="IFrameResize()">
<div class="row personal_background">
    <div class="overlay"></div>
    <div class="col-md-8 col-md-offset-2 personal_body">
        <%--标题--%>
        <div class="col-md-12 personal_title">
            <h2 class="col-md-12 text-center ">个人中心</h2>
            <label class="col-md-2 col-md-offset-5 bar-w3-agile"></label>
        </div>
        <%--  user_info   --%>
        <div class="col-md-12 user_info">
            <div class="col-md-2  header">
                <img id="uploadPhoto" src="${webRoot}/webpages/static/images/photo1.jpg" alt="" class="col-md-12 head"
                     data-toggle="modal" data-target="#avatar-modal"/>
                <p class="col-md-12 modify" data-toggle="modal" data-target="#avatar-modal">修改头像</p>
            </div>
            <!---->
            <div class="col-md-9 right_c">
                <div class="col-md-12 right_info">
                    <div id="username" class="col-md-6 id_card">
                        <span class="id_name">用户名：qq_40967964</span>
                    </div>
                    <div class="col-md-12 line"></div>
                    <div class="col-md-12 nick">
                        <span id="nickname" class="col-md-4 nickname">昵称：Daisy-song</span>
                        <span class="col-md-2 mod" data-toggle="modal" data-target="#modify-modal">修改资料</span>
                    </div>
                    <form>
                        <ul class="col-md-12 ">
                            <li class="common">实名：</li>
                            <li class="common">性别：女</li>
                            <li class="common">生日：</li>
                            <li class="common">座右铭：</li>
                            <li class="common">地区：</li>
                            <li class="common">邮箱：</li>
                            <li class="common">邮政编码：</li>
                            <li class="common">电话号码：</li>
                            <li class="common">公司：</li>
                            <li class="common">职位：</li>
                            <li class="intro">
                                <span class="noWid">简介：</span>
                                <span class="content"></span>
                            </li>
                        </ul>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<%--图片上传--%>
<div class="modal fade" id="avatar-modal" aria-hidden="true" aria-labelledby="avatar-modal-label" role="dialog"
     tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <!--<form class="avatar-form" action="upload-logo.php" enctype="multipart/form-data" method="post">-->
            <form class="avatar-form">
                <div class="modal-header">
                    <button class="close" data-dismiss="modal" type="button">&times;</button>
                    <h4 class="modal-title" id="avatar-modal-label">上传图片</h4>
                </div>
                <div class="modal-body">
                    <div class="avatar-body">
                        <div class="avatar-upload">
                            <input class="avatar-src" name="avatar_src" type="hidden">
                            <input class="avatar-data" name="avatar_data" type="hidden">
                            <label for="avatarInput" style="line-height: 35px;">图片上传</label>
                            <button class="btn btn-danger" type="button" style="height: 35px;"
                                    onclick="$('input[id=avatarInput]').click();">请选择图片
                            </button>
                            <span id="avatar-name"></span>
                            <input class="avatar-input hide" id="avatarInput" name="avatar_file" type="file">
                        </div>
                        <div class="row">
                            <div class="col-md-8 col-md-offset-2">
                                <div class="avatar-wrapper"></div>
                            </div>
                        </div>
                        <div class="row avatar-btns">
                            <div class="col-md-3 col-md-offset-2 btn_rotate">
                                <div class="btn-group">
                                    <button class="btn btn-danger fa fa-undo" data-method="rotate" data-option="-90"
                                            type="button" title="Rotate -90 degrees"> 向左旋转
                                    </button>
                                </div>
                                <div class="btn-group">
                                    <button class="btn  btn-danger fa fa-repeat" data-method="rotate" data-option="90"
                                            type="button" title="Rotate 90 degrees"> 向右旋转
                                    </button>
                                </div>
                            </div>
                            <div class="col-md-2 col-md-offset-3 btn_save">
                                <button id="savePhoto" class="btn btn-danger btn-block avatar-save fa fa-save"
                                        type="button" data-dismiss="modal"> 保存修改
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<%--修改个人信息--%>
<div class="modal fade" id="modify-modal" aria-hidden="true" aria-labelledby="avatar-modal-label" role="dialog"
     tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <!--<form class="avatar-form" action="upload-logo.php" enctype="multipart/form-data" method="post">-->
            <form class="avatar-form">
                <div class="modal-header">
                    <button class="close" data-dismiss="modal" type="button">&times;</button>
                    <h4 class="modal-title">修改个人信息</h4>
                </div>
                <div class="modal-body ">
                    <div class="avatar-body">
                        <div class="avatar-upload">
                            <input class="avatar-src" name="avatar_src" type="hidden">
                            <input class="avatar-data" name="avatar_data" type="hidden">
                            <div class="col-md-10 col-md-offset-1 bd">
                                <div class="col-md-8 col-md-offset-2 item">
                                    <label>真实姓名<span>*</span></label>
                                    <input type="text" name="userAddress[consignee]" id="real_name" class="common_input"
                                           placeholder="真实姓名" maxlength="15" autocomplete='off'>
                                    <p class="tip-msg tipMsg" id="realNameTip"></p>
                                </div>
                                <div class="col-md-8 col-md-offset-2 item">
                                    <label>性别<span>*</span></label>
                                    <input class="man" id="man" type="radio" checked="checked" name="1"/>男
                                    <input class="woman" id="woman" type="radio" name="1"/>女
                                </div>
                                <div class="col-md-8 col-md-offset-2 item">
                                    <label>生日<span>*</span></label>
                                    <input type="text" class="common_input" id="birthday">
                                    <p class="tip-msg tipMsg"></p>
                                </div>
                                <div class="col-md-8 col-md-offset-2 item">
                                    <label>座右铭<span>*</span></label>
                                    <textarea name="motto" class="input-area" id="motto"
                                              placeholder="不超过20字"></textarea>
                                    <p class="tip-msg tipMsg" id="mottoTips"></p>
                                </div>
                                <div class="col-md-8 col-md-offset-2 item">
                                    <label>地址<span>*</span></label>
                                    <input type="text" name="address" class="common_input" id="address"
                                           placeholder="请输入您所在城市" autocomplete='off'>
                                    <p class="tip-msg tipMsg" id="addressTip"></p>
                                </div>
                                <div class="col-md-8 col-md-offset-2 item">
                                    <label>邮箱<span>*</span></label>
                                    <input type="text" name="email" id="email" class="common_input" placeholder="请输入邮箱"
                                           maxlength="15" autocomplete='off'>
                                    <p class="tip-msg tipMsg" id="emailModifyTip"></p>
                                </div>
                                <div class="col-md-8 col-md-offset-2 item">
                                    <label>邮政编码<span>*</span></label>
                                    <input type="text" name="postal_code" id="postal_code" class="common_input"
                                           placeholder="邮政编码" maxlength="15" autocomplete='off'>
                                    <p class="tip-msg tipMsg"></p>
                                </div>
                                <div class="col-md-8 col-md-offset-2 item">
                                    <label>联系电话<span>*</span></label>
                                    <input type="text" name="userAddress[tel]" class="common_input" id="phone"
                                           placeholder="11位手机号" autocomplete='off'>
                                    <p class="tip-msg tipMsg" id="telModifyTip"></p>
                                </div>
                                <div class="col-md-8 col-md-offset-2 item">
                                    <label>公司<span>*</span></label>
                                    <input type="text" id="company" class="common_input" placeholder="您所在公司"
                                           maxlength="15" autocomplete='off'>
                                    <p class="tip-msg tipMsg"></p>
                                </div>
                                <div class="col-md-8 col-md-offset-2 item">
                                    <label>职位<span>*</span></label>
                                    <input type="text" id="position" class="common_input" placeholder="您目前任职"
                                           maxlength="15" autocomplete='off'>
                                    <p class="tip-msg tipMsg"></p>
                                </div>
                                <div class="col-md-8 col-md-offset-2 item">
                                    <label>简介<span>*</span></label>
                                    <textarea class="input-area" id="describe" placeholder="个人简介"></textarea>
                                    <p class="tip-msg tipMsg" id="describeTip"></p>
                                </div>

                            </div>
                        </div>
                        <div class="row avatar-btns">
                            <div class="col-md-2 col-md-offset-5 btn_save">
                                <button class="btn btn-danger btn-block avatar-save fa fa-save" type="button"
                                        data-dismiss="modal"> 保存修改
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="loading" aria-label="Loading" role="img" tabindex="-1"></div>

<script type="text/javascript">
    //上传图片简易的验证  大小 格式
    $('#avatarInput').on('change', function (e) {
        var filemaxsize = 1024 * 3;//5M
        var target = $(e.target);
        var Size = target[0].files[0].size / 1024;

        if (Size > filemaxsize) {
            alert('图片过大，请重新选择!');
            $(".avatar-wrapper").childre().remove;
            return false;
        }
        if (!this.files[0].type.match(/image.*/)) {
            alert('请选择正确的图片!')
        } else {
            var filename = document.querySelector("#avatar-name");
            var texts = document.querySelector("#avatarInput").value;
            var teststr = texts; //你这里的路径写错了
            testend = teststr.match(/[^\\]+\.[^\(]+/i); //直接完整文件名的
            filename.innerHTML = testend;
        }

    });

    //验证手机号
    function checkPhone(str) {
        var phoneReg = /^1[345678]\d{9}$/;
        if (phoneReg.test(str)) {
            return true;
        } else {
            return false;
        }
    }

    //验证邮箱
    function checkEmail(str) {
        var emailReg = /^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/;
        if (emailReg.test(str)) {
            return true;
        } else {
            return false;
        }
    }

    /*验证修改个人信息格式*/
    $(document).ready(function () {
        ajaxErrorHandler(); //ajax请求错误统一处理
        /*验证手机号*/
        $("#phone").blur(function () {
            if (!checkPhone($("#phone").val().trim())) {
                $("#telModifyTip").html("<span style='color:#FF5722'>手机号格式不对！</span>");
                $("#phone").focus(); //获取焦点
            } else {
                $("#telModifyTip").html("");
            }
        })
        /*验证邮箱*/
        $("#email").blur(function () {
            if (!checkEmail($("#email").val().trim())) {
                $("#emailModifyTip").html("<span style='color:#FF5722'>邮箱格式不对！</span>");
                $("#email").focus(); //获取焦点
            } else {
                $("#emailModifyTip").html("");
            }
        })
        //限制real_name输入框字数
        $("#real_name").keyup(function () {
            if ($("#real_name").val().length > 5) {
                $("#real_name").val($("#real_name").val().substring(0, 20));
                $("#realNameTip").html("<span style='color:#FF5722'>字数不能超过5个！</span>");
            } else {
                $("#realNameTip").html("");
            }
        });
        //限制motto输入框字数
        $("#motto").keyup(function () {
            if ($("#motto").val().length > 20) {
                $("#motto").val($("#motto").val().substring(0, 20));
                $("#mottoTips").html("<span style='color:#FF5722'>字数不能超过20个！</span>");
            } else {
                $("#mottoTips").html("");
            }
        });

        //限制个人介绍输入框字数
        $("#describe").keyup(function () {
            if ($("#describe").val().length > 50) {
                $("#describe").val($("#describe").val().substring(0, 50));
                $("#describeTip").html("<span style='color:#FF5722'>字数不能超过50个！</span>");
            } else {
                $("#describeTip").html("");
            }
        });
    });


    /*生日选择、上传图片*/
    layui.use(['laydate', 'upload'], function () {
        var laydate = layui.laydate;
        var upload = layui.upload;

        //执行选择日期实例
        laydate.render({
            elem: '#birthday' //指定元素

        });

        /* //执行上传图片实例
         var uploadInst = upload.render({
             elem: '#savePhoto' //绑定元素
             ,url: '/upload/' //上传接口
             ,done: function(res){
                 //上传完毕回调
             }
             ,error: function(){
                 //请求异常回调
             }
         });*/
    });

    $(".avatar-save").on("click", function () {
        var img_lg = document.getElementById('imageHead');
        // 截图小的显示框内的内容
        html2canvas(img_lg, {
            allowTaint: true,
            taintTest: false,
            onrendered: function (canvas) {
                canvas.id = "mycanvas";
                //生成base64图片数据
                var dataUrl = canvas.toDataURL("image/jpeg");
                var newImg = document.createElement("img");
                newImg.src = dataUrl;
                imagesAjax(dataUrl)
            }
        });
    })

    function imagesAjax(src) {
        var data = {};
        data.img = src;
        data.jid = $('#jid').val();
        $.ajax({
            url: "upload-logo.php",
            data: data,
            type: "POST",
            dataType: 'json',
            success: function (re) {
                if (re.status == '1') {
                    $('.user_pic img').attr('src', src);
                }
            }
        });
    }


</script>

</body>
</html>


