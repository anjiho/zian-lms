<%@ page import="com.zianedu.lms.utils.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<%
    String JLecKey = request.getParameter("param_key");
    String type = request.getParameter("type");

    String payStatus = Util.isNullValue(request.getParameter("param_key2"), "");
    String orderStatus = Util.isNullValue(request.getParameter("param_key3"), "");
    String orderSearch = Util.isNullValue(request.getParameter("param_key4"), "");
    String searchStartDate = Util.isNullValue(request.getParameter("param_key5"), "");
    String searchEndDate = Util.isNullValue(request.getParameter("param_key6"), "");
    String searchText = Util.isNullValue(request.getParameter("param_key7"), "");
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
    .pt-06 {padding-top:6px;}
    #orderStatus input{margin-right: 10px; position: relative; top:1.5px; left: 2px;}
</style>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/orderManageService.js'></script>
<script>
    $( document ).ready(function() {
        $('#stateModal').on('hidden.bs.modal', function (e) {
            $('form').each(function () {
                this.reset();
            });
        });
        $('#optionModal').on('hidden.bs.modal', function (e) {
            $('form').each(function () {
                this.reset();
            });
        });
    });
    function init() {
        var payStatus='<%=payStatus%>';
        var orderStatus= '<%=orderStatus%>';
        var orderSearch ='<%=orderSearch%>';
        var searchStartDate='<%=searchStartDate%>';
        var searchEndDate='<%=searchEndDate%>';
        var searchText='<%=searchText%>';

        getProductSearchSelectbox("l_searchSel");
        menuActive('menu-3', 8);
        getlectureWatchPayStatusSelectbox('PayStatus',payStatus); //결제상태
        getlectureWatchOrderStatusCheckbox('orderStatus',orderStatus); //진행상태
        getlectureWatchOrderStatusSelectbox('ModalStatus', ''); //팝업 진행상태
        orderSearchSelectbox('orderSearch', orderSearch);
        listNumberSelectbox('listNumberSel', 10);
        getVideoOptionTypeList("optionSel",""); //팝업창 옵션
        if(searchStartDate==''){
            if(searchEndDate==''){
                setSearchDate('6m', 'searchStartDate', 'searchEndDate');
            }else{
                innerValue("searchStartDate", searchStartDate);
                innerValue("searchEndDate", searchEndDate);
            }
        }else{
            innerValue("searchStartDate", searchStartDate);
            innerValue("searchEndDate", searchEndDate);
        }

        innerValue("searchText", searchText);

        if(orderStatus.indexOf(',')!=-1){
            var orderStatusArr=splitReplace(orderStatus,',');
            overlapCheckbox('orderStatus',orderStatusArr);
        }

        fn_search("new");
    }

    function fn_search(val) {
        var paging = new Paging();
        var sPage = getInputTextValue("sPage");

        if (val == "new") sPage = "1";

        dwr.util.removeAllRows("dataList"); //테이블 리스트 초기화
        gfn_emptyView("H", "");//페이징 예외사항처리
        innerValue("jId", ""); //초기화
        innerValue("JLecKey", ""); //초기화
        var orderLecStatus  = getCheckboxValue("orderStatus");
        var payStatus       = getSelectboxValue('PayStatus');
        var searchType      = getSelectboxValue("orderSearch");//검색타입
        var startSearchDate = getInputTextValue('searchStartDate');
        var endSearchDate   = getInputTextValue('searchEndDate');
        var searchText      = getInputTextValue('searchText');

        var loading = new Loading({
            direction: 'hor',
            discription: '검색중',
            animationIn: false,
            animationOut: false,
            defaultApply: 	true
        });

        orderManageService.getVideoLectureWatchListCount(startSearchDate, endSearchDate, payStatus, orderLecStatus, searchType, searchText, function (cnt) {
                paging.count(sPage, cnt, '10', '10', comment.blank_list);
                orderManageService.getVideoLectureWatchList(sPage, 10, startSearchDate, endSearchDate, payStatus,
                    orderLecStatus, searchType, searchText, function (selList) {
                        if (selList.length == 0) return;
                        dwr.util.addRows("dataList", selList, [
                            function(data) {return data.JId == null ? "-" : data.JId;},
                            function(data) {return "<a href='javascript:void(0);' color='blue' onclick='goMemberDetail(" + data.userKey + ");'>" + data.userId + "</a>";},
                            function(data) {return data.userName == null ? "-" : data.userName;},
                            function(data) {return data.kindName == null ? "-" : '<a href="javascript:void(0);" data-toggle="modal" data-target="#optionModal" onclick="goOptionModify('+"'"+data.JId+"'"+','+data.kind+')" style="color: blue">'+data.kindName+'</a>';},
                            function(data) {return data.goodsName == null ? "-" : "<a href='javascript:void(0);' onclick='goOrderDetail("+ data.JLecKey +")' style='color: blue'>"+data.goodsName+"</a>";},
                            function(data) {return "<a href='javascript:void(0);' data-toggle=\"modal\" data-target=\"#stateModal\" onclick='goStateModify("+ data.JLecKey +","+ data.status +")' style='color: blue'>"+data.statusName+"</a>";},
                            function(data) {return data.status == 0 ? "-": split_minute_getDay(data.startDt)+"<br>"+split_minute_getDay(data.endDt);},
                            function(data) {return data.limitDay == null ? "-" : data.limitDay;},
                            function(data) {return data.pauseTotalDay+"<br>"+data.pauseDay;},
                            function(data) {return split_minute_getDay(data.pauseStartDt)+"<br>"+split_minute_getDay(data.pauseEndDt);},
                            function(data) {return data.payStatus == 2 ? "결제완료" : '결제취소';}
                        ], {escapeHtml:false});
                    });
            loadingOut(loading);
            });
    }

    function changePopup(id) {
        innerValue("pauseStartDt", "");
        innerValue("pauseStartDtLimit", "");
        innerValue("pauseDay", "");
        innerValue("pauseCnt", "");
        innerValue("pauseTotalDay", "");

        var state = getSelectboxValue(id);

        if(state ==2) $(".hidePopup").show();
        else $(".hidePopup").hide();
    }
    
    //진행상태 변경
    function goStateModify(val, state) {
        orderManageService.getOrderLecInfo(val, function (data) {
            if(state == 2){
                $(".hidePopup").show();
                innerValue("status", data.status);
                innerValue("JLecKey", data.JLecKey);
                getlectureWatchOrderStatusSelectbox('ModalStatus', data.status); //일시정지 팝업 진행상태
                innerValue("startDt", data.startDt);
                innerValue("startDtLimit", data.startDtLimit);
                innerValue("limitDay", data.limitDay);
                innerValue("pauseStartDt", data.pauseStartDt);
                innerValue("pauseStartDtLimit", data.pauseStartDtLimit);
                innerValue("pauseDay", data.pauseDay);
                innerValue("pauseCnt", data.pauseCnt);
                innerValue("pauseTotalDay", data.pauseTotalDay);
            }else{
                innerValue("status", data.status);
                innerValue("JLecKey", data.JLecKey);
                getlectureWatchOrderStatusSelectbox('ModalStatus', data.status); //일시정지 팝업 진행상태
                innerValue("startDt", data.startDt);
                innerValue("startDtLimit", data.startDtLimit);
                innerValue("limitDay", data.limitDay);
            }
        });
    }

    //수강타입 (옵션) 가져오기
    function goOptionModify(jId, kind) {
        getVideoOptionTypeList("optionSel", kind); //팝업창 옵션
        innerValue("jId", jId);
    }

    function goOrderDetail(val) {
        var payStatus       = getSelectboxValue('PayStatus');
        var orderStatus  = getCheckboxValue("orderStatus");
        var ordersearch      = getSelectboxValue("orderSearch");//검색타입
        var startSearchDate = getInputTextValue('searchStartDate');
        var endSearchDate   = getInputTextValue('searchEndDate');
        var searchText      = getInputTextValue('searchText');

        innerValue("param_key", val);
        innerValue("param_key2", payStatus);
        innerValue("param_key3", orderStatus);
        innerValue("param_key4", ordersearch);
        innerValue("param_key5", startSearchDate);
        innerValue("param_key6", endSearchDate);
        innerValue("param_key7", searchText);

        goPage('orderManage', 'lectureTimeManage');
    }

    //진행상태 수정
    function stateSave() {
        var getstate = getInputTextValue("status"); //기존 진행상태 값

        var state=getSelectboxValue("changeOrderStatus");

        var jLecKey = getInputTextValue("JLecKey");

        var startDate = getInputTextValue("startDt");

        var limitDay = getInputTextValue("limitDay");

        var pauseStartDate = "";
        if(state == 2) pauseStartDate = getInputTextValue("pauseStartDt");

        var pauseDay = "";
        if(state == 2) pauseDay = getInputTextValue("pauseDay");

        var pauseCnt = "";
        if(state == 2) pauseCnt = getInputTextValue("pauseCnt");

        var totalPauseCnt = "";
        if(state == 2) totalPauseCnt = getInputTextValue("pauseTotalDay");

        var status = state;/*
        var orderLecStatus = get_array_values_by_name("select", "orderStatus"); //진행상태
        if(state == 2) status = orderLecStatus[1];
        else status = orderLecStatus[2];*/

        if(startDate == ""){
            alert("강의시작일을 입력해 주세요.");
            return false;
        }
        if(limitDay == ""){
            alert("수강일을 입력해 주세요.");
            return false;
        }

        if (getstate == 2) { //기존 진행상태가 일시정지일 경우
            if(status == 2){ // 팝업에서 선택된 진행상태가 일시정지일 경우
                if(pauseStartDate == ""){
                    alert("일시중지 시작일 입력해 주세요.");
                    return false;
                }
                if(pauseDay == ""){
                    alert("일시중지 일수를 입력해 주세요.");
                    return false;
                }
            }
        }

        if(confirm("진행상태를 수정하시겠습니까?")) {
            if (getstate == 2) {
                if(status == 2){ //기존에 진행상태가 일시정지인 popup에서 다른 진행상태로 변경후 저장시 예외처리
                    orderManageService.updateOrderLecFromPause(jLecKey, status, startDate, limitDay, pauseStartDate, pauseDay, pauseCnt, totalPauseCnt, function () {
                        alert("변경되었습니다.");
                        isReloadPage();
                    });
                }else{
                    orderManageService.updateOrderLec(jLecKey, status, startDate, limitDay, function () {
                        alert("변경되었습니다.");
                        isReloadPage();
                    });
                }
            } else {
                orderManageService.updateOrderLec(jLecKey, status, startDate, limitDay, function () {
                    alert("변경되었습니다.");
                    isReloadPage();
                });
            }
        }
    }

    function dateAddDel(val) {
        var dt = new Date($('#pauseStartDt').val()); // 날짜값 입력
        var dayOfMonth = dt.getDate();
        dt.setDate(dayOfMonth + Number(val));
        var year   = dt.getFullYear();
        var month  = dt.getMonth() + 1;
        var day    = dt.getDate();
        month = month >= 10 ? month : '0' + month;
        day = day >= 10 ? day : '0' + day;
        var endDay = year+"-"+month+"-"+day;
        $("#pauseStartDtLimit").val(endDay);
    }

    //수강타입 수정
    function optionSave() {
        var jId = getInputTextValue("jId");
        if(jId != null){
            if(confirm("수강타입을 수정하시겠습니까?")){
                var goodsKind = getSelectboxValue("videoOptionSel");
                orderManageService.updateGoodsKindType(jId, goodsKind, function () {
                    /*var searchStartDate = getInputTextValue("searchStartDate");
                    var searchEndDate = getInputTextValue("searchEndDate");
                    var payType = getSelectboxValue("PayStatus");
                    var state = getSelectboxValue("orderStatus");
                    var searchType = getSelectboxValue("searchType");
                    var searchText = getInputTextValue("searchText");

                    innerValue('param_key2', searchStartDate);
                    innerValue('param_key3', searchEndDate);
                    innerValue('param_key3', payType);
                    innerValue('param_key3', state);
                    innerValue('param_key3', searchType);
                    innerValue('param_key3', searchText);*/
                    alert("변경되었습니다.");
                    isReloadPage();
                });
            }
        }
    }

    function dateAddDel2(val) {
        var dt = new Date($('#startDt').val()); // 날짜값 입력
        var dayOfMonth = dt.getDate();
        dt.setDate(dayOfMonth + Number(val));
        var year   = dt.getFullYear();
        var month  = dt.getMonth() + 1;
        var day    = dt.getDate();
        month = month >= 10 ? month : '0' + month;
        day = day >= 10 ? day : '0' + day;
        var endDay = year+"-"+month+"-"+day;
        $("#startDtLimit").val(endDay);

    }
