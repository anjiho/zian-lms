<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/memberManageService.js'></script>
<script>
    function init() {
        searchMileageSelectBox("l_searchSel");
        menuActive('menu-5', 8);
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

        memberManageService.getMileageListCount(searchType, searchText, function (cnt) {
            paging.count(sPage, cnt, '10', '10', comment.blank_list);
            var listNum = ((cnt-1)+1)-((sPage-1)*10); //리스트 넘버링
            memberManageService.getMileageList(sPage, pagingListCount(), searchType, searchText, function (selList) {
                if (selList.length == 0) return;
                dwr.util.addRows("dataList", selList, [
                    function(data) {return data.userId == null ? "-" : data.userId;},
                    function(data) {return data.name == null ? "-" : data.name;},
                    function(data) {return data.indate == null ? "-" : data.indate;},
                    function(data) {return data.description == null ? "-" : data.description;},
                    function(data) {return data.point == null ? "-" : data.type ==1? addThousandSeparatorCommas(data.point) : addThousandSeparatorCommas(data.point);},
                ], {escapeHtml:false});
            });
            loadingOut(loading);
        });
    }

    //쿠폰 등록 팝업
    function mileageProduce() {
        $('.modal-dialog').css('max-width','1200px');

        dwr.util.removeAllRows("dataList3"); //테이블 리스트 초기화
        dwr.util.removeAllRows("selectUserList"); //테이블 리스트 초기화
        gfn_emptyView("H", "");//페이징 예외사항처리

        searchMemberSelectBox('userSelect','');
        mileageTypeSelectBox('typeSelect');
        fn_search3("new");
    }

    //팝업 Close 기능
    function close_pop(flag) {
        $('#myModal').hide();
    };

    //팝업 저장 기능
    function modify() {
        if($('#selectUserList tr').length > 0){

            var usersArr = new Array(); // 배열 선언

            $('#selectUserList  tr').each(function(index){
                var $this = $(this);
                var userKey=$this.find('input[name="res_key[]"]').val();
                var data = {
                    userKey: Number(userKey),
                };
                usersArr.push(data);
            });
            var typeSelect = getSelectboxValue('typeSelect');
            var point = getInputTextValue('point');

            if(typeSelect ==0) point=point*-1;
            var memo = getInputTextValue('memo');
            var jKey=0;
            var jId="";
            var descType=0;

            memberManageService.issueMileageToUser(usersArr,typeSelect,point,memo,jKey,jId,descType, function () {
                alert("지급 완료되었습니다.");
                isReloadPage();
            });
        }else{
            alert("추가된 회원 목록이 없습니다.");
            return false;
        }
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
        var authorityName = td.eq(5).text();
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
        selectUserListHtml     += "<span>" + authorityName + "</span>";
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
</script>
<div class="page-breadcrumb">
    <input type="hidden" id="sPage">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">마일리지 관리</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">회원관리</li>
                        <li class="breadcrumb-item active" aria-current="page">마일리지 관리</li>
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
                            <button type="button" data-toggle="modal" data-target="#myModal"   class="btn btn-outline-info mx-auto" onclick="mileageProduce()">마일리지 등록</button>
                        </div>
                    </div>
                </div>
                    <!--상품별 디바이스 TABLE-->
                    <table class="table table-hover">
                        <thead>
                        <tr>
                            <th scope="col" style="width: 10%;">ID</th>
                            <th scope="col" style="width: 10%;">이름</th>
                            <th scope="col" style="width: 20%;">일시</th>
                            <th scope="col" style="width: 40%;">내역</th>
                            <th scope="col" style="width: 20%;">포인트</th>
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

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document" style="max-width:1200px;max-height: 200px;">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">마일리지 등록</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form>
                <input type="hidden" id="key" value="">
                <!-- modal body -->
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-7">
                            <div class="card">
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
                        </div>
                        <div class="col-md-1">
                            <div class="card">

                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card">
                                <table class="table table-hover text-center" style="margin-top:51px" id="userAdd">
                                    <thead>
                                    <tr>
                                        <th scope="col" width="30%">ID</th>
                                        <th scope="col" width="35%">이름</th>
                                        <th scope="col" width="20%">권한</th>
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
                    <hr style="width: 100%;color:#6c757d" noshade >
                    <div class="col-hd-1">
                        <div class="card">

                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-7">
                            <div class="card">
                                <div class="form-group row">
                                    <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">타입</label>
                                    <span id="typeSelect"></span>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">포인트</label>
                                    <input type="text" class="col-sm-2 form-control" style="display: inline-block;" id="point">
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">지급 내용</label>
                                    <input type="text" class="col-sm-4 form-control" style="display: inline-block;" id="memo">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div style="text-align: center;">
                        <button type="button" class="btn btn-info" style="text-align: center" onclick="modify();">등록</button>
                    </div>
                </div>
                <!-- //modal body -->
            </form>
        </div>
    </div>
</div>


<%@include file="/common/jsp/footer.jsp" %>
