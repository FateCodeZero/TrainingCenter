/*新闻和公告还没写*/


/*加载培训动态列表在body.jsp*/
$(document).ready(function(){

    // var usertoken_str = $.cookie('usertoken_str');

    $.ajax({
        type: '',
        url: "",
        data:{},
        success: function (data) {
            if(!data['infostatus']){
                return ;
            }

            console.log("动态条数");

        }
    });
});
