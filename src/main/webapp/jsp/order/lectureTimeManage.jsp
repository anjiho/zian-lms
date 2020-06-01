<%@ page import="com.zianedu.lms.utils.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<%
    String JLecKey = request.getParameter("param_key");
    String payStatus = Util.isNullValue(request.getParameter("param_key2"), "");
    String orderStatus = Util.isNullValue(request.getParameter("param_key3"), "");
    String orderSearch = Util.isNullValue(request.getParameter("param_key4"), "");
    String searchStartDate = Util.isNullValue(request.getParameter("param_key5"), "");
    String searchEndDate = Util.isNullValue(request.getParameter("param_key6"), "");
    String searchText = Util.isNullValue(request.getParameter("param_key7"), "");
    String searchText2=new String( searchText.getBytes( "8859_1"), "UTF-8");
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
                if(resultList.length > 0){
                    var i = 0;
                    dwr.util.addRows("dataList", resultList, [
                        function(data) {return "<input type='hidden' name='curriKey[]' value='"+ data.curriKey +"'>"},
                        function(data) {return "<input type='hidden' name='JCurriKey[]' value='"+ data.JCurriKey +"'>"},
                        function(data) {return leadingZeros(i++,2)},//코드
                        function(data) {return data.name},
                        //function(data) {return "<input type='text' name='lectureTime[]' value='"+ data.remainTime +"' class='form-control col-md-2' style='float: left' >/"+data.vodTime;},//출제년도
                        function(data) {return "<input type='text' name='lectureTime[]' value='"+ data.remainTime +"' class='form-control col-md-2' style='float: left' >/"+"<span style='padding: 0.3rem;vertical-align: middle'>"+data.vodTime+"</span>";},//출제년도
                    ], {escapeHtml:false});
                    $('#dataList tr').each(function(){
                        var tr = $(this);
                        tr.children().eq(0).attr("style", "display:none");
                        tr.children().eq(1).attr("style", "display:none");
                    });
                }
            }

            if(info.resultTotalTime != null){
                var result = info.resultTotalTime;
                var remainT=result.remainTotalTime.toString();
                var resultPer=Math.floor(remainT/result.vodTotalTime*100);

                innerHTML("vodTotalTime", result.vodTotalTime);
                innerHTML("remainTotalTime", remainT);
                innerHTML("remainPer", resultPer);

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
            if (lecTime[index] > 0) {
                orderManageService.changeUserLectureTime(JCurriKey[index], JLecKey, key, lecTime[index], function () {isReloadPage();});
            }
        });
        }
    }

    function goPauseLogList() {
        $('.modal-dialog').css('max-width','500px');

        dwr.util.removeAllRows("dataList3"); //테이블 리스트 초기화

        fn_search3("new");
    }

    function fn_search3(val) {

        dwr.util.removeAllRows("dataList3"); //테이블 리스트 초기화

        orderManageService.getUserLecturePauseLogInfo(JLecKey, function (selList) {
            var recInfo = selList.pauseRec;
             if (selList.length == 0) return;
            dwr.util.addRows("dataList3", recInfo, [
                function(data) {return data.logType},
                function(data) {return data.createDate},
            ], {escapeHtml:false});

            $('#dataList3').each(function(){
                var tr = $(this).find('tr');
                tr.eq(2).css('background','#eeeeee');
                tr.eq(3).css('background','#eeeeee');
            });

            var cntInfo = selList.lecturePauseDetail;

            innerHTML("pauseTotalDay", cntInfo.pauseTotalDay + "일");
            innerHTML("pauseCnt", cntInfo.pauseCnt + "번");


        });
    }

    function goOrderList() {
        innerValue("param_key2", '<%=payStatus%>');
        innerValue("param_key3", '<%=orderStatus%>');
        innerValue("param_key4", '<%=orderSearch%>');
        innerValue("param_key5", '<%=searchStartDate%>');
        innerValue("param_key6", '<%=searchEndDate%>');
        innerValue("param_key7", '<%=searchText2%>');

        goPage('orderManage', 'lectureWatchList');
    }

    //팝업 Close 기능
    function close_pop(flag) {
        $('#myModal').hide();
    };

</script>
<div class="page-breadcrumb">
    <input type="hidden" id="JLecKey" name="JLecKey" value=<%=JLecKey%>>
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">수강시간 조정</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">종류</li>
                        <li class="breadcrumb-item active" aria-current="page">날짜</li>
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
                        <div class="form-group row">
                            <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">총수강시간</label>
                            <span id="remainTotalTime"></span>분&nbsp;/&nbsp;<span id="vodTotalTime"></span>분 (<span id="remainPer"></span>%)
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">일시정지 기록</label>
                            <button type="button" data-toggle="modal" data-target="#myModal"   class="btn btn-outline-info" onclick="goPauseLogList()">기록확인</button>
                        </div>
                        <div align="right">
                            <button type="button" class="btn btn-outline-info mx-auto" onclick="goOrderList()">목록</button>
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
            <div class="card-body  scrollable" style="height:650px;">
                <div class="float-right mb-3">
                    <button type="button" class="btn btn-info btn-sm" onclick="saveLectureTime();">일시정지 기록</button>
                </div>
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
<!--optionSel -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document" style="max-width:1200px;max-height: 200px;">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">일시정지 기록</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form>
                <input type="hidden" id="key" value="">
                <!-- modal body -->
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card">
                                <div class="form-group row">
                                    <label class="col-sm-5 control-label col-form-label" style="margin-bottom: 0">일시정지 총 횟수</label>
                                    <span id="pauseCnt"></span>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-5 control-label col-form-label" style="margin-bottom: 0">일시정지 총 일수</label>
                                    <span id="pauseTotalDay"></span>
                                </div>
                                <table class="table table-hover text-center">
                                    <thead>
                                    <tr>
                                        <th scope="col" width="20%">종류</th>
                                        <th scope="col" width="80%">시간</th>
                                    </tr>
                                    </thead>
                                    <tbody id="dataList3"></tbody>
                                    <tr>
                                        <td id="emptys3" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
                                    </tr>
                                </table>
                                <div>
                                    <input type="hidden" id="sPage3" >
                                    <%@ include file="/common/inc/com_pageNavi3.inc" %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- //modal body -->
            </form>
        </div>
    </div>
</div>
<!-- // 기본소스--><!--main wapper-->
<%@include file="/common/jsp/footer.jsp" %>
