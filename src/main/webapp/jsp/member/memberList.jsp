<%@ page import="com.zianedu.lms.utils.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<%
    String searchStartDate = Util.isNullValue(request.getParameter("param_key2"), "");
    String searchEndDate = Util.isNullValue(request.getParameter("param_key3"), "");
    String memberGradeSel = Util.isNullValue(request.getParameter("param_key4"), "1000");
    String sel_1 = Util.isNullValue(request.getParameter("param_key5"), "");
    String memberSel = Util.isNullValue(request.getParameter("param_key6"), "");
    String searchText = Util.isNullValue(request.getParameter("param_key7"), "");
    String isDetail = Util.isNullValue(request.getParameter("param_key8"), "");
%>
<style>
    ol,ul{list-style:none}

    button{margin:0;padding:0;font-family:inherit;border:0 none;background:transparent;cursor:pointer}
    button::-moz-focus-inner{border:0;padding:0}
    .searchDate{overflow:hidden;margin-bottom:-3px;*zoom:1;margin-left: -7%;}
    .searchDate:after{display:block;clear:both;content:''}
    .searchDate li{position:relative;float:left;margin:0 7px 0 0}
    .searchDate li .chkbox2{display:block;text-align:center}
    .searchDate li .chkbox2 input{position:absolute;z-index:-1}
    .searchDate li .chkbox2 label{display:block;width:77px;height:26px;font-size:14px;font-weight:bold;color:#fff;text-align:center;line-height:25px;text-decoration:none;cursor:pointer;background:#02486f}
    .searchDate li .chkbox2.on label{background:#ec6a6a}

</style>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/memberManageService.js'></script>
<script>
    function init() {
        var isDetail = '<%=isDetail%>';
        var memberSel = '<%=memberSel%>';
        var sel_1 = '<%=sel_1%>';
        var memberGradeSel = '<%=memberGradeSel%>';

        menuActive('menu-5', 1);
        innerValue("searchStartDate", '<%=searchStartDate%>');
        innerValue("searchEndDate", '<%=searchEndDate%>');
        getMemberSearchSelectbox("l_searchSel", memberSel);
        getSelectboxListForCtgKey('affiliationCtgKey', '133', sel_1);
        memberGrageSelectBox("memberGrageSel", memberGradeSel);
        innerValue("searchText", '<%=searchText%>');

        if (isDetail == 'detail') {
            fn_search2('new');
        } else {
            fn_search('new');
        }

    }

    function fn_search(val) {
        var paging = new Paging();
        var sPage = getInputTextValue("sPage");

        if (val == "new") sPage = "1";

        dwr.util.removeAllRows("dataList"); //테이블 리스트 초기화
        gfn_emptyView("H", "");//페이징 예외사항처리

        var searchType   = getSelectboxValue("memberSel");
        var searchText   = getInputTextValue('searchText');
        var regStartDate = getInputTextValue("searchStartDate");
        var regEndDate   = getInputTextValue("searchEndDate");
        var grade        = getSelectboxValue("memberGradeSel");
        var affiliationCtgKey = getSelectboxValue("sel_1");

        if(searchType == null || searchText == "") searchType = "";
        if(grade == null) grade = "";
        if(affiliationCtgKey == null) affiliationCtgKey = "10000";


        var loading = new Loading({
            direction: 'hor',
            discription: '검색중',
            animationIn: false,
            animationOut: false,
            defaultApply: 	true,
        });

        memberManageService.getMemeberListCount(searchType, searchText, regStartDate, regEndDate, grade, affiliationCtgKey, function (cnt) {
            paging.count(sPage, cnt, '10', '10', comment.blank_list);
            var listNum = ((cnt-1)+1)-((sPage-1)*10); //리스트 넘버링
            memberManageService.getMemeberList(sPage, 10, searchType, searchText, regStartDate, regEndDate, grade, affiliationCtgKey, function (selList) {
                if (selList.length == 0) return;
                dwr.util.addRows("dataList", selList, [
                    function(data) {return data.userKey == null ? "-" : data.userKey;},
                    function(data) {return data.userId == null ? "-" : data.userId;},
                    function(data) {return "<a href='javascript:void(0);' color='blue' style='' onclick='goMemberDetail(" + data.userKey + ");'>" + data.name + "</a>";},
                    function(data) {return data.telephoneMobile == null ? "-" : data.telephoneMobile;},
                    function(data) {return data.email == null ? "-" : data.email;},
                    function(data) {return data.indate == null ? "-" : split_minute_getDay(data.indate);},
                    function(data) {return data.affiliationName == null ? "-" : data.affiliationName;},
                    function(data) {return data.gradeName == null ? "-" : data.gradeName;},
                    function(data) {return data.authorityName == null ? "-" : data.authorityName;},
                    function(data) {return data.isMobileReg == 0 ?  "<i class='mdi mdi-close' style='color: red'></i>" : "<i class='mdi mdi-check' style='color:green;'></i>";},
                ], {escapeHtml:false});
            });
            loadingOut(loading);
        });
    }

    function fn_search2(val) {
        var paging = new Paging();
        var sPage = getInputTextValue("sPage");

        if (val == "new") sPage = "1";

        dwr.util.removeAllRows("dataList"); //테이블 리스트 초기화
        gfn_emptyView("H", "");//페이징 예외사항처리

        var isDetail = '<%=isDetail%>';
        var searchType   = getSelectboxValue("memberSel");
        var searchText   = getInputTextValue('searchText');
        var regStartDate = getInputTextValue("searchStartDate");
        var regEndDate   = getInputTextValue("searchEndDate");
        var grade        = getSelectboxValue("memberGradeSel");
        var affiliationCtgKey = getSelectboxValue("sel_1");

        if (isDetail) {
            searchType = '<%=memberSel%>';
            searchText = '<%=searchText%>';
            regStartDate = '<%=searchStartDate%>';
            regEndDate = '<%=searchEndDate%>';
            grade = '<%=memberGradeSel%>';
            affiliationCtgKey = '<%=sel_1%>';
        }

        if(searchType == null || searchText == "") searchType = "";
        if(grade == null) grade = "";
        if(affiliationCtgKey == null) affiliationCtgKey = "10000";


        var loading = new Loading({
            direction: 'hor',
            discription: '검색중',
            animationIn: false,
            animationOut: false,
            defaultApply: 	true,
        });

        memberManageService.getMemeberListCount(searchType, searchText, regStartDate, regEndDate, grade, affiliationCtgKey, function (cnt) {
            paging.count(sPage, cnt, '10', '10', comment.blank_list);
            var listNum = ((cnt-1)+1)-((sPage-1)*10); //리스트 넘버링
            memberManageService.getMemeberList(sPage, 10, searchType, searchText, regStartDate, regEndDate, grade, affiliationCtgKey, function (selList) {
                if (selList.length == 0) return;
                dwr.util.addRows("dataList", selList, [
                    function(data) {return data.userKey == null ? "-" : data.userKey;},
                    function(data) {return data.userId == null ? "-" : data.userId;},
                    function(data) {return "<a href='javascript:void(0);' color='blue' style='' onclick='goMemberDetail(" + data.userKey + ");'>" + data.name + "</a>";},
                    //function(data) {return "<a href='javascript:void(0);' color='blue' style='' onclick='goMemberSms(" +'+data.userId +' + ");'>" + data.telephoneMobile + "</a>";},
                    function(data) {return data.telephoneMobile == null ? "-" : data.telephoneMobile;},
                    function(data) {return data.email == null ? "-" : data.email;},
                    function(data) {return data.indate == null ? "-" : split_minute_getDay(data.indate);},
                    function(data) {return data.affiliationName == null ? "-" : data.affiliationName;},
                    function(data) {return data.gradeName == null ? "-" : data.gradeName;},
                    function(data) {return data.authorityName == null ? "-" : data.authorityName;},
                    function(data) {return data.isMobileReg == 0 ?  "<i class='mdi mdi-close' style='color: red'></i>" : "<i class='mdi mdi-check' style='color:green;'></i>";},
                ], {escapeHtml:false});
            });
            loadingOut(loading);
        });
    }

    function excelDownload() {
        if (confirm("다운로드 받으시겠습니까?")) {
            var memberSel = getSelectboxValue("memberSel");
            var searchText = getInputTextValue("searchText");
            var searchStartDate = getInputTextValue("searchStartDate");
            var searchEndDate = getInputTextValue("searchEndDate");
            var memberGradeSel = getSelectboxValue("memberGradeSel");
            var sel_1 = getSelectboxValue("sel_1");

            if (searchStartDate == "") {
                alert("검색 시작일을 입력하세요.");
                $("#searchStartDate").focus();
                return;
            }
            if (searchEndDate == "") {
                alert("검색 종료일을 입력하세요.");
                $("#searchEndDate").focus();
                return;
            }

            var url = "memberSel=" + memberSel + "&searchText=" + searchText + "&searchStartDate=" + searchStartDate + "&searchEndDate=" + searchEndDate +
                "&memberGradeSel=" + memberGradeSel + "&sel_1=" + sel_1;

            $.download('/excelDownload/userList',url,'post' );
        }
    }
</script>
<div class="page-breadcrumb">
    <input type="hidden" id="sPage">
    <input type="hidden" id="JKey" name="JKey" value="">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">회원 목록</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">회원관리</li>
                        <li class="breadcrumb-item active" aria-current="page">회원 목록</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</div>
<!-- 기본 소스-->
<div class="">
    <div class="form-group">
        <div class="card">
            <div class="card-body">
                <div class="row">
                    <div class="col">
                        <div class="form-group row">
                            <label  class="col-sm-1 control-label col-form-label" style="margin-bottom: 0">기간별조회</label>
                            <div class="col-sm-5 pl-0 pr-0">
                                <tr>
                                    <td>
                                        <ul class="searchDate">
                                            <li>
                                                <span class="chkbox2">
                                                    <input type="radio" name="dateType" id="dateType1" onclick="setSearchDate('0d', 'searchStartDate', 'searchEndDate')"/>
                                                    <label for="dateType1">당일</label>
                                                </span>
                                            </li>
                                            <li>
                                                <span class="chkbox2">
                                                    <input type="radio" name="dateType" id="dateType3" onclick="setSearchDate('1w', 'searchStartDate', 'searchEndDate')"/>
                                                    <label for="dateType3">1주</label>
                                                </span>
                                            </li>
                                            <li>
                                                <span class="chkbox2">
                                                    <input type="radio" name="dateType" id="dateType4" onclick="setSearchDate('2w', 'searchStartDate', 'searchEndDate')"/>
                                                    <label for="dateType4">2주</label>
                                                </span>
                                            </li>
                                            <li>
                                                <span class="chkbox2">
                                                    <input type="radio" name="dateType" id="dateType5" onclick="setSearchDate('1m', 'searchStartDate', 'searchEndDate')"/>
                                                    <label for="dateType5">1개월</label>
                                                </span>
                                            </li>
                                            <li>
                                                <span class="chkbox2">
                                                    <input type="radio" name="dateType" id="dateType6" onclick="setSearchDate('3m', 'searchStartDate', 'searchEndDate')"/>
                                                    <label for="dateType6">3개월</label>
                                                </span>
                                            </li>
                                            <li>
                                                <span class="chkbox2">
                                                    <input type="radio" name="dateType" id="dateType7" onclick="setSearchDate('6m', 'searchStartDate', 'searchEndDate')"/>
                                                    <label for="dateType7">6개월</label>
                                                </span>
                                            </li>
                                        </ul>
                                    </td>
                                </tr>
                            </div>
                            <div class="col-sm-5 input-group pl-0 pr-0">
                                <input type="text" class="form-control datepicker" placeholder="yyyy-mm-dd" name="searchStartDate" id="searchStartDate">
                                <div class="input-group-append">
                                    <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                </div>
                                <span> ~ </span>
                                <input type="text" class="form-control datepicker" placeholder="yyyy-mm-dd" name="searchEndDate" id="searchEndDate">
                                <div class="input-group-append">
                                    <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <div class="form-group row">
                            <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">회원등급</label>
                            <div class="col-sm-8 pl-0 pr-0">
                                <span id="memberGrageSel"></span>
                                <!--<span id="orderPayStatus"></span>-->
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="form-group row" style="">
                            <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">준비직렬</label>
                            <div class="col-sm-8 pl-0 pr-0">
                                <span id="affiliationCtgKey"></span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="form-group row">
                        <label class="col-sm-1 control-label col-form-label" style="margin-bottom: 0">검색어</label>
                        <div class="col-sm-4 input-group pl-0 pr-0">
                            <div class="col-sm-6">
                                <span id="l_searchSel"></span>
                            </div>
                            <input type="text" class="form-control" id="searchText" onkeypress="if(event.keyCode==13) {fn_search('new'); return false;}">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <div style=" float: right;">
                            <button type="button" class="btn btn-outline-info mx-auto" data-toggle="modal" data-target="#sModal4" onclick="fn_search('new')">검색</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- //formgroup -->
<div class="row">
    <div class="col-md-12">
        <div class="card">
            <div class="card-body">
                <div class="mb-5">
                    <button type="button" class="btn btn-outline-info mx-auto float-right" onclick="excelDownload()"><i class="mdi mdi-file-excel"></i>엑셀다운로드</button>
                </div>
                <table class="table table-hover">
                    <thead>
                    <tr>
                        <th scope="col" width="5%">CODE</th>
                        <th scope="col" width="7%">ID</th>
                        <th scope="col" width="7%">이름</th>
                        <th scope="col" width="10%">휴대전화</th>
                        <th scope="col" width=10%">Email</th>
                        <th scope="col" width="10%">등록일</th>
                        <th scope="col" width="10%">직렬</th>
                        <th scope="col" width="10%">등급</th>
                        <th scope="col" width="8%">권한</th>
                        <th scope="col" width="10%">모바일가입</th>
                    </tr>
                    </thead>
                    <tbody id="dataList"></tbody>
                    <tr>
                        <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
                    </tr>
                </table>
                <%@ include file="/common/inc/com_pageNavi.inc" %>
            </div>
        </div>
    </div>
</div>
</div>
<!-- // 기본소스-->
</div>

<script>
    $("#searchStartDate , #searchEndDate").datepicker({
        language: "kr",
        format: "yyyy-mm-dd",
        numberOfMonths: 2
    });
</script>
<!--main wapper-->
<%@include file="/common/jsp/footer.jsp" %>
