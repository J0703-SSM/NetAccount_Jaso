<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>登录系统</title>
    <link type="text/css" rel="stylesheet" media="all" href="/resources/styles/global.css"/>
    <link type="text/css" rel="stylesheet" media="all" href="/resources/styles/global_color.css"/>

    <link type="text/css" rel="stylesheet" href="/resources/w2ui-1.5.rc1/w2ui-1.5.rc1.css"/>
    <script src="/resources/js/jquery-3.2.1.js"></script>
    <script type="text/javascript" src="/resources/w2ui-1.5.rc1/w2ui-1.5.rc1.js"></script>

</head>
<body class="index">
<div class="login_box">
    <form id="loginForm" action="/user_admin/login">
        <table>
            <tr>
                <td class="login_info">账号：</td>
                <td colspan="2"><input name="admin_code" type="text" class="width150"
                                       placeholder="用户名 或 邮箱"/></td>
                <td class="login_error_info">
                    <span class="required">${nameError.defaultMessage}</span>
                </td>
            </tr>
            <tr>
                <td class="login_info">密码：</td>
                <td colspan="2"><input name="password" type="password" class="width150"
                                       placeholder="注册密码"/></td>
                <td>
                    <span class="required">${pwdError.defaultMessage}</span>
                </td>
            </tr>
            <tr>
                <td class="login_info">验证码：</td>
                <td class="width70"><input name="verifyCodeInput" type="text" class="width70"
                                           placeholder="(不分大小写)"/></td>
                <td><img src="/user_admin/getVerifyCode" alt="验证码"
                         title="点击更换" id="verifyCodeImage" onclick="changeImage()"/>
                </td>
                <td>
                    <span class="required">${vcError}</span>
                </td>
            </tr>
            <tr>
                <td class="login_info">
                    <a class="w2ui-btn" onclick="popup()">忘记密码?</a>
                </td>
                <td class="login_button" colspan="2">
                    <input id="sub" type="image" src="/resources/images/login_btn.png">
                </td>
                <td>
                    <span class="required">${error}</span>
                </td>
            </tr>
        </table>
    </form>

</div>
<script>

    <%--点击更新验证--%>
    function changeImage() {
        $("#verifyCodeImage").attr('src', '/user_admin/getVerifyCode?a=' + Math.random());
    }

    //        忘记密码
    function popup() {
        w2popup.open({
            width: 580,
            height: 350,
            title: '{ 找 回 密 码 }',
            body: '<div class="w2ui-centered"><h1>通过您注册时使用的邮箱,验证找回密码.</h1>' +
            '<br><br><br>  <input id="email" type="text" class="width200"/></div>',
            buttons: '<button class="w2ui-btn" onclick="verifyEmail()">验证邮箱</button>' +
            '<button class="w2ui-btn" onclick="w2popup.close();">我又想起来了</button>',
            showMax: true
        });
    }
    //验证邮箱
    function verifyEmail() {
//        popup1();
        $.ajax({
            url: "/user_admin/verifyEmail",
            type: "get",
            data: {
                "email": $("#email").val()
            },
            success: function (data) {
                if (data == 1) {
                    //ok
                    popup1();
                } else {
                    //no
                    popup3();
                }
            }

        });
    }

    function popup1() {
        w2popup.lock("loading...", true);
        setTimeout(function () { w2popup.unlock(); }, 3000);
        w2alert("新的初始密码正发送到您的邮箱...");
        $.ajax({
            url: "/user_admin/sendEmail",
            type: "get",
            data: {
                "email": $("#email").val()
            },
            success: function (data) {
                if (data == 1){

                    w2popup.open({
                        title: ' 邮件已发送成功:',
                        body: '<div class="w2ui-centered"><h1>√  新密码已发送到邮箱,请注意查收!</h1>'
                    });
                }
            }

        });

    }

    //邮箱无效
    function popup3() {
        w2alert("× 邮箱地址不存在,请重新确认您的邮箱!");
    }


</script>
</body>
</html>
