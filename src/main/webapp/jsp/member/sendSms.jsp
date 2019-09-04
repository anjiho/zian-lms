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
        fn_search('new');
    }

    function fn_search(val) {
        var paging = new Paging();
        var sPage = $("#sPage").val();

        if(val == "new")  sPage = "1";
        dwr.util.removeAllRows("dataList");
        gfn_emptyView("H", "");//페이징 예외사항처리

        var searchType = getSelectboxValue("memberSel");
        var searchText = getInputTextValue("searchText");
        if(searchType == null) searchType = "";
        memberManageService.getMemeberListCount(searchType, searchText, "", "", 1000, 10000, function(cnt) {
            paging.count(sPage, cnt, '10', '10', comment.blank_list);
            memberManageService.getMemeberList(sPage, '10', searchType, searchText, "", "", 1000, 10000, function (selList) {
                if (selList.length > 0) {
                    for (var i = 0; i < selList.length; i++) {
                        var cmpList = selList[i];
                        var checked = "";
                        if(cmpList.userId == userKey){
                            checked  = 'checked';
                        }
                        if (cmpList != undefined) {
                            var cellData = [
                                function(data) {return cmpList.userKey == null ? "-" : cmpList.userKey;},
                                function(data) {return cmpList.userId == null ? "-" : cmpList.userId;},
                                function(data) {return "<a href='javascript:void(0);' color='blue' style='' onclick='goMemberDetail(" + cmpList.userKey + ");'>" + cmpList.name + "</a>";},
                                function(data) {return cmpList.telephoneMobile == null ? "-" : cmpList.telephoneMobile;},
                                function(data) {return cmpList.affiliationName == null ? "-" : cmpList.affiliationName;},
                                function(data) {return "<input type='checkbox' name='rowChk'  value='"+ cmpList.userKey +"' "+ checked +">"},
                            ];
                            dwr.util.addRows("dataList", [0], cellData, {escapeHtml: false});
                        }
                    }
                    //회원목록에서 넘어온경우, sms회원목록에 추가 함수호출
                    if(userKey != "") addSmsMember();
                }else{
                    gfn_emptyView("V", comment.blank_list2);
                }
            });
        });
    }

    //회원 추가
    function addSmsMember() {
        if($("input[name=rowChk]:checked").length > 0){
            $("input[name=rowChk]:checked").each(function() {
                var tr = $(this).parent().parent();
                var td = tr.children();

                var userKey = $(this).val();
                var userId  = td.eq(1).text();
                var name    = td.eq(2).text();
                var userMobile = td.eq(3).text();

                //회원 중복체크
                var resKeys = get_array_values_by_name("input", "userKey");
                if ($.inArray(userKey, resKeys) != '-1') {
                    return;
                }

                var delBtn = "<button type=\"button\" onclick=\"deleteTableRow('addMemberTabel', 'delBtn')\" class=\"btn btn-outline-danger btn-sm delBtn\">삭제</button>";
                var cellData = [
                    function() {return "<input type='hidden' name='userKey' value='"+ userKey +"'>";},
                    function() {return userId;},
                    function() {return name;},
                    function() {return userMobile;},
                    function() {return delBtn;}
                ];
                dwr.util.addRows("addMemberList", [0], cellData, {escapeHtml: false});
                $('#addMemberList tr').each(function(){
                    var tr = $(this);
                    tr.children().eq(0).attr("style", "display:none");//bankKey hidden
                });
            });
        }else{
            if(userKey == "") {
                alert("회원을 선택해 주세요.");
                return false;
            }
        }
    }

    function sendSms() {
        if($('#addMemberTabel tbody tr').length > 0){
            var SmsArr = new Array();    // 배열 선언
            if(confirm("메세지를 보내시겠습니까?")){
                $('#addMemberTabel tbody tr').each(function(index){
                    var userKey = $(this).find("td input").eq(0).val();
                    var receiverPhoneNumber = $(this).find("td").eq(3).text();
                    var split_receivernumber = receiverPhoneNumber.split("-");
                    var receiverPhoneNumber2 = split_receivernumber[0]+split_receivernumber[1]+split_receivernumber[2];


                    var sendNumber = $("#sendNumber").val();
                    var split_number = sendNumber.split("-");
                    var sendNumber2 = split_number[0]+split_number[1]+split_number[2];

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
            <div class="col-md-7">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title mb-4">회원목록</h5>
                        <div>
                            <div style="width:20%;float:left;margin-bottom:20px">
                                <span id="l_searchSel"></span>
                            </div>
                            <div style="width: 33%;float:left;margin-left:5px">
                                <input type="text" class="form-control" id="searchText" onkeypress="if(event.keyCode==13) {fn_search('new'); return false;}">
                            </div>
                            <div style="width:33%;float:left;margin-left:10px">
                                <button type="button" class="btn btn-outline-info mx-auto" onclick="fn_search('new')">검색</button>
                            </div>
                            <div style="float:right;">
                              <button type="button" onclick="addSmsMember();" class="btn btn-info btn-sm">추가</button>
                            </div>
                        </div>
                        <table class="table table-hover">
                            <thead>
                            <tr>
                                <th scope="col" width="10%">CODE</th>
                                <th scope="col" width="20%">ID</th>
                                <th scope="col" width="10%">이름</th>
                                <th scope="col" width="20%">휴대전화</th>
                                <th scope="col" width="17%">권한</th>
                                <th scope="col" width="3%"><input type="checkbox" id="allCheck" onclick="allChk(this, 'rowChk');"></th>
                            </tr>
                            </thead>
                            <tbody id="dataList"></tbody>
                            <tr>
                                <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
                            </tr>
                        </table>
                        <%@ include file="/common/inc/com_pageNavi.inc" %>
                    </div>
                </div>
            </div>
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
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title mb-4">추가된 회원목록</h5>
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
<!-- // 기본소스-->
<!-- End Container fluid  -->
<%@include file="/common/jsp/footer.jsp" %>

