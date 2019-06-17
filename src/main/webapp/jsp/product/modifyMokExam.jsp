<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<%
    String examKey = request.getParameter("param_key");
%>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/productManageService.js'></script>
<script>
    var examKey = '<%=examKey%>';

    function init() {
        menuActive('menu-1', 7);
        getProductSearchTypeSelectbox("l_productSearch");
        getNewSelectboxListForCtgKey("l_classGroup", "4309", "");//급수
        getNewSelectboxListForCtgKey2("l_subjectGroup", "70", "");//과목
        getMockCategoryList("l_Classification","");//분류
        getMockYearSelectbox("l_examYearGroup","");//출제년도

        getTimeHourSelectbox("acceptStartHour",0);
        getTimeHourSelectbox("acceptEndHour",0);
        getTimeHourSelectbox("onlineStartHour",0);
        getTimeHourSelectbox("onlineEndHour",0)
        getTimeHourSelectbox("offlineHour",0);

        getTimeMinuteSelectbox("acceptStartMinute",24);
        getTimeMinuteSelectbox("acceptEndMinute",24);
        getTimeMinuteSelectbox("onlineStartMinute",24);
        getTimeMinuteSelectbox("onlineEndMinute",24);
        getTimeMinuteSelectbox("offlineMinute",24);
        //탭 메뉴 색상 변경
        $("#playForm ul").each(function(idx) {
            var ul = $(this);
            ul.find("li").addClass("done").attr("aria-selected", "false");
            ul.find("li").eq(0).removeClass("done").attr("aria-selected", "true");
        });

        /* 모의고사 정보 가져오기 */
        productManageService.getMockExamInfo(examKey, function(info) {
            console.log(info);
            var mokExamInfo = info.mokExamInfo;
            innerValue("name", mokExamInfo.name);
            isCheckboxByNumber("isRealFree", mokExamInfo.isRealFree);//노출
            isCheckboxByNumber("isGichul", mokExamInfo.isGichul);//판매
            isCheckboxByNumber("isShowFiles", mokExamInfo.isShowFiles);//무료
            isCheckboxByNumber("isShowStaticTotalRank", mokExamInfo.isShowStaticTotalRank);//판매
            isCheckboxByNumber("isShowStaticTotalAvg", mokExamInfo.isShowStaticTotalAvg);//무료
            getNewSelectboxListForCtgKey("l_classGroup", "4309", mokExamInfo.classGroupCtgKey);//급수
            getNewSelectboxListForCtgKey2("l_subjectGroup", "70", mokExamInfo.subjectCtgKey);//과목
            getMockCategoryList("l_Classification", mokExamInfo.classCtgKey);//분류
            getMockYearSelectbox("l_examYearGroup", mokExamInfo.examYear);//출제년도
            innerValue("indate", split_minute_getDay(mokExamInfo.indate));
            innerValue("acceptStartDate", split_minute_getDay(mokExamInfo.acceptStartDate));
            innerValue("acceptEndDate", split_minute_getDay(mokExamInfo.acceptEndDate));
            innerValue("onlineStartDate", split_minute_getDay(mokExamInfo.onlineStartDate));
            innerValue("onlineEndDate", split_minute_getDay(mokExamInfo.onlineEndDate));
            innerValue("onlineTime", mokExamInfo.onlineTime);//온라인 시험기간
            innerValue("offlineDate", split_minute_getDay(mokExamInfo.offlineDate));//오프라인 시험일
            innerValue("offlineTimePeriod", mokExamInfo.offlineTimePeriod);//오프라인 모의고사 시간 (표시용)
            innerValue("offlineTimePlace", mokExamInfo.offlineTimePlace);//오프라인 모의고사 시험 장소 (표시용)
            innerValue("selectSubjectCount", mokExamInfo.selectSubjectCount);//선택과목수
            innerValue("questionCount", mokExamInfo.questionCount);// 과목당 문항수
            innerValue("answerCount", mokExamInfo.answerCount);// 답안수
            split_HH_getTime(mokExamInfo.acceptStartDate, "timeHour", 0);
            split_MM_getTime(mokExamInfo.acceptStartDate, "timeMinute", 0);
            split_HH_getTime(mokExamInfo.acceptEndDate, "timeHour", 1);
            split_MM_getTime(mokExamInfo.acceptEndDate, "timeMinute", 1);
            split_HH_getTime(mokExamInfo.onlineStartDate, "timeHour", 2);
            split_MM_getTime(mokExamInfo.onlineStartDate, "timeMinute", 2);
            split_HH_getTime(mokExamInfo.onlineEndDate, "timeHour", 3);
            split_MM_getTime(mokExamInfo.onlineEndDate, "timeMinute", 3);
            split_HH_getTime(mokExamInfo.offlineDate, "timeHour", 4);//오프라인시험일
            split_MM_getTime(mokExamInfo.offlineDate, "timeMinute", 4);//오프라인시험일

            /* 시험과목 리스트 가져오기 */
            var examSubjectInfo = info.examSubjectInfo;

            if (examSubjectInfo.length == 0) {
                var cellData = [];
                dwr.util.addRows("examSubList", [0], cellData, {escapeHtml: false});
            }else {
                for (var i = 0; i < examSubjectInfo.length; i++) {
                    var cmpList = examSubjectInfo[i];
                    var deleteBtn = '<button type="button" onclick="deletebankInfo(' + cmpList.bankSubjectExamLinkKey + ')"  class="btn btn-outline-danger btn-sm">삭제</button>';
                    var subBankKey    = "<input type='hidden'  value='" + cmpList.examQuestionBankSubjectKey + "' name='bankSubKey[]' >";
                    var bankExamLinkKey    = "<input type='hidden'  value='" + cmpList.bankSubjectExamLinkKey + "' name='bankSubLinkKey[]' >";

                    var check = "";
                    if(Number(cmpList.required) == 1){
                        check = "checked";
                    }

                    var subHtml =  "<div class='col-sm-10'>";
                        subHtml += "<div style=\"margin-top: -23px;\">";
                        subHtml += "ON";
                        subHtml += " <label class=\"switch\">";
                        subHtml += " <input type='checkbox'  name='required'  onchange='updateRequireSubject("+cmpList.bankSubjectExamLinkKey+")'  id='bankSubLinkKey_"+ cmpList.bankSubjectExamLinkKey +"' style='display:none;' "+ check +">";
                        subHtml += "<span class=\"slider\" ></span>";
                        subHtml += "</label>";
                        subHtml += "OFF";
                        subHtml += "</div>";
                        subHtml += "</div>";

                    var cellData = [
                        function() {return cmpList.ctgName},
                        function() {return cmpList.name},
                        function() {return cmpList.questionNumber},
                        function() {return subHtml},
                        function() {return deleteBtn},
                        function() {return subBankKey},
                        function() {return cmpList.required},
                        function() {return bankExamLinkKey},
                    ];
                    dwr.util.addRows("examSubList", [0], cellData, {escapeHtml: false});
                }
                $('#examSubList tr').each(function(){
                    var tr = $(this);
                    tr.children().eq(5).attr("style", "display:none");//bankKey hidden
                    tr.children().eq(6).attr("style", "display:none");//required hidden
                    tr.children().eq(7).attr("style", "display:none");//required hidden
                    tr.children().eq(3).attr("style","text-align: left");
                });
            }
        });
    }

    function deletebankInfo(bankKey) {
        if(confirm("삭제 하시겠습니까?")) {
            productManageService.deleteExamSubject(bankKey, function () {
                if ($("#examSubTable > tbody > tr").length == 1) {
                    $('#examSubTable > tbody:first > tr:first').attr("style", "display:none");
                } else {
                    $('#examSubTable > tbody:last > tr:last').remove();
                }
            });
        }
    }

    function mockExamSave() {
        var mockInfoObj = getJsonObjectFromDiv("section1");
        if(mockInfoObj.isRealFree == 'on')  mockInfoObj.isRealFree = '1'; //주간모의고사
        else mockInfoObj.isRealFree = '0';
        if(mockInfoObj.isGichul == 'on')  mockInfoObj.isGichul = '1';//기출문제
        else mockInfoObj.isGichul = '0';
        if(mockInfoObj.isShowFiles == 'on')  mockInfoObj.isShowFiles = '1';//파일오픈
        else mockInfoObj.isShowFiles = '0';
        if(mockInfoObj.isShowStaticTotalRank == 'on')  mockInfoObj.isShowStaticTotalRank = '1';//랭크보여주기
        else mockInfoObj.isShowStaticTotalRank = '0';
        if(mockInfoObj.isShowStaticTotalAvg == 'on')  mockInfoObj.isShowStaticTotalAvg = '1';//평균보여주기
        else mockInfoObj.isShowStaticTotalAvg = '0';

        mockInfoObj.acceptStartDate = mockInfoObj.acceptStartDate+" "+$('select[name=timeHour]').eq(0).val()+":"+$('select[name=timeMinute]').eq(0).val()+":"+"00";
        mockInfoObj.acceptEndDate   = mockInfoObj.acceptEndDate+" "+$('select[name=timeHour]').eq(1).val()+":"+$('select[name=timeMinute]').eq(1).val()+":"+"00";
        mockInfoObj.onlineStartDate = mockInfoObj.onlineStartDate+" "+$('select[name=timeHour]').eq(2).val()+":"+$('select[name=timeMinute]').eq(2).val()+":"+"00";
        mockInfoObj.onlineEndDate   = mockInfoObj.onlineEndDate+" "+$('select[name=timeHour]').eq(3).val()+":"+$('select[name=timeMinute]').eq(3).val()+":"+"00";

        mockInfoObj.printQuestionFile = "";
        mockInfoObj.printCommentaryFile = "";

        if(confirm("수정 하시겠습니까?")) {
            /*시험과목 저장*/
            var bankSubLinkKey = get_array_values_by_name("input", "bankSubLinkKey[]");
            var bankSubKey = get_array_values_by_name("input", "bankSubKey[]");

            for (var i = 0; i < bankSubLinkKey.length; i++) {
                var isRequired = $("input:checkbox[name='required']").eq(i).is(":checked");//필수과목 체크
                if (isRequired == true) required = '1';
                else required = '0';

                if(bankSubLinkKey[i] == ""){
                    productManageService.saveTBankSubjectExamLink(examKey, bankSubKey[i] ,required, function () {});
                }
            }

            /*기본정보 저장*/
            productManageService.upsultMokExamInfo(mockInfoObj, function () {
                 //isReloadPage(true);
            });
        }
    }

    function updateRequireSubject(key) {
        var required = "";
        if($("#bankSubLinkKey_"+key).is(":checked") == true){
             required = 1;
         }else{
             required = 0;
         }
     /*필수과목 변경 저장*/
        var tBankSubjectExamLinkVOS = {
            bankSubjectExamLinkKey: key,
            required: required
        };
        var array = new Array();
        array.push(tBankSubjectExamLinkVOS);
        productManageService.updateRequireSubject(array, function () {});
    }

    //모의고사 문제은행 과목선택 팝업창 리스트 불러오기
    function fn_search3(val) {
        var paging = new Paging();
        var sPage = $("#sPage3").val();
        var searchType = getSelectboxValue("searchType");
        var searchText = getInputTextValue("productSearchType");

        if(val == "new") {
            sPage = "1";
        }

        dwr.util.removeAllRows("dataList3");
        gfn_emptyView3("H", "");//페이징 예외사항처리
        productManageService.getMockExamQuestionBankSubjectListCount(searchType, searchText, function(cnt) {
            paging.count3(sPage, cnt, '10', '10', comment.blank_list);
            var listNum = ((cnt-1)+1)-((sPage-1)*10); //리스트 넘버링
            productManageService.getMockExamQuestionBankSubjectList(sPage, '10', searchType, searchText, function (selList) {
                if (selList.length > 0) {
                    for (var i = 0; i < selList.length; i++) {
                        var cmpList = selList[i];
                        var bookSelBtn = '<input type="button" onclick="sendChildValue($(this))" value="선택" class="btn btn-outline-info mx-auto"/>';
                        var examQuestionBankSubjectKey = "<input type='hidden' id='bankSubKey[]' value='"+ cmpList.examQuestionBankSubjectKey +"'>";
                        if (cmpList != undefined) {
                            var cellData = [
                                function(data) {return examQuestionBankSubjectKey;},
                                function(data) {return cmpList.ctgName;},
                                function(data) {return cmpList.name;},
                                function(data) {return cmpList.questionNumber;},
                                function(data) {return bookSelBtn;}
                            ];
                            dwr.util.addRows("dataList3", [0], cellData, {escapeHtml: false});
                            $('#dataList3 tr').each(function(){
                                var tr = $(this);
                                tr.children().eq(0).attr("style", "display:none");
                            });
                        }
                    }
                }else{
                    gfn_emptyView3("V", comment.blank_list2);
                }
            });
        });
    }

    function sendChildValue (val) {
        var checkBtn = val;

        var tr = checkBtn.parent().parent();
        var td = tr.children();

        var bankSubKey = td.find("input").val();
        var ctgName = td.eq(1).text();
        var name = td.eq(2).text();
        var questionNumber = td.eq(3).text();

        var bankSubKey1 = get_array_values_by_name("input", "bankSubKey[]");
        if ($.inArray(bankSubKey, bankSubKey1) != '-1') {
            alert("이미 선택된 과목입니다.");
            return;
        }

        var subHtml = "<tr scope='col' colspan='3'>";
        subHtml     += " <td>";
        subHtml     += "<span>" + ctgName + "</span>";
        subHtml     += "<input type='hidden' value='' name='bankSubLinkKey[]'>";
        subHtml     += "<input type='hidden'  value='" + bankSubKey + "' name='bankSubKey[]'>";
        subHtml     += "</td>";
        subHtml     += " <td>";
        subHtml     += "<span>" + name + "</span>";
        subHtml     += "</td>";
        subHtml     += " <td>";
        subHtml     += "<span>" + questionNumber + "</span>";
        subHtml     += "</td>";
        subHtml     += "<td class=\"text-left\">";
        subHtml     += " <div class='col-sm-10'>";
        subHtml     += " <div style=\"margin-top: -23px;\">";
        subHtml     += "ON";
        subHtml     += " <label class=\"switch\">";
        subHtml     += " <input type='checkbox'  name='required'  style='display:none;' >";
        subHtml     += "<span class=\"slider\" ></span>";
        subHtml     += "</label>";
        subHtml     += "OFF";
        subHtml     += "</div>";
        subHtml     += "</div>";
        subHtml     += "</td>";
        subHtml     += " <td>";
        subHtml     += "<button type=\"button\" onclick=\"deleteTableRow('examSubTable', 'delBtn' );\" class=\"btn btn-outline-danger btn-sm delBtn\" style=\"margin-top:8%;\" >삭제</button>";
        subHtml     += "</td>";

        $('#examSubTable > tbody:first').append(subHtml);//선택 모의고사 리스트 뿌리기
        $('#examSubTable tr').each(function(){
            var tr = $(this);
        });
    }

    //테이블 로우 삭제
    function deleteTableRow(tableId) {
        if (tableId == "examSubTable") {
            if ($("#examSubTable > tbody > tr").length == 1) {
                $('#examSubTable > tbody:first > tr:first').attr("style", "display:none");
            } else {
                $('#examSubTable > tbody:last > tr:last').remove();
            }
        }
    }

