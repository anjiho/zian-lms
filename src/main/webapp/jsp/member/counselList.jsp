<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/memberManageService.js'></script>
<script>
    function init() {
        searchCounselSelectBox("l_searchSel");
        menuActive('menu-5', 3);
        fn_search('new');
    }

    //상담내역 불러오기
    function fn_search(val) {
        var paging = new Paging();
        var sPage = getInputTextValue("sPage");
        var searchType = getSelectboxValue("searchCounselSel");
        var searchText = getInputTextValue("searchText");

        if (searchType == null) searchType = "";
        if (val == "new") sPage = "1";

        dwr.util.removeAllRows("dataList");
        gfn_emptyView("H", "");

        var loading = new Loading({
            direction: 'hor',
            discription: '검색중',
            animationIn: false,
            animationOut: false,
            defaultApply: 	true,
        });

        memberManageService.getCounselListCount(searchType, searchText, function (cnt) {
            paging.count(sPage, cnt, '10', '10', comment.blank_list);
            var listNum = ((cnt-1)+1)-((sPage-1)*10); //리스트 넘버링
            memberManageService.getCounselList(sPage, pagingListCount(), searchType, searchText, function (selList) {
                if (selList.length == 0) return;
                if (selList.length > 0) {
                    for (var i = 0; i < selList.length; i++) {
                        var cmpList = selList[i];
                        if (cmpList != undefined) {
                            var userIdHTML = "<a href='javascript:void(0);' color='blue'  data-toggle=\"modal\" data-target=\"#consultModal\" onclick='modifyConsult("+ cmpList.counselKey +");'>"+cmpList.userId+"</a>";
                            var cellData = [
                                function() {return listNum--;},
                                function() {return cmpList.userId == null ? "-" : userIdHTML;},//유저id
                                function() {return cmpList.name == null ? "-" : cmpList.name;},
                                function() {return cmpList.indate == null ? "-" : cmpList.typeName;},//상담구분
                                function() {return cmpList.telephone+"<br>"+cmpList.telephoneMobile;},//연락처
                                function() {return cmpList.indate == null ? "-" : cmpList.indate;},
                                function() {return cmpList.procStartDate == null ? "-" : cmpList.procStartDate;},
                                function() {return cmpList.procEndDate == null ? "-" : cmpList.procEndDate ;},
                            ];
                            dwr.util.addRows("dataList", [0], cellData, {escapeHtml: false});
                        }
                    }
                }

            });
            loadingOut(loading);
        });
    }

    function modifyConsult(counselKey){
        $("#modalIndate, #modalOkDate, #modalstartDate").show(); //처리날짜들 보여주기
        $(".modal-title").text("상담 상세");//팝업창 헤드text값
        $("#counselKey").val(counselKey);
        memberManageService.getCounselDetailInfo(counselKey, function (info) {
            innerValue("userKey", info.userKey);
            innerHTML("wirter", info.writeUserName + "(" + info.writeUserId + ")");
            innerHTML("modalUserId", info.userId);
            innerHTML("modalName", info.userName);
            innerValue("memo", info.memo);
            innerValue("contents", info.contents);
            innerHTML("indate", getDateTimeSplitComma(info.indate));
            innerHTML("procEndDate", getDateTimeSplitComma(info.procEndDate));
            innerHTML("procStartDate", getDateTimeSplitComma(info.procStartDate));
            getConsultDivisionSelectBox("consultDivisionSel", info.type);
            getConsultStatusSelectBox("consultStatusSel", info.status);
        });
    }

    /* 상담 수정 */
    function counselSave(){
        var counselKey = $("#counselKey").val();
        var userKey = getInputTextValue("userKey");
        if (confirm("수정 하시겠습니까?")) {
            var type      = getSelectboxValue("consultDivisionSel");
            var status    = getSelectboxValue("consultStatusSel");
            var memo      = getInputTextValue("memo");
            var contents  = getInputTextValue("contents");
            var telephone = getInputTextValue("telephone1") + "-" + getInputTextValue("telephone2") + "-" + getInputTextValue("telephone3");
            var telephoneMobile = getInputTextValue("telephoneMobile1") + "-" + getInputTextValue("telephoneMobile2") + "-" + getInputTextValue("telephoneMobile3");
            var counselObj = {
                counselKey: counselKey,
                cKey: 0,
                userKey: userKey,
                writeUserKey: "",
                type: type,
                status: status,
                //telephone: telephone,
                //telephoneMobile: telephoneMobile,
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
            memberManageService.updateCounselInfo(counselObj, function (selList) {
                alert("수정이 완료되었습니다.");
                isReloadPage(true);
            });
        }
    }
</script>
<div class="page-breadcrumb">
    <input type="hidden" id="sPage">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">상담내역</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">회원관리</li>
                        <li class="breadcrumb-item active" aria-current="page">상담내역</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</div>
<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <div>
                        <div style=" float: left; width: 10%">
                            <span id="l_searchSel"></span>
                        </div>
                        <div style=" float: left; width: 33%; margin-left: 10px">
                            <input type="text" class="form-control" id="searchText" onkeypress="if(event.keyCode==13) {fn_search('new'); return false;}">
                        </div>
                        <div style=" float: left; width: 33%; margin-left: 10px;">
                            <button type="button" class="btn btn-outline-info mx-auto" onclick="fn_search('new')">검색</button>
                        </div>
                    </div>
                </div>
                    <!--상품별 디바이스 TABLE-->
                    <table class="table table-hover">
                        <thead>
                        <tr>
                            <th scope="col" style="width: 5%;">No.</th>
                            <th scope="col" style="width: 10%;">ID</th>
                            <th scope="col" style="width: 10%;">이름</th>
                            <th scope="col" style="width: 8%;">상담구분</th>
                            <th scope="col" style="width: 10%;">연락처</th>
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
        </div>
    </div>
</div>

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
                        <input type="hidden" id="userKey" value="">
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
                                    <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">진행상태</label>
                                    <div class="col-sm-6 pl-0 pr-0">
                                        <span id="consultStatusSel"></span>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">작성자</label>
                                    <div class="col-sm-6 pl-0 pr-0">
                                        <span id="wirter"></span>
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
                            <textarea class="col-sm-7 form-control" id="memo" name="memo" rows="7"></textarea>
<%--                            <input type="text" class="col-sm-6 form-control" style="display: inline-block;height: 100px;" id="memo" name="memo">--%>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">내용</label>
                            <textarea class="col-sm-7 form-control" id="contents" name="contents" rows="7"></textarea>
<%--                            <input type="text" class="col-sm-6 form-control" style="display: inline-block;height: 100px;" id="contents" name="contents">--%>
                        </div>
                        <button type="button" class="btn btn-info float-right m-l-2" style="margin-bottom: 10px;" id="saveBtn" onclick="counselSave();">수정</button>
                    </div>
                </div>
                <!-- //modal body -->
            </form>
        </div>
    </div>
</div>


<%@include file="/common/jsp/footer.jsp" %>
