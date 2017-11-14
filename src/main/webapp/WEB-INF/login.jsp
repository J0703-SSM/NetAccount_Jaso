<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>登录系统</title>
        <link type="text/css" rel="stylesheet" media="all" href="/resources/styles/global.css" />
        <link type="text/css" rel="stylesheet" media="all" href="/resources/styles/global_color.css" />
        <script src="/resources/js/jquery-3.2.1.js"></script>
    </head>
    <body class="index">
        <div class="login_box">
            <form id="loginForm" action="/user_admin/login">
            <table>
                <tr>
                    <td class="login_info">账号：</td>
                    <td colspan="2"><input name="admin_code" type="text" class="width150"
                    placeholder="字母、数字和下划线"/></td>
                    <td class="login_error_info">
                        <span class="required">${nameError.defaultMessage}</span>
                    </td>
                </tr>
                <tr>
                    <td class="login_info">密码：</td>
                    <td colspan="2"><input name="password" type="password" class="width150"
                    placeholder="字母、数字和下划线"/></td>
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
                    <td></td>
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
            $("#verifyCodeImage").attr('src', '/user_admin/getVerifyCode?a='+Math.random());
        }
    </script>
    </body>
</html>
