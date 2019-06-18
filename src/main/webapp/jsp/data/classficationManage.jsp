<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>

<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/dataManageService.js'></script>
<script>
    function init() {
        menuActive('menu-0', 1);
        /* 리스트 불러오기 */
        categoryList();
        subjectList();
    }
    function saveClassfication(){ /* 분류저장 */
        var classfication =  getInputTextValue("classfication");
        if(classfication != ""){
            if(confirm("분류 등록을 하시겠습니까?")) {
                dataManageService.saveClassficationInfo("CLASSFICATION", classfication, function () {isReloadPage(true);});
            }
        }else{
            alert("분류를 입력해 주세요.");
            return false;
        }
    }
    function saveSubject(){ /* 과목저장 */
        var subject =  getInputTextValue("subject");
        if(subject != ""){
            if(confirm("과목 등록을 하시겠습니까?")) {
                dataManageService.saveClassficationInfo("SUBJECT", subject, function () {isReloadPage(true);});
            }
        }else{
            alert("과목을 입력해 주세요.");
            return false;
        }
    }

    function deleteClassfication(val) { /*과목 삭제*/
        if(confirm("삭제하시겠습니까?")) {
            dataManageService.deleteClassSubject(val, function () {
                isReloadPage(true);
            });
        }
    }

    function deleteSubject(val) { /* 과목 삭제 */
        if(confirm("삭제하시겠습니까?")) {
            dataManageService.deleteClassSubject(val, function () {isReloadPage(true);});
        }
    }

    function categoryList() { /* 분류 리스트 */
        dataManageService.getTcategoryList("CLASSFICATION", function (selList) {
            if (selList.length > 0) {
                for (var i = 0; i < selList.length; i++) {
                    var cmpList = selList[i];
                    if (cmpList != undefined) {
                        var deleteBtn  = "<button type=\"button\" onclick='deleteClassfication("+cmpList.ctgKey+")' class=\"btn btn-outline-danger btn-sm\">삭제</button>";
                        var cellData = [
                            function(data) {return "";},
                            function(data) {return cmpList.name;},
                            function(data) {return deleteBtn;},
                        ];
                        dwr.util.addRows("classficationList", [0], cellData, {escapeHtml:false});
                    }
                }
            }
        });
    }

    function subjectList() { /* 과목 리스트 */
        dataManageService.getTcategoryList("SUBJECT", function (selList) {
            if (selList.length > 0) {
                for (var i = 0; i < selList.length; i++) {
                    var cmpList = selList[i];
                    if (cmpList != undefined) {
                        var deleteBtn  = "<button type=\"button\" onclick='deleteSubject("+cmpList.ctgKey+")' class=\"btn btn-outline-danger btn-sm\">삭제</button>";
                        var cellData = [
                            function(data) {return "";},
                            function(data) {return cmpList.name;},
                            function(data) {return deleteBtn;}
                        ];
                        dwr.util.addRows("subjectList", [0], cellData, {escapeHtml:false});
                    }
                }
            }

        });
    }

</script>
<div class="page-breadcrumb">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">분류 / 과목 관리</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">데이터 관리</li>
                        <li class="breadcrumb-item active" aria-current="page">분류 / 과목 관리</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</div>
<div class="container-fluid">
    <div class="row">
        <!-- 분류관리 -->
        <div class="col-md-4">
            <div class="card">
            <div class="row"  style="margin-top: 30px;text-align: center;margin-left: 25px;">
                <label class="col-sm-3 text-center control-label col-form-label card-title">분류등록</label>
                <div style="width: 45%;">
                    <input type="text" class="form-control" width="50px" id="classfication" onkeypress="if(event.keyCode==13) {saveClassfication(); return false;}">
                </div>
                <div  style="width: 5%; margin-left: 2px;">
                    <button type="button" class="btn btn-info" onclick="saveClassfication();">추가</button>
                </div>
            </div>
            <div class="card-body scrollable" style="height:800px;">
                <table class="table table-hover  text-center">
                    <thead>
                    <tr>
                        <th scope="col"></th>
                        <th scope="col" style="width:80%; text-align: center">분류명</th>
                        <th scope="col" style="width:20%;">관리</th>
                    </tr>
                    </thead>
                    <tbody id="classficationList"></tbody>
                </table>
            </div>
        </div>
        </div>
        <!-- //분류관리 -->

        <!-- 과목관리 -->
        <div class="col-md-4">
            <div class="card">
                <div class="row" style="margin-top: 30px;text-align: center;margin-left: 25px;">
                    <label  class="col-sm-3 control-label col-form-label card-title">과목등록</label>
                    <div style="width: 45%;">
                        <input type="text" class="form-control" id="subject" onkeypress="if(event.keyCode==13) {saveSubject(); return false;}">
                    </div>
                    <div  style="width: 5%; margin-left: 2px;">
                        <button type="button" class="btn btn-info" onclick="saveSubject();">추가</button>
                    </div>
                </div>
                <div class="card-body scrollable" style="height:800px;">
                    <table class="table table-hover text-center">
                        <thead>
                        <tr>
                            <th scope="col"></th>
                            <th scope="col" style="width:80%;text-align: center">과목명</th>
                            <th scope="col" style="width:20%;">관리</th>
                        </tr>
                        </thead>
                        <tbody id="subjectList"></tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- //과목관리 -->
    </div>
</div>
<!-- End Container fluid  -->
<%@include file="/common/jsp/footer.jsp" %>
