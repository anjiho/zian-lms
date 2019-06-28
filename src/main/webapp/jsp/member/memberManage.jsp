<%@ page import="com.zianedu.lms.utils.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<%
    String userKey = request.getParameter("param_key");
    String searchStartDate = Util.isNullValue(request.getParameter("param_key2"), "");
    String searchEndtDate = Util.isNullValue(request.getParameter("param_key3"), "");
    String memberGradeSel = Util.isNullValue(request.getParameter("param_key4"), "");
    String sel_1 = Util.isNullValue(request.getParameter("param_key5"), "");
    String memberSel = Util.isNullValue(request.getParameter("param_key6"), "");
    String searchText = Util.isNullValue(request.getParameter("param_key7"), "");
    String isDetail = Util.isNullValue(request.getParameter("param_key8"), "");
%>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/memberManageService.js'></script>
<script>
    var userKey = '<%=userKey%>';
    $( document ).ready(function() {
        //탭 메뉴 색상 변경
        $("#playForm ul").each(function(idx) {
            var ul = $(this);
            ul.find("li").addClass("done").attr("aria-selected", "false");
            ul.find("li").eq(0).removeClass("done").attr("aria-selected", "true");
        });
        /*modal 초기화*/
        $('#consultModal').on('hidden.bs.modal', function (e) {
            $('form').each(function(){
                this.reset();
                $("#modalIndate, #modalOkDate, #modalstartDate").hide();
                $(".modal-title").text("상담 추가");
                $("#counselKey").val("");
            });
        });
    });

    function init() {
        getConsultDivisionSelectBox("consultDivisionSel", "");
        getConsultStatusSelectBox("consultStatusSel", "");
        menuActive('menu-5', 1);
        /* 회원상세 정보 가져오기 */
        memberManageService.getMemberDetailInfo(userKey, function(info) {
            var result = info.result;
            innerHTML("userId", result.userId == null ? "-" : result.userId );
            innerHTML("modalUserId",result.userId);
            innerHTML("name", result.name);
            innerHTML("modalName",result.name);
            innerHTML("indate1", result.indate);

            innerHTML("birth", result.birth);
            innerHTML("telephone", result.telephone);
            innerHTML("telephoneMobile", result.telephoneMobile);
            innerHTML("email", result.email);
            innerHTML("zipcode", result.zipcode);
            innerHTML("addressRoad", result.addressRoad);
            innerHTML("addressNumber", result.addressNumber);
            innerHTML("address", result.address);
            getNewSelectboxListForCtgKey5('interestCtgKey0','133', result.interestCtgKey0);
            memberGrageSelectBox1("memberGrageSel", result.grade);
            getwelfareDcPercentSelectBox("welfareDcPercent", result.welfareDcPercent);
            innerHTML("isMobileReg", result.isMobileReg == '0' ? "PC" : "Mobile");
            innerHTML("note", result.note == null ? "-" : result.note);

            $('input:radio[name=recvEmail]:input[value=' + result.recvEmail + ']').attr("checked", true);
            $('input:radio[name=recvSms]:input[value=' + result.recvSms + ']').attr("checked", true);
            $("input[name=recvEmail]").attr("disabled",true);
            $("input[name=recvSms]").attr("disabled",true);
            $("select[id=twelfareDcPercentSel]").attr("disabled",true);

        });

        /*회원 상담내역 리스트 가져오기*/
        memberManageService.getUserCounselList(userKey, function(selList) {
            if (selList.length == 0) return;
            if(selList.length > 0){
                for (var i = 0; i < selList.length; i++) {
                    var cmpList = selList[i];
                    if (cmpList != undefined) {
                        var cellData = [
                            function(data) {return cmpList.counselKey == null ? "-" : cmpList.counselKey;},
                            function(data) {return cmpList.consultTypeName == null ? "-" : "<a href='javascript:void(0);' color='blue'  data-toggle=\"modal\" data-target=\"#consultModal\" onclick='modifyConsult("+ cmpList.counselKey +");'>"+cmpList.consultTypeName+"</a>";},
                            function(data) {return cmpList.telephone+"<br>"+cmpList.telephoneMobile;},
                            function(data) {return cmpList.indate == null ? "-" : split_minute_getDay(cmpList.indate);},
                            function(data) {return cmpList.procStartDate == null ? "-" : split_minute_getDay(cmpList.procStartDate);},
                            function(data) {return cmpList.procEndDate == null ? "-" : split_minute_getDay(cmpList.procEndDate);},
                        ];
                        dwr.util.addRows(dataList, [0], cellData, {escapeHtml:false});
                    }else{
                        gfn_emptyView("V", comment.blank_list2);
                    }
                }
            }
        });
    }

    function modifyConsult(counselKey){
        $("#modalIndate, #modalOkDate, #modalstartDate").show(); //처리날짜들 보여주기
        $(".modal-title").text("상담 수정");//팝업창 헤드text값
        $("#counselKey").val(counselKey);
        memberManageService.getCounselDetailInfo(counselKey, function (info) {
            innerHTML("wirter", info.writeUserName);
            innerHTML("modalUserId", info.userId);
            innerHTML("modalName", info.userName);
            innerValue("memo", info.memo);
            innerValue("contents", info.contents);
            innerHTML("indate", info.indate);
            innerHTML("procEndDate", info.procEndDate);
            innerHTML("procStartDate", info.procStartDate);
            getConsultDivisionSelectBox("consultDivisionSel", info.type);
            getConsultStatusSelectBox("consultStatusSel", info.status);
        });
    }

    //파일 선택시 파일명 보이게 하기
    $(document).on('change', '.addFile', function() {
        $(this).parent().find('.custom-file-control').html($(this).val().replace(/C:\\fakepath\\/i, ''));
    });
    $(document).on('change', '.addFile', function() {
        $(this).parent().find('.custom-file-control1').html($(this).val().replace(/C:\\fakepath\\/i, ''));
    });

    /* 상담 저장 */
    function counseltSave(){
        var counselKey = $("#counselKey").val();

        if(counselKey == "") { // 신규 상담내역 저장일때,
            if (confirm("저장 하시겠습니까?")) {
                var type = getSelectboxValue("consultDivisionSel");
                var status = getSelectboxValue("consultStatusSel");
                var memo = getInputTextValue("memo");
                var contents = getInputTextValue("contents");
                var telephone = "";
                var telephoneMobile = "";
                var counselObj = {
                    counselKey: 0,
                    cKey: 0,
                    userKey: userKey,
                    writeUserKey: "",
                    type: type,
                    status: status,
                    telephone: telephone,
                    telephoneMobile: telephoneMobile,
                    memo: memo,
                    contents: contents,
                    procStartDate: "",
                    procEndDate: "",
                    indate: "",
                    imageFile1: "",
                    imageFile2: "",
                    imageFile3: "",
                    imageFile4: "",
                    imageFile5: ""
                };
                memberManageService.saveCounselInfo(counselObj, function (selList) {isReloadPage();});
            }
        }else{
            if (confirm("수정 하시겠습니까?")) {
                var type      = getSelectboxValue("consultDivisionSel");
                var status    = getSelectboxValue("consultStatusSel");
                var memo      = getInputTextValue("memo");
                var contents  = getInputTextValue("contents");
                var telephone = "";
                var telephoneMobile = "";
                var counselObj = {
                    counselKey: Number(counselKey),
                    cKey: 0,
                    userKey: Number(userKey),
                    writeUserKey: "",
                    type: Number(type),
                    status: Number(status),
                    telephone: telephone,
                    telephoneMobile: telephoneMobile,
                    memo: memo,
                    contents: contents,
                    procStartDate: "",
                    procEndDate: "",
                    indate: "",
                    imageFile1: "",
                    imageFile2: "",
                    imageFile3: "",
                    imageFile4: "",
                    imageFile5: ""
                };
                memberManageService.updateCounselInfo(counselObj, function (selList) {isReloadPage();});
             }
        }
    }

    function goMemberList() {
        innerValue('param_key', '<%=userKey%>');
        innerValue('param_key2', '<%=searchStartDate%>');
        innerValue('param_key3', '<%=searchEndtDate%>');
        innerValue('param_key4', '<%=memberGradeSel%>');
        innerValue('param_key5', '<%=sel_1%>');
        innerValue('param_key6', '<%=memberSel%>');
        innerValue('param_key7', '<%=searchText%>');
        innerValue('param_key8', '<%=isDetail%>');

        goPage('memberManage', 'memberList');
    }
