/**
 * 动态设置iframe高度，让子页面撑开父页面，注意子页面顶部和底部不要设置margin和padding，因为计算高度时会被忽略
 */
function IFrameResize(){
    //alert($(document.body).height()); //弹出当前页面的高度
    var obj = parent.document.getElementById("IF-body"); //取得父页面IFrame对象
    //alert(parent.document.getElementById("IF-body").height); //弹出父页面中IFrame中设置的高度
    obj.height = $(document.body).height(); //调整父页面中IFrame的高度为此页面的高度
}

/**
 * 获取URL后携带的参数
 * @param paramName:参数名称
 */
function getUrlParam(paramName) {
    var query = window.location.search.substring(1);
    var vars = query.split("&");
    for (var i=0;i<vars.length;i++) {
        var pair = vars[i].split("=");
        if(pair[0] == paramName){return pair[1];}
    }
    return(false);
}

