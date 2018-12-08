<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/context/mytags.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>用户信息管理</title>
    <link rel="stylesheet" href="${webRoot}/plug-in/layui-v2.4.5/layui/css/layui.css" charset="UTF-8">
    <link rel="stylesheet" href="${webRoot}/plug-in/bootstrap3.3.5/css/bootstrap.min.css" charset="UTF-8">

    <script src="${webRoot}/plug-in/jquery-3.2.1/jquery-3.2.1.min.js"></script>
    <script src="${webRoot}/plug-in/layui-v2.4.5/layui/layui.all.js"></script>
    <script src="${webRoot}/plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
    <script src="${webRoot}/plug-in/js/utils.js"></script>

</head>

<body>
<div class="layui-tab layui-tab-brief" lay-filter="tab-top">
    <div class="layui-tab-title">
        <li class="layui-this" lay-id="all">全部</li>
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
</script>

<%--表格操作--%>
<script type="text/html" id="table-opt">
    <a class="layui-btn layui-btn-xs layui-btn-normal" lay-event="edit">查看</a>
</script>

<script type="text/javascript">
    var layer_window = ''; 	//定义全局变量,用以储存弹出的窗口的窗口对象
    var searchContent = $("#searchContent").val(); //模糊查询内容
    var table = null;  //layui table
    var element = null; //layui element
    var state = null; //tab标题状态

    $(document).ready(function () {
        loadLayuiElement();//加载 layui element
        //加载表格数据
        tableData();
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
                , height: 550
                , toolbar: '#table-head'
                , title: '菜单管理'
                , url: '${webRoot}/userInfo/list' //数据接口
                , page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                    layout: ['limit', 'count', 'prev', 'page', 'next', 'skip'] //自定义分页布局
                    , limit: 10
                    , limits:[5,10,20,50,100]
                    , prev: '上一页'
                    , next: '下一页'
                    , groups: 5 //只显示 5 个连续页码
                    , first: '首页' //显示首页
                    , last: '尾页' //显示尾页
                }
                , cols: [[ //表头
                    {type: 'checkbox', fixed: 'left', width: 50, align: 'center'}
                    , {title: '序号', type: 'numbers', fixed: 'left', width: 50, align: 'center'}
                    , {field: 'id', title: 'ID', hide: true, width: 100, align: 'center'}
                    , {field: 'username', title: '用户账号', width: 150, align: 'center'}
                    , {field: 'nickname', title: '用户昵称', width: 150, align: 'center'}
                    , {field: 'realName', title: '真实姓名', width: 150, align: 'center'}
                    , {field: 'portraitImg', title: '头像URL', width: 150, align: 'center'}
                    , {field: 'gender', title: '性别', width: 50, align: 'center', templet: function (d) {
                        if (d.gender === 1) {
                            return '<span class="layui-btn layui-btn-xs">男</span>'
                        }
                        if(d.state === 0){
                            return '<span class="layui-btn layui-btn-danger layui-btn-xs">女</span>'
                        }
                    }}
                    , {
                        field: 'birthday', title: '生日', sort: true, width: 180, align: 'center', templet: function (d) {
                            return new Date(d.birthday).toLocaleString('chinese', {hour12: false}).replace(/:d{1,2}$/, ' ');
                        }
                    }
                    , {field: 'address', title: '地址', width: 150, align: 'center'}
                    , {field: 'postalCode', title: '邮政编码', width: 150, align: 'center'}
                    , {field: 'email', title: '邮箱', width: 150, align: 'center'}
                    , {field: 'phone', title: '手机号码', width: 150, align: 'center'}
                    , {field: 'motto', title: '个性签名', width: 150, align: 'center'}
                    , {field: 'describe', title: '个人简介', width: 150, align: 'center'}
                    , {field: 'imgs', title: '个人图片', width: 150, align: 'center'}
                    , {field: 'company', title: '工作单位', width: 150, align: 'center'}
                    , {field: 'position', title: '所处职位', width: 150, align: 'center'}
                    , {field: 'career', title: '职业', width: 150, align: 'center'}
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

            //监听表格复选框选择
            table.on('checkbox(table-filter)', function (obj) {
                console.log(obj)
            });

            //监听工具条
            table.on('tool(table-filter)', function (obj) {
                var data = obj.data;
                var id = data.id;
                /*操作（1：启用，0：禁用）*/
                if (obj.event === 'edit') {    //启用
                    dataEdit(data, state);
                }
            });
        });
    }

    /**
     * 查看详情
     * */
    function dataEdit(id) {
        layer.open({
            title: '用户信息',
            type: 2,
            area: ['1000px', '450px'],
            fix: false, //不固定
            maxmin: true,
            content: '${webRoot}/webpages/user/userInfo.jsp?id=' + id,
            success: function (layero, index) {
                layer_window = layero;   //获取弹出窗口的窗口对象
            },
            end: function () {
                location.reload(); //回调函数，刷新页面
            }
        });
    }

    /**
     * 通过 id 获取用户信息
     * @param id
     * @returns {*}
     */
    function getUserInfoById(id) {
        if (id === null || id === '') {
            layer.alert('id不能为空！', {
                time: 3000,
                icon: 2
            });
            return false;
        }
        var user = null;
        var data = {id: id};
        $.ajax({
            url: "${webRoot}/user/getUserInfoById",
            type: "get",
            async: false,    //关闭异步请求
            data: data,
            dataType: "json",
            success: function (data) {
                var jsonData = eval(data); //数据解析
                var code = jsonData.code;
                var msg = jsonData.msg;
                if (code === 1) {
                    user = jsonData.data.user;
                } else {
                    layer.alert(msg, {
                        time: 3000,
                        icon: 2
                    });
                    return false;
                }
            }
            , error: function (jqXHR, textStatus, errorThrown) {
                ajaxErrorHandler(jqXHR); //ajax请求异常统一处理
            }
        });
        return user;
    }
</script>

</html>