<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/productManageService.js'></script>
<script>
    function init() {
        getProductSearchSelectbox("l_searchSel");
        menuActive('menu-1', 7);
    }

    function goModifyMockExam(examKey) {
        innerValue("examKey",examKey);
        goPage("productManage","modifyMokExam");
    }

    function fn_search(val) {
        var paging = new Paging();
        var sPage = getInputTextValue("sPage");
        var searchType = getSelectboxValue("searchType");   //검색 조건 셀렉트박스 값
        var searchText = getInputTextValue("searchText");   //검색 값

        if (val == "new") sPage = "1";

        dwr.util.removeAllRows("dataList"); //테이블 리스트 초기화
        gfn_emptyView("H", "");//페이징 예외사항처리

        productManageService.getMockExamListCount(searchType, searchText, function (cnt) {
            paging.count(sPage, cnt, '10', '10', comment.blank_list);
            var listNum = ((cnt-1)+1)-((sPage-1)*10); //리스트 넘버링
            productManageService.getMockExamList(sPage, pagingListCount(), searchType, searchText, function (selList) {
                console.log(selList);
                if (selList.length == 0) return;
                dwr.util.addRows("dataList", selList, [
                    function(data) {return "<a href='javascript:void(0);' color='blue' onclick='goModifyMockExam(" + data.examKey + ");'>" +  data.name + "</a>";},
                    function(data) {return split_minute_getDay(data.acceptStartDate)+"<br>"+split_minute_getDay(data.acceptEndDate);},
                    function(data) {return split_minute_getDay(data.onlineStartDate)+"<br>"+split_minute_getDay(data.onlineEndDate);},
                    function(data) {return data.onlineTime+'분';},
                ], {escapeHtml:false});
            });
        });
    }
</script>
<div class="page-breadcrumb">
    <input type="hidden" id="sPage">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">모의고사 목록</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">상품관리</li>
                        <li class="breadcrumb-item active" aria-current="page">모의고사 목록</li>
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
                            <span id="l_searchSel"></span>
                        </div>
                        <div style=" float: left; width: 33%; margin-left: 10px">
                            <input type="text" class="form-control" id="searchText" onkeypress="if(event.keyCode==13) {fn_search('new'); return false;}">
                        </div>
                        <div style=" float: left; width: 33%; margin-left: 10px;">
                            <button type="button" class="btn btn-outline-info mx-auto" onclick="fn_search('new')">검색</button>
                        </div>
                    </div>
                </div>
                <table class="table table-hover text-center">
                    <input type="hidden" id="examKey" name="examKey" value="">
                    <thead>
                    <tr>
                        <th scope="col" style="width: 50%;">시험명</th>
                        <th scope="col" style="width: 15%;">시험신청기간</th>
                        <th scope="col" style="width: 15%;">시험기간</th>
                        <th scope="col" style="width: 10%;">진행시간</th>
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
