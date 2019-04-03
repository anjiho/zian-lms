<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <!-- Tell the browser to be responsive to screen width -->
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <%--JQuery--%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="common/vendor/jquery/jquery.min.js"></script>
    <script src="common/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="common/vendor/jquery/jquery.validate.js"></script>
    <script src="common/vendor/jquery/jquery.validate.min.js"></script>

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
</head>
<title>지안에듀관리자</title>
<body>
<form name="frm" method="get">
<input type="hidden" name="page_gbn" id="page_gbn">

<%@include file="/common/jsp/header.jsp" %>
