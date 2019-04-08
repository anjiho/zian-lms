<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/dataManageService.js'></script>
<script>
function saveClassfication(){ /* 분류저장 */
    var subject =  getInputTextValue("subject");
    if(confirm("과목추가 하시겠습니까?")) {
        dataManageService.saveClassficationInfo("CLASSFICATION", subject, function () {
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
                    console.log(cmpList);
                    var cellData = [
                        function(data) {return cmpList.name;},
                        function(data) {return "<a href=\"#\"  data-toggle=\"tooltip\" data-placement=\"top\" title=\"Delete\" ></i><i class=\"mdi mdi-close\"></i></a>"}
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


$("#add111").click(function(event) {
    alert(1);
    // Fetch form to apply custom Bootstrap validation
    var form = $("#frm");

    if (form[0].checkValidity() === false) {
        event.preventDefault();
        event.stopPropagation();
    }

    form.addClass('was-validated');
    // Perform ajax submit here...

});
</script>
<div class="page-breadcrumb">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">분류관리</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="#">카테고리관리</a></li>
                        <li class="breadcrumb-item active" aria-current="page">분류관리</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</div>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-6">
            <div class="card">
                <div class="card-body">
                    <div class="row">
                        <label  class="text-right control-label col-form-label">과목분류</label>
                        <div class="col-sm-3">
                            <input type="text" class="form-control" id="subject" required>
                            <div class="invalid-feedback">No, you missed this one.</div>
                        </div>
                        <div class="">
                            <button type="button" class="btn btn-info" style="float:right;" id="test">추가</button>
                        </div>
                    </div>
                </div>
                <table class="table">
                    <thead>
                    <tr>
                        <th scope="col">과목</th>
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
