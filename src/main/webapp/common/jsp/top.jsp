<%@ page import="com.flowedu.config.ConfigHolder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/jsp/common.jsp" %>
<%
	String serverName = request.getServerName();
	String version = ConfigHolder.gerVersion();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="<%=webRoot%>/common/dist/style.bundle.css?ver=<%=version%>">
<link rel="stylesheet" href="<%=webRoot%>/common/css/sider_menu.css?ver=<%=version%>">
<link rel="stylesheet" href="<%=webRoot%>/common/css/addStyle.css?ver=<%=version%>">

<!--  jquery plugin -->
<script type='text/javascript' src="<%=webRoot%>/common/js/jquery-2.2.4.min.js"></script>
<script type='text/javascript' src="<%=webRoot%>/calendar/lib/moment.min.js"></script>
<script type='text/javascript' src="<%=webRoot%>/calendar/js/fullcalendar.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<!-- dwr 필수 스트립트 -->
<script type='text/javascript' src="<%=webRoot%>/dwr/engine.js"></script>
<script type='text/javascript' src="<%=webRoot%>/dwr/util.js"></script>

<script src='//cdn.rawgit.com/fgelinas/timepicker/master/jquery.ui.timepicker.js'></script>
<script type='text/javascript' src="<%=webRoot%>/js/jquery.mtz.monthpicker.js"></script>
<script type='text/javascript' src="<%=webRoot%>/js/datepicker.js"></script>

<script type='text/javascript' src="<%=webRoot%>/js/blank-check.js?ver=<%=version%>"></script>
<script type='text/javascript' src="<%=webRoot%>/js/selectbox.js?ver=<%=version%>"></script>
<script type='text/javascript' src="<%=webRoot%>/common/js/comment.js?ver=<%=version%>"></script>
<script type='text/javascript' src="<%=webRoot%>/common/js/common.js?ver=<%=version%>"></script>
<script type='text/javascript' src="<%=webRoot%>/common/js/commonUI.js?ver=<%=version%>"></script>
<script type='text/javascript' src="<%=webRoot%>/js/radio.js?ver=<%=version%>"></script>
<script type='text/javascript' src="<%=webRoot%>/js/sidebar-menu.js"></script>

<!-- 페이징 관련 필수 스트립트 -->
<script type='text/javascript' src="<%=webRoot%>/js/paging-count-check.js?ver=<%=version%>"></script>
<script type='text/javascript' src="<%=webRoot%>/common/js/com_page.js?ver=<%=version%>"></script>
<script src="<%=webRoot%>/calendar/lang/ko.js"/>

<script type='text/javascript' src="<%=webRoot%>/js/page.js?ver=<%=version%>"></script>
<!-- 공통으로 쓰는 값 모여있는 스크립트 -->
<script src="<%=webRoot%>/js/value.js?ver=<%=version%>"></script>
<!-- 페이지 이동 스크립트 -->
<script src="<%=webRoot%>/js/page.js?ver=<%=version%>"></script>
<!-- 공통으로 쓰는 값 모여있는 스크립트 -->
<script src="<%=webRoot%>/js/convert_value.js?ver=<%=version%>"></script>

<!-- 학생관리 추가 -->
<script type='text/javascript' src="<%=webRoot%>/common/js/studentAdd.js?ver=<%=version%>"></script>

<meta http-equiv="content-Type" content="text/html;charset=utf-8">
<title>지안에듀 LMS</title>
</head>
