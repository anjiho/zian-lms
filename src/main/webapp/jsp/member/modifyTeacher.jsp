<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<%
    String userKey = request.getParameter("param_key");
%>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/memberManageService.js'></script>
<script>
    var userKey = '<%=userKey%>';
    function init() {
        menuActive('menu-5', 4);
        getCategoryList("sel_category","214");
        getEmailSelectbox('deliveryUserEmail2', '');//이메일
        getSelectboxListForCtgKey('interestCtgKey0','133', "");
        getwelfareDcPercentSelectBox("welfareDcPercent", "");//teacherGrade
        getAuthoritySelectbox("teacherAuthority","");
        getAuthorityGradeSelectbox("teacherGrade", "");
    }

    $( document ).ready(function() {
        //탭 메뉴 색상 변경
        $("#playForm ul").each(function(idx) {
            var ul = $(this);
            ul.find("li").addClass("done").attr("aria-selected", "false");
            ul.find("li").eq(0).removeClass("done").attr("aria-selected", "true");
        });
    });

    function emailSelChange(val) {
        if(val == '1') $('#InputEmail').val('');
        else $('#InputEmail').val(val);
    }
    //파일 선택시 파일명 보이게 하기
    $(document).on('change', '.addFile', function() {
        $(this).parent().find('.custom-file-control').html($(this).val().replace(/C:\\fakepath\\/i, ''));
    });
    $(document).on('change', '.addFile', function() {
        $(this).parent().find('.custom-file-control1').html($(this).val().replace(/C:\\fakepath\\/i, ''));
    });

    //카테고리 추가 버튼
    function addCategoryInfo() {
        var fistTrStyle = $("#categoryTable tr").eq(0).attr("style");

        if (fistTrStyle == "display:none") {
            $('#categoryTable tr').eq(0).removeAttr("style", null);
        } else {
            var $tableBody = $("#categoryTable").find("tbody"),
                $trLast = $tableBody.find("tr:last"),
                $trNew = $trLast.clone();
            $trLast.after($trNew);

            getCategoryNoTag2('categoryTable','1183', '2');
        }
    }

    //카테코리 셀렉트 박스 변경 시
    function changeCategory(tableId, val, tdNum) {
        if(tdNum == '5') return false;
        getCategoryNoTag2(val, tableId, tdNum);
    }

    //에디터 추가 기능
    $(function() {
        $("#add_field_button").click(function (e) {
            var newProd = $('#prod_form_template')
                .clone()
                .removeClass('hide')
                .removeAttr('id')
                .appendTo('#prod_list');
            $('#prod_list').append(newProd);
            $(newProd).summernote({
                height: 250,
                width: 1300,
                focus: true,
            });
        });
        $('#prod_list textarea').summernote({
            height: 250,
            width: 1300,
            focus: true,
        });
    });
    $(function() {
        $("#add_field_button1").click(function (e) {
            var newProd = $('#prod_form_template1')
                .clone()
                .removeClass('hide')
                .removeAttr('id')
                .appendTo('#prod_list1');
            $('#prod_list1').append(newProd);
            $(newProd).summernote({
                height: 250,
                width: 1300,
                focus: true,
            });
        });
        $('#prod_list1 textarea').summernote({
            height: 250,
            width: 1300,
            focus: true,
        });
    });
</script>
<div class="page-breadcrumb">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">강사정보 수정</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">회원 관리</li>
                        <li class="breadcrumb-item active" aria-current="page">강사정보 수정</li>
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
                        <!-- 1.기본정보 Tab -->
                        <h3>기본정보</h3>
                        <section class="col-md-auto">
                            <div id="section1">
                                <div class="col-md-12">
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">아이디</label>
                                        <input type="text" class="col-sm-2 form-control" style="display: inline-block;" id="userId" name="userId">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">이름</label>
                                        <input type="text" class="col-sm-2 form-control" style="display: inline-block;" id="name" name="name">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">비밀번호</label>
                                        <input type="password" class="col-sm-2 form-control" style="display: inline-block;" id="pwd" name="pwd">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">권한</label>
                                        <div class="col-sm-2 pl-0 pr-0">
                                            <span id="teacherAuthority"></span>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">관리자권한등급</label>
                                        <div class="col-sm-2 pl-0 pr-0">
                                            <span id="teacherGrade"></span>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">등록일</label>
                                        <div class="col-sm-2 input-group pl-0 pr-0">
                                            <input type="text" class="form-control mydatepicker" placeholder="yyyy-mm-dd" name="indate" id="indate">
                                            <div class="input-group-append">
                                                <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">생년월일</label>
                                        <div class="col-sm-2 input-group pl-0 pr-0">
                                            <input type="text" class="form-control mydatepicker" placeholder="yyyy-mm-dd" name="birth" id="birth">
                                            <div class="input-group-append">
                                                <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">휴대전화</label>
                                        <input type="text" class="col-sm-1 form-control" style="display: inline-block;" id="phone1">
                                        -
                                        <input type="text" class="col-sm-1 form-control" style="display: inline-block;" id="phone2">
                                        -
                                        <input type="text" class="col-sm-1 form-control" style="display: inline-block;" id="phone3">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">E-Mail</label>
                                        <input type="text" class="col-sm-2 form-control" id='InputEmail1' style="display: inline-block;">
                                        &nbsp;
                                        @
                                        &nbsp;
                                        <div class="col-lg-5 row">
                                            <input type="text" id="InputEmail" class="col-sm-4 form-control">
                                            <div class="col-sm-7 pl-0 pr-0">
                                                <span id="deliveryUserEmail2"></span>
                                            </div>
                                        </div>
                                    </div>
                                    <!--<div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">E-mail 수신여부</label>
                                        <input type="radio" name="recvEmail"  class="custom-radio" value="1">동의&nbsp;
                                        <input type="radio" name="recvEmail"  class="custom-radio" value="0">동의안함
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">SMS 수신여부</label>
                                        <input type="radio" name="recvSms"  class="custom-radio" value="1">동의&nbsp;
                                        <input type="radio" name="recvSms"  class="custom-radio" value="0">동의안함
                                    </div>-->
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label  mt-4" style="margin-bottom: 0">주소</label>
                                        <div class="col-sm-8 pl-0 pr-0">
                                            <div class="col-sm-7 input-group pl-0 pr-0">
                                                <input type="text" class="col-sm-4 form-control"  id="postcode"  placeholder="우편번호" >
                                                <input type="button" onclick="execDaumPostcode()" class="btn btn-info btn-sm" value="우편번호 찾기">
                                            </div>
                                            <div class="col-sm-7 input-group pl-0 pr-0">
                                                <input type="text" id="roadAddress" class="col-sm-10 form-control" style="display: inline-block;" placeholder="도로명주소">
                                                <input type="text" id="detailAddress" class="col-sm-6 form-control" style="width:100px;" placeholder="상세주소">
                                                <span id="guide" style="color:#999;display:none"></span>
                                            </div>
                                            <div class="col-sm-7 input-group pl-0 pr-0">
                                                <input type="text" id="jibunAddress"  class="col-sm-10 form-control" style="display: inline-block;" placeholder="지번주소">
                                            </div>

                                        </div>
                                    </div>
                                    <!--<div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">복지할인율</label>
                                        <div class="col-sm-2 pl-0 pr-0">
                                            <span id="welfareDcPercent"></span>
                                        </div>
                                    </div>-->
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">준비직렬</label>
                                        <div class="col-sm-2 pl-0 pr-0">
                                            <span id="interestCtgKey0"></span>
                                        </div>
                                    </div>
                                    <button type="button" class="btn btn-info float-right m-l-2" onclick="teacherSave();">저장</button>
                                </div>
                            </div>
                        </section>
                        <!-- // 1.기본정보 Tab -->
                        <!-- 2 강사 정보 -->
                        <h3>강사 정보</h3>
                        <section class="col-md-auto">
                            <div id="section2">
                                <div class="col-md-12">
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">리스트이미지</label>
                                        <div class="col-sm-6 pl-0 pr-0">
                                            <div class="custom-file">
                                                <input type="file" class="custom-file-input" id="imageListFile"  name="imageListFile" required>
                                                <span class="custom-file-control custom-file-label"></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">뷰 이미지</label>
                                        <div class="col-sm-6 pl-0 pr-0">
                                            <div class="custom-file">
                                                <input type="file" class="custom-file-input addFile"  id="imageViewFile" name="imageViewFile" required>
                                                <span class="custom-file-control1 custom-file-label"></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">샘플강의</label>
                                        <input type="text" class="col-sm-3 form-control" style="display: inline-block;" name="writer" id="writer">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">온라인강좌 정산율</label>
                                        <input type="number" class="col-sm-3 form-control" style="display: inline-block;" name="writer" id=""> %
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">오프라인강좌 정산율</label>
                                        <input type="number" class="col-sm-3 form-control" style="display: inline-block;" name="writer" id=""> %
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">인사말</label>
                                        <textarea class="col-sm-6 form-control" style="height: 150px;width: 2000px;"></textarea>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">약력</label>
                                        <textarea class="col-sm-6 form-control" style="height: 150px;width: 2000px;"></textarea>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">저서</label>
                                        <textarea class="col-sm-6 form-control" style="height: 150px;width: 2000px;"></textarea>
                                    </div>
                                </div>
                            </div>
                        </section>
                        <!--// 2 강사 정보 -->
                        <!-- 3.카테고리 목록 Tab -->
                        <h3>강사 카테고리</h3>
                        <section>
                            <div class="float-right mb-3">
                                <button type="button" class="btn btn-info btn-sm" onclick="addCategoryInfo();">추가</button>
                            </div>
                            <div id="section3">
                                <table class="table" id="categoryTable">
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
                                    <tbody id="categoryList">
                                    <tr>
                                        <td><!--옵션명selbox-->
                                            <select class='form-control'  id='sel_category' onchange="getCategoryNoTag2('categoryTable','1183', '2');">
                                            </select>
                                        </td>
                                        <td>
                                            <i class="m-r-10 mdi mdi-play" style="font-size:18px;color:darkblue"></i>
                                        </td>
                                        <td>
                                            <select class='form-control'>
                                            </select>
                                        </td>
                                        <td>
                                            <i class="m-r-10 mdi mdi-play" style="font-size:18px;color:darkblue"></i>
                                        </td>
                                        <td>
                                            <select class='form-control'>
                                            </select>
                                        </td>
                                        <td>
                                            <i class="m-r-10 mdi mdi-play" style="font-size:18px;color:darkblue"></i>
                                        </td>
                                        <td>
                                            <select class='form-control'>
                                            </select>
                                        </td>
                                        <td>
                                            <i class="m-r-10 mdi mdi-play" style="font-size:18px;color:darkblue"></i>
                                        </td>
                                        <td>
                                            <select class='form-control'  name="ctgKey">
                                            </select>
                                        </td>
                                        <td>
                                            <button type="button" onclick="deleteTableRow('categoryTable', 'delBtn')" class='btn btn-outline-danger btn-sm delBtn' style="margin-top:8%;">삭제</button>
                                        </td>
                                    </tr>

                                    </tbody>
                                </table>
                            </div>
                        </section>
                        <!-- //3.카테고리 목록 Tab -->
                        <!-- 2 강사 정보 -->
                        <h3>과목그룹별 설명내용(PC 전용)</h3>
                        <section class="col-md-auto">
                            <div id="section4">
                                <div class="col-md-12">
                                    <label class="control-label col-form-label">과목그룹별 설명내용 (PC 전용)</label>
                                    <button type="button" class="btn btn-outline-secondary" style="float: right;" id="add_field_button">추가</button>
                                    <div id='prod_list'>
                                        <textarea></textarea>
                                    </div>
                                    <div id='prod_form_template'>
                                        <textarea  class="hide"></textarea>
                                        <a class="fas fa-trash-alt" style="color: red"></a>
                                    </div>
                                </div>
                            </div>
                        </section>
                        <!--// 2 강사 정보 -->
                        <h3>과목그룹별 설명내용(Mobile 전용)</h3>
                        <section class="col-md-auto">
                            <div id="section5">
                                <div class="col-md-12">
                                    <label class="control-label col-form-label">과목그룹별 설명내용 (MOBILE 전용)</label>
                                    <button type="button" class="btn btn-outline-secondary" style="float: right;" id="add_field_button1">추가</button>
                                    <div id='prod_list1'>
                                        <textarea></textarea>
                                    </div>
                                    <textarea id='prod_form_template1' class="hide" size="75">  </textarea>
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
    var form = $("#playForm");
    form.children("div").steps({
        headerTag: "h3",
        bodyTag: "section",
        enableAllSteps: true,
        startIndex : 0,
        saveState : true, //현재 단계 쿠키저장
        enablePagination : false,
        onFinished: function(event, currentIndex) {
            popupSave();
        },
    });

    $('#startDate,#endDate').datepicker({
        format: "yyyy-mm-dd",
        language: "kr"
    });

    //파일 선택시 파일명 보이게 하기
    $(document).on('change', '.addFile1', function() {
        $(this).parent().find('.custom-file-control').html($(this).val().replace(/C:\\fakepath\\/i, ''));
    });
    $(document).on('change', '.addFile2', function() {
        $(this).parent().find('.custom-file-control2').html($(this).val().replace(/C:\\fakepath\\/i, ''));
    });
    $(document).on('change', '.addFile3', function() {
        $(this).parent().find('.custom-file-control3').html($(this).val().replace(/C:\\fakepath\\/i, ''));
    });
    $(document).on('change', '.addFile4', function() {
        $(this).parent().find('.custom-file-control4').html($(this).val().replace(/C:\\fakepath\\/i, ''));
    });
    $(document).on('change', '.addFile5', function() {
        $(this).parent().find('.custom-file-control5').html($(this).val().replace(/C:\\fakepath\\/i, ''));
    });
</script>

<%@include file="/common/jsp/footer.jsp" %>
