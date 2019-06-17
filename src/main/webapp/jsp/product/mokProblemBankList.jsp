<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/productManageService.js'></script>
<script>
    function init() {
        getProductSearchSelectbox("l_searchSel");
        menuActive('menu-1', 11);
        fn_search('new');

        getMockYearSelectbox("l_examYearGroup","");//출제년도
        getSelectboxListdivisionCtgKey("l_examType", 4390, "");//출제구분
        getNewSelectboxListForCtgKey2("l_subjectGroup", "70", "");//과목
        getAnswerSelectbox("l_answerType", "");//정답
        getExamLevelSelectbox("l_examLevel", "");//난이도
        getTypeSelectbox("l_Type", 4392);//유형
        getExamPatternSelectbox("l_pattern", 4404);//패턴
        getSelectboxstepCtgKey("unitTable", 4405, 0);//단원
    }

    function changeExamUnit(val,tableId , tdNum) {
        getSelectboxstepCtgKey(tableId, val, tdNum);//단원
    }

    function goModifyProblemBank(val) {
        innerValue("param_key", val);
        goPage("productManage","modifyMokProblemBank");
    }

    function fn_search(val) {
        var paging = new Paging();
        var sPage = getInputTextValue("sPage");

        if (val == "new") sPage = "1";

        dwr.util.removeAllRows("dataList"); //테이블 리스트 초기화
        gfn_emptyView("H", "");//페이징 예외사항처리

        var examYear = getSelectboxValue("examYear");
        var subjectCode = getInputTextValue("subjectCode");
        var divisionCtgKey = getSelectboxValue("divisionCtgKey");
        var subjectCtgKey = getSelectboxValue("selSubjectCtgKey");
        var patternCtgKey = getSelectboxValue("selPattern");
        var stepCtgKey = getSelectboxValue("selUnit");

        if(examYear == null) examYear = "";
        if(subjectCode == null) subjectCode = "";
        if(divisionCtgKey == null) divisionCtgKey = "";
        if(subjectCtgKey == null) subjectCtgKey = "";
        if(patternCtgKey == null) patternCtgKey = "";
        if(stepCtgKey == null) stepCtgKey = "";


        var ctgKey = $('#unitTable').find("td select").eq(2).val();
        var unitCtgKey = ctgKey;
        if(unitCtgKey == null){
            unitCtgKey = 0;
        }
        var searchVO = {
            startPage: sPage,
            listLimitNumber: 10,
            divisionCtgKey: divisionCtgKey,
            subjectCtgKey: subjectCtgKey,
            stepCtgKey: stepCtgKey,
            patternCtgKey: patternCtgKey,
            unitCtgKey: unitCtgKey,
            examYear: examYear,
            subjectCode: subjectCode
        };

        var loading = new Loading({
            direction: 'hor',
            discription: '검색중',
            animationIn: false,
            animationOut: false,
            defaultApply: 	true,
        });

        productManageService.getProblemBankListCount(searchVO, function (cnt) {
            paging.count(sPage, cnt, '10', '10', comment.blank_list);
            var listNum = ((cnt-1)+1)-((sPage-1)*10); //리스트 넘버링
            productManageService.getProblemBankList(searchVO, function (selList) {
                if (selList.length == 0) return;
                dwr.util.addRows("dataList", selList, [
                    function(data) {return listNum--;},
                    function(data) {return data.examQuestionBankKey == 0 ? "-" : "<a href='javascript:void(0);' color='blue' onclick='goModifyProblemBank(" + data.examQuestionBankKey + ");'>" +  data.examQuestionBankKey + "</a>";},
                    function(data) {return data.className == null ? "-" : data.className;},
                    function(data) {return data.examYear == null ? "-" : data.examYear;},
                    function(data) {return data.subjectName == null ? "-" : data.subjectName;},
                    function(data) {return data.levelName == null ? "-" : data.levelName;},
                    function(data) {return data.typeName == null ? "-" : data.typeName;},
                    function(data) {return data.patternName == null ? "-" : data.patternName;},
                    function(data) {return data.unitName == null ? "-" : data.unitName;},
                ], {escapeHtml:false});
            });
            loadingOut(loading);
        });
    }
