<%@ page import="com.zianedu.lms.utils.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<%
    String searchStartDate = Util.isNullValue(request.getParameter("param_key2"), "");
    String searchEndDate = Util.isNullValue(request.getParameter("param_key3"), "");
    String dateSearchType = Util.isNullValue(request.getParameter("param_key4"), "1000");
    String orderStatus = Util.isNullValue(request.getParameter("param_key5"), "");
    String isOffline = Util.isNullValue(request.getParameter("param_key6"), "");
    String orderPayTypeSel = Util.isNullValue(request.getParameter("param_key7"), "");
    String deviceSel = Util.isNullValue(request.getParameter("param_key8"), "");
    String orderSearch = Util.isNullValue(request.getParameter("param_key9"), "");
    String searchText = Util.isNullValue(request.getParameter("param_key10"), "");
    String searchText2=new String( searchText.getBytes( "8859_1"), "UTF-8");
    String isDetail = Util.isNullValue(request.getParameter("param_key11"), "");
%>
<style>
    ol, ul {
        list-style: none
    }

    button {
        margin: 0;
        padding: 0;
        font-family: inherit;
        border: 0 none;
        background: transparent;
        cursor: pointer
    }

    button::-moz-focus-inner {
        border: 0;
        padding: 0
    }

    .searchDate {
        overflow: hidden;
        margin-bottom: -3px;
        *zoom: 1;
        margin-left: -6%;
    }

    .searchDate:after {
        display: block;
        clear: both;
        content: ''
    }

    .searchDate li {
        position: relative;
        float: left;
        margin: 0 7px 0 0
    }

    .searchDate li .chkbox2 {
        display: block;
        text-align: center
    }

    .searchDate li .chkbox2 input {
        position: absolute;
        z-index: -1
    }

    .searchDate li .chkbox2 label {
        display: block;
        width: 77px;
        height: 26px;
        font-size: 14px;
        font-weight: bold;
        color: #fff;
        text-align: center;
        line-height: 25px;
        text-decoration: none;
        cursor: pointer;
        background: #02486f
    }

    .searchDate li .chkbox2.on label {
        background: #ec6a6a
    }
