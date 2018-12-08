<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/context/mytags.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>权限选择</title>
    <link rel="stylesheet" href="${webRoot}/plug-in/layui-v2.4.5/layui/css/layui.css" charset="UTF-8">
    <link rel="stylesheet" href="${webRoot}/plug-in/bootstrap3.3.5/css/bootstrap.min.css" charset="UTF-8">

    <script src="${webRoot}/plug-in/jquery-3.2.1/jquery-3.2.1.min.js" charset="UTF-8"></script>
    <script src="${webRoot}/plug-in/layui-v2.4.5/layui/layui.all.js" charset="UTF-8"></script>
    <script src="${webRoot}/plug-in/bootstrap3.3.5/js/bootstrap.min.js" charset="UTF-8"></script>
    <script src="${webRoot}/plug-in/js/bootstrap-treeview.min.js"></script>
    <script src="${webRoot}/plug-in/js/utils.js"></script>
</head>

<body>
<div class="layui-tab layui-tab-brief" lay-filter="demoTitle">
    <div class="row">
        <div class="text-left col-sm-12">
            <div class="col-sm-4">
                <div class="text-center" style="color: #FF5722">菜单可读授权</div>
                <div id="treeView-checkbox" class=""></div>
            </div>
            <div class="col-sm-8 text-center layui-tab-content">
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
                <div class="text-center" style="color: #FF5722;">菜单详细授权，此处勾选后记得保存哟~</div>
                <div class="row">
                    <table id="tableData" lay-filter="table-filter"></table>
                </div>
            </div>
        </div>
    </div>
</div>
<footer style="z-index: 999">
    <div class="row">
        <div class="col-sm-offset-2 col-sm-12 text-center">
            <button type="button" class="layui-btn col-sm-4" id="submit">保存授权</button>
            <button type="button" class="layui-btn layui-btn-normal col-sm-4" id="close">关闭并回返</button>
        </div>
    </div>
</footer>
</body>

