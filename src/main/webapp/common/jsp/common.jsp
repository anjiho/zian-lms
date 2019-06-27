<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ page import="com.zianedu.lms.session.UserSession" %>
<%@ page import="com.zianedu.lms.vo.TUserVO" %>
<%
    TUserVO tUserVO = (TUserVO)session.getAttribute("user_info");
    int authority = tUserVO.getAuthority();
    String name = tUserVO.getName();
    int teacherKey = tUserVO.getTeacherKey();
    int httpStatusCode = response.getStatus();

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
    <!-- 공통 함수 JS -->
    <script src="common/js/common.js"></script>
    <script src="common/js/comPage.js"></script>
    <script src="common/js/selectbox.js"></script>
    <script src="common/js/checkbox.js"></script>

    <script type='text/javascript' src='/dwr/engine.js'></script>
    <script type='text/javascript' src='/dwr/util.js'></script>

    <!--Common css-->
    <link href="common/css/common.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic" rel="stylesheet" type="text/css">

    <!-- Favicon icon -->

    <link rel="icon" type="image/png" sizes="16x16" href="img/logo.png">
    <!-- Custom CSS -->
    <link href="common/assets/libs/flot/css/float-chart.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="common/dist/css/style.min.css" rel="stylesheet">
    <link href="common/assets/libs/jquery-steps/jquery.steps.css" rel="stylesheet">
    <link href="common/assets/libs/jquery-steps/steps.css" rel="stylesheet">
    <!-- datatable CSS -->
    <link rel="stylesheet" type="text/css" href="common/assets/extra-libs/multicheck/multicheck.css">
    <link href="common/assets/libs/datatables.net-bs4/css/dataTables.bootstrap4.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="common/dist/css/datepicker3.css" />
    <!-- loading CSS -->
    <link rel="stylesheet" type="text/css" href="common/css/loading.css" />

    <!-- All Jquery -->
    <!-- ============================================================== -->
    <script src="common/assets/libs/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap tether Core JavaScript -->
    <script src="common/assets/libs/popper.js/dist/umd/popper.min.js"></script>
    <script src="common/assets/libs/bootstrap/dist/js/bootstrap.min.js"></script>
    <script src="common/assets/libs/perfect-scrollbar/dist/perfect-scrollbar.jquery.min.js"></script>
    <script src="common/assets/extra-libs/sparkline/sparkline.js"></script>
    <script src="common/assets/libs/jquery-steps/build/jquery.steps.min.js"></script>
    <script src="common/assets/libs/jquery-validation/dist/jquery.validate.min.js"></script>
    <!--Wave Effects -->
    <script src="common/dist/js/waves.js"></script>
    <!--Menu sidebar -->
    <!--<script src="common/dist/js/sidebarmenu.js"></script>-->
    <script src="common/js/sidebar-menu.js"></script>

    <!--Custom JavaScript -->
    <script src="common/dist/js/custom.min.js"></script>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <!--This page JavaScript -->
    <!-- Charts js Files -->
    <script src="common/assets/libs/flot/excanvas.js"></script>
    <script src="common/assets/libs/flot/jquery.flot.js"></script>
    <script src="common/assets/libs/flot/jquery.flot.pie.js"></script>
    <script src="common/assets/libs/flot/jquery.flot.time.js"></script>
    <script src="common/assets/libs/flot/jquery.flot.stack.js"></script>
    <script src="common/assets/libs/flot/jquery.flot.crosshair.js"></script>
    <script src="common/assets/libs/flot.tooltip/js/jquery.flot.tooltip.min.js"></script>
    <script src="common/dist/js/pages/chart/chart-page-init.js"></script>

    <script src="common/assets/libs/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>
    <!--datatable js-->
    <script src="common/assets/extra-libs/multicheck/jquery.multicheck.js"></script>
    <script src="common/assets/extra-libs/DataTables/datatables.min.js"></script>
    <script type="text/javascript" src="common/js/jquery.tablednd.js"></script>
    <script type="text/javascript" src="common/dist/js/jquery-sortable.js"></script>

    <script type="text/javascript" src="common/js/bootstrap-datepicker.js"></script>
    <script type="text/javascript" src="common/js/bootstrap-datepicker.kr.js"></script>
    <!--paging-->
    <script src="common/js/paging-count-check.js"></script>
    <!--comment-->
    <script src="common/js/comment.js"></script>
    <!---summernote js/css-->
    <link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
    <script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>
    <!-- dwr common -->
    <script type='text/javascript' src='/dwr/interface/selectboxService.js'></script>

    <!-- loading -->
    <script src="common/js/loading.js"></script>
    <!--<script type="text/javascript" src="https://pagead2.googlesyndication.com/pagead/show_ads.js"></script>-->

    <!--daum map api-->
    <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

    <script src="common/js/jquery.table2excel.js"></script>


</head>
<title>지안에듀관리자</title>
<body onload="init();">
<!--헤더-->
<%@include file="/common/jsp/header.jsp" %>
<!-- form 시작-->
<form name="frm" method="get" id="frm">
<input type="hidden" name="page_gbn" id="page_gbn">
<input type="hidden" name="param_key" id="param_key">
<input type="hidden" name="teacher_date_key" id="teacher_date_key">
<input type="hidden" name="teacher_name_key" id="teacher_name_key">
<input type="hidden" id="type" name="type" value=""><!--주문관리 : 페이지 왼쪽메뉴 스타일 type-->
</form>
<%
    if (authority == 4) {
%>
    <!--관리자 메뉴-->
 <%@include file="/common/jsp/aside/admin_aside.jsp" %>
<%
    } else if (authority == 5) {
%>
    <!--강사관리자 메뉴-->
<%@include file="/common/jsp/aside/teacher_aside.jsp" %>
<%
    } else if (authority == 15) {
%>
    <!--도서관리자 메뉴-->
<%@include file="/common/jsp/aside/book_aside.jsp" %>
<%
} else if (authority == 22) {
%>
    <!--정산관리자 메뉴-->
<%@include file="/common/jsp/aside/calculate_aside.jsp" %>
<%
}
%>
<script>
    var httpCode = '<%=httpStatusCode%>';
    if (httpCode == '901') {
        alert("세션이 만료되어 로그인 페이지로 이동합니다.");
    }

    function serializeDiv( $div, serialize_method ) {
        // Accepts 'serialize', 'serializeArray'; Implicit 'serialize'
        serialize_method = serialize_method || 'serialize';

        // Unique selector for wrapper forms
        var inner_wrapper_class = 'any_unique_class_for_wrapped_content';

        // Wrap content with a form
        $div.wrapInner( "<form class='"+inner_wrapper_class+"'></form>" );

        // Serialize inputs
        var result = $('.'+inner_wrapper_class, $div)[serialize_method]();

        // Eliminate newly created form
        $('.script_wrap_inner_div_form', $div).contents().unwrap();

        // Return result
        return result;
    }
</script>
