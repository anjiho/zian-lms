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
<script type='text/javascript' src='/dwr/interface/memberManageService.js'></script>
<script type='text/javascript' src='/dwr/interface/productManageService.js'></script>
<script>
    function init() {
        getMemberSearchSelectbox("l_memberSearch");
        getProductSearchTypeSelectbox("l_productSearch");
        getAcaLecturePayTypeSelectbox("payType", "");//결제방법
        getCardKindSelectbox('cardCode', '');//카드선택
        getSelectboxListForCtgKey('affiliationCtgKey','133','');
        menuActive('menu-3', 9);
        fn_search('new');
        fn_search3('new');
    }

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
        var grade = "";
        var affiliationCtgKey = 0;

        memberManageService.getMemeberListCount(searchType, searchText, regStartDate, regEndDate,
            grade, affiliationCtgKey, function (cnt) {
                paging.count(sPage, cnt, '10', '10', comment.blank_list);
                var listNum = ((cnt-1)+1)-((sPage-1)*10); //리스트 넘버링
                memberManageService.getMemeberList(sPage, 5, searchType, searchText,
                    regStartDate, regEndDate, grade, affiliationCtgKey, function (selList) {
                        console.log(selList);
                        if (selList.length == 0) return;
                        var SelBtn = '<input type="button" onclick="sendChildValue($(this))" value="선택" class="btn btn-outline-info"/>';
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

    //회원 ID,KEY값 전달
    function sendChildValue(val) {
        var checkBtn = val;

        var tr = checkBtn.parent().parent();
        var td = tr.children();

        var userKey = td.find("input").val();
        var userId = td.eq(1).text();

        $("#userId").val(userId);
        $("#userKey").val(userKey);
    }

    function fn_search3(val) {
        var paging = new Paging();
        var sPage = getInputTextValue("sPage3");
        var searchType = getSelectboxValue("searchType");
        var searchText = getInputTextValue("optionSearchType");
        if(searchType == undefined) searchType = "";

        if(val == "new") sPage = "1";

        dwr.util.removeAllRows("dataList3");
        gfn_emptyView3("H", "");//페이징 예외사항처리
        productManageService.getProductListCount(searchType, searchText, "ACADEMY", function (cnt) {
            paging.count3(sPage, cnt, pagingListCount(), pagingListCount(), comment.blank_list);
            var listNum = ((cnt-1)+1)-((sPage-1)*10); //리스트 넘버링
            productManageService.getProductList(sPage, 5, searchType, searchText, "ACADEMY", function (selList) {
                if (selList.length == 0) return;
                console.log(selList);
                var SelBtn = '<input type="button" onclick="sendChildValue_2($(this))" value="선택" class="btn btn-outline-info"/>';
                dwr.util.addRows("dataList3", selList, [
                    function(data) {return '<input name="GKey[]" value=' + "'" + data.GKey + "'" + '>';},
                    function(data) {return data.GKey;},
                    function(data) {return data.goodsName;},
                    function(data) {return data.kind+"개월";},
                    function(data) {return SelBtn;},
                ], {escapeHtml:false});
                $('#dataList3 tr').each(function(){
                    var tr = $(this);
                    tr.children().eq(0).attr("style", "display:none");
                });
            });
        });
    }

    //옵션 전달값
    function sendChildValue_2(val) {
        var checkBtn = val;

        var tr = checkBtn.parent().parent();
        var td = tr.children();

        var gKey = td.find("input").val();
        var goodsName = td.eq(2).text();
        var kind = td.eq(3).text();
        var GKeys = get_array_values_by_name("input", "res_key[]");
        if ($.inArray(gKey, GKeys) != '-1') {
            alert("이미 선택된 옵션입니다.");
            return;
        }

        var optionListHtml = "<tr scope='col' colspan='3'>";
        optionListHtml     += " <td>";
        optionListHtml     += "<input type='hidden'  value='" + gKey + "' name='res_key[]'>";
        optionListHtml     += "</td>";
        optionListHtml     += " <td>";
        optionListHtml     += "<span>" + goodsName + "</span>";
        optionListHtml     += "</td>";
        optionListHtml     += " <td>";
        optionListHtml     += "<span>" + kind + "</span>";
        optionListHtml     += "</td>";
        optionListHtml     += " <td>";
        optionListHtml     += "<button type=\"button\" onclick=\"deleteTableRow('optionTable');\" class=\"btn btn-outline-danger btn-sm\" style=\"margin-top:8%;\" >삭제</button>";
        optionListHtml     += "</td>";
        $('#optionTable > tbody:first').append(optionListHtml);
        $('#optionList tr').each(function(){
            var tr = $(this);
            tr.children().eq(0).attr("style", "display:none");
        });
    }

    function deleteTableRow(val) {
        if (val == "optionTable") {
            if ($("#optionTable > tbody > tr").length == 1) {
                $('#optionTable > tbody:first > tr:first').attr("style", "display:none");
            } else {
                $('#optionTable > tbody:last > tr:last').remove();
            }
        }
    }
    
    function academyLectureInfoSave() {
        var userKey = getInputTextValue('userKey');
        var memoTitle = getInputTextValue('memoTitle');
        var memoContent = getInputTextValue('memoContent');
        var price = getInputTextValue('price');
        var payType =  getSelectboxValue('payType');
        var cardCode = getSelectboxValue('cardCode');
        var optionArray = new Array();
        $('#optionTable tbody tr').each(function(index){
            var gKey = $(this).find("td input").eq(0).val();
            optionArray.push(gKey);
        });

        if(userKey != "") {
            if(confirm("저장 하시겠습니까?")){
                orderManageService.saveAcademyLecture(userKey, optionArray, price, payType, cardCode, memoTitle, memoContent,function (cnt) {});
            }
        }else{
            alert("회원을 선택해 주세요.");
        }
    }
</script>
<div class="page-breadcrumb">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">학원수강 입력</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">주문관리</li>
                        <li class="breadcrumb-item active" aria-current="page">학원수강 입력</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</div>

<!-- 기본 소스-->
<div class="container-fluid">
    <div class="row">
        <div class="col-md-6">

            <div class="card">
                <div class="card-body">
                    <h5 class="card-title" style="display:inline-block;vertical-align:middle;margin-bottom:-2px;">회원검색</h5>
                </div>
                <div style=" display:inline;">
                    <div style=" float: left;">
                        <span id="l_memberSearch"></span>
                    </div>
                    <div style=" float: left; width: 33%">
                        <input type="text" class="form-control" id="SearchText" onkeypress="if(event.keyCode==13) {fn_search('new'); return false;}">
                    </div>
                    <div style=" float: left; width: 33%">
                        <button type="button" class="btn btn-outline-info mx-auto" onclick="fn_search('new')">검색</button>
                    </div>
                </div>
                <input type="hidden" id="sPage">
                <table class="table table-hover text-center">
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
        <div class="col-md-6">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title" style="display:inline-block;vertical-align:middle;margin-bottom:-2px;">옵션추가</h5>
                </div>
                <div style=" display:inline;">
                    <div style=" float: left;">
                        <span id="l_productSearch"></span>
                    </div>
                    <div style=" float: left; width: 33%">
                        <input type="text" class="form-control" id="optionSearchType" onkeypress="if(event.keyCode==13) {fn_search('new'); return false;}">
                    </div>
                    <div style=" float: left; width: 33%">
                        <button type="button" class="btn btn-outline-info mx-auto" onclick="fn_search3('new')">검색</button>
                    </div>
                </div>
                <div class="table-responsive">
                    <input type="hidden" id="sPage3" >
                    <table id="zero_config" class="table table-hover text-center">
                        <thead>
                        <tr>
                            <th style="width:5%">코드</th>
                            <th style="width:50%">상품명</th>
                            <th style="width:10%">옵션</th>
                            <th style="width:3%"></th>
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
        <!-- //formgroup -->

<div class="col-md-12">
    <div class="card">
        <div class="card-body">
            <div class="form-group row">
                <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">회원ID</label>
                <input type="hidden" id="userKey" name="userKey" value="">
                <input type="text" class="col-sm-2 form-control"  id="userId" readonly>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">준비직렬</label>
                <div class="col-sm-6 pl-0 pr-0">
                    <span id="affiliationCtgKey"></span>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">판매금액</label>
                <input type="text" class="col-sm-2 form-control" id="sellPrice" readonly>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">결제금액</label>
                <input type="number" class="col-sm-2 form-control" id="price">
            </div>
            <div class="form-group row">
                <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">결제방법</label>
                <div class="col-sm-6 pl-0 pr-0">
                    <span id="payType"></span>
                    <span id="cardCode"></span>
                </div>

            </div>
            <div class="form-group">
                <div class="form-group row">
                    <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">제목</label>
                    <input type="text" class="col-sm-6 form-control" id="memoTitle">
                </div>
                <div class="form-group row">
                    <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">내용</label>
                    <textarea class="col-sm-6 form-control" id="memoContent" style="height: 150px;"></textarea>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">옵션</label>
                <table class="table table-hover text-center" id="optionTable">
                    <thead>
                    <tr>
                        <th scope="col" style="width:75%;">상품명</th>
                        <th scope="col" style="width:25%;">옵션</th>
                        <th scope="col" style="width:5%;"></th>
                    </tr>
                    </thead>
                    <tbody id="optionList"></tbody>
                </table>
            </div>
            <button type="button" class="btn btn-info float-right" onclick="academyLectureInfoSave();">저장</button>
        </div>
    </div>
</div>
</div>
<!-- // 기본소스-->
<!--main wapper-->
<%@include file="/common/jsp/footer.jsp" %>
