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
    // $(function() {
    //     $('#sidebarnav li').on('click', function (e) {
    //         if ($(this).children('ul').hasClass('in')) {
    //             $(this).children("a").addClass('');
    //             $(this).children("ul").removeClass('in');
    //         } else {
    //             $(this).children("a").addClass('active');
    //             $(this).children("ul").addClass('in');
    //         }
    //     });
    //     $('.sidebar-item > a').on('click', function() {
    //         $(this).children("a").addClass('active');
    //         $(this).children("ul").addClass('in');
    //         $(this).parent().removeClass("active");
    //         //$('.sidebar-item').find('a').removeClass('active');
    //
    //     });
    // });
</script>
<aside class="left-sidebar" data-sidebarbg="skin5">
    <!-- Sidebar scroll-->
    <div class="scroll-sidebar">
        <!-- Sidebar navigation-->
        <nav class="sidebar-nav">
            <ul id="sidebarnav" class="p-t-30">
<%--                    <ul aria-expanded="false" class="collapse  first-level">--%>
<%--                        <li class="sidebar-item" ><a href="void(0)" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 기본정보 </span></a></li>--%>
<%--                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link" style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 요약정보 </span></a></li>--%>
<%--                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 배송정보 </span></a></li>--%>
<%--                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link"><i class=""></i><span class="hide-menu"> 배송사설정 </span></a></li>--%>
<%--                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 권한관리 </span></a></li>--%>
<%--                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link"><i class=""></i><span class="hide-menu"> 권한관리 </span></a></li>--%>
<%--                    </ul>--%>
<%--                </li>--%>
                <!--
                  <li class="sidebar-item"> <a class="sidebar-link has-arrow waves-effect waves-dark" href="javascript:void(0)" aria-expanded="false"><i class="mdi mdi-receipt"></i><span class="hide-menu">Forms </span></a>
                            <ul aria-expanded="false" class="collapse  first-level">
                                <li class="sidebar-item"><a href="form-basic.html" class="sidebar-link"><i class="mdi mdi-note-outline"></i><span class="hide-menu"> Form Basic </span></a></li>
                                <li class="sidebar-item"><a href="form-wizard.html" class="sidebar-link"><i class="mdi mdi-note-plus"></i><span class="hide-menu"> Form Wizard </span></a></li>
                            </ul>
                    </li>
                -->
                <li class="sidebar-item" id="menu-0"> <a class="sidebar-link has-arrow waves-effect waves-dark" href="javascript:void(0)"  aria-expanded="false"><i class="mdi mdi-chart-bar"></i><span class="hide-menu">데이터관리</span></a>
                    <ul aria-expanded="false" class="collapse  first-level">
                        <li class="sidebar-item" id="menu-0-0"><a href="void(0)" onclick="goPage('dataManage', 'classficationSave'); return false;" class="sidebar-link" style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 분류관리 </span></a></li>
                        <!--   -->
                        <li class="sidebar-item" id="menu-0-1"><a href="#" onclick="goPage('dataManage', 'subjectSave');" class="sidebar-link" style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 과목관리 </span></a></li>
                        <!--<li class="sidebar-item"><a href="#"  class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 배너관리 </span></a></li>-->
                        <hr>
                        <li class="sidebar-item" id="menu-0-2"><a href="void(0)" onclick="goPage('dataManage', 'bannerSave'); return false;" class="sidebar-link"><i class=""></i><span class="hide-menu">배너관리</span></a></li>
                        <li class="sidebar-item" id="menu-0-3"><a href="void(0)" onclick="goPage('dataManage', 'sideBannerSave'); return false;" class="sidebar-link"><i class=""></i><span class="hide-menu">사이드바배너관리</span></a></li>
                        <hr>
                        <!--<li class="sidebar-item"><a href="#" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 일정/검색어관리 </span></a></li>-->
                        <li class="sidebar-item" id="menu-0-4"><a href="void(0)" onclick="goPage('dataManage', 'examplanSave'); return false;" class="sidebar-link"><i class=""></i><span class="hide-menu"> 시험일정관리 </span></a></li>
                        <li class="sidebar-item" id="menu-0-5"><a href="void(0)" onclick="goPage('dataManage', 'searchSave'); return false;" class="sidebar-link"><i class=""></i><span class="hide-menu"> 검색어관리 </span></a></li>
                        <hr>
                    </ul>
                </li>
                <li class="sidebar-item"  id="menu-1"> <a class="sidebar-link has-arrow waves-effect waves-dark" href="javascript:void(0)" aria-expanded="false"><i class="mdi mdi-chart-bubble"></i><span class="hide-menu">상품관리</span></a>
                    <ul aria-expanded="false" class="collapse  first-level">
                        <!--<li class="sidebar-item" ><a href="#" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 동영상상품관리 </span></a></li>-->
                        <li class="sidebar-item"  id="menu-1-0"><a href="http://localhost:8080/productManage?page_gbn=playList" onclick="goPage('productManage', 'playList'); return false;" class="sidebar-link style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 동영상 목록 </span></a></li>
                        <li class="sidebar-item" id="menu-1-1"><a href="http://localhost:8080/productManage?page_gbn=playSave" onclick="goPage('productManage', 'playSave'); return false;" class="sidebar-link" style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 동영상 등록 </span></a></li>
                        <hr style="width: 100%;color:#6c757d" noshade >
                        <!--<li class="sidebar-item"><a href="#" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 학원강의 상품관리 </span></a></li>-->
                        <li class="sidebar-item" id="menu-1-2"><a href="#" onclick="goPage('productManage', 'academyLectureList')" class="sidebar-link"><i class=""></i><span class="hide-menu">학원강의 목록</span></a></li>
                        <li class="sidebar-item" id="menu-1-3"><a href="#" onclick="goPage('productManage', 'academyLectureSave')" class="sidebar-link"><i class=""></i><span class="hide-menu">학원강의 등록</span></a></li>
                        <hr style="width: 100%;color:#6c757d" noshade >
                        <!--<li class="sidebar-item"><a href="void(0)" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 도서관리 </span></a></li>-->
                        <li class="sidebar-item" id="menu-1-4"><a href="void(0)" onclick="goPage('productManage', 'bookList'); return false;" class="sidebar-link"><i class=""></i><span class="hide-menu"> 도서목록 </span></a></li>
                        <li class="sidebar-item" id="menu-1-5"><a href="void(0)" onclick="goPage('productManage', 'bookSave'); return false;" class="sidebar-link"><i class=""></i><span class="hide-menu"> 도서등록 </span></a></li>
                        <!--<li class="sidebar-item"><a href="void(0)" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 모의고사관리 </span></a></li>-->
                        <hr style="width: 100%;color:#6c757d" noshade >
                        <li class="sidebar-item" id="menu-1-6"><a href="void(0)" onclick="goPage('productManage', 'mokExamList'); return false;" class="sidebar-link"><i class=""></i><span class="hide-menu"> 모의고사목록 </span></a></li>
                        <li class="sidebar-item" id="menu-1-7"><a href="void(0)" onclick="goPage('productManage', 'mokExamManage'); return false;" class="sidebar-link"><i class=""></i><span class="hide-menu"> 모의고사등록 </span></a></li>
                        <li class="sidebar-item" id="menu-1-8"><a href="void(0)" class="sidebar-link"><i class=""></i><span class="hide-menu"> 문제은행 </span></a></li>
                        <hr style="width: 100%;color:#6c757d" noshade >
                    </ul>
                </li>
                <li class="sidebar-item"> <a class="sidebar-link has-arrow waves-effect waves-dark" href="javascript:void(0)" aria-expanded="false"><i class="mdi mdi-border-inside"></i><span class="hide-menu">프로모션상품관리</span></a>
                    <ul aria-expanded="false" class="collapse  first-level">
                        <li class="sidebar-item" ><a href="void(0)" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 패키지 상품관리 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link" style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 패키지목록 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link" style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 패키지등록 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 지안패스 상품관리 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link"><i class=""></i><span class="hide-menu"> 지안패스 페이지 관리 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link"><i class=""></i><span class="hide-menu"> 지안패스 관리 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 연간회원제 상품관리 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link"><i class=""></i><span class="hide-menu"> 연간회원제 페이지관리 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link"><i class=""></i><span class="hide-menu"> 연간회원제 관리 </span></a></li>
                    </ul>
                </li>
                <li class="sidebar-item"> <a class="sidebar-link has-arrow waves-effect waves-dark" href="javascript:void(0)" aria-expanded="false"><i class="mdi mdi-blur-linear"></i><span class="hide-menu">주문관리</span></a>
                    <ul aria-expanded="false" class="collapse  first-level">
                        <li class="sidebar-item" ><a href="void(0)" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 주문관리 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link" style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 전체주문목록 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 수강관리 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link"><i class=""></i><span class="hide-menu"> 수강내역목록 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link"><i class=""></i><span class="hide-menu"> 학원수강 관리 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link"><i class=""></i><span class="hide-menu"> 무료수강 관리 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 디바이스관리 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link"><i class=""></i><span class="hide-menu"> 상품/모바일 디바이스관리 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link"><i class=""></i><span class="hide-menu"> 기기변경 이력조회 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 모의고사 관리 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link"><i class=""></i><span class="hide-menu"> 오프라인 응시자 목록 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link"><i class=""></i><span class="hide-menu"> 성적내역 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link"><i class=""></i><span class="hide-menu"> OMR </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 기타관리 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link"><i class=""></i><span class="hide-menu"> 마일리지관리 </span></a></li>
                    </ul>
                </li>
                <li class="sidebar-item"> <a class="sidebar-link has-arrow waves-effect waves-dark" href="javascript:void(0)" aria-expanded="false"><i class="mdi mdi-relative-scale"></i><span class="hide-menu">팝업/쿠폰관리</span></a>
                    <ul aria-expanded="false" class="collapse  first-level">
                        <li class="sidebar-item" ><a href="void(0)" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 팝업관리 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link" style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 팝업관리 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 쿠폰관리 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link"><i class=""></i><span class="hide-menu"> 쿠폰관리 </span></a></li>
                    </ul>
                </li>
                <li class="sidebar-item"> <a class="sidebar-link has-arrow waves-effect waves-dark" href="javascript:void(0)" aria-expanded="false"><i class="mdi mdi-face"></i><span class="hide-menu">회원관리</span></a>
                    <ul aria-expanded="false" class="collapse  first-level">
                        <li class="sidebar-item" ><a href="void(0)" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 회원관리 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link" style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 회원관리 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link" style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 탈퇴회원관리 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link" style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 상담내역 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 강사/노출순서 관리 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link"><i class=""></i><span class="hide-menu"> 강사관리 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link"><i class=""></i><span class="hide-menu"> 순서관리 </span></a></li>
                        <li class="sidebar-item" ><a href="void(0)" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> SMS보내기 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link" style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 푸시관리 </span></a></li>
                    </ul>
                </li>
                <li class="sidebar-item"> <a class="sidebar-link has-arrow waves-effect waves-dark" href="javascript:void(0)" aria-expanded="false"><i class="mdi mdi-pencil"></i><span class="hide-menu">게시판관리</span></a>
                    <ul aria-expanded="false" class="collapse  first-level">
                        <li class="sidebar-item" ><a href="void(0)" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 게시판관리 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link" style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 게시판관리 </span></a></li>
                        <li class="sidebar-item" ><a href="void(0)" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 내강의실 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link" style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 복습동영상신청 </span></a></li>
                        <li class="sidebar-item" ><a href="void(0)" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 행정직 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link" style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 커뮤니티 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link" style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 공지사항 </span></a></li>
                        <li class="sidebar-item" ><a href="void(0)" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 기술직 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link" style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 커뮤니티 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link" style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 공지사항 </span></a></li>
                        <li class="sidebar-item" ><a href="void(0)" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 계리직 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link" style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 학습질문하기 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link" style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 시험정보 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link" style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 커뮤니티 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link" style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 공지사항 </span></a></li>
                        <li class="sidebar-item" ><a href="void(0)" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 온라인서점 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link" style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 커뮤니티 </span></a></li>
                        <li class="sidebar-item" ><a href="void(0)" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 고객센터 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link" style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 고객센터 </span></a></li
                        <li class="sidebar-item" ><a href="void(0)" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 교수소개 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link" style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 공지사항 </span></a></li>
                    </ul>
                </li>
                <li class="sidebar-item" id="menu-7"> <a class="sidebar-link has-arrow waves-effect waves-dark" href="javascript:void(0)" aria-expanded="false"><i class="mdi mdi-move-resize-variant"></i><span class="hide-menu">통계</span></a>
                    <ul aria-expanded="false" class="collapse  first-level">
                        <li class="sidebar-item" ><a href="void(0)" onclick="goPage('statisManage', 'productStatistics'); return false;" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 상품통계 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" onclick="goPage('statisManage', 'promotionStatistics'); return false;" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 프로모션 통계 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" onclick="goPage('statisManage', 'memberStatistics'); return false;" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 회원가입 통계 </span></a></li>
<%--                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 회원통계 </span></a></li>--%>
                    </ul>
                </li>
                <li class="sidebar-item" id="menu-8"> <a class="sidebar-link has-arrow waves-effect waves-dark" href="javascript:void(0)" aria-expanded="false"><i class="mdi mdi-account-key"></i><span class="hide-menu">교수</span></a>
                    <ul aria-expanded="false" class="collapse  first-level">
                        <li class="sidebar-item" ><a href="#" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 정산내역 </span></a></li>
                        <li class="sidebar-item"><a href="icon-material.html" class="sidebar-link" style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 월별 정산내역 </span></a></li>
                        <li class="sidebar-item"><a href="icon-material.html" class="sidebar-link" style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 기간별 정산내역 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" onclick="goPage('teacherManage', 'teacherCalcGraph'); return false;" class="sidebar-link" style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 매출 그래프 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 게시글관리 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link"><i class=""></i><span class="hide-menu"> 학습자료실 </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link"><i class=""></i><span class="hide-menu"> Q&A </span></a></li>
                        <li class="sidebar-item"><a href="void(0)" class="sidebar-link"><i class=""></i><span class="hide-menu"> 리뷰 </span></a></li>
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