</script>
<div class="page-breadcrumb">
    <input type="hidden" id="sPage">
    <!--<input type="hidden" id="JKey" name="JKey" value="">-->
    <input type="hidden" id="JLecKey" name="JLecKey" value="">
    <input type="hidden" id="status" value="">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">수강내역 목록</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">주문관리</li>
                        <li class="breadcrumb-item active" aria-current="page">수강내역 목록</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</div>
<!-- 기본 소스-->
<div class="container-fluid">
    <div class="form-group">
        <div class="card">
            <div class="card-body">
                <div class="row">
                    <div class="col">
                        <div class="form-group row">
                            <label  class="col-sm-1 control-label col-form-label" style="margin-bottom: 0">기간별조회</label>
                            <div class="col-sm-4">
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
                            <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">결제상태</label>
                            <div class="col-sm-8 pl-0 pr-0">
                                <span id="PayStatus"></span>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="form-group row" style="">
                            <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">진행상태</label>
                            <div class="col-sm-8 pl-0 pr-0 pt-06">
                                <span id="orderStatus"></span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <div class="form-group row">
                            <label class="col-sm-1 control-label col-form-label" style="margin-bottom: 0">검색어</label><!--0-->
                            <div class="col-sm-2 pl-0 pr-0 mr-3"><!--0-->
                                <span id="orderSearch"></span>
                            </div>
                            <div class="col-sm-2 pl-0 pr-0 mr-3"><!--0-->
                                <input type="text" class="form-control" id="searchText" onkeypress="if(event.keyCode==13) {fn_search('new'); return false;}">
                            </div>
                            <div class="col-sm-2 pl-0 pr-0 mr-3"><!--0-->
                                <button type="button" class="btn btn-outline-info mx-auto" onclick="fn_search('new')">검색</button>
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
                    <table class="table table-hover">
                        <thead>
                        <tr>
                            <th scope="col" width="10%">주문번호</th>
                            <th scope="col" width="7%">ID</th>
                            <th scope="col" width="7%">주문자</th>
                            <th scope="col" width="7%">수강타입</th>
                            <th scope="col" width="20%">강좌명</th>
                            <th scope="col" width="7%">진행상태</th>
                            <th scope="col" width="6%">시작일자<br>종료일자</th>
                            <th scope="col" width="5%">수강일수</th>
                            <th scope="col" width="6%">총 중지일수<br>중지일수</th>
                            <th scope="col" width="8%">중지시작일<br>중지종료일</th>
                            <th scope="col" width="8%">결제상태</th>
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
</div>

