<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<%
    String JLecKey = request.getParameter("JLecKey");
%>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/orderManageService.js'></script>
<script>
    var JLecKey = '<%=JLecKey%>';
    function init() {
        menuActive('menu-3', 8);

        orderManageService.getUserLectureVideoDetailInfo(JLecKey, function (info) {
            if(info.result != null){
                var result =  info.result;
                innerHTML("JId", result.JId);
                innerHTML("name", result.name);
                innerHTML("goodsName", result.goodsName);
            }

            if(info.resultList != null) {
                var resultList = info.resultList;
                console.log(resultList);
                if(resultList.length > 0){
                    console.log(--resultList.length);
                    var i = 0;
                    dwr.util.addRows("dataList", resultList, [
                        function(data) {return "<input type='hidden' name='curriKey[]' value='"+ data.curriKey +"'>"},
                        function(data) {return "<input type='hidden' name='JCurriKey[]' value='"+ data.JCurriKey +"'>"},
                        function(data) {return leadingZeros(i++,2)},//코드
                        function(data) {return data.name},
                        function(data) {return "<input type='text' name='lectureTime[]' value='"+ data.remainTime +"' class='form-control col-md-2' style='float: left' >/"+data.vodTime;},//출제년도
                    ], {escapeHtml:false});
                    $('#dataList tr').each(function(){
                        var tr = $(this);
                        tr.children().eq(0).attr("style", "display:none");
                        tr.children().eq(1).attr("style", "display:none");
                    });
                }
            }
        });
    }

    //수강시간 조정 저장
    function saveLectureTime() {
        var JCurriKey = get_array_values_by_name("input", "JCurriKey[]");
        var curriKey = get_array_values_by_name("input", "curriKey[]");
        var lecTime = get_array_values_by_name("input", "lectureTime[]");
        if(confirm('저장하시겠습니까?')){
        $.each(curriKey, function(index, key) {
            if(JCurriKey[index] == 0){
                orderManageService.changeUserLectureTime(0, JLecKey, key, lecTime[index], function () {isReloadPage();});
            }else {
                orderManageService.changeUserLectureTime(JCurriKey[index], JLecKey, key, lecTime[index], function () {isReloadPage();});
            }
        });
        }
    }

</script>
<div class="page-breadcrumb">
    <input type="hidden" id="JLecKey" name="JLecKey" value=<%=JLecKey%>>
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">수강시간 조정</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">주문관리</li>
                        <li class="breadcrumb-item active" aria-current="page">수강시간 조정</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</div>
<!-- 기본 소스-->
<!-- 기본 소스-->
<div class="">
    <div class="form-group">
        <div class="card">
            <div class="card-body">
                <div class="col-md-12">
                    <div class="col">
                        <div class="form-group row">
                            <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">주문번호</label>
                            <span id="JId"></span>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">회원이름</label>
                            <span id="name" style="color: #0040f1"></span>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">상품명</label>
                            <span id="goodsName"></span>
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
            <button type="button" class="btn btn-outline-primary btn-sm" style="width:100px;margin-left:1330px;"  onclick="saveLectureTime();">수강시간 저장</button>
            <div class="card-body">
                <table class="table table-hover">
                    <thead>
                    <tr>
                        <th scope="col" width="5%">회차</th>
                        <th scope="col" width="30%">강의제목</th>
                        <th scope="col" width="15%">시간</th>
                    </tr>
                    </thead>
                    <tbody id="dataList"></tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</div>
<!-- // 기본소스--><!--main wapper-->
<%@include file="/common/jsp/footer.jsp" %>
