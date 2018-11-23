<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/context/mytags.jsp" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title></title>
    <link rel="stylesheet" href="../static/css/my_layui.css">
    <link rel="stylesheet" href="${webRoot}/plug-in/layui-v2.4.5/layui/css/layui.css">
    <link rel="stylesheet" href="${webRoot}/plug-in/bootstrap3.3.5/css/bootstrap.min.css">

    <script src="${webRoot}/plug-in/jquery-3.2.1/jquery-3.2.1.min.js"></script>
    <script src="${webRoot}/plug-in/layui-v2.4.5/layui/layui.all.js"></script>
    <script src="${webRoot}/plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
</head>

<body>
<div class="layui-tab layui-tab-brief" lay-filter="demoTitle">
    <ul class="my-title layui-tab-title site-demo-title">
        <li class="layui-this">预览</li>
        <li class="">查看代码</li>
        <li class="">帮助</li>
    </ul>
    <div class="my-layui-body layui-body layui-tab-content site-demo site-demo-body">

        <div class="layui-tab-item layui-show">
            <div class="layui-main">
                <div id="LAY_preview">

                    <fieldset class="layui-elem-field site-demo-button" style="margin-top: 30px;">
                        <legend>按钮主题</legend>
                        <div>
                            <button class="layui-btn layui-btn-primary">原始按钮</button>
                            <button class="layui-btn">默认按钮</button>
                            <button class="layui-btn layui-btn-normal">百搭按钮</button>
                            <button class="layui-btn layui-btn-warm">暖色按钮</button>
                            <button class="layui-btn layui-btn-danger">警告按钮</button>
                            <button class="layui-btn layui-btn-disabled">禁用按钮</button>
                        </div>
                    </fieldset>
                    <fieldset class="layui-elem-field site-demo-button">
                        <legend>按钮尺寸</legend>
                        <div>
                            <button class="layui-btn layui-btn-primary layui-btn-lg">大型按钮</button>
                            <button class="layui-btn layui-btn-primary">默认按钮</button>
                            <button class="layui-btn layui-btn-primary layui-btn-sm">小型按钮</button>
                            <button class="layui-btn layui-btn-primary layui-btn-xs">迷你按钮</button>

                            <br>

                            <button class="layui-btn layui-btn-lg">大型按钮</button>
                            <button class="layui-btn">默认按钮</button>
                            <button class="layui-btn layui-btn-sm">小型按钮</button>
                            <button class="layui-btn layui-btn-xs">迷你按钮</button>

                            <br>

                            <button class="layui-btn layui-btn-lg layui-btn-normal">大型按钮</button>
                            <button class="layui-btn layui-btn-normal">默认按钮</button>
                            <button class="layui-btn layui-btn-sm layui-btn-normal">小型按钮</button>
                            <button class="layui-btn layui-btn-xs layui-btn-normal">迷你按钮</button>

                            <br>

                            <div style="width: 216px; margin: 0;">
                                <!-- layui 2.2.5 新增 -->
                                <button class="layui-btn layui-btn-fluid">流体按钮</button>
                            </div>
                        </div>
                    </fieldset>
                    <fieldset class="layui-elem-field site-demo-button">
                        <legend>灵活的图标按钮（更多图标请阅览：文档-图标）</legend>
                        <div>
                            <button class="layui-btn"><i class="layui-icon"></i></button>
                            <button class="layui-btn"><i class="layui-icon"></i></button>
                            <button class="layui-btn"><i class="layui-icon"></i></button>
                            <button class="layui-btn"><i class="layui-icon"></i></button>
                            <button class="layui-btn"><i class="layui-icon"></i></button>
                            <button class="layui-btn"><i class="layui-icon"></i></button>

                            <br>

                            <button class="layui-btn layui-btn-danger"><i class="layui-icon"></i></button>
                            <button class="layui-btn layui-btn-danger"><i class="layui-icon"></i></button>
                            <button class="layui-btn layui-btn-danger"><i class="layui-icon"></i></button>
                            <button class="layui-btn layui-btn-danger"><i class="layui-icon"></i></button>
                            <button class="layui-btn layui-btn-danger"><i class="layui-icon"></i></button>
                            <button class="layui-btn layui-btn-danger"><i class="layui-icon"></i></button>

                            <br>

                            <button class="layui-btn layui-btn-primary layui-btn-sm"><i class="layui-icon"></i>
                            </button>
                            <button class="layui-btn layui-btn-primary layui-btn-sm"><i class="layui-icon"></i>
                            </button>
                            <button class="layui-btn layui-btn-primary layui-btn-sm"><i class="layui-icon"></i>
                            </button>
                            <button class="layui-btn layui-btn-primary layui-btn-sm"><i class="layui-icon"></i>
                            </button>
                            <button class="layui-btn layui-btn-primary layui-btn-sm"><i class="layui-icon"></i>
                            </button>
                            <button class="layui-btn layui-btn-primary layui-btn-sm"><i class="layui-icon"></i>
                            </button>

                            <button class="layui-btn layui-btn-sm"><i class="layui-icon"></i></button>
                            <button class="layui-btn layui-btn-sm"><i class="layui-icon"></i></button>
                            <button class="layui-btn layui-btn-sm"><i class="layui-icon"></i></button>
                            <button class="layui-btn layui-btn-sm"><i class="layui-icon"></i></button>
                            <button class="layui-btn layui-btn-sm"><i class="layui-icon"></i></button>
                            <button class="layui-btn layui-btn-sm"><i class="layui-icon"></i></button>

                            <button class="layui-btn layui-btn-normal layui-btn-sm"><i class="layui-icon"></i></button>
                            <button class="layui-btn layui-btn-normal layui-btn-sm"><i class="layui-icon"></i></button>
                            <button class="layui-btn layui-btn-normal layui-btn-sm"><i class="layui-icon"></i></button>
                            <button class="layui-btn layui-btn-normal layui-btn-sm"><i class="layui-icon"></i></button>
                            <button class="layui-btn layui-btn-normal layui-btn-sm"><i class="layui-icon"></i></button>
                            <button class="layui-btn layui-btn-normal layui-btn-sm"><i class="layui-icon"></i></button>
                        </div>
                    </fieldset>
                    <fieldset class="layui-elem-field site-demo-button">
                        <legend>还可以是圆角按钮</legend>
                        <div>
                            <button class="layui-btn layui-btn-primary layui-btn-radius">原始按钮</button>
                            <button class="layui-btn layui-btn-radius">默认按钮</button>
                            <button class="layui-btn layui-btn-normal layui-btn-radius">百搭按钮</button>
                            <button class="layui-btn layui-btn-warm layui-btn-radius">暖色按钮</button>
                            <button class="layui-btn layui-btn-danger layui-btn-radius">警告按钮</button>
                            <button class="layui-btn layui-btn-disabled layui-btn-radius">禁用按钮</button>
                        </div>
                    </fieldset>
                    <fieldset class="layui-elem-field site-demo-button">
                        <legend>风格混搭的按钮</legend>
                        <div>
                            <button class="layui-btn layui-btn-lg layui-btn-primary layui-btn-radius">大型加圆角</button>
                            <a href="http://www.layui.com/doc/element/button.html" class="layui-btn" target="_blank">跳转的按钮</a>
                            <button class="layui-btn layui-btn-sm layui-btn-normal"><i class="layui-icon"></i> 删除
                            </button>
                            <button class="layui-btn layui-btn-xs layui-btn-disabled"><i class="layui-icon"></i> 分享
                            </button>
                        </div>
                    </fieldset>

                    <fieldset class="layui-elem-field site-demo-button">
                        <legend>按钮组</legend>
                        <div class="layui-btn-group">
                            <button class="layui-btn">增加</button>
                            <button class="layui-btn ">编辑</button>
                            <button class="layui-btn">删除</button>
                        </div>
                        <div class="layui-btn-group">
                            <button class="layui-btn layui-btn-sm"><i class="layui-icon"></i></button>
                            <button class="layui-btn layui-btn-sm"><i class="layui-icon"></i></button>
                            <button class="layui-btn layui-btn-sm"><i class="layui-icon"></i></button>
                            <button class="layui-btn layui-btn-sm"><i class="layui-icon"></i></button>
                        </div>
                        <div class="layui-btn-group">
                            <button class="layui-btn layui-btn-primary layui-btn-sm">文字</button>
                            <button class="layui-btn layui-btn-primary layui-btn-sm"><i class="layui-icon"></i>
                            </button>
                            <button class="layui-btn layui-btn-primary layui-btn-sm"><i class="layui-icon"></i>
                            </button>
                            <button class="layui-btn layui-btn-primary layui-btn-sm"><i class="layui-icon"></i>
                            </button>
                        </div>
                    </fieldset>
                </div>

                <fieldset class="layui-elem-field layui-field-title">
                    <legend>按钮容器</legend>
                </fieldset>
                <blockquote class="layui-elem-quote layui-quote-nm">
                    layui 2.2.5 开始新增
                </blockquote>
                <div class="layui-btn-container">
                    <button class="layui-btn">按钮一</button>
                    <button class="layui-btn">按钮二</button>
                    <button class="layui-btn">按钮三</button>
                </div>
                <div class="layui-btn-container">
                    <button class="layui-btn">按钮一</button>
                    <button class="layui-btn">按钮二</button>
                    <button class="layui-btn">按钮三</button>
                </div>

            </div>
        </div>

        <div class="layui-tab-item">
					<textarea class="layui-border-box site-demo-text site-demo-code" id="LAY_democode"
                              spellcheck="false" readonly="">&lt;!DOCTYPE html&gt;
						&lt;html&gt;
						&lt;head&gt;
						  &lt;meta charset="utf-8"&gt;
						  &lt;title&gt;layui&lt;/title&gt;
						  &lt;meta name="renderer" content="webkit"&gt;
						  &lt;meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"&gt;
						  &lt;meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"&gt;
						  &lt;link rel="stylesheet" href="//res.layui.com/layui/dist/css/layui.css"  media="all"&gt;
						  &lt;!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 --&gt;
						&lt;/head&gt;
					</textarea>
        </div>

        <div class="layui-tab-item">
            <div class="layui-main">
                <p>如果“查看代码”中的图标字符显示为：，那是正常的。具体在使用时，请参照【文档-图标字体】将其替换为对应的Unicode 字符。</p>

                <div style="margin: 15px 0;">
                    <ins class="adsbygoogle" style="display:inline-block;width:970px;height:90px"
                         data-ad-client="ca-pub-6111334333458862" data-ad-slot="6835627838"></ins>
                </div>

                <fieldset class="layui-elem-field layui-field-title" style="margin-top: 50px;">
                    <legend>相关</legend>
                </fieldset>
                <a class="layui-btn layui-btn-normal" href="/doc/element/button.html" target="_blank">按钮文档</a>
            </div>
        </div>

    </div>
</div>
</body>

<script type="text/javascript">
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
</script>

</html>