</script>
<div class="page-breadcrumb">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">회원정보</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">회원 관리</li>
                        <li class="breadcrumb-item active" aria-current="page">회원정보</li>
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
                        <h3>회원 기본정보</h3>
                        <section class="col-md-auto">
                            <div id="section1">
                                <input type="hidden" name="userKey" value="<%=userKey%>">
                                <input type="hidden" name="cKey" value="0">
                                <input type="hidden" name="type" value="0">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group row">
                                            <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">아이디</label>
                                            <span id="userId"></span>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">이름</label>
                                            <span id="name"></span>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">등록일</label>
                                            <span id="indate1"></span>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">생년월일</label>
                                            <span id="birth"></span>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">전화번호</label>
                                            <span id="telephone"></span>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">휴대전화번호</label>
                                            <span id="telephoneMobile"></span>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">E-mail</label>
                                            <span id="email"></span>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">E-mail수신여부</label>
                                            <!--<input type="radio" name="recvEmail"  class="custom-radio" value="1">동의
                                            <input type="radio" name="recvEmail"  class="custom-radio" value="0">동의안함-->
                                            <div class="custom-control custom-radio">
                                                <input type="radio" class="custom-control-input" value="1" id="customControlValidation3" name="recvEmail" required="">
                                                <label class="custom-control-label" for="customControlValidation3">동의</label>
                                            </div>&nbsp; &nbsp;
                                            <div class="custom-control custom-radio">
                                                <input type="radio" class="custom-control-input" value="0" id="customControlValidation4" name="recvEmail" required="">
                                                <label class="custom-control-label" for="customControlValidation4">동의안함</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group row">
                                            <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">SMS 수신여부</label>
                                            <div class="custom-control custom-radio">
                                                <input type="radio" class="custom-control-input" id="customControlValidation1" value="1" name="recvSms">
                                                <label class="custom-control-label" for="customControlValidation1">동의</label>
                                            </div>
                                            &nbsp; &nbsp;
                                            <div class="custom-control custom-radio">
                                                <input type="radio" class="custom-control-input" id="customControlValidation2" value="0" name="recvSms">
                                                <label class="custom-control-label" for="customControlValidation2">동의안함</label>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">주소</label>
                                            우편번호 <span id="zipcode"></span>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0"></label>
                                            <span id="addressRoad"></span>
                                            <span id="addressNumber"></span>
                                            <span id="address"></span>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">복지할인율</label>
                                            <div class="col-sm-6 pl-0 pr-0">
                                             <span id="welfareDcPercent"></span>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">준비직렬</label>
                                            <div class="col-sm-6 pl-0 pr-0">
                                                <span id="interestCtgKey0"></span>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">등급</label>
                                            <div class="col-sm-6 pl-0 pr-0">
                                                <span id="memberGrageSel"></span>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">비고</label>
                                            <span id="note"></span>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">가입디바이스종류</label>
                                            <span id="isMobileReg"></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>
                        <!-- // 1.기본정보 Tab -->
                        <!-- 2.상담 목록 Tab -->
                        <h3>상담내역</h3>
                        <section>
                            <div class="float-right mb-3">
                                <button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#consultModal">상담내용 추가</button>
                            </div>
                            <div id="section3">
                                <table class="table table-hover">
                                    <thead>
                                    <tr>
                                        <th scope="col" style="width: 15%;">상담번호</th>
                                        <th scope="col" style="width: 15%;">상담구분</th>
                                        <th scope="col" style="width: 15%;">연락처</th>
                                        <th scope="col" style="width: 15%;">접수일</th>
                                        <th scope="col" style="width: 15%;">처리시작일</th>
                                        <th scope="col" style="width: 15%;">완료일</th>
                                    </tr>
                                    </thead>
                                    <tbody id="dataList"></tbody>
                                    <tr>
                                        <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
                                    </tr>
                                </table>
                                <%@ include file="/common/inc/com_pageNavi.inc" %>
                            </div>
                        </section>
                        <!-- //2.상담 목록 Tab -->
                    </div>
                </div>
                <div align="right">
                    <button type="button" class="btn btn-outline-info mx-auto" onclick="goMemberList()">목록</button>
                </div>
            </div>
        </div>
        <!-- //div.card -->
    </div>
