<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/productManageService.js'></script>
<script>
    function init() {
        getProductSearchSelectbox("l_searchSel");
        menuActive('menu-1', 5);
        fn_search('new');
    }

    function goModifyBook(gKey) {
        innerValue("param_key", gKey);
        goPage("productManage","modifyBook");
    }

    function fn_search(val) {
        var paging = new Paging();
        var sPage = getInputTextValue("sPage");
        var searchType = getSelectboxValue("searchType");   //검색 조건 셀렉트박스 값
        var searchText = getInputTextValue("searchText");   //검색 값
        if(searchType == null) searchType = "";
        if (val == "new") sPage = "1";

        dwr.util.removeAllRows("dataList"); //테이블 리스트 초기화
        gfn_emptyView("H", "");//페이징 예외사항처리

        productManageService.getProductListCount(searchType, searchText, "BOOK", function (cnt) {
            paging.count(sPage, cnt, '10', '10', comment.blank_list);
            var listNum = ((cnt-1)+1)-((sPage-1)*10); //리스트 넘버링
            productManageService.getProductList(sPage, pagingListCount(), searchType, searchText, "BOOK", function (selList) {
                if (selList.length == 0) return;
                dwr.util.addRows("dataList", selList, [
                    function(data) {return listNum--;},
                    // function(data) {return i+1;},
                    function(data) {return data.GKey;},
                    function(data) {return "<a href='javascript:void(0);' color='blue' style='float:left' onclick='goModifyBook(" + data.GKey + ");'>" + data.goodsName + "</a>";},
                    function(data) {return split_minute_getDay(data.indate);},
                    function(data) {return data.isShow == 0 ? "<i class='mdi mdi-close' style='color: red'></i>" : "<i class='mdi mdi-check' style='color:green;'></i>";},
                    function(data) {return data.isSell == 0 ? "<i class='mdi mdi-close' style='color: red'></i>" : "<i class='mdi mdi-check' style='color:green;'></i>";},
                    function(data) {return data.isFree == 0 ? "<i class='mdi mdi-close' style='color: red'></i>" : "<i class='mdi mdi-check' style='color:green;'></i>";},
                ], {escapeHtml:false});
            });
        });
    }
</script>
<div class="page-breadcrumb">
    <input type="hidden" id="sPage">
    <input type="hidden" id="gKey"  name="gKey">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">도서 목록</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">상품관리</li>
                        <li class="breadcrumb-item active" aria-current="page">도서목록</li>
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
                        <th scope="col" style="width: 5%;">CODE</th>
                        <th scope="col" style="width: 45%;">상품명</th>
                        <th scope="col" style="width: 10%;">등록일</th>
                        <th scope="col" style="width: 5%;">노출</th>
                        <th scope="col" style="width: 5%;">판매</th>
                        <th scope="col" style="width: 5%;">무료</th>
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
