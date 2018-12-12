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

    <link rel="stylesheet" href="${webRoot}/plug-in/headPhoto/cropper.min.css">
    <link rel="stylesheet" href="${webRoot}/plug-in/headPhoto/sitelogo.css">
    <link rel="stylesheet" href="${webRoot}/webpages/static/css/personalCenter.css">
    <link rel="stylesheet" type="text/css" href="http://www.jq22.com/jquery/font-awesome.4.6.0.css">

    <!-- JS -->
    <script type="text/javascript" src="${webRoot}/plug-in/jquery-3.2.1/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/jquery-cookie/jquery.cookie.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/layui-v2.4.5/layui/layui.all.js"></script>
    <script type="text/javascript" src="${webRoot}/webpages/static/js/utils.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/js/utils.js"></script>

    <script type="text/javascript" src="${webRoot}/plug-in/headPhoto/cropper.min.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/headPhoto/html2canvas.min.js"></script>
    <script type="text/javascript" src="${webRoot}/plug-in/headPhoto/sitelogo.js"></script>

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
                <img id="headPhoto" src="${webRoot}/webpages/static/images/photo1.jpg" alt="" class="col-md-12 head"
                     data-toggle="modal" data-target="#avatar-modal"/>
                <p class="col-md-12 modify" data-toggle="modal" data-target="#avatar-modal">修改头像</p>
            </div>
            <!---->
            <div class="col-md-9 right_c">
                <div class="col-md-12 right_info">
                    <div class="form-horizontal col-md-12">
                        <input type="hidden" value="" name="id" id="id">
                        <div class="form-group">
                            <label for="username" class="col-sm-2 control-label">账号</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="username" id="username" value=""
                                       disabled="disabled">
                            </div>
                        </div>
                        <hr>
                        <div class="form-group">
                            <label for="nickname" class="col-sm-2 control-label">昵称</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="nickname" id="nickname" value=""
                                       placeholder="填写昵称">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="motto" class="col-sm-2 control-label">个性签名</label>
                            <div class="col-sm-10">
                                <textarea rows="2" class="form-control" name="motto" id="motto"
                                          placeholder="填写个性签名"></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="realName" class="col-sm-2 control-label">真实姓名</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="realName" id="realName" value=""
                                       placeholder="填写真实姓名">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="gender" class="col-sm-2 control-label">性别</label>
                            <div class="col-sm-10">
                                <select class="form-control" name="gender" id="gender">
                                    <option value="1" id="man">男</option>
                                    <option value="0" id="woman">女</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="birthday" class="col-sm-2 control-label">生日</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="birthday" id="birthday" value=""
                                       placeholder="填写生日">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="address" class="col-sm-2 control-label">地址</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="address" id="address" value=""
                                       placeholder="填写居住地址">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="postalCode" class="col-sm-2 control-label">邮政编码</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="postalCode" id="postalCode" value=""
                                       placeholder="填写居住地邮编">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="email" class="col-sm-2 control-label">邮箱</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="email" id="email" value=""
                                       placeholder="填写个人邮箱">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="phone" class="col-sm-2 control-label">手机号码</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="phone" id="phone" value=""
                                       placeholder="填写手机号码">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="career" class="col-sm-2 control-label">职业</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="career" id="career" value=""
                                       placeholder="填写目前的职业">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="company" class="col-sm-2 control-label">公司</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="company" id="company" value=""
                                       placeholder="填写所在公司">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="position" class="col-sm-2 control-label">职位</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="position" id="position" value=""
                                       placeholder="填写所处职位">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="describe" class="col-sm-2 control-label">个人简介</label>
                            <div class="col-sm-10">
                                <textarea rows="3" class="form-control" name="describe" id="describe"
                                          placeholder="填写个人简介"></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-10 text-center">
                                <div class="col-sm-3"></div>
                                <button type="button" class="layui-btn col-sm-4" id="submit">保存更新</button>
                                <div class="col-sm-3"></div>
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
                                <input class="avatar-input hide" id="avatarInput" name="avatar_file" type="file"></div>
                            <div class="row">
                                <div class="col-md-9">
                                    <div class="avatar-wrapper"></div>
                                </div>
                                <div class="col-md-3">
                                    <div class="avatar-preview preview-lg" id="imageHead"></div>
                                    <!--<div class="avatar-preview preview-md"></div>
                            <div class="avatar-preview preview-sm"></div>-->
                                </div>
                            </div>
                            <div class="row avatar-btns">
                                <div class="col-md-4">
                                    <div class="btn-group">
                                        <button class="btn btn-danger fa fa-undo" data-method="rotate" data-option="-90"
                                                type="button" title="Rotate -90 degrees"> 向左旋转
                                        </button>
                                    </div>
                                    <div class="btn-group">
                                        <button class="btn  btn-danger fa fa-repeat" data-method="rotate"
                                                data-option="90" type="button" title="Rotate 90 degrees"> 向右旋转
                                        </button>
                                    </div>
                                </div>
                                <div class="col-md-5" style="text-align: right;">
                                    <button class="btn btn-danger fa fa-arrows" data-method="setDragMode"
                                            data-option="move" type="button" title="移动">
							            <span class="docs-tooltip" data-toggle="tooltip" title=""
                                              data-original-title="$().cropper(&quot;setDragMode&quot;, &quot;move&quot;)">
							            </span>
                                    </button>
                                    <button type="button" class="btn btn-danger fa fa-search-plus" data-method="zoom"
                                            data-option="0.1" title="放大图片">
							            <span class="docs-tooltip" data-toggle="tooltip" title=""
                                              data-original-title="$().cropper(&quot;zoom&quot;, 0.1)">
							              <!--<span class="fa fa-search-plus"></span>-->
							            </span>
                                    </button>
                                    <button type="button" class="btn btn-danger fa fa-search-minus" data-method="zoom"
                                            data-option="-0.1" title="缩小图片">
							            <span class="docs-tooltip" data-toggle="tooltip" title=""
                                              data-original-title="$().cropper(&quot;zoom&quot;, -0.1)">
							              <!--<span class="fa fa-search-minus"></span>-->
							            </span>
                                    </button>
                                    <button type="button" class="btn btn-danger fa fa-refresh" data-method="reset"
                                            title="重置图片">
                                        <span class="docs-tooltip" data-toggle="tooltip" title=""
                                              data-original-title="$().cropper(&quot;reset&quot;)"
                                              aria-describedby="tooltip866214"></span>
                                    </button>
                                </div>
                                <div class="col-md-3">
                                    <button id="headSave" class="btn btn-danger btn-block avatar-save fa fa-save" type="button"
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
</div>
<script src="${webRoot}/plug-in/headPhoto/html2canvas.min.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
    var username = $.cookie('username');
    var userInfo = null;
    $(document).ready(function () {
        laydate(); //日期选择
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
        $("#nickname").val(userInfo.nickname);
        $("#realName").val(userInfo.realName);
        var gender = userInfo.gender;
        if (gender === 1) {
            $("#man").attr('selected', 'selected')
        } else {
            $("#woman").attr('selected', 'selected')
        }
        $("#birthday").val(new Date(userInfo.birthday).Format("yyyy-MM-dd"));
        $("#address").val(userInfo.address);
        $("#postalCode").val(userInfo.postalCode);
        $("#email").val(userInfo.email);
        $("#phone").val(userInfo.phone);
        $("#motto").val(userInfo.motto);
        $("#describe").val(userInfo.describe);
        $("#company").val(userInfo.company);
        $("#position").val(userInfo.position);
        $("#career").val(userInfo.career);
    }

    //上传图片简易的验证  大小 格式
    $('#avatarInput').on('change', function(e) {
        var filemaxsize = 1024 * 2;//5M
        var target = $(e.target);
        var Size = target[0].files[0].size / 1024;
        if(Size > filemaxsize) {
            alert('图片过大，请重新选择!');
            $(".avatar-wrapper").childre().remove;
            return false;
        }
        if(!this.files[0].type.match(/image.*/)) {
            alert('请选择正确的图片!')
        } else {
            var filename = document.querySelector("#avatar-name");
            var texts = document.querySelector("#avatarInput").value;
            var teststr = texts; //你这里的路径写错了
            testend = teststr.match(/[^\\]+\.[^\(]+/i); //直接完整文件名的
            filename.innerHTML = testend;
        }
    });

    $("#headSave").on("click", function () {
        var img_lg = document.getElementById('imageHead');
        // 截图小的显示框内的内容
        html2canvas(img_lg, {
            allowTaint: true,
            taintTest: false,
            onrendered: function(canvas) {
                canvas.id = "mycanvas";
                //生成base64图片数据
                var dataUrl = canvas.toDataURL("image/jpeg");
                var newImg = document.createElement("img");
                newImg.src = dataUrl;
                console.log(dataUrl);
                /*imagesAjax(dataUrl)*/
                $('#headPhoto').attr('src',dataUrl );
            }
        });
    });

    function imagesAjax(src) {
        var username = $('#username').val();
        if (username === null || username === '') {
            layer.alert("保存失败，请重新登录", {
                time: 3000,
                icon: 2
            });
            return false;
        }

        var data = {
            file: src,
            username: username
        };

        $.ajax({
            url: "${webRoot}/userInfo/updateLogo",
            data: data,
            type: "POST",
            dataType: 'json',
            processData: false,
            contentType: false,
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
    }

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
            $("#mottoTips").html("<span style='color:#FF5722'>字数不能超过100个！</span>");
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

    /*生日选择*/
    function laydate() {
        layui.use(['laydate'], function () {
            var laydate = layui.laydate;
            //执行选择日期实例
            laydate.render({
                elem: '#birthday' //指定元素
            });
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

        if (username === null || username === '') {
            layer.alert('账号不能为空', {
                time: 3000,
                icon: 2
            });
            return;
        }

        var data = {
            username: username,
            nickname: nickname,
            realName: realName,
            gender: gender,
            birthday: birthday,
            address: address,
            postalCode: postalCode,
            email: email,
            phone: phone,
            motto: motto,
            describe: describe,
            company: company,
            position: position,
            career: career
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