</script>
<div class="page-breadcrumb">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">모의고사 수정</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">상품관리</li>
                        <li class="breadcrumb-item active" aria-current="page">모의고사 수정</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</div>
<!--//순서-->

<!-- 기본 소스-->
<form id="basic">
    <div class="container-fluid">
        <div class="card">
            <div class="card-body wizard-content">
                <h4 class="card-title"></h4>
                <h6 class="card-subtitle"></h6>
                <div id="playForm" method="" action="" class="m-t-40">
                    <div>
                        <h3>모의고사 정보</h3>
                        <section class="col-md-auto">
                            <div id="section1">
                                <input type="hidden" value="<%=examKey%>" name="examKey">
                                <div class="col-md-12">
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">시험명</label>
                                        <input type="text" class="col-sm-6 form-control" style="display: inline-block;" id="name" name="name">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 text-left control-label col-form-label" style="margin-bottom: 0">빅모의고사</label>
                                        <div class="col-sm-10 pl-0 pr-0 row">
                                            <div class="col-sm-8 pl-0 pr-0">
                                                <div class="row pl-4 pr-0" style="padding-bottom: 20px;">
                                                    <span>주간 모의고사</span>
                                                    <div style="margin-top: -23px;margin-left: 20px;">
                                                        OFF
                                                        <label class="switch">
                                                            <input type="checkbox" id="isRealFree" name="isRealFree" style="display:none;">
                                                            <span class="slider"></span>
                                                        </label>
                                                        ON
                                                    </div>
                                                </div>
                                                <div class="row pl-4 pr-0">
                                                    <span>기출문제</span>
                                                    <div style="margin-top: -23px;margin-left:52px;">
                                                        OFF
                                                        <label class="switch">
                                                            <input type="checkbox" id="isGichul" name="isGichul" style="display:none;">
                                                            <span class="slider"></span>
                                                        </label>
                                                        ON
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label  class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">급수</label>
                                        <div class="col-sm-6 pl-0 pr-0">
                                            <span id="l_classGroup"></span>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label  class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">분류</label>
                                        <div class="col-sm-6 pl-0 pr-0">
                                            <span id="l_Classification"></span>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label  class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">과목</label>
                                        <div class="col-sm-6 pl-0 pr-0">
                                            <span id="l_subjectGroup"></span>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label  class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">출제년도</label>
                                        <div class="col-sm-6 pl-0 pr-0">
                                            <span id="l_examYearGroup"></span>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">등록일</label>
                                        <div class="col-sm-6 input-group pl-0 pr-0">
                                            <input type="text" class="form-control mydatepicker" placeholder="yyyy-mm-dd" name="indate" id="indate">

                                            <div class="input-group-append">
                                                <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">시험 신청기간</label>
                                        <div class="col-sm-8 pl-0 pr-0">
                                            <div class="col-sm-7 input-group pl-0 pr-0">
                                                <input type="text" class="form-control mydatepicker" placeholder="yyyy-mm-dd" name="acceptStartDate" id="acceptStartDate">
                                                <div class="input-group-append">
                                                    <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                                </div>&nbsp;
                                                <span id="acceptStartHour"></span><span class="pt-2">시</span><span id="acceptStartMinute"></span><span class="pt-2">분</span>&nbsp;&nbsp;&nbsp;<span class="pt-2">에서</span>
                                            </div>
                                            <div class="col-sm-7 input-group pl-0 pr-0">
                                                <input type="text" class="form-control mydatepicker" placeholder="yyyy-mm-dd" name="acceptEndDate" id="acceptEndDate">
                                                <div class="input-group-append">
                                                    <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                                </div>&nbsp;
                                                <span id="acceptEndHour"></span><span class="pt-2">시</span><span id="acceptEndMinute"></span><span class="pt-2">분</span>&nbsp;&nbsp;&nbsp;<span class="pt-2">까지</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">온라인 시험기간</label>
                                        <div class="col-sm-8 pl-0 pr-0">
                                            <div class="col-sm-7 input-group pl-0 pr-0">
                                                <input type="text" class="form-control mydatepicker" placeholder="yyyy-mm-dd" name="onlineStartDate" id="onlineStartDate">
                                                <div class="input-group-append">
                                                    <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                                </div>&nbsp;
                                                <span id="onlineStartHour"></span><span class="pt-2">시</span><span id="onlineStartMinute"></span><span class="pt-2">분</span>&nbsp;&nbsp;&nbsp;<span class="pt-2">에서</span>
                                            </div>
                                            <div class="col-sm-7 input-group pl-0 pr-0">
                                                <input type="text" class="form-control mydatepicker" placeholder="yyyy-mm-dd" name="onlineEndDate" id="onlineEndDate">
                                                <div class="input-group-append">
                                                    <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                                </div>&nbsp;
                                                <span id="onlineEndHour"></span><span class="pt-2">시</span><span id="onlineEndMinute"></span><span class="pt-2">분</span>&nbsp;&nbsp;&nbsp;<span class="pt-2">까지</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">온라인 시험기간 (분) </label>
                                        <input type="number" class="col-sm-6 form-control" style="display: inline-block;" id="onlineTime" name="onlineTime">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label"  style="margin-bottom: 0">오프라인 시험일</label>
                                        <div class="col-sm-4 input-group pl-0 pr-0">
                                            <input type="text" class="form-control mydatepicker" placeholder="yyyy-mm-dd" name="offlineDate" id="offlineDate">
                                            <div class="input-group-append">
                                                <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                            </div>&nbsp;
                                            <span id="offlineHour"></span><span class="pt-2">시</span><span id="offlineMinute"></span><span class="pt-2">분</span>
                                        </div>
                                    </div>

                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">오프라인 시험 시간(표시용)</label>
                                        <input type="text" class="col-sm-6 form-control" style="display: inline-block;" id="offlineTimePeriod" name="offlineTimePeriod">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">오프라인 시험 장소</label>
                                        <input type="text" class="col-sm-6 form-control" style="display: inline-block;" id="offlineTimePlace" name="offlineTimePlace">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">선택과목 선택 가능수</label>
                                        <input type="number" class="col-sm-6 form-control" style="display: inline-block;" id="selectSubjectCount" name="selectSubjectCount">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">과목당 문항수</label>
                                        <input type="number" class="col-sm-6 form-control" style="display: inline-block;" id="questionCount" name="questionCount">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">답안수</label>
                                        <input type="number" class="col-sm-6 form-control" style="display: inline-block;" id="answerCount" name="answerCount">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">시험지 파일</label>
                                        <div class="col-sm-6 pl-0 pr-0">
                                            <div class="custom-file">
                                                <input type="file" class="custom-file-input" id="printQuestionFile"  name="printQuestionFile">
                                                <span class="custom-file-control custom-file-label"></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">해설지 파일</label>
                                        <div class="col-sm-6 pl-0 pr-0">
                                            <div class="custom-file">
                                                <input type="file" class="custom-file-input addFile" id="printCommentaryFile" name="printCommentaryFile">
                                                <span class="custom-file-control1 custom-file-label"></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">파일오픈</label>
                                        <div class="col-sm-10">
                                            <div style="margin-top: -23px;" class="col-sm-5">
                                                OFF
                                                <label class="switch">
                                                    <input type="checkbox" style="display:none;" id="isShowFiles" name="isShowFiles">
                                                    <span class="slider"></span>
                                                </label>
                                                ON
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">랭크 보여주기</label>
                                        <div class="col-sm-10">
                                            <div style="margin-top: -23px;" class="col-sm-5">
                                                OFF
                                                <label class="switch">
                                                    <input type="checkbox" style="display:none;" id="isShowStaticTotalRank" name="isShowStaticTotalRank">
                                                    <span class="slider"></span>
                                                </label>
                                                ON
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">평균보여주기</label>
                                        <div class="col-sm-10">
                                            <div style="margin-top: -23px;" class="col-sm-5">
                                                OFF
                                                <label class="switch">
                                                    <input type="checkbox" style="display:none;" id="isShowStaticTotalAvg" name="isShowStaticTotalAvg">
                                                    <span class="slider"></span>
                                                </label>
                                                ON
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>
                        <!-- // 1.기본정보 Tab -->
                        <!-- 2.옵션 Tab -->
                        <h3>시험과목</h3>
                        <section>
                            <div class="mb-3 float-right">
                                <button type="button" class="btn btn-info btn-sm"  data-toggle="modal" data-target="#examSubModal" onclick="fn_search3('new');">추가</button>
                            </div>
                            <table class="table text-center table-hover"  id="examSubTable">
                                <thead>
                                <tr>
                                    <th scope="col" colspan="1" style="width:20%">과목명</th>
                                    <th scope="col" colspan="1" style="width:40%">등록명</th>
                                    <th scope="col" colspan="1" style="width:10%">문제수</th>
                                    <th scope="col" colspan="1" style="width:15%">필수과목</th>
                                    <th scope="col" colspan="1" style="width:7%"></th>
                                </tr>
                                </thead>
                                <tbody id="examSubList">
                                </tbody>
                            </table>
                        </section>
                        <!-- //2.옵션 Tab -->
                    </div>
                </div>
            </div>
        </div>
        <!-- //div.card -->
    </div>
