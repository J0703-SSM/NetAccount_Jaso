<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page isELIgnored="false" %>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link type="text/css" rel="stylesheet" media="all" href="/resources/styles/global.css"/>
    <link type="text/css" rel="stylesheet" media="all" href="/resources/styles/global_color.css"/>
    <script src="/resources/js/jquery-3.2.1.js"></script>
    <script language="javascript" type="text/javascript">
        //保存成功的提示信息
        function showResult() {
            //判断输入格式
            if ($("#name").val() == "" || $("#tel").val() == "" || $("#email").val() == "") {
                $("#msg").show();
                return false;
            }else {
                $("#msg").hide();
            }

            //姓名
            if (isString($("#name").val())) {
                $("#name_msg").html("*只允许输入字符!");

                return false;
            } else {
                $("#name_msg").html("√");

            }
            //手机号
            if (!isMobile($("#tel").val())) {
                $("#tel_msg").html("*请输入正确移动电话");
                return false;
            } else {
                $("#tel_msg").html("√");

            }
            //邮箱
            if (!isEmail($("#email").val())) {
                $("#email_msg").html("*请输入正确邮箱");
                return false;
            } else {
                $("#email_msg").html("√");

            }


            //提交表单
            $.ajax({
                url: "/user_admin/edit_user_info",
                type: "get",
                data: {
                    "name": $("#name").val(),
                    "telephone": $("#tel").val(),
                    "email": $("#email").val()
                },
                success: function () {}

            });
            showResultDiv(true);
            window.setTimeout("showResultDiv(false);", 3000);

        }
        function showResultDiv(flag) {
            var divResult = document.getElementById("save_result_info");
            if (flag)
                divResult.style.display = "block";
            else
                divResult.style.display = "none";
        }

        function isMobile(tel) {
            reg = /^(\+\d{2,3}\-)?\d{11}$/;
            return reg.test(tel);
        }

        function isEmail(email) {
            reg = /^\w{3,}@\w+(\.\w+)+$/;
            return reg.test(email);
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
            <li><a href="/user_role/findAllRole" class="role_off"></a></li>
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
        <li><a href="/user_info" class="information_on"></a></li>
        <li><a href="/user_modi_pwd" class="password_off"></a></li>
    </ul>
</div>
<!--导航区域结束-->
<!--主要区域开始-->
<div id="main">
    <!--保存操作后的提示信息：成功或者失败-->
    <div id="save_result_info" class="save_success">保存成功！</div><!--保存失败，数据并发错误！-->
    <%--表单--%>
    <form action="" class="main_form" id="f">
        <div class="text_info clearfix"><span>管理员账号：</span></div>
        <div class="input_info">
            <input type="text" readonly="readonly" class="readonly " value=
                    "${applicationScope.loginAdmin.admin_code}"/>
        </div>

        <div class="text_info clearfix"><span>角色：</span></div>
        <div class="input_info">
            <input type="text" readonly="readonly" class="readonly width200"
                   value="<c:forEach items="${applicationScope.loginAdmin.roleList}" var="role" >${role.name}&nbsp;&nbsp;</c:forEach>"/>

        </div>

        <div class="text_info clearfix"><span>姓名：</span></div>
        <div class="input_info">
            <input id="name" name="name" type="text" value="${applicationScope.loginAdmin.name}"/>
            <span id="name_msg" class="required"></span>
        </div>

        <div class="text_info clearfix"><span>电话：</span></div>
        <div class="input_info">
            <input id="tel" name="telephone" type="text" class="width200"
                   value="${applicationScope.loginAdmin.telephone}"/>
            <span id="tel_msg" class="required"></span>
        </div>

        <div class="text_info clearfix"><span>Email：</span></div>
        <div class="input_info">
            <input id="email" name="email" type="text" class="width200" value="${applicationScope.loginAdmin.email}"/>
            <span id="email_msg" class="required"></span>
        </div>

        <div class="text_info clearfix"><span>创建时间：</span></div>
        <div class="input_info">
            <input type="text" readonly="readonly" class="readonly width200"
                   value="${applicationScope.loginAdmin.enrolldate}"/>
        </div>

        <div class="button_info clearfix">
            <input type="button" value="保存" class="btn_save" onclick="showResult();"/>
            <input type="button" value="取消" class="btn_save" onclick="location.href='/index'"/>
            <br>
            <br>
            <div id="msg" class="validate_msg_short error_msg" style="display: none">*请将信息填写完整! 否则无法确定此操作!</div>
        </div>
    </form>
</div>
<!--主要区域结束-->
<div id="footer">
    <p>Designed by Jaso&reg; Made in DaLian</p>
    <p>版权所有&copy; J科技有限公司 </p>
</div>
</body>
</html>
