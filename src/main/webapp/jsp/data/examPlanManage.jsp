<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/dataManageService.js'></script>
<script>
    $( document ).ready(function() {
        examList(); //시험일정 리스트 불러오기
        menuActive('menu-0', 4);
        /*modal 초기화*/
        $('.modal').on('hidden.bs.modal', function (e) {
            $('form').each(function(){
                this.reset();
                $("#key").val("");
            });
        });
    });

    function examList() {
        dataManageService.getExamSchedule( function (selList) {
            if (selList.length > 0) {
                for (var i = 0; i < selList.length; i++) {
                    var cmpList = selList[i];
                    var Btn = "<button type=\"button\" class=\"btn btn-outline-success btn-sm\" onclick='getExam("+ cmpList.scheduleKey +");' data-toggle=\"modal\" data-target=\"#sModal\">수정</button><button type=\"button\" class=\"btn btn-outline-danger btn-sm\" onclick='examDelete("+ cmpList.scheduleKey +");'>삭제</button>";

                    if (cmpList != undefined) {
                        var cellData = [
                            function(data) {return cmpList.scheduleKey;},
                            function(data) {return cmpList.title;},
                            function(data) {return split_minute_getDay(cmpList.startDate);},
                            function(data) {return Btn;}
                        ];
                        dwr.util.addRows("dataList", [0], cellData, {escapeHtml:false});
                    }
                }
            }
        });
    }

    function examSave() {
        var title = $("#title").val();
        var datetimepicker12 = $("#datetimepicker12").val();
        var scheduleKey =  $("#scheduleKey").val();
        var link = $("#link").val();
        //modifyExamSchedule
        var key = $("#key").val();
        if(key == "modify"){//수정
            if(confirm("일정 수정 하시겠습니까?")) {
                var data = {
                    scheduleKey: scheduleKey,
                    title: title,
                    startDate: datetimepicker12,
                    link: link
                };
            dataManageService.modifyExamSchedule(data, function () {isReloadPage(true);});
            }
        }else{//저장
            if(confirm("일정 추가 하시겠습니까?")) {
                dataManageService.saveExamSchedule(title, '2019-04-08', function () {isReloadPage(true);});
            }
        }
    }

    function examDelete(val) {
        if(confirm("삭제 하시겠습니까?")) {
            dataManageService.deleteExamSchedule(val, function () {
                isReloadPage(true);
            });
        }
    }

    function getExam(val) {
        $("#key").val('modify');
        dataManageService.getExamScheduleDetailInfo(val, function (selList) {
            var startDate = split_minute_getDay(selList.startDate);
            $("#scheduleKey").val(selList.scheduleKey);
            $("#title").val(selList.title);
            $("#datetimepicker12").val(startDate);
            $("#link").val(selList.link);
        });
    }
</script>
<!--순서-->
<div class="page-breadcrumb">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">시험일정 관리</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">데이터관리</li>
                        <li class="breadcrumb-item active" aria-current="page">시험일정관리</li>
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
        <div class="col-md-8">
            <div class="card">
                <div class="card-body">
                    <button type="button" style="vertical-align: middle;display:inline-block;float:right" class="btn btn-info btn-sm examadd" data-toggle="modal" data-target="#sModal">추가</button>
                </div>
                <table class="table table-hover">
                    <thead>
                    <tr>
                        <th scope="col" style="width: 10%;">CODE</th>
                        <th scope="col" style="width: 55%;">일정이름</th>
                        <th scope="col" style="width: 15%;">날짜</th>
                        <th scope="col" style="width: 15%;">관리</th>
                    </tr>
                    </thead>
                    <tbody id="dataList"></tbody>
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
            <div class="modal-header">
                <h5 class="modal-title">시험일정 설정</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form>
                <input type="hidden" id="key" value="">
            <!-- modal body -->
            <div class="modal-body">
                <div class="form-group row">
                    <label class="col-sm-2 text-right control-label col-form-label">CODE</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="scheduleKey" readonly>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-2 text-right control-label col-form-label">일정이름</label>
                    <div class="col-md-9">
                        <div class="custom-file">
                            <input type="text" class="form-control" id="title">
                        </div>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-2 text-right control-label col-form-label">날짜</label>
                    <div class="col-sm-9">
                        <div class="input-group">
                            <input type="text" class="form-control mydatepicker" placeholder="yyyy-mm-dd" id="datetimepicker12">
                            <div class="input-group-append">
                                <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-2 text-right control-label col-form-label">링크</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="link">
                    </div>
                </div>
                <div style="text-align: center;">
                    <button type="button" class="btn btn-info" onclick="examSave();">저장</button>
                </div>
            </div>
            <!-- //modal body -->
            </form>
        </div>
    </div>
</div>
<!-- //form문 끝 -->
<%@include file="/common/jsp/footer.jsp" %>
<script>
    $('#datetimepicker12').datepicker({
        format: "yyyy-mm-dd",
        language: "kr"
    });
</script>
