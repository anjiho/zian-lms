<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/productManageService.js'></script>
<script type='text/javascript' src='/dwr/interface/selectboxService.js'></script>

<script>
    $( document ).ready(function() {
        getVideoOptionTypeList("videoOptionSel_0","");
        getCategoryList("sel_1","214");
        getSelectboxListForCtgKey("set_1","4309");//급수 셀렉트박스
        getSelectboxListForCtgKey("set_2","70");//과목 셀렉트박스
        getSelectboxListForCtgKey("set_3","202");//유형 셀렉트박스
        getSelectboxListForCtgKey("SubjectList","70");//과목 셀렉트박스
        selectTeacherSelectbox("teacherList","");//선생님 셀렉트박스

        $('#summernote').summernote({ //기본정보-에디터
            width: 750,
            height: 300,
            focus: true,
            theme: 'cerulean'
        });
    });

    function changesel(id, val){ //카테고리 셀렉트박스 불러오기
        var idNum = 0;
        if (id != undefined) {
            var split = gfn_split(id, "_");
            var idNum = "sel_" + (Number(split[1]) + 1) ;
        }
        getCategoryList(idNum, val);
    }

    function optionDelete() {
        $('#optionTable > tbody:last > tr:last').remove();
    }
    
    function addOption(){ //옵션명 추가
        var optionCnt = $("#optionTable tr").length-1;
        var getOption = "videoOptionSel_"+optionCnt;
        getVideoOptionTypeList(getOption, "");
        var optionHtml = "<tr>";
                optionHtml += "<td style=\"padding: 0.3rem;text-align: center;\">";
                    optionHtml += "<select class=\"select2 form-control custom-select\" style=\"height:36px;\" id='videoOptionSel_"+optionCnt+"'>";
                        optionHtml += "<option>선택</option>";
                    optionHtml += "</select>";
                optionHtml += "</td>";
                    optionHtml += "<td style=\"padding: 0.3rem;\">";
                    optionHtml += "<input type=\"text\" class=\"form-control\">";
                optionHtml += "</td>";
                    optionHtml += "<td style=\"padding: 0.3rem;\">";
                    optionHtml += "<input type=\"text\" class=\"form-control\">";
                optionHtml += "</td>";
                optionHtml += " <td style=\"padding: 0.3rem;\">";
                    optionHtml += "<input type=\"text\" style=\"display: inline-block\" class=\"form-control\">";
                optionHtml += "</td>";
                optionHtml += " <td style=\"padding: 0.3rem;\">";
                     optionHtml += "<input type=\"text\" style=\"display: inline-block\" class=\"form-control\">";
                optionHtml += "</td>";
                optionHtml += "<td style=\"padding: 0.3rem;\">";
                    optionHtml += " <input type=\"text\" class=\"form-control\">";
                optionHtml += "</td>";
                optionHtml += " <td style=\"padding: 0.3rem;\">";
                    optionHtml += "<button type=\"button\" onclick=\"optionDelete()\" class=\"btn btn-danger btn-sm\" style=\"margin-top:8%;\">삭제</button>";
                optionHtml += "</a>";
                optionHtml += "</td>";
        optionHtml += "</tr>";
            $('#optionTable > tbody:first').append(optionHtml);
    }

    //파일 선택시 파일명 보이게 하기
    $(document).on('change', '.custom-file-input', function() {
        $(this).parent().find('.custom-file-control').html($(this).val().replace(/C:\\fakepath\\/i, ''));
    });
    $(document).on('change', '.addFile', function() {
        $(this).parent().find('.custom-file-control1').html($(this).val().replace(/C:\\fakepath\\/i, ''));
    });
</script>
<div class="page-breadcrumb">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">동영상 등록</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">상품관리</li>
                        <li class="breadcrumb-item active" aria-current="page">동영상상품관리</li>
                        <li class="breadcrumb-item active" aria-current="page">동영상 등록</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</div>
<!--//순서-->

<!-- 기본 소스-->
<div class="container-fluid">
    <div class="card">
        <div class="card-body wizard-content">
            <h4 class="card-title"></h4>
            <h6 class="card-subtitle"></h6>
            <div id="playForm" naem="frm" method="" action="" class="m-t-40">
                <div>
                    <!-- 1.기본정보 Tab -->
                    <h3>기본정보</h3>
                    <section class="col-md-6">
                        <div class="form-group">
                            <label class="control-label col-form-label" style="margin-bottom: 0">상품타입</label>
                            <input type="text" class="form-control" id="scheduleKey" value="온라인강좌" readonly>
                        </div>
                        <div class="form-group">
                            <label for="lname" class="control-label col-form-label" style="margin-bottom: 0">이름</label>
                            <input type="text" class="form-control" id="lname">
                        </div>
                        <div class="form-group">
                            <label class="control-label col-form-label" style="margin-bottom: 0">등록일</label>
                            <div class="input-group">
                                <input type="text" class="form-control mydatepicker" placeholder="yyyy.mm.dd">
                                <div class="input-group-append">
                                    <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-form-label" style="margin-bottom: 0">판매시작일</label>
                            <div class="input-group">
                                <input type="text" class="form-control mydatepicker" placeholder="mm/dd/yyyy">
                                <div class="input-group-append">
                                    <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                </div>
                            </div>
                        </div>
                        <div class="form-group row mt-4" style="">
                            <label class="col-sm-2 text-left control-label col-form-label">노출</label>
                            <div class="col-sm-10">
                                <div style="margin-top: -23px;">
                                    OFF
                                    <label class="switch">
                                        <input type="checkbox" id="newPopYn" name="newPopYn" style="display:none;">
                                        <span class="slider"></span>
                                    </label>
                                    ON
                                </div>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 text-left control-label col-form-label">판매</label>
                            <div class="col-sm-10">
                                <div style="margin-top: -23px;">
                                    OFF
                                    <label class="switch">
                                        <input type="checkbox" style="display:none;">
                                        <span class="slider"></span>
                                    </label>
                                    ON
                                </div>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 text-left control-label col-form-label">무료</label>
                            <div class="col-sm-10">
                                <div style="margin-top: -23px;">
                                    OFF
                                    <label class="switch">
                                        <input type="checkbox" style="display:none;">
                                        <span class="slider"></span>
                                    </label>
                                    ON
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-form-label" style="margin-bottom: 0">리스트이미지</label>
                            <div>
                                <div class="custom-file">
                                    <input type="file" class="custom-file-input" id="attachFile"  required>
                                    <span class="custom-file-control custom-file-label"></span>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-form-label" style="margin-bottom: 0">상세이미지</label>
                            <div>
                                <div class="custom-file">
                                    <input type="file" class="custom-file-input addFile" id="attachFile1" required>
                                    <span class="custom-file-control1 custom-file-label"></span>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="control-label col-form-label" style="margin-bottom: 0">강조표시</label>
                            <div>
                                <select class="col-sm-6 select2 form-control custom-select">
                                    <option>없음</option>
                                    <option value="best">BEST</option>
                                    <option value="new">NEW</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-form-label">사은품 배송비 무료</label>
                            <div>
                                <div style="margin-top: -23px;">
                                    OFF
                                    <label class="switch">
                                        <input type="checkbox" style="display:none;">
                                        <span class="slider"></span>
                                    </label>
                                    ON
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-form-label">상세설명</label>
                            <div>
                                <textarea name="content" id="summernote" value=""></textarea>
                            </div>
                        </div>
                    </section>
                    <!-- // 1.기본정보 Tab -->

                    <!-- 2.옵션 Tab -->
                    <h3>옵션</h3>
                    <section>
                        <table class="table" id="optionTable">
                            <thead>
                            <tr style="border-top:0">
                                <th scope="col" style="text-align:center;width:30%">옵션명</th>
                                <th scope="col" style="text-align:center;">원가</th>
                                <th scope="col" style="text-align:center;">판매가</th>
                                <th scope="col" style="text-align:center;">포인트</th>
                                <th scope="col" colspan="2" style="text-align:center;">재수강</th>
                                <th scope="col" style="text-align:center;"></th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td style="padding: 0.3rem;text-align: center;">
                                    <select class="select2 form-control custom-select" style="height:36px;" id="videoOptionSel_0">
                                        <option>선택</option>
                                    </select>
                                </td>
                                <td style="padding: 0.3rem;">
                                    <input type="text" class="form-control">
                                </td>
                                <td style="padding: 0.3rem;">
                                    <input type="text" class="form-control">
                                </td>
                                <td style="padding: 0.3rem;">
                                    <input type="text" class="form-control">
                                </td>
                                <td style="padding: 0.3rem;">
                                    <input type="text" style="display: inline-block" class="form-control">
                                </td>
                                <td style="padding: 0.3rem;">
                                    <input type="text" class="form-control">
                                </td>
                                <td style="padding: 0.3rem;">
                                    <button type="button" onclick="optionDelete();" class="btn btn-danger btn-sm" style="margin-top:8%;">삭제</button>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                        <div class="mx-auto" style="width:5.5%">
                            <button type="button" class="btn btn-outline-info mx-auto" onclick="addOption();">추가</button>
                        </div>
                    </section>
                    <!-- //2.옵션 Tab -->

                    <!-- 3.카테고리 목록 Tab -->
                    <h3>카테고리</h3>
                    <section>
                        <div class="form-group">
                            <label  class="control-label col-form-label" style="margin-bottom: 0">카테고리</label>
                            <div>
                                    <select class="col-sm-2 select2 form-control custom-select" id="sel_1" onchange="changesel(this.id, this.value);">
                                        <option>선택</option>
                                    </select>
                                    <i class="m-r-10 mdi mdi-chevron-right" style="color:darkblue;vertical-align: middle;font-size:28px;"></i>
                                    <select class="col-sm-2 select2 form-control custom-select" id="sel_2"  onchange="changesel(this.id, this.value);">
                                        <option>선택</option>
                                    </select>
                                    <i class="m-r-10 mdi mdi-chevron-right" style="vertical-align: middle;font-size:28px;"></i>
                                    <select class="col-sm-3 select2 form-control custom-select" id="sel_3" onchange="changesel(this.id, this.value);">
                                        <option>선택</option>
                                    </select>
                                    <i class="m-r-10 mdi mdi-chevron-right" style="vertical-align: middle;font-size:28px;"></i>
                                    <select class="col-sm-3 select2 form-control custom-select" id="sel_4" onchange="changesel(this.id, this.value);">
                                        <option>선택</option>
                                </select>
                                <i class="m-r-10 mdi mdi-chevron-right" style="vertical-align: middle;font-size:28px;"></i>
                                <select class="col-sm-3 select2 form-control custom-select" id="sel_5" onchange="changesel(this.id, this.value);">
                                    <option>선택</option>
                                </select>
                            </div>
                        </div>
                    </section>
                    <!-- //3.카테고리 목록 Tab -->

                    <!-- 4.강좌 정보 Tab -->
                    <h3>강좌정보</h3>
                    <section>
                        <div class="form-group">
                            <label class="control-label col-form-label" style="margin-bottom: 0">강좌 CODE</label>
                            <input type="text" class="form-control" value="" readonly>
                        </div>
                        <div class="form-group">
                            <label for="lname" class="col-sm-1 control-label col-form-label" style="margin-bottom: 0">급수</label>
                            <select class="col-sm-6 select2 form-control custom-select" id="set_1">

                            </select>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-1 control-label col-form-label" style="margin-bottom: 0">과목</label>
                            <select class="col-sm-6 select2 form-control custom-select" id="set_2">

                            </select>
                        </div>
                        <div class="form-group">
                            <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">유형</label>
                            <select class="col-sm-6 select2 form-control custom-select" id="set_3">

                            </select>
                        </div>
                        <div class="form-group">
                            <label  class="control-label col-form-label" style="margin-bottom: 0">진행상태</label>
                            <div>
                                <select class="col-sm-6 select2 form-control custom-select">
                                    <option>준비중</option>
                                    <option value="#">진행중</option>
                                    <option value="#">완강</option>
                                    <option value="#">폐강</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-form-label" style="margin-bottom: 0">강좌수</label>
                            <input type="text" class="col-sm-6 form-control" id="" maxlength="4" placeholder="0">
                        </div>
                        <div class="form-group">
                            <label class="control-label col-form-label" style="margin-bottom: 0">수강일수</label>
                            <input type="text" class="col-sm-6 form-control" id="" maxlength="4" placeholder="0">
                        </div>
                        <div class="form-group">
                            <label class="control-label col-form-label" style="margin-bottom: 0">강좌시간</label>
                            <input type="text" class="col-sm-6 form-control" id="" maxlength="4" placeholder="0">
                        </div>
                        <div class="form-group">
                            <label class="control-label col-form-label" style="margin-bottom: 0">배수 <span style="font-size:11px;vertical-align:middle;color:#999;font-weight:500;margin-left:10px">*배수가 0이면 무제한</span></label>
                            <input type="number" class="col-sm-6 form-control" id="" placeholder="2">
                        </div>
                        <div class="form-group">
                            <label  class="control-label col-form-label" style="margin-bottom: 0">진행상태</label>
                            <div>
                                <select class="col-sm-6 select2 form-control custom-select">
                                    <option>준비중</option>
                                    <option value="#">2010</option>
                                    <option value="#">2011</option>
                                    <option value="#">2012</option>
                                    <option value="#">2013</option>
                                    <option value="#">2014</option>
                                    <option value="#">2015</option>
                                    <option value="#">2016</option>
                                    <option value="#">2017</option>
                                    <option value="#">2018</option>
                                    <option value="#">2019</option>
                                    <option value="#">2020</option>
                                </select>
                            </div>
                        </div>
                    </section>
                    <!-- //4.강좌 정보 Tab -->

                    <!-- 5.강사 목록 Tab -->
                    <h3>강사목록</h3>
                    <section>
                        <table class="table">
                            <thead>
                            <tr>
                                <th scope="col" colspan="5" style="text-align:center;width:30%">강사목록</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td style="padding: 0.3rem;text-align: center;width: 20%;vertical-align: middle">
                                    <select class="select2 form-control custom-select" style="height:36px;" id="SubjectList">
                                        <option>선택</option>

                                    </select>
                                </td>
                                <td style="padding: 0.3rem; vertical-align: middle;width:2%;text-align: center;">
                                    <i class="m-r-10 mdi mdi-play" style="font-size:18px;color:darkblue"></i>
                                </td>
                                <td style="padding: 0.3rem;width: 20%">
                                    <select class="select2 form-control custom-select" style="height:36px;" id="teacherList">
                                        <option>선택</option>

                                    </select>
                                </td>
                                <td style="padding: 0.3rem;width:60%;text-align:right;vertical-align: middle">
                                    <label style="display: inline-block">조건 : </label>
                                    <input type="text" class="form-control" style="display: inline-block;width:60%"> %
                                </td>
                                <td style="width:3%;vertical-align: middle">
                                    <a href="#" data-toggle="tooltip" data-placement="top" title="삭제">
                                        <i class="mdi mdi-close"></i>
                                    </a>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                        <div class="mx-auto" style="width:5.5%">
                            <button type="button" class="btn btn-outline-info mx-auto">추가</button>
                        </div>
                    </section>
                    <!-- //5.강사 목록 Tab -->

                    <!-- 6.선택 Tab -->
                    <h3>선택</h3>
                    <section>
                        <input name="acceptTerms" type="checkbox" class="required">
                        <label for="acceptTerms">I agree with the Terms and Conditions.</label>
                    </section>
                    <!-- //6.선택 Tab -->

                    <!-- 7.강의 목록 Tab -->
                    <h3>강의목록</h3>
                    <section>
                        <input id="acceptTerms" name="acceptTerms" type="checkbox" class="required">
                        <label for="acceptTerms">I agree with the Terms and Conditions.</label>
                    </section>
                    <!-- //7.강의 목록 Tab -->
                </div>
            </div>
        </div>
    </div>
    <!-- //div.card -->
</div>
<!-- // 기본소스-->

<!-- 시험일정 추가 팝업창 -->
<div class="modal fade" id="sModal2" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">텍스트 입력</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <!-- modal body -->
            <div class="modal-body">
                <div class="form-group row">
                    <label for="lname" class="col-sm-3 text-right control-label col-form-label">텍스트</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="scode">
                    </div>
                </div>
                <button type="button" class="btn btn-info float-right">확인</button>
            </div>
            <!-- //modal body -->
        </div>
    </div>
</div>
<!-- //시험일정 추가 팝업창 -->1
<!-- End Container fluid  -->
    <%@include file="/common/jsp/footer.jsp" %>
    <script>
        // Basic Example with form
        var form = $("#playForm");
        form.children("div").steps({
            headerTag: "h3",
            bodyTag: "section",
            transitionEffect: "slideLeft",
            /*onStepChanging: function(event, currentIndex, newIndex) {
               // form.validate().settings.ignore = ":disabled,:hidden";
                //return form.valid();
            },
            onFinishing: function(event, currentIndex) {
                //form.validate().settings.ignore = ":disabled";
                //return form.valid();
            },
            onFinished: function(event, currentIndex) {
                //alert("Submitted!");
            }*/
            // aria-selected:"false"
        });


    </script>
<style>

</style>