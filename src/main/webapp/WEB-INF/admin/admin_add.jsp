<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page isELIgnored="false" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>云科技</title>
        <link type="text/css" rel="stylesheet" media="all" href="/resources/styles/global.css" />
        <link type="text/css" rel="stylesheet" media="all" href="/resources/styles/global_color.css" />
        <script src="/resources/js/jquery-3.2.1.js"></script>
        <script language="javascript" type="text/javascript">

            //表单验证
            $.ajax({
                url: "/user_admin/addAdmin",
                type: "get",
                data: {
                    admin_code:$("#admin_code").val()
                },
                success: function (data) {
                    if (data == '0'){
                        showResultDiv(true)
                    }
                }
            });


            //保存成功的提示消息
            function showResult() {
                $("#f").submit();

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
                <li><a href="/admin_list" class="admin_on"></a></li>
                <li><a href="/fee_list" class="fee_off"></a></li>
                <li><a href="/account_list" class="account_off"></a></li>
                <li><a href="/service_list" class="service_off"></a></li>
                <li><a href="/bill_list" class="bill_off"></a></li>
                <li><a href="/report_list" class="report_off"></a></li>
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
                        <input name="name" type="text" />
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
                        <input name="password" type="password"  />
                        <span class="required">*</span>
                        <div class="validate_msg_long"></div>
                    </div>
                    <div class="text_info clearfix"><span>重复密码：</span></div>
                    <div class="input_info">
                        <input name="repassword" type="password"  />
                        <span class="required">*</span>
                        <div class="validate_msg_long"></div>
                    </div>      
                    <div class="text_info clearfix"><span>电话：</span></div>
                    <div class="input_info">
                        <input name="telephone" type="text" class="width200"/>
                        <span class="required">*</span>
                        <div class="validate_msg_medium"></div>
                    </div>
                    <div class="text_info clearfix"><span>Email：</span></div>
                    <div class="input_info">
                        <input name="email" type="text" class="width200"/>
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
</html>
