<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>

<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/dataManageService.js'></script>
<script>
    function init() {
        menuActive('menu-0', 1);
    }
    function saveClassfication(){ /* 분류저장 */
        var subject =  getInputTextValue("subject");
        if(subject != ""){
            if(confirm("분류추가 하시겠습니까?")) {
                dataManageService.saveClassficationInfo("CLASSFICATION", subject, function () {
                    isReloadPage(true);
                });
            }
        }else{
            alert("분류를 입력해 주세요.");
            return false;
        }
    }

    function deleteSubject(val) { /*과목 삭제*/
        if(confirm("삭제하시겠습니까?")) {
            dataManageService.deleteClassSubject(val, function () {
                isReloadPage(true);
            });
        }
    }

    function categoryList() { /* 분류 리스트 */
        dataManageService.getTcategoryList("CLASSFICATION", function (selList) {
            if (selList.length > 0) {
                for (var i = 0; i < selList.length; i++) {
                    var cmpList = selList[i];
                    if (cmpList != undefined) {
                        var deleteBtn  = "<button type=\"button\" onclick='deleteSubject("+cmpList.ctgKey+")' class=\"btn btn-outline-danger btn-sm\">삭제</button>";
                        var cellData = [
                            function(data) {return cmpList.name;},
                            function(data) {return deleteBtn;},
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
            <h4 class="page-title">분류관리</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">데이터 관리</li>
                        <li class="breadcrumb-item active" aria-current="page">분류관리</li>
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
                        <label class="col-sm-3 text-center control-label col-form-label card-title"  style="margin-bottom: 0px;">분류등록</label>
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
                        <th scope="col" style="width:75%;">분류명</th>
                        <th scope="col" style="width:25%;">관리</th>
                        <th scope="col" style="width:25%;"></th>
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