</script>
<div class="page-breadcrumb">
    <input type="hidden" id="sPage">
    <input type="hidden" id="examQuestionBankKey"  name="examQuestionBankKey">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">모의고사 문제은행 문제목록</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">상품관리</li>
                        <li class="breadcrumb-item active" aria-current="page">모의고사 문제은행 문제목록</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</div>
<!-- 기본 소스-->
<div class="container-fluid">
    <div class="form-group">
        <div class="card">
            <div class="card-body">
                <div class="row border-bottom" style="display: block;overflow: hidden;padding-bottom: 10px">
                    <label class="control-label col-form-label ml-3 pt-4 font-weight-bold" style="display:inline;font-size:1.05rem;">옵션</label>
                    <button type="button" onclick="fn_search('new')" class="row btn btn-info btn-sm" style="float:right;margin-right: 1.25rem">검색</button>
                </div>
                <div class="row" style="padding-top:20px">
                    <div class="col">
                        <div class="form-group row">
                            <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">출제년도</label>
                            <div class="col-sm-8 pl-0 pr-0">
                                <span id="l_examYearGroup"></span>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label  class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">출제구분</label>
                            <div class="col-sm-8 pl-0 pr-0">
                                <span id="l_examType"></span>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">패턴</label>
                            <div class="col-sm-8 pl-0 pr-0">
                                <span id="l_pattern"></span>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="form-group row" style="">
                            <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">과목코드</label>
                            <input type="text" class="col-sm-8 form-control" id="subjectCode">
                        </div>
                        <div class="form-group row">
                            <label  class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">과목</label>
                            <div class="col-sm-8 pl-0 pr-0">
                                <span id="l_subjectGroup"></span>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label  class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">유형</label>
                            <div class="col-sm-8 pl-0 pr-0">
                                <span id="l_Type"></span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <div class="form-group row">
                            <label  class="col-sm-1 control-label col-form-label" style="margin-bottom: 0">단원</label>
                                <table id="unitTable">
                                    <tbody id="unitSelList">
                                    <td><!--옵션명selbox-->
                                        <select class='form-control'  id='sel_unit' onchange="changeExamUnit('unitTable', this.value, 1);">
                                        </select>
                                    </td>
                                    <td>
                                        <select class='form-control'></select>
                                    </td>
                                    <td>
                                        <select class='form-control' id="unitSel"></select>
                                    </td>
                                    </tbody>
                                </table>
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
                    <table class="table table-hover">
                        <thead>
                        <tr>
                            <th scope="col" style="width: 5%;">No.</th>
                            <th scope="col" width="8%">코드</th>
                            <th scope="col" width="8%">출제구분</th>
                            <th scope="col" width="8%">출제년도</th>
                            <th scope="col" width="9%">과목</th>
                            <th scope="col" width="9%">난이도</th>
                            <th scope="col" width="10%">유형</th>
                            <th scope="col" width="20%">패턴</th>
                            <th scope="col" width="35%">단원</th>
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
</div>
<!-- // 기본소스-->


<!-- 검색일정 추가 팝업창 -->
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
                    <label class="col-sm-3 text-right control-label col-form-label">텍스트</label>
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
<!-- //검색일정 추가 팝업창 -->
</div>
<!--page wapper-->
<!-- The Modal -->
<div id="addModal" class="modal1 fade show" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
    <input type="hidden" id="bannerKey" value="">
    <input type="hidden" id="pos" value="">
    <input type="hidden" id="ctgKey" value="">
    <!-- Modal content -->
    <div class="modal-dialog" role="document">
        <div class="modal-content1">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">Modal title</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
            </div>
        </div>
    </div>
</div>

</div>
</div>
<!--main wapper-->
<%@include file="/common/jsp/footer.jsp" %>
