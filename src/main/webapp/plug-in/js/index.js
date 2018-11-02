
/*输入控制*/
$(document).ready(function(){
	
	$('#user_name').blur(function () {
        if ($('#user_name').val() =='')
            {
               $('#user_name').attr('placeholder',"用户名不能为空！").css('color', '#FF8C00');
            }
        })

   $('#user_pwd').blur(function () {
        if ($('#user_pwd').val() == '') {
            $('#user_pwd').attr('placeholder',"密码不能为空！").css('color', '#FF8C00');
            }
        })

   $('#v_code').blur(function () {
        if ($('#v_code').val() == '') {
            $('#v_code').attr('placeholder',"验证码不能为空！").css('color', '#FF8C00');
            }
        })

});




/*提交注册*/
$(document).ready(function(){
	$('#login_submit').click(function(){

		var user_name = $("#user_name").val().trim();
		var user_password = $("#user_pwd").val().trim();
		var v_code = $("#v_code").val().trim();

		alert(user_name + "=====" + user_password  + "=====" +v_code);


		//提交操作
	})
});


/*$(function(){
	//刷新验证码
	$("#checkCode").click(function(){
		alert(11111);
		$("#loginCode").val('');
		$("#imgVcode").attr("src", getContextPath()+"/user/checkCode?dt="+new Date().getTime());
	});
	$("#userName").keydown(function(){
		$("#userEr").html("");$("#pswdEr").html("");
	});
	$("#pswd").keydown(function(){
		$("#userEr").html("");$("#pswdEr").html("");
	});
});*/



