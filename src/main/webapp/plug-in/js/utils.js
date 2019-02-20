/**
 * 动态设置iframe高度，让子页面撑开父页面，注意子页面顶部和底部不要设置margin和padding，因为计算高度时会被忽略
 */
function IFrameResize(){

    //alert("父页面高度"+parent.document.getElementById("IF-body").offsetHeight); //弹出父页面的高度
    var obj = parent.document.getElementById("IF-body"); //取得父页面IFrame对象
    //alert(parent.document.getElementById("IF-body").height); //弹出父页面中IFrame中设置的高度
    //alert("当前页面高度"+ $(document.body).height());
    obj.height = $(document.body).height(); //调整父页面中IFrame的高度为此页面的高度
    // obj.height =  document.documentElement.offsetHeight||document.body.offsetHeight;
    //obj.height = document.documentElement.clientHeight;

}


/**
 * 截取URL携带的参数,需要传入待截取的参数的键值
 */
(function ($) {
    $.extend({
        Request: function (m) {
            var sValue = location.search.match(new RegExp("[\?\&]" + m + "=([^\&]*)(\&?)", "i"));
            return sValue ? sValue[1] : sValue;
        },
        UrlUpdateParams: function (url, name, value) {
            var r = url;
            if (r != null && r != 'undefined' && r != "") {
                value = encodeURIComponent(value);
                var reg = new RegExp("(^|)" + name + "=([^&]*)(|$)");
                var tmp = name + "=" + value;
                if (url.match(reg) != null) {
                    r = url.replace(eval(reg), tmp);
                }
                else {
                    if (url.match("[\?]")) {
                        r = url + "&" + tmp;
                    } else {
                        r = url + "?" + tmp;
                    }
                }
            }
            return r;
        }

    });
})(jQuery);

/**
 * 预处理清除页面content的富文本样式
 * @param content
 * @returns {*}
 */
function pageContent(content) {

    content = content.replace(/(\n)/g, "");
    content = content.replace(/(\t)/g, "");
    content = content.replace(/(\r)/g, "");
    content = content.replace(/<\/?[^>]*>/g, "");
    content = content.replace(/\s*/g, "");
    return content;
}

/**
 * 处理标题
 * @param title
 * @returns {string}
 */
function titleSubstring(title) {

    if(title.length > 20){
        title = title.substring(0,20)+"…";
        return title;
    }else if(title.length < 10){
        for(var k = 0; k < 10;k ++){
            title = title +'\xa0';
        }
        return title;
    }else {
        return title;
    }
}

/**
 * 处理content
 * @param content
 * @returns {string}
 */
function contentSubstring(content) {

    if(content.length > 70){
        content = content.substring(0,70)+"…";
        return content;
    }else{
        content += content;
        return contentSubstring(content);
    }

}



/**
 * Ajax 请求错误统一异常处理处理
 */
ajaxErrorHandler = function (jqXHR) {
    switch (jqXHR.status) {
        case(500):
            layer.alert('请求参数有误，请检查后重试', {
                time: 3000,
                icon: 2
            });
            break;
        case(401):
            layer.alert('您未登录，请您先去登录', {
                time: 3000,
                icon: 2
            });
            break;
        case(403):
            layer.alert('非常抱歉，您没有该操作权限', {
                time: 3000,
                icon: 2
            });
            break;
        case(408):
            layer.alert('服务器请求超时', {
                time: 3000,
                icon: 2
            });
            break;
        default:
            layer.alert('网络异常', {
                time: 3000,
                icon: 2
            });
    }
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

/**
 * 输入长度限制工具方法
 * @param inputDom:输入框dom对象
 * @param maxLength：最大允许输入的字符个数
 */
stringLengthCheck = function (inputDom,maxLength) {
    var numberReg = /\d+$/;  //验证数字，至少是一位数字
    if (inputDom === null || inputDom === '' || !numberReg.test(maxLength) ){
        alert('参数错误，传入的参数不符合方法需求！');
        return false;
    }else {
        var str = inputDom.val();
        var length = str.length();
        if (length > maxLength){
            inputDom.val(inputDom.val().substring(0,maxLength) );
            return false;
        }else {
            return true;
        }
    }
};

/*对Date的扩展，将 Date 转化为指定格式的String
月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符，
年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)
例子：
(new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423
(new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18*/
/*调用：
var time1 = new Date().Format("yyyy-MM-dd");
var time2 = new Date().Format("yyyy-MM-dd HH:mm:ss");*/
Date.prototype.Format = function (fmt) { //author: meizz
    var o = {
        "M+": this.getMonth() + 1, //月份
        "d+": this.getDate(), //日
        "h+": this.getHours(), //小时
        "m+": this.getMinutes(), //分
        "s+": this.getSeconds(), //秒
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度
        "S": this.getMilliseconds() //毫秒
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
        if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
};



