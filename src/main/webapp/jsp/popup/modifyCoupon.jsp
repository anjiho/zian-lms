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
<style type="text/css">.content{overflow:initial !important}</style>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/popupCouponManageService.js'></script>
<script type='text/javascript' src='/dwr/interface/dataManageService.js'></script>
<script type='text/javascript' src='/dwr/interface/productManageService.js'></script>
<script type='text/javascript' src='/dwr/interface/memberManageService.js'></script>
<script>
    $( document ).ready(function() {
        $('#periodType').click(function(){
            var type = getSwitchValue("periodType");
            if(type==1){
                $('.period02').hide();
                $('.period01').show();
            }else{
                $('.period01').hide();
                $('.period02').show();
            }
        })

        $('#userSearchType').click(function(){
            var type = getSwitchValue("userSearchType");
            if(type==1){
                alert("준비중입니다.");
                isSwitchByNumber("userSearchType", 0);
                return;
                /*$('.excelUpload').show();
                $('.searchUpload').hide();
                $('.modal-dialog').css('max-width','600px');*/

            }else{
                $('.excelUpload').hide();
                $('.searchUpload').show();
                $('.modal-dialog').css('max-width','1200px');
            }
        })
    });
    var couponKey = '<%=couponKey%>';
    var sPage='<%=sPage%>';

    function init() {
        var currentDay=today();
        innerValue('indate',currentDay);

        //탭 메뉴 색상 변경
        $("#playForm ul").each(function(idx) {
            var ul = $(this);
            ul.find("li").addClass("done").attr("aria-selected", "false");
            ul.find("li").eq(0).removeClass("done").attr("aria-selected", "true");
        });
        menuActive('menu-4', 3);

        /*기본정보*/
        innerHTML("code", couponKey);
        innerValue("sPage", sPage);
        /*기본정보*/

        /*카테고리*/
        getNewCategoryList("sel_category","214",'1183');
        getCategoryNoTag2('categoryTable1','1183', '3');
        /*카테고리*/

        /*쿠폰 소지자 조회*/
        getCouponConditionSelectbox("couponConditionSearch",'');
        /*쿠폰 소지자 조회*/

        /* 쿠폰 정보 가져오기 */
        popupCouponManageService.getCouponDetailInfo(couponKey, function(info) {
            var couponInfo = info.couponInfo;
            var dcType=couponInfo.dcType;

            innerValue("name", couponInfo.name);
            innerValue("contents", couponInfo.contents);
            innerValue("indate", couponInfo.indate);
            innerValue("dcValue", dcType =='1'?couponInfo.dcValue==''?'0':couponInfo.dcValue:format(couponInfo.dcValue));
            innerValue("limitPriceMin", couponInfo.limitPriceMin ==''?'0':format(couponInfo.limitPriceMin)); //최소 결제 금액
            innerValue("limitDay",couponInfo.limitDay == ''?'0':couponInfo.limitDay);//사용기간설정
            innerValue("startDate",couponInfo.startDate);//사용기간설정
            innerValue("endDate",couponInfo.endDate);//사용기간설정

            isSwitchByNumber("periodType", couponInfo.periodType);//지급방식
            isSwitchByNumber("type", couponInfo.type);//지급방식
            isSwitchByNumber("dcType", couponInfo.dcType);//할인설정
            isSwitchByNumber("isShow",couponInfo.isShow);//노출여부
            deviceSelectbox2('deviceSelect', couponInfo.device);//쿠폰 사용 디바이스 설정

            /* 쿠폰 소지자 조회 */
            innerValue("couponName", couponInfo.name);
            /* //쿠폰 소지자 조회 */

            var periodType=couponInfo.periodType;
            if( periodType== 1){
                    $('.period02').hide();
                    $('.period01').show();
             }else{
                $('.period01').hide();
                $('.period02').show();
            }

            if(couponInfo.type==1) $('.offButton').show();
            else $('.offButton').hide();

            /**
             * 카테고리 정보 가져오기
             */
            var resultList = info.couponCategoryList;

            var nextIcon = "<i class=\"m-r-10 mdi mdi-play\" style=\"font-size:18px;color:darkblue\"></i>";
            if(resultList.length == 0){
                var cellData = [
                    function() {return "<input type='hidden' name='inputCtgKey[]' value=''>";},
                    function() {return "지안에듀";},
                    function() {return nextIcon},
                    function() {return getCategoryNoTag('categoryTable1','1183', '3');},
                    function() {return nextIcon},
                    function() {return defaultCategorySelectbox();},
                    function() {return nextIcon},
                    function() {return defaultCategorySelectbox();},
                    function() {return nextIcon},
                    function() {return defaultCategorySelectbox();},
                    function() {return "<button type=\"button\" onclick=\"deleteTableRow('categoryTable1', 'delBtn');\" class=\"btn btn-outline-danger btn-sm delBtn\" style=\"margin-top:8%;\" >삭제</button>"},
                ];
                dwr.util.addRows("categoryList", [0], cellData, {escapeHtml: false});
                $('#categoryList tr').eq(0).attr("style", "display:none");
            }else{
                for(var i=0; i < resultList.length; i++){
                    var categoryList=resultList[i];
                    var delBtn = "<input type='button' onclick='deleteCategory("+ categoryList[i].ctgKey +");' class='btn btn-outline-danger btn-sm' value='삭제'>";
                    var cellData = [
                        function() {return "<input type='hidden' name='inputCtgKey[]' value='"+ categoryList[i].ctgKey +"'>";},
                        function() {return "지안에듀";},
                        function() {return nextIcon},
                        function() {return categoryList[2].name;},
                        function() {return nextIcon},
                        function() {return categoryList[1].name;},
                        function() {return nextIcon},
                        function() {return categoryList[0].name;},
                        function() {return delBtn},
                        //function() {return ""},
                    ];
                    dwr.util.addRows("categoryList", [0], cellData, {escapeHtml: false});
                    $('#categoryList tr').each(function(){
                        var tr = $(this);
                        // tr.children().eq(11).attr("style", "display:none");
                    });
                }
            }
        });

    }

    function fn_search(val) {
        var paging = new Paging();
        var sPage = getInputTextValue("sPage");

        if (val == "new") sPage = "1";

        dwr.util.removeAllRows("dataList"); //테이블 리스트 초기화
        gfn_emptyView("H", "");//페이징 예외사항처리

        var listLimit=10;
        var couponMasterKey=couponKey;
        var searchType=getSelectboxValue('couponConditionSearch');
        var searchText=getInputTextValue('searchText');
        var type=getSwitchValue('type');
        var periodType=getSwitchValue('periodType');

        popupCouponManageService.getAdminCouponIssueUserListCount(couponMasterKey,type,searchType,searchText, function (cnt) {
                paging.count(sPage, cnt, '10', '10', comment.blank_list);
                    popupCouponManageService.getAdminCouponIssueUserList(sPage,listLimit,couponMasterKey,type,periodType,searchType,searchText, function (selList) {
                        if (selList.length == 0) return;
                        dwr.util.addRows("dataList", selList, [
                            function(data) {return "<a href='javascript:void(0);' color='blue' onclick='goMemberDetail(" + data.userKey + ");'>" + data.userId + "</a>";},
                            function(data) {return  data.name;},
                            function(data) {return data.code == null ? "-" : data.code;},
                            function(data) {return data.indate ==null? "-" : data.indate;},
                            function(data) {return data.valIdDate == null ? "-" : data.valIdDate ;},
                            function(data) {return data.useDate == null ? "-" : data.useDate;}
                        ], {escapeHtml:false});
            });
        });
    }

    function deleteCategory(linkKey){
        if(confirm("삭제하시겠습니까?")) {
            productManageService.deleteCouponCategory(linkKey,couponKey, 'COUPON',function () {isReloadPage();});
        }
    }

    //카테고리 추가 버튼
    function addCategoryInfo() {
        for(var i=0; i < $("#categoryList1").find("tr").length; i++){
            var cateName1 =  $("#categoryList1").find("tr").eq(i).find("td select").eq(1).val();
            if(cateName1 == "" || cateName1 == undefined){
                alert("카테고리 선택후 추가해 주세요.");
                $("#categoryList").find("tr").eq(i).find("td select").eq(1).focus();
                return false;
            }
        }

        var fistTrStyle = $("#categoryTable1 tr").eq(0).attr("style");

        if (fistTrStyle == "display:none") {
            $('#categoryTable1 tr').eq(0).removeAttr("style", null);
        } else {
            var $tableBody = $("#categoryTable1").find("tbody"),
                $trLast = $tableBody.find("tr:last"),
                $trNew = $trLast.clone();
            $trLast.after($trNew);

            getCategoryNoTag2('categoryTable1','1183', '2');
        }
    }

    //카테코리 셀렉트 박스 변경 시
    function changeCategory(tableId, val, tdNum) {
        if(tdNum == '11') return false;
        getCategoryNoTag2(val, tableId, tdNum);
    }

    function couponSave() {
        var basicObj = getJsonObjectFromDiv("section1");
        var limitPrice=uncomma(getInputTextValue('limitPriceMin'));
        var dcType=getSwitchValue('dcType');
        if(dcType==0){
            var dcValue=uncomma(getInputTextValue('limitPriceMin'));
            basicObj.dcValue=Number(dcValue);
        }else{
            basicObj.dcValue=Number(getInputTextValue('dcValue'));
        }
        basicObj.couponMasterKey = <%=couponKey%>;
        basicObj.dcType =getSwitchValue('dcType');
        basicObj.type = getSwitchValue('type');
        basicObj.periodType = getSwitchValue('periodType');
        basicObj.isShow =getSwitchValue('isShow');
        basicObj.limitDay=Number(getInputTextValue('limitDay'));
        basicObj.device=Number(getInputTextValue('device'));
        basicObj.limitPriceMin=Number(limitPrice);

        var categoryArr = new Array();
        $('#categoryTable1 tbody tr').each(function (index) {
            var ctgKeys = get_array_values_by_name("input", "inputCtgKey1[]");
                categoryArr.push(Number(ctgKeys));
        });

       if(confirm("수정 하시겠습니까?")) {
            var ctgkey = $("#categoryList1").find("tr").eq(0).find("td select").eq(1).val();
            if(ctgkey != "") {
                popupCouponManageService.updateCouponCategoryInfo(couponKey, categoryArr, function () {});
            }
            popupCouponManageService.updateCouponMasterInfo(basicObj, function () {isReloadPage(true);});
        }
    }

    //쿠폰 등록 팝업
    function couponProduce() {
        var type=getSwitchValue('type');
        if (type==0){
            $('.modal-dialog').css('max-width','1200px');
        }else $('.modal-dialog').css('max-width','600px');

        dwr.util.removeAllRows("dataList3"); //테이블 리스트 초기화
        dwr.util.removeAllRows("selectUserList"); //테이블 리스트 초기화
        gfn_emptyView("H", "");//페이징 예외사항처리

        popupCouponManageService.getCouponDetailInfo(couponKey , function (selList) {
            var type2=getSwitchValue('userSearchType');
            $("#popupType").val(type);
            $("#popupCouponKey").val(couponKey);

            searchMemberSelectBox('userSelect','');

            if(type==1){
                $('.offline').show();
                $('.online').hide();
            }else{
                $('.offline').hide();
                if(type2==0){
                    $('.searchUpload').show();
                    $('.excelUpload').hide();
                }
                else {
                    $('.searchUpload').hide();
                    $('.excelUpload').show();
                }
            }
            isCheckboxByNumber("popuptype", selList.type);
            if (selList.value1 != null) { /*파일명보이게*/
                $(document).ready(function () {
                    $('.custom-file-control').html(selList.value1);
                });
            }
        });
    }

    //팝업 Close 기능
    function close_pop(flag) {
        $('#myModal').hide();
    };

    //팝업 저장 기능
    function modify() {
        var data = new FormData();
        var type=getSwitchValue('type');
        var type2=getSwitchValue('userSearchType');
        var offCoupon=$("#offCoupon").val();
        var couponMKey=couponKey;

        if(type==0){ // 온라인 쿠폰
            if(type2==0) {  // 회원검색
                if($('#selectUserList tr').length > 0){

                    var couponUsersArr = new Array(); // 배열 선언
                    var periodType =getSwitchValue('periodType');

                    $('#selectUserList  tr').each(function(index){
                        var $this = $(this);
                        var userKey=$this.find('input[name="res_key[]"]').val();
                        var data = {
                            userKey: Number(userKey),
                            couponMasterKey: couponMKey,
                        };
                        couponUsersArr.push(data);
                    });
                    popupCouponManageService.issueCouponToUser(couponUsersArr, function () {
                        alert("지급 완료되었습니다.");
                        isReloadPage();
                    });
                }else{
                    alert("추가된 회원 목록이 없습니다.");
                    return false;
                }
            }
            if(type2==1){  // 엑셀업로드
                $.each($('#attachFile')[0].files, function(i, file) {
                    data.append('file_name', file);

                    if(confirm("저장하시겠습니까?")) {
                        $.ajax({
                            url: "/file/bannerUpload",
                            method: "post",
                            dataType: "JSON",
                            data: data,
                            cache: false,
                            processData: false,
                            contentType: false,
                            success: function (data) {
                                alert("저장이 완료되었습니다.");
                                location.reload();
                            }
                        });
                    }
                });
            }
        }else if (type==1){ // 오프라인 쿠폰
            popupCouponManageService.produceOfflineCoupon(couponMKey,offCoupon, function () {
                alert("생성 완료되었습니다..");
                isReloadPage();
            });
        }
    }

    function fn_search3(val) {
        var paging = new Paging();
        var sPage=getInputTextValue("sPage3");
        var searchText=getInputTextValue('couponUser');
        var searchType=getSelectboxValue('userSelect');

        if(searchType == undefined) searchType = "";
        if(val == "new") sPage = "1";

        dwr.util.removeAllRows("dataList3"); //테이블 리스트 초기화
        gfn_emptyView3("H", "");//페이징 예외사항처리

        memberManageService.getMemberSelectListCount(searchType, searchText, function (cnt) {
            paging.count3(sPage, cnt, '10', '10', comment.blank_list);
            var listNum = ((cnt-1)+1)-((sPage-1)*10); //리스트 넘버링
            memberManageService.getMemberSelectList(sPage, 5, searchType, searchText, function (selList) {
                if (selList.length == 0) return;
                var SelBtn = '<input type="button" onclick="sendUserSelect($(this))" value="선택" style="margin-top: -6px;" class="btn btn-info btn-sm"/>';
                dwr.util.addRows("dataList3", selList, [
                    function(data) {return '<input type="hidden" name="userKey[]" value=' + "'" + data.userKey + "'" + '>';},
                    function(data) {return data.userId == null ? "-" : data.userId;},
                    function(data) {return data.name == null ? "-" :data.name;},
                    function(data) {return data.telephoneMobile == null ? "-" :data.telephoneMobile;},
                    function(data) {return data.affiliationName == null ? "-" : data.affiliationName;},
                    function(data) {return data.authorityName == null ? "-" : data.authorityName;},
                    function(data) {return SelBtn;},
                ], {escapeHtml:false});
            });
        });
    }

    function sendUserSelect(val) {
        var checkBtn = val;
        var tr = checkBtn.parent().parent();
        var td = tr.children();
        var userKey =  td.find("input").eq(0).val();
        var userId = td.eq(1).text();
        var userName = td.eq(2).text();
        var authorityName = td.eq(5).text();
        var userKeyChk = get_array_values_by_name("input", "res_key[]");

        if ($.inArray(userKey, userKeyChk) != '-1') {
            alert("이미 선택된 회원입니다.");
            return;
        }

        var selectUserListHtml = "<tr scope='col' colspan='3'>";
        selectUserListHtml     += " <td>";//userKey
        selectUserListHtml     += "<input type='hidden'  value='" + userKey + "' name='res_key[]'>";
        selectUserListHtml     += "</td>";
        selectUserListHtml     += " <td>";
        selectUserListHtml     += "<span>" + userId + "</span>";
        selectUserListHtml     += "</td>";
        selectUserListHtml     += " <td>";
        selectUserListHtml     += "<span>" + userName + "</span>";
        selectUserListHtml     += "</td>";
        selectUserListHtml     += " <td>";
        selectUserListHtml     += "<span>" + authorityName + "</span>";
        selectUserListHtml     += "</td>";
        selectUserListHtml     += " <td>";
        selectUserListHtml     += "<button type=\"button\" onclick=\"deleteTableRow('selectUserList', 'delBtn')\" class=\"btn btn-outline-danger btn-sm delBtn\">삭제</button>";
        selectUserListHtml     += "</td>";
        $('#userAdd > tbody:first').append(selectUserListHtml);
        $('#selectUserList tr').each(function(){
            var tr = $(this);
            tr.children().eq(0).attr("style", "display:none");
        });
    }

    function fn_search4(val){
        var paging = new Paging();
        var sPage=getInputTextValue("sPage4");
        if(val == "new") sPage = "1";

        $('.modal-dialog').css('max-width','600px');

        dwr.util.removeAllRows("dataList4"); //테이블 리스트 초기화
        gfn_emptyView("H", "");//페이징 예외사항처리

        popupCouponManageService.getOfflineCouponListCount(couponKey, function (cnt) {
            paging.count4(sPage, cnt, '10', '10', comment.blank_list);
            var listNum = ((cnt-1)+1)-((sPage-1)*10); //리스트 넘버링
            popupCouponManageService.getOfflineCouponList(sPage,10,couponKey, function (selList) {
                if (selList.length == 0) return;
                dwr.util.addRows("dataList4", selList, [
                    function(data) {return data.code == null ? "-" : data.code;},
                    function(data) {return data.produceDate == null ? "-" :data.produceDate;},
                ], {escapeHtml:false});
            });
        });
    }

    function goCouponList() {
        innerValue('param_key', '<%=couponKey%>');
        innerValue('param_key2', '<%=searchStartDate%>');
        innerValue('param_key3', '<%=searchEndDate%>');
        innerValue('param_key4', '<%=couponSearch%>');
        innerValue('param_key5', '<%=searchText2%>');
        innerValue('param_key6', '<%=sPage%>');

        goPage('popupCouponManage', '<%=type%>');
    }
