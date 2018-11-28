<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/context/mytags.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>资源菜单选择</title>
    <link rel="stylesheet" href="${webRoot}/plug-in/layui-v2.4.5/layui/css/layui.css" charset="UTF-8">
    <link rel="stylesheet" href="${webRoot}/plug-in/bootstrap3.3.5/css/bootstrap.min.css" charset="UTF-8">

    <script src="${webRoot}/plug-in/jquery-3.2.1/jquery-3.2.1.min.js" charset="UTF-8"></script>
    <script src="${webRoot}/plug-in/layui-v2.4.5/layui/layui.all.js" charset="UTF-8"></script>
    <script src="${webRoot}/plug-in/bootstrap3.3.5/js/bootstrap.min.js" charset="UTF-8"></script>

</head>

<body>
<div class="layui-tab layui-tab-brief" lay-filter="demoTitle">
    <div class="layui-tab-content">
        <div class="row">
            <%--<div class="col-sm-1"></div>--%>
            <div class="text-left col-sm-12">
                <table id="tableData" lay-filter="table-filter"></table>
            </div>
            <%--<div class="col-sm-1"></div>--%>
        </div>
        <div class="col-sm-offset-2 col-sm-10 text-center">
            <button type="button" class="layui-btn col-sm-4" id="submit">提交</button>
            <div class="col-sm-1"></div>
            <button type="button" class="layui-btn layui-btn-normal col-sm-4" id="close">关闭并回返</button>
        </div>
        <br>
    </div>
</div>
</body>

<script type="text/javascript">
    var searchContent = $("#searchContent").val(); //模糊查询内容
    var table;  //layui table

    //layui数据表格
    layui.use('table', function () {
        table = layui.table;
        //渲染
        table.render({
            id: 'table1'
            , elem: '#tableData'
            , height: 450
            , title: '菜单管理'
            , url: '${webRoot}/resource/select' //数据接口
            , page: true //开启分页
            , limit: 10 //每页显示多少条数据
            , cols: [[ //表头
                {type: 'checkbox', fixed: 'left', align: 'center'}
                , {title: '序号', type: 'numbers', fixed: 'left', align: 'center'}
                , {field: 'id', title: 'ID', hide: true, align: 'center'}
                , {field: 'name', title: '菜单名称', align: 'center'}
                , {field: 'url', title: '对应URL', align: 'center'}
            ]]
            , where: {//接口需要的其它参数
                searchContent: searchContent
            }
            , parseData: function (res) { //res 即为原始返回的数据
                var code = res.code == 1 ? 0 : 1;
                var msg = res.msg;
                var data = res.data.items;
                var count = 0;
                if (data != null) {
                    count = data.total;
                }
                return {
                    "code": code, //解析接口状态，layui的0为成功
                    "msg": msg, //解析提示文本
                    "count": count, //解析数据长度
                    "data": data //解析数据列表
                };
            }
            , request: { //用于对分页请求的参数：page、limit重新设定名称
                pageName: 'currentPage' //页码的参数名称，默认：page
                , limitName: 'rows' //每页数据量的参数名，默认：limit
            }
            , done: function (res, curr, count) { //渲染完毕后回调
                //如果是异步请求数据方式，res即为你接口返回的信息。
                //如果是直接赋值的方式，res即为：{data: [], count: 99} data为当前页数据、count为数据总长度
                //table.render();
            }
        });

        //监听表格复选框选择
        table.on('checkbox(table-filter)', function (obj) {
            console.log(obj)
        });
    });

    //执行数据返回操作
    $("#submit").click(function () {
        var data = returnSelectedData();
        /*layer.msg("选中：ID:" + data.id +"\nname："+data.name);*/
        returnData(data);
    });

    //关闭
    $("#close").click(function () {
        closeView();
    });

    //获取被选中的数据
    function returnSelectedData() {
        //获取被选中数据
        var checkStatus = table.checkStatus('table1');
        var data = checkStatus.data;

        var selectedData;   //选中的数据

        if (data.length == 0) {
            layer.alert('请先选择权限对应的资源', {
                time: 3000,
                icon: 2
            });
            return false;
        } else {
            if (data.length > 1) {
                layer.alert('一个权限只能对应一个资源', {
                    time: 3000,
                    icon: 2
                });
                return false;
            } else {
                selectedData = {
                    id: data[0].id,
                    name: data[0].name
                };
                return selectedData;
            }
        }
    }

    //返回被选中的数据
    function returnData(data) {
        if (data == null) {
            layer.msg("请先选择数据", {
                icon: 2,
                time: 2000 //2秒关闭（如果不配置，默认是3秒）
            });
        } else {
            parent.getBackResourceData(data);	//将Json数据传给父窗口
        }
        closeView();
    }

    //关闭当前弹出窗口
    function closeView() {
        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
        parent.layer.close(index); //再执行关闭
    }

</script>

</html>