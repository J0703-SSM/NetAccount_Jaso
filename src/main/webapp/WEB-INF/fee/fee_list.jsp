<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title></title>
        <link type="text/css" rel="stylesheet" media="all" href="/resources/styles/global.css" />
        <link type="text/css" rel="stylesheet" media="all" href="/resources/styles/global_color.css" />
        <script src="/resources/js/jquery-3.2.1.js"></script>
        <script language="javascript" type="text/javascript">

            //页面加载,查询所有条目
            $.ajax({
                url: "/cost/findAll?pc=1",
                type: "get",
                success: function (data) {}

            });




            //排序按钮的点击事件
            function sort(btnObj) {
                if (btnObj.className == "sort_desc")
                    btnObj.className = "sort_asc";
                else
                    btnObj.className = "sort_desc";
            }

            //启用
            function startFee(id) {
                var r = window.confirm("确定要启用此资费吗？资费启用后将不能修改和删除。");
                $.post({
                    url: "/cost/operate",
                    data: {
                        cost_id: id
                    }
                });
                document.getElementById("operate_result_info").style.display = "block";
//                window.location.reload();
            }
            //删除
            function deleteFee(id) {
                var q = window.confirm("确定要删除此资费吗？");

                $.post({
                    url: "/cost/delete",
                    data: {
                        cost_id: id
                    }
                });
                document.getElementById("operate_result_info").style.display = "block";
//                window.location.reload();
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
            <form action="" method="">
                <!--排序-->
                <div class="search_add">
                    <div>
                        <!--<input type="button" value="月租" class="sort_asc" onclick="sort(this);" />-->
                        <input type="button" value="基费" class="sort_asc" onclick="sort(this);" />
                        <input type="button" value="时长" class="sort_asc" onclick="sort(this);" />
                    </div>
                    <input type="button" value="增加" class="btn_add"
                           onclick="location.href='/fee_add';" />
                </div> 
                <!--启用操作的操作提示-->
                <div id="operate_result_info" class="operate_success">
                    <img src="../../resources/images/close.png" onclick="this.parentNode.style.display='none';window.location.reload();" />
                    操作成功！
                </div>
                <!--数据区域：用表格展示数据-->
                <div id="data">            
                    <table id="datalist">
                        <tr>
                            <th>资费ID</th>
                            <th class="width100">资费名称</th>
                            <th>基本时长</th>
                            <th>基本费用</th>
                            <th>单位费用</th>
                            <th>创建时间</th>
                            <th>开通时间</th>
                            <th class="width50">状态</th>
                            <th class="width200">操作</th>
                        </tr>

                        <c:forEach items="${applicationScope.pb.beanList}" var="cost">
                        <tr>
                            <td>${cost.cost_id}</td>
                            <td><a href="fee_detail.jsp">${cost.name}</a></td>
                            <td>${cost.base_duration}小时</td>
                            <td>${cost.base_cost}元</td>
                            <td>${cost.unit_cost}元/小时</td>
                            <td>${cost.creatime}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${cost.status == 1}">
                                        ${cost.startime}
                                    </c:when>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${cost.status == 0}">
                                        暂停
                                    </c:when>
                                    <c:when test="${cost.status == 1}">
                                        开通
                                    </c:when>
                                </c:choose>
                            </td>
                            <td>
                                <c:if test="${cost.status == '0'}">
                                    <input type="button" value="启用" class="btn_start"
                                           onclick="startFee(${cost.cost_id});" />
                                    <input type="button" value="修改" class="btn_modify"
                                           onclick="location.href='#';" />
                                    <input type="button" value="删除" class="btn_delete"
                                           onclick="deleteFee(${cost.cost_id});" />
                                </c:if>

                            </td>
                        </tr>
                        </c:forEach>
                    </table>
                    <p>业务说明：<br />
                    1、创建资费时，状态为暂停，记载创建时间；<br />
                    2、暂停状态下，可修改，可删除；<br />
                    3、开通后，记载开通时间，且开通后不能修改、不能再停用、也不能删除；<br />
                    4、业务账号修改资费时，在下月底统一触发，修改其关联的资费ID（此触发动作由程序处理）
                    </p>
                </div>
                <!--分页-->
                <div id="pages">
                    <a href="/cost/findAll?pc=1">首页</a>
                    <c:if test="${applicationScope.pb.pc > 1}">
                        <a href="/cost/findAll?pc=${applicationScope.pb.pc-1}">上一页</a>
                    </c:if>


                    <%--计算 begin  end
                        > 如 总页数 tp <= 10  :  begin = 1, end = tp
                        > 如 总页数 >10
                            使用计算公式: begin = pc - 5    end = pc +4
                            * 头溢出  begin<1     begin = 1
                            * 尾溢出  end > tp    end = tp
                    --%>
                    <c:choose>
                        <c:when test="${applicationScope.pb.tp <= 5}">
                            <c:set var="begin" value="1"/>
                            <c:set var="end" value="${applicationScope.pb.tp}"/>
                        </c:when>
                        <c:otherwise>
                            <c:set var="begin" value="${applicationScope.pb.pc-2}"/>
                            <c:set var="end" value="${applicationScope.pb.pc+2}"/>
                            <%--头溢出--%>
                            <c:if test="${begin < 1}">
                                <c:set var="begin" value="1"/>
                                <c:set var="end" value="5"/>
                            </c:if>
                            <%--尾溢出--%>
                            <c:if test="${end > applicationScope.pb.tp}">
                                <c:set var="begin" value="${applicationScope.pb.tp - 4}"/>
                                <c:set var="end" value="${applicationScope.pb.tp}"/>
                            </c:if>
                        </c:otherwise>
                    </c:choose>

                    <c:forEach var="i" begin="${begin}" end="${end}">
                        <c:choose>
                            <c:when test="${applicationScope.pb.pc eq i}">
                                <a href="#" class="current_page">${i}</a>
                            </c:when>
                            <c:otherwise>
                                <a href="/cost/findAll?pc=${i}">${i}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>


                    <c:if test="${applicationScope.pb.pc < applicationScope.pb.tp}">
                        <a href="/cost/findAll?pc=${applicationScope.pb.pc+1}">下一页</a>
                    </c:if>
                    <a href="/cost/findAll?pc=${applicationScope.pb.tp}">尾页</a>

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
