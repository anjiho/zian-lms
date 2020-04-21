<%@ page import="com.zianedu.lms.utils.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
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
    });

    function init() {
        var currentDay=today();
        innerValue('indate',currentDay);

        //탭 메뉴 색상 변경
        $("#playForm ul").each(function(idx) {
            var ul = $(this);
            ul.find("li").addClass("done").attr("aria-selected", "false");
            ul.find("li").eq(0).removeClass("done").attr("aria-selected", "true");
        });
        menuActive('menu-4', 4);

        /*기본정보*/
        innerValue("name", "");
        innerValue("contents", "");
        innerValue("dcValue", "");
        innerValue("limitPriceMin", ""); //최소 결제 금액
        innerValue("limitDay","");//사용기간설정
        innerValue("startDate","");//사용기간설정
        innerValue("endDate","");//사용기간설정

        isSwitchByNumber("periodType", 0);//지급방식
        isSwitchByNumber("type", 0);//지급방식
        isSwitchByNumber("dcType", 0);//할인설정
        isSwitchByNumber("isShow",0);//노출여부
        deviceSelectbox2('deviceSelect','0');//쿠폰 사용 디바이스 설정

        $('.period01').hide();
        $('.period02').show();
        /*기본정보*/

        /*카테고리*/
        getNewCategoryList("sel_category","214",'1183');
        getCategoryNoTag2('categoryTable1','1183', '3');
        /*카테고리*/

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
            popupCouponManageService.saveCouponInfo(basicObj, categoryArr, function () {goPage('popupCouponManage', 'couponList');});
        }
    }

    //쿠폰 등록 팝업

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
                    </div>
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
