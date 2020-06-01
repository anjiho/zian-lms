<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/orderManageService.js'></script>
<script type='text/javascript' src='/dwr/interface/memberManageService.js'></script>
<script type='text/javascript' src='/dwr/interface/productManageService.js'></script>
<script>
    function init() {
        getMemberSearchSelectbox("l_memberSearch");
        getProductSearchTypeSelectbox("l_productSearch");
        menuActive('menu-3', 10);
        fn_search('new');
        fn_search3('new');
    }

    //회원정보 가져오기
    function fn_search(val) {
        var paging = new Paging();
        var sPage = getInputTextValue("sPage");

        if (val == "new") sPage = "1";

        dwr.util.removeAllRows("dataList"); //테이블 리스트 초기화
        gfn_emptyView("H", "");//페이징 예외사항처리

        var searchType = getSelectboxValue('memberSel');
        var searchText = getInputTextValue('SearchText');
        var regStartDate = "";
        var regEndDate = "";
        var grade = 1000;
        var affiliationCtgKey = 10000;

        memberManageService.getMemeberListCount(searchType, searchText, regStartDate, regEndDate,
            grade, affiliationCtgKey, function (cnt) {
                paging.count(sPage, cnt, '5', '5', comment.blank_list);
                memberManageService.getMemeberList(sPage, 5, searchType, searchText,
                    regStartDate, regEndDate, grade, affiliationCtgKey, function (selList) {
                        if (selList.length == 0) return;
                        var SelBtn = '<input type="button" onclick="sendChildValue($(this))" value="선택" class="btn btn-info btn-sm" style="margin-top: -3px;"/>';
                        dwr.util.addRows("dataList", selList, [
                            function(data) {return '<input name="userKey[]" value=' + "'" + data.userKey + "'" + '>';},
                            function(data) {return data.userId;},
                            function(data) {return data.name;},
                            function(data) {return data.telephoneMobile;},
                            function(data) {return data.authorityName;},
                            function(data) {return SelBtn;}
                        ], {escapeHtml:false});
                        $('#dataList tr').each(function(){
                            var tr = $(this);
                            tr.children().eq(0).attr("style", "display:none");
                        });
                    });
            });
    }

    //상품정보 가져오기
    function fn_search3(val) {
        var paging = new Paging();
        var sPage = getInputTextValue("sPage3");
        var searchType = getSelectboxValue("searchType");
        var searchText = getInputTextValue("optionSearchType");

        if(searchType == undefined) searchType = "";
        if(val == "new") sPage = "1";

        dwr.util.removeAllRows("dataList3");
        gfn_emptyView3("H", "");//페이징 예외사항처리

        productManageService.getVideoProductListCountByFreeLectureInject(searchType, searchText, function (cnt) {
            paging.count3(sPage, cnt, pagingListCount(), pagingListCount(), comment.blank_list);
            var listNum = ((cnt-1)+1)-((sPage-1)*10); //리스트 넘버링
            productManageService.getVideoProductListByFreeLectureInject(sPage, 5, searchType, searchText, function (selList) {
                if (selList.length == 0) return;
                if(selList.length > 0){
                    for (var i = 0; i < selList.length; i++) {
                        var cmpList = selList[i];

                        var mobileChkBtn = "";
                        var vodMobileChkBtn = "";
                        var vodChkBtn = "";

                        var mobiletext = '"MOBILE"';
                        var vodMobiletext = '"VOD + MOBILE"';
                        var vodtext = '"VOD"';

                        if(cmpList.vodPriceKey > 0)        vodChkBtn        = "<input type='checkbox' name='vodChk' onclick='sendChildValue2($(this),"+ cmpList.vodPriceKey +","+ vodtext +");'>" + "VOD"+"<br>";
                        if(cmpList.mobilePriceKey > 0 )    mobileChkBtn     = "<input type='checkbox' name='mobileChk' onclick='sendChildValue2($(this),"+ cmpList.mobilePriceKey +","+ mobiletext +");'>"+"MOBILE"+"<br>";
                        if(cmpList.vodMobilePriceKey > 0 ) vodMobileChkBtn  = "<input type='checkbox' name='vodMobileChk' onclick='sendChildValue2($(this),"+ cmpList.vodMobilePriceKey +","+ vodMobiletext +");'>" + "VOD + MOBILE"+"<br>";

                        if (cmpList != undefined) {
                            var cellData = [
                                function(data) {return cmpList.GKey == null ? "-" : cmpList.GKey;},
                                function(data) {return cmpList.goodsName == null ? "-" : cmpList.goodsName;},
                                function(data) {return vodChkBtn+mobileChkBtn+vodMobileChkBtn},
                            ];
                            dwr.util.addRows(dataList3, [0], cellData, {escapeHtml:false});
                        }
                    }
                }
            });
        });
    }

    function sendChildValue2(val, priceKey, type) {
       var checkBtn = val;

        var tr = checkBtn.parent().parent();
        var td = tr.children();

        var gKey      =  td.eq(0).text();
        var goodsName = td.eq(1).text();
        var price     = priceKey;

        var resKeys = get_array_values_by_name("input", "res_key[]");
        for(var i=0; i<resKeys.length; i++){
            if(resKeys[i] == price){
                $("#chk_"+price).remove();
                return false;
            }
        }
        var trId = 'chk_'+price;
        var optionListHtml = "<tr scope='col' colspan='3' id='"+ trId +"'>";
        optionListHtml     += " <td>";
        optionListHtml     += "<input type='hidden'  value='" + priceKey + "' name='res_key[]'>";
        optionListHtml     += "</td>";
        optionListHtml     += " <td>";
        optionListHtml     += "<span>" + gKey + "</span>";
        optionListHtml     += "</td>";
        optionListHtml     += " <td>";
        optionListHtml     += "<span>" + goodsName + "</span>";
        optionListHtml     += "</td>";
        optionListHtml     += " <td>";
        optionListHtml     += "<span>" + type + "</span>";
        optionListHtml     += "</td>";
        optionListHtml     += " <td>";
        optionListHtml     += "<button type=\"button\" onclick=\"deleteTableRow('productTable', 'delBtn');\" class=\"btn btn-outline-danger btn-sm delBtn\">삭제</button>";
        optionListHtml     += "</td>";
        $('#productTable > tbody:first').append(optionListHtml);
        $('#productList  tr').each(function(){
            var tr = $(this);
            tr.children().eq(0).attr("style", "display:none");
        });
    }

    //회원 정보 전달
    function sendChildValue(val) {
        var checkBtn = val;

        var tr = checkBtn.parent().parent();
        var td = tr.children();

        var userKey   =  td.find("input").eq(0).val();
        var userId    =  td.eq(1).text();
        var userName  =  td.eq(2).text();

        var resKey = get_array_values_by_name("input", "user_key[]");
        if ($.inArray(userKey, resKey) != '-1') {
            alert("이미 선택된 회원입니다.");
            return;
        }

        var optionListHtml = "<tr scope='col' colspan='3'>";
        optionListHtml     += " <td>";
        optionListHtml     += "<input type='hidden'  value='" + userKey + "' name='user_key[]'>";
        optionListHtml     += "</td>";
        optionListHtml     += " <td>";
        optionListHtml     += "<span>" + userId + "</span>";
        optionListHtml     += "</td>";
        optionListHtml     += " <td>";
        optionListHtml     += "<span>" + userName + "</span>";
        optionListHtml     += "</td>";
        optionListHtml     += " <td>";
        optionListHtml     += "<button type=\"button\" onclick=\"deleteTableRow('memberTable', 'delBtn');\"  class=\"btn btn-outline-danger btn-sm delBtn\">삭제</button>";
        optionListHtml     += "</td>";
        $('#memberTable > tbody:first').append(optionListHtml);
        $('#memberList tr').each(function(){
            var tr = $(this);
            tr.children().eq(0).attr("style", "display:none");
        });
    }

    //저장
    function freeLectureSave() {
        var startDate = getInputTextValue('searchStartDate');
        var endDate = getInputTextValue('searchEndDate');

        var res_key = get_array_values_by_name("input", "res_key[]");
        var priceKeyList = new Array();
        $.each(res_key, function(index, key) {
            priceKeyList.push(key);
        });

        var userKeys = get_array_values_by_name("input", "user_key[]");
        var userKeyList = new Array();
        $.each(userKeys, function(index, key) {
            userKeyList.push(key);
        });

        var status = 0;
        var basicObj = getJsonObjectFromDiv("section1");
        alert(basicObj.startStop);
        if(basicObj.startStop == 'on') status = 1;
        else status = 0;

        if(userKeyList.length > 0){
            if(res_key.length > 0) {
                if(confirm("무료강의제공을 하시겠습니까?")){
                    orderManageService.injectFreeVideoLecture(priceKeyList, userKeyList, status, startDate, endDate,function (cnt) {
                        alert("강의 제공이 완료되었습니다.");
                        isReloadPage();
                    });
                }
            }else{
                alert("상품을 선택해 주세요.");
                return false;
            }
        }else{
            alert("회원을 선택해 주세요");
            return false;
        }
    }

    function changeContent() {
        var basicObj = getJsonObjectFromDiv("section1");
        if(basicObj.isLecDay == 'on') $("#daySetDiv").show();
        else $("#daySetDiv").hide();
    }

    function dateAddDel(val) {
        var dt = new Date($('#searchStartDate').val()); // 날짜값 입력
        var dayOfMonth = dt.getDate();
        dt.setDate(dayOfMonth + Number(val));
        var year   = dt.getFullYear();
        var month  = dt.getMonth() + 1;
        var day    = dt.getDate();
        month = month >= 10 ? month : '0' + month;
        day = day >= 10 ? day : '0' + day;
        var endDay = year+"-"+month+"-"+day;
        $("#searchEndDate").val(endDay);
    }
</script>
<div class="page-breadcrumb">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">무료수강 입력</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">주문관리</li>
                        <li class="breadcrumb-item active" aria-current="page">무료수강 관리</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</div>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-6">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title" style="display:inline-block;vertical-align:middle;margin-bottom:15px;">상품목록</h5>
                    <div>
                        <div style=" float: left;">
                            <span id="l_productSearch"></span>
                        </div>
                        <div style=" float: left; width: 33%; margin-left: 5px">
                            <input type="text" class="form-control" id="optionSearchType" onkeypress="if(event.keyCode==13) {fn_search3('new'); return false;}">
                        </div>
                        <div style=" float: left; width: 33%; margin-left: 5px;">
                            <button type="button" class="btn btn-outline-info mx-auto" onclick="fn_search3('new')">검색</button>
                        </div>
                    </div>
                </div>
                    <input type="hidden" id="sPage3" >
                    <table id="zero_config" class="table table-hover">
                        <thead>
                        <tr>
                            <th style="width:5%">CODE</th>
                            <th style="width:40%">상품명</th>
                            <th style="width:20%">옵션</th>
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
        <div class="col-md-6">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title" style="display:inline-block;vertical-align:middle;margin-bottom:15px;">회원목록</h5>
                    <div>
                        <div style=" float: left;">
                            <span id="l_memberSearch"></span>
                        </div>
                        <div style=" float: left; width: 33%; margin-left: 5px">
                            <input type="text" class="form-control" id="SearchText" onkeypress="if(event.keyCode==13) {fn_search('new'); return false;}">
                        </div>
                        <div style=" float: left; width: 33%; margin-left: 5px;">
                            <button type="button" class="btn btn-outline-info mx-auto" onclick="fn_search('new')">검색</button>
                        </div>
                    </div>
                </div>
                <input type="hidden" id="sPage">
                <table class="table table-hover">
                    <thead>
                    <tr>
                        <th scope="col" style="width:20%;">ID</th>
                        <th scope="col" style="width:10%;">이름</th>
                        <th scope="col" style="width:30%;">번호</th>
                        <th scope="col" style="width:10%;">권한</th>
                        <th scope="col" style="width:5%;"></th>
                    </tr>
                    </thead>
                    <tbody id="dataList"> </tbody>
                    <tr>
                        <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
                    </tr>
                </table>
                <%@ include file="/common/inc/com_pageNavi.inc" %>
                </div>
            </div>
        </div>
        <!-- //formgroup -->

        <div class="col-md-12">
            <div class="card">
                <div id="section1">
                    <div class="card-body">
                        <div class="form-group float-right mb-3">
                            <button type="button" class="btn btn-info btn-sm" onclick="freeLectureSave();">무료강의제공</button>
                        </div>
                        <div id="daySetDiv" style="display: none;">
                            <div class="form-group row">
                                <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">강의시작일</label>
                                <div class="col-sm-3 input-group pl-0 pr-0">
                                    <input type="text" class="form-control mydatepicker" placeholder="yyyy-mm-dd" name="searchStartDate" id="searchStartDate">
                                    <div class="input-group-append">
                                        <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">기간</label>
                                <input type="number" class="col-sm-2 form-control"  id="day" onkeyup="dateAddDel(this.value);">
                            </div>
                            <div class="form-group row">
                                <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">종료일</label>
                                <div class="col-sm-3 input-group pl-0 pr-0" id="dateRangePicker">
                                    <input type="text" class="form-control mydatepicker" placeholder="yyyy-mm-dd" name="searchEndDate" id="searchEndDate">
                                    <div class="input-group-append">
                                        <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 control-label col-form-label">수강일수</label>
                            <div class="col-sm-10">
                                <div style="margin-top: -23px;">
                                    기본값
                                    <label class="switch">
                                        <input type="checkbox" style="display:none;" onchange="changeContent();" id="isLecDay" name="isLecDay">
                                        <span class="slider"></span>
                                    </label>
                                    설정값
                                </div>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 control-label col-form-label">시작/대기</label>
                            <div class="col-sm-10">
                                <div style="margin-top: -23px;">
                                    대기
                                    <label class="switch">
                                        <input type="checkbox" style="display:none;" id="startStop" name="startStop">
                                        <span class="slider"></span>
                                    </label>
                                    시작
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">상품목록</label>
                                    <table class="table table-hover text-center" id="productTable">
                                        <thead>
                                        <tr>
                                            <th scope="col" style="width:5%;">CODE</th>
                                            <th scope="col" style="width:42%;">상품명</th>
                                            <th scope="col" style="width:25%;">옵션</th>
                                            <th scope="col" style="width:5%;"></th>
                                        </tr>
                                        </thead>
                                        <tbody id="productList" ></tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">회원목록</label>
                                    <table class="table table-hover text-center" id="memberTable">
                                        <thead>
                                        <tr>
                                            <th scope="col" style="width:75%;">ID</th>
                                            <th scope="col" style="width:25%;">이름</th>
                                            <th scope="col" style="width:5%;"></th>
                                        </tr>
                                        </thead>
                                        <tbody id="memberList"></tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
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
