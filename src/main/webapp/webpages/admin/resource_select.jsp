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
    <script src="${webRoot}/plug-in/js/bootstrap-treeview.min.js" charset="UTF-8"></script>
</head>

<body>
<div class="layui-tab layui-tab-brief" lay-filter="demoTitle">
    <div class="row">
        <div class="text-left col-sm-12">
            <div class="col-sm-4">
                <div id="treeview-selectable" class=""></div>
            </div>
            <div class="col-sm-8 text-center layui-tab-content">
                <table id="tableData" lay-filter="table-filter"></table>
            </div>
        </div>
    </div>
    <footer style="z-index: 999">
        <div class="row">
            <div class="col-sm-offset-2 col-sm-12 text-center">
                <button type="button" class="layui-btn col-sm-4" id="submit">确认选择</button>
                <button type="button" class="layui-btn layui-btn-normal col-sm-4" id="close">关闭并回返</button>
            </div>
        </div>
    </footer>
</div>
</body>

<script type="text/javascript">
    var searchContent = $("#searchContent").val(); //模糊查询内容
    var table = null;  //layui table

    $(document).ready(function () {
        var resourceData = getResourceData();
        var treeData = buildTreeData(resourceData);
        initSelectableTree(treeData);
    });

    /**
     * 获取菜单数据
     * */
    function getResourceData() {
        var returnData = null;
        $.ajax({
            url: "${webRoot}/resource/tree",
            type: "get",
            async: false,    //关闭异步请求
            data: null,
            dataType: "json",
            success: function (data) {
                var jsonData = eval(data); //数据解析
                var code = jsonData.code;
                var msg = jsonData.msg;
                if (code === 1) {
                    returnData = jsonData.data.items;
                } else {
                    layer.alert(msg, {
                        time: 3000,
                        icon: 2
                    });
                    return false;
                }
            }
        });
        return returnData;
    }

    /*构建树形数据*/
    function buildTreeData(data) {
        var tree = [];
        $.each(data, function (index, item) {
            var id = item.id;   /*本节点菜单id*/
            var name = item.name;   /*本节点菜单名称*/
            var parentId = item.parentId;   /*本节点的父节点菜单id*/
            var order = item.order; /*本节点排序，可忽略*/
            var level = item.level; /*本节点层级*/
            var url = item.data.url;   /*本节点url*/
            var iconStyle = item.data.iconStyle;  /*本节点iocn*/
            var children = item.children;   /*子节点*/

            //使用递归方式解析数据
            tree[index] = {
                id: id,
                pid: parentId,
                order: order,
                text: name,
                icon:iconStyle,  /*当前节点上的图标*/
                selectedIcon:iconStyle,  /*当前节点被选择后的图标*/
                href:"${webRoot}/"+url,
                tags: level,
                nodes: buildTreeData(children)
            };
        });
        return tree;
    }

    /*初始化选择树*/
    function initSelectableTree(data) {
        return $('#treeview-selectable').treeview({
            data: data,
            showIcon: true,    /*开启节点图标*/
            enableLinks:false,  /*不启用当前节点的超链接*/
            multiSelect: $('#chk-select-multi').is(':checked'),
            onNodeSelected: function (event, node) {
                console.log(node);
                /*$('#selectable-output').prepend('<p>' + node.text + '</p>');*/
                var id = node.id; //节点数据id
                var parentId = node.pid; //当前节点的父节点数据id
                var condition = {parentId: parentId}; //自定义查询条件

                //数据表格
                tableData(condition);
            },
            onNodeUnselected: function (event, node) {
                /*取消节点选中事件*/
            }
        });
    }

    /**数据表格
    * condition：json字符串查询条件
    * */
    function tableData(condition) {
        //layui数据表格
        layui.use('table', function () {
            table = layui.table;
            //渲染
            table.render({
                id: 'table1'
                , elem: '#tableData'
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
                    condition: JSON.stringify(condition)
                }
                , parseData: function (res) { //res 即为原始返回的数据
                    var code = res.code === 1 ? 0 : 1;
                    var msg = res.msg;
                    var data = null;
                    if (code === 0) {
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

            //监听表格复选框选择
            table.on('checkbox(table-filter)', function (obj) {
                console.log(obj)
            });
        });
    }

    //执行数据返回操作
    $("#submit").click(function () {
        if (table === null || table === '') {
            layer.alert('请先选择数据', {
                time: 3000,
                icon: 2
            });
            return false;
        }

        //获取被选中数据
        var checkStatus = table.checkStatus('table1');
        var items = checkStatus.data;
        var length = items.length;

        if (length === 0) {
            layer.alert('请先选择权限对应的资源', {
                time: 3000,
                icon: 2
            });
            return false;
        }
        if (length > 1) {
            layer.alert('一个权限只能对应一个资源', {
                time: 3000,
                icon: 2
            });
            return false;
        }
        //选中的数据
        var selectedData = {
            id: items[0].id,
            name: items[0].name
        };
        returnData(selectedData);
    });

    //返回被选中的数据
    function returnData(data) {
        if (data === null) {
            layer.msg("请先选择数据", {
                icon: 2,
                time: 2000 //2秒关闭（如果不配置，默认是3秒）
            });
        } else {
            parent.getBackResourceData(data);	//将Json数据传给父窗口
        }
        closeView();
    }

    //关闭
    $("#close").click(function () {
        closeView();
    });

    //关闭当前弹出窗口
    function closeView() {
        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
        parent.layer.close(index); //再执行关闭
    }

</script>

</html>