/*加载培训动态详情*/
/*
$(document).ready(function(){
    $('#question_pwd').click(function(){

        $.ajax({
            type: 'GET',
            url: "http://" + backendserver + ":" + backendport + "/v1/secret/get/",
            data: null,
            success: function (data) {
                if(!data['infostatus']){
                    return ;
                }
                var option = '';
                for (var i = data['inforesult'].length - 1; i >= 0; i--) {

                    $('#question_pwd').append($('<option value='+ (i+1) +'>'+ data['inforesult'][i]['secret_content']+'</option>'));
                }

            }
        });
    });
});*/