</form>

<!--모의고사 문제은행 과목선택 팝업창-->
<div class="modal fade" id="examSubModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document" style="max-width: 900px">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">모의고사 문제은행 과목선택</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form>
                <!-- modal body -->
                <div class="modal-body">
                    <div style="margin-bottom: 45px;">
                        <div style=" float: left;">
                            <span id="l_productSearch"></span>
                        </div>
                        <div style=" float: left; width: 33%; margin-left: 5px">
                            <input type="text" class="form-control" id="productSearchType" onkeypress="if(event.keyCode==13) {fn_search3('new'); return false;}">
                        </div>
                        <div style=" float: left; width: 33%; margin-left: 5px;">
                            <button type="button" class="btn btn-outline-info mx-auto" onclick="fn_search3('new')">검색</button>
                        </div>
                    </div>
                    <div class="table-responsive  scrollable" style="height:800px;">
                        <input type="hidden" id="sPage3" >
                        <table id="zero_config" class="table table-hover">
                            <thead class="thead-light">
                            <tr>
                                <th style="width:20%">과목</th>
                                <th style="width:45%">이름</th>
                                <th style="width:15%">문제수</th>
                                <th style="width:7%"></th>
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
                <!-- //modal body -->
            </form>
        </div>
    </div>
</div>
<!-- // 기본소스-->
<%@include file="/common/jsp/footer.jsp" %>
<script>
    var form = $("#playForm");
    form.children("div").steps({
        headerTag: "h3",
        bodyTag: "section",
        enableAllSteps: true,
        startIndex : 0,
        saveState : true, //현재 단계 쿠키저장
        enablePagination : true,
        onFinished: function(event, currentIndex) {
            mockExamSave();
        }
    });

    $('#indate').datepicker({
        format: "yyyy-mm-dd",
        language: "kr"
    });
    $('#sellstartdate').datepicker({
        format: "yyyy-mm-dd",
        language: "kr"
    });
    $('#cpdate').datepicker({
        format: "yyyy-mm-dd",
        language: "kr"
    });

    //파일 선택시 파일명 보이게 하기
    $(document).on('change', '.custom-file-input', function() {
        $(this).parent().find('.custom-file-control').html($(this).val().replace(/C:\\fakepath\\/i, ''));
    });
    $(document).on('change', '.addFile', function() {
        $(this).parent().find('.custom-file-control1').html($(this).val().replace(/C:\\fakepath\\/i, ''));
    });
    $(document).on('change', '.PreviewFile', function() {
        $(this).parent().find('.custom-file-control3').html($(this).val().replace(/C:\\fakepath\\/i, ''));
    });

</script>

<%@include file="/common/jsp/footer.jsp" %>
