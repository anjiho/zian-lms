<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ page import="com.zianedu.lms.session.UserSession" %>
<%@ page import="com.zianedu.lms.vo.TUserVO" %>
<%
    TUserVO tUserVO = (TUserVO)session.getAttribute("user_info");
    int authority = tUserVO.getAuthority();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <!-- Tell the browser to be responsive to screen width -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <!--- JQuery
    <script src="common/vendor/jquery/jquery.min.js"></script>
    <script src="common/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="common/vendor/jquery/jquery.validate.js"></script>
    <script src="common/vendor/jquery/jquery.validate.min.js"></script>-->

    <!-- 공통 함수 JS -->
    <script src="common/js/common.js"></script>
    <script src="common/js/comPage.js"></script>

    <script type='text/javascript' src='/dwr/engine.js'></script>
    <script type='text/javascript' src='/dwr/util.js'></script>
    <!-- Bootstrap CSS -->
    <link href="common/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    <link href="common/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="common/css/common.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic" rel="stylesheet" type="text/css">

    <!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="common/assets/images/favicon.png">
    <!-- Custom CSS -->
    <link href="common/assets/libs/flot/css/float-chart.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="common/dist/css/style.min.css" rel="stylesheet">

    <!-- All Jquery -->
    <!-- ============================================================== -->
    <script src="common/assets/libs/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap tether Core JavaScript -->
    <script src="common/assets/libs/popper.js/dist/umd/popper.min.js"></script>
    <script src="common/assets/libs/bootstrap/dist/js/bootstrap.min.js"></script>
    <script src="common/assets/libs/perfect-scrollbar/dist/perfect-scrollbar.jquery.min.js"></script>
    <script src="common/assets/extra-libs/sparkline/sparkline.js"></script>
    <!--Wave Effects -->
    <script src="common/dist/js/waves.js"></script>
    <!--Menu sidebar -->
    <script src="common/dist/js/sidebarmenu.js"></script>
    <!--Custom JavaScript -->
    <script src="common/dist/js/custom.min.js"></script>

    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <!--This page JavaScript -->
    <!-- <script src="dist/js/pages/dashboards/dashboard1.js"></script> -->
    <!-- Charts js Files -->
    <script src="common/assets/libs/flot/excanvas.js"></script>
    <script src="common/assets/libs/flot/jquery.flot.js"></script>
    <script src="common/assets/libs/flot/jquery.flot.pie.js"></script>
    <script src="common/assets/libs/flot/jquery.flot.time.js"></script>
    <script src="common/assets/libs/flot/jquery.flot.stack.js"></script>
    <script src="common/assets/libs/flot/jquery.flot.crosshair.js"></script>
    <script src="common/assets/libs/flot.tooltip/js/jquery.flot.tooltip.min.js"></script>
    <script src="common/dist/js/pages/chart/chart-page-init.js"></script>
</head>
<title>지안에듀관리자</title>
<body>
<%@include file="/common/jsp/header.jsp" %>
<form name="frm" method="get">
<input type="hidden" name="page_gbn" id="page_gbn">
<div id="main-wrapper">
<%
    if (authority == 4) {
%>
 <%@include file="/common/jsp/aside.jsp" %>
<%
    } else if (authority == 5) {
%>
<%@include file="/common/jsp/aside2.jsp" %>
<%
    }
%>
