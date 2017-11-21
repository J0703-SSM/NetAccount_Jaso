<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page isELIgnored="false" %>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link type="text/css" rel="stylesheet" media="all" href="${pageContext.request.contextPath}/resources/styles/global.css"/>
    <link type="text/css" rel="stylesheet" media="all" href="${pageContext.request.contextPath}/resources/styles/global_color.css"/>
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.2.1.js"></script>
    <script language="javascript" type="text/javascript">
        //保存成功的提示信息
        function showResult() {
            //判断输入
            if ($("#oldpwd").val() == "" || $("#newpwd").val() == "" || $("#repwd").val() == "") {
                $("#msg").show();
                return false;
            }else {
                $("#msg").hide();
            }

            if ($("#oldpwd").val() != ${applicationScope.loginAdmin.password}) {
                $("#old_msg").html("*旧密码错误!");
                return false;
            } else {
                $("#old_msg").html("√");
            }

            if (!isPassword($("#newpwd").val())){
                $("#new_msg").html("*密码由3~8位数字字母组成");
                return false;
            } else {
                $("#new_msg").html("√");
            }
            if ($("#newpwd").val() == $("#oldpwd").val()) {
                $("#new_msg").html("*新密码不得与旧密码相同!");
                return false;
            } else {
                $("#new_msg").html("√");
            }
            if ($("#newpwd").val() != $("#repwd").val()) {
                $("#re_msg").html("*两次输入密码不一致!");
                return false;
            } else {
                $("#re_msg").html("√");
            }
            //提交表单
            $.ajax({
                url: "${pageContext.request.contextPath}/user_admin/update_user_pwd",
                type: "get",
                data: {
                    "password": $("#newpwd").val()
                },
                success: function () {
                }

            });

            $("#updateAgain").show();
            $("#f").hide();

        }

        function isPassword(str) {
            reg = /^[a-zA-Z0-9]{3,8}$/;
            return reg.test(str);
        }


    </script>
</head>
<body>
<!--Logo区域开始-->
<div id="header">
    <img src="${pageContext.request.contextPath}../../resources/images/logo.png" alt="logo" class="left"/>
    <a href="${pageContext.request.contextPath}/user_admin/quit">[退出]</a>
</div>
<!--Logo区域结束-->
<!--导航区域开始-->
<div id="navi">
    <ul id="menu">
        <li><a href="/index" class="index_off"></a></li>
        <c:if test="${loginPrivi['1'] != null}">
            <li><a href="${pageContext.request.contextPath}/user_role/findAllRole" class="role_off"></a></li>
        </c:if>
        <c:if test="${loginPrivi['2'] != null}">
            <li><a href="${pageContext.request.contextPath}/admin_list" class="admin_off"></a></li>
        </c:if>
        <c:if test="${loginPrivi['3'] != null}">
            <li><a href="${pageContext.request.contextPath}/fee_list" class="fee_off"></a></li>
        </c:if>
        <c:if test="${loginPrivi['4'] != null}">
            <li><a href="${pageContext.request.contextPath}/account_list" class="account_off"></a></li>
        </c:if>
        <c:if test="${loginPrivi['5'] != null}">
            <li><a href="${pageContext.request.contextPath}/service_list" class="service_off"></a></li>
        </c:if>
        <c:if test="${loginPrivi['6'] != null}">
            <li><a href="${pageContext.request.contextPath}/bill_list" class="bill_off"></a></li>
        </c:if>
        <c:if test="${loginPrivi['7'] != null}">
            <li><a href="${pageContext.request.contextPath}/report_list" class="report_off"></a></li>
        </c:if>
        <li><a href="${pageContext.request.contextPath}/user_info" class="information_off"></a></li>
        <li><a href="${pageContext.request.contextPath}/user_modi_pwd" class="password_on"></a></li>
    </ul>
</div>
<!--导航区域结束-->
<div id="main">

    <div id="updateAgain" class="save_success" style="display: none;text-align: center">
        <h1>温馨提示: 密码修改成功 !</h1>
        <br>
        <h2>使用您的新密码去登录吧 : <a href="${pageContext.request.contextPath}/user_admin/quit">重新登录</a></h2>
    </div>

    <form id="f"class="main_form">
        <div class="text_info clearfix"><span>旧密码：</span></div>
        <div class="input_info">
            <input id="oldpwd" type="password" class="width200 in_pwd"/>
            <span id="old_msg" class="required"></span>
        </div>
        <div class="text_info clearfix"><span>新密码：</span></div>
        <div class="input_info">
            <input id="newpwd" type="password" class="width200 in_pwd"/>
            <span id="new_msg" class="required"></span>
        </div>
        <div class="text_info clearfix"><span>重复新密码：</span></div>
        <div class="input_info">
            <input id="repwd" type="password" class="width200 in_pwd"/>
            <span id="re_msg" class="required"></span>
        </div>

        <div class="button_info clearfix">
            <input type="button" value="保存" class="btn_save" onclick="showResult();"/>
            <input type="button" value="取消" class="btn_save" onclick="location.href='${pageContext.request.contextPath}/index'"/>
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
