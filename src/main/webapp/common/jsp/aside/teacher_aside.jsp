<%--
  Created by IntelliJ IDEA.
  User: won
  Date: 2019-04-03
  Time: 오전 10:58
  왼쪽메뉴 - 관리자권한 메뉴페이지
--%>
<!-- Left Sidebar-->

<%@page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<style>
    hr {
        border: 1;
        height: 1px;
        background-image: linear-gradient(left, #f0f0f0, #8c8c8c, #f0f0f0);
        margin-bottom: 0px;
        margin-top: 0px;
    }

</style>
<script>
</script>
<aside class="left-sidebar" data-sidebarbg="skin5">
    <!-- Sidebar scroll-->
    <div class="scroll-sidebar">
        <!-- Sidebar navigation-->
        <nav class="sidebar-nav">
            <ul id="sidebarnav" class="p-t-30">
                <li class="sidebar-item" id="menu-7"> <a class="sidebar-link has-arrow waves-effect waves-dark" href="javascript:void(0)" aria-expanded="false"><i class="mdi mdi-account-key"></i><span class="hide-menu">교수</span></a>
                    <ul aria-expanded="false" class="collapse  first-level">
                        <li class="sidebar-item"><a href="void(0)" onclick="goPage('teacherManage', 'teacherCalculateMonthList'); return false;" class="sidebar-link"><i class=""></i><span class="hide-menu">월별 정산내역</span></a></li>
                        <li class="sidebar-item"><a href="void(0)" onclick="goPage('teacherManage', 'teacherCalculateSectionList'); return false;" class="sidebar-link"><i class=""></i><span class="hide-menu">기간별 정산내역</span></a></li>
                        <hr style="width: 100%;color:#6c757d" noshade >
                        <li class="sidebar-item"><a href="void(0)" onclick="goPage('teacherManage', 'teacherCalcGraph'); return false;" class="sidebar-link"><i class=""></i><span class="hide-menu">매출 그래프</span></a></li>
                        <!-- <li class="sidebar-item"><a href="void(0)" onclick="goPage('statisManage', 'promotionStatistics'); return false;" class="sidebar-link"><i class=""></i><span class="hide-menu">게시글관리</span></a></li>
                         <li class="sidebar-item"><a href="void(0)" onclick="goPage('statisManage', 'memberStatistics'); return false;" class="sidebar-link"><i class=""></i><span class="hide-menu">학습자료실</span></a></li>
                         <li class="sidebar-item"><a href="void(0)" onclick="goPage('statisManage', 'memberStatistics'); return false;" class="sidebar-link"><i class=""></i><span class="hide-menu">Q&A</span></a></li>
                         <li class="sidebar-item"><a href="void(0)" onclick="goPage('statisManage', 'memberStatistics'); return false;" class="sidebar-link"><i class=""></i><span class="hide-menu">리뷰</span></a></li>-->
                        <hr style="width: 100%;color:#6c757d" noshade >
                    </ul>
                </li>
            </ul>
        </nav>
        <!-- End Sidebar navigation -->
    </div>
    <!-- End Sidebar scroll-->
</aside>
<div class="page-wrapper">
    <script>
        $.sidebarMenu($('.sidebar-item'));
        $.sidebarSubMenu();
    </script>

