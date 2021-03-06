<%--
  Created by IntelliJ IDEA.
  User: won
  Date: 2019-04-03
  Time: 오전 10:58
   왼쪽메뉴 - 도서관리자권한 메뉴페이지
--%>
<!-- Left Sidebar-->
<%@page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<aside class="left-sidebar" data-sidebarbg="skin5">
    <!-- Sidebar scroll-->
    <div class="scroll-sidebar">
        <!-- Sidebar navigation-->
        <nav class="sidebar-nav">
            <ul id="sidebarnav" class="p-t-30 ">
                <li class="sidebar-item"> <a class="sidebar-link has-arrow waves-effect waves-dark" href="javascript:void(0)" aria-expanded="false"><i class="mdi mdi-face"></i><span class="hide-menu">기본관리</span></a>
                    <ul aria-expanded="false" class="collapse  first-level vertical-menu ">
                        <li class="sidebar-item"><a href="icon-fontawesome.html" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 배송정보 </span></a></li>
                        <li class="sidebar-item"><a href="icon-fontawesome.html" class="sidebar-link"><i class=""></i><span class="hide-menu"> 배송사설정 </span></a></li>
                    </ul>
                </li>
                <li class="sidebar-item"> <a class="sidebar-link has-arrow waves-effect waves-dark" href="javascript:void(0)" aria-expanded="false"><i class="mdi mdi-chart-bubble"></i><span class="hide-menu">상품관리</span></a>
                    <ul aria-expanded="false" class="collapse  first-level">
                        <li class="sidebar-item" ><a href="icon-material.html" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 동영상상품관리 </span></a></li>
                        <li class="sidebar-item"><a href="icon-material.html" class="sidebar-link" style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 동영상 목록 </span></a></li>
                        <li class="sidebar-item"><a href="icon-material.html" class="sidebar-link" style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 동영상 등록 </span></a></li>
                        <li class="sidebar-item"><a href="icon-fontawesome.html" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 학원강의 상품관리 </span></a></li>
                        <li class="sidebar-item"><a href="icon-fontawesome.html" class="sidebar-link"><i class=""></i><span class="hide-menu">학원강의 목록</span></a></li>
                        <li class="sidebar-item"><a href="icon-fontawesome.html" class="sidebar-link"><i class=""></i><span class="hide-menu">학원강의 등록</span></a></li>
                        <li class="sidebar-item"><a href="icon-fontawesome.html" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 도서관리 </span></a></li>
                        <li class="sidebar-item"><a href="icon-fontawesome.html" class="sidebar-link"><i class=""></i><span class="hide-menu"> 도서목록 </span></a></li>
                        <li class="sidebar-item"><a href="icon-fontawesome.html" class="sidebar-link"><i class=""></i><span class="hide-menu"> 도서등록 </span></a></li>
                        <li class="sidebar-item"><a href="icon-fontawesome.html" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 모의고사관리 </span></a></li>
                        <li class="sidebar-item"><a href="icon-fontawesome.html" class="sidebar-link"><i class=""></i><span class="hide-menu"> 모의고사목록 </span></a></li>
                        <li class="sidebar-item"><a href="icon-fontawesome.html" class="sidebar-link"><i class=""></i><span class="hide-menu"> 모의고사등록 </span></a></li>
                    </ul>
                </li>
                <li class="sidebar-item"> <a class="sidebar-link has-arrow waves-effect waves-dark" href="javascript:void(0)" aria-expanded="false"><i class="mdi mdi-border-inside"></i><span class="hide-menu">프로모션상품관리</span></a>
                    <ul aria-expanded="false" class="collapse  first-level">
                        <li class="sidebar-item" ><a href="icon-material.html" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 패키지 상품관리 </span></a></li>
                        <li class="sidebar-item"><a href="icon-material.html" class="sidebar-link" style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 패키지목록 </span></a></li>
                        <li class="sidebar-item"><a href="icon-material.html" class="sidebar-link" style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 패키지등록 </span></a></li>
                        <li class="sidebar-item"><a href="icon-fontawesome.html" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 지안패스 상품관리 </span></a></li>
                        <li class="sidebar-item"><a href="icon-fontawesome.html" class="sidebar-link"><i class=""></i><span class="hide-menu"> 지안패스 페이지 관리 </span></a></li>
                        <li class="sidebar-item"><a href="icon-fontawesome.html" class="sidebar-link"><i class=""></i><span class="hide-menu"> 지안패스 관리 </span></a></li>
                        <li class="sidebar-item"><a href="icon-fontawesome.html" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 연간회원제 상품관리 </span></a></li>
                        <li class="sidebar-item"><a href="icon-fontawesome.html" class="sidebar-link"><i class=""></i><span class="hide-menu"> 연간회원제 페이지관리 </span></a></li>
                        <li class="sidebar-item"><a href="icon-fontawesome.html" class="sidebar-link"><i class=""></i><span class="hide-menu"> 연간회원제 관리 </span></a></li>
                    </ul>
                </li>
                <li class="sidebar-item"> <a class="sidebar-link has-arrow waves-effect waves-dark" href="javascript:void(0)" aria-expanded="false"><i class="mdi mdi-blur-linear"></i><span class="hide-menu">주문관리</span></a>
                    <ul aria-expanded="false" class="collapse  first-level">
                        <li class="sidebar-item" ><a href="icon-material.html" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 주문관리 </span></a></li>
                            <li class="sidebar-item"><a href="icon-material.html" class="sidebar-link" style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 전체주문목록 </span></a></li>
                        <li class="sidebar-item"><a href="icon-fontawesome.html" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 수강관리 </span></a></li>
                            <li class="sidebar-item"><a href="icon-fontawesome.html" class="sidebar-link"><i class=""></i><span class="hide-menu"> 수강내역목록 </span></a></li>
                            <li class="sidebar-item"><a href="icon-fontawesome.html" class="sidebar-link"><i class=""></i><span class="hide-menu"> 무료수강 관리 </span></a></li>
                        <li class="sidebar-item"><a href="icon-fontawesome.html" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 디바이스관리 </span></a></li>
                            <li class="sidebar-item"><a href="icon-fontawesome.html" class="sidebar-link"><i class=""></i><span class="hide-menu"> 상품/모바일 디바잉스관리 </span></a></li>
                            <li class="sidebar-item"><a href="icon-fontawesome.html" class="sidebar-link"><i class=""></i><span class="hide-menu"> 기기변경 이력조회 </span></a></li>
                        <li class="sidebar-item"><a href="icon-fontawesome.html" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 기타관리 </span></a></li>
                            <li class="sidebar-item"><a href="icon-fontawesome.html" class="sidebar-link"><i class=""></i><span class="hide-menu"> 마일리지관리 </span></a></li>
                    </ul>
                </li>
                <li class="sidebar-item"> <a class="sidebar-link has-arrow waves-effect waves-dark" href="javascript:void(0)" aria-expanded="false"><i class="mdi mdi-relative-scale"></i><span class="hide-menu">팝업/쿠폰관리</span></a>
                    <ul aria-expanded="false" class="collapse  first-level">
                        <li class="sidebar-item" ><a href="icon-material.html" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 팝업관리 </span></a></li>
                        <li class="sidebar-item"><a href="icon-material.html" class="sidebar-link" style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 팝업관리 </span></a></li>
                        <li class="sidebar-item"><a href="icon-fontawesome.html" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 쿠폰관리 </span></a></li>
                        <li class="sidebar-item"><a href="icon-fontawesome.html" class="sidebar-link"><i class=""></i><span class="hide-menu"> 쿠폰관리 </span></a></li>
                    </ul>
                </li>
                <li class="sidebar-item"> <a class="sidebar-link has-arrow waves-effect waves-dark" href="javascript:void(0)" aria-expanded="false"><i class="mdi mdi-face"></i><span class="hide-menu">회원관리</span></a>
                    <ul aria-expanded="false" class="collapse  first-level">
                        <li class="sidebar-item" ><a href="icon-material.html" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 회원관리 </span></a></li>
                        <li class="sidebar-item"><a href="icon-material.html" class="sidebar-link" style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 회원관리 </span></a></li>
                        <li class="sidebar-item"><a href="icon-material.html" class="sidebar-link" style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 탈퇴회원관리 </span></a></li>
                        <li class="sidebar-item"><a href="icon-material.html" class="sidebar-link" style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 상담내역 </span></a></li>
                        <li class="sidebar-item"><a href="icon-fontawesome.html" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 강사 관리 </span></a></li>
                        <li class="sidebar-item"><a href="icon-fontawesome.html" class="sidebar-link"><i class=""></i><span class="hide-menu"> 강사관리 </span></a></li>
                        <li class="sidebar-item" ><a href="icon-material.html" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> SMS보내기 </span></a></li>
                    </ul>
                </li>
                <li class="sidebar-item"> <a class="sidebar-link has-arrow waves-effect waves-dark" href="javascript:void(0)" aria-expanded="false"><i class="mdi mdi-pencil"></i><span class="hide-menu">게시판관리</span></a>
                    <ul aria-expanded="false" class="collapse  first-level">
                        <li class="sidebar-item" ><a href="icon-material.html" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 내강의실 </span></a></li>
                        <li class="sidebar-item"><a href="icon-material.html" class="sidebar-link" style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 복습동영상신청 </span></a></li>
                        <li class="sidebar-item" ><a href="icon-material.html" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 행정직 </span></a></li>
                        <li class="sidebar-item"><a href="icon-material.html" class="sidebar-link" style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 커뮤니티 </span></a></li>
                        <li class="sidebar-item"><a href="icon-material.html" class="sidebar-link" style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 공지사항 </span></a></li>
                        <li class="sidebar-item" ><a href="icon-material.html" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 기술직 </span></a></li>
                        <li class="sidebar-item"><a href="icon-material.html" class="sidebar-link" style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 커뮤니티 </span></a></li>
                        <li class="sidebar-item"><a href="icon-material.html" class="sidebar-link" style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 공지사항 </span></a></li>
                        <li class="sidebar-item" ><a href="icon-material.html" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 계리직 </span></a></li>
                        <li class="sidebar-item"><a href="icon-material.html" class="sidebar-link" style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 학습질문하기 </span></a></li>
                        <li class="sidebar-item"><a href="icon-material.html" class="sidebar-link" style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 시험정보 </span></a></li>
                        <li class="sidebar-item"><a href="icon-material.html" class="sidebar-link" style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 커뮤니티 </span></a></li>
                        <li class="sidebar-item"><a href="icon-material.html" class="sidebar-link" style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 공지사항 </span></a></li>
                        <li class="sidebar-item" ><a href="icon-material.html" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 온라인서점 </span></a></li>
                        <li class="sidebar-item"><a href="icon-material.html" class="sidebar-link" style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 커뮤니티 </span></a></li>
                        <li class="sidebar-item" ><a href="icon-material.html" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 고객센터 </span></a></li>
                        <li class="sidebar-item"><a href="icon-material.html" class="sidebar-link" style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 고객센터 </span></a></li
                        <li class="sidebar-item" ><a href="icon-material.html" class="sidebar-link"><i class="fas fa-minus"></i><span class="hide-menu"> 교수소개 </span></a></li>
                        <li class="sidebar-item"><a href="icon-material.html" class="sidebar-link" style="padding: 10px 19px;"><i class=""></i><span class="hide-menu"> 공지사항 </span></a></li>
                    </ul>
                </li>
            </ul>
        </nav>
        <!-- End Sidebar navigation -->
    </div>
    <!-- End Sidebar scroll-->
</aside>
<div class="page-wrapper">
