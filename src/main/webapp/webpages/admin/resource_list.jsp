<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/context/mytags.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
    <link rel="stylesheet" href="${webRoot}/plug-in/layui-v2.4.5/layui/css/layui.css" charset="UTF-8">
    <link rel="stylesheet" href="${webRoot}/plug-in/bootstrap3.3.5/css/bootstrap.min.css" charset="UTF-8">

    <script src="${webRoot}/plug-in/jquery-3.2.1/jquery-3.2.1.min.js" charset="UTF-8"></script>
    <script src="${webRoot}/plug-in/layui-v2.4.5/layui/layui.all.js" charset="UTF-8"></script>
    <script src="${webRoot}/plug-in/bootstrap3.3.5/js/bootstrap.min.js" charset="UTF-8"></script>

</head>

<body>
<div class="layui-tab layui-tab-brief" lay-filter="demoTitle">
    <ul class="my-title layui-tab-title site-demo-title">
        <li class="layui-this">预览</li>
        <li class="">查看代码</li>
        <li class="">帮助</li>
    </ul>
    <div class="row">
        <%--<div class="col-sm-1"></div>--%>
        <div class="text-left col-sm-12">
            <table id="tableData" lay-filter="table-filter"></table>
        </div>
        <%--<div class="col-sm-1"></div>--%>
    </div>
</div>
</body>
<%--头部工具栏--%>
<script type="text/html" id="table-head">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-normal layui-btn-sm" lay-event="add" title="添加菜单">+ 添加</button>
        <button class="layui-btn layui-btn-danger layui-btn-sm" lay-event="delete" title="删除菜单">- 批量删除</button>
        <button class="layui-btn layui-btn-sm" lay-event="update" title="编辑菜单">/ 编辑</button>
    </div>
</script>

<%--表格操作--%>
<script type="text/html" id="table-opt">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>

