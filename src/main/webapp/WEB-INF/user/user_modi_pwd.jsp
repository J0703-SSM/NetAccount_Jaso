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
            //判断输入
            if ($("#oldpwd").val() == "" || $("#newpwd").val() == "" || $("#repwd").val() == "") {
                $("#msg").html("*请填写完整!");
                return false;
            } else {
                $("#msg").html("");
            }

            if ($("#oldpwd").val() != ${applicationScope.loginAdmin.password}) {
                $("#old_msg").html("*旧密码错误!");
                return false;
            } else {
                $("#old_msg").html("");
            }
            if ($("#newpwd").val() == $("#oldpwd").val()) {
                $("#new_msg").html("*新密码不得与旧密码相同!");
                return false;
            } else {
                $("#new_msg").html("");
            }
            if ($("#newpwd").val() != $("#repwd").val()) {
                $("#re_msg").html("*两次输入密码不一致!");
                return false;
            } else {
                $("#re_msg").html("");
            }
            //提交表单
            $.ajax({
                url: "/user_admin/update_user_pwd",
                type: "get",
                data: {
                    "password": $("#newpwd").val()
                },
                success: function () {
                }

            });


//            showResultDiv(true);
//            window.setTimeout("showResultDiv(false);", 3000);

            $("#updateAgain").show();
            $("#f").hide();

        }
        function showResultDiv(flag) {
            var divResult = document.getElementById("save_result_info");
            if (flag)
                divResult.style.display = "block";
            else
                divResult.style.display = "none";
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
        <li><a href="/user_role/findAllRole" class="role_off"></a></li>
        <li><a href="/admin_list" class="admin_off"></a></li>
        <li><a href="/fee_list" class="fee_off"></a></li>
        <li><a href="/account_list" class="account_off"></a></li>
        <li><a href="/service_list" class="service_off"></a></li>
        <li><a href="/bill_list" class="bill_off"></a></li>
        <li><a href="/report_list" class="report_off"></a></li>
        <li><a href="/user_info" class="information_off"></a></li>
        <li><a href="/user_modi_pwd" class="password_on"></a></li>
    </ul>
</div>
<!--导航区域结束-->
<div id="main">

    <div id="updateAgain" class="save_success" style="display: none;text-align: center">
        <h1>温馨提示: 密码修改成功 !</h1>
        <h2>使用您的新密码去登录吧 : <a href="/user_admin/quit">重新登录</a></h2>
    </div>

    <form id="f" action="" class="main_form">
        <div class="text_info clearfix"><span>旧密码：</span></div>
        <div class="input_info">
            <input id="oldpwd" type="password" class="width200 in_pwd"/><span
                class="required">*</span>
            <div id="old_msg" class="validate_msg_medium "></div>
        </div>
        <div class="text_info clearfix"><span>新密码：</span></div>
        <div class="input_info">
            <input id="newpwd" type="password" class="width200 in_pwd"/><span class="required">*</span>
            <div id="new_msg" class="validate_msg_medium "></div>
        </div>
        <div class="text_info clearfix"><span>重复新密码：</span></div>
        <div class="input_info">
            <input id="repwd" type="password" class="width200 in_pwd"/><span class="required">*</span>
            <div id="re_msg" class="validate_msg_medium "></div>
        </div>

        <div class="button_info clearfix">
            <input type="button" value="保存" class="btn_save" onclick="showResult();"/>
            <input type="button" value="取消" class="btn_save" onclick="location.href='/index'"/>
            <br>
            <div id="msg" class="validate_msg_medium "></div>
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
