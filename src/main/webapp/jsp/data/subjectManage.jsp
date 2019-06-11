<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/dataManageService.js'></script>
<script>
    function init() {
        menuActive('menu-0', 2);
    }
    function saveSubject(){ /* 분류저장 */
        var subject =  getInputTextValue("subject");
        if(subject != ""){
            if(confirm("과목추가 하시겠습니까?")) {
                dataManageService.saveClassficationInfo("SUBJECT", subject, function () {isReloadPage(true);});
            }
        }else{
            alert("과목을 입력해 주세요.");
            return false;
        }
    }
    function deleteSubject(val) { /* 과목 삭제 */
        if(confirm("삭제하시겠습니까?")) {
            dataManageService.deleteClassSubject(val, function () {isReloadPage(true);});
        }
    }
    function subjectList() { /* 분류 리스트 */
        dataManageService.getTcategoryList("SUBJECT", function (selList) {
            if (selList.length > 0) {
                for (var i = 0; i < selList.length; i++) {
                    var cmpList = selList[i];
                    if (cmpList != undefined) {
                        var deleteBtn  = "<button type=\"button\" onclick='deleteSubject("+cmpList.ctgKey+")' class=\"btn btn-outline-danger btn-sm\">삭제</button>";
                        var cellData = [
                            function(data) {return cmpList.name;},
                            function(data) {return deleteBtn;}
                        ];
                        dwr.util.addRows("dataList", [0], cellData, {escapeHtml:false});
                    }
                }
            }

        });
    }
    $( document ).ready(function() {
        categoryList(); //분류 리스트 불러오기
    });
</script>
<div class="page-breadcrumb">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">과목관리</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="#">데이터관리</a></li>
                        <li class="breadcrumb-item active" aria-current="page">과목관리</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</div>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-5">
            <div class="card">
                <div class="card-body">
                    <div class="form-group row" style="margin-bottom: 0px;">
                        <label  class="col-sm-3 text-center control-label col-form-label card-title">과목등록</label>
                            <div class="col-sm-7">
                                <input type="text" class="form-control" width="50px" id="subject" required="required">
                            </div>
                            <div>
                                <button type="button" class="btn btn-info" style="float:right;" onclick="saveClassfication();">추가</button>
                            </div>
                    </div>
                </div>
                <table class="table table-hover text-center">
                    <thead>
                    <tr>
                        <th scope="col">과목명</th>
                        <th scope="col">관리</th>
                        <th scope="col"></th>
                    </tr>
                    </thead>
                    <tbody id="dataList"></tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<!-- End Container fluid  -->
<%@include file="/common/jsp/footer.jsp" %>
