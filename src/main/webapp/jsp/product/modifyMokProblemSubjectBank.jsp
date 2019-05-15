<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<%
    String bankSubjectKey = request.getParameter("bankSubjectKey");
%>
<script src='https://code.jquery.com/ui/1.11.4/jquery-ui.min.js'></script>
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
        getNewSelectboxListForCtgKey4("l_subjectGroup1", "70", "");//과목
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
                    function(data) {return "<input type='hidden' name='examQuestionBankKey[]' value=''>"},//코드
                    function(data) {return "<input type='hidden' name='questionBankKey[]' value='"+ data.examQuesBankKey +"'>"},//코드
                    function(data) {return data.examQuesBankKey},//코드
                    function(data) {return data.className},//출제구분
                    function(data) {return data.examYear+"년"},//출제년도
                    function(data) {return data.subjectName},//출제과목
                    function(data) {return data.levelName},//난이도
                    function(data) {return data.typeName},//유형
                    function(data) {return data.patternName},//패턴
                    function(data) {return data.unitName},//단원
                    function(data) {return "<button type='button' onclick='deleteTableRow("+ data.examQuesBankKey +");' class=\"btn btn-outline-danger btn-sm\" style=\"margin-top:8%;\" >삭제</button>"}
                ], {escapeHtml:false});
                $('#dataList tr').each(function(){
                    var tr = $(this);
                    tr.children().eq(0).attr("style", "display:none");
                    tr.children().eq(1).attr("style", "display:none");
                });
            }
        });
    }

    function changeExamUnit(val,tableId , tdNum) {
        getSelectboxstepCtgKey(tableId, val, tdNum);//단원
    }

    //리스트 삭제
    function deleteTableRow(examQuesBankKey) {//bankSubjectQuesLinkKey
        alert(examQuesBankKey);
        if(confirm('삭제 하시겠습니까?')){
            productManageService.deleteProblemBankSubjectList(examQuesBankKey, function() {});
        }
    }

    //수정
    function mockProblemBankModify() {
        var subjectName = $("#name").val();
        var subjectCtgKey = getSelectboxValue("selSubjectCtgKey");

        //상단내용 수정
        if(confirm('수정 하시겠습니까?')) {
            productManageService.upsultProblemBankTitleInfo(bankSubjectKey, subjectName, subjectCtgKey, function (val) {
                if(bankSubjectKey != ""){
                    var examQuestionBankKey = get_array_values_by_name("input", "examQuestionBankKey[]");
                    for (var i=0; i<examQuestionBankKey.length; i++) {
                        if(examQuestionBankKey[i] > 0){
                            productManageService.saveProblemBankSubject(bankSubjectKey, examQuestionBankKey[i], function () {});
                        }
                    }
                }
            });
        }
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
                    <button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#sModal2">추가</button>
                </div>
                <table class="table table-hover" id="mokTableList">
                    <thead>
                    <tr>
                        <th scope="col" width="9%">코드</th>
                        <th scope="col" width="9%">출제구분</th>
                        <th scope="col" width="9%">출제년도</th>
                        <th scope="col" width="9%">과목</th>
                        <th scope="col" width="9%">난이도</th>
                        <th scope="col" width="16.5%">유형</th>
                        <th scope="col" width="16.5%">패턴</th>
                        <th scope="col" width="16.5%">단원</th>
                        <th scope="col" width="8%"></th>
                    </tr>
                    </thead>
                    <tbody id="dataList"></tbody>
                </table>
                <button type="button" class="btn btn-info float-right m-l-2" onclick="mockProblemBankModify();">수정</button>
            </div>
        </div>
    </div>
</div>
</div>
<!-- // 기본소스-->
<script>
    function fn_search3(val) {
        var paging = new Paging();
        var sPage = getInputTextValue("sPage3");

        if (val == "new") sPage = "1";

        dwr.util.removeAllRows("dataList3"); //테이블 리스트 초기화
        gfn_emptyView3("H", "");//페이징 예외사항처리

        var examYear = getSelectboxValue("examYear");
        var subjectCode = getInputTextValue("subjectCode");
        var divisionCtgKey = getSelectboxValue("divisionCtgKey");
        var subjectCtgKey = getSelectboxValue("selSubjectCtgKey1");
        var patternCtgKey = getSelectboxValue("selPattern");
        var stepCtgKey = getSelectboxValue("selUnit");
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

        productManageService.getProblemBankListCount(searchVO, function (cnt) {
            paging.count3(sPage, cnt, '10', '10', comment.blank_list);
            var listNum = ((cnt-1)+1)-((sPage-1)*10); //리스트 넘버링

            productManageService.getProblemBankList(searchVO, function (selList) {
                if (selList.length == 0) return;
                var SelBtn = '<input type="button" onclick="sendChildValue($(this))" value="선택" class="btn btn-outline-info mx-auto"/>';
                dwr.util.addRows("dataList3", selList, [
                    function(data) {return "<input type='hidden' id='examQuestionBankKey[]' value='"+ data.examQuestionBankKey +"'>";},
                    function(data) {return data.examQuestionBankKey == 0 ? "-" : data.examQuestionBankKey;},
                    function(data) {return data.className == null ? "-" : data.className;},
                    function(data) {return data.examYear == null ? "-" : data.examYear;},
                    function(data) {return data.subjectName == null ? "-" : data.subjectName;},
                    function(data) {return data.levelName == null ? "-" : data.levelName;},
                    function(data) {return data.typeName == null ? "-" : data.typeName;},
                    function(data) {return data.patternName == null ? "-" : data.patternName;},
                    function(data) {return data.unitName == null ? "-" : data.unitName;},
                    function(data) {return SelBtn;},
                ], {escapeHtml:false});
                $('#dataList3 tr').each(function(){
                    var tr = $(this);
                    tr.children().eq(0).attr("style", "display:none");
                });
            });
        });
    }

    function sendChildValue (val) {
        var checkBtn = val;

        var tr = checkBtn.parent().parent();
        var td = tr.children();

        var examQuestionBankKey = td.find("input").val();
        var className = td.eq(1).text();
        var examYear = td.eq(2).text();
        var subjectName = td.eq(3).text();
        var levelName = td.eq(4).text();
        var typeName = td.eq(5).text();
        var patternName = td.eq(6).text();
        var unitName = td.eq(7).text();
        var unitName1 = td.eq(8).text();
        var examQuestionBankKey1 = get_array_values_by_name("input", "examQuestionBankKey[]");
        if ($.inArray(examQuestionBankKey, examQuestionBankKey1) != '-1') {
            alert("이미 선택된 문제입니다.");
            return;
        }

        var subHtml = "<tr class='ui-state-default even ui-sortable-handle'>";
        subHtml     += " <td>";
        subHtml     += "<span>" + className + "</span>";
        subHtml     += "<input type='hidden'  value='" + examQuestionBankKey + "' name='examQuestionBankKey[]'>";
        subHtml     += "</td>";
        subHtml     += " <td>";
        subHtml     += "<span>" + examYear + "</span>";
        subHtml     += "</td>";
        subHtml     += " <td>";
        subHtml     += "<span>" + subjectName + "</span>";
        subHtml     += "</td>";
        subHtml     += " <td>";
        subHtml     += "<span>" + levelName + "</span>";
        subHtml     += "</td>";
        subHtml     += " <td>";
        subHtml     += "<span>" + typeName + "</span>";
        subHtml     += "</td>";
        subHtml     += " <td>";
        subHtml     += "<span>" + patternName + "</span>";
        subHtml     += "</td>";
        subHtml     += " <td>";
        subHtml     += "<span>" + unitName + "</span>";
        subHtml     += "</td>";
        subHtml     += " <td>";
        subHtml     += "<span>" + unitName1 + "</span>";
        subHtml     += "</td>";
        subHtml     += " <td>";
        subHtml     += "<button type=\"button\" onclick=\"deleteTableRow1('mokTableList');\" class=\"btn btn-outline-danger btn-sm\" style=\"margin-top:8%;\" >삭제</button>";
        subHtml     += "</td>";
        subHtml     += "</tr>";
        $('#mokTableList > tbody:first').append(subHtml);
        $('#mokTableList tr').each(function(){
            var tr = $(this);
        });
    }

    $( "#mokTableList tbody" ).sortable({
        update: function( event, ui ) {
            $(this).children().each(function(index) {
                $(this).find('tr').last().html(index + 1);
            });

            //
            var changeNumberArr = new Array();
            var questionBankKey = get_array_values_by_name("input", "questionBankKey[]");
            for (var i=0; i<questionBankKey.length; i++) {
                if(questionBankKey[i] > 0){
                    var data = {
                        key : questionBankKey[i],
                        pos : i
                    };
                }
                changeNumberArr.push(data);
            }
            console.log(changeNumberArr);
            //productManageService.changeNumberProblemBankSubjectList(changeNumberArr, function () {});
        }
    });

    //테이블 로우 삭제
    function deleteTableRow1(tableId) {
        if (tableId == "mokTableList") {
            $('#mokTableList > tbody:last > tr:last').remove();
        }
    }
</script>
<!--모의고사 문제은행 과목등록 팝업창-->
<div class="modal fade" id="sModal2" tabindex="-1" role="dialog" aria-hidden="true" >
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width:1000px;">
            <div class="modal-header">
                <h5 class="modal-title">모의고사 문제은행 문제목록</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <!-- modal body -->
            <div class="modal-body">
                <div class="form-group">
                    <div class="card">
                        <div class="card-body">
                            <div class="row" style="padding-top:20px">
                                <div class="col">
                                    <input type="hidden" id="sPage3">
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
                                            <span id="l_subjectGroup1"></span>
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
                            <button type="button" onclick="fn_search3('new')" class="row btn btn-info btn-sm" style="float:right;margin-right: 1.25rem">검색</button>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-body">
                                <table class="table table-hover">
                                    <thead>
                                    <tr>
                                        <th scope="col" width="5%">코드</th>
                                        <th scope="col" width="8%">출제구분</th>
                                        <th scope="col" width="8%">출제년도</th>
                                        <th scope="col" width="8%">과목</th>
                                        <th scope="col" width="9%">난이도</th>
                                        <th scope="col" width="9%">유형</th>
                                        <th scope="col" width="20%">패턴</th>
                                        <th scope="col" width="40%">단원</th>
                                        <th scope="col" width="8%"></th>
                                    </tr>
                                    </thead>
                                    <tbody id="dataList3"></tbody>
                                    <tr>
                                        <td id="emptys3" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
                                    </tr>
                                </table>
                                <%@ include file="/common/inc/com_pageNavi3.inc" %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- //modal body -->
        </div>
    </div>
</div>
<!-- //검색일정 추가 팝업창 -->

</div>
<!--main wapper-->
<%@include file="/common/jsp/footer.jsp" %>
