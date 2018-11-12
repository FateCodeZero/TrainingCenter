/**
 * Created by IntelliJ IDEA.
 * User: YangYi
 * Date: 2018/11/11
 * Time: 21:02
 */

/**
 * Ajax 请求错误页面跳转统一处理
 * @param context：项目上下文，需要在.jsp文件传入 ${webRoot} 的值
 * @param code：ajax 请求返回的状态码
 * @returns {boolean}
 */
function errorPageJump(context,code) {

    //跳转到403页面
    if (code == 403){
        window.location=context+"/errorpage/403.jsp";
        return false;
    }

    //跳转到404页面
    if (code == 404){
        window.location=context+"/errorpage/404.jsp";
        return false;
    }

    //跳转到405页面
    if (code == 405){
        window.location=context+"/errorpage/405.jsp";
        return false;
    }

    return true;
}
