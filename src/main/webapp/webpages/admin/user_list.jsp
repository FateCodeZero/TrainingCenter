<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/context/mytags.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>普通用户管理</title>
    <link rel="stylesheet" href="${webRoot}/plug-in/layui-v2.4.5/layui/css/layui.css" charset="UTF-8">
    <link rel="stylesheet" href="${webRoot}/plug-in/bootstrap3.3.5/css/bootstrap.min.css" charset="UTF-8">

    <script src="${webRoot}/plug-in/jquery-3.2.1/jquery-3.2.1.min.js" charset="UTF-8"></script>
    <script src="${webRoot}/plug-in/layui-v2.4.5/layui/layui.all.js" charset="UTF-8"></script>
    <script src="${webRoot}/plug-in/bootstrap3.3.5/js/bootstrap.min.js" charset="UTF-8"></script>
</head>

<body>
<div class="layui-tab layui-tab-brief" lay-filter="tab-top">
    <div class="layui-tab-title">
        <li class="layui-this" lay-id="all">全部</li>
        <li lay-id="enable">已启用</li>
        <li lay-id="unEnable">已禁用</li>
        <li lay-id="deleted">已删除</li>
    </div>
    <div class="layui-tab-content">
        <div class="row">
            <div class="col-sm-6"></div>
            <div class="col-sm-6">
                <div class="input-group">
                    <input type="text" class="form-control" id="searchContent" placeholder="模糊查询">
                    <span class="input-group-btn">
                        <button class="btn btn-info" type="button" id="search" title="查找本表的内容">搜索</button>
                    </span>
                </div>
            </div>
        </div>
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
        <button class="layui-btn layui-btn-normal layui-btn-sm" lay-event="add" title="添加用户"><i
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
    <a class="layui-btn layui-btn-xs" lay-event="enable" title="启用用户">启用</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="unEnable" title="禁用用户">禁用</a>
    <a class="layui-btn layui-btn-warm layui-btn-xs" lay-event="lock" title="锁定用户IP">锁IP</a>
    <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="unlock" title="解锁用户IP">解锁</a>
</script>