</script>
<div class="page-breadcrumb">
    <input type="hidden" id="sPage">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">쿠폰상세</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">팝업/쿠폰 관리</li>
                        <li class="breadcrumb-item active" aria-current="page">쿠폰상세</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</div>
<!--//순서-->

<!-- 기본 소스-->
<!-- 기본 소스-->
<form id="basic">
    <div class="container-fluid">
        <div class="card">
            <div class="card-body wizard-content">
                <h4 class="card-title"></h4>
                <h6 class="card-subtitle"></h6>
                <div id="playForm" method="" action="" class="m-t-40">
                    <div>

                        <!-- 1.기본정보 Tab -->
                        <h3>기본정보</h3>
                        <section class="col-md-auto">
                            <div id="section1">
                                <div class="col-md-12">
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">코드</label>
                                        <span id="code"></span>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">쿠폰명</label>
                                        <input type="text" class="col-sm-6 form-control" style="display: inline-block;" id="name" name="name">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">설명</label>
                                        <input type="text" class="col-sm-6 form-control" style="display: inline-block;" id="contents" name="contents">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">등록일</label>
                                        <div class="col-sm-3 input-group pl-0 pr-0" id="dateRangePicker">
                                            <input type="text" class="form-control mydatepicker" placeholder="yyyy-mm-dd" name="indate" id="indate">
                                            <div class="input-group-append">
                                                <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row mt-4">
                                        <label class="col-sm-2 text-left control-label col-form-label"  style="margin-bottom: 0">지급방식</label>
                                        <div class="col-sm-10">
                                            <div style="margin-top: -23px;">
                                                온라인
                                                <label class="switch">
                                                    <input type="checkbox" id="type" name="type" style="display:none;">
                                                    <span class="slider"></span>
                                                </label>
                                                오프라인
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row mt-4">
                                        <label class="col-sm-2 text-left control-label col-form-label"  style="margin-bottom: 0">할인설정</label>
                                        <div class="col-sm-10">
                                            <div style="margin-top: -23px;">
                                                할인가
                                                <label class="switch">
                                                    <input type="checkbox" id="dcType" name="dcType" style="display:none;">
                                                    <span class="slider"></span>
                                                </label>
                                                할인율
                                            </div>
                                            <div style="margin-top:11px">
                                                <label class="control-label col-form-label" style="margin-bottom:0;margin-right:10px;font-weight:inherit">할인값</label>
                                                <input type="text" class="col-sm-1 form-control" style="display: inline-block;" id="dcValue" name="dcValue">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">최소결제금액</label>
                                        <input type="text" class="col-sm-2 form-control" style="display: inline-block;" id="limitPriceMin" name="limitPriceMin">
                                        <label class="control-label col-form-label" style="margin-bottom:0;margin-right:10px;font-weight:inherit">원</label>
                                    </div>
                                    <div class="form-group row mt-4">
                                        <label class="col-sm-2 text-left control-label col-form-label"  style="margin-bottom: 0">사용기간</label>
                                        <div class="col-sm-10">
                                            <div style="margin-top: -23px;">
                                                발행기준
                                                <label class="switch">
                                                    <input type="checkbox" id="periodType" name="periodType" style="display:none;">
                                                    <span class="slider"></span>
                                                </label>
                                                지정기간
                                            </div>
                                            <div class="col-sm-10 pl-0 pr-0 mr-3 pt-3 mt-3 pb-4" style="position:relative;">
                                                <span id="period">
                                                    <div class="period01" style="display:none;position:absolute;left:0;top:0">
                                                        <input type='text' class='form-control datepicker col-sm-3' placeholder='yyyy-mm-dd' name='startDate' id='startDate' style='display:inline-block' autocomplete='off'>
                                                        <div class='input-group-append' style='display:inline-block'>
                                                            <span class='input-group-text'><i class='fa fa-calendar'></i></span>
                                                        </div>
                                                        <span style='display:inline-block'>&nbsp;&nbsp;~&nbsp;&nbsp;</span>
                                                        <input type='text' class='form-control datepicker col-sm-3' placeholder='yyyy-mm-dd' name='endDate' id='endDate' style='display:inline-block' autocomplete='off'>
                                                        <div class='input-group-append' style='display:inline-block'>
                                                            <span class='input-group-text'><i class='fa fa-calendar'></i></span>
                                                        </div>
                                                    </div>
                                                    <div class="period02" style="display:none;position:absolute;left:0;top:0">
                                                        쿠폰 취득(발행) 후 : <input type='text' class='col-sm-2 form-control' style='display: inline;margin-left:6px;text-align:right' id='limitDay' name='limitDay'> 일간 사용가능
                                                    </div>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row mt-4">
                                        <label class="col-sm-2 text-left control-label col-form-label"  style="margin-bottom: 0">노출여부</label>
                                        <div class="col-sm-10">
                                            <div style="margin-top: -23px;">
                                                OFF
                                                <label class="switch">
                                                    <input type="checkbox" id="isShow" name="isShow" style="display:none;">
                                                    <span class="slider"></span>
                                                </label>
                                                ON
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">사용범위</label><!--0-->
                                        <div class="col-sm-2 pl-0 pr-0 mr-3"><!--0-->
                                            <span id="deviceSelect"></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>
                        <!-- // 1.기본정보 Tab -->
                        <!-- 2.카테고리 목록 Tab -->
                        <h3>카테고리</h3>
                        <section>
                            <div class="float-right mb-3">
                                <button type="button" class="btn btn-info btn-sm" onclick="addCategoryInfo()">추가</button>
                            </div>
                            <div id="section3">
                                <!--카테고리 가져오기-->
                                <table class="table" id="categoryTable">
                                    <thead>
                                    <tr style="display:none;">
                                        <th></th>
                                        <th scope="col"></th>
                                        <th scope="col"></th>
                                    </tr>
                                    </thead>
                                    <tbody id="categoryList"></tbody>
                                </table>
                                <!--새로운카테고리 추가-->
                                <table class="table" id="categoryTable1">
                                    <input type="hidden" name="ctgGKey" value="0">
                                    <input type="hidden" name="gKey" value="0">
                                    <input type="hidden" name="pos" value="0">
                                    <thead>
                                    <tr style="display:none;">
                                        <th></th>
                                        <th scope="col"></th>
                                        <th scope="col"></th>
                                        <th scope="col"></th>
                                        <th scope="col"></th>
                                        <th scope="col"></th>
                                        <th scope="col"></th>
                                        <th scope="col"></th>
                                    </tr>
                                    </thead>
                                    <tbody id="categoryList1">
                                    <tr>
                                        <td style="display: none">
                                            <input type='hidden' name='inputCtgKey1[]' value=''>
                                        </td>
                                        <td><!--옵션명selbox-->
                                            <select class='form-control'  id='sel_category' disabled></select>
                                        </td>
                                        <td>
                                            <i class="m-r-10 mdi mdi-play" style="font-size:18px;color:darkblue"></i>
                                        </td>
                                        <td>
                                            <select class='form-control'></select>
                                        </td>
                                        <td>
                                            <i class="m-r-10 mdi mdi-play" style="font-size:18px;color:darkblue"></i>
                                        </td>
                                        <td>
                                            <select class='form-control'></select>
                                        </td>
                                        <td>
                                            <i class="m-r-10 mdi mdi-play" style="font-size:18px;color:darkblue"></i>
                                        </td>
                                        <td>
                                            <select class='form-control'></select>
                                        </td>
                                        <td>
                                            <i class="m-r-10 mdi mdi-play" style="font-size:18px;color:darkblue"></i>
                                        </td>
                                        <td>
                                            <select class='form-control'  name="ctgKey"></select>
                                        </td>
                                        <td>
                                            <button type="button" onclick="deleteTableRow('categoryTable1', 'delBtn')" class='btn btn-outline-danger btn-sm delBtn'>삭제</button>
                                        </td>
                                    </tr>

                                    </tbody>
                                </table>
                            </div>
                        </section>
                        <!-- //2.카테고리 목록 Tab -->
                        <!-- 3.쿠폰 소지자 조회 Tab -->
                        <h3>쿠폰 소지자 조회/등록</h3>
                        <section>
                            <div class="form-group row">
                                <label class="col-sm-1 control-label col-form-label" style="margin-bottom: 0">쿠폰이름</label>
                                <input type="text" class="col-sm-3 form-control" style="display: inline-block;" id="couponName" name="couponName">
                            </div>
                            <div class="row">
                                <div class="col">
                                    <div class="form-group row">
                                        <label class="col-sm-1 control-label col-form-label" style="margin-bottom: 0">검색어</label><!--0-->
                                        <div class="col-sm-1 pl-0 pr-0 mr-3"><!--0-->
                                            <span id="couponConditionSearch"></span>
                                        </div>
                                        <div class="col-sm-3 pl-0 pr-0 mr-3"><!--0-->
                                            <input type="text" class="form-control" id="searchText" onkeypress="if(event.keyCode==13) {fn_search('new'); return false;}">
                                        </div>
                                        <div class="col-sm-2 pl-0 pr-0 mr-3"><!--0-->
                                            <button type="button" class="btn btn-outline-info mx-auto" onclick="fn_search('new')">검색</button>
                                        </div>
                                        <div class="col-sm-1" style="position:absolute;right: 0"><!--0-->
                                            <button type="button" data-toggle="modal" data-target="#myModal2"   class="offButton btn btn-outline-info mx-auto" onclick="fn_search4('new')">오프라인 쿠폰 조회</button>
                                            <button type="button" data-toggle="modal" data-target="#myModal"   class="btn btn-outline-info mx-auto" onclick="couponProduce()">쿠폰 등록</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <table class="table table-hover text-center">
                                <thead>
                                <tr>
                                    <th scope="col" width="5%">ID</th>
                                    <th scope="col" width="8%">이름</th>
                                    <th scope="col" width="15%">쿠폰번호</th>
                                    <th scope="col" width="10%">발급일자</th>
                                    <th scope="col" width="10%">유효기간</th>
                                    <th scope="col" width="15%">사용날짜</th>
                                </tr>
                                </thead>
                                <tbody id="dataList"></tbody>
                                <tr>
                                    <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
                                </tr>
                            </table>
                            <%@ include file="/common/inc/com_pageNavi.inc" %>
                        </section>
                        <!-- //3.쿠폰 소지자 조회 Tab -->
                        <div style="position:absolute;left:2.5%;bottom:-30px;z-index:99">
                            <button type="button" class="btn btn-outline-info" onclick="goCouponList()">목록</button>
                        </div>

                    </div>
                </div>
            </div>
        </div>
        <!-- //div.card -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog" role="document" style="max-width:1200px;max-height: 200px;">
                <div class="modal-content">
                    <input type="hidden" id="popupCouponKey" value="">
                    <input type="hidden" id="pos" value="">
                    <input type="hidden" id="ctgKey" value="">
                    <div class="modal-header">
                        <h5 class="modal-title">쿠폰 등록</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form>
                        <input type="hidden" id="key" value="">
                        <!-- modal body -->
                        <div class="modal-body">
                            <input type="hidden" id="popupType" name="popupType"/>
                            <div class="offline form-group row">
                                <label class="col-sm-2 text-center control-label col-form-label">쿠폰생성</br>(오프라인)</label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control" id="offCoupon" style="width:80%;display: inline-block"> 개 생성
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-7">
                                    <div class="card">
                                        <div class="online searchUpload form-group row">
                                            <span id="userSelect"></span>
                                            <div class="col-sm-4">
                                                <input type="text" class="form-control" id="couponUser">
                                            </div>
                                            <div style="text-align: center;">
                                                <button type="button" class="btn btn-info" style="text-align: center" onclick="fn_search3('new');">검색</button>
                                            </div>
                                        </div>

                                        <table class="online searchUpload table table-hover text-center">
                                            <thead>
                                            <tr>
                                                <th scope="col" width="1%"></th>
                                                <th scope="col" width="13%">ID</th>
                                                <th scope="col" width="13%">이름</th>
                                                <th scope="col" width="20%">휴대전화</th>
                                                <th scope="col" width="12%">직렬</th>
                                                <th scope="col" width="12%">권한</th>
                                                <th scope="col" width="10%"></th>
                                            </tr>
                                            </thead>
                                            <tbody id="dataList3"></tbody>
                                            <tr>
                                                <td id="emptys3" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
                                            </tr>
                                        </table>
                                        <div class="online searchUpload">
                                            <input type="hidden" id="sPage3" >
                                            <%@ include file="/common/inc/com_pageNavi3.inc" %>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-1">
                                    <div class="card">

                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="card">
                                        <table class="online searchUpload table table-hover text-center" style="margin-top:51px" id="userAdd">
                                            <thead>
                                            <tr>
                                                <th scope="col" width="30%">ID</th>
                                                <th scope="col" width="35%">이름</th>
                                                <th scope="col" width="20%">권한</th>
                                                <th scope="col" width="15%"></th>
                                            </tr>
                                            </thead>
                                            <tbody id="selectUserList"></tbody>
                                            <tr>
                                                <td id="selectUserEmptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <div class="online excelUpload form-group row">
                                <label class="col-sm-2 text-center control-label col-form-label">엑셀 업로드</label>
                                <div class="col-md-10">
                                    <div class="custom-file">
                                        <input type="file" class="custom-file-input" id="attachFile"  onchange="getThumbnailPrivew(this,$('#cma_image'))" required>
                                        <span class="custom-file-control custom-file-label"></span>
                                        <div id="cma_image" style="width:30%;max-width:30%;display:none;"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="online form-group row mt-4">
                                <div class="col-sm-10">
                                    <div style="margin-top: -23px;">
                                        회원검색
                                        <label class="switch">
                                            <input type="checkbox" id="userSearchType" name="userSearchType" style="display:none;">
                                            <span class="slider"></span>
                                        </label>
                                        엑셀업로드
                                    </div>
                                </div>
                            </div>
                            <div style="text-align: center;">
                                <button type="button" class="btn btn-info" style="text-align: center" onclick="modify();">등록</button>
                            </div>
                        </div>
                        <!-- //modal body -->
                    </form>
                </div>
            </div>
        </div>
        <div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog" role="document" style="max-width:1200px;max-height: 200px;">
                <div class="modal-content">
                    <input type="hidden" id="popupCouponKey2" value="">
                    <div class="modal-header">
                        <h5 class="modal-title">오프라인 쿠폰 조회</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        </br>
                        <h7 class="modal-title">미사용 오프라인 쿠폰 리스트입니다.</h7>
                    </div>
                    <form>
                        <!-- modal body -->
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="card">
                                        <table class="offline searchUpload table table-hover text-center">
                                            <thead>
                                            <tr>
                                                <th scope="col" width="70%">쿠폰 코드</th>
                                                <th scope="col" width="30%">쿠폰 생성 날짜</th>
                                            </tr>
                                            </thead>
                                            <tbody id="dataList4"></tbody>
                                            <tr>
                                                <td id="emptys4" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
                                            </tr>
                                        </table>
                                        <div class="online searchUpload">
                                            <input type="hidden" id="sPage4" >
                                            <%@ include file="/common/inc/com_pageNavi4.inc" %>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- //modal body -->
                    </form>
                </div>
            </div>
        </div>
    </div>
</form><!-- // 기본소스-->

<!-- End Container fluid  -->
<%@include file="/common/jsp/footer.jsp" %>
<script>
    // Basic Example with form
    var form = $("#playForm");
    form.children("div").steps({
        headerTag: "h3",
        bodyTag: "section",
        enableAllSteps: true,
        startIndex : 0,
        saveState : true, //현재 단계 쿠키저장
        enablePagination : true,
        onFinished: function(event, currentIndex) {
            couponSave();
        },
    });

    $('#indate').datepicker({
        format: "yyyy-mm-dd",
        language: "kr"
    });

    $('#startDate').datepicker({
        format: "yyyy-mm-dd",
        language: "kr"
    });
    $('#endDate').datepicker({
        format: "yyyy-mm-dd",
        language: "kr"
    });
</script>

<%@include file="/common/jsp/footer.jsp" %>
