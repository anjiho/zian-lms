<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>

<style>
    ol,ul{list-style:none}

    button{margin:0;padding:0;font-family:inherit;border:0 none;background:transparent;cursor:pointer}
    button::-moz-focus-inner{border:0;padding:0}
    .searchDate{overflow:hidden;margin-bottom:10px;*zoom:1}
    .searchDate:after{display:block;clear:both;content:''}
    .searchDate li{position:relative;float:left;margin:0 7px 0 0}
    .searchDate li .chkbox2{display:block;text-align:center}
    .searchDate li .chkbox2 input{position:absolute;z-index:-1}
    .searchDate li .chkbox2 label{display:block;width:72px;height:26px;font-size:14px;font-weight:bold;color:#fff;text-align:center;line-height:25px;text-decoration:none;cursor:pointer;background:#a5b0b6}
    .searchDate li .chkbox2.on label{background:#ec6a6a}
</style>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/productManageService.js'></script>
<script>
    function init() {
        getProductSearchSelectbox("l_searchSel");
        menuActive('menu-3', 1);
    }
    function fn_search(val) {
        var paging = new Paging();
        var sPage = getInputTextValue("sPage");

        if (val == "new") sPage = "1";

        dwr.util.removeAllRows("dataList"); //테이블 리스트 초기화
        gfn_emptyView("H", "");//페이징 예외사항처리

        var examYear = getSelectboxValue("examYear");
        var subjectCode = getInputTextValue("subjectCode");
        var divisionCtgKey = getSelectboxValue("divisionCtgKey");
        var subjectCtgKey = getSelectboxValue("selSubjectCtgKey");
        var patternCtgKey = getSelectboxValue("selPattern");
        var stepCtgKey = getSelectboxValue("selUnit");
        var ctgKey = $('#unitTable').find("td select").eq(2).val();
        var unitCtgKey = ctgKey;
        if(unitCtgKey == null){
            unitCtgKey = 0;
        }
        var searchVO = {
            startPage: sPage,
            listLimitNumber: 10,
            divisionCtgKey: divisionCtgKey,
            subjectCtgKey: subjectCtgKey,
            stepCtgKey: stepCtgKey,
            patternCtgKey: patternCtgKey,
            unitCtgKey: unitCtgKey,
            examYear: examYear,
            subjectCode: subjectCode
        };
        productManageService.getProblemBankListCount(searchVO, function (cnt) {
            paging.count(sPage, cnt, '10', '10', comment.blank_list);
            var listNum = ((cnt-1)+1)-((sPage-1)*10); //리스트 넘버링
            productManageService.getProblemBankList(searchVO, function (selList) {
                if (selList.length == 0) return;
                dwr.util.addRows("dataList", selList, [
                    function(data) {return listNum--;},
                    function(data) {return data.examQuestionBankKey == 0 ? "-" : "<a href='javascript:void(0);' color='blue' onclick='goModifyProblemBank(" + data.examQuestionBankKey + ");'>" +  data.examQuestionBankKey + "</a>";},
                    function(data) {return data.className == null ? "-" : data.className;},
                    function(data) {return data.examYear == null ? "-" : data.examYear;},
                    function(data) {return data.subjectName == null ? "-" : data.subjectName;},
                    function(data) {return data.levelName == null ? "-" : data.levelName;},
                    function(data) {return data.typeName == null ? "-" : data.typeName;},
                    function(data) {return data.patternName == null ? "-" : data.patternName;},
                    function(data) {return data.unitName == null ? "-" : data.unitName;},
                ], {escapeHtml:false});
            });
        });
    }
</script>
<div class="page-breadcrumb">
    <input type="hidden" id="sPage">
    <input type="hidden" id="examQuestionBankKey"  name="examQuestionBankKey">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">전체주문목록</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">주문관리</li>
                        <li class="breadcrumb-item active" aria-current="page">전체주문목록</li>
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
                            <div class="col-sm-8 pl-0 pr-0">
                                <tr>
                                    <td>
                                        <ul class="searchDate">
                                            <li>
                                                <span class="chkbox2">
                                                    <input type="radio" name="dateType" id="dateType1" onclick="setSearchDate('0d')"/>
                                                    <label for="dateType1">당일</label>
                                                </span>
                                            </li>
                                            <li>
                                                <span class="chkbox2">
                                                    <input type="radio" name="dateType" id="dateType2" onclick="setSearchDate('3d')"/>
                                                    <label for="dateType2">3일</label>
                                                </span>
                                            </li>
                                            <li>
                                                <span class="chkbox2">
                                                    <input type="radio" name="dateType" id="dateType3" onclick="setSearchDate('1w')"/>
                                                    <label for="dateType3">1주</label>
                                                </span>
                                            </li>
                                            <li>
                                                <span class="chkbox2">
                                                    <input type="radio" name="dateType" id="dateType4" onclick="setSearchDate('2w')"/>
                                                    <label for="dateType4">2주</label>
                                                </span>
                                            </li>
                                            <li>
                                                <span class="chkbox2">
                                                    <input type="radio" name="dateType" id="dateType5" onclick="setSearchDate('1m')"/>
                                                    <label for="dateType5">1개월</label>
                                                </span>
                                            </li>
                                            <li>
                                                <span class="chkbox2">
                                                    <input type="radio" name="dateType" id="dateType6" onclick="setSearchDate('3m')"/>
                                                    <label for="dateType6">3개월</label>
                                                </span>
                                            </li>
                                            <li>
                                                <span class="chkbox2">
                                                    <input type="radio" name="dateType" id="dateType7" onclick="setSearchDate('6m')"/>
                                                    <label for="dateType7">6개월</label>
                                                </span>
                                            </li>
                                        </ul>
                                        <div class="clearfix">
                                            <div class="col-sm-3 input-group pl-0 pr-0">
                                                <input type="text" class="form-control datepicker" placeholder="yyyy-mm-dd" name="searchStartDate" id="searchStartDate">
                                                <div class="input-group-append">
                                                    <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                                </div>
                                            </div>
                                            <!-- // -->
                                            <span class="demi">~</span>
                                            <div class="col-sm-3 input-group pl-0 pr-0">
                                                <input type="text" class="form-control datepicker" placeholder="yyyy-mm-dd" name="searchEndDate" id="searchEndDate">
                                                <div class="input-group-append">
                                                    <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row" style="padding-top:20px">
                    <div class="col">
                        <div class="form-group row">
                            <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">처리상태</label>
                            <div class="col-sm-8 pl-0 pr-0">
                                <span id=""></span>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label  class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">결제방법</label>
                            <div class="col-sm-8 pl-0 pr-0">
                                <span id="l_examType"></span>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="form-group row" style="">
                            <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">구매장소</label>
                            <input type="text" class="col-sm-8 form-control" id="subjectCode">
                        </div>
                        <div class="form-group row">
                            <label  class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">디바이스</label>
                            <div class="col-sm-8 pl-0 pr-0">
                                <span id="l_subjectGroup"></span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <div class="form-group row">
                            <label  class="col-sm-1 control-label col-form-label" style="margin-bottom: 0">검색어</label>
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
                        <th scope="col" width="15%">주문번호</th>
                        <th scope="col" width="8%">주문자</th>
                        <th scope="col" width="20%">주문내역</th>
                        <th scope="col" width="8%">결제금액</th>
                        <th scope="col" width="9%">결제방법</th>
                        <th scope="col" width="10%">진행상태</th>
                        <th scope="col" width="5%">모바일</th>
                        <th scope="col" width="10%">배송상태</th>
                        <th scope="col" width="5%"></th>
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
    function getFormatDate(date){
        var year = date.getFullYear();
        var month = (1 + date.getMonth());
        month = month >= 10 ? month : '0' + month;
        var day = date.getDate();
        day = day >= 10 ? day : '0' + day;
        return  year +'-'+ month +'-'+ day;
    }

    $("#searchStartDate, #searchEndDate").datepicker({
        language: "kr",
        format: "yyyy-mm-dd",
    });

    function setSearchDate(start){

        var num = start.substring(0,1);
        var str = start.substring(1,2);

        var today = new Date();

        var endDate = getFormatDate(today);

        $('#searchEndDate').val(endDate);

        if(str == 'd'){
            today.setDate(today.getDate() - num);
        }else if (str == 'w'){
            today.setDate(today.getDate() - (num*7));
        }else if (str == 'm'){
            today.setMonth(today.getMonth() - num);
            today.setDate(today.getDate() + 1);
        }

        var startDate = getFormatDate(today);

        $('#searchStartDate').val(startDate);
    }


</script>
<!--main wapper-->
<%@include file="/common/jsp/footer.jsp" %>