<!-- 일시정지 상태 수정 팝업창 --->
<div class="modal fade" id="stateModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document" style="max-width: 550px;">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">수강정보 상세보기</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <!-- modal body -->
            <div class="modal-body">
                <div class="form-group row">
                    <label class="col-sm-3 text-right control-label col-form-label">상태</label>
                    <div class="col-sm-9">
                        <span id="ModalStatus"></span>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-3 text-right control-label col-form-label">강의시작일</label>
                    <div class="col-sm-6">
                        <div class="input-group">
                            <input type="text" class="form-control mydatepicker" placeholder="yyyy-mm-dd" id="startDt">
                            <div class="input-group-append">
                                <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-3 text-right control-label col-form-label">강의종료일</label>
                    <div class="col-sm-6">
                        <div class="input-group">
                            <input type="text" class="form-control mydatepicker" placeholder="yyyy-mm-dd" id="startDtLimit">
                            <div class="input-group-append">
                                <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-3 text-right control-label col-form-label">수강일</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" id="limitDay" onkeyup="dateAddDel2(this.value);">
                    </div>
                </div>
                <div class="form-group row hidePopup">
                    <label class="col-sm-3 text-right control-label col-form-label">일시중지 시작일</label>
                    <div class="col-sm-6">
                        <div class="input-group">
                            <input type="text" class="form-control mydatepicker" placeholder="yyyy-mm-dd" id="pauseStartDt">
                            <div class="input-group-append">
                                <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group row hidePopup">
                    <label class="col-sm-3 text-right control-label col-form-label">일시중지 종료일</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" id="pauseStartDtLimit" readonly>
                    </div>
                </div>
                <div class="form-group row hidePopup">
                    <label class="col-sm-3 text-right control-label col-form-label">일시중지 일수</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" id="pauseDay" onkeyup="dateAddDel(this.value);">
                    </div>
                </div>
                <div class="form-group row hidePopup">
                    <label class="col-sm-3 text-right control-label col-form-label">일시중지 횟수</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" id="pauseCnt">
                    </div>
                </div> <div class="form-group row hidePopup">
                <label class="col-sm-3 text-right control-label col-form-label">총 일시중지 일수</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="pauseTotalDay">
                </div>
            </div>
                <button type="button" class="btn btn-info float-right" onclick="stateSave();">저장</button>
            </div>
            <!-- //modal body -->
        </div>
    </div>
</div>

<!--optionSel -->
<div class="modal fade" id="optionModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document" style="max-width: 500px;">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">상품 옵션 변경</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <input type="hidden" id="jId" value="">
            <!-- modal body -->
            <div class="modal-body">
                <div class="form-group row">
                    <label class="col-sm-3 text-center control-label col-form-label">옵션 선택</label>
                    <div class="col-sm-6">
                        <span id="optionSel"></span>
                    </div>
                    <button type="button" class="btn btn-info float-right" onclick="optionSave();">저장</button>
                </div>
            </div>
            <!-- //modal body -->
        </div>
    </div>
</div>



<!--main wapper-->
<%@include file="/common/jsp/footer.jsp" %>
<script>
    $("#searchStartDate , #searchEndDate, .mydatepicker").datepicker({
        language: "kr",
        format: "yyyy-mm-dd",
        numberOfMonths: 2
    });
</script>