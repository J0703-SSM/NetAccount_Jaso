<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page isELIgnored="false" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title></title>
        <link type="text/css" rel="stylesheet" media="all" href="/resources/styles/global.css" />
        <link type="text/css" rel="stylesheet" media="all" href="/resources/styles/global_color.css" />
    </head>
    <body class="index">
        <!--导航区域开始-->
        <div id="index_navi">
            <ul id="menu">
                <li><a href="/index" class="index_on"></a></li>
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

                <li><a href="/user_info" class="information_off"></a></li>
                <li><a href="/user_modi_pwd" class="password_off"></a></li>
            </ul>
        </div>
    </body>
</html>
