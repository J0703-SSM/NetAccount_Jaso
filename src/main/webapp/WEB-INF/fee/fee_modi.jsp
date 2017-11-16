<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page isELIgnored="false" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title></title>
        <link type="text/css" rel="stylesheet" media="all" href="/resources/styles/global.css" />
        <link type="text/css" rel="stylesheet" media="all" href="/resources/styles/global_color.css" />
        <script src="/resources/js/jquery-3.2.1.js"></script>
        <script language="javascript" type="text/javascript">
            //保存结果的提示
            function showResult() {



                showResultDiv(true);
                window.setTimeout("showResultDiv(true);", 3000);
                if ($("#base_duration").val() == ''){$("#base_duration").val(0);}
                if ($("#base_cost").val() == ''){ $("#base_cost").val(0);}
                if ($("#unit_cost").val() == ''){$("#unit_cost").val(0);}
                $("#f").submit();
            }
            function showResultDiv(flag) {
                var divResult = document.getElementById("save_result_info");
                if (flag)
                    divResult.style.display = "block";
                else
                    divResult.style.display = "none";
            }

            //切换资费类型
            function feeTypeChange(type) {
                var inputArray = document.getElementById("main").getElementsByTagName("input");
                if (type == 1) {
                    inputArray[5].readOnly = true;
                    inputArray[5].value = "";
                    inputArray[5].className += " readonly";
                    inputArray[6].readOnly = false;
                    inputArray[6].className = "width100";
                    inputArray[7].readOnly = true;
                    inputArray[7].className += " readonly";
                    inputArray[7].value = "";
                }
                else if (type == 2) {
                    inputArray[5].readOnly = false;
                    inputArray[5].className = "width100";
                    inputArray[6].readOnly = false;
                    inputArray[6].className = "width100";
                    inputArray[7].readOnly = false;
                    inputArray[7].className = "width100";
                }
                else if (type == 3) {
                    inputArray[5].readOnly = true;
                    inputArray[5].value = "";
                    inputArray[5].className += " readonly";
                    inputArray[6].readOnly = true;
                    inputArray[6].value = "";
                    inputArray[6].className += " readonly";
                    inputArray[7].readOnly = false;
                    inputArray[7].className = "width100";
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
                <li><a href="/user_role/findAllRole" class="role_off"></a></li>
                <li><a href="/admin_list" class="admin_off"></a></li>
                <li><a href="/fee_list" class="fee_on"></a></li>
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
            <div id="save_result_info" class="save_success">保存成功！</div>
            <form id="f" action="/cost/updateCost" method="post" class="main_form">
                <div class="text_info clearfix"><span>资费ID：</span></div>
                <div class="input_info">
                    <input type="text" name="cost_id" class="readonly" readonly value="${cost.cost_id}" /></div>
                <div class="text_info clearfix"><span>资费名称：</span></div>
                <div class="input_info">
                    <input id="name" type="text" name="name" class="width300" value="${cost.name}"/>
                    <span class="required">*</span>
                    <div id="name_msg" class="validate_msg_short"></div>
                </div>
                <div class="text_info clearfix"><span>资费类型：</span></div>
                <div class="input_info fee_type">
                    <input type="radio" name="cost_type"
                           <c:if test="${cost.cost_type == '包月'}">
                               checked="checked"
                           </c:if>
                           id="monthly" value="包月" onclick="feeTypeChange(1);" />
                    <label for="monthly">包月</label>
                    <input type="radio" name="cost_type"
                            <c:if test="${cost.cost_type == '套餐'}">
                                checked="checked"
                            </c:if>
                           id="package" value="套餐" onclick="feeTypeChange(2);" />
                    <label for="package">套餐</label>
                    <input type="radio" name="cost_type"
                            <c:if test="${cost.cost_type == '计时'}">
                                checked="checked"
                            </c:if>
                           id="timeBased" value="计时" onclick="feeTypeChange(3);" />
                    <label for="timeBased">计时</label>
                </div>
                <div class="text_info clearfix"><span>基本时长：</span></div>
                <div class="input_info">
                    <input id="base_duration" name="base_duration" type="text" value="${cost.base_duration}" class="width100" />
                    <span class="info">小时</span>
                    <span class="required">*</span>
                    <div id="base_duration_msg" class="validate_msg_long"></div>
                </div>
                <div class="text_info clearfix"><span>基本费用：</span></div>
                <div class="input_info">
                    <input id="base_cost" name="base_cost" type="text" value="${cost.base_cost}" class="width100" />
                    <span class="info">元</span>
                    <span class="required">*</span>
                    <div id="base_cost_msg" class="validate_msg_long"></div>
                </div>
                <div class="text_info clearfix"><span>单位费用：</span></div>
                <div class="input_info">
                    <input id="unit_cost" name="unit_cost" type="text" value="${cost.unit_cost}" class="width100" />
                    <span class="info">元/小时</span>
                    <span class="required">*</span>
                    <div id="unit_cost_msg" class="validate_msg_long"></div>
                </div>   
                <div class="text_info clearfix"><span>资费说明：</span></div>
                <div class="input_info_high">
                    <textarea id="descr" name="descr" class="width300 height70">${cost.descr}
                    </textarea>
                    <div id="descr_msg" class="validate_msg_short"></div>
                </div>                    
                <div class="button_info clearfix">
                    <input type="button" value="保存" class="btn_save"  onclick="showResult();" />
                    <input type="button" value="取消" class="btn_save" onclick="location.href='/fee_list'"/>
                </div>
            </form>
        </div>
        <!--主要区域结束-->
        <div id="footer">
            <p>Designed by Jaso&reg; Made in DaLian</p>
            <p>版权所有&copy;  J科技有限公司 </p>
        </div>
    </body>
</html>
