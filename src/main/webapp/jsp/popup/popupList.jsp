<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/popupCouponManageService.js'></script>
<script>
    function init() {
        //getProductSearchSelectbox("l_searchSel");
        menuActive('menu-4', 1);
        fn_search('new');
    }
    function fn_search(val) {
        var paging = new Paging();
        var sPage = getInputTextValue("sPage");

        if (val == "new") sPage = "1";

        dwr.util.removeAllRows("dataList"); //테이블 리스트 초기화
        gfn_emptyView("H", "");//페이징 예외사항처리

        popupCouponManageService.getPopupListCount( function (cnt) {
                paging.count(sPage, cnt, '10', '10', comment.blank_list);
                var listNum = ((cnt-1)+1)-((sPage-1)*10); //리스트 넘버링
            popupCouponManageService.getPopupList(sPage, 10, function (selList) {
                        if (selList.length == 0) return;
                        dwr.util.addRows("dataList", selList, [
                            function(data) {return listNum--;},
                            function(data) {return "<a href='javascript:void(0);' color='blue' style='float:left' onclick='goModifyPopup(" + data.popupKey + ");'>" + data.name + "</a>";},
                            function(data) {return data.type;},
                            function(data) {return data.width+"px";},
                            function(data) {return data.height+"px";},
                            function(data) {return data.left+"px";},
                            function(data) {return data.top+"px";},
                            function(data) {return split_minute_getDay(data.startDate)+" ~ "+split_minute_getDay(data.endDate);},
                            function(data) {return data.isShow == 0 ?  "<i class='mdi mdi-close' style='color: red'></i>" : "<i class='mdi mdi-check' style='color:green;'></i>";},
                        ], {escapeHtml:false});
                    });
            });
    }
    function goModifyPopup(val) {
        innerValue('param_key', val);
        goPage('popupCouponManage', 'modifyPopup');
    }

</script>
<div class="page-breadcrumb">
    <input type="hidden" id="sPage">
    <input type="hidden" id="popupKey" name="popupKey" value="">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">팝업 목록</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">팝업/쿠폰 관리</li>
                        <li class="breadcrumb-item active" aria-current="page">팝업 목록</li>
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
                    <!--<div>
                        <div style=" float: left; width: 10%">
                            <span id="l_searchSel"></span>
                        </div>
                        <div style=" float: left; width: 33%; margin-left: 10px">
                            <input type="text" class="form-control" id="searchText" onkeypress="if(event.keyCode==13) {fn_search('new'); return false;}">
                        </div>
                        <div style=" float: left; width: 33%; margin-left: 10px;">
                            <button type="button" class="btn btn-outline-info mx-auto" onclick="fn_search('new')">검색</button>
                        </div>
                    </div>-->
                </div>
                <table class="table table-hover text-center">
                    <thead>
                    <tr>
                        <th scope="col" width="5%">No.</th>
                        <th scope="col" width="25%">팝업명</th>
                        <th scope="col" width="8%">타입</th>
                        <th scope="col" width="8%">Width</th>
                        <th scope="col" width="8%">Height</th>
                        <th scope="col" width="8%">Left</th>
                        <th scope="col" width="8%">Top</th>
                        <th scope="col" width="25%">노출기간</th>
                        <th scope="col" width="5%">노출</th>
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
