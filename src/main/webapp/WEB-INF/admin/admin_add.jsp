<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page isELIgnored="false" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>云科技</title>
        <link type="text/css" rel="stylesheet" media="all" href="/resources/styles/global.css" />
        <link type="text/css" rel="stylesheet" media="all" href="/resources/styles/global_color.css" />
        <%--w2ul--%>
        <link type="text/css" rel="stylesheet"  href="/resources/w2ui-1.5.rc1/w2ui-1.5.rc1.css" />
        <script src="/resources/js/jquery-3.2.1.js"></script>
        <script type="text/javascript" src="/resources/w2ui-1.5.rc1/w2ui-1.5.rc1.js"></script>

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
            <div id="save_result_info" class="save_fail">保存失败！ 登录名已存在!</div>
            <form id="f" action="/user_admin/addAdmin"  class="main_form">
                    <div class="text_info clearfix"><span>姓名：</span></div>
                    <div class="input_info">
                        <input id="name" name="name" type="text" />
                        <span class="required">*</span>
                        <div class="validate_msg_long"></div>
                    </div>
                    <div class="text_info clearfix"><span>管理员账号：</span></div>
                    <div class="input_info">
                        <input id="admin_code" name="admin_code" type="text"  />
                        <span class="required">*</span>
                        <div class="validate_msg_long"></div>
                    </div>
                    <div class="text_info clearfix"><span>密码：</span></div>
                    <div class="input_info">
                        <input id="password" name="password" type="password"  />
                        <span class="required">*</span>
                        <div class="validate_msg_long"></div>
                    </div>
                    <div class="text_info clearfix"><span>重复密码：</span></div>
                    <div class="input_info">
                        <input id="repassword" name="repassword" type="password"  />
                        <span class="required">*</span>
                        <div class="validate_msg_long"></div>
                    </div>      
                    <div class="text_info clearfix"><span>电话：</span></div>
                    <div class="input_info">
                        <input id="telephone" name="telephone" type="text" class="width200"/>
                        <span class="required">*</span>
                        <div class="validate_msg_medium"></div>
                    </div>
                    <div class="text_info clearfix"><span>Email：</span></div>
                    <div class="input_info">
                        <input id="email" name="email" type="text" class="width200"/>
                        <span class="required">*</span>
                        <div class="validate_msg_medium"></div>
                    </div>
                    <div class="text_info clearfix"><span>角色：</span></div>
                    <div class="input_info_high">
                        <div class="input_info_scroll">
                            <ul id="role">
                                <c:forEach items="${roleList}" var="role">
                                <li><input name="role" type="checkbox" value="${role.id}"/>${role.name}</li>
                                </c:forEach>
                            </ul>
                        </div>
                        <span class="required">*</span>
                        <div class="validate_msg_tiny"></div>
                    </div>
                    <div class="button_info clearfix">
                        <input type="button" value="保存" class="btn_save" onclick="showResult();" />
                        <input type="button" value="取消" class="btn_save" onclick="location.href='/admin_list'"/>
                    </div>
                </form>  
        </div>
        <!--主要区域结束-->
        <br>
        <br>
        <div id="footer">
            <p>Designed by Jaso&reg; Made in DaLian</p>
            <p>版权所有&copy;  J科技有限公司 </p>
        </div>
    </body>

    <script language="javascript" type="text/javascript">


        //保存成功的提示消息
        function showResult() {
            if ($("#name").val().trim() == ''){
                popup();
                return false;
            }
            if ($("#admin_code").val().trim() == ''){
                popup();
                return false;
            }
            if ($("#password").val().trim() == ''){
                popup();
                return false;
            }
            if ($("#repassword").val().trim() == ''){
                popup();
                return false;
            }
            if ($("#telephone").val().trim() == ''){
                popup();
                return false;
            }
            if ($("#email").val().trim() == ''){
                popup();
                return false;
            }

            $("#f").submit();

        }

        function popup() {
            w2popup.open({
                title: ' 提交失败:',
                body: '<div class="w2ui-centered"><h1>请确保表单填写完整!</h1>' +
                '<br><br><br><br><button onclick="popup2()">已填写完整</button></div>'
            });
        }
        function popup2() {
            w2popup.open({
                title: ' 提交失败:',
                body: '<div class="w2ui-centered"><h1>您的登录名已存在,不可使用!</h1>' +
                '<br><br><h1>换个名字试试吧</h1></div>'
            });
        }
        function showResultDiv(flag) {
            var divResult = document.getElementById("save_result_info");
            if (flag)
                divResult.style.display = "block";
            else
                divResult.style.display = "none";
        }
    </script>
</html>