</style>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/orderManageService.js'></script>
<script>
    function init() {
        var isDetail = '<%=isDetail%>';

        var searchStartDate = '<%=searchStartDate%>';
        var searchEndDate = '<%=searchEndDate%>';
        var dateSearchType = '<%=dateSearchType%>';
        var orderStatus = '<%=orderStatus%>';
        var isOffline = '<%=isOffline%>';
        var orderPayTypeSel = '<%=orderPayTypeSel%>';
        var deviceSel = '<%=deviceSel%>';
        var orderSearch = '<%=orderSearch%>';
        var searchText = '<%=searchText2%>';

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

        getProductSearchSelectbox("l_searchSel");
        menuActive('menu-3', 2);
        orderStatusTypeSelecbox('orderStatus', orderStatus);//처리상태 - 입금예정,결제대기,결제완료
        orderPayStatusTypeSelecbox('orderPayStatus', '');//처리상태 - 결제취소,주문취소,결제실패
        isOfflineSelectbox('isOffline', isOffline);
        deviceSelectbox('deviceSel', deviceSel);
        orderPayTypeSelectbox('orderPayTypeSel', orderPayTypeSel);
        orderSearchSelectbox('orderSearch', orderSearch);
        orderStatusTypeChangeSelecbox('orderStatusChangeSel', '');
        listNumberSelectbox('listNumberSel', '');
        innerValue("searchText", searchText);
        getOrderDateSearchSelectbox('dateSearchType',dateSearchType);//검색 주문일자기준선택

        fn_search("new");
    }

    function fn_search(val) {
        var paging = new Paging();
        var sPage = getInputTextValue("sPage");
        if (searchType == null) searchType = "";
        if (val == "new") sPage = "1";

        dwr.util.removeAllRows("dataList"); //테이블 리스트 초기화
        gfn_emptyView("H", "");//페이징 예외사항처리

        var payStatus = getSelectboxValue("orderStatus");//처리상태
        var isOffline = getSelectboxValue("isOffline");//구매장소
        var isMobile = getSelectboxValue("deviceSel");//디바이스
        var payType = getSelectboxValue("orderPayTypeSel");//결제방법
        var searchType = getSelectboxValue("orderSearch");//검색타입
        var orderStatusChangeSel = getSelectboxValue("orderStatusChangeSel");//결제상태변경
        var listNumberSel = getSelectboxValue("listNumberSel");//리스트개수
        var startSearchDate = getInputTextValue('searchStartDate');
        var endSearchDate = getInputTextValue('searchEndDate');
        var searchText = getInputTextValue('searchText');
        var dateSearchType = getSelectboxValue('dateSearchType');

        var goodsType = 'VIDEO';
        var isVideoReply = 0;

        var loading = new Loading({
            direction: 'hor',
            discription: '검색중',
            animationIn: false,
            animationOut: false,
            defaultApply: true
        });

        orderManageService.getOrderListCount(startSearchDate, endSearchDate, goodsType, payStatus, isOffline,
            payType, isMobile, searchType, searchText, isVideoReply, dateSearchType, function (cnt) {
                paging.count(sPage, cnt, '10', '10', comment.blank_list);
                var listNum = ((cnt - 1) + 1) - ((sPage - 1) * 10); //리스트 넘버링
                orderManageService.getOrderList(sPage, listNumberSel, startSearchDate, endSearchDate, goodsType,
                    payStatus, isOffline, payType, isMobile, searchType, searchText, isVideoReply, dateSearchType, function (selList) {

                        if (selList.length == 0) return;
                        dwr.util.addRows("dataList", selList, [
                            function (data) {
                                return "<a href='javascript:void(0);' color='blue' style='' onclick='goOrderDetail(" + data.JKey + ");'>" + data.JId + "</a>";
                            },
                            function (data) {
                                return "<a href='javascript:void(0);' color='blue' style='' onclick='goMemberDetail(" + data.userKey + ");'>" + data.userId + "</a>";
                            },
                            function (data) {
                                return data.name == null ? "-" : data.name;
                            },
                            //function(data) {return data.orderGoodsName == null ? "-" : data.orderGoodsName;},
                            function (data) {
                                return data.orderGoodsCount == 0 ? data.orderGoodsName : data.orderGoodsName + "<a style='color: red'>외" + data.orderGoodsCount + "</a>";
                            },
                            function (data) {
                                return data.pricePay == null ? "-" : format(data.pricePay);
                            },
                            function (data) {
                                return data.payTypeName == null ? "-" : data.payTypeName + "<br/><a style='color: green'>" + gfn_isnull(data.depositUser)+"</a>";
                            },
                            function (data) {
                                return data.payStatusName == null ? "-" : data.payStatusName;
                            },
                            //function(data) {return data.isMobile == null ? "-" : data.isMobile;},
                            function (data) {
                                return data.isMobile == 0 ? "<i class='mdi mdi-close' style='color: red'></i>" : "<i class='mdi mdi-check' style='color:green;'></i>";
                            },
                            function (data) {
                                return "<label class='customcheckbox m-b-20'><input type='checkbox' name='rowChk' value='" + data.JKey + "'><span class='checkmark'></span>";
                            }
                        ], {escapeHtml: false});
                    });
                loadingOut(loading);
                bookOrderList
            });
    }

    function changeList() {
        fn_search('new');
    }

    function goOrderDetail(val) {
        innerValue('param_key', val);
        innerValue('type', 'playOrderList');
        innerValue('param_key2', getInputTextValue('searchStartDate'));
        innerValue('param_key3', getInputTextValue('searchEndDate'));
        innerValue('param_key4', getSelectboxValue('dateSearchType'));
        innerValue('param_key5', getSelectboxValue('orderStatus'));
        innerValue('param_key6', getSelectboxValue('isOffline'));
        innerValue('param_key7', getSelectboxValue('orderPayTypeSel'));
        innerValue('param_key8', getSelectboxValue('deviceSel'));
        innerValue('param_key9', getSelectboxValue('orderSearch'));
        innerValue('param_key10', getInputTextValue('searchText'));

        goPage('orderManage', 'orderDetailManage');
    }

    //결제상태변경
    function changePayStatus() {
        if ($("input[name=rowChk]:checked").length == 0) {
            alert("회원을 선택해 주세요.");
            return false;
        }
        var orderStatusChangeSel = getSelectboxValue("orderStatusChangeSel");//결제상태변경
        var arr = new Array();
        $("input[name=rowChk]:checked").each(function () {
            var jKey = $(this).val();
            var data = {
                jKey: jKey,
                payStatus: orderStatusChangeSel
            };
            arr.push(data);
        });
        if (confirm('변경하시겠습니까?')) {
            orderManageService.changePayStatus(arr, function () {
                isReloadPage();
            });
        }
    }

    function excelDownload() {
        if (confirm("다운로드 받으시겠습니까?")) {
            var searchType = getSelectboxValue("searchType");
            var searchText = getInputTextValue("searchText");
            var searchStartDate = getInputTextValue("searchStartDate");
            var searchEndDate = getInputTextValue("searchEndDate");
            var orderStatus = getSelectboxValue("orderStatus");
            var isOffline = getSelectboxValue("isOffline");
            var payType = getSelectboxValue("orderPayType");
            var isMobile = getSelectboxValue("deviceSel");

            var url = "searchType=" + searchType + "&searchText=" + searchText + "&searchStartDate=" + searchStartDate + "&searchEndDate=" + searchEndDate +
                "&goodsType=VIDEO" + "&payStatus=" + orderStatus + "&isOffline=" + isOffline + "&payType=" + payType + "&isMobile=" + isMobile + "&isVideoReply=0"

            $.download('/excelDownload/orderList', url, 'post');
        }
    }
