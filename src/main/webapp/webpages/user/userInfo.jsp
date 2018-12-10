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
    <script type="text/javascript" src="${webRoot}/plug-in/jquery-cookie/jquery.cookie.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/layui-v2.4.5/layui/layui.all.js"></script>
    <script type="text/javascript" src="${webRoot}/webpages/static/js/utils.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/js/utils.js"></script>

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
                    <div class="col-md-6 id_card">
                        <span class="id_name">账号：<input type="text" id="username" style="border: none"
                                                        disabled="disabled"></span>
                    </div>
                    <div class="col-md-12 line"></div>
                    <div class="col-md-12 nick">
                        <span class="col-md-4 nickname">昵称：<span id="old_nickname"></span></span>
                        <span class="col-md-2 mod" data-toggle="modal" data-target="#modify-modal">修改资料</span>
                    </div>
                    <div>
                        <div class="col-md-12 ">
                            <div class="common">实名：<span id="old_realName"></span></div>
                            <div class="common">性别：<span id="old_gender"></span></div>
                            <div class="common">生日：<span id="old_birthday"></span></div>
                            <div class="common">座右铭：<span id="old_motto"></span></div>
                            <div class="common">地址：<span id="old_address"></span></div>
                            <div class="common">邮箱：<span id="old_email"></span></div>
                            <div class="common">邮政编码：<span id="old_postalCode"></span></div>
                            <div class="common">电话号码：<span id="old_phone"></span></div>
                            <div class="common">职业：<span id="old_career"></span></div>
                            <div class="common">公司：<span id="old_company"></span></div>
                            <div class="common">职位：<span id="old_position"></span></div>
                            <div class="intro">
                                <span class="noWid">简介：</span>
                                <textarea class="content" id="old_describe"></textarea>
                            </div>
                        </div>
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
                                        <button class="btn  btn-danger fa fa-repeat" data-method="rotate"
                                                data-option="90"
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
                <div class="avatar-form">
                    <div class="modal-header">
                        <button class="close" data-dismiss="modal" type="button">&times;</button>
                        <h4 class="modal-title">修改个人信息</h4>
                    </div>
                    <div class="modal-body ">
                        <div class="avatar-body">
                            <div class="avatar-upload">
                                <input id="id" name="id" type="hidden">
                                <div class="col-md-10 col-md-offset-1 bd">
                                    <div class="col-md-8 col-md-offset-2 item">
                                        <label>昵称</label>
                                        <input type="text" name="nickname" id="nickname" class="common_input"
                                               placeholder="昵称" maxlength="50" autocomplete='off'>
                                        <p class="tip-msg tipMsg" id="nicknameTip"></p>
                                    </div>
                                    <div class="col-md-8 col-md-offset-2 item">
                                        <label>真实姓名</label>
                                        <input type="text" name="realName" id="realName"
                                               class="common_input"
                                               placeholder="真实姓名" maxlength="50" autocomplete='off'>
                                        <p class="tip-msg tipMsg" id="realNameTip"></p>
                                    </div>
                                    <div class="col-md-8 col-md-offset-2 item">
                                        <label>性别</label>
                                        <select id="gender" name="gender">
                                            <option value="1" selected="selected">男</option>
                                            <option value="0">女</option>
                                        </select>
                                    </div>
                                    <div class="col-md-8 col-md-offset-2 item">
                                        <label>生日</label>
                                        <input type="text" class="common_input" id="birthday">
                                        <p class="tip-msg tipMsg"></p>
                                    </div>
                                    <div class="col-md-8 col-md-offset-2 item">
                                        <label>座右铭</label>
                                        <textarea name="motto" class="input-area" id="motto"
                                                  placeholder="不超过50字"></textarea>
                                        <p class="tip-msg tipMsg" id="mottoTips"></p>
                                    </div>
                                    <div class="col-md-8 col-md-offset-2 item">
                                        <label>地址</label>
                                        <input type="text" name="address" class="common_input" id="address"
                                               placeholder="请输入您所在城市" autocomplete='off'>
                                        <p class="tip-msg tipMsg" id="addressTip"></p>
                                    </div>
                                    <div class="col-md-8 col-md-offset-2 item">
                                        <label>邮箱</label>
                                        <input type="text" name="email" id="email" class="common_input"
                                               placeholder="请输入邮箱"
                                               maxlength="30" autocomplete='off'>
                                        <p class="tip-msg tipMsg" id="emailModifyTip"></p>
                                    </div>
                                    <div class="col-md-8 col-md-offset-2 item">
                                        <label>邮政编码</label>
                                        <input type="text" name="postalCode" id="postalCode" class="common_input"
                                               placeholder="邮政编码" maxlength="15" autocomplete='off'>
                                        <p class="tip-msg tipMsg"></p>
                                    </div>
                                    <div class="col-md-8 col-md-offset-2 item">
                                        <label>联系电话</label>
                                        <input type="text" name="phone" class="common_input" id="phone"
                                               placeholder="11位手机号" autocomplete='off' maxlength="11">
                                        <p class="tip-msg tipMsg" id="telModifyTip"></p>
                                    </div>
                                    <div class="col-md-8 col-md-offset-2 item">
                                        <label>职业</label>
                                        <input type="text" id="career" name="career" class="common_input"
                                               placeholder="您目前任职"
                                               maxlength="15" autocomplete='off'>
                                        <p class="tip-msg tipMsg"></p>
                                    </div>
                                    <div class="col-md-8 col-md-offset-2 item">
                                        <label>公司</label>
                                        <input type="text" id="company" name="company" class="common_input"
                                               placeholder="您所在公司"
                                               maxlength="100" autocomplete='off'>
                                        <p class="tip-msg tipMsg"></p>
                                    </div>
                                    <div class="col-md-8 col-md-offset-2 item">
                                        <label>职位</label>
                                        <input type="text" id="position" name="position" class="common_input"
                                               placeholder="您目前任职"
                                               maxlength="15" autocomplete='off'>
                                        <p class="tip-msg tipMsg"></p>
                                    </div>
                                    <div class="col-md-8 col-md-offset-2 item">
                                        <label>简介</label>
                                        <textarea class="input-area" id="describe" name="describe"
                                                  placeholder="个人简介"></textarea>
                                        <p class="tip-msg tipMsg" id="describeTip"></p>
                                    </div>

                                </div>
                            </div>
                            <div class="row avatar-btns">
                                <div class="col-md-2 col-md-offset-5 btn_save">
                                    <button id="submit" class="btn btn-danger" type="button" data-dismiss="modal"> 保存修改
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="loading" aria-label="Loading" role="img" tabindex="-1"></div>
</div>
<script type="text/javascript">
    var username = $.cookie('username');
    var userInfo = null;
    $(document).ready(function () {
        userInfo = getUserInfoByUsername(username);
        editDataInitialization(userInfo);
    });

    /**
     * 编辑数据初始化
     * @param userInfo 要编辑的权限对象
     */
    function editDataInitialization(userInfo) {
        if (userInfo === null || userInfo === '') {
            layer.alert('数据初始化失败，对象不能为空', {
                time: 3000,
                icon: 2
            });
            return null;
        }
        $("#id").val(userInfo.id);
        $("#username").val(userInfo.username);
        $("#old_nickname").html(userInfo.nickname);
        $("#old_realName").html(userInfo.realName);
        var gender = userInfo.gender;
        if (gender === 1) {
            $("#old_gender").html('男');
        } else {
            $("#old_gender").html('女');
        }
        $("#old_birthday").html(new Date(userInfo.birthday).toLocaleString('chinese', {hour12: false}).replace(/:d{1,2}$/, ' '));
        $("#old_address").html(userInfo.address);
        $("#old_postalCode").html(userInfo.postalCode);
        $("#old_email").html(userInfo.email);
        $("#old_phone").html(userInfo.phone);
        $("#old_motto").html(userInfo.motto);
        $("#old_describe").html(userInfo.describe);
        $("#old_company").html(userInfo.company);
        $("#old_position").html(userInfo.position);
        $("#old_career").html(userInfo.career);
    }

    //上传图片简易的验证  大小 格式
    $('#avatarInput').on('change', function (e) {
        var filemaxsize = 3*1024;//3M
        var target = $(e.target);
        var size = target[0].files[0].size / 1024;

        if (size > filemaxsize) {
            alert('图片过大，请重新选择!');
            $(".avatar-wrapper").childre().remove;
            return false;
        }
        if (!this.files[0].type.match(/image.*/)) {
            alert('请选择正确的图片!')
        } else {
            var filename = document.querySelector("#avatar-name");
            var filePath = document.querySelector("#avatarInput").value;
            var name = filePath.match(/[^\\]+\.[^\(]+/i); //直接完整文件名的
            filename.innerHTML = name;
        }
    });

    /*验证手机号*/
    $("#phone").blur(function () {
        var phone = $("#phone").val().trim();
        if (!checkPhone(phone)) {
            $("#telModifyTip").html("<span style='color:#FF5722'>手机号格式不对！</span>");
        } else {
            $("#telModifyTip").html("");
        }
    });

    /*验证邮箱*/
    $("#email").blur(function () {
        var email = $("#email").val().trim();
        if (!checkEmail(email)) {
            $("#emailModifyTip").html("<span style='color:#FF5722'>邮箱格式不对！</span>");
        } else {
            $("#emailModifyTip").html("");
        }
    });

    //限制real_name输入框字数
    $("#real_name").keyup(function () {
        var realName = $("#realName").val();
        if (realName.length > 50) {
            $("#realName").val(realName.substring(0, 50));
            $("#realNameTip").html("<span style='color:#FF5722'>姓名字数不能超过50个</span>");
        } else {
            $("#realNameTip").html("");
        }
    });

    //限制motto输入框字数
    $("#motto").keyup(function () {
        var motto = $("#motto").val();
        if (motto.length > 100) {
            $("#motto").val(motto.substring(0, 100));
            $("#mottoTips").html("<span style='color:#FF5722'>字数不能超过20个！</span>");
        } else {
            $("#mottoTips").html("");
        }
    });

    //限制个人介绍输入框字数
    $("#describe").keyup(function () {
        var describe = $("#describe").val();
        if (describe.length > 1000) {
            $("#describe").val(describe.substring(0, 1000));
            $("#describeTip").html("<span style='color:#FF5722'>字数不能超过1000个！</span>");
        } else {
            $("#describeTip").html("");
        }
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

    $("#savePhoto").on("click", function () {
        var img_lg = document.getElementById('avatarInput');
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
                alert(dataUrl);
                /*imagesAjax(dataUrl)*/
            }
        });
    });

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
                if (re.status === 1) {
                    $('.user_pic img').attr('src', src);
                }
            }
            , error: function (jqXHR, textStatus, errorThrown) {
                ajaxErrorHandler(jqXHR); //ajax请求异常统一处理
            }
        });
    }

    $("#submit").click(function () {
        var username = $("#username").val();
        var nickname = $("#nickname").val();
        var realName = $("#realName").val();
        var gender = $("#gender").val();
        var birthday = $("#birthday").val();
        var address = $("#address").val();
        var postalCode = $("#postalCode").val();
        var email = $("#email").val();
        var phone = $("#phone").val();
        var motto = $("#motto").val();
        var describe = $("#describe").val();
        var company = $("#company").val();
        var position = $("#position").val();
        var career = $("#career").val();

        if (username === null || username === ''){
            layer.alert('账号不能为空', {
                time: 3000,
                icon: 2
            });
            return;
        }

        var data = {
            username:username,
            nickname:nickname,
            realName:realName,
            gender:gender,
            birthday:birthday,
            address:address,
            postalCode:postalCode,
            email:email,
            phone:phone,
            motto:motto,
            describe:describe,
            company:company,
            position:position,
            career:career
        };

        $.ajax({
            url: "${webRoot}/userInfo/update",
            type: "POST",
            data: data,
            dataType: "json",
            success: function (data) {
                var jsonData = eval(data); //数据解析
                var code = jsonData.code;
                var msg = jsonData.msg;
                if (code === 1) {
                    layer.alert(msg, {
                        time: 3000,
                        icon: 1
                    });
                    location.reload(); //回调函数，刷新页面
                } else {
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