<script type="text/javascript">
    var layer_window = ''; 	//定义全局变量,用以储存弹出的窗口的窗口对象
    var searchContent = $("#searchContent").val(); //模糊查询内容
    var table = null;  //layui table
    var element = null; //layui element
    var state = null; //tab标题状态

    $(document).ready(function () {
        ajaxErrorHandler(); //ajax请求错误统一处理
        loadLayuiElement();//加载 layui element
        tableData();    //加载数据表格
    });

    function loadLayuiElement() {
        //JavaScript代码区域
        layui.use('element', function () {
            var element = layui.element;
            //监听选项卡切换
            element.on('tab(tab-top)', function (data) {
                console.log(data);
                var lay_id = this.getAttribute('lay-id');//当前Tab标题所在的原始DOM元素
                var condition = null;
                switch (lay_id) {
                    case 'all':     //全部数据
                        state = '';
                        condition = {
                            searchContent: searchContent,
                            state: state
                        };
                        layuiReload(condition);
                        break;
                    case 'enable':     //已启用的数据
                        state = 1;
                        condition = {
                            searchContent: searchContent,
                            state: state
                        };
                        layuiReload(condition);
                        break;
                    case 'unEnable':     //已禁用的数据
                        state = 0;
                        condition = {
                            searchContent: searchContent,
                            state: state
                        };
                        layuiReload(condition);
                        break;
                    case 'deleted':     //已删除的数据
                        state = -1;
                        condition = {
                            searchContent: searchContent,
                            state: state
                        };
                        layuiReload(condition);
                        break;
                }
            });
            element.render('tab(tab-top)');
        });
    }

    /**
     * 数据表格重新加载
     * condition：自定义查询条件
     * */
    function layuiReload(condition) {
        if (condition !== null && condition !== ''){
            var state = condition.state;
            var searchTxt = condition.searchContent;
            if (state === null || state === ''){
                //保证tab返回全部时，能查询所有
                condition = {
                    searchContent:searchTxt
                };
            }
            table.reload('table1', {
                page: {
                    curr: 1 //重新从第 1 页开始
                }
                ,where: { //接口需要的其它参数
                    condition: JSON.stringify(condition)
                }
            });
        }
    }
    /**
     * 模糊查询
     */
    $("#search").click(function () {
        var searchContent = $("#searchContent").val(); //模糊查询内容
        var condition = {
            searchContent: searchContent
            ,state:state
        };
        layuiReload(condition);
    });

    function tableData() {
        //layui数据表格
        layui.use('table', function () {
            table = layui.table;
            //渲染
            table.render({
                id: 'table1'
                , elem: '#tableData'
                , height: 450
                , title: '普通用户管理'
                , url: '${webRoot}/user/list' //数据接口
                , page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                    layout: ['limit', 'count', 'prev', 'page', 'next', 'skip'] //自定义分页布局
                    , limit: 10
                    , prev: '上一页'
                    , next: '下一页'
                    , groups: 5 //只显示 5 个连续页码
                    , first: true //显示首页
                    , last: true //显示尾页
                }
                , cols: [[ //表头
                    {type: 'checkbox', fixed: 'left', width: 50, align: 'center'}
                    , {title: '序号', type: 'numbers', fixed: 'left', width: 50, align: 'center'}
                    , {field: 'id', title: 'ID', hide: true, width: 100, align: 'center'}
                    , {field: 'username', title: '用户账号', width: 150, align: 'center'}
                    , {field: 'loginIP', title: '登录IP', width: 150, align: 'center'}
                    , {
                        field: 'unlockedFlag', title: 'IP锁定状态', width: 100, align: 'center', templet: function (d) {
                            if (d.unlockedFlag === 1) {
                                return '<span class="layui-btn layui-btn-normal layui-btn-xs">正常</span>'
                            }
                            if (d.unlockedFlag === 0) {
                                return '<span class="layui-btn layui-btn-danger layui-btn-xs">锁定</span>'
                            }
                        }
                    }
                    , {
                        field: 'state', title: '使用状态', width: 100, align: 'center', templet: function (d) {
                            if (d.state === 1) {
                                return '<span class="layui-btn layui-btn-xs">已启用</span>'
                            }
                            if (d.state === 0) {
                                return '<span class="layui-btn layui-btn-danger layui-btn-xs">已禁用</span>'
                            }
                            if (d.state === -1) {
                                return '<span class="layui-btn layui-btn-disabled layui-btn-xs">已删除</span>'
                            }
                        }
                    }
                    , {
                        field: 'registerTime', title: '注册时间', sort: true, width: 150, align: 'center', templet: function (d) {
                            return new Date(d.registerTime).toLocaleString('chinese', {hour12: false}).replace(/:d{1,2}$/, ' ');
                        }
                    }
                    , {
                        field: 'lastLoginTime',
                        title: '最后登录时间',
                        sort: true,
                        width: 200,
                        align: 'center',
                        templet: function (d) {
                            return new Date(d.lastLoginTime).toLocaleString('chinese', {hour12: false}).replace(/:d{1,2}$/, ' ');
                        }
                    }
                    <%--<sec:authorize access="hasPermission('/webpages/admin/resource_list.jsp','UPDATE')">--%>
                    , {title: '操作', fixed: 'right', toolbar: '#table-opt', width: 250, align: 'center'} //这里的toolbar值是模板元素的选择器
                    <%--</sec:authorize>--%>
                ]]
                , where: {//接口需要的其它参数
                    condition: JSON.stringify({searchContent: searchContent})
                }
                , parseData: function (res) { //res 即为原始返回的数据
                    var code = res.code === 1 ? 0 : 1;
                    var msg = res.msg;
                    var data = null;
                    var count = 0;
                    if (code === 0) {
                        data = res.data.items;
                        count = res.data.total;
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

            //监听工具条
            table.on('tool(table-filter)', function (obj) {
                var data = obj.data;
                var id = data.id;/*操作的数据Id*/

                var state = 1;/*启/禁用操作（1：启用，0：禁用）*/
                var locked = 1;/*IP锁定操作（1：锁定，0：正常）*/

                if (obj.event === 'enable') {    //启用
                    state = 1;
                    enableOpt(data, state);
                } else if (obj.event === 'unEnable') {  //禁用
                    state = 0;
                    enableOpt(data, state);
                } else if (obj.event === 'lock') {  /*锁定IP*/
                    locked = 0;
                    IPLockedOpt(data,locked);
                } else if (obj.event === 'unlock') {  /*解锁IP*/
                    locked = 1;
                    IPLockedOpt(data,locked);
                }
            });
        });
    }

    //启/禁用操作
    function enableOpt(obj, state) {
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
                username: obj.username,
                state: state
            };
            $.ajax({
                url: "${webRoot}/user/update",
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

    /*IP锁定/解锁操作*/
    /**
     * @return {boolean}
     */
    function IPLockedOpt(obj, locked) {
        if (obj.id === null || obj.id === '' || locked === null || locked === '') {
            layer.alert('请先选择要操作的数据', {
                time: 3000,
                icon: 2
            });
            return false;
        } else {
            /*将更新所必须的字段一起传过去*/
            var data = {
                id: obj.id,
                username: obj.username,
                state: obj.state,
                unlockedFlag:locked,
                loginIP:obj.loginIP
            };
            $.ajax({
                url: "${webRoot}/user/update",
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
</script>

</html>