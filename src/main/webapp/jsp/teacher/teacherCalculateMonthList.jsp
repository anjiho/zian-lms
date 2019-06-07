<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/statisManageService.js'></script>
<script>
    function init() {
        getSmsSearchSelectbox("l_searchSel");
        menuActive('menu-7', 1);
        getSmsYearSelectbox("l_monthYearSel","");
    }

    function fn_search(val) {
        statisManageService.getTeacherCalculateByMonth(31, "201903", function (selList) {
            console.log(selList);
            if (selList.length == 0) return;
            var videoCalculateResult = selList.videoCalculateResult; //온라인강좌
            var packageCalculateResult = selList.packageCalculateResult; // 패키지
            var academyCalculateResult = selList.academyCalculateResult; //학원강의

            var onlineTotalCnt = 0;

            if(videoCalculateResult.length > 0){
                for(var i=0; i<videoCalculateResult.length; i++){
                    var cmpList =  videoCalculateResult[i];

                    onlineTotalCnt += cmpList.payCnt;
                    var kind = "";
                    if(cmpList.kind == '100') kind = "VOD";
                    else if(cmpList.kind == '100') kind = "MOBILE";
                    else kind = "VOD+MOBILE";
                    if (cmpList != undefined) {
                        var cellData = [
                            function() {return kind;},
                            function() {return cmpList.name},
                            function() {return cmpList.payCnt},
                            function() {return format(cmpList.payPrice)},
                            function() {return cmpList.cancelCnt},
                            function() {return format(cmpList.cancelPrice)},
                        ];
                        dwr.util.addRows("onlineTable", [0], cellData, {escapeHtml:false});
                    }
                }
                innerHTML("test", onlineTotalCnt);
            }

           /* dwr.util.addRows("dataList", selList, [
                function(data) {return data.sendDate;},
                function(data) {return InputPhoneNumCheck(data.receiveNumber);},
                function(data) {return InputPhoneNumCheck(data.sendNumber);},
                function(data) {return "<a href='javascript:void(0);' color='blue' style='float:left' onclick='MemberDetail(" + data.userKey + ");'>" + data.receiverId + "</a>";},
                function(data) {return data.sendMessage;},
                function(data) {return data.receiverName;},
            ], {escapeHtml:false});*/
        });
    }

    function MemberDetail(userKey) {
        innerValue("param_key", userKey);
        goPage('memberManage', 'memberManage');
    }
</script>
<div class="page-breadcrumb">
    <input type="hidden" id="sPage">
    <input type="hidden" id="param_key" name="param_key" value="">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">월별 정산내역</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">통계</li>
                        <li class="breadcrumb-item active" aria-current="page">월별 정산내역</li>
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
                            <span id="l_monthYearSel"></span>
                        </div>
                        <div style=" float: left; width: 10%;margin-left: 10px">
                            <span id="l_searchSel"></span>
                        </div>
                        <div style=" float: left; width: 33%;margin-left: 10px">
                            <input type="text" class="form-control" id="searchText" onkeypress="if(event.keyCode==13) {fn_search('new'); return false;}">
                        </div>
                        <div style=" float: left; width: 33%; margin-left: 10px;">
                            <button type="button" class="btn btn-outline-info mx-auto" onclick="fn_search('new')">검색</button>
                        </div>
                    </div>
                </div>
                <!--온라인강좌-->
                <div style="float: left">
                    <label  class="col-sm-3 control-label col-form-label card-title">온라인강좌</label>
                </div>
                <table class="table text-center" id="onlineTable">
                    <thead>
                    <tr>
                        <th scope="col" style="width: 10%;">구분</th>
                        <th scope="col" style="width: 25%;">강좌명</th>
                        <th scope="col" style="width: 10%;">인원</th>
                        <th scope="col" style="width: 10%;">금액</th>
                        <th scope="col" style="width: 10%;">환불인원</th>
                        <th scope="col" style="width: 15%;">환불금액</th>
                    </tr>
                    </thead>
                    <tbody id="onlineList"></tbody>
                    <tfoot>
                        <tr style="background-color: #777777" class="caculate-list">
                            <td colspan="2" style="color:white;font-weight: bold;height: 10px;">온라인강좌 소계</td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                    </tfoot>
                </table>
                <!--//온라인강좌-->
                <!--학원강의-->
                <div style="float: left">
                    <label  class="col-sm-3 control-label col-form-label card-title">학원강의</label>
                </div>
                <table class="table text-center"  id="acaTable">
                    <thead>
                    <tr>
                        <th scope="col" style="width: 10%;">구분</th>
                        <th scope="col" style="width: 25%;">강좌명</th>
                        <th scope="col" style="width: 10%;">인원</th>
                        <th scope="col" style="width: 10%;">금액</th>
                        <th scope="col" style="width: 10%;">환불인원</th>
                        <th scope="col" style="width: 15%;">환불금액</th>
                    </tr>
                    </thead>
                    <tbody id="acaList"></tbody>
                    <tfoot>
                        <tr class="caculate-list">
                            <td colspan="2">온라인강좌 소개</td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                    </tfoot>
                </table>
                <!--//학원강의-->
                <!--패키지-->
                <div style="float: left">
                    <label  class="col-sm-3 control-label col-form-label">패키지</label>
                </div>
                <table class="table text-center calculate-list" id="pacakgeTable">
                    <thead>
                    <tr>
                        <th scope="col" style="width: 10%;">구분</th>
                        <th scope="col" style="width: 25%;">강좌명</th>
                        <th scope="col" style="width: 10%;">인원</th>
                        <th scope="col" style="width: 10%;">금액</th>
                        <th scope="col" style="width: 10%;">환불인원</th>
                        <th scope="col" style="width: 15%;">환불금액</th>
                    </tr>
                    </thead>
                    <tbody id="pacakgeList"></tbody>
                    <tfoot>
                        <tr class="caculate-list">
                            <td colspan="2">온라인강좌 소개</td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                    </tfoot>
                </table>
                <!--//패키지-->

                <!--온라인강좌-->
                <table class="table text-center SumTaber">
                    <tbody>
                    <tr>
                        <td colspan="4">판매합계</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td colspan="4">환불합계</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td colspan="4">총 합계</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td colspan="4">소득세(0.3%) +  주민세(0.03%)</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td colspan="4">사우회비</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td colspan="4" style="color: yellow">실지급액</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    </tbody>
                </table>
                <!--//온라인강좌-->
            </div>
        </div>
    </div>
</div>

<style>
    .SumTaber tr{
        background-color: #4d6082;
    }
    .SumTaber tr td{
        color: white;
        font-weight: bold;
    }

    .calculate-list {
        background-color: #777777;
    }

    .calculate-list td{
        color: white;
        font-weight: bold;
    }
</style>
<%@include file="/common/jsp/footer.jsp" %>