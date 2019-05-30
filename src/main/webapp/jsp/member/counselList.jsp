<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/memberManageService.js'></script>
<script>
    function init() {
        searchCounselSelectBox("l_searchSel");
        menuActive('menu-5', 3);
        fn_search('new');
    }

    //상담내역 불러오기
    function fn_search(val) {
        var paging = new Paging();
        var sPage = getInputTextValue("sPage");
        var searchType = getSelectboxValue("searchCounselSel");
        var searchText = getInputTextValue("searchText");

        if (searchType == null) searchType = "";
        if (val == "new") sPage = "1";

        dwr.util.removeAllRows("dataList");
        gfn_emptyView("H", "");

        memberManageService.getCounselListCount(searchType, searchText, function (cnt) {
            paging.count(sPage, cnt, '10', '10', comment.blank_list);
            var listNum = ((cnt-1)+1)-((sPage-1)*10); //리스트 넘버링
            memberManageService.getCounselList(sPage, pagingListCount(), searchType, searchText, function (selList) {
                if (selList.length == 0) return;
                console.log(selList);
                if (selList.length > 0) {
                    for (var i = 0; i < selList.length; i++) {
                        var cmpList = selList[i];
                        if (cmpList != undefined) {
                            var cellData = [
                                function(data) {return listNum--;},
                               /* function(data) {return cmpList.userId == null ? "-" : cmpList.userId;},
                                function(data) {return cmpList.name == null ? "-" : cmpList.name;},
                                function(data) {return cmpList.indate == null ? "-" : cmpList.indate;},
                                function(data) {return cmpList.reason == null ? "-" : cmpList.reason;},
                                function(data) {return acceptBtn;},
                                function(data) {return deleteBtn;},*/
                            ];
                            dwr.util.addRows("dataList", [0], cellData, {escapeHtml: false});
                        }
                    }
                }else{
                    gfn_emptyView3("V", comment.blank_list2);
                }

            });
        });
    }


</script>
<div class="page-breadcrumb">
    <input type="hidden" id="sPage">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">상담내역</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">회원관리</li>
                        <li class="breadcrumb-item active" aria-current="page">상담내역</li>
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
                    <!--상품별 디바이스 TABLE-->
                    <table class="table table-hover text-center">
                        <thead>
                        <tr>
                            <th scope="col" style="width: 5%;">No.</th>
                            <th scope="col" style="width: 10%;">ID</th>
                            <th scope="col" style="width: 10%;">이름</th>
                            <th scope="col" style="width: 8%;">상담구분</th>
                            <th scope="col" style="width: 10%;">연락처</th>
                            <th scope="col" style="width: 15%;">접수일</th>
                            <th scope="col" style="width: 15%;">처리시작일</th>
                            <th scope="col" style="width: 15%;">완료일</th>
                        </tr>
                        </thead>
                        <tbody id="dataList"></tbody>
                        <tr>
                            <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
                        </tr>
                    </table>
                    <div style="display: none">
                        <%@ include file="/common/inc/com_pageNavi.inc" %>
                    </div>
            </div>
        </div>
    </div>
</div>


<%@include file="/common/jsp/footer.jsp" %>
