<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<%
    String bankSubjectKey = request.getParameter("bankSubjectKey");
%>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/productManageService.js'></script>
<script>
    var bankSubjectKey = '<%=bankSubjectKey%>';

    function init() {
        getProductSearchSelectbox("l_searchSel");
        menuActive('menu-1', 13);

        getMockYearSelectbox("l_examYearGroup","");//출제년도
        getSelectboxListdivisionCtgKey("l_examType", 4390, "");//출제구분
        getNewSelectboxListForCtgKey2("l_subjectGroup", "70", "");//과목
        getAnswerSelectbox("l_answerType", "");//정답
        getExamLevelSelectbox("l_examLevel", "");//난이도
        getTypeSelectbox("l_Type", 4392);//유형
        getExamPatternSelectbox("l_pattern", 4404);//패턴
        getSelectboxstepCtgKey("unitTable", 4405, 0);//단원


        productManageService.getProblemBankSubjectList(bankSubjectKey, function(info) {
            console.log(info);
            var resultInfo = info.resultInfo;
            innerHTML("productType", resultInfo.examQuestionBankSubjectKey);
            innerValue("name",resultInfo.name);
            getNewSelectboxListForCtgKey2("l_subjectGroup", "70", resultInfo.subjectCtgKey);//과목

            var resultList = info.resultList;
            if (resultList.length > 0) {
                dwr.util.addRows("dataList", resultList, [
                    //function(data) {return data.examQuesBankKey},
                    //bankSubjectQuesLinkKey
                    function(data) {return data.examQuesBankKey},
                    function(data) {return data.examQuesBankKey},//출제구분
                    function(data) {return data.examYear+"년"},//출제년도
                    function(data) {return data.subjectName},//출제과목
                    function(data) {return data.levelName},//난이도
                    function(data) {return data.typeName},//유형
                    function(data) {return data.patternName},//패턴
                    function(data) {return data.unitName},//단원
                    function(data) {return "<button type='button' onclick='deleteTableRow("+ data.examQuesBankKey +");' class=\"btn btn-outline-danger btn-sm\" style=\"margin-top:8%;\" >삭제</button>"}
                ], {escapeHtml:false});
            }
        });
    }

    function changeExamUnit(val,tableId , tdNum) {
        getSelectboxstepCtgKey(tableId, val, tdNum);//단원
    }

    //리스트추가
    function addProblemInfo() {
        
    }
    
    //리스트 삭제
    function deleteTableRow(examQuesBankKey) {//bankSubjectQuesLinkKey
        if(confirm('삭제 하시겠습니까?')){
            productManageService.deleteProblemBankSubjectList(examQuesBankKey, function() {});
        }
    }

    //수정
    function mockProblemBankModify() {
        
    }

</script>
<div class="page-breadcrumb">
    <input type="hidden" id="sPage">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">모의고사 문제은행 과목수정</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">상품관리</li>
                        <li class="breadcrumb-item active" aria-current="page">모의고사 문제은행 과목수정</li>
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
                            <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">상품타입</label>
                            <span id="productType"></span>
                            <input type="hidden" class="col-sm-6 bg-light required form-control" id="type" name='type' value="3">
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">이름</label>
                            <input type="text" class="col-sm-6 form-control" style="display: inline-block;" id="name" name="name">
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">과목</label>
                            <div class="col-sm-6 pl-0 pr-0">
                                <span id="l_subjectGroup"></span>
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
                <div class="float-right mb-3">
                    <button type="button" class="btn btn-info btn-sm" onclick="addProblemInfo();">추가</button>
                </div>
                <table class="table table-hover" id="bankSubjectTable">
                    <thead>
                    <tr>
                        <th scope="col" width="5%">코드</th>
                        <th scope="col" width="8%">출제구분</th>
                        <th scope="col" width="8%">출제년도</th>
                        <th scope="col" width="6%">과목</th>
                        <th scope="col" width="6%">난이도</th>
                        <th scope="col" width="15%">유형</th>
                        <th scope="col" width="15%">패턴</th>
                        <th scope="col" width="45%">단원</th>
                        <th scope="col" width="5%"></th>
                    </tr>
                    </thead>
                    <tbody id="dataList"></tbody>
                    <tr>
                        <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
                    </tr>
                </table>
                <%@ include file="/common/inc/com_pageNavi.inc" %>
                <button type="button" class="btn btn-info float-right m-l-2" onclick="mockProblemBankModify();">수정</button>
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
<!--main wapper-->
<%@include file="/common/jsp/footer.jsp" %>
