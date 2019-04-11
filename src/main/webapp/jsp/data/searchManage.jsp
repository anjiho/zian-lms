<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/dataManageService.js'></script>
<script type='text/javascript' src='/dwr/interface/selectboxService.js'></script>
<script>
    $( document ).ready(function() {
        getSearchKeywordDomainList('sel_subDomain','');
        searchChange("PUBLIC");

        $('.modal').on('hidden.bs.modal', function (e) {
            $('form').each(function(){
                this.reset();
                $("#key").val("");
            });
        });
    });
    
    function searchChange(val) {
        dataManageService.getSearchKeywordList(val, function (selList) {
            if (selList.length > 0) {
                dwr.util.removeAllRows("dataList");
                for (var i = 0; i < selList.length; i++) {
                    var cmpList = selList[i];
                    var Btn = "<button type=\"button\" class=\"btn btn-outline-primary btn-sm\" onclick='getSearch("+ cmpList.searchKeywordKey +");' data-toggle=\"modal\" data-target=\"#sModal\">수정</button><button type=\"button\" class=\"btn btn-outline-danger btn-sm\" onclick='searchDelete("+ cmpList.searchKeywordKey +");'>삭제</button>";
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
        $("#key").val('modify');
        $("#searchKeywordKey").val(val);
        /*dataManageService.getExamScheduleDetailInfo(val, function (selList) {
            $("#searchText").val(selList.searchText);
        });*/
    }

    function searchSave() {
        var searchText =  $("#searchText").val();
        var kewordDomain = $("#sel_subDomain option:selected").val();
        var key = $("#key").val();
        var searchKeywordKey = $("#searchKeywordKey").val();

        if(key == "modify"){
            if(confirm("수정 하시겠습니까?")) {
                dataManageService.modifySearchKeyword(searchKeywordKey, searchText, function () {
                    isReloadPage(true);
                });
            }
        }else{
            if(confirm("저장 하시겠습니까?")) {
                dataManageService.saveSearchKeyword(kewordDomain, searchText, function (selList) {
                    isReloadPage(true);
                });
            }
        }
    }

    function searchDelete(val) {
        if(confirm("삭제 하시겠습니까?")) {
            dataManageService.deleteSearchkeyword(val, function () {
                isReloadPage(true);
            });
        }
    }
</script>
<!--순서-->
<div class="page-breadcrumb">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">검색어 관리</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">데이터관리</li>
                        <li class="breadcrumb-item active" aria-current="page">일정/검색어관리</li>
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
                        <div class="col-sm-9">
                            <select class="select2 form-control custom-select" id="sel_subDomain" onchange="searchChange(this.value);">
                                <option>선택</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title" style="display:inline-block;vertical-align:middle;margin-bottom:-2px;">검색어관리</h5>
                    <button type="button" style="vertical-align: middle;display:inline-block;float:right" class="btn btn-info btn-sm" data-toggle="modal" data-target="#sModal">추가</button>
                </div>
                <table class="table table-hover text-center">
                    <thead>
                    <tr>
                        <th scope="col" style="width:75%;">검색어 목록</th>
                        <th scope="col" style="width:25%;">관리</th>
                    </tr>
                    </thead>
                    <tbody id="dataList"> </tbody>
                    <!--<tr>
                        <td class="text-left align-middle">안효선</td>
                        <td>
                            <button type="button" class="btn btn-outline-primary btn-sm">수정</button>
                            <button type="button" class="btn btn-outline-danger btn-sm">삭제</button>
                        </td>
                    </tr>
                    <tr>
                        <td class="text-left align-middle">2019 서울시9급</td>
                        <td>
                            <button type="button" class="btn btn-outline-primary btn-sm">수정</button>
                            <button type="button" class="btn btn-outline-danger btn-sm">삭제</button>
                        </td>
                    </tr>
                    <tr>
                        <td class="text-left align-middle">2019 국가직7급</td>
                        <td>
                            <button type="button" class="btn btn-outline-primary btn-sm">수정</button>
                            <button type="button" class="btn btn-outline-danger btn-sm">삭제</button>
                        </td>
                    </tr>
                    <tr>
                        <td class="text-left align-middle">2019 지방직7급</td>
                        <td>
                            <button type="button" class="btn btn-outline-primary btn-sm">수정</button>
                            <button type="button" class="btn btn-outline-danger btn-sm">삭제</button>
                        </td>
                    </tr>
                    <tr>
                        <td class="text-left align-middle">2019 서울시7급</td>
                        <td>
                            <button type="button" class="btn btn-outline-primary btn-sm">수정</button>
                            <button type="button" class="btn btn-outline-danger btn-sm">삭제</button>
                        </td>
                    </tr>-->

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
            <input type="hidden" id="key" value="modify">
            <input type="hidden" id="searchKeywordKey" value="">
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
                        <input type="text" class="form-control" id="searchText">
                    </div>
                </div>
                <button type="button" class="btn btn-info float-right" onclick="searchSave();">저장</button>
            </div>
            <!-- //modal body -->
        </div>
    </div>
</div>
<%@include file="/common/jsp/footer.jsp" %>
