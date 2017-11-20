<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page isELIgnored="false" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link type="text/css" rel="stylesheet" media="all" href="/resources/styles/global.css"/>
    <link type="text/css" rel="stylesheet" media="all" href="/resources/styles/global_color.css"/>
    <script src="/resources/js/jquery-3.2.1.js"></script>

    <script language="javascript" type="text/javascript">
        //保存成功的提示消息
        function showResult() {

            //表单判空
            if ($("#role_name").val() == "") {
                $("#name_msg").html("*请填写!");
                return false;
            } else {
                $("#name_msg").html("√")
            }

            if (isString($("#role_name").val())) {
                $("#name_msg").html("*请填写字符格式名称!");
                return false;
            } else {
                $("#name_msg").html("√")
            }


            //多选框数据存数组
            var privis = [];
            var sel = $('input[name = privi]');
            var judge = false;
            for (var i = 0; i < sel.length; i++) {
                if (sel[i].checked) {
                    privis.push(sel[i].value);
                    judge = true;
                    $("#sel_msg").html("")
                }
            }
            if (!judge) {
                $("#sel_msg").html("*至少选择一个权限!");
                return false;
            }


            //提交表单
            $.ajax({
                url: "/user_role/editRole",
                type: "get",
                data: {
                    "privilegeList": privis,
                    "name": $("#role_name").val(),
                    "id":${role.id}
                },
                success: function (data) {
                    if (data == 0) {
                        $("#name_msg").html("×");
                        $("#save_result_info").html("角色名称存在,换个名字试试吧");
                        showResultDiv(false);
                        window.setTimeout("showResultDiv(false);", 3000);
                    } else {
                        showResultDiv(false);
                        window.setTimeout("showResultDiv(false);", 3000);
                    }
                }
            });

        }
        function showResultDiv(flag) {
            var divResult = document.getElementById("save_result_info");
            if (!flag)
                divResult.style.display = "block";
            else
                divResult.style.display = "none";
        }
        function isString(name) {
            reg = /^[a-z,A-Z]+$/;
            return reg.test(name);
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
    <!--保存操作后的提示信息：成功或者失败-->
    <div id="save_result_info" class="save_success">编辑成功</div>

    <form  class="main_form">
        <div class="text_info clearfix"><span>角色名称：</span></div>
        <div class="input_info">
            <input id="role_name" type="text" class="width200" value="${role.name}"/>
            <span id="name_msg" class="required"></span>
        </div>
        <div class="text_info clearfix"><span>设置权限：</span></div>
        <div class="input_info_high">
            <div class="input_info_scroll">
                <ul>
                    <c:forEach items="${allPrivi}" var="privi">
                        <li><input name="privi" type="checkbox"
                        <c:forEach items="${role.privilegeList}" var="p">
                        <c:if test="${p.id == privi.id}">
                                   checked="checked"
                        </c:if>
                            </c:forEach>
                            value="${privi.id}"/>${privi.name}</li>
                    </c:forEach>

                </ul>
            </div>
            <span id="sel_msg" class="required"></span>
        </div>
        <div class="button_info clearfix">
            <input type="button" value="保存" class="btn_save" onclick="showResult();"/>
            <input type="button" value="取消" class="btn_save" onclick="location.href='/user_role/findAllRole'"/>
        </div>
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
