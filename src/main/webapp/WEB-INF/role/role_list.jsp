<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page isELIgnored="false" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link type="text/css" rel="stylesheet" media="all" href="/resources/styles/global.css"/>
    <link type="text/css" rel="stylesheet" media="all" href="/resources/styles/global_color.css"/>

    <link type="text/css" rel="stylesheet" href="/resources/w2ui-1.5.rc1/w2ui-1.5.rc1.css"/>
    <script src="/resources/js/jquery-3.2.1.js"></script>
    <script type="text/javascript" src="/resources/w2ui-1.5.rc1/w2ui-1.5.rc1.js"></script>

    <script language="javascript" type="text/javascript">


        function deleteRole(data) {

            //验证身份
            popup(data);


        }


        function popup(data) {
            w2popup.open({
                width: 300,
                height: 200,
                title: '{ 身份验证 }',
                body: '<div class="w2ui-centered">请输入密码:' +
                '<input id="pwd" type="password" class="width200"/></div>',
                buttons: '<button class="w2ui-btn" onclick="password('+data+')">残忍删除</button>' +
                '<button class="w2ui-btn" onclick="w2popup.close();">还是不删除了吧</button>',
                showMax: true
            });
        }

        function password(data) {
            if ($("#pwd").val() == ${loginAdmin.password}) {
                w2popup.close();
                $("#msg").html("执行删除操作后, 不可恢复!");
                document.getElementById("operate_result_info").style.display = "block";
                //删除
                //如果此角色有人,不能删
                $.ajax({
                    url: "/user_role/selectByid",
                    type: "get",
                    data: {
                        "id": data
                    },
                    success: function (result) {
                        if (result != 0) {
                            $("#msg").html("此角色不可删除!");
                            document.getElementById("operate_result_info").style.display = "block";
                            return false;
                        } else {
                            $.ajax({
                                url: "/user_role/delByid",
                                type: "get",
                                data: {
                                    "id": data
                                }, success: function () {
                                }
                            });
                            document.getElementById("operate_result_info").style.display = "block";

                        }
                    }
                });
            }else {
                w2alert("× 密码错误!");
            }

        }

    </script>
</head>
<body>
<!--Logo区域开始-->
<div id="header">
    <img src="../../resources/images/logo.png" alt="logo" class="left"/>
    <a href="/user_admin/quit">[退出]</a>
</div>
<!--Logo区域结束-->
<!--导航区域开始-->
<div id="navi">
    <ul id="menu">
        <li><a href="/index" class="index_off"></a></li>
        <c:if test="${loginPrivi['1'] != null}">
            <li><a href="/user_role/findAllRole" class="role_on"></a></li>
        </c:if>
        <c:if test="${loginPrivi['2'] != null}">
            <li><a href="/admin_list" class="admin_off"></a></li>
        </c:if>
        <c:if test="${loginPrivi['3'] != null}">
            <li><a href="/fee_list" class="fee_off"></a></li>
        </c:if>
        <c:if test="${loginPrivi['4'] != null}">
            <li><a href="/account_list" class="account_off"></a></li>
        </c:if>
        <c:if test="${loginPrivi['5'] != null}">
            <li><a href="/service_list" class="service_off"></a></li>
        </c:if>
        <c:if test="${loginPrivi['6'] != null}">
            <li><a href="/bill_list" class="bill_off"></a></li>
        </c:if>
        <c:if test="${loginPrivi['7'] != null}">
            <li><a href="/report_list" class="report_off"></a></li>
        </c:if>
        <li><a href="/user_info" class="information_off"></a></li>
        <li><a href="/user_modi_pwd" class="password_off"></a></li>
    </ul>
</div>
<!--导航区域结束-->
<!--主要区域开始-->
<div id="main">
    <form>
        <!--添加-->
        <div class="search_add">
            <input type="button" value="增加" class="btn_add" onclick="location.href='/role_add';"/>
        </div>
        <!--删除的操作提示-->
        <div id="operate_result_info" class="operate_fail">
            <img src="../../resources/images/close.png"
                 onclick="this.parentNode.style.display='none'; window.location.reload();"/>
            <span id="msg">删除成功！</span>
        </div> <!--删除错误！该角色被使用，不能删除。-->


        <!--数据区域：用表格展示数据-->
        <div id="data">
            <table id="datalist">
                <tr>
                    <th>角色 ID</th>
                    <th>角色名称</th>
                    <th class="width600">拥有的权限</th>
                    <th class="td_modi"></th>
                </tr>
                <c:forEach items="${roleList}" var="role">
                    <tr>
                        <td>${role.id}</td>
                        <td>${role.name}</td>
                        <td>
                            <c:forEach items="${role.privilegeList}" var="p">
                                ${p.name} &nbsp;
                            </c:forEach>
                        </td>
                        <td>
                            <input type="button" value="修改" class="btn_modify"
                                   onclick="location.href='/user_role/findByid/'+${role.id};"/>
                            <input type="button" value="删除" class="btn_delete"
                                   onclick="deleteRole(${role.id});"/>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>

        <!--分页-->
        <%--<div id="pages">--%>
        <%--<a href="#">上一页</a>--%>
        <%--<a href="#" class="current_page">1</a>--%>
        <%--<a href="#">2</a>--%>
        <%--<a href="#">3</a>--%>
        <%--<a href="#">4</a>--%>
        <%--<a href="#">5</a>--%>
        <%--<a href="#">下一页</a>--%>
        <%--</div>--%>

    </form>
</div>
<!--主要区域结束-->
<br>
<br>
<br>
<div id="footer">
    <p>Designed by Jaso&reg; Made in DaLian</p>
    <p>版权所有&copy; J科技有限公司 </p>
</div>
</body>
</html>
