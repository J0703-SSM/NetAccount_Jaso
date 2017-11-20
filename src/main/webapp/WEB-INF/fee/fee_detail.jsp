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
            <form action="" method="" class="main_form">
                <div class="text_info clearfix"><span>资费ID：</span></div>
                <div class="input_info"><input type="text" class="readonly" readonly value="${cost.cost_id}" /></div>
                <div class="text_info clearfix"><span>资费名称：</span></div>
                <div class="input_info"><input type="text" class="readonly" readonly value="${cost.name}"/></div>
                <div class="text_info clearfix"><span>资费状态：</span></div>
                <div class="input_info">
                    <select class="readonly" disabled>
                        <option <c:if test="${cost.status == 1}">selected</c:if> >开通</option>
                        <option <c:if test="${cost.status == 0}">selected</c:if> >暂停</option>
                    </select>
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
                    <input type="text" class="readonly" readonly value="${cost.base_duration}"  />
                    <span>小时</span>
                </div>
                <div class="text_info clearfix"><span>基本费用：</span></div>
                <div class="input_info">
                    <input type="text"  class="readonly" readonly value="${cost.base_cost}" />
                    <span>元</span>
                </div>
                <div class="text_info clearfix"><span>单位费用：</span></div>
                <div class="input_info">
                    <input type="text"  class="readonly" readonly value="${cost.unit_cost}" />
                    <span>元/小时</span>
                </div>
                <div class="text_info clearfix"><span>创建时间：</span></div>
                <div class="input_info"><input type="text"  class="readonly width200" readonly
                                               value="${cost.creatime}" /></div>
                <div class="text_info clearfix"><span>启动时间：</span></div>
                <div class="input_info"><input type="text"  class="readonly width200" readonly
                                               value="${cost.startime}" /></div>
                <div class="text_info clearfix"><span>资费说明：</span></div>
                <div class="input_info_high">
                    <textarea class="width300 height70 readonly" readonly>${cost.descr}</textarea>
                </div>                    
                <div class="button_info clearfix">
                    <input type="button" value="返回" class="btn_save" onclick="location.href='/fee_list'" />
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
