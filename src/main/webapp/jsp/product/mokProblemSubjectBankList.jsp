<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/productManageService.js'></script>
<script>
    function init() {
        getProductSearchSelectbox("l_searchSel");
        menuActive('menu-1', 13);
    }

        function goModifyBankSubject(bankSubjectKey) {
        innerValue("bankSubjectKey", bankSubjectKey);
        goPage("productManage","modifyMokProblemSubjectBank");
    }

    function fn_search(val) {

        var paging = new Paging();
        var sPage = getInputTextValue("sPage");
        var searchType = getSelectboxValue("searchType");   //검색 조건 셀렉트박스 값
        var searchText = getInputTextValue("searchText");   //검색 값

        if (val == "new") sPage = "1";

        dwr.util.removeAllRows("dataList"); //테이블 리스트 초기화
        gfn_emptyView("H", "");//페이징 예외사항처리

        productManageService.getMockExamQuestionBankSubjectListCount(searchType, searchText, function (cnt) {
            paging.count(sPage, cnt, '10', '10', comment.blank_list);
            var listNum = ((cnt-1)+1)-((sPage-1)*10); //리스트 넘버링
            productManageService.getMockExamQuestionBankSubjectList(sPage, pagingListCount(), searchType, searchText, function (selList) {
                if (selList.length == 0) return;
                dwr.util.addRows("dataList", selList, [
                    function(data) {return listNum--;},
                    function(data) {return data.ctgName;},
                    function(data) {return "<a href='javascript:void(0);' style='float:left' color='blue' onclick='goModifyBankSubject(" + data.examQuestionBankSubjectKey + ");'>" +  data.name + "</a>";},
                    function(data) {return data.questionNumber;},
                ], {escapeHtml:false});
            });
        });
    }
</script>
<div class="page-breadcrumb">
    <input type="hidden" id="sPage">
    <input type="hidden" id="bankSubjectKey"  name="bankSubjectKey">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">모의고사 문제은행 과목목록</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">상품관리</li>
                        <li class="breadcrumb-item active" aria-current="page">모의고사 문제은행 과목목록</li>
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
                    <thead>
                    <tr>
                        <th scope="col" style="width: 5%;">No.</th>
                        <th scope="col" style="width: 5%;">과목</th>
                        <th scope="col" style="width: 45%;">이름</th>
                        <th scope="col" style="width: 10%;">문제수</th>
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
