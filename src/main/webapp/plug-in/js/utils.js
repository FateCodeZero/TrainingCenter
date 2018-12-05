/**
 * 动态设置iframe高度，让子页面撑开父页面，注意子页面顶部和底部不要设置margin和padding，因为计算高度时会被忽略
 */
IFrameResize = function(){
    //alert($(document.body).height()); //弹出当前页面的高度
    var obj = parent.document.getElementById("IF-body"); //取得父页面IFrame对象
    //alert(parent.document.getElementById("IF-body").height); //弹出父页面中IFrame中设置的高度
    obj.height = $(document.body).height(); //调整父页面中IFrame的高度为此页面的高度
};

/**
 * 获取URL后携带的参数
 * @param paramName:参数名称
 */
getUrlParam = function(paramName) {
    var query = window.location.search.substring(1);
    var vars = query.split("&");
    for (var i=0;i<vars.length;i++) {
        var pair = vars[i].split("=");
        if(pair[0] === paramName){return pair[1];}
    }
    return(false);
};

/**
 * 账号合法性验证
 * */
usernameCheck = function (username) {
    if (!(checkEmail(username) || checkPhone(username))){
        return false;
    }
    return true;
};

/**
 * 密码合法性验证
 * 以字母开头，长度在6-18之间，只能包含字符、数字和下划线。
 * */
passwordCheck = function(str) {
    var usernameReg = /^[a-zA-Z]\w{5,17}$/;
    if (usernameReg.test(str)){
        return true;
    }else {
        return false;
    }
};

/**
 邮箱验证： 第一部分@第二部分
 第一部分 ： 由字母、数字、下划线、短线 - 、点号 . 组成
 第二部分： 域名，域名由字母、数字、短线 - 域名后缀组成
 * */
checkEmail = function(str) {
    var emailReg = /^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/;
    if (emailReg.test(str)){
        return true;
    }else {
        return false;
    }
};

/**
 * 手机号验证：
 ^ 1 以数字1 开头
 [3-578] 手机号第二位允许是 3 、4 、5、6、7、8 中的任意一位
 \d{9} 任意9位数字组合
 $ 只能以数字作为结尾
 **/
checkPhone = function(str) {
    var phoneReg = /^1[345678]\d{9}$/;
    if (phoneReg.test(str)){
        return true;
    }else {
        return false;
    }
};


