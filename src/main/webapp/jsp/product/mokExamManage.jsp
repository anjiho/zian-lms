<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/productManageService.js'></script>
<script>
    function init() {
        menuActive('menu-1', 8);

        getNewSelectboxListForCtgKey("l_classGroup", "4309", "");//급수
        getNewSelectboxListForCtgKey2("l_subjectGroup", "70", "");//과목
        getMockCategoryList("l_Classification","");//분류
        getMockYearSelectbox("l_examYearGroup","");//출제년도

        getTimeHourSelectbox("acceptStartHour",0);
        getTimeHourSelectbox("acceptEndHour",0);
        getTimeHourSelectbox("onlineStartHour",0);
        getTimeHourSelectbox("onlineEndHour",0);

        getTimeMinuteSelectbox("acceptStartMinute",24);
        getTimeMinuteSelectbox("acceptEndMinute",24);
        getTimeMinuteSelectbox("onlineStartMinute",24);
        getTimeMinuteSelectbox("onlineEndMinute",24);
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

        if(confirm("저장 하시겠습니까?")) {
            productManageService.upsultMokExamInfo(mockInfoObj, function () {
                //isReloadPage(true);
            });
        }
    }
</script>
<input type="hidden" name="sPage3" id="sPage3">
<div class="page-breadcrumb">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">모의고사 등록</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">상품관리</li>
                        <li class="breadcrumb-item active" aria-current="page">모의고사 등록</li>
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
                        <section class="col-md-auto">
                            <div id="section1">
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
                                        <label class="col-sm-2 control-label col-form-label  mt-4" style="margin-bottom: 0">시험 신청기간</label>
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
                                        <label class="col-sm-2 control-label col-form-label mt-4" style="margin-bottom: 0">온라인 시험기간</label>
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
                                        <div class="col-sm-6 input-group pl-0 pr-0">
                                            <input type="text" class="form-control mydatepicker" placeholder="mm/dd/yyyy" name="offlineDate" id="offlineDate">
                                            <div class="input-group-append">
                                                <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                            </div>
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
                                    <button type="button" class="btn btn-info float-right m-l-2" onclick="mockExamSave();">저장</button>
                                </div>
                            </div>
                        </section>
                    </div>
                </div>
            </div>
        </div>
        <!-- //div.card -->
    </div>
</form>
<!-- End Container fluid  -->
<%@include file="/common/jsp/footer.jsp" %>
<script>
    // Basic Example with form

    $('#indate').datepicker({
        format: "yyyy-mm-dd",
        language: "kr",
        numberOfMonths: [2,3]
    });

    $('#acceptStartDate,#acceptEndDate').datepicker({
        format: "yyyy-mm-dd",
        language: "kr",
        numberOfMonths: [2,3]
    });
    $('#onlineStartDate ').datepicker({
        format: "yyyy-mm-dd",
        language: "kr",
        numberOfMonths: [2,2]
    });
    $('#onlineEndDate').datepicker({
        format: "yyyy-mm-dd",
        language: "kr"
    });
    $('#offlineDate').datepicker({
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
</script>

<%@include file="/common/jsp/footer.jsp" %>
