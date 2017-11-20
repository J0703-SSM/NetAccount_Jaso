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


        //保存结果的提示
        function showResult() {

//            if ($("input[type='radio']").eq(0).is(':checked')){
//                if ($("#base_duration").val() == '') {
//                    $("#base_duration").val(0);
//                }
//
//                if ($("#unit_cost").val() == '') {
//                    $("#unit_cost").val(0);
//                }
//            }
//
//            if ($("input[type='radio']").eq(2).is(':checked');){
//
//                if ($("#base_duration").val() == '') {
//                    $("#base_duration").val(0);
//                }
//                if ($("#base_cost").val() == '') {
//                    $("#base_cost").val(0);
//                }
//
//            }

            if ($("#unit_cost").val() == '') {
                $("#unit_cost").val(0);
            }

            if ($("#base_duration").val() == '') {
                $("#base_duration").val(0);
            }
            if ($("#base_cost").val() == '') {
                $("#base_cost").val(0);
            }


            //表单验证

            if (!isString($("#name").val()) || $("#name").val() == '') {
                $("#name_msg").html("*字母、数字、汉字和下划线的组合");
                return false;
            }
            <%--去重复--%>
            $.ajax({
                url: "/cost/verifyName",
                type: "get",
                data: {
                    name: $("#name").val()
                }, success: function (data) {
                    if (data == 0) {
                        $("#name_msg").html("*资费名称重复");//资费名称重复
                        return false;
                    }
                    $("#name_msg").html("√");

                    if (!isInteger($("#base_duration").val()) || $("#base_duration").val() == '') {
                        $("#base_duration_msg").html("*1~600之间整数");
                        return false;
                    }
                    $("#base_duration_msg").html("√");

                    if (!isCount($("#base_cost").val()) || $("#base_cost").val() == '') {
                        $("#base_cost_msg").html("*0-99999.99之间的数值");
                        return false;
                    }
                    $("#base_cost_msg").html("√");

                    if (!isCount($("#unit_cost").val()) || $("#unit_cost").val() == '') {
                        $("#unit_cost_msg").html("*0-99999.99之间的数值");
                        return false;
                    }
                    $("#unit_cost_msg").html("√");

                    if (!isStr($("#descr").val()) || $("#descr").val() == '') {
                        $("#descr_msg").html("*字母、数字、汉字和下划线的组合");
                        return false;
                    }
                    $("#descr_msg").html("√");
                    //提交表单

                    $("#add").submit();
                }
            });


        }

        function isString(name) {
            reg = /^[a-z,A-Z,0-9]+$/;
            return reg.test(name);
        }

        function isInteger(name) {
            reg = /^([0-6]\d{0,2}|600)$/;
            return reg.test(name);
        }
        function isCount(name) {
            reg = /^(\d{1,5})(\.\d{1,2})?$/;
            return reg.test(name);
        }
        function isStr(name) {
            reg = /^\S{1,100}$/;
            return reg.test(name);
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
                inputArray[4].readOnly = true;
                inputArray[4].value = "";
                inputArray[4].className += " readonly";
                inputArray[5].readOnly = false;
                inputArray[5].className = "width100";
                inputArray[5].value = "";
                inputArray[6].readOnly = true;
                inputArray[6].className += " readonly";
                inputArray[6].value = "";
            }
            else if (type == 2) {
                inputArray[4].readOnly = false;
                inputArray[4].className = "width100";
                inputArray[4].value = "";
                inputArray[5].readOnly = false;
                inputArray[5].className = "width100";
                inputArray[5].value = "";
                inputArray[6].readOnly = false;
                inputArray[6].className = "width100";
                inputArray[6].value = "";
            }
            else if (type == 3) {
                inputArray[4].readOnly = true;
                inputArray[4].value = "";
                inputArray[4].className += " readonly";
                inputArray[5].readOnly = true;
                inputArray[5].value = "";
                inputArray[5].className += " readonly";
                inputArray[6].readOnly = false;
                inputArray[6].className = "width100";
                inputArray[6].value = "";
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
        <c:if test="${loginPrivi['1'] != null}">
            <li><a href="/user_role/findAllRole" class="role_off"></a></li>
        </c:if>
        <c:if test="${loginPrivi['2'] != null}">
            <li><a href="/admin_list" class="admin_off"></a></li>
        </c:if>
        <c:if test="${loginPrivi['3'] != null}">
            <li><a href="/fee_list" class="fee_on"></a></li>
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
    <div id="save_result_info" class="save_fail">添加失败!资费名称已存在!</div>

    <%--表单--%>
    <form action="/cost/addCost" id="add" method="post" class="main_form">
        <div class="text_info clearfix"><span>资费名称：</span></div>
        <div class="input_info">
            <input id="name" name="name" type="text" class="width300"/>
            <span id="name_msg" class="required"></>
        </div>
        <div class="text_info clearfix"><span>资费类型：</span></div>
        <div class="input_info fee_type">
            <input type="radio" name="cost_type" id="monthly" value="包月" onclick="feeTypeChange(1);"/>
            <label for="monthly">包月</label>
            <input type="radio" name="cost_type" checked="checked" value="套餐" id="package" onclick="feeTypeChange(2);"/>
            <label for="package">套餐</label>
            <input type="radio" name="cost_type" id="timeBased" value="计时" onclick="feeTypeChange(3);"/>
            <label for="timeBased">计时</label>
        </div>
        <div class="text_info clearfix"><span>基本时长：</span></div>
        <div class="input_info">
            <input id="base_duration" name="base_duration" type="text" class="width100"/>
            <span class="info">小时</span>
            <span id="base_duration_msg" class="required"></span>
        </div>
        <div class="text_info clearfix"><span>基本费用：</span></div>
        <div class="input_info">
            <input id="base_cost" name="base_cost" type="text" class="width100"/>
            <span class="info">元</span>
            <span id="base_cost_msg" class="required"></span>
        </div>
        <div class="text_info clearfix"><span>单位费用：</span></div>
        <div class="input_info">
            <input id="unit_cost" name="unit_cost" type="text" class="width100"/>
            <span class="info">元/小时</span>
            <span id="unit_cost_msg" class="required"></span>
        </div>
        <div class="text_info clearfix"><span>资费说明：</span></div>
        <div class="input_info_high">
            <textarea id="descr" name="descr" class="width300 height70"></textarea>
            <span id="descr_msg" class="required"></span>
        </div>
        <div class="button_info clearfix">
            <input type="button" value="保存" class="btn_save" onclick="showResult()"/>
            <input type="button" value="取消" class="btn_save" onclick="location.href='/fee_list'"/>
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
