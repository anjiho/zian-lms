<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<style>
    ol,ul{list-style:none}

    button{margin:0;padding:0;font-family:inherit;border:0 none;background:transparent;cursor:pointer}
    button::-moz-focus-inner{border:0;padding:0}
    .searchDate{overflow:hidden;margin-bottom:-3px;*zoom:1;margin-left: -7%;}
    .searchDate:after{display:block;clear:both;content:''}
    .searchDate li{position:relative;float:left;margin:0 7px 0 0}
    .searchDate li .chkbox2{display:block;text-align:center}
    .searchDate li .chkbox2 input{position:absolute;z-index:-1}
    .searchDate li .chkbox2 label{display:block;width:77px;height:26px;font-size:14px;font-weight:bold;color:#fff;text-align:center;line-height:25px;text-decoration:none;cursor:pointer;background:#02486f}
    .searchDate li .chkbox2.on label{background:#ec6a6a}
</style>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/orderManageService.js'></script>
<script type='text/javascript' src='/dwr/interface/productManageService.js'></script>
<script>
    function init() {
        menuActive('menu-3', 10);
        getProductSearchTypeSelectbox("l_productSearch");
        fn_search('new');
    }

    function fn_search(val) {
        var paging = new Paging();
        var sPage = getInputTextValue("sPage3");
        var searchType = getSelectboxValue("searchType");
        var searchText = getInputTextValue("optionSearchType");
        if(searchType == undefined) searchType = "";

        if(val == "new") sPage = "1";

        dwr.util.removeAllRows("dataList");
        gfn_emptyView("H", "");//페이징 예외사항처리

        productManageService.getProductListCount(searchType, searchText, "ACADEMY", function (cnt) {
            paging.count(sPage, cnt, pagingListCount(), pagingListCount(), comment.blank_list);
            var listNum = ((cnt-1)+1)-((sPage-1)*10); //리스트 넘버링
            productManageService.getProductList(sPage, 10, searchType, searchText, "ACADEMY", function (selList) {
                if (selList.length == 0) return;
                var SelBtn = '<input type="button" onclick="sendChildValue_2($(this))" value="선택" class="btn btn-outline-info"/>';
                dwr.util.addRows("dataList", selList, [
                    function(data) {return data.GKey;},
                    function(data) {return "<a href='javascript:void(0);' color='blue' style='float:left' onclick='goModifyAcademyLecture(" + data.GKey + ");'>" + data.goodsName + "</a>";},
                    function(data) {return data.isShow == 0 ?  "<i class='mdi mdi-close' style='color: red'></i>" : "<i class='mdi mdi-check' style='color:green;'></i>";},
                    function(data) {return data.isSell == 0 ?  "<i class='mdi mdi-close' style='color: red'></i>" : "<i class='mdi mdi-check' style='color:green;'></i>";},
                    function(data) {return data.isFree == 0 ?  "<i class='mdi mdi-close' style='color: red'></i>" : "<i class='mdi mdi-check' style='color:green;'></i>";},
                ], {escapeHtml:false});
                $('#dataList tr').each(function(){
                    var tr = $(this);
                    //tr.children().eq(0).attr("style", "display:none");
                    //tr.children().eq(1).attr("style", "display:none");
                });
            });
        });
    }
</script>
<div class="page-breadcrumb">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">학원수강 관리</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">주문관리</li>
                        <li class="breadcrumb-item active" aria-current="page">학원수강 관리</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</div>
<!-- 기본 소스-->
<div class="">
    <div class="form-group">
        <div class="card">
            <div class="card-body">
                <div class="col-md-12">
                    <div class="col">
                        <div class="form-group row">
                            <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">이탈자 확인</label>
                            <span></span>
                            <button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#lectureModal">강좌찾기</button>
                        </div>
                        <div class="form-group row" id="lecDiv" style="display:none;">
                            <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">검색강좌</label>
                            <span></span>




                        </div>
                        <div class="form-group row" id="connectDiv" style="display:none;">
                            <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">연계강좌</label>
                            <div class="col-sm-6 pl-0 pr-0">
                                <span id=""></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- //formgroup -->
<div class="row">
    <div class="col-md-12">
        <div class="card">
            <div class="card-body">
                <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">연계수강자</label>
                <table class="table table-hover">
                    <thead>
                    <tr>
                        <th scope="col" width="5%">CODE</th>
                        <th scope="col" width="8%">ID</th>
                        <th scope="col" width="8%">이름</th>
                        <th scope="col" width="14%">휴대전화</th>
                        <th scope="col" width="14%">E-Mail</th>
                        <th scope="col" width="10%">등록일</th>
                        <th scope="col" width="5%">직렬</th>
                        <th scope="col" width="5%">등급</th>
                        <th scope="col" width="10%">등급변경일</th>
                        <th scope="col" width="5%">권한</th>
                        <th scope="col" width="10%">모바일가입</th>
                        <th scope="col" width="5%">연결</th>
                    </tr>
                    </thead>
                    <tbody id="connectList"></tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="col-md-12">
        <div class="card">
            <div class="card-body">
                <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">신규수강자</label>
                <table class="table table-hover">
                    <thead>
                    <tr>
                        <th scope="col" width="5%">CODE</th>
                        <th scope="col" width="8%">ID</th>
                        <th scope="col" width="8%">이름</th>
                        <th scope="col" width="14%">휴대전화</th>
                        <th scope="col" width="14%">E-Mail</th>
                        <th scope="col" width="10%">등록일</th>
                        <th scope="col" width="5%">직렬</th>
                        <th scope="col" width="5%">등급</th>
                        <th scope="col" width="10%">등급변경일</th>
                        <th scope="col" width="5%">권한</th>
                        <th scope="col" width="10%">모바일가입</th>
                        <th scope="col" width="5%">연결</th>
                    </tr>
                    </thead>
                    <tbody id="newMemberList"></tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="col-md-12">
        <div class="card">
            <div class="card-body">
                <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">이탈자</label>
                <table class="table table-hover">
                    <thead>
                    <tr>
                        <th scope="col" width="5%">CODE</th>
                        <th scope="col" width="8%">ID</th>
                        <th scope="col" width="8%">이름</th>
                        <th scope="col" width="14%">휴대전화</th>
                        <th scope="col" width="14%">E-Mail</th>
                        <th scope="col" width="10%">등록일</th>
                        <th scope="col" width="5%">직렬</th>
                        <th scope="col" width="5%">등급</th>
                        <th scope="col" width="10%">등급변경일</th>
                        <th scope="col" width="5%">권한</th>
                        <th scope="col" width="10%">모바일가입</th>
                        <th scope="col" width="5%">연결</th>
                        <!--<th scope="col" width="8%">배송상태</th>-->
                        <th scope="col" width="3%"><input type="checkbox" id="allCheck" onclick="allChk(this, 'rowChk');"></th>
                    </tr>
                    </thead>
                    <tbody id="outList"></tbody>
                </table>
                <%@ include file="/common/inc/com_pageNavi.inc" %>
            </div>
        </div>
    </div>
</div>
</div>
<!-- // 기본소스-->
</div>

<!-- 학원강의 팝업창-->
<div class="modal fade" id="lectureModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document" style="max-width: 1000px;">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">상품 선택</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form>
                <!-- modal body -->
                <div class="modal-body" style="padding: 1.25rem;">
                    <div style=" display:inline;">
                        <div style=" float: left; width: 10%">
                            <span id="l_productSearch"></span>
                        </div>
                        <div style=" float: left; width: 33%">
                            <input type="text" class="form-control" id="optionSearchType" onkeypress="if(event.keyCode==13) {fn_search('new'); return false;}">
                        </div>
                        <div style=" float: left; width: 33%">
                            <button type="button" class="btn btn-outline-info mx-auto" onclick="fn_search('new')">검색</button>
                        </div>
                    </div>
                    <div class="table-responsive">
                        <input type="hidden" id="sPage" >
                        <table id="zero_config" class="table table-hover text-center">
                            <thead class="thead-light">
                            <tr>
                                <th scope="col" style="width:5%;">CODE</th>
                                <th scope="col" style="width:40%;">상품명</th>
                                <th scope="col" style="width: 5%;">노출</th>
                                <th scope="col" style="width: 5%;">판매</th>
                                <th scope="col" style="width: 5%;">무료</th>
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
                <!-- //modal body -->
            </form>
        </div>
    </div>
</div>

<script>
    $("#searchStartDate , #searchEndDate").datepicker({
        language: "kr",
        format: "yyyy-mm-dd",
        numberOfMonths: 2
    });
</script>
<!--main wapper-->
<%@include file="/common/jsp/footer.jsp" %>
