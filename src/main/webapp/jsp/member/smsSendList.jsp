<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/memberManageService.js'></script>
<script>
    function init() {
        getSmsSearchSelectbox("l_searchSel");
        menuActive('menu-5', 2);
        fn_search('new');
        getSmsYearSelectbox("l_monthYearSel","");
    }

    function fn_search(val) {
        var paging = new Paging();
        var sPage = getInputTextValue("sPage");
        var searchType = getSelectboxValue("searchType");   //검색 조건 셀렉트박스 값
        var searchText = getInputTextValue("searchText");   //검색 값
        var yyyyMM = getSelectboxValue("searchYearMonth");
        if(searchType == null) searchType = "";
        if (val == "new") sPage = "1";

        dwr.util.removeAllRows("dataList"); //테이블 리스트 초기화
        gfn_emptyView("H", "");//페이징 예외사항처리

        memberManageService.getSmsSendListCount(yyyyMM, searchType, searchText,function (cnt) {
            paging.count(sPage, cnt, '10', '10', comment.blank_list);
            var listNum = ((cnt-1)+1)-((sPage-1)*10); //리스트 넘버링
            memberManageService.getSmsSendList(sPage, pagingListCount(), yyyyMM, searchType, searchText, function (selList) {
                console.log(selList);
                if (selList.length == 0) return;
                dwr.util.addRows("dataList", selList, [
                    function(data) {return data.sendDate;},
                    function(data) {return InputPhoneNumCheck(data.receiveNumber);},
                    function(data) {return InputPhoneNumCheck(data.sendNumber);},
                    function(data) {return "<a href='javascript:void(0);' color='blue' style='float:left' onclick='MemberDetail(" + data.userKey + ");'>" + data.receiverId + "</a>";},
                    function(data) {return data.sendMessage;},
                    function(data) {return data.receiverName;},
                ], {escapeHtml:false});
            });
        });
    }
    
    function MemberDetail(userKey) {
        innerValue("param_key", userKey);
        goPage('memberManage', 'memberManage');
    }
</script>
<div class="page-breadcrumb">
    <input type="hidden" id="sPage">
    <input type="hidden" id="param_key" name="param_key" value="">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">SMS 발송내역</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">회원 관리</li>
                        <li class="breadcrumb-item active" aria-current="page">SMS 발송내역</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</div>
<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <div>
                        <div style=" float: left; width: 10%">
                            <span id="l_monthYearSel"></span>
                        </div>
                        <div style=" float: left; width: 10%;margin-left: 10px">
                            <span id="l_searchSel"></span>
                        </div>
                        <div style=" float: left; width: 33%;margin-left: 10px">
                            <input type="text" class="form-control" id="searchText" onkeypress="if(event.keyCode==13) {fn_search('new'); return false;}">
                        </div>
                        <div style=" float: left; width: 33%; margin-left: 10px;">
                            <button type="button" class="btn btn-outline-info mx-auto" onclick="fn_search('new')">검색</button>
                        </div>
                    </div>
                </div>
                <table class="table table-hover text-center">
                    <thead>
                    <tr>
                        <th scope="col" style="width: 15%;">발송일</th>
                        <th scope="col" style="width: 10%;">수신번호</th>
                        <th scope="col" style="width: 10%;">발신번호</th>
                        <th scope="col" style="width: 4%;">수신자</th>
                        <th scope="col" style="width: 35%;">내용</th>
                        <th scope="col" style="width: 10%;">결과</th>

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


<%@include file="/common/jsp/footer.jsp" %>