<script type="text/javascript">
    var searchContent = $("#searchContent").val(); //模糊查询内容
    //JavaScript代码区域
    layui.use('element', function () {
        var element = layui.element;
        //监听导航点击
        element.on('nav', function (elem) {
            //console.log(elem)
            layer.msg(elem.text()); //弹出提示
            var text = elem.text();
        });
        element.render("nav");
    });

    //layui数据表格
    layui.use('table', function () {
        var table = layui.table;
        //渲染
        table.render({
            id: 'table1'
            , elem: '#tableData'
            , toolbar: '#table-head'
            , height: 430
            , title: '菜单管理'
            , url: '${webRoot}/resource/listPage' //数据接口
            , page: true //开启分页
            , limit: 10 //每页显示多少条数据
            , cols: [[ //表头
                {type: 'checkbox', fixed: 'left', width: 50}
                , {title: '序号', type: 'numbers', fixed: 'left', width: 50}
                , {field: 'id', title: 'ID', hide: true, width: 100}
                , {field: 'name', title: '菜单名称', width: 100}
                , {field: 'url', title: '对应URL', sort: true, width: 150}
                , {field: 'describe', title: '资源描述', width: 150}
                , {field: 'remarks', title: '备注', width: 150}
                , {
                    field: 'state', title: '使用状态', width: 100, align: 'center', templet: function (d) {
                        if (d.state == 1) {
                            return '<span class="layui-btn layui-btn-xs">启用</span>'
                        } else {
                            return '<span class="layui-btn layui-btn-danger layui-btn-xs">禁用</span>'
                        }
                    }
                }
                , {
                    field: 'createUserId', title: '创建人', width: 150, templet: function (d) {
                        var user = getUserById(d.createUserId);
                        return user.username;
                    }
                }
                , {
                    field: 'createDate', title: '创建时间', width: 150, templet: function (d) {
                        return new Date(d.createDate).toLocaleString('chinese', {hour12: false}).replace(/:d{1,2}$/, ' ');
                    }
                }
                , {
                    field: 'updateUserId', title: '更新人Id', width: 150, templet: function (d) {
                        var user = getUserById(d.updateUserId);
                        return user.username;
                    }
                }
                , {
                    field: 'updateDate', title: '更新时间', width: 150, templet: function (d) {
                        return new Date(d.updateDate).toLocaleString('chinese', {hour12: false}).replace(/:d{1,2}$/, ' ');
                    }
                }
                , {title: '操作', fixed: 'right', align: 'center', toolbar: '#table-opt', width: 150} //这里的toolbar值是模板元素的选择器
            ]]
            , where: {//接口需要的其它参数
                searchContent: searchContent
            }
            , parseData: function (res) { //res 即为原始返回的数据
                return {
                    "code": res.code == 1 ? 0 : 1, //解析接口状态，layui的0为成功
                    "msg": res.msg, //解析提示文本
                    "count": res.data.total, //解析数据长度
                    "data": res.data.data //解析数据列表
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

        //头部工具栏监听事件
        table.on('toolbar(table-filter)', function (obj) {
            //var checkStatus = table.checkStatus(obj.config.id);

            //获取被选中数据
            var checkStatus = table.checkStatus('table1');
            var data = checkStatus.data;

            switch (obj.event) {
                case 'add':
                    layer.msg('添加');
                    addData();  //添加
                    break;
                case 'delete':
                    layer.msg('删除');
                    if (data.length == 0) {
                        layer.alert('请先选择要删除的数据', {
                            time: 3000,
                            icon: 2
                        });
                        return false;
                    } else {
                        var ids = '';
                        var cnt = 0;
                        $.each(data, function (index, d) { //拼装ids
                            if (index == 0) {
                                ids += d.id;
                            } else {
                                ids += ",";
                                ids += d.id;
                            }
                            cnt += 1;
                        });
                        deleteData(ids, cnt); //删除数据
                    }
                    break;
                case 'update':
                    layer.msg('编辑');
                    if (data.length == 0) {
                        layer.alert('请先选择要编辑的数据', {
                            time: 3000,
                            icon: 2
                        });
                        return false;
                    } else if (data.length > 1) {
                        layer.alert('一次只能编辑一条数据', {
                            time: 3000,
                            icon: 2
                        });
                        return false;
                    } else {
                        var id = data[0].id;
                        editData(id);
                    }
                    break;
            }
        });

        //监听表格复选框选择
        table.on('checkbox(table-filter)', function (obj) {
            console.log(obj)
        });

        //监听工具条
        table.on('tool(table-filter)', function (obj) {
            var data = obj.data;
            if (obj.event === 'detail') {
                layer.msg('ID：' + data.id + ' 的查看操作');
            } else if (obj.event === 'del') {
                deleteData(data.id, 1)
            } else if (obj.event === 'edit') {
                editData(data.id);
            }
        });
    });

    function addData() {
        layer.open({
            title: '添加菜单',
            type: 2,
            area: ['1000px', '450px'],
            fix: false, //不固定
            maxmin: true,
            content: '${webRoot}/resource/addOrUpdatePage',
            success: function (layero, index) {
                //                AddLayero = layero;
                //				        (AddLayero);
            },
            end: function () {
                location.reload(); //回调函数，刷新页面
            }
        });
    }

    function editData(id) {
        layer.open({
            title: '编辑菜单',
            type: 2,
            area: ['1000px', '450px'],
            fix: false, //不固定
            maxmin: true,
            content: '${webRoot}/resource/addOrUpdatePage?resourceId=' + id,
            success: function (layero, index) {
            },
            end: function () {
                location.reload(); //回调函数，刷新页面
            }
        });
    }

    //删除
    function deleteData(ids, count) {
        var tipMsg = ''; //弹窗提示信息
        tipMsg = '<div style="text-align: center">即将删除<span style="color: #FF5722;font-size: large"> ' + count +
            ' </span>条数据，<br>删除后<span style="color:#FF5722;font-size: large">数据不可恢复</span>，确定要删除吗？</div>';
        //询问框
        layer.confirm(tipMsg, {
                btn: ['确定', '取消']//按钮
            }
            , function () { //确定之后执行
                var data = {
                    ids: ids
                };
                $.ajax({
                    url: "${webRoot}/resource/delete",
                    type: "post",
                    data: data,
                    dataType: "json",
                    success: function (data) {
                        var jsonData = eval(data); //数据解析
                        var code = jsonData
                        var msg = jsonData.msg;
                        if (code == 1) {
                            layer.alert(msg, {
                                time: 5000,
                                icon: 1
                            });
                        } else {
                            layer.alert(msg, {
                                time: 3000,
                                icon: 2
                            });
                        }
                        location.reload(); //操作后刷新页面
                    }
                });
            });
    }

    /**
     * 通过 id 获取用户
     * @param id
     * @returns {*}
     */
    function getUserById(id) {
        if (id == null || id == '') {
            layer.alert('id不能为空！', {
                time: 3000,
                icon: 2
            });
            return false;
        }
        var user = '';
        var data = {id: id};
        $.ajax({
            url: "${webRoot}/user/getUserById",
            type: "post",
            async: false,    //关闭异步请求
            data: data,
            dataType: "json",
            success: function (data) {
                var jsonData = eval(data); //数据解析
                var code = jsonData.code;
                var msg = jsonData.msg;
                if (code == 1) {
                    user = jsonData.data.user;
                } else {
                    layer.alert(msg, {
                        time: 3000,
                        icon: 2
                    });
                    return false;
                }
            }
        });
        return user;
    }
</script>

</html>