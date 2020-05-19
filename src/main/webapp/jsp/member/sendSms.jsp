<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<%
    String userKey = request.getParameter("param_key");
%>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/memberManageService.js'></script>
<script>
    $( document ).ready(function() {
        $('#stateModal').on('hidden.bs.modal', function (e) {
            $('form').each(function () {
                this.reset();
            });
        });

        $('#userSearchType').click(function(){
            var type = getSwitchValue("userSearchType");
            if(type==1){
                $('.directUpload').show();
                $('.searchUpload').hide();
                $('.modal-dialog').css('max-width','1000px');

            }else{
                $('.directUpload').hide();
                $('.searchUpload').show();
                $('.modal-dialog').css('max-width','1700px');
            }
        })
    });

    $(document).keypress(function(e) {
        if (e.keyCode == 13){
            var type = getSwitchValue("userSearchType");
            if(type==0) {
                alert("'검색' 버튼을 직접 눌러서 검색해주세요.");
                e.preventDefault();
            }
        }
    });

    var userKey = '<%=userKey%>';
    function init() {
        menuActive('menu-5', 6);
        //탭 메뉴 색상 변경
        $("#playForm ul").each(function(idx) {
            var ul = $(this);
            ul.find("li").addClass("done").attr("aria-selected", "false");
            ul.find("li").eq(0).removeClass("done").attr("aria-selected", "true");
        });

        var key = "";
        if(userKey != "") key = "id";
        else key = "";
        getMemberSearchSelectbox("l_searchSel", key);
        $("#searchText").val(userKey);
    }
    function memberAddPopup(){
        var type=getSwitchValue('type');
        if (type==0){
            $('.modal-dialog').css('max-width','1700px');
        }else $('.modal-dialog').css('max-width','600px');

        dwr.util.removeAllRows("selectUserList");
        isSwitchByNumber("userSearchType", 0);
        searchMemberSelectBox('userSelect','');
        $('.directUpload').hide();
        $('.searchUpload').show();
        fn_search3('new');
    }

    function fn_search3(val) {
        var paging = new Paging();
        var sPage=getInputTextValue("sPage3");
        var searchText=getInputTextValue('mileageUser');
        var searchType=getSelectboxValue('userSelect');

        if(searchType == undefined) searchType = "";
        if(val == "new") sPage = "1";

        dwr.util.removeAllRows("dataList3"); //테이블 리스트 초기화
        gfn_emptyView3("H", "");//페이징 예외사항처리

        memberManageService.getMemberSelectListCount(searchType, searchText, function (cnt) {
            paging.count3(sPage, cnt, '10', '10', comment.blank_list);
            var listNum = ((cnt-1)+1)-((sPage-1)*10); //리스트 넘버링
            memberManageService.getMemberSelectList(sPage, 5, searchType, searchText, function (selList) {
                if (selList.length == 0) return;
                var SelBtn = '<input type="button" onclick="sendUserSelect($(this))" value="선택" style="margin-top: -6px;" class="btn btn-info btn-sm"/>';
                dwr.util.addRows("dataList3", selList, [
                    function(data) {return '<input type="hidden" name="userKey[]" value=' + "'" + data.userKey + "'" + '>';},
                    function(data) {return data.userId == null ? "-" : data.userId;},
                    function(data) {return data.name == null ? "-" :data.name;},
                    function(data) {return data.telephoneMobile == null ? "-" :data.telephoneMobile;},
                    function(data) {return data.affiliationName == null ? "-" : data.affiliationName;},
                    function(data) {return data.authorityName == null ? "-" : data.authorityName;},
                    function(data) {return SelBtn;},
                ], {escapeHtml:false});
            });
        });
    }

    function sendUserSelect(val) {
        var checkBtn = val;
        var tr = checkBtn.parent().parent();
        var td = tr.children();
        var userKey =  td.find("input").eq(0).val();
        var userId = td.eq(1).text();
        var userName = td.eq(2).text();
        var telPhone = td.eq(3).text();
        var userKeyChk = get_array_values_by_name("input", "res_key[]");

        if ($.inArray(userKey, userKeyChk) != '-1') {
            alert("이미 선택된 회원입니다.");
            return;
        }

        var selectUserListHtml = "<tr scope='col' colspan='3'>";
        selectUserListHtml     += " <td>";//userKey
        selectUserListHtml     += "<input type='hidden'  value='" + userKey + "' name='res_key[]'>";
        selectUserListHtml     += "</td>";
        selectUserListHtml     += " <td>";
        selectUserListHtml     += "<span>" + userId + "</span>";
        selectUserListHtml     += "</td>";
        selectUserListHtml     += " <td>";
        selectUserListHtml     += "<span>" + userName + "</span>";
        selectUserListHtml     += "</td>";
        selectUserListHtml     += " <td>";
        selectUserListHtml     += "<span>" + telPhone + "</span>";
        selectUserListHtml     += "</td>";
        selectUserListHtml     += " <td>";
        selectUserListHtml     += "<button type=\"button\" onclick=\"deleteTableRow('selectUserList', 'delBtn')\" class=\"btn btn-outline-danger btn-sm delBtn\">삭제</button>";
        selectUserListHtml     += "</td>";
        $('#userAdd > tbody:first').append(selectUserListHtml);
        $('#selectUserList tr').each(function(){
            var tr = $(this);
            tr.children().eq(0).attr("style", "display:none");
        });
    }

    function directUserSelect(){
        var txtBox = getInputTextValue('directPhone');
        var lines =  txtBox.split("\n");

        var userKey="";
        var userId="";
        var userName="";

        for (var i = 0; i < lines.length; i++) {
            var telPhone= lines[i];
            if(telPhone !="") {

                var selectUserListHtml = "<tr scope='col' colspan='3'>";
                selectUserListHtml += " <td>";//userKey
                selectUserListHtml += "<input type='hidden'  value='" + userKey + "' name='res_key[]'>";
                selectUserListHtml += "</td>";
                selectUserListHtml += " <td>";
                selectUserListHtml += "<span>" + userId + "</span>";
                selectUserListHtml += "</td>";
                selectUserListHtml += " <td>";
                selectUserListHtml += "<span>" + userName + "</span>";
                selectUserListHtml += "</td>";
                selectUserListHtml += " <td>";
                selectUserListHtml += "<span>" + telPhone + "</span>";
                selectUserListHtml += "</td>";
                selectUserListHtml += " <td>";
                selectUserListHtml += "<button type=\"button\" onclick=\"deleteTableRow('selectUserList', 'delBtn')\" class=\"btn btn-outline-danger btn-sm delBtn\">삭제</button>";
                selectUserListHtml += "</td>";

                $('#userAdd > tbody:first').append(selectUserListHtml);
                $('#selectUserList tr').each(function () {
                    var tr = $(this);
                    tr.children().eq(0).attr("style", "display:none");
                });
            }
        }
    }

    //회원 추가
    function addSmsMember() {
        if($('#selectUserList tr').length > 0){
            $('#selectUserList  tr').each(function(index){
                var tr = $(this);
                var td = tr.children();

                var userKey =  td.eq(0).text();
                var userId  = td.eq(1).text();
                var name    = td.eq(2).text();
                var telPhone = td.eq(3).text();

                //회원 중복체크
                /*var resKeys = get_array_values_by_name("input", "userKey");
                if ($.inArray(userKey, resKeys) != '-1') {
                    return;
                }*/

                var overlapCheck = 0;

                $('#addMemberList tr').each(function(){
                    var tr2 = $(this);
                    if(telPhone == tr2.children().eq(3).text()) overlapCheck =1;
                });

                if(overlapCheck == 0){
                    var delBtn = "<button type=\"button\" onclick=\"deleteTableRow('addMemberTabel', 'delBtn')\" class=\"btn btn-outline-danger btn-sm delBtn\">삭제</button>";
                    var cellData = [
                        function() {return "<input type='hidden' name='userKey' value='"+ userKey +"'>";},
                        function() {return userId;},
                        function() {return name;},
                        function() {return telPhone;},
                        function() {return delBtn;}
                    ];
                    dwr.util.addRows("addMemberList", [0], cellData, {escapeHtml: false});
                    $('#addMemberList tr').each(function(){
                        var tr = $(this);
                        tr.children().eq(0).attr("style", "display:none");//bankKey hidden
                    });
                }
            });
        }else{
            if(userKey == "") {
                alert("회원을 선택해 주세요.");
                return false;
            }
        }
        $('#stateModal').modal("hide");
    }

    function sendSms() {
        if($('#addMemberTabel tbody tr').length > 0){
            var SmsArr = new Array();    // 배열 선언
            if(confirm("메세지를 보내시겠습니까?")){
                $('#addMemberTabel tbody tr').each(function(index){
                    var userKey = $(this).find("td input").eq(0).val();
                    var receiverPhoneNumber = $(this).find("td").eq(3).text();
                    var split_receivernumber = receiverPhoneNumber.split("-");
                    var receiverPhoneNumber2 = split_receivernumber[0]+gfn_isundefinedvalue(split_receivernumber[1],"")+gfn_isundefinedvalue(split_receivernumber[2],"");

                    var sendNumber = $("#sendNumber").val();
                    var split_number = sendNumber.split("-");
                    var sendNumber2 = split_number[0]+gfn_isundefinedvalue(split_number[1],"")+gfn_isundefinedvalue(split_number[2],"");

                    var msg = $("#className").val();
                    var data = {
                        receiverPhoneNumber: receiverPhoneNumber2,
                        sendNumber: sendNumber2,
                        msg: msg,
                        userKey: Number(userKey),
                    };
                    SmsArr.push(data);
                });
                memberManageService.sendSms(SmsArr, function () {isReloadPage();});
            }
        }else{
                alert("추가된 회원목록이 없습니다.");
                return false;
        }
    }

