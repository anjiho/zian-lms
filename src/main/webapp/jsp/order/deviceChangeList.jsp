<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
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
<script type='text/javascript' src='/dwr/interface/orderManageService.js'></script>
<script>
    function init() {
        getSearchDeviceSelectbox("l_searchSel");
        menuActive('menu-3', 12);
        deviceSelectbox1('deviceSel', '');
        setSearchDate('6m', 'searchStartDate', 'searchEndDate');
        fn_search('new');
    }

    function fn_search(val) {
        var paging = new Paging();
        var sPage = getInputTextValue("sPage");

        if (val == "new") sPage = "1";

        dwr.util.removeAllRows("dataList"); //테이블 리스트 초기화
        gfn_emptyView("H", "");//페이징 예외사항처리

        var searchType = getSelectboxValue("searchType");//검색타입
        var startSearchDate = getInputTextValue('searchStartDate');
        var endSearchDate = getInputTextValue('searchEndDate');
        var searchText = getInputTextValue('searchText');
        var deviceType = getSelectboxValue('deviceSel');

        var loading = new Loading({
            direction: 'hor',
            discription: '검색중',
            animationIn: false,
            animationOut: false,
            defaultApply: 	true,
        });


        orderManageService.getDeviceChangeLogListCount(startSearchDate, endSearchDate, deviceType, searchType, searchText, function (cnt) {
                paging.count(sPage, cnt, '10', '10', comment.blank_list);
                var listNum = ((cnt-1)+1)-((sPage-1)*10); //리스트 넘버링
                orderManageService.getDeviceChangeLogList(sPage, pagingListCount(), startSearchDate, endSearchDate, deviceType, searchType, searchText, function (selList) {
                        if (selList.length == 0) return;
                        if(selList.length > 0){
                            for (var i = 0; i < selList.length; i++) {
                                var cmpList = selList[i];
                                if (cmpList != undefined) {
                                    var goodsName = cmpList.goodsName == null ? "-" : cmpList.goodsName;
                                    var deviceId = cmpList.deviceId == null ? "-" : cmpList.deviceId;
                                    var deviceProductHtml = deviceId+"<br>"+"<a color='grey' >"+goodsName+"</a>";
                                    var cellData = [
                                        function(data) {return cmpList.userId == null ? "-" : cmpList.userId;},
                                        function(data) {return cmpList.userId == null ? "-" : "<a href='javascript:void(0);' style='float:left' color='blue'>"+cmpList.userId+"</a>";},
                                        function(data) {return cmpList.indate == null ? "-" : split_minute_getDay(cmpList.indate);},
                                        function(data) {return cmpList.deleteDate == null ? "-" : split_minute_getDay(cmpList.deleteDate);},
                                        function(data) {return deviceProductHtml;},
                                        function(data) {return cmpList.type == 0 ? "<i class='mdi mdi-close' style='color: red'></i>" : "<i class='mdi mdi-check' style='color:green;'></i>";},
                                        function(data) {return cmpList.deviceModel == null ? "-" : cmpList.deviceModel;},
                                        function(data) {return cmpList.osVersion == null ? "-" : cmpList.osVersion;},
                                        function(data) {return cmpList.appVersion == null ? "-" : cmpList.appVersion;},
                                    ];
                                    dwr.util.addRows(dataList, [0], cellData, {escapeHtml:false});
                                }else{
                                    gfn_emptyView("V", comment.blank_list2);
                                }
                            }
                        }
                    });
            loadingOut(loading);
            });
    }

</script>
<div class="page-breadcrumb">
    <input type="hidden" id="sPage">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">기기변경 이력조회</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">주문관리</li>
                        <li class="breadcrumb-item active" aria-current="page">기기변경 이력조회</li>
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
                            <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">디바이스</label>
                            <div class="col-lg-5">
                                <span id="deviceSel"></span>
                            </div>
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
                <div class="form-group row">
                    <div style=" float: left; width: 10%">
                        <span id="l_searchSel"></span>
                    </div>
                    <div style=" float: left; width: 33%; margin-left: 10px">
                        <input type="text" class="form-control" id="searchText" onkeypress="if(event.keyCode==13) {fn_search('new'); return false;}">
                    </div>
                    <div style=" float: left; width: 33%; margin-left: 10px;">
                        <!--<button type="button" class="btn btn-outline-info mx-auto" onclick="fn_search('new')">검색</button>-->
                        <button type="button" class="btn btn-outline-info mx-auto" onclick="fn_search('new')">검색</button>
                    </div>
                </div>
                <table class="table table-hover">
                    <thead>
                    <tr>
                        <th scope="col" width="5%">사용자</th>
                        <th scope="col" width="5%">ID</th>
                        <th scope="col" width="9%">생성일시</th>
                        <th scope="col" width="9%">삭제일시</th>
                        <th scope="col" width="28%">디바이스ID / 상품명</th>
                        <th scope="col" width="6%">모바일</th>
                        <th scope="col" width="15%">모델명</th>
                        <th scope="col" width="15%">OS버전</th>
                        <th scope="col" width="20%">App버전</th>
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
