<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link type="text/css" rel="stylesheet" media="all" href="/resources/styles/global.css"/>
    <link type="text/css" rel="stylesheet" media="all" href="/resources/styles/global_color.css"/>
    <link type="text/css" rel="stylesheet" href="/resources/w2ui-1.5.rc1/w2ui-1.5.rc1.css"/>
    <script src="/resources/js/jquery-3.2.1.js"></script>
    <script type="text/javascript" src="/resources/w2ui-1.5.rc1/w2ui-1.5.rc1.js"></script>
    <script language="javascript" type="text/javascript">

        //排序按钮的点击事件
        function sort(btnObj, column) {
            if (btnObj.className == "sort_desc") {
                //升序
                btnObj.className = "sort_asc";
                location.href = "/cost/findAll?pc=1&sort=asc&column=" + column + "";
            }
            else {
                //降序
                btnObj.className = "sort_desc";
                location.href = "/cost/findAll?pc=1&sort=desc&column=" + column + "";
            }
        }

        //启用
        function startFee(id) {
            $.ajax({
                url: "/cost/operate",
                type:"get",
                data: {
                    cost_id: id
                },success: function (){}
            });
            document.getElementById("operate_result_info").style.display = "block";
        }
        //删除
        function deleteFee(id) {

            popup(id)

        }
        function popup(data) {
            w2popup.open({
                width: 300,
                height: 200,
                title: '{ 身份验证 }',
                body: '<div class="w2ui-centered">请输入密码:' +
                '<input id="pwd" type="password" class="width200"/></div>',
                buttons: '<button class="w2ui-btn" onclick="password('+data+')">残忍删除</button>' +
                '<button class="w2ui-btn" onclick="w2popup.close();">还是不删除了吧</button>',
                showMax: true
            });
        }

        function password(data) {
            if ($("#pwd").val() == ${loginAdmin.password}) {
                w2popup.close();
                $("#msg").html("执行删除操作后, 不可恢复!");
                document.getElementById("operate_result_info").style.display = "block";
                //删除
                $.ajax({
                    url: "/cost/delete",
                    type:"get",
                    data: {
                        cost_id: data
                    },success: function (){}
                });
                $("#msg").html("删除操作成功!");
                document.getElementById("operate_result_info").style.display = "block";
            }else {
                w2alert("× 密码错误!");
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
    <form >

        <!--排序-->
        <div class="search_add">
            <div>
                <!--<input type="button" value="月租" class="sort_asc" onclick="sort(this);" />-->
                <input id="cost_order" type="button" value="基费"
                       <c:if test="${column != 'base_cost'}">
                           class="sort_asc"
                       </c:if>
                        <c:if test="${column == 'base_cost'}">
                            <c:if test="${sort == null}">
                                class="sort_asc"
                            </c:if>
                            <c:if test="${sort != null}">
                                class="sort_${sort}"
                            </c:if>
                        </c:if>
                       onclick="sort(this,'base_cost');"/>
                <input id="duration_order" type="button" value="时长"
                        <c:if test="${column != 'base_duration'}">
                            class="sort_asc"
                        </c:if>
                        <c:if test="${column == 'base_duration'}">
                            <c:if test="${sort == null}">
                                class="sort_asc"
                            </c:if>
                            <c:if test="${sort != null}">
                                class="sort_${sort}"
                            </c:if>
                        </c:if>
                       onclick="sort(this,'base_duration');"/>
            </div>
            <input type="button" value="增加" class="btn_add"
                   onclick="location.href='/fee_add';"/>
        </div>

        <!--启用操作的操作提示-->
        <div id="operate_result_info" class="operate_success">
            <img src="../../resources/images/close.png"
                 onclick="this.parentNode.style.display='none';window.location.reload();"/>
            <span id="msg">启用操作成功！</span>
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
                    <th class="width50">状态</th>
                    <th class="width200">

                    </th>
                </tr>

                <c:forEach items="${pb.beanList}" var="cost">
                    <tr>
                        <td>${cost.cost_id}</td>
                        <td><a href="/cost/detail/${cost.cost_id}">${cost.name}</a></td>
                        <td>
                            <c:if test="${cost.base_duration != 0}">
                                ${cost.base_duration}小时
                            </c:if>

                        </td>
                        <td>
                            <c:if test="${cost.base_cost != 0.0}">
                                ${cost.base_cost}元
                            </c:if>
                        </td>
                        <td>
                            <c:if test="${cost.unit_cost != 0.0}">
                                ${cost.unit_cost}元/小时
                            </c:if>
                        </td>
                        <td>${cost.creatime}</td>

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
                            <c:choose>
                                <c:when test="${cost.status == 0}">
                                    <input type="button" value="启用" class="btn_start"
                                           onclick="startFee(${cost.cost_id});"/>
                                    <input type="button" value="修改" class="btn_modify"
                                           onclick="location.href='/cost/findCost/'+${cost.cost_id};"/>
                                    <input type="button" value="删除" class="btn_delete"
                                           onclick="deleteFee(${cost.cost_id});"/>
                                </c:when>
                                <c:when test="${cost.status == 1}">
                                    <c:choose>
                                        <c:when test="${cost.status == 1}">
                                            [开通时间]:${cost.startime}
                                        </c:when>
                                    </c:choose>
                                </c:when>
                            </c:choose>

                        </td>
                    </tr>
                </c:forEach>
            </table>
            <p>业务说明：<br/>
                1、创建资费时，状态为暂停，记载创建时间；<br/>
                2、暂停状态下，可修改，可删除；<br/>
                3、开通后，记载开通时间，且开通后不能修改、不能再停用、也不能删除；<br/>
                4、业务账号修改资费时，在下月底统一触发，修改其关联的资费ID（此触发动作由程序处理）
            </p>
        </div>
        <!--分页-->
        <div id="pages">
            <a href="/cost/findAll?pc=1&sort=${sort}&column=${column}">首页</a>
            <c:if test="${pb.pc > 1}">
                <a href="/cost/findAll?pc=${pb.pc-1}&sort=${sort}&column=${column}">上一页</a>
            </c:if>


            <%--计算 begin  end
                > 如 总页数 tp <= 10  :  begin = 1, end = tp
                > 如 总页数 >10
                    使用计算公式: begin = pc - 5    end = pc +4
                    * 头溢出  begin<1     begin = 1
                    * 尾溢出  end > tp    end = tp
            --%>
            <c:choose>
                <c:when test="${pb.tp <= 5}">
                    <c:set var="begin" value="1"/>
                    <c:set var="end" value="${pb.tp}"/>
                </c:when>
                <c:otherwise>
                    <c:set var="begin" value="${pb.pc-2}"/>
                    <c:set var="end" value="${pb.pc+2}"/>
                    <%--头溢出--%>
                    <c:if test="${begin < 1}">
                        <c:set var="begin" value="1"/>
                        <c:set var="end" value="5"/>
                    </c:if>
                    <%--尾溢出--%>
                    <c:if test="${end > pb.tp}">
                        <c:set var="begin" value="${pb.tp - 4}"/>
                        <c:set var="end" value="${pb.tp}"/>
                    </c:if>
                </c:otherwise>
            </c:choose>

            <c:forEach var="i" begin="${begin}" end="${end}">
                <c:choose>
                    <c:when test="${pb.pc eq i}">
                        <a href="#" class="current_page">${i}</a>
                    </c:when>
                    <c:otherwise>
                        <a href="/cost/findAll?pc=${i}&sort=${sort}&column=${column}">${i}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>


            <c:if test="${pb.pc < pb.tp}">
                <a href="/cost/findAll?pc=${pb.pc+1}&sort=${sort}&column=${column}">下一页</a>
            </c:if>
            <a href="/cost/findAll?pc=${pb.tp}&sort=${sort}&column=${column}">尾页</a>

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
