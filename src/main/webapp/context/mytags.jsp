<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>
<c:set var="webRoot" value="<%=basePath%>" />

<script type="text/javascript">
    /**
     * Ajax 请求错误页面跳转统一处理
     */
    ajaxErrorHandler = function () {
        $.ajaxSetup({
            contentType: "application/x-www-form-urlencoded;charset=utf-8",
            complete: function (XMLHttpRequest, textStatus) {
            },
            statusCode: {
                401: function () {
                    window.location = "${webRoot}/webpages/errorpage/401.jsp";
                },
                403: function () {
                    window.location = "${webRoot}/webpages/errorpage/403.jsp";
                },
                404: function () {
                    window.location = "${webRoot}/webpages/errorpage/404.jsp";
                },
                500: function () {
                    window.location = "${webRoot}/webpages/errorpage/500.jsp";
                }
            }
        });
    };
</script>