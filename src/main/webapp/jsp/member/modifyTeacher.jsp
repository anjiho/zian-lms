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
        getTeacherSubjectCategoryList("pcSubjectSel","");
        getTeacherSubjectCategoryList1("mobileSubjectSel", "70", "");
        //탭 메뉴 색상 변경
        $("#playForm ul").each(function(idx) {
            var ul = $(this);
            ul.find("li").addClass("done").attr("aria-selected", "false");
            ul.find("li").eq(0).removeClass("done").attr("aria-selected", "true");
        });

        function emailSelChange(val) {
            if(val == '1') $('#InputEmail').val('');
            else $('#InputEmail').val(val);
        }
        //파일 선택시 파일명 보이게 하기
        $(document).on('change', '.custom-file-input', function() {
            $(this).parent().find('.custom-file-control').html($(this).val().replace(/C:\\fakepath\\/i, ''));
        });
        $(document).on('change', '.addFile', function() {
            $(this).parent().find('.custom-file-control1').html($(this).val().replace(/C:\\fakepath\\/i, ''));
        });

        //강사 기본정보 가져오기
        memberManageService.getMemberDetailInfo(userKey, function (info) {
            var result = info.result;
            innerValue("userId", result.userId);
            innerValue("name", result.name);
            innerValue("pwd", result.pwd);
            //innerValue("indeate", result.indate);
            innerValue("birth", result.birth);

            var phoneNum = result.telephoneMobile;
            var phoneNumSplit = phoneNum.split("-");
            innerValue("phone1", phoneNumSplit[0]);
            innerValue("phone2", phoneNumSplit[1]);
            innerValue("phone3", phoneNumSplit[2]);

            var emailStr = result.email;
            var emailSplit = emailStr.split("@");
            innerValue("InputEmail", emailSplit[1]);
            innerValue("InputEmail1", emailSplit[0]);

            getAuthoritySelectbox("teacherAuthority", result.authority);
            getAuthorityGradeSelectbox("teacherGrade", result.grade);

            innerValue("postcode", result.zipcode);
            innerValue("roadAddress", result.addressRoad);
            innerValue("jibunAddress", result.addressNumber);
            innerValue("detailAddress", result.address);

            getSelectboxListdivisionCtgKey('interestCtgKey0','133', result.interestCtgKey0);
        });

        //강사정보 가져오기
        memberManageService.getTeacherDetailInfo(userKey, function (info) {
            var teacherInfo = info.teacherInfo;
            console.log(info);
            if (teacherInfo.imageTeacherList != null) {
                $('.custom-file-control').html(fn_clearFilePath(teacherInfo.imageTeacherList));//리스트이미지
            }
            if (teacherInfo.imageTeacherView != null) {
                $('.custom-file-control1').html(fn_clearFilePath(teacherInfo.imageTeacherView));//상세이미지
            }
            innerValue("sampleVodFile", teacherInfo.sampleVodFile);
            innerValue("onlinelecCalculateRate", teacherInfo.onlinelecCalculateRate);
            innerValue("offlinelecCalculateRate", teacherInfo.offlinelecCalculateRate);
            innerValue("greeting", teacherInfo.greeting);
            innerValue("history", teacherInfo.history);
            innerValue("bookWriting", teacherInfo.bookWriting);
            innerValue("teacherKey", teacherInfo.teacherKey);

            /*카테고리 정보 가져오기*/
            var nextIcon = "<i class=\"m-r-10 mdi mdi-play\" style=\"font-size:18px;color:darkblue\"></i>";
            var teacherCategoryInfoList = info.teacherCategoryInfoList;

            if(teacherCategoryInfoList.length == 0){
                var cellData = [
                    function() {return "<input type='hidden' name='inputCtgKey[]' value=''>";},
                    function() {return "지안에듀";},
                    function() {return nextIcon},
                    function() {return getCategoryNoTag('categoryTable','1183', '3');},
                    function() {return nextIcon},
                    function() {return defaultCategorySelectbox();},
                    function() {return nextIcon},
                    function() {return defaultCategorySelectbox();},
                    function() {return nextIcon},
                    function() {return defaultCategorySelectbox();},
                    function() {return "<button type=\"button\" onclick=\"deleteTableRow('categoryTable', 'delBtn');\" class=\"btn btn-outline-danger btn-sm delBtn\" style=\"margin-top:8%;\" >삭제</button>"},
                ];
                dwr.util.addRows("categoryList", [0], cellData, {escapeHtml: false});
                $('#categoryList tr').eq(0).attr("style", "display:none");
            }else{
                for(var i=0; i < teacherCategoryInfoList.length; i++){
                    var delBtn = "<input type='button' onclick='deleteCategory("+ teacherCategoryInfoList[i].linkKey +");' class='btn btn-outline-danger btn-sm' value='삭제'>";
                    var categoryList =  teacherCategoryInfoList[i].teacherCategoryInfo;
                    var cellData = [
                        function() {return "<input type='hidden' name='inputCtgKey[]' value='"+ categoryList[0].ctgKey +"'>";},
                        function() {return "지안에듀";},
                        function() {return nextIcon},
                        function() {return categoryList[3].name;},
                        function() {return nextIcon},
                        function() {return categoryList[2].name;},
                        function() {return nextIcon},
                        function() {return categoryList[1].name;},
                        function() {return nextIcon},
                        function() {return categoryList[0].name;},
                        function() {return delBtn},
                        function() {return ""},
                    ];
                    dwr.util.addRows("categoryList", [0], cellData, {escapeHtml: false});
                    $('#categoryList tr').each(function(){
                        var tr = $(this);
                    });
                }
            }

            /*과목별 그룹 설명내용*/
            var subjectGroupInfo = info.subjectGroupInfo;

                if(subjectGroupInfo.length == 0){
                    /*pc*/
                  var html = "<div id=\"test_div\"  class=\"form-group\">";
                  html += "<div class=\"row testContent\">";
                    html += "<span>" + getTeacherSubjectCategoryList4("")+ "</span>";
                    html += "<textarea name=\"pcContent\" class=\"pcContent\" ></textarea>";
                    html += "</div>";
                    html += "</div>";
                    $("#test_div2").html(html);
                    $(".pcContent").summernote({
                        height: 250,
                        width: 1300,
                        placeholder: '내용을 적어주세요1.',
                        popover: {
                            image: [],
                            link: [],
                            air: []
                        }
                    });
                    /*mobile*/
                    var html1 = "<div id=\"mobile_div\"  class=\"form-group\">";
                    html1 += "<div class=\"row mobiletestContent1\">";
                    html1 += "<span>" + getTeacherSubjectCategoryList5("")+ "</span>";
                    html1 += "<textarea name=\"mobileContent\" class=\"mobileContent\" ></textarea>";
                    html1 += "</div>";
                    html1 += "</div>";
                    $("#mobile_div2").html(html1);
                    $(".mobileContent").summernote({
                        height: 250,
                        width: 1300,
                        placeholder: '내용을 적어주세요1.',
                        popover: {
                            image: [],
                            link: [],
                            air: []
                        }
                    });
            }else{
                $("#studyVal").val(1);
               // gfn_display("mobile_div", false);
                for(var i=0; i < subjectGroupInfo.length; i++){
                    var cmpList = subjectGroupInfo[i];
                    if(subjectGroupInfo.length > 0){
                        if(cmpList.device == 1){ //pc
                            var cmpList = subjectGroupInfo[i];
                            var cellData = [
                                function() {return "<input type='hidden' name='hiddenKey' value='"+ cmpList.resKey +"'>";},
                                function() {return getTeacherSubjectCategoryList3(cmpList.resKey, i);},
                                function() {return "<textarea name=\"RePcContent\"  class=\"RePcContent\">"+ cmpList.valueText +"</textarea>";}
                            ];
                            dwr.util.addRows("newList", [0], cellData, {escapeHtml: false});
                           // $('#newList tr').eq(0).attr("style", "display:none");
                            $('.RePcContent').summernote({
                                height: 250,
                                width: 1300,
                                placeholder: '내용을 적어주세요1.',
                                popover: {
                                    image: [],
                                    link: [],
                                    air: []
                                }
                            });
                        }else if(cmpList.device == 3){ //mobile
                            var cmpList = subjectGroupInfo[i];
                            var cellData = [
                                function() {return "<input type='hidden' name='hiddenKey1' value='"+ cmpList.resKey +"'>";},
                                function() {return getTeacherSubjectCategoryList6(cmpList.resKey, i);},
                                function() {return "<textarea name=\"RemobileContent\"  class=\"RemobileContent\">"+ cmpList.valueText +"</textarea>";}
                            ];
                            dwr.util.addRows("newList1", [0], cellData, {escapeHtml: false});
                            // $('#newList tr').eq(0).attr("style", "display:none");
                            $('.RemobileContent').summernote({
                                height: 250,
                                width: 1300,
                                placeholder: '내용을 적어주세요1.',
                                popover: {
                                    image: [],
                                    link: [],
                                    air: []
                                }
                            });
                        }
                    }
                }
            }//else

        });
    }
    /*
    function formatter(memoList) {
                    return "<label></label>" +
                            "<div>" +
                                "<h4><span><i class='tag'>" + convert_memo_type(memoList.memoType) + "</i>" + memoList.memberName + "</span>"+
                                "<em>" + getDateTimeSplitComma(memoList.createDate) + "</em></h4>"+
                                "<p>" + ellipsis(memoList.memoContent, 30) + "</p>" +
                                   "<h4><em>전화번호 : " + fn_tel_tag(memoList.phoneNumber) + "</em></h4>" +
                            "</div>" +
                            "<div class='manage'>" +
                                "<button type='button' onclick='goStudentReg("+ '"' + 'student' + '"' + ","+ '"' + 'save_student' + '"' + ","+ '"' + memoList.phoneNumber + '"' + ");'>학생등록" +
                                "<button type='button' onclick='deleteConsultMemo("+ memoList.earlyConsultMemoId + ");'>삭제" +
                            "</div>";
                }
                dwr.util.addOptions("dataList", memoList, formatter, {escapeHtml:false});
     */

    //카테고리 삭제 linkKey
    function deleteCategory(linkKey) {
        if(confirm("삭제하시겠습니까?")) {
            memberManageService.deleteTeacherCategory(linkKey, function () {isReloadPage();});
        }
    }

    //카테고리 추가 버튼
    function addCategoryInfo() {
        var fistTrStyle = $("#categoryList tr").eq(0).attr("style");

        if (fistTrStyle == "display:none") {
            $('#categoryList tr').eq(0).removeAttr("style", null);
        } else {
            var $tableBody = $("#categoryTable").find("tbody"),
                $trLast = $tableBody.find("tr:last"),
                $trNew = $trLast.clone();
            $trLast.after($trNew);

            var delBtn = "<button type=\"button\" onclick=\"deleteTableRow('categoryTable', 'delBtn');\" class=\"btn btn-outline-danger btn-sm delBtn\" style=\"margin-top:8%;\" >삭제</button>";
            $trNew.find("td").eq(0).html("");
            $trNew.find("td").eq(1).html("지안에듀");
            getCategoryNoTag('categoryTable','1183', '3');
            $trNew.find("td").eq(5).html(defaultCategorySelectbox());
            $trNew.find("td").eq(7).html(defaultCategorySelectbox());
            $trNew.find("td").eq(9).html(defaultCategorySelectbox());
            $trNew.find("td").eq(10).attr("style","display:none;");
            $trNew.find("td").eq(11).html(delBtn);
        }
    }

    //카테코리 셀렉트 박스 변경 시
    function changeCategory(tableId, val, tdNum) {
        if(tdNum == '11') return false;
        getCategoryNoTag2(val, tableId, tdNum);
    }

    //기본정보 수정
    function modifyBasicInfo() {
        var authority = getSelectboxValue("authoritSel");//권한
        var authoritGrade = getSelectboxValue("authoritGradeSel");//권한등급

        var interestCtgKey0 = getSelectboxValue("divisionCtgKey");//직렬 키
        var phone1 = getInputTextValue("phone1");
        var phone2 = getInputTextValue("phone2");
        var phone3 = getInputTextValue("phone3");
        var phone = phone1 + "-" + phone2 + "-" + phone3;

        var email = getInputTextValue("InputEmail1") + "@" + getInputTextValue("InputEmail");

        var zipcode = getInputTextValue("postcode");
        var addressRoad = getInputTextValue("roadAddress");
        var addressNumber = getInputTextValue("jibunAddress");
        var address = getInputTextValue("detailAddress");

        var userId = getInputTextValue("userId");
        var pwd = getInputTextValue("pwd");
        var name = getInputTextValue("name");
        //var indate = getInputTextValue("indate");
        var birth = getInputTextValue("birth");
        var teacherKey = getInputTextValue("teacherKey");
        var userKey =  getInputTextValue("userKey");
        var teacherObj = {
            userKey: userKey,
            cKey: 0,
            userId: userId,
            indate: "",
            name: name,
            authority: authority,
            status: 10, //가입상태
            userPwd: "",
            birth: birth,
            lunar: "",
            gender: "",
            telephone: "",
            telephoneMobile: phone,
            zipcode: zipcode,
            addressRoad: addressRoad,
            addressNumber: addressNumber,
            address: address,
            email: email,
            recvSms: "",
            recvEmail: "",
            welfareDcPercent: 0,
            grade: authoritGrade,
            note: "",
            interestCtgKey0: Number(interestCtgKey0)
        };

        memberManageService.updateUserInfo(teacherObj, function () {isReloadPage();});
    }

    //강사정보 수정
    function modifyTeacherInfo() {
        if($("#imageTeacherList").val() == ""){
                var teacherInfoObj2 = getJsonObjectFromDiv("section2");
                var teacherKey = getInputTextValue("teacherKey");
                var userKey =  getInputTextValue("userKey");
                teacherInfoObj2.imageTeacherList = "";
                teacherInfoObj2.imageTeacherView = "";
                teacherInfoObj2.imageList = "";
                teacherInfoObj2.imageView = "";
                teacherInfoObj2.imageMainList = "";
                teacherInfoObj2.imageContents = "";
                teacherInfoObj2.teacherKey = teacherKey;
                teacherInfoObj2.userKey = userKey;

                memberManageService.updateTeacherInfo(teacherInfoObj2, function(info) {isReloadPage();});
        }else{
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
                            var teacherInfoObj2 = getJsonObjectFromDiv("section2");
                            var teacherKey = getInputTextValue("teacherKey");
                            var userKey =  getInputTextValue("userKey");
                            teacherInfoObj2.imageTeacherList = data.result.listImageFilePath;
                            teacherInfoObj2.imageTeacherView = data.result.viewImageFilePath;
                            teacherInfoObj2.imageList = data.result.listImageFilePath;
                            teacherInfoObj2.imageView = "";
                            teacherInfoObj2.imageMainList = "";
                            teacherInfoObj2.imageContents = "";
                            teacherInfoObj2.teacherKey = teacherKey;
                            teacherInfoObj2.userKey = userKey;

                            memberManageService.updateTeacherInfo(teacherInfoObj2, function(info) {isReloadPage();});
                        }
                    }
                });
            }
        }
    }

    //카테고리 저장
    function teacherCategorySave() {
        var teacherKey = getInputTextValue("teacherKey");
        var categoryArr = new Array();
        $('#categoryTable tbody tr').each(function (index) {
            if($(this).find("td").eq(0).html() == ""){
                var ctgKey = $(this).find("td select").eq(3).val();
                var data = {
                    linkKey: 0,
                    reqKey : ctgKey,
                    resKey : Number(teacherKey),
                    reqType : 100,
                    resType : 200,
                    pos : 0,
                    valueBit : 0
                };
                memberManageService.insertTeacherCategory(data, function () {
                    isReloadPage(true);
                });
            }
        });
    }

    //과목그룹별 pc 저장
    function teacherPcSubjectInfoSave() {
        var teacherKey = getInputTextValue("teacherKey");
        var subjectCtgKey = get_array_values_by_name("select", "subjectCtgKey"); //기존데이터 카테고리 셀렉트박스
        var subjectCtgKey4 = get_array_values_by_name("select", "subjectCtgKey4"); //추가시 카테고리 셀렉트박스
       var hiddenKey = get_array_values_by_name("input", "hiddenKey");

       if(subjectCtgKey4.length > 0){ //추가된 카테고리
           $.each(subjectCtgKey4, function(index, key) {
               var data = {};
               data.resKey = 0;
               data.type = 0;
               data.device = 1;
               data.key00 = teacherKey;
               data.key02 = key;
               data.key01 = 0;
               data.key00Type = 0;
               data.key01Type = 0;
               data.key02Type = 0;
               data.value = "";
               data.valueText = $("#section4 .pcContent").val();

              memberManageService.insertTResAtTeacherSubject(data, function () {isReloadPage();});
           });
       }
       /* $.each(subjectCtgKey, function(index, key) {
            var data = {};
            data.resKey = 0;
            data.type = 0;
            data.device = 1;
            data.key00 = teacherKey;
            data.key02 = key;
            data.key01 = 0;
            data.key00Type = 0;
            data.key01Type = 0;
            data.key02Type = 0;
            data.value = "";
            data.valueText = $("#section4 .pcContent").val();
            console.log(data);
          //memberManageService.insertTResAtTeacherSubject(data, function () {isReloadPage();});
        });*/
    }

    //과목그룹별 mobile 저장
    function teacherMobileSubjectInfoSave() {
        var teacherKey = getInputTextValue("teacherKey");
        var mobileSubjectCtgKey = get_array_values_by_name("select", "mobilesubjectCtgKey"); //카테고리 키값

        $.each(mobileSubjectCtgKey, function(index, key) {
            var data = {};
            data.resKey = 0;
            data.type = 0;
            data.device = 3;
            data.key00 = teacherKey;
            data.key02 = key;
            data.key01 = 0;
            data.key00Type = 0;
            data.key01Type = 0;
            data.key02Type = 0;
            data.value = "";
            data.valueText = $('.mobileContent').eq(index).val();
            memberManageService.insertTResAtTeacherSubject(data, function () {isReloadPage();});
        });
    }


    //에디터 추가 기능
    $(function() {
        /*-------PC--------*/
        $("#add_field_button").click(function (e) {
            $includeDiv = $("#test_div2");
            var html = "<div class=\"row testContent1\" name=\"testContent1\">\n" +
                        "<input type='hidden' name='hiddenKey' value=''>"+
                       "<span>" + getTeacherSubjectCategoryList9("") + "</span>\n" +
                       "<textarea name=\"pcContent\" class=\"pcContent\" ></textarea>\n" +
                       "</div>";
                $includeDiv.after(html);
                //$("#test_div").show();
                $("textarea[name=pcContent]").summernote({
                        height: 250,
                        width: 1300,
                        placeholder: '내용을 적어주세요.',
                        popover: {
                            image: [],
                            link: [],
                            air: []
                        }
                });
        });
        $('.pcContent').summernote({
            height: 250,
            width: 1300,
            placeholder: '내용을 적어주세요1.',
            popover: {
                image: [],
                link: [],
                air: []
            }
        });

        /*-------MOBILE--------*/
        $("#add_field_button1").click(function (e) {
            $includeDiv = $("#mobile_div2");
            var html = "<div class=\"row mobiletestContent2\" name=\"mobiletestContent2\">\n" +
                "<input type='hidden' name='hiddenKey1' value=''>"+
                "<span>" + getTeacherSubjectCategoryList10("") + "</span>\n" +
                "<textarea name=\"mobileContent\" class=\"mobileContent\" ></textarea>\n" +
                "</div>";
            $includeDiv.after(html);
            $("textarea[name=mobileContent]").summernote({
                height: 250,
                width: 1300,
                placeholder: '내용을 적어주세요.',
                popover: {
                    image: [],
                    link: [],
                    air: []
                }
            });
        });
        $('.mobileContent').summernote({
            height: 250,
            width: 1300,
            placeholder: '내용을 적어주세요1.',
            popover: {
                image: [],
                link: [],
                air: []
            }
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
                    <input type="hidden" id="teacherKey" value="">
                    <input type="hidden" id="userKey" value="<%=userKey%>">
                    <div>
                        <!-- 1.기본정보 Tab -->
                        <h3>기본정보</h3>
                        <section>
                            <div id="section1">
                                <div class="col-md-12">
                                    <button type="button" class="btn btn-outline-primary btn-sm float-right" onclick="modifyBasicInfo();">수정</button>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">아이디</label>
                                        <input type="text" class="col-sm-2 form-control" style="display: inline-block;" id="userId" name="userId" readonly>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">이름</label>
                                        <input type="text" class="col-sm-2 form-control" style="display: inline-block;" id="name" name="name">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">비밀번호</label>
                                        <input type="password" class="col-sm-2 form-control" style="display: inline-block;" id="pwd" name="pwd" readonly>
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
                                    <!--<div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">등록일</label>
                                        <div class="col-sm-2 input-group pl-0 pr-0">
                                            <input type="text" class="form-control mydatepicker" placeholder="yyyy-mm-dd" name="indate" id="indate">
                                            <div class="input-group-append">
                                                <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                            </div>
                                        </div>
                                    </div>-->
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
                                        <input type="text" class="col-sm-1 form-control" style="display: inline-block;" id="phone1" maxlength="4">
                                        -
                                        <input type="text" class="col-sm-1 form-control" style="display: inline-block;" id="phone2" maxlength="4">
                                        -
                                        <input type="text" class="col-sm-1 form-control" style="display: inline-block;" id="phone3" maxlength="4">
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
                                </div>
                            </div>
                        </section>
                        <!-- // 1.기본정보 Tab -->
                        <!-- 2 강사 정보 -->
                        <h3>강사 정보</h3>
                        <section class="col-md-auto">
                            <div id="section2">
                                <div class="col-md-12">
                                    <button type="button" class="btn btn-outline-primary btn-sm float-right" onclick="modifyTeacherInfo();">수정</button>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">리스트이미지</label>
                                        <div class="col-sm-6 pl-0 pr-0">
                                            <div class="custom-file">
                                                <input type="file" class="custom-file-input" id="imageTeacherList"  name="imageTeacherList" required>
                                                <span class="custom-file-control custom-file-label"></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">뷰 이미지</label>
                                        <div class="col-sm-6 pl-0 pr-0">
                                            <div class="custom-file">
                                                <input type="file" class="custom-file-input addFile"  id="imageTeacherView" name="imageTeacherView" required>
                                                <span class="custom-file-control1 custom-file-label"></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">샘플강의</label>
                                        <input type="text" class="col-sm-3 form-control" style="display: inline-block;" id="sampleVodFile" name="sampleVodFile">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">온라인강좌 정산율</label>
                                        <input type="number" class="col-sm-3 form-control" style="display: inline-block;" name="writer" id="onlinelecCalculateRate"> %
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">오프라인강좌 정산율</label>
                                        <input type="number" class="col-sm-3 form-control" style="display: inline-block;" name="writer" id="offlinelecCalculateRate"> %
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">인사말</label>
                                        <textarea class="col-sm-6 form-control" style="height: 150px;width: 2000px;" id="greeting" name="greeting"></textarea>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">약력</label>
                                        <textarea class="col-sm-6 form-control" style="height: 150px;width: 2000px;" id="history" name="history"></textarea>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">저서</label>
                                        <textarea class="col-sm-6 form-control" style="height: 150px;width: 2000px;" id="bookWriting" name="bookWriting"></textarea>
                                    </div>
                                </div>
                            </div>
                        </section>
                        <!--// 2 강사 정보 -->
                        <!-- 3.카테고리 목록 Tab -->
                        <h3>카테고리</h3>
                        <section>
                            <div class="float-right mb-3">
                                <button type="button" class="btn btn-outline-primary btn-sm" onclick="teacherCategorySave();">수정</button>
                                <button type="button" class="btn btn-info btn-sm" onclick="addCategoryInfo('new');">추가</button>
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


                                    </tbody>
                                </table>
                            </div>
                        </section>
                        <!-- //3.카테고리 목록 Tab -->
                        <!-- 과목그룹 PC -->
                        <h3>과목그룹별 설명내용(PC)</h3>
                        <section>
                            <div id="section4">
                                <div class="col-md-12">
                                    <div class="float-right mb-3">
                                        <button type="button" class="btn btn-outline-primary btn-sm" onclick="teacherPcSubjectInfoSave();">수정</button>
                                        <button type="button" class="btn btn-info btn-sm" id="add_field_button">추가</button>
                                    </div>
                                    <table id="prod_list">
                                        <thead>
                                        <th scope="col" style="width:25%;"></th>
                                            <th scope="col" style="width:25%;"></th>
                                            <th scope="col" style="width:75%;"></th>
                                        </thead>
                                        <tbody id="newList"></tbody>
                                    </table>

                                    <div id="test_div2"></div>
                                </div>
                            </div>
                        </section>
                        <!-- //과목그룹 PC -->
                        <!-- 과목그룹 Mobile -->
                        <!-- 과목그룹 PC -->
                        <h3>과목그룹별 설명내용(Mobile)</h3>
                        <section>
                            <div id="section5">
                                <div class="col-md-12">
                                    <div class="float-right mb-3">
                                        <button type="button" class="btn btn-outline-primary btn-sm" onclick="teacherPcSubjectInfoSave();">수정</button>
                                        <button type="button" class="btn btn-info btn-sm" id="add_field_button1">추가</button>
                                    </div>
                                    <table id="prod_list1">
                                        <thead>
                                        <th scope="col" style="width:25%;"></th>
                                        <th scope="col" style="width:25%;"></th>
                                        <th scope="col" style="width:75%;"></th>
                                        </thead>
                                        <tbody id="newList1"></tbody>
                                    </table>
                                    <div id="mobile_div2"></div>
                                </div>
                            </div>
                        </section>
                        <!-- //과목그룹 Mobile -->
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

    $('#birth').datepicker({
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
