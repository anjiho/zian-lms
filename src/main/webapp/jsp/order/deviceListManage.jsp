<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/orderManageService.js'></script>
<script>
    function init() {
        getSearchDeviceSelectbox("l_searchSel");
        deviceManageSelectbox("deviceSel",'');
        menuActive('menu-3', 11);
        changeDeviceList(0);
    }

    function fn_search(val) {//상품별
        var paging = new Paging();
        var sPage = getInputTextValue("sPage");
        var searchType = getSelectboxValue("searchType");   //검색 조건 셀렉트박스 값
        var searchText = getInputTextValue("searchText");   //검색 값

        if (val == "new") sPage = "1";

        dwr.util.removeAllRows("dataList"); //테이블 리스트 초기화
        gfn_emptyView("H", "");//페이징 예외사항처리

        var loading = new Loading({
            direction: 'hor',
            discription: '검색중',
            animationIn: false,
            animationOut: false,
            defaultApply: 	true,
        });

        orderManageService.getPcDeviceListCount(searchType, searchText, function (cnt) {
            paging.count(sPage, cnt, '10', '10', comment.blank_list);
            var listNum = ((cnt-1)+1)-((sPage-1)*10); //리스트 넘버링
            orderManageService.getPcDeviceList(sPage, pagingListCount(), searchType, searchText, function (selList) {
                if (selList.length == 0) return;
                dwr.util.addRows("dataList", selList, [
                    function(data) {return data.userName == null ? "-" : data.userName;},
                    function(data) {return data.userId == null ? "-" : data.userId;},
                    function(data) {return data.indate == null ? "-" : split_minute_getDay(data.indate);},
                    function(data) {return data.deviceId+"<br>"+data.goodsName;},
                    function(data) {return "<button type='button' onclick='DeviceDelete("+ data.deviceLimitKey +");' class='btn btn-outline-danger btn-sm'>삭제</button>";},
                ], {escapeHtml:false});
            });
            loadingOut(loading);
        });
    }

    function fn_search3(val) {//모바일
        var paging = new Paging();
        var sPage = $("#sPage3").val();
        var searchType = getSelectboxValue("searchType");
        var searchText = getInputTextValue("searchText");

        if(val == "new")  sPage = "1";

        dwr.util.removeAllRows("dataList3");
        gfn_emptyView3("H", "");//페이징 예외사항처리
        orderManageService.getMobileDeviceListCount(searchType, searchText, function(cnt) {
            paging.count3(sPage, cnt, '10', '10', comment.blank_list);
            var listNum = ((cnt-1)+1)-((sPage-1)*10); //리스트 넘버링
            orderManageService.getMobileDeviceList(sPage, '10', searchType, searchText, function (selList) {
                if (selList.length > 0) {
                    for (var i = 0; i < selList.length; i++) {
                        var cmpList = selList[i];
                        var btn = "<button type='button' onclick='DeviceDelete("+ cmpList.deviceLimitKey +")' class='btn btn-outline-danger btn-sm'>삭제</button>";
                        if (cmpList != undefined) {
                            var cellData = [
                                function(data) {return cmpList.userKey == null ? "-" : cmpList.userKey;},
                                function(data) {return cmpList.userId == null ? "-" : cmpList.userId;},
                                function(data) {return cmpList.deviceId == null ? "-" : cmpList.deviceId;},
                                function(data) {return cmpList.deviceModel == null ? "-" : cmpList.deviceModel;},
                                function(data) {return cmpList.osVersion == null ? "-" : cmpList.osVersion;},
                                function(data) {return cmpList.appVersion == null ? "-" : cmpList.appVersion;},
                                function(data) {return btn;},
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

    function DeviceDelete(key) {
        if(key != 0){
            if(confirm('삭제하시겠습니까?')){orderManageService.deleteUserDeviceLimit(key, function (selList) {isReloadPage();});}
        }
    }

    function changeDeviceList(val) {
        if(val == '0'){
            $("#productDeviceTable").show();
            $("#mobileDeviceTable").hide();
            fn_search('new');
        }else{
            $("#mobileDeviceTable").show();
            $("#productDeviceTable").hide();
            fn_search3('new');
        }
    }

    function search() {
        var deviceType = getSelectboxValue('deivceSel');
        if(deviceType == '0') fn_search('new');
        else fn_search3('new');
    }
</script>
<div class="page-breadcrumb">
    <input type="hidden" id="sPage">
    <input type="hidden" id="sPage3">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">상품/모바일 디바이스 관리</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">주문관리</li>
                        <li class="breadcrumb-item active" aria-current="page">상품/모바일 디바이스 관리</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</div>
<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            <div class="form-group row">
                <label class="col-sm-1 control-label col-form-label" style="margin-bottom: 0">디바이스 선택</label>
                <div class="col-sm-6 pl-0 pr-0">
                    <span id="deviceSel"></span>
                </div>
            </div>
            <div class="card">
                <div class="card-body">
                    <div class="form-group row">
                        <div style=" float: left; width: 10%">
                            <span id="l_searchSel"></span>
                        </div>
                        <div style=" float: left; width: 33%; margin-left: 10px">
                            <input type="text" class="form-control" id="searchText" onkeypress="if(event.keyCode==13) {fn_search('new'); return false;}">
                        </div>
                        <div style=" float: left; width: 33%; margin-left: 10px;">
                            <!--<button type="button" class="btn btn-outline-info mx-auto" onclick="fn_search('new')">검색</button>-->
                            <button type="button" class="btn btn-outline-info mx-auto" onclick="search()">검색</button>
                        </div>
                    </div>
                </div>
                <div id="productDeviceTable" style="display:none">
                    <!--상품별 디바이스 TABLE-->
                    <table class="table table-hover text-center">
                        <thead>
                        <tr>
                            <th scope="col" style="width: 5%;">사용자</th>
                            <th scope="col" style="width: 10%;">ID</th>
                            <th scope="col" style="width: 10%;">일시</th>
                            <th scope="col" style="width: 45%;">디바이스 ID / 상품명</th>
                            <th scope="col" style="width: 5%;"></th>
                        </tr>
                        </thead>
                        <tbody id="dataList"></tbody>
                        <tr>
                            <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
                        </tr>
                    </table>
                     <%@ include file="/common/inc/com_pageNavi.inc" %>
                </div>
                <!--//상품별 디바이스 TABLE-->
                <div id="mobileDeviceTable" style="display:none">
                <!--모바일 디바이스 TABLE-->
                    <table class="table table-hover text-center">
                        <thead>
                        <tr>
                            <th scope="col" style="width: 5%;">사용자</th>
                            <th scope="col" style="width: 5%;">ID</th>
                            <th scope="col" style="width: 30%;">디바이스 ID</th>
                            <th scope="col" style="width: 15%;">모델명</th>
                            <th scope="col" style="width: 15%;">OS버전</th>
                            <th scope="col" style="width: 10%;">App버전</th>
                            <th scope="col" style="width: 5%;"></th>
                        </tr>
                        </thead>
                        <tbody id="dataList3"></tbody>
                        <tr>
                            <td id="emptys3" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
                        </tr>
                    </table>
                    <%@ include file="/common/inc/com_pageNavi3.inc" %>
                <!--//모바일 디바이스 TABLE-->
                </div>
            </div>
        </div>
    </div>
</div>


<%@include file="/common/jsp/footer.jsp" %>