<script type="text/javascript">
    var table = null;  //layui table
    /*当前要授权的角色id*/
    var roleId = '';
    /*菜单数据*/
    var resourceData = null;
    /*权限数据*/
    var permissionData = null;
    /*菜单树所需要的数据*/
    var treeData = null;
    /*当前授权的页面菜单id*/
    var currentResourceId = null;
    var searchContent = $("#searchContent").val(); //模糊查询内容

    $(document).ready(function () {

        /*从URL获取对象ID,获取当前要授权的角色对象id*/
        roleId = getUrlParam('id');
        /*获取菜单数据*/
        resourceData = getResourceData();
        /*获取当前角色所含有的所有权限数据*/
        permissionData = getPermissionsByRoleId(roleId);
        /*提取权限数据中的菜单id*/
        var resourceIds = getResourceIdsByPermissions(permissionData);
        /*构建菜单树所需要的数据*/
        treeData = buildTreeData(resourceData, resourceIds);

        /*console.log(treeData);*/
        /*初始化Checkbox菜单树*/
        initCheckboxTree(treeData);
    });

    /*获取菜单资源*/
    function getResourceData() {
        var returnData = null;
        $.ajax({
            url: "${webRoot}/resource/tree",
            type: "post",
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
                }
            }
            , error: function (jqXHR, textStatus, errorThrown) {
                ajaxErrorHandler(jqXHR); //ajax请求异常统一处理
            }
        });
        return returnData;
    }

    /*获取当前角色所含有的所有权限*/
    function getPermissionsByRoleId(roleId) {
        var permissions = null;
        if (roleId !== null && roleId !== '') {
            var data = {
                roleId: roleId
            };
            $.ajax({
                url: "${webRoot}/permission/getPermissionsByRoleId",
                type: "get",
                async: false,    //关闭异步请求
                data: data,
                dataType: "json",
                success: function (data) {
                    var jsonData = eval(data);
                    var code = jsonData.code;
                    var msg = jsonData.msg;
                    if (code === 1) {
                        permissions = jsonData.data.items;
                    } else {
                        layer.alert(msg, {
                            time: 3000,
                            icon: 2
                        });
                    }
                }
                , error: function (jqXHR, textStatus, errorThrown) {
                    ajaxErrorHandler(jqXHR); //ajax请求异常统一处理
                }
            });
        }
        return permissions;
    }

    /*提取出权限中的菜单id*/
    function getResourceIdsByPermissions(permissions) {
        var ids = '';
        if (permissions !== null && permissions !== '') {
            $.each(permissions, function (index, permission) {
                if (index === 0) {
                    ids += permission.resourceId;
                } else {
                    ids += ",";
                    ids += permission.resourceId;
                }
            });
        }
        return ids;
    }

    /*构建树形数据
    * resourceData：菜单数据
    * permissionResourceIds：当前角色中所含的权限对应的菜单id
    * */
    function buildTreeData(resourceData, permissionResourceIds) {
        var tree = [];
        $.each(resourceData, function (index, item) {
            /*本节点菜单id*/
            var id = item.id;
            /*本节点菜单名称*/
            var name = item.name;
            /*本节点的父节点菜单id*/
            var parentId = item.parentId;
            /*本节点排序*/
            var order = item.order;
            /*本节点层级*/
            var level = item.level;
            /*本节点url*/
            var url = item.data.url;
            /*本节点iocn*/
            var iconStyle = item.data.iconStyle;
            /*子节点*/
            var children = item.children;

            var checked = false;  //是否处于checked状态
            /*若当前菜单在处在当前角色的权限集合中，则让其处于被选中状态*/
            if (permissionResourceIds.indexOf(id) !== -1) {
                checked = true;
            }

            /*使用递归方式解析数据*/
            tree[index] = {
                id: id,
                pid: parentId,
                order: order,
                text: name,
                icon: iconStyle, /*当前节点上的图标*/
                selectedIcon: iconStyle, /*当前节点被选择后的图标*/
                href: "${webRoot}/" + url,
                tags: level,
                state: {
                    /*一个节点的初始状态*/
                    checked: checked  /*是否处于checked状态*/
                },
                nodes: buildTreeData(children, permissionResourceIds)
            };
        });
        return tree;
    }

    /*初始化选择树*/
    function initCheckboxTree(data) {
        return $('#treeView-checkbox').treeview({
            data: data, /*加载的树形json数据*/
            showIcon: true, /*开启节点图标*/
            showCheckbox: true, /*开启Checkbox*/
            enableLinks: false, /*不启用当前节点的超链接*/
            onNodeChecked: function (event, node) {     //节点选择事件
                var selectNodes = getChildNodeIdArr(node);
                console.log(node);

                //选中被选种节点及其所有子节点
                if (selectNodes) { //判断子节点不为空，选中所有子节点
                    $('#treeView-checkbox').treeview('checkNode', [selectNodes, {silent: true}]);
                }
                //所有子节点被选中时，选中其父节点
                var parentNode = $("#treeView-checkbox").treeview("getNode", node.parentId);
                setParentNodeCheck(node);
                //后续各种操作……
            },
            onNodeUnchecked: function (event, node) {//节点取消选择事件
                var selectNodes = getChildNodeIdArr(node);//获取所有子节点
                //撤销选中分支
                if (selectNodes) {//判断子节点不为空，执行取消选中所有子节点操作
                    $('#treeView-checkbox').treeview('uncheckNode', [selectNodes, {silent: true}]);
                }
            },
            onNodeSelected: function (event, node) { //节点单击事件
                console.log(node);
                var id = node.id;  //节点数据id
                var parentId = node.pid; //当前节点的父节点数据id
                var condition = { //自定义查询条件
                    resourceId: id
                    , searchContent: searchContent
                };
                currentResourceId = id;  //设置当前页面菜单id
                tableData(condition);
            }
        });
    }

    //判获取所有子节点
    function getChildNodeIdArr(node) {
        var ts = [];
        if (node.nodes) {
            for (var x in node.nodes) {
                ts.push(node.nodes[x].nodeId);
                if (node.nodes[x].nodes) {
                    var getNodeDieDai = getChildNodeIdArr(node.nodes[x]);
                    for (var j in getNodeDieDai) {
                        ts.push(getNodeDieDai[j]);
                    }
                }
            }
        } else {
            ts.push(node.nodeId);
        }
        return ts;
    }

    //设置父节点
    function setParentNodeCheck(node) {
        var parentNode = $("#treeView-checkbox").treeview("getNode", node.parentId);
        if (parentNode.nodes) {
            var checkedCount = 0;
            for (var x in parentNode.nodes) {
                if (parentNode.nodes[x].state.checked) {
                    checkedCount++;
                } else {
                    break;
                }
            }
            if (checkedCount === parentNode.nodes.length) {
                $("#treeView-checkbox").treeview("checkNode", parentNode.nodeId);
                setParentNodeCheck(parentNode);
            }
        }
    }

    /**
     * 模糊查询
     */
    $("#search").click(function () {
        var searchContent = $("#searchContent").val(); //模糊查询内容
        var condition = {
            resourceId: currentResourceId
            , searchContent: searchContent
        };
        table.reload('table1', {
            page: {
                curr: 1 //重新从第 1 页开始
            }
            , where: { //接口需要的其它参数
                condition: JSON.stringify(condition)
            }
        });
    });

    /*数据表格
    * condition：json字符串查询条件
    * */
    function tableData(condition) {
        if (condition === null || condition === '') {
            layer.alert('查询条件不能为空', {
                time: 3000,
                icon: 2
            });
            return false;
        }
        layui.use('table', function () {
            table = layui.table;

            //渲染
            table.render({
                id: 'table1'
                , elem: '#tableData'
                , title: '菜单管理'
                , url: '${webRoot}/permission/select' //数据接口
                , page: true //开启分页
                , limit: 10 //每页显示多少条数据
                , cols: [[ //表头
                    {type: 'checkbox', fixed: 'left', align: 'center'}
                    , {title: '序号', type: 'numbers', fixed: 'left', align: 'center'}
                    , {field: 'id', title: 'ID', hide: true, align: 'center'}
                    , {field: 'name', title: '权限名称', align: 'center'}
                    , {
                        field: 'operations', title: '可操作权限', width: 200, align: 'center', templet: function (d) {
                            var operations = d.operations;
                            return operationsToStr(operations);
                        }
                    }, {
                        field: 'resourceId',
                        title: '对应资源',
                        hide: true,
                        width: 150,
                        align: 'center',
                        templet: function (d) {
                            var resourceId = d.resourceId;
                            var resource = getResourceById(resourceId);
                            return resource.name;
                        }
                    }
                ]]
                , where: {//接口需要的其它参数
                    condition: JSON.stringify(condition)
                }
                , parseData: function (res) { //数据转换，layui-2.4及以后支持，res 即为原始返回的数据
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

                    /*让角色已有的权限处于被选中状态*/
                    var permissionIds = '';
                    $.each(permissionData, function (index, permission) {
                        if (index === 0) {
                            permissionIds += permission.id;
                        } else {
                            permissionIds += ',';
                            permissionIds += permission.id;
                        }
                    });
                    $.each(data, function (index, item) {
                        var id = item.id;
                        if (permissionIds.indexOf(id) !== -1) {
                            /*让数据处于被选中状态*/
                            data[index].LAY_CHECKED = true;
                        }
                    });
                    //返回要渲染的数据
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

    /**
     * 获取所有被选中节点
     */
    function getSelectedNodes() {
        var selectedNodes = $('#treeView-checkbox').treeview('getChecked');
        var resourceIds = '';
        $.each(selectedNodes, function (index, node) {
            if (index === 0) {
                resourceIds += node.id;
            } else {
                resourceIds += ',';
                resourceIds += node.id;
            }
        });
        console.log(resourceIds);
        return resourceIds;
    }

    /*获取被选中的表格数据*/
    function getTableSelectedData() {
        //获取被选中的表单数据
        var checkStatus = table.checkStatus('table1');
        var items = checkStatus.data;

        var resourceId = currentResourceId; //当前授权菜单id
        //获取表格选中的操作权限
        var permissionIds = '';    //选中的权限数据

        //遍历获取被选中数据的id
        $.each(items, function (index, item) {
            if (index === 0) {
                permissionIds += item.id;
            } else {
                permissionIds += ',';
                permissionIds += item.id;
            }
        });
        return {
            resourceId: resourceId,
            permissionIds: permissionIds
        };
    }

    //授权提交
    $("#submit").click(function () {
        if (table === null || table === '') {
            layer.alert('请先选择数据', {
                time: 3000,
                icon: 2
            });
            return false;
        }

        /*获取被选中的tree数据，即菜单数据*/
        var resourceIds = getSelectedNodes();

        /*获取被选中的菜单数据，即当前菜单的授权数据*/
        var permissionData = getTableSelectedData();

        /*保证当前授权菜单被选中
        if (permissionData !== null && (resourceIds === null || resourceIds === '')) {
            resourceIds += currentResourceId;
        }*/

        var grantData = {
            roleId: roleId,
            permissionData: permissionData,
            resourceIds: resourceIds
        };
        console.log(grantData);

        var data = {
            grantData: JSON.stringify(grantData)
        };
        $.ajax({
            url: "${webRoot}/role/grant",
            type: "post",
            data: data,
            dataType: "json",
            success: function (data) {
                var jsonData = eval(data); //数据解析
                var code = jsonData.code;
                var msg = jsonData.msg;
                if (code === 1) {
                    msg += ",关闭当前窗口后起效~";
                    layer.alert(msg, {
                        time: 3000,
                        icon: 1
                    });
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

    /**
     * 通过 id 获取资源
     * @param id
     * @returns {*}
     */
    function getResourceById(id) {
        if (id === null || id === '') {
            layer.alert('查询对象不能为空！', {
                time: 3000,
                icon: 2
            });
            return null;
        }
        var resource = null;
        var data = {id: id};
        $.ajax({
            url: "${webRoot}/resource/getResourceById",
            type: "get",
            async: false,    //关闭异步请求
            data: data,
            dataType: "json",
            success: function (data) {
                var jsonData = eval(data); //数据解析
                var code = jsonData.code;
                var msg = jsonData.msg;
                if (code === 1) {
                    resource = jsonData.data.resource;
                } else {
                    layer.alert(msg, {
                        time: 3000,
                        icon: 2
                    });
                }
            }
            , error: function (jqXHR, textStatus, errorThrown) {
                ajaxErrorHandler(jqXHR); //ajax请求异常统一处理
            }
        });
        return resource;
    }

    /**
     * 可操作代码转为中文
     * @param operations
     * @returns {string}
     */
    function operationsToStr(operations) {
        var optStr = '';
        if (operations === null || operations === '') {
            return optStr;
        } else {
            var arr = operations.trim().split(",");
            $.each(arr, function (index, opt) {
                if (index === 0) {
                    switch (opt) {
                        case 'READ':
                            optStr += '查看';
                            break;
                        case 'CREATE':
                            optStr += '添加';
                            break;
                        case 'UPDATE':
                            optStr += '更新';
                            break;
                        case 'DELETE':
                            optStr += '删除';
                            break;
                    }
                } else {
                    switch (opt) {
                        case 'READ':
                            optStr += '、查看';
                            break;
                        case 'CREATE':
                            optStr += '、添加';
                            break;
                        case 'UPDATE':
                            optStr += '、更新';
                            break;
                        case 'DELETE':
                            optStr += '、删除';
                            break;
                    }
                }
            });
        }
        return optStr;
    }

</script>

</html>