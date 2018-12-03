<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/context/mytags.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>管理员用户管理</title>
    <link rel="stylesheet" href="${webRoot}/plug-in/layui-v2.4.5/layui/css/layui.css" charset="UTF-8">
    <link rel="stylesheet" href="${webRoot}/plug-in/bootstrap3.3.5/css/bootstrap.min.css" charset="UTF-8">

    <script src="${webRoot}/plug-in/jquery-3.2.1/jquery-3.2.1.min.js" charset="UTF-8"></script>
    <script src="${webRoot}/plug-in/layui-v2.4.5/layui/layui.all.js" charset="UTF-8"></script>
    <script src="${webRoot}/plug-in/bootstrap3.3.5/js/bootstrap.min.js" charset="UTF-8"></script>
</head>

<body>
<div class="layui-tab layui-tab-brief" lay-filter="demoTitle">
    <div class="layui-tab-title" lay-filter="tab-top">
        <li class="layui-this" lay-id="all">全部</li>
        <li lay-id="enable">已启用</li>
        <li lay-id="unEnable">已禁用</li>
    </div>
    <div class="layui-tab-content">
        <div class="row">
            <%--<div class="col-sm-1"></div>--%>
            <div class="text-left col-sm-12">
                <table id="tableData" lay-filter="table-filter"></table>
            </div>
            <%--<div class="col-sm-1"></div>--%>
        </div>
    </div>
</div>
</body>
<%--头部工具栏--%>
<script type="text/html" id="table-head">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-normal layui-btn-sm" lay-event="add" title="添加菜单"><i
                class="layui-icon layui-icon-add-circle"></i> 添加
        </button>
        <button class="layui-btn layui-btn-sm" lay-event="update" title="编辑菜单"><i
                class="layui-icon layui-icon-edit"></i> 编辑
        </button>
        <button class="layui-btn layui-btn-danger layui-btn-sm" lay-event="delete" title="批量删除菜单"><i
                class="layui-icon layui-icon-delete"></i> 批量删除
        </button>
    </div>
</script>

<%--表格操作--%>
<script type="text/html" id="table-opt">
    <a class="layui-btn layui-btn-xs layui-btn-normal" lay-event="grant">授权</a>
    <a class="layui-btn layui-btn-xs" lay-event="enable">启用</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="unEnable">禁用</a>
</script>

<script type="text/javascript">
    var layer_window = ''; 	//定义全局变量,用以储存弹出的窗口的窗口对象
    var searchContent = $("#searchContent").val(); //模糊查询内容
    var table;  //layui table

    //JavaScript代码区域
    layui.use('element', function () {
        var element = layui.element;
        //监听选项卡切换
        element.on('tab', function (data) {
            var lay_id = this.getAttribute('lay-id');
            console.log(lay_id); //当前Tab标题所在的原始DOM元素
            /*if (lay_id === 'enable'){
                table.reload('table1',{
                    where: {//接口需要的其它参数
                        searchContent: 1
                    }
                });
            }*/
        });
        element.render('tab');
    });

    //layui数据表格
    layui.use('table', function () {
        table = layui.table;
        //渲染
        table.render({
            id: 'table1'
            , elem: '#tableData'
            , toolbar: '#table-head'
            , title: '用户管理'
            , url: '${webRoot}/user/list_admin' //数据接口
            , page: true //开启分页
            , limit: 10 //每页显示多少条数据
            , cols: [[ //表头
                {type: 'checkbox', fixed: 'left', width: 50, align: 'center'}
                , {title: '序号', type: 'numbers', fixed: 'left', width: 50, align: 'center'}
                , {field: 'id', title: 'ID', hide: true, width: 100, align: 'center'}
                , {field: 'username', title: '用户账号', width: 150, align: 'center'}
                , {field: 'loginIP', title: '登录IP', width: 150, align: 'center'}
                , {
                    field: 'unlockedFlag', title: 'IP锁定状态', width: 100, align: 'center', templet: function (d) {
                        if (d.unlockedFlag === 1) {
                            return '<span class="layui-btn layui-btn-xs">已启用</span>'
                        }
                        if(d.unlockedFlag === 0){
                            return '<span class="layui-btn layui-btn-danger layui-btn-xs">已禁用</span>'
                        }
                        if(d.unlockedFlag === -1){
                            return '<span class="layui-btn layui-btn-disabled layui-btn-xs">已删除</span>'
                        }
                    }
                }
                , {
                    field: 'state', title: '使用状态', width: 100, align: 'center', templet: function (d) {
                        if (d.state === 1) {
                            return '<span class="layui-btn layui-btn-xs">已启用</span>'
                        }
                        if(d.state === 0){
                            return '<span class="layui-btn layui-btn-danger layui-btn-xs">已禁用</span>'
                        }
                        if(d.state === -1){
                            return '<span class="layui-btn layui-btn-disabled layui-btn-xs">已删除</span>'
                        }
                    }
                }
                , {
                    field: 'registerTime', title: '注册时间', width: 150, align: 'center', templet: function (d) {
                        return new Date(d.registerTime).toLocaleString('chinese', {hour12: false}).replace(/:d{1,2}$/, ' ');
                    }
                }
                , {
                    field: 'lastLoginTime', title: '创建时间', sort: true, width: 180, align: 'center', templet: function (d) {
                        return new Date(d.lastLoginTime).toLocaleString('chinese', {hour12: false}).replace(/:d{1,2}$/, ' ');
                    }
                }
                <%--<sec:authorize access="hasPermission('/webpages/admin/resource_list.jsp','UPDATE')">--%>
                , {title: '操作', fixed: 'right', toolbar: '#table-opt', width: 180, align: 'center'} //这里的toolbar值是模板元素的选择器
                <%--</sec:authorize>--%>
            ]]
            , where: {//接口需要的其它参数
                condition: JSON.stringify({searchContent:searchContent})
            }
            , parseData: function (res) { //res 即为原始返回的数据
                var code = res.code === 1 ? 0 : 1;
                var msg = res.msg;
                var data = null;
                if (code === 0){
                    data = res.data.items;
                }
                var count = 0;
                if (data !== null) {
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

        //头部工具栏监听事件
        table.on('toolbar(table-filter)', function (obj) {
            //var checkStatus = table.checkStatus(obj.config.id);

            //获取被选中数据
            var checkStatus = table.checkStatus('table1');
            var data = checkStatus.data;

            if (data.length === 0 && obj.event !== 'add') {
                layer.alert('请先选择要操作的数据', {
                    time: 3000,
                    icon: 2
                });
                return false;
            } else {
                switch (obj.event) {
                    case 'add':     //添加
                        addData();
                        break;
                    case 'delete':  //删除

                        var ids = '';
                        var cnt = 0;
                        $.each(data, function (index, d) { //拼装ids
                            if (index === 0) {
                                ids += d.id;
                            } else {
                                ids += ",";
                                ids += d.id;
                            }
                            cnt += 1;
                        });
                        deleteData(ids, cnt); //删除数据
                        break;
                    case 'update':  //编辑
                        if (data.length > 1) {
                            layer.alert('一次只能编辑一条数据', {
                                time: 3000,
                                icon: 2
                            });
                            return false;
                        } else {
                            editData(data[0].id);
                        }
                        break;
                    case 'detail':
                        if (data.length > 1) {
                            layer.alert('一次只能查看一条数据', {
                                time: 3000,
                                icon: 2
                            });
                            return false;
                        } else {
                            layer.msg("ID:【" + data[0].id + "】的查看操作");
                        }
                        break;
                }
            }
        });

        //监听表格复选框选择
        table.on('checkbox(table-filter)', function (obj) {
            console.log(obj)
        });

        //监听工具条
        table.on('tool(table-filter)', function (obj) {
            var data = obj.data;
            var id = data.id;
            /*操作的数据Id*/
            var state = 1;
            /*操作（1：启用，0：禁用）*/
            if (obj.event === 'enable') {    //启用
                state = 1;
                enableOpt(data, state);
            } else if (obj.event === 'unEnable') {  //禁用
                state = 0;
                enableOpt(data,state);
            }else if (obj.event === 'grant'){ //授权
                layer.open({
                    title: '角色授权',
                    type: 2,
                    area: ['1000px', '450px'],
                    fix: false, //不固定
                    maxmin: true,
                    content: '${webRoot}/webpages/admin/permission_select.jsp?id='+id,
                    success: function (layero, index) {
                        layer_window = layero;   //获取弹出窗口的窗口对象
                    },
                    end: function () {
                        location.reload(); //回调函数，刷新页面
                    }
                });
            }
        });
    });

    function addData() {
        layer.open({
            title: '添加用户',
            type: 2,
            area: ['1000px', '450px'],
            fix: false, //不固定
            maxmin: true,
            content: '${webRoot}/webpages/admin/role_add.jsp',
            success: function (layero, index) {
                layer_window = layero;   //获取弹出窗口的窗口对象
            },
            end: function () {
                location.reload(); //回调函数，刷新页面
            }
        });
    }

    function editData(id) {
        layer.open({
            title: '编辑角色',
            type: 2,
            area: ['1000px', '450px'],
            fix: false, //不固定
            maxmin: true,
            content: '${webRoot}/webpages/admin/role_edit.jsp?id=' + id,
            success: function (layero, index) {
                layer_window = layero;   //获取弹出窗口的窗口对象
            },
            end: function () {
                location.reload(); //回调函数，刷新页面
            }
        });
    }

    //获取弹出窗口返回的json格式的数据
    function getBackPermissionData(JsonData) {		//返回权限数据
        var resourceSelectWindow = window[layer_window.find('iframe')[0]['name']];	//获取子窗口的窗口对象
        resourceSelectWindow.window.setPermissionData(JsonData);		//由弹出窗口的窗口对象去调用弹出窗口的方法
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
                    url: "${webRoot}/role/delete",
                    type: "post",
                    data: data,
                    dataType: "json",
                    success: function (data) {
                        var jsonData = eval(data); //数据解析
                        var code = jsonData.code;
                        var msg = jsonData.msg;
                        if (code === 1) {
                            layer.alert(msg, {
                                time: 3000,
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

    //启/禁用操作
    function enableOpt(obj,state) {
        if (obj.id === null || obj.id === '' || state === null || state === '') {
            layer.alert('请先选择要操作的数据', {
                time: 3000,
                icon: 2
            });
            return false;
        } else {
            /*将更新所必须的字段一起传过去*/
            var data = {
                id: obj.id,
                name: obj.name,
                state: state,
                resourceId: obj.resourceId
            };
            $.ajax({
                url: "${webRoot}/role/update",
                type: "post",
                data: data,
                dataType: "json",
                success: function (data) {
                    var jsonData = eval(data);
                    var code = jsonData.code;
                    var msg = jsonData.msg;
                    if (code === 1) {
                        layer.msg(msg);
                    } else {
                        layer.alert(msg, {
                            time: 3000,
                            icon: 2
                        });
                    }
                    location.reload(); //操作后刷新页面
                }
            });
        }
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
        var user = null;
        var data = {id: id};
        $.ajax({
            url: "${webRoot}/user/getUserById",
            type: "get",
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