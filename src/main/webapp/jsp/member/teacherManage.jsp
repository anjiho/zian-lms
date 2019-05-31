<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/memberManageService.js'></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    function init() {
        menuActive('menu-5', 5);
        getEmailSelectbox('deliveryUserEmail2', '');//이메일
        getSelectboxListForCtgKey('interestCtgKey0','133', "");
       //getwelfareDcPercentSelectBox("welfareDcPercent", "");//teacherGrade
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
    function teacherSave() {
        var data = new FormData();
        $.each($('#imageTeacherList')[0].files, function (i, file) {
            data.append('listImageFile', file);
        });
        $.each($('#imageTeacherView')[0].files, function (i, file) {
            data.append('listImageViewFile', file);
        });
        data.append('uploadType', 'TEACHER');
        if (confirm("저장 하시겠습니까?")) {//TEACHER
            $.ajax({
                url: "/file/imageFileUpload",
                method: "post",
                dataType: "JSON",
                data: data,
                cache: false,
                processData: false,
                contentType: false,
                success: function (data) {
                    if (data.result) {
                        var teacherInfoObj = getJsonObjectFromDiv("section1");
                        var teacherInfoObj2 = getJsonObjectFromDiv("section2");

                        teacherInfoObj2.imageTeacherList = data.result.listImageFilePath;
                        teacherInfoObj2.imageTeacherView = data.result.viewImageFilePath;
                        teacherInfoObj2.imageList = data.result.listImageFilePath;
                        teacherInfoObj2.imageView = "";
                        teacherInfoObj2.imageMainList = "";
                        teacherInfoObj2.imageContents = "";
                        teacherInfoObj2.teacherKey = 0;
                        teacherInfoObj2.userKey = 0;
                        var authority = getSelectboxValue("authoritSel");//권한
                        var authoritGrade = getSelectboxValue("authoritGradeSel");//권한등급
                        var interestCtgKey0 = getSelectboxValue("sel_1");//직렬 키

                        var phone1 = getInputTextValue("phone1");
                        var phone2 = getInputTextValue("phone2");
                        var phone3 = getInputTextValue("phone3");
                        var phone = phone1+phone2+phone3;

                        var email = getInputTextValue("InputEmail1")+"@"+getInputTextValue("InputEmail");

                        var zipcode = getInputTextValue("postcode");
                        var addressRoad =getInputTextValue("roadAddress");
                        var addressNumber =getInputTextValue("jibunAddress");
                        var address = getInputTextValue("detailAddress");

                        var userId = getInputTextValue("userId");
                        var pwd = getInputTextValue("pwd");
                        var name = getInputTextValue("name");
                        //var indate = getInputTextValue("indate");
                        var birth = getInputTextValue("birth");
                        //var recvEmail = $('input[name="recvEmail"]:checked').val();
                        //var recvSms = $('input[name="recvSms"]:checked').val();

                        var teacherObj = {
                            userKey : 0,
                            cKey : 0,
                            userId : userId,
                            indate : "",
                            name : name,
                            authority : authority,
                            status : 10, //가입상태
                            pwd : pwd,
                            birth : birth,
                            lunar : "",
                            gender : "",
                            telephone: "",
                            telephoneMobile : phone,
                            zipcode: zipcode,
                            addressRoad : addressRoad,
                            addressNumber : addressNumber,
                            address : address,
                            email : email,
                            recvSms : "",
                            recvEmail : "",
                            welfareDcPercent : 0,
                            grade : authoritGrade,
                            note : "",
                            interestCtgKey0 : Number(interestCtgKey0)
                        };
                        console.log(teacherObj);
                        console.log(teacherInfoObj2);
                        memberManageService.saveMember(teacherObj, teacherInfoObj2, function(info) {alert(info);});
                    }
                }
            });
        }
    }
    
    function isUserId() {
        var userId = $("#userId").val();
        memberManageService.isUser(userId, function(info) {
            if(info == false){
                $("#userId").addClass('is-invalid');
                $("#isChkId").hide();
            }else{
                $("#userId").removeClass('is-invalid');
                $("#isChkId").show();
            }
        });
    }
</script>
<div class="page-breadcrumb">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">강사 등록</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">회원관리</li>
                        <li class="breadcrumb-item active" aria-current="page">강사 등록</li>
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
                        <h3>강사 기본정보</h3>
                        <section class="col-md-auto">
                            <div id="section1">
                                <input type="hidden" name="userKey" value="0">
                                <input type="hidden" name="cKey" value="0">
                                <input type="hidden" name="lunar" value="">
                                <input type="hidden" name="gender" value="">
                                <div class="col-md-12">
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">아이디</label>
                                        <input type="text" class="col-sm-2 form-control" style="display: inline-block;" id="userId" name="userId">
                                        <button type="button"  class="btn btn-info btn-sm" onclick="isUserId();">중복체크</button>
                                        <span class="invalid-feedback">중복된 아이디 입니다.</span>
                                        <span id="isChkId" style="display: none;margin-top: 0.28rem;font-size: 80%;margin-left: 10px;color: blue;">사용 가능한 아이디 입니다.</span>
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
                                   <!-- <div class="form-group row">
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
                                </div>
                            </div>
                        </section>
                        <!-- // 1.기본정보 Tab -->
                        <!-- 도서정보 -->
                        <h3>강사 정보</h3>
                        <section class="col-md-auto">
                            <div id="section2">
                                <input type="hidden" name="teacherKey" value="0">
                                <input type="hidden" name="userKey" value="0">
                                <div class="col-md-12">
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">리스트이미지</label>
                                        <div class="col-sm-5 pl-0 pr-0">
                                            <div class="custom-file">
                                                <input type="file" class="custom-file-input" id="imageTeacherList"  name="imageTeacherList" required>
                                                <span class="custom-file-control custom-file-label"></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">뷰 이미지</label>
                                        <div class="col-sm-5 pl-0 pr-0">
                                            <div class="custom-file">
                                                <input type="file" class="custom-file-input addFile"  id="imageTeacherView" name="imageTeacherView" required>
                                                <span class="custom-file-control1 custom-file-label"></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">샘플강의</label>
                                        <input type="text" class="col-sm-3 form-control" style="display: inline-block;" name="sampleVodFile" id="sampleVodFile">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">온라인강좌 정산율</label>
                                        <input type="number" class="col-sm-3 form-control" style="display: inline-block;" name="onlinelecCalculateRate" id="onlinelecCalculateRate"> %
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">오프라인강좌 정산율</label>
                                        <input type="number" class="col-sm-3 form-control" style="display: inline-block;" name="offlinelecCalculateRate" id="offlinelecCalculateRate"> %
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">인사말</label>
                                        <textarea class="col-sm-6 form-control" style="height: 150px;width: 2000px;" id="greeting" name="greeting"></textarea>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">약력</label>
                                        <textarea class="col-sm-6 form-control" style="height: 150px;width: 2000px;" name="history"></textarea>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">저서</label>
                                        <textarea class="col-sm-6 form-control" style="height: 150px;width: 2000px;" id="bookWriting" name="bookWriting"></textarea>
                                    </div>
                                </div>
                            </div>
                        </section>
                        <!-- // 1.기본정보 Tab -->
                        <!-- 도서정보 -->
                    </div>
                </div>
            </div>
        </div>
        <!-- //div.card -->
    </div>
</form>
<!-- // 기본소스-->
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
            teacherSave();
        },
        // onContentLoaded: function (event, currentIndex) {
        //
        // }
        /*onFinishing: function(event, currentIndex) {
            //form.validate().settings.ignore = ":disabled";
            //return form.valid();
        },
        onFinished: function(event, currentIndex) {
            //alert("Submitted!");
        }*/
        // aria-selected:"false"
    });

    $('#indate , #birth').datepicker({
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

    function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ''; // 참고 항목 변수

            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }

            if(data.buildingName !== '' && data.apartment === 'Y'){
                extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }

            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }

            document.getElementById('postcode').value = data.zonecode;
            document.getElementById("roadAddress").value = roadAddr;
            document.getElementById("jibunAddress").value = data.jibunAddress;

            // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
            /*if(roadAddr !== ''){
                document.getElementById("extraAddress").value = extraRoadAddr;
            } else {
                document.getElementById("extraAddress").value = '';
            }*/

            var guideTextBox = document.getElementById("guide");
            // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
            if(data.autoRoadAddress) {
                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                guideTextBox.style.display = 'block';

            } else if(data.autoJibunAddress) {
                var expJibunAddr = data.autoJibunAddress;
                guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                guideTextBox.style.display = 'block';
            } else {
                guideTextBox.innerHTML = '';
                guideTextBox.style.display = 'none';
            }
        }
    }).open();
    }
</script>

<%@include file="/common/jsp/footer.jsp" %>
