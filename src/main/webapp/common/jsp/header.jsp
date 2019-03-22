<%@ page import="com.flowedu.session.UserSession" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String academyThumbnail = UserSession.academyThumbnail();
    Long officeId = Long.valueOf(UserSession.officeId());
%>
<script type='text/javascript' src='<%=webRoot%>/dwr/interface/authService.js'></script>
<script>
    function init() {
        authService.getLeftMenuInfo(function(selList) {
           if (selList.length == 0) {
               return;
           }
           for (var i=0; i<selList.length; i++) {
               var cmpList = selList[i].mainMenu;
               if (!cmpList.viewYn) {
                   $("#main_" + cmpList.mainMenuId).attr("data", "1");
               }

           }
            var cmpList2 = selList[0].subMenus;
            for (var j=0; j<cmpList2.length; j++) {
                var subMenu = cmpList2[j];
                if (!subMenu.viewYn) {
                   $("#sub_menu_" + subMenu.subMenuId).attr("data", "1");
                }
            }
        });
    }
</script>
<div id="wrap" >
    <header id="header">
        <div style="margin-left: 22px;">
            <%--<img id="academy_img" src="<%=academyThumbnail%>" alt="" style="width: auto; height: 80px">--%>
        </div>
        <button class="toggle_aside"></button>

        <nav id="lnb" class="depth1">
            <ul class="sidebar-menu">
                <%--<li><a href="#"><span class="fa fa-times menu_close_btn"></span></a></li>--%>
                <li id="main_li_0">
                    <a href="javascript:goPage('dashboard', 'dashboard_list')" id="main_0" >메인</a>
                </li>
                <li id="main_li_1"><a href="#" id="main_1">학생관리</a>
                    <ul class="sidebar-submenu" id="main_ul_1">
                        <li><a id="sub_menu_1" href="void(0)" onclick="goPage('student', 'student_list', this); return false;"><span class="fa fa-user"></span>개별학생관리</a></li>
                        <li><a id="sub_menu_2" href="#"><span class="fa fa-street-view"></span>강사별학생관리</a></li>
                        <li><a id="sub_menu_3" href="#"><span class="fa fa-headphones"></span>상담관리</a></li>
                        <li><a id="sub_menu_4 "href="#"><span class="fa fa-cc-visa"></span>수납관리</a></li>
                    </ul>
                </li>
                <li id="main_li_2">
                    <a href="#" id="main_2">학습관리</a>
                    <ul class="sidebar-submenu" id="main_ul_2">
                        <!-- javascript: -->
                        <li><a id="sub_menu_5" href="void(0)" onclick="goPage('lecture', 'lecture_attend_list', this); return false;" ><span class="fa fa-address-book"></span>출결관리</a></li>
                        <li><a id="sub_menu_6" href="void(0)" onclick="goPage('lecture', 'assignment_list', this); return false;"><span class="fa fa-book"></span>과제관리</a></li>
                    </ul>
                </li>
                <%--<li><a href="javascript:goPage('consult', 'early_consult_memo')" <%=depth1 == 3 ? "class='on'" : ""%>>학습관리</a></li>--%>
                <li id="main_li_3">
                    <a href="#" id="main_3">행정관리</a>
                    <ul class="sidebar-submenu" id="main_ul_3">
                        <li><a id="sub_menu_7" href="void(0)" onclick="goPage('academy', 'list_academy', this); return false;"><span class="fa fa-building"></span>학원관리</a></li>
                    </ul>
                </li>
                <li id="main_li_4">
                    <a href="#" id="main_4">강의관리</a>
                    <ul class="sidebar-submenu" id="main_ul_4">
                        <li><a id="sub_menu_8" href="#"><span class="fa far fa-calendar"></span>반관리</a></li>
                        <li><a id="sub_menu_9" href="#"><span class="fa far fa-credit-card"></span>수강료관리</a></li>
                        <li><a id="sub_menu_10" href="void(0)" onclick="goPage('lecture', 'lecture_list', this); return false;"><span class="fa far fa-bell"></span>강의관리</a></li>
                    </ul>
                </li>

                <li id="main_li_5">
                    <a href="#" id="main_5">운영관리</a>
                    <ul class="sidebar-submenu" id="main_ul_5">
                        <li><a id="sub_menu_11" href="void(0)" onclick="goPage('member', 'list_member', this); return false;"><span class="fa fa-address-card"></span>운영자관리</a></li>
                        <li><a id="sub_menu_12" href="void(0)" onclick="goPage('bus', 'bus_info', this); return false;"><span class="fa fa-bus"></span>셔틀버스관리</a></li>
                    </ul>
                </li>
                <li id="main_li_6">
                    <a href="#" id="main_6">커뮤니티관리</a>
                </li>
                <li id="main_li_7">
                    <a href="#" id="main_7">ERP</a>
                </li>
                <li id="main_menu_8">
                    <a href="#" id="main_8">시스템관리</a>
                </li>
                <%--<li><a href="javascript:goPage('template', 'formType1')" <%=depth1 == 10 ? "class='on'" : ""%>>프론트 개발 페이지</a></li>--%>
            </ul>
        </nav>

    </header>

<script>
    init();
    $.sidebarMenu($('.sidebar-menu'));
    $(".sidebar-menu > li").eq(<%=siderMenuDepth1%>).addClass("active");
    $(".sidebar-menu > li:nth-child(<%=siderMenuDepth2%>) > ul > li:nth-child(<%=siderMenuDepth3%>) > a").addClass("on");

</script>



