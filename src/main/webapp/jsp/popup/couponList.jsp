<%@ page import="com.zianedu.lms.utils.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<%
    String couponKey = request.getParameter("param_key");
    String type = request.getParameter("type");
    String searchStartDate = Util.isNullValue(request.getParameter("param_key2"), "");
    String searchEndDate = Util.isNullValue(request.getParameter("param_key3"), "");
    String couponSearch = Util.isNullValue(request.getParameter("param_key4"), "");
    String searchText = Util.isNullValue(request.getParameter("param_key5"), "");
    String searchText2=new String( searchText.getBytes( "8859_1"), "UTF-8");
    String sPage = Util.isNullValue(request.getParameter("param_key6"), "");
%>
<style>
    ol,ul{list-style:none}

    button{margin:0;padding:0;font-family:inherit;border:0 none;background:transparent;cursor:pointer}
    button::-moz-focus-inner{border:0;padding:0}
    .searchDate{overflow:hidden;margin-bottom:-3px;*zoom:1;margin-left: -6%;}
    .searchDate:after{display:block;clear:both;content:''}
    .searchDate li{position:relative;float:left;margin:0 7px 0 0}
    .searchDate li .chkbox2{display:block;text-align:center}
    .searchDate li .chkbox2 input{position:absolute;z-index:-1}
    .searchDate li .chkbox2 label{display:block;width:77px;height:26px;font-size:14px;font-weight:bold;color:#fff;text-align:center;line-height:25px;text-decoration:none;cursor:pointer;background:#02486f}
    .searchDate li .chkbox2.on label{background:#ec6a6a}

</style>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/popupCouponManageService.js'></script>
<script>
    function init() {
        var sPage = '<%=sPage%>';
        var searchStartDate = '<%=searchStartDate%>';
        var searchEndDate = '<%=searchEndDate%>';
        var couponSearch = '<%=couponSearch%>';
        var searchText = '<%=searchText2%>';

        //getProductSearchSelectbox("l_searchSel");
        menuActive('menu-4', 3);
        innerValue("sPage", sPage);
        couponTypeSelecbox('couponSearch',couponSearch);
        innerValue("searchText", searchText);

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

        if(sPage=='') {
            fn_search("new");
        }else{
            fn_search(sPage);
        }
    }

    function fn_search(val) {
        var paging = new Paging();
        var sPage = getInputTextValue("sPage");
        var searchType=getSelectboxValue("couponSearch");
        var searchText=getInputTextValue('searchText');
        var startSearchDate = getInputTextValue('searchStartDate');
        var endSearchDate = getInputTextValue('searchEndDate');


        if (val == "new") sPage = "1";

        dwr.util.removeAllRows("dataList"); //테이블 리스트 초기화
        gfn_emptyView("H", "");//페이징 예외사항처리

        popupCouponManageService.getCouponListCount(searchType,searchText,startSearchDate,endSearchDate,function (cnt) {
                paging.count(sPage, cnt, '10', '10', comment.blank_list);
                var listNum = ((cnt-1)+1)-((sPage-1)*10); //리스트 넘버링
            popupCouponManageService.getCouponList(sPage, 10,searchType,searchText,startSearchDate,endSearchDate, function (selList) {
                        if (selList.length == 0) return;
                        dwr.util.addRows("dataList", selList, [
                            function(data) {return listNum--;},
                            function(data) {return "<a href='javascript:void(0);' color='blue' style='float:left' onclick='goModifyCoupon(" + data.couponMasterKey + ");'>" + data.name + "</a>";},
                            function(data) {return data.dcTypeName;},
                            function(data) {return data.dcType==1?data.dcValue+"%":data.dcValue+"원";},
                            function(data) {return data.issueTypeName+"</br><a style='color: green'>"+data.periodTypeName + "</a>";},
                            function(data) {return data.issueDate;},
                            function(data) {return data.periodType==0?"발급일로부터</br>"+data.limitDay+"일":data.dateUse;},
                        ], {escapeHtml:false});
                    });
            });
    }
    function goModifyCoupon(val) {
        innerValue('param_key', val);
        innerValue('type', 'couponList');
        innerValue('param_key2', getInputTextValue('searchStartDate'));
        innerValue('param_key3', getInputTextValue('searchEndDate'));
        innerValue('param_key4', getSelectboxValue('couponSearch'));
        innerValue('param_key5', getInputTextValue('searchText'));
        innerValue('param_key6', getInputTextValue("sPage"));

        goPage('popupCouponManage', 'modifyCoupon');
    }

</script>
<div class="page-breadcrumb">
    <input type="hidden" id="sPage">
    <input type="hidden" id="popupKey" name="popupKey" value="">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">쿠폰 목록</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">팝업/쿠폰 관리</li>
                        <li class="breadcrumb-item active" aria-current="page">쿠폰 목록</li>
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
                    <div class="row">
                        <div class="col">
                            <div class="form-group row">
                                <label  class="col-sm-1 control-label col-form-label" style="margin-bottom: 0">기간별조회</label>
                                <div class="col-sm-4 pl-0 pr-0">
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
                                <div class="col-sm-3 input-group pl-0 pr-0">
                                    <input type="text" class="form-control datepicker" placeholder="yyyy-mm-dd" name="searchStartDate" id="searchStartDate" autocomplete="off">
                                    <div class="input-group-append">
                                        <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                    </div>
                                    <span>&nbsp;&nbsp;~&nbsp;&nbsp;</span>
                                    <input type="text" class="form-control datepicker" placeholder="yyyy-mm-dd" name="searchEndDate" id="searchEndDate" autocomplete="off">
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
                                <label class="col-sm-1 control-label col-form-label" style="margin-bottom: 0">검색어</label><!--0-->
                                <div class="col-sm-2 pl-0 pr-0 mr-3"><!--0-->
                                    <span id="couponSearch"></span>
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
                <table class="table table-hover text-center">
                    <thead>
                    <tr>
                        <th scope="col" width="5%">CODE</th>
                        <th scope="col" width="25%">쿠폰명</th>
                        <th scope="col" width="8%">할인방식</th>
                        <th scope="col" width="8%">할인액(원/율)</th>
                        <th scope="col" width="8%">발급방식</th>
                        <th scope="col" width="8%">발행일</th>
                        <th scope="col" width="8%">사용기간</th>
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
<script>
    $("#searchStartDate , #searchEndDate").datepicker({
        language: "kr",
        format: "yyyy-mm-dd",
        numberOfMonths: 2
    });
</script>
<%@include file="/common/jsp/footer.jsp" %>
