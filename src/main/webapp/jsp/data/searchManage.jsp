<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<%
    String subDomainSel = request.getParameter("param_key");
%>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/dataManageService.js'></script>
<script type='text/javascript' src='/dwr/interface/selectboxService.js'></script>
<script>
    var subDomainSel = '<%=subDomainSel%>';
    function init(){
        getSearchKeywordDomainList('sel_subDomain', subDomainSel);
        searchChange(subDomainSel);
        menuActive('menu-0', 5);
    }

    function searchChange(val) {
        dataManageService.getSearchKeywordList(val, function (selList) {
            if (selList.length > 0) {
                dwr.util.removeAllRows("dataList");
                for (var i = 0; i < selList.length; i++) {
                    var cmpList = selList[i];
                    var Btn = "<button type=\"button\" class=\"btn btn-outline-success btn-sm\" onclick='getSearch("+ cmpList.searchKeywordKey +");' data-toggle=\"modal\" data-target=\"#sModal\">수정</button><button type=\"button\" class=\"btn btn-outline-danger btn-sm\" onclick='searchDelete("+ cmpList.searchKeywordKey +");'>삭제</button>";
                    if (cmpList != undefined) {
                        var cellData = [
                            function(data) {return cmpList.keyword;},
                            function(data) {return Btn;}
                        ];
                        dwr.util.addRows("dataList", [0], cellData, {escapeHtml:false});
                    }
                }
            }
        });
    }

    function getSearch(val) { //상세정보 가져오기
        $("#searchKeywordKey").val(val);
        dataManageService.getSearchKeywordInfo(val, function (selList) {
            $("#searchModifyText").val(selList.keyword);
        });
    }

    function modifySave() {
        var searchText = $("#searchModifyText").val();
        var searchKeywordKey = $("#searchKeywordKey").val();
        if(confirm("수정 하시겠습니까?")) {
            dataManageService.modifySearchKeyword(searchKeywordKey, searchText, function () {
                var sel_subDomain =  getSelectboxValue('sel_subDomain');
                innerValue("param_key", sel_subDomain);
                goPage('dataManage', 'searchSave');

            });
        }
    }
    
    function searchSave() {
        var searchText   =  $("#searchText").val();
        var kewordDomain = getSelectboxValue("sel_subDomain");

        if(kewordDomain == ""){
            alert("직렬직을 선택해 주세요.");
            return false;
        }else if(searchText == ""){
            alert("검색어를 입력해 주세요.");
            return false;

        }else{
            if(confirm("저장 하시겠습니까?")) {
                dataManageService.saveSearchKeyword(kewordDomain, searchText, function (selList) {
                    var sel_subDomain =  getSelectboxValue('sel_subDomain');
                    innerValue("param_key", sel_subDomain);
                    goPage('dataManage', 'searchSave');
                });
            }
        }
    }

    function searchDelete(val) {
        if(confirm("삭제 하시겠습니까?")) {
            dataManageService.deleteSearchkeyword(val, function () {
                var sel_subDomain =  getSelectboxValue('sel_subDomain');
                innerValue("param_key", sel_subDomain);
                goPage('dataManage', 'searchSave');
            });
        }
    }
</script>
<!--순서-->
<div class="page-breadcrumb">
    <input type="hidden" id="param_key" value="">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">검색어 관리</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">데이터관리</li>
                        <li class="breadcrumb-item active" aria-current="page">검색어관리</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</div>
<!--//순서-->

<!-- 기본 소스-->
<div class="container-fluid">
    <div class="row">
        <div class="col-md-6">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title" style="position: absolute;left: -9999px;top: -9999px">직렬직 검색어선택</h5>
                    <div class="form-group row" style="margin-bottom: 0px;">
                        <label class="col-sm-3 text-left control-label col-form-label card-title"  style="margin-bottom: 0px;">직렬직선택</label>
                        <div class="col-sm-6">
                            <select class="select2 form-control custom-select" id="sel_subDomain" onchange="searchChange(this.value);">
                                <option>선택</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card">
                <input type="hidden" id="key" value="modify">
                <input type="hidden" id="searchKeywordKey" value="">
                <div class="card-body">
                    <div class="form-group row" style="margin-bottom: 0px;">
                        <label class="col-sm-3 text-left control-label col-form-label card-title"  style="margin-bottom: 0px;">검색어 추가</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="searchText" onkeypress="if(event.keyCode==13) {searchSave(); return false;}">
                        </div>
                        <button type="button" class="btn btn-info" onclick="searchSave();">저장</button>
                    </div>
                </div>
                <table class="table table-hover text-center">
                    <thead>
                    <tr>
                        <th scope="col" style="width:75%;">검색어</th>
                        <th scope="col" style="width:25%;">관리</th>
                    </tr>
                    </thead>
                    <tbody id="dataList"> </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<!-- // 기본소스-->


<!-- 시험일정 추가 팝업창 -->
<div class="modal fade" id="sModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
           <!-- <input type="hidden" id="key" value="modify">
            <input type="hidden" id="searchKeywordKey" value="">-->
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
                        <input type="text" class="form-control" id="searchModifyText">
                    </div>
                </div>
                <button type="button" class="btn btn-info float-right" onclick="modifySave();">저장</button>
            </div>
            <!-- //modal body -->
        </div>
    </div>
</div>



<%@include file="/common/jsp/footer.jsp" %>
