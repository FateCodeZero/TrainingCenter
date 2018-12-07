<%--
  Created by IntelliJ IDEA.
  User: Sky
  Date: 2018/12/6
  Time: 17:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/context/mytags.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>培训动态管理</title>
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

<script type="text/javascript">
    var layer_window = ''; 	//定义全局变量,用以储存弹出的窗口的窗口对象
    var searchContent = $("#searchContent").val(); //模糊查询内容
    var table = null;  //layui table
    var element = null; //layui element
    var state = null; //tab标题状态

    $(document).ready(function () {
        ajaxErrorHandler(); //ajax请求错误统一处理
        loadLayuiElement();//加载 layui element
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
               , toolbar: '#table-head'
               , title: '菜单管理'
               , url: '${webRoot}/trainingDynamic/listPage' //数据接口
               , page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                   layout: ['limit', 'count', 'prev', 'page', 'next', 'skip'] //自定义分页布局
                   , limit: 10
                   , prev: '上一页'
                   , next: '下一页'
                   , groups: 5 //只显示 5 个连续页码
                   , first: true //显示首页
                   , last: true //显示尾页
               }
               ,height:550
               , cols: [[ //表头
                   {type: 'checkbox', fixed: 'left', width: 50, align: 'center'}
                   , {title: '序号', type: 'numbers', fixed: 'left', width: 50, align: 'center'}
                   , {field: 'id', title: 'id', hide: true, width: 100, align: 'center'}
                   , {field: 'title', title: '标题', width: 200, align: 'center'}
                   , {field: 'content', title: '培训内容', width: 200, align: 'center'}
                   , {field: 'imgs', title: '图片', width: 150}
                   , {field: 'remarks', title: '备注', width: 150, align: 'center'}
                   , {
                       field: 'createUserId', title: '创建人', width: 150, align: 'center', templet: function (d) {
                           var user = getUserById(d.createUserId);
                           return user.username;
                       }
                   }
                   , {
                       field: 'createDate',
                       title: '创建时间',
                       sort: true,
                       width: 180,
                       align: 'center',
                       templet: function (d) {
                           return new Date(d.createDate).toLocaleString('chinese', {hour12: false}).replace(/:d{1,2}$/, ' ');
                       }
                   }
                   , {
                       field: 'updateUserId', title: '更新人Id', width: 150, align: 'center', templet: function (d) {
                           var user = getUserById(d.updateUserId);
                           return user.username;
                       }
                   }
                   , {
                       field: 'updateDate',
                       title: '更新时间',
                       sort: true,
                       width: 180,
                       align: 'center',
                       templet: function (d) {
                           return new Date(d.updateDate).toLocaleString('chinese', {hour12: false}).replace(/:d{1,2}$/, ' ');
                       }
                   }
                   <%--<sec:authorize access="hasPermission('/webpages/admin/resource_list.jsp','UPDATE')">--%>
                   /* , {title: '操作', fixed: 'right', toolbar: '#table-opt', width: 150, align: 'center'} *///这里的toolbar值是模板元素的选择器
                   <%--</sec:authorize>--%>
               ]]
               , where: {//接口需要的其它参数
                   searchContent: searchContent
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

       });
   }

    /*添加培训动态*/
    function addData() {
        layer.open({
            title: '添加培训动态',
            type: 2,
            area: ['1100px', '550px'],
            fix: false, //不固定
            maxmin: true,
            content: '${webRoot}/webpages/admin/trainingDynamic_add.jsp',
            success: function (layero, index) {
                layer_window = layero;   //获取弹出窗口的窗口对象
            },
            end: function () {
                location.reload(); //回调函数，刷新页面
            }
        });
    }

    /*编辑培训动态*/
    function editData(id) {
        layer.open({
            title: '编辑培训动态',
            type: 2,
            area: ['1100px', '550px'],
            fix: false, //不固定
            maxmin: true,
            content: '${webRoot}/webpages/admin/trainingDynamic_edit.jsp?id=' + id,
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
                    url: "${webRoot}/trainingDynamic/delete",
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

    /**
     * 通过 id 获取用户
     * @param id
     * @returns {*}
     */
    function getUserById(id) {
        if (id === null || id === '') {
            /*layer.alert('id不能为空！', {
                time: 3000,
                icon: 2
            });*/
            return false;
        }
        var user = '';
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