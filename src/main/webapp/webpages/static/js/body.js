/*新闻和公告还没写*/


/*加载培训动态列表在body.jsp*/
/*$(document).ready(function(){

     var usertoken_str = $.cookie('usertoken_str');

    $.ajax({
        type: 'GET',
        url: "http://" + backendserver + ":" + backendport + "/v1/class/show/all/task/",
        data:{usertoken_str:usertoken_str,class_id:class_id_text},
        success: function (data) {
            if(!data['infostatus']){
                return ;
            }
            var option = '';
            for (var i = 0; i <data['inforesult'].length; i++) {

                var task_id = data['inforesult'][i]['task_id'];
                var task_title = data['inforesult'][i]['task_title'];
                var task_publish_date = data['inforesult'][i]['task_publish_date'];
                var task_deadline = data['inforesult'][i]['task_deadline'];


                if(data['inforesult'][i]['task_condition'] == 0)
                {
                    var task_condition = "未批改";
                    tmp = tmp + 1;





                    /!*不是第一条，选择追加*!/
                    $("#class_list").append(boarddiv);


                    /!*先绑定监听事件，再动态追加，否则动态添加元素的监听事件会失效*!/
                    $("a[target='change_work']").click(
                        function(){

                            $.cookie('task_id',$(this).attr("id"));

                            window.location.href = "change_work.html";
                        });

                }
            }

            /!*调用对话框函数*!/
            $("a[target='delete_work']").click(function(){ $.tips_func($(this).attr("id"),usertoken_str); });

        }
    });
});*/
