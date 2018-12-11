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
 * 处理标题
 * @param title
 * @returns {string}
 */
function titleSubstring(title) {

    if(title.length > 20){
        title = title.substring(0,20)+"…";
        /*console.log(title);*/
        return title;
    }else if(title.length < 10){
        for(k = 0; k < 10;k ++){
            title = title +'\xa0';
        }
        /*console.log(title +"000");*/
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

    /*alert("当前传入的："+content);*/
    if(content.length > 70){
        console.log("执行if")
        content = content.substring(0,70)+"…";
        console.log("返回前的值："+content);
        return content;
    }else{
        console.log("执行else")
        content += content;
        /*alert("回调的："+content);*/
        return contentSubstring(content);
    }

}


