<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<%
    String popupKey = request.getParameter("param_key");
%>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/popupCouponManageService.js'></script>
<script type='text/javascript' src='/dwr/interface/dataManageService.js'></script>
<script type='text/javascript' src='/dwr/interface/productManageService.js'></script>
<script>
    var popupKey = '<%=popupKey%>';

    function init() {
        $('textarea[name=contents]').summernote({ //기본정보-에디터
            height: 250,
            minHeight: null,
            maxHeight: null,
            focus: false,
            lang: 'ko-KR',
            placeholder: '내용을 적어주세요.'
            ,hint: {
                match: /:([\-+\w]+)$/,
                search: function (keyword, callback) {
                    callback($.grep(emojis, function (item) {
                        return item.indexOf(keyword) === 0;
                    }));
                },
                template: function (item) {
                    var content = emojiUrls[item];
                    return '<img src="' + content + '" width="20" /> :' + item + ':';
                },
                content: function (item) {
                    var url = emojiUrls[item];
                    if (url) {
                        return $('<img />').attr('src', url).css('width', 20)[0];
                    }
                    return '';
                }
            },
            popover: {
                image: [],
                link: [],
                air: []
            }
        });

        //탭 메뉴 색상 변경
        $("#playForm ul").each(function(idx) {
            var ul = $(this);
            ul.find("li").addClass("done").attr("aria-selected", "false");
            ul.find("li").eq(0).removeClass("done").attr("aria-selected", "true");
        });
        menuActive('menu-4', 1);
        getTimeHourSelectbox("acceptStartHour", "");
        getTimeHourSelectbox("acceptEndHour", "");
        getTimeMinuteSelectbox("acceptStartMinute", "");
        getTimeMinuteSelectbox("acceptEndMinute", "");
        /*카테고리*/
        getNewCategoryList("sel_category","214",'1183');
        getCategoryNoTag2('categoryTable1','1183', '3');
        /*카테고리*/

        /* 패키시상품 정보 가져오기 */
        popupCouponManageService.getPopupDetailInfo(popupKey, function(info) {
            var result = info.result;

            innerHTML("code", result.popupKey);
            innerValue("name", result.name);
            $("#startDate").datepicker("setDate", split_minute_getDay(result.startDate));
            $("#endDate").datepicker("setDate", split_minute_getDay(result.endDate));
            innerValue("height", result.height);
            innerValue("width", result.width);
            innerValue("x", result.x);
            innerValue("y", result.y);
            isCheckboxByNumber("isShow", result.isShow);//노출
            $("#contents").summernote("code", result.contents);
            split_HH_getTime(result.startDate, "timeHour", 0);

            split_MM_getTime(result.startDate, "timeMinute", 0);
            split_HH_getTime(result.endDate, "timeHour", 1);
            split_MM_getTime(result.endDate, "timeMinute", 1);
            /**
             * 카테고리 정보 가져오기
             */
            var resultList = info.resultList;

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
                    var delBtn = "<input type='button' onclick='deleteCategory("+ resultList[i].linkKey +");' class='btn btn-outline-danger btn-sm' value='삭제'>";
                    var categoryList =  resultList[i].categoryList;
                    var cellData = [
                        function() {return "<input type='hidden' name='inputCtgKey[]' value='"+ categoryList[0].ctgKey +"'>";},
                        //function() {return "지안에듀";},
                        //function() {return nextIcon},
                        //function() {return categoryList[2].name;},
                        //function() {return nextIcon},
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

    function deleteCategory(linkKey){
        if(confirm("삭제하시겠습니까?")) {
            productManageService.deleteVideoOtherInfo(linkKey, 'POPUP',function () {isReloadPage();});
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

    function popupSave() {
        var basicObj = getJsonObjectFromDiv("section1");

        if (basicObj.isShow == 'on') basicObj.isShow = '1';//노출 checkbox
        else basicObj.isShow = '0';

        var timeHour    = 0;
        var timeHour1   = 0;
        var timeMinute  = 0;
        var timeMinute1 = 0;

        if($('select[name=timeHour]').eq(0).val() == null) timeHour = "00";
        else timeHour = $('select[name=timeHour]').eq(0).val();

        if($('select[name=timeMinute]').eq(0).val()  == null) timeMinute = "00";
        else timeMinute = $('select[name=timeMinute]').eq(0).val();

        if($('select[name=timeHour]').eq(1).val()  == null) timeHour1 = "00";
        else timeHour1 = $('select[name=timeHour]').eq(1).val();

        if($('select[name=timeMinute]').eq(1).val()  == null) timeMinute1 = "00";
        else timeMinute1 = $('select[name=timeMinute]').eq(1).val();


        basicObj.startDate = basicObj.startDate+" "+timeHour+":"+timeMinute+":"+"00";
        basicObj.endDate   = basicObj.endDate+" "+timeHour1+":"+timeMinute1+":"+"00";

        var categoryArr = new Array();
        $('#categoryTable1 tbody tr').each(function (index) {
            var ctgKeys = get_array_values_by_name("input", "inputCtgKey1[]");
                categoryArr.push(Number(ctgKeys));
        });

       if(confirm("수정 하시겠습니까?")) {
            var ctgkey = $("#categoryList1").find("tr").eq(0).find("td select").eq(1).val();
            if(ctgkey != "") {
                popupCouponManageService.updatePopupCategoryInfo(popupKey, categoryArr, function () {});
            }
            popupCouponManageService.updatePopupInfo(basicObj, function () {isReloadPage(true);});
        }
    }

    function isSizeChk(px, id) {
        if(px == 0 || px > 1280) $("#"+id).addClass('is-invalid');
        else $("#"+id).removeClass('is-invalid');
    }
</script>
<div class="page-breadcrumb">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">팝업수정</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">팝업 관리</li>
                        <li class="breadcrumb-item active" aria-current="page">팝업수정</li>
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
                                <input type="hidden" name="popupKey" value="<%=popupKey%>">
                                <input type="hidden" name="cKey" value="0">
                                <input type="hidden" name="type" value="0">
                                <div class="col-md-12">
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">코드</label>
                                        <span id="code">0</span>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">제목</label>
                                        <input type="text" class="col-sm-6 form-control" style="display: inline-block;" id="name" name="name">
                                    </div>
                                    <div class="form-group row mt-4">
                                        <label class="col-sm-2 text-left control-label col-form-label"  style="margin-bottom: 0">노출</label>
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
                                        <label class="col-sm-2 control-label col-form-label  mt-4" style="margin-bottom: 0">사이즈</label>
                                        <div class="col-sm-8 pl-0 pr-0">
                                            <div class="col-sm-7 input-group pl-0 pr-0">
                                                <label class="col-sm-2 control-label col-form-label"  style="margin-bottom: 0">Width : </label>
                                                <input type="number" class="col-sm-6 form-control" onkeyup="isSizeChk(this.value, 'width');" id="width"  name="width" value="0">
                                                <span style="vertical-align: middle;margin-left:5px">px</span>
                                                <span class="invalid-feedback">1이상 1280이하로 입력해야 합니다.</span>
                                            </div>
                                            <div class="col-sm-7 input-group pl-0 pr-0">
                                                <label class="col-sm-2 control-label col-form-label"  style="margin-bottom: 0">Height : </label>
                                                <input type="number" class="col-sm-6 form-control" onkeyup="isSizeChk(this.value, 'height');" id="height"  name="height" value="0">
                                                <span style="vertical-align: middle;margin-left:5px">px</span>
                                                <span class="invalid-feedback">1이상 1280이하로 입력해야 합니다.</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label  mt-4" style="margin-bottom: 0">위치</label>
                                        <div class="col-sm-8 pl-0 pr-0">
                                            <div class="col-sm-7 input-group pl-0 pr-0">
                                                <label class="col-sm-2 control-label col-form-label"  style="margin-bottom: 0">Left : </label>
                                                <input type="number" class="col-sm-6 form-control" value="0" name="x" id="x">
                                                <span style="vertical-align: middle;margin-left:5px">px</span>
                                            </div>
                                            <div class="col-sm-7 input-group pl-0 pr-0">
                                                <label class="col-sm-2 control-label col-form-label"  style="margin-bottom: 0">Top : </label>
                                                <input type="number" class="col-sm-6 form-control" value="0" name="y"  id="y">
                                                <span style="vertical-align: middle;margin-left:5px">px</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label  mt-4" style="margin-bottom: 0">노출시간</label>
                                        <div class="col-sm-8 pl-0 pr-0">
                                            <div class="col-sm-8 input-group pl-0 pr-0">
                                                <input type="text" class="form-control mydatepicker" placeholder="yyyy-mm-dd" name="startDate" id="startDate">
                                                <div class="input-group-append">
                                                    <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                                </div>&nbsp;
                                                <span id="acceptStartHour"></span><span class="pt-2">시</span><span id="acceptStartMinute"></span><span class="pt-2">분</span>&nbsp;&nbsp;&nbsp;<span class="pt-2">에서</span>
                                            </div>
                                            <div class="col-sm-8 input-group pl-0 pr-0">
                                                <input type="text" class="form-control mydatepicker" placeholder="yyyy-mm-dd" name="endDate" id="endDate">
                                                <div class="input-group-append">
                                                    <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                                </div>&nbsp;
                                                <span id="acceptEndHour"></span><span class="pt-2">시</span><span id="acceptEndMinute"></span><span class="pt-2">분</span>&nbsp;&nbsp;&nbsp;<span class="pt-2">까지</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-form-label">상세설명</label>
                                        <div>
                                            <textarea value="" id="contents" name="contents"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>
                        <!-- // 1.기본정보 Tab -->
                        <!-- 3.카테고리 목록 Tab -->
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
                        <!-- //3.카테고리 목록 Tab -->
                    </div>
                </div>
            </div>
        </div>
        <!-- //div.card -->
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
            popupSave();
        },
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