</script>
<input type="hidden" id="sPage">
<div class="page-breadcrumb">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">SMS 보내기</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">회원 관리</li>
                        <li class="breadcrumb-item active" aria-current="page">SMS 보내기</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</div>
<!--//순서-->
<!-- 기본 소스-->
<div class="container-fluid">
    <div class="form-group">
        <div class="row">

            <div class="col-md-5">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">메세지</h5>
                        <div style="border: 1px solid #f4f4f4;padding:10px 15px">
                            <textarea class="form-control" name="className"  id="className" maxlength="80" onkeyup="pubByteCheckTextarea('#className','#classCount','80');" style="width:100%;height:226px;padding:5px 5px;resize:none;border:none" placeholder="메세지 내용을 입력해주세요."></textarea>
                            <div>
                                <span class="count" id="classCount">0 / 80 Byte</span>
                            </div>
                        </div>
                    </div>
                    <div class="card-body border-top">
                        <div class="row">
                            <label class="col-3 pt-2" style="vertical-align:middle">보내는사람 : </label>
                            <input type="text" class="col-7 form-control" id="sendNumber" name="sendNumber" value="02-6080-1725" />
                            <button type="button" onclick="sendSms();" class="btn btn-primary btn-sm float-right" style="margin-left:20px;width:60px">보내기</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-5">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title mb-4" style="float: left;padding-top: 8px;">추가된 회원목록</h5>
                        <button type="button" class="btn btn-outline-info mx-auto float-right" data-toggle="modal" data-target="#stateModal" onclick="memberAddPopup();"><i class="mdi mdi-file-excel"></i>회원 추가</button>
                        <table class="table table-hover" id="addMemberTabel">
                            <thead>
                            <tr>
                                <th scope="col" width="28%">ID</th>
                                <th scope="col" width="14%">이름</th>
                                <th scope="col" width="28%">휴대전화</th>
                                <th scope="col" width="10%">삭제</th>
                            </tr>
                            </thead>
                            <tbody id="addMemberList"></tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 회원 추가 팝업창 --->