</script>
<div class="page-breadcrumb">
    <input type="hidden" id="sPage">
    <input type="hidden" id="JKey" name="JKey" value="">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">동영상주문 목록</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">주문관리</li>
                        <li class="breadcrumb-item active" aria-current="page">동영상주문 목록</li>
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
                            <label class="col-sm-1 control-label col-form-label" style="margin-bottom: 0">기간별조회</label>
                            <div class="col-sm-4 pl-0 pr-0">
                                <tr>
                                    <td>
                                        <ul class="searchDate">
                                            <li>
                                                <span class="chkbox2">
                                                    <input type="radio" name="dateType" id="dateType1"
                                                           onclick="setSearchDate('0d', 'searchStartDate', 'searchEndDate')"/>
                                                    <label for="dateType1">당일</label>
                                                </span>
                                            </li>
                                            <li>
                                                <span class="chkbox2">
                                                    <input type="radio" name="dateType" id="dateType3"
                                                           onclick="setSearchDate('1w', 'searchStartDate', 'searchEndDate')"/>
                                                    <label for="dateType3">1주</label>
                                                </span>
                                            </li>
                                            <li>
                                                <span class="chkbox2">
                                                    <input type="radio" name="dateType" id="dateType4"
                                                           onclick="setSearchDate('2w', 'searchStartDate', 'searchEndDate')"/>
                                                    <label for="dateType4">2주</label>
                                                </span>
                                            </li>
                                            <li>
                                                <span class="chkbox2">
                                                    <input type="radio" name="dateType" id="dateType5"
                                                           onclick="setSearchDate('1m', 'searchStartDate', 'searchEndDate')"/>
                                                    <label for="dateType5">1개월</label>
                                                </span>
                                            </li>
                                            <li>
                                                <span class="chkbox2">
                                                    <input type="radio" name="dateType" id="dateType6"
                                                           onclick="setSearchDate('3m', 'searchStartDate', 'searchEndDate')"/>
                                                    <label for="dateType6">3개월</label>
                                                </span>
                                            </li>
                                            <li>
                                                <span class="chkbox2">
                                                    <input type="radio" name="dateType" id="dateType7"
                                                           onclick="setSearchDate('6m', 'searchStartDate', 'searchEndDate')"/>
                                                    <label for="dateType7">6개월</label>
                                                </span>
                                            </li>
                                        </ul>
                                    </td>
                                </tr>
                            </div>
                            <div class="col-sm-3 input-group pl-0 pr-0">
                                <input type="text" class="form-control datepicker" placeholder="yyyy-mm-dd"
                                       name="searchStartDate" id="searchStartDate">
                                <div class="input-group-append">
                                    <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                </div>
                                <span>&nbsp;&nbsp;~&nbsp;&nbsp;</span>
                                <input type="text" class="form-control datepicker" placeholder="yyyy-mm-dd"
                                       name="searchEndDate" id="searchEndDate">
                                <div class="input-group-append">
                                    <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                </div>
                            </div>
                            <div class="col-sm-2 pl-5 pr-0">
                                <span id="dateSearchType"></span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <div class="form-group row">
                            <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">처리상태</label>
                            <div class="col-sm-8 pl-0 pr-0">
                                <span id="orderStatus"></span>
                                <!--<span id="orderPayStatus"></span>-->
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">결제방법</label>
                            <div class="col-sm-8 pl-0 pr-0">
                                <span id="orderPayTypeSel"></span>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="form-group row" style="">
                            <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">구매장소</label>
                            <div class="col-sm-8 pl-0 pr-0">
                                <span id="isOffline"></span>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">디바이스</label>
                            <div class="col-sm-8 pl-0 pr-0">
                                <span id="deviceSel"></span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <div class="form-group row">
                            <label class="col-sm-1 control-label col-form-label" style="margin-bottom: 0">검색어</label>
                            <!--0-->
                            <div class="col-sm-2 pl-0 pr-0 mr-3"><!--0-->
                                <span id="orderSearch"></span>
                            </div>
                            <div class="col-sm-2 pl-0 pr-0 mr-3"><!--0-->
                                <input type="text" class="form-control" id="searchText"
                                       onkeypress="if(event.keyCode==13) {fn_search('new'); return false;}">
                            </div>
                            <div class="col-sm-2 pl-0 pr-0 mr-3"><!--0-->
                                <button type="button" class="btn btn-outline-info mx-auto" onclick="fn_search('new')">
                                    검색
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <div class="row">
            <div class="col">
                <div class="form-group row">
                    <label class="col-sm-2 control-label col-form-label" style="margin-bottom:0;padding-left:30px">결제상태변경</label>
                    <div class="col-sm-8 pl-0 pr-0">
                        <span id="orderStatusChangeSel"></span>
                        <button type="button" class="btn btn-outline-info mx-auto" onclick="changePayStatus()">변경
                        </button>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="form-group row">
                    <label class="col-sm-2 control-label col-form-label" style="mmargin-bottom: 0;padding-left:12px">리스트개수</label>
                    <div class="col-sm-8 pl-0 pr-0">
                        <span id="listNumberSel"></span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-body">
                    <div class="mb-5">
                        <button type="button" class="btn btn-outline-info mx-auto float-right"
                                onclick="excelDownload();"><i class="mdi mdi-file-excel"></i>엑셀다운로드
                        </button>
                    </div>
                    <table class="table table-hover">
                        <thead>
                        <tr>
                            <th scope="col" width="10%">주문번호</th>
                            <th scope="col" width="8%">ID</th>
                            <th scope="col" width="8%">주문자</th>
                            <th scope="col" width="30%">주문내역</th>
                            <th scope="col" width="7%">결제금액</th>
                            <th scope="col" width="5%">결제방법</th>
                            <th scope="col" width="8%">진행상태</th>
                            <th scope="col" width="8%">모바일</th>
                            <!--<th scope="col" width="8%">배송상태</th>-->
                            <th width="3%">
                                <label class="customcheckbox m-b-20">
                                    <input type="checkbox" id="mainCheckbox" id="allCheck"
                                           onclick="allChk(this, 'rowChk');">
                                    <span class="checkmark"></span>
                                </label>
                            </th>
                        </tr>
                        </thead>
                        <tbody id="dataList"></tbody>
                        <tr>
                            <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle'
                                style="visibility:hidden"></td>
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

<script>
    $("#searchStartDate , #searchEndDate").datepicker({
        language: "kr",
        format: "yyyy-mm-dd",
        numberOfMonths: 2
    });
</script>
<!--main wapper-->
<%@include file="/common/jsp/footer.jsp" %>
