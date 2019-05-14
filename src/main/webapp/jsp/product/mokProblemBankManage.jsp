<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/productManageService.js'></script>
<script>
    function init() {
        menuActive('menu-1', 12);
        getMockYearSelectbox("l_examYearGroup","");//출제년도
        getSelectboxListdivisionCtgKey("l_examType", 4390, "");//출제구분
        getNewSelectboxListForCtgKey2("l_subjectGroup", "70", "");//과목
        getAnswerSelectbox("l_answerType", "");//정답
        getExamLevelSelectbox("l_examLevel", "");//난이도

        getSelectboxstepCtgKey("typeTable", 4392, 0);//유형
        getSelectboxstepCtgKey("patternTable", 4404, 0);//패턴
        getSelectboxstepCtgKey("unitTable", 4405, 0);//단원
    }
    
    function mockProblemBankSave() {
        var data = new FormData();

        $.each($('#questionImage')[0].files, function(i, file) {
            data.append('questionImage', file);
        });

        $.each($('#commentaryImage')[0].files, function(i, file) {
            data.append('commentaryImage', file);
        });

        data.append('uploadType', 'QUESTION_BANK');

        if(confirm("저장하시겠습니까?")) {
            $.ajax({
                url: "/file/imageFileUpload",
                method: "post",
                dataType: "JSON",
                data: data,
                cache: false,
                processData: false,
                contentType: false,
                success: function (data) {
                    if(data.result){
                        var basicObj = getJsonObjectFromDiv("section1");

                        $('#typeTable tbody tr').each(function(index){//유형
                            var ctgKey = $(this).find("td select").eq(1).val();
                            basicObj.stepCtgKey = ctgKey;
                        });

                        $('#patternTable tbody tr').each(function(index){//패턴
                            var ctgKey = $(this).find("td select").eq(1).val();
                            basicObj.patternCtgKey = ctgKey;
                        });

                        $('#unitTable tbody tr').each(function(index){//단원
                            var ctgKey = $(this).find("td select").eq(2).val();
                            basicObj.unitCtgKey = ctgKey;
                        });


                        basicObj.questionImage = data.result.questionImagePath;
                        basicObj.commentaryImage = data.result.commentaryImagePath;

                        productManageService.upsultProblemBank(basicObj, function () {
                             isReloadPage(true);
                         });

                    }
                }
            });
        }
    }

    //유형 셀렉트박스 변경 시
    function changeExamUnit(val,tableId , tdNum) {
        getSelectboxstepCtgKey(tableId, val, tdNum);//단원
    }
    /*문제,해설 이미지파일 미리보기 */
    $(document).ready(function() {
        function readURL(input, tagId) {
            if (input.files && input.files[0]) {
                var reader = new FileReader(); //파일을 읽기 위한 FileReader객체 생성
                 reader.onload = function (e) {
                       $('#'+tagId).attr('src', e.target.result);
                       $("#"+tagId).show();
                 }
                 reader.readAsDataURL(input.files[0]);
                }
        }
         $("#questionImage").change(function(){
             readURL(this, 'QuestionBlah');
         });
        $("#commentaryImage").change(function(){
            readURL(this, 'commentaryBlah');
        });
    });