</form>
<!-- 상담 팝업창-->
<div class="modal fade" id="consultModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document" style="max-width: 980px;">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">상담 추가</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form>
                <!-- modal body -->
                <div class="modal-body">
                    <div id="section2">
                        <input type="hidden" id="counselKey" value="">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group row">
                                <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">상담구분</label>
                                <div class="col-sm-6 pl-0 pr-0">
                                    <span id="consultDivisionSel"></span>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-sm-3 control-label col-form-label" style="margin-bottom: 0">회원아이디</label>
                                <div class="col-sm-7 pl-0 pr-0">
                                    <span id="modalUserId"></span>
                                </div>
                            </div>
                            <!--<div class="form-group row">
                                <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">전화번호</label>
                                <input type="text" class="col-sm-2 form-control" style="display: inline-block;" id="telephone1">
                                -
                                <input type="text" class="col-sm-2 form-control" style="display: inline-block;" id="telephone2">
                                -
                                <input type="text" class="col-sm-2 form-control" style="display: inline-block;" id="telephone3">
                            </div>-->
                            <div class="form-group row" style="display: none;" id="modalIndate">
                                <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">접수일</label>
                                <div class="col-sm-6 pl-0 pr-0">
                                    <span id="indate"></span>
                                </div>
                            </div>
                            <div class="form-group row" style="display: none;" id="modalOkDate">
                                <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">완료일</label>
                                <div class="col-sm-6 pl-0 pr-0">
                                    <span id="procEndDate"></span>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                                <div class="form-group row">
                                    <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">작성자</label>
                                    <div class="col-sm-6 pl-0 pr-0">
                                        <span id="wirter"><%=name%></span>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">진행상태</label>
                                    <div class="col-sm-6 pl-0 pr-0">
                                        <span id="consultStatusSel"></span>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">회원이름</label>
                                    <span id="modalName"></span>
                                </div>
                                <div class="form-group row" style="display: none;" id="modalstartDate">
                                    <label class="col-sm-4 control-label col-form-label" style="margin-bottom: 0">처리시작일</label>
                                    <div class="col-sm-6 pl-0 pr-0">
                                        <span id="procStartDate"></span>
                                    </div>
                                </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">메모</label>
                        <input type="text" class="col-sm-6 form-control" style="display: inline-block;height: 100px;" id="memo" name="memo">
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">내용</label>
                        <input type="text" class="col-sm-6 form-control" style="display: inline-block;height: 100px;" id="contents" name="contents">
                    </div>
                        <button type="button" class="btn btn-info float-right m-l-2" style="margin-bottom: 10px;" id="saveBtn" onclick="counseltSave();">저장</button>
                </div>
                </div>
                <!-- //modal body -->
            </form>
        </div>
    </div>
</div>
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