<div class="modal fade" id="stateModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document" style="max-width:1700px;max-height: 200px;">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">회원 목록</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form>
                <input type="hidden" id="key" value="">
                <!-- modal body -->
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="searchUpload card">
                                <div class="form-group row">
                                    <span id="userSelect"></span>
                                    <div class="col-sm-4">
                                        <input type="text" class="form-control" id="mileageUser">
                                    </div>
                                    <div style="text-align: center;">
                                        <button type="button" class="btn btn-info" style="text-align: center" onclick="fn_search3('new');">검색</button>
                                    </div>
                                </div>

                                <table class="table table-hover text-center">
                                    <thead>
                                    <tr>
                                        <th scope="col" width="1%"></th>
                                        <th scope="col" width="13%">ID</th>
                                        <th scope="col" width="13%">이름</th>
                                        <th scope="col" width="20%">휴대전화</th>
                                        <th scope="col" width="12%">직렬</th>
                                        <th scope="col" width="12%">권한</th>
                                        <th scope="col" width="10%"></th>
                                    </tr>
                                    </thead>
                                    <tbody id="dataList3"></tbody>
                                    <tr>
                                        <td id="emptys3" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
                                    </tr>
                                </table>
                                <div>
                                    <input type="hidden" id="sPage3" >
                                    <%@ include file="/common/inc/com_pageNavi3.inc" %>
                                </div>
                            </div>
                            <div class="directUpload card">
                                <button type="button" class="btn btn-outline-info mx-auto float-right" onclick="directUserSelect();">회원 추가</button>
                                <textarea id="directPhone" style="width: 500px; height: 300px; margin-top:12px; float:left;"></textarea>
                            </div>
                        </div>
                        <div class="col-md-1">
                            <div class="card">
                            </div>
                        </div>
                        <div class="col-md-5">
                            <div class="card">
                                <table class="table table-hover text-center" style="margin-top:51px" id="userAdd">
                                    <thead>
                                    <tr>
                                        <th scope="col" width="20%">ID</th>
                                        <th scope="col" width="20%">이름</th>
                                        <th scope="col" width="45%">휴대전화 번호</th>
                                        <th scope="col" width="15%"></th>
                                    </tr>
                                    </thead>
                                    <tbody id="selectUserList"></tbody>
                                    <tr>
                                        <td id="selectUserEmptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="online form-group row mt-4">
                        <div class="col-sm-10">
                            <div style="margin-top: -23px;">
                                회원검색
                                <label class="switch">
                                    <input type="checkbox" id="userSearchType" name="userSearchType" style="display:none;">
                                    <span class="slider"></span>
                                </label>
                                직접검색
                            </div>
                        </div>
                    </div>
                    <div style="text-align: center;">
                        <button type="button" class="btn btn-info" style="text-align: center" onclick="addSmsMember();">추가</button>
                    </div>

                </div>
                <!-- //modal body -->
            </form>
        </div>
    </div>
</div>
<!-- // 기본소스-->
<!-- End Container fluid  -->
<%@include file="/common/jsp/footer.jsp" %>