</script>
<div class="page-breadcrumb">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">모의고사 문제은행 신규 등록</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">상품관리</li>
                        <li class="breadcrumb-item active" aria-current="page">모의고사 문제은행 신규 등록</li>
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
                                <input type="hidden" value="0" name="examQuestionBankKey">
                                <input type="hidden" value="" name="bookImage">
                                <input type="hidden" value="" name="answer1Reason">
                                <input type="hidden" value="" name="answer2Reason">
                                <input type="hidden" value="" name="answer3Reason">
                                <input type="hidden" value="" name="answer4Reason">
                                <input type="hidden" value="" name="answer5Reason">
                                <input type="hidden" value="" name="tag">
                                <div class="col-md-12">
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">문제 이미지</label>
                                        <div class="col-sm-6 pl-0 pr-0">
                                            <div class="custom-file">
                                                <input type="file" class="custom-file-input" id="questionImage"  name="questionImage" required>
                                                <span class="custom-file-control custom-file-label"></span>
                                            </div>
                                            <img id="QuestionBlah" src="#"  style="display: none"/>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">해설 이미지</label>
                                        <div class="col-sm-6 pl-0 pr-0">
                                            <div class="custom-file">
                                                <input type="file" class="custom-file-input addFile" id="commentaryImage" name="commentaryImage" required>
                                                <span class="custom-file-control1 custom-file-label"></span>
                                            </div>
                                            <img id="commentaryBlah" src="#" style="display: none" />
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">노출날짜</label>
                                        <div class="col-sm-6 input-group pl-0 pr-0">
                                            <input type="text" class="form-control mydatepicker" placeholder="yyyy-mm-dd" name="dspDate" id="dspDate">
                                            <div class="input-group-append">
                                                <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                            </div>
                                            <span style="display: block;padding-top:5px">암기노트등, 출력날짜가 필요할때만 사용</span>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">출제구분</label>
                                        <div class="col-sm-6 pl-0 pr-0">
                                            <span id="l_examType"></span>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">출제년도</label>
                                        <div class="col-sm-6 pl-0 pr-0">
                                            <span id="l_examYearGroup"></span>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">과목코드</label>
                                        <input type="text" class="col-sm-6 form-control" style="display: inline-block;" id="subjectCode" name="subjectCode">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">과목선택</label>
                                        <div class="col-sm-6 pl-0 pr-0">
                                            <span id="l_subjectGroup"></span>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">정답</label>
                                        <div class="col-sm-6 pl-0 pr-0">
                                            <span id="l_answerType"></span>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">난이도</label>
                                        <div class="col-sm-6 pl-0 pr-0">
                                            <span id="l_examLevel"></span>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">유형</label>
                                        <div class="col-sm-6 pl-0 pr-0">
                                            <table id="typeTable">
                                                <tbody id="typeSelList">
                                                <td><!--옵션명selbox-->
                                                    <select class='form-control'  id='sel_type' onchange="changeExamUnit('typeTable', this.value, 1);">
                                                    </select>
                                                </td>
                                                <td>
                                                    <select class='form-control'></select>
                                                </td>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">패턴</label>
                                        <div class="col-sm-6 pl-0 pr-0">
                                            <table id="patternTable">
                                                <tbody id="patternSelList">
                                                    <td><!--옵션명selbox-->
                                                        <select class='form-control'  id='sel_pattern' onchange="changeExamUnit('patternTable', this.value, 1);">
                                                        </select>
                                                    </td>
                                                    <td>
                                                        <select class='form-control'></select>
                                                    </td>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">단원</label>
                                        <div class="col-sm-6 pl-0 pr-0">
                                            <table id="unitTable">
                                                <tbody id="unitSelList">
                                                <td><!--옵션명selbox-->
                                                    <select class='form-control'  id='sel_unit' onchange="changeExamUnit('unitTable', this.value, 1);">
                                                    </select>
                                                </td>
                                                <td>
                                                    <select class='form-control'></select>
                                                </td>
                                                <td>
                                                    <select class='form-control'></select>
                                                </td>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">해설강의 링크</label>
                                        <input type="text" class="col-sm-6 form-control" style="display: inline-block;" id="commentaryUrl" name="commentaryUrl">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">총평</label>
                                        <input type="text" class="col-sm-6 form-control" style="display: inline-block;" id="review" name="review">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">1번 선택 이유</label>
                                        <input type="text" class="col-sm-6 form-control" style="display: inline-block;height: 100px;" id="answer1Reason" name="answer1Reason">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">2번 선택 이유</label>
                                        <input type="text" class="col-sm-6 form-control" style="display: inline-block;height: 100px;" id="answer2Reason" name="answer2Reason">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">3번 선택 이유</label>
                                        <input type="text" class="col-sm-6 form-control" style="display: inline-block;height: 100px;" id="answer3Reason" name="answer3Reason">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">4번 선택 이유</label>
                                        <input type="text" class="col-sm-6 form-control" style="display: inline-block;height: 100px;" id="answer4Reason" name="answer4Reason">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">5번 선택 이유</label>
                                        <input type="text" class="col-sm-6 form-control" style="display: inline-block;height: 100px;" id="answer5Reason" name="answer5Reason">
                                    </div>

                                    <button type="button" class="btn btn-info float-right m-l-2" onclick="mockProblemBankSave();">저장</button>
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

    $('#dspDate').datepicker({
        format: "yyyy-mm-dd",
        language: "kr",
        numberOfMonths: [2,3]
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
