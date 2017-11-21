<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page isELIgnored="false" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
        //获得所有权限(高级查询)
        $.ajax({
            url: "/user_role/findAllPrivi",
            type: "get",
            success: function (data) {
                var _html = "";
                $.each(data, function (i, n) {
                    _html += '<option value=' + n.id + '>' + n.name + '</option>';

                });
                $("#selModules").append(_html);

            }

        });


        //显示角色详细信息
        function showDetail(flag, a) {
            var detailDiv = a.parentNode.getElementsByTagName("div")[0];
            if (flag) {
                detailDiv.style.display = "block";
            }
            else
                detailDiv.style.display = "none";
        }
        //重置密码
        function resetPwd() {
            if ($("input:checkbox:checked").length == 0) {
                alert("请至少选择一条数据！");
            }else {
                $("input:checkbox:checked").each(function () {

                    $.ajax({
                        url: "/user_admin/resetPwd",
                        type: 'get',
                        data: {
                            id: $(this).val()
                        },
                        success: function () {
                        }

                    });
                    $("#msg").html("重置密码成功!");
                    document.getElementById("operate_result_info").style.display = "block";
                });
            }


        }

        //删除
        function deleteAdmin(id) {

            popup(id)
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
                $(function () {
                    $.post(
                            "/user_admin/deleteAdmin",
                            {
                                id: data
                            }
                    )
                });


                document.getElementById("operate_result_info").style.display = "block";
            }else {
                w2alert("× 密码错误!");
            }

        }



        //全选
        function selectAdmins(inputObj) {
            var inputArray = document.getElementById("datalist").getElementsByTagName("input");
            for (var i = 1; i < inputArray.length; i++) {
                if (inputArray[i].type == "checkbox") {
                    inputArray[i].checked = inputObj.checked;
                }
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
            <li><a href="/user_role/findAllRole" class="role_off"></a></li>
        </c:if>
        <c:if test="${loginPrivi['2'] != null}">
            <li><a href="/admin_list" class="admin_on"></a></li>
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
    <form action="" method="">
        <!--查询-->
        <div class="search_add">
            <%--<div>--%>
                <%--模块：--%>
                <%--<select id="selModules" class="select_search">--%>
                    <%--<option>全部</option>--%>
                <%--</select>--%>
            <%--</div>--%>
            <%--<div>角色：<input type="text" value="" class="text_search width200"/></div>--%>
            <%--<div><input type="button" value="搜索" class="btn_search"/></div>--%>
            <input type="button" value="密码重置" class="btn_add" onclick="resetPwd();"/>
            <input type="button" value="增加" class="btn_add" onclick="location.href='/user_admin/findAllRole';"/>
        </div>
        <!--删除和密码重置的操作提示-->
        <div id="operate_result_info" class="operate_fail">
            <img src="../../resources/images/close.png"
                 onclick="this.parentNode.style.display='none';window.location.reload();"/>
            <span id="msg">删除成功!</span><!--密码重置失败！数据并发错误。-->
        </div>
        <!--数据区域：用表格展示数据-->
        <div id="data">
            <table id="datalist">
                <tr>
                    <th class="th_select_all">
                        <input type="checkbox" onclick="selectAdmins(this);"/>
                        <span>全选</span>
                    </th>
                    <th>管理员ID</th>
                    <th>姓名</th>
                    <th>登录名</th>
                    <th>电话</th>
                    <th>电子邮件</th>
                    <th>授权日期</th>
                    <th class="width100">拥有角色</th>
                    <th></th>
                </tr>


                <c:forEach items="${applicationScope.adminList}" var="admin">
                    <tr>
                        <td><input type="checkbox" value="${admin.id}"/></td>
                        <td>${admin.id}</td>
                        <td>${admin.name}</td>
                        <td>${admin.admin_code}</td>
                        <td>${admin.telephone}</td>
                        <td>${admin.email}</td>
                        <td>${admin.enrolldate}</td>
                        <td>
                            <a class="summary" onmouseover="showDetail(true,this);"
                               onmouseout="showDetail(false,this);">
                                <c:forEach items="${admin.roleList}" var="role" varStatus="v">
                                    <c:if test="${v.first}">${role.name}</c:if>
                                </c:forEach>
                            </a>
                            <!--浮动的详细信息-->
                            <c:if test="${fn:length(admin.roleList) gt 1}">
                                <div class="detail_info">
                                    <c:forEach items="${admin.roleList}" var="role">${role.name}&nbsp;&nbsp;</c:forEach>
                                </div>
                            </c:if>

                        </td>
                        <td class="td_modi">
                            <%--<input type="button" value="修改" class="btn_modify"--%>
                                   <%--onclick="location.href='#';"/>--%>
                            <input type="button" value="删除" class="btn_delete"
                                   onclick="deleteAdmin(${admin.id});"/>
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
        <%--</div>                    --%>
    </form>
</div>
<!--主要区域结束-->
<br>
<br>
<div id="footer">
    <p>Designed by Jaso&reg; Made in DaLian</p>
    <p>版权所有&copy; J科技有限公司 </p>
</div>
</body>
</html>
