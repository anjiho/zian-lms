<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/memberManageService.js'></script>
<script>
    function init() {
        searchMemberSelectBox("l_searchSel");
        searchMemberSelectBox1("l_searchSel1");
        menuActive('menu-5', 2);
        fn_search('new');
        fn_search3('new');
    }

    //탈퇴신청 리스트 불러오기
    function fn_search(val) {
        var paging = new Paging();
        var sPage = getInputTextValue("sPage");
        var searchType = getSelectboxValue("searchMemberSel");
        var searchText = getInputTextValue("searchText");

        if (searchType == null) searchType = "";
        if (val == "new") sPage = "1";

        dwr.util.removeAllRows("dataList");
        gfn_emptyView("H", "");

        memberManageService.getMemeberSecessionApplyListCount(searchType, searchText, function (cnt) {
            paging.count(sPage, cnt, '10', '10', comment.blank_list);
            var listNum = ((cnt-1)+1)-((sPage-1)*10); //리스트 넘버링
            memberManageService.getMemeberSecessionApplyList(sPage, pagingListCount(), searchType, searchText, function (selList) {
                if (selList.length == 0) return;
                if (selList.length > 0) {
                    for (var i = 0; i < selList.length; i++) {
                        var cmpList = selList[i];
                        if (cmpList != undefined) {
                            var acceptBtn  = "<button type=\"button\" onclick='SecessionAccept("+cmpList.secessionKey+")' class=\"btn btn-outline-info btn-sm\">승인</button>";
                            var deleteBtn  = "<button type=\"button\" onclick='SecessionCancel("+cmpList.secessionKey+")' class=\"btn btn-outline-danger btn-sm\">취소</button>";
                            var cellData = [
                                function(data) {return listNum--;},
                                function(data) {return cmpList.userId == null ? "-" : cmpList.userId;},
                                function(data) {return cmpList.name == null ? "-" : cmpList.name;},
                                function(data) {return cmpList.indate == null ? "-" : cmpList.indate;},
                                function(data) {return cmpList.reason == null ? "-" : cmpList.reason;},
                                function(data) {return acceptBtn;},
                                function(data) {return deleteBtn;},
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

    function SecessionAccept(secessionKey) {
        if(confirm("승인 하시겠습니까?")){memberManageService.approveSecession(secessionKey, function () {isReloadPage();});}
    }

    function SecessionCancel(secessionKey) {
        if(confirm("취소 하시겠습니까?")) {memberManageService.cancelSecession(secessionKey, function () {isReloadPage();});}
    }
    
    //탈퇴리스트 불러오기
    function fn_search3(val) {
        var paging = new Paging();
        var sPage = $("#sPage3").val();
        var searchType = getSelectboxValue("searchMemberSel1");
        var searchText = getInputTextValue("searchText1");

        if(val == "new") sPage = "1";

        dwr.util.removeAllRows("dataList3");
        gfn_emptyView3("H", "");//페이징 예외사항처리
        memberManageService.getMemeberSecessionListCount(searchType, searchText, function(cnt) {
            paging.count3(sPage, cnt, '10', '10', comment.blank_list);
            var listNum = ((cnt-1)+1)-((sPage-1)*10); //리스트 넘버링
            memberManageService.getMemeberSecessionList(sPage, '10',searchType, searchText, function (selList) {
                if (selList.length > 0) {
                    for (var i = 0; i < selList.length; i++) {
                        var cmpList = selList[i];
                        if (cmpList != undefined) {
                            var cellData = [
                                function(data) {return listNum--;},
                                function(data) {return cmpList.userId;},
                                function(data) {return cmpList.name;},
                                function(data) {return cmpList.indate;},
                                function(data) {return cmpList.reason;},
                                function(data) {return "";},
                                function(data) {return "";},
                            ];
                            dwr.util.addRows("dataList3", [0], cellData, {escapeHtml: false});
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
    <input type="hidden" id="sPage3">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">회원 탈퇴 / 신청 목록</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">회원관리</li>
                        <li class="breadcrumb-item active" aria-current="page">회원 탈퇴 / 신청 목록</li>
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
                    <div class="form-group">
                        <h4>회원탈퇴 신청 목록</h4>
                    </div>
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
                <div id="productDeviceTable">
                    <!--상품별 디바이스 TABLE-->
                    <table class="table table-hover">
                        <thead>
                        <tr>
                            <th scope="col" style="width: 5%;">No.</th>
                            <th scope="col" style="width: 10%;">ID</th>
                            <th scope="col" style="width: 10%;">이름</th>
                            <th scope="col" style="width: 20%;">탈퇴일</th>
                            <th scope="col" style="width: 25%;">탈퇴사유</th>
                            <th scope="col" style="width: 5%;">탈퇴승인</th>
                            <th scope="col" style="width: 5%;">탈퇴취소</th>
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
            <div class="card">
                <div class="card-body">
                    <div class="form-group">
                        <h4>회원탈퇴 목록</h4>
                    </div>
                    <div>
                        <div style=" float: left; width: 10%">
                            <span id="l_searchSel1"></span>
                        </div>
                        <div style=" float: left; width: 33%; margin-left: 10px">
                            <input type="text" class="form-control" id="searchText1" onkeypress="if(event.keyCode==13) {fn_search('new'); return false;}">
                        </div>
                        <div style=" float: left; width: 33%; margin-left: 10px;">
                            <button type="button" class="btn btn-outline-info mx-auto" onclick="fn_search3('new')">검색</button>
                        </div>
                    </div>
                </div>
                    <!--상품별 디바이스 TABLE-->
                    <table class="table table-hover">
                        <thead>
                        <tr>
                            <th scope="col" style="width: 5%;">No.</th>
                            <th scope="col" style="width: 10%;">ID</th>
                            <th scope="col" style="width: 10%;">이름</th>
                            <th scope="col" style="width: 20%;">탈퇴일</th>
                            <th scope="col" style="width: 25%;">탈퇴사유</th>
                            <th scope="col" style="width: 5%;"></th>
                            <th scope="col" style="width: 5%;"></th>
                        </tr>
                        </thead>
                        <tbody id="dataList3"></tbody>
                        <tr>
                            <td id="emptys3" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
                        </tr>
                    </table>
                <%@ include file="/common/inc/com_pageNavi3.inc" %>
            </div>
        </div>
    </div>
</div>


<%@include file="/common/jsp/footer.jsp" %>
