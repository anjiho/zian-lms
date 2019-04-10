<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/dataManageService.js'></script>
<script type='text/javascript' src='/dwr/interface/selectboxService.js'></script>

<script>
    $(document).ready(function() {
        changeBox2();
        //getSubDomainList("sel_subDomain", "");//서브도메인 select 불러오기
        //changeBox2('216');
        //$("#dragtable0").empty();
    });
    //파일 선택시 파일명 보이게 하기
    $(document).on('change', '.custom-file-input', function() {
        $(this).parent().find('.custom-file-control').html($(this).val().replace(/C:\\fakepath\\/i, ''));
    });
    $(document).on('change', '.custom-file-input1', function() {
        $(this).parent().find('.custom-file-control1').html($(this).val().replace(/C:\\fakepath\\/i, ''));
    });
    function changeBox2() {
        $(".card").remove();
        dataManageService.getSideBarBannerList(4200,function (selList) {
            console.log(selList);
            if (selList.length > 0) {
                for (var i = 0; i < selList.length; i++) {
                    var cmpList = selList[i];
                    var result = cmpList.result;
                    var addBtn = "<button type='button' onclick='popup_save(0,"+result.ctgKey+",0)'  class='btn btn-success btn-sm' style='float: right'>추가</button>";
                    if(result.name){
                        var bannerNmaeHtml = "<div class='card'>";
                        bannerNmaeHtml += '<div class=\'card-body\'>';
                        bannerNmaeHtml += '<div class=\'row\'>';
                        bannerNmaeHtml += "<label class=\'text-right control-label col-form-label\'>" + result.name + "</label>";
                        bannerNmaeHtml += '</div>';
                        bannerNmaeHtml += "<div id='"+result.ctgKey+"'>";
                        bannerNmaeHtml += addBtn;
                        bannerNmaeHtml += '</div>';
                        bannerNmaeHtml += '</div>';
                        bannerNmaeHtml += '</div>';
                        $("#test").append(bannerNmaeHtml);
                    }

                    var bannerContentHtml = "<table class='table'  id='dragtable"+i+"' cellspacing='0' cellpadding='2'>";
                    bannerContentHtml += '<thead>';
                    bannerContentHtml += ' <tr>';
                    bannerContentHtml += '<th>타이틀</th>';
                    bannerContentHtml += '<th>이미지</th>';
                    bannerContentHtml += '<th>배경이미지</th>';
                    bannerContentHtml += '<th>배경색상</th>';
                    bannerContentHtml += '<th>새창열기</th>';
                    bannerContentHtml += '<th>링크URL</th>';
                    bannerContentHtml += '<th></th>';
                    bannerContentHtml += '</tr>';
                    bannerContentHtml += '</thead>';
                    bannerContentHtml += "<tbody id='dataList"+i+"'></tbody>";
                    bannerContentHtml += '</table>';
                    $('#'+result.ctgKey).append(bannerContentHtml);

                    var selList2 = cmpList.resultList;
                    var dataList =  "dataList"+i;
                    for (var j = 0; j < selList2.length; j++) {
                        var cmpList1 = selList2[j];

                        var btn = '<button type="button" onclick="popup('+cmpList1.ctgInfoKey+","+cmpList1.ctgKey+","+cmpList1.pos+')"  class="btn btn-success btn-sm">수정</button><button type="button" onclick="bannerDelete('+cmpList1.ctgInfoKey+","+cmpList1.ctgKey+","+cmpList1.pos+')" class="btn btn-danger btn-sm">삭제</button>';
                        var bitText = "";
                        if(cmpList1.valueBit1 == "1"){
                            bitText = "O";
                        }else {
                            bitText = "X";
                        }
                        if (cmpList1 != undefined) {
                            var cellData = [
                                //return cmpList1.valueBit1 == null ? "-" : cmpList1.value1;
                                function(data) {return cmpList1.value5 == null ? "-" : cmpList1.value5;},
                                function(data) {return cmpList1.value1 == null ? "-" : cmpList1.value1;},
                                function(data) {return cmpList1.value2 == null ? "-" : cmpList1.value2;},
                                function(data) {return cmpList1.value3 == null ? "-" : cmpList1.value3;},
                                function(data) {return cmpList1.valueBit1 == null ? "-" : bitText;},
                                function(data) {return cmpList1.value4 == null ? "-" : cmpList1.value4;},
                                function(data) {return btn;}
                            ];
                            dwr.util.addRows(dataList, [0], cellData, {escapeHtml:false});
                        }
                    }
                }
            }
        });
    }

    function popup(val,ctgKey,pos) { //수정팝업
        $('#myModal').show();
        dataManageService.getBannerDetailInfo(val, function (selList) {
            $("#bannerKey").val(val);
            $("#ctgKey").val(ctgKey);
            $("#pos").val(pos);
            $("#title").val(selList.value5);
            $("#bannerColor").val(selList.value3);
            $("#bannerLink").val(selList.value4);
            if (selList.valueBit1 == '1') $("#newPopYn").prop('checked', true);
            else $("#newPopYn").prop('checked', false);

            if (selList.value1 != null) { /*파일명보이게*/
                $(document).ready(function () {
                    $('.custom-file-control').html(selList.value1);
                });
            }
        });
    }
    function popup_save(val,ctgKey,pos) { //추가팝업
        $('#myModal').show();
        $("#title").val("");
        $("#bannerColor").val("");
        $("#bannerLink").val("");
        $('.custom-file-control').html("");
        $("#newPopYn").prop('checked', false);

        $("#bannerKey").val(val);
        $("#ctgKey").val(ctgKey);
        $("#pos").val(pos);
    }
    //팝업 Close 기능
    function close_pop(flag) {
        $('#myModal').hide();
    };

    function modify() {
        //저장일경우 pos, ctgingoKey == 0 , ctgKey값만 넘김
        var data = new FormData();
        $.each($('#attachFile')[0].files, function(i, file) {
            data.append('file_name', file);
        });
        var attachFile = fn_clearFilePath($('#attachFile').val());
        var ctgKey= $("#ctgKey").val();
        var pos = $("#pos").val();
        var bannerKey= $("#bannerKey").val();
        var title = $("#title").val();
        var bannerColor = $("#bannerColor").val();
        var newPopYn =  $('input:checkbox[id="newPopYn"]').val();
        var bannerLink = $("#bannerLink").val();

        if(newPopYn == 'on')  newPopYn = 1;
        else newPopYn = 0;

        data.append("pos", pos);
        data.append("ctgInfoKey", bannerKey);
        data.append("ctgKey", ctgKey);
        data.append("value5", title);
        data.append("value3", bannerColor);
        data.append("valueBit1", newPopYn);
        data.append("value4", bannerLink);

        if(confirm("저장하시겠습니까?")) {
            $.ajax({
                url: "/file/bannerUpload",
                method: "post",
                dataType: "JSON",
                data: data,
                cache: false,
                processData: false,
                contentType: false,
                success: function (data) {
                    location.reload();
                }
            });
        }
    }

    function bannerDelete(val,ctgKey,pos) {
        if(confirm("삭제하시겠습니까?")) {
            dataManageService.deleteBannerInfo(val, ctgKey, function () {
                location.reload();
            });
        }
    }
</script>
<div class="page-breadcrumb">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">배너관리</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">배너관리</li>
                        <li class="breadcrumb-item active" aria-current="page">사이드배너관리</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</div>
<div class="container-fluid">
    <div id="test"></div>
    <!-- The Modal -->
    <form name="popupModal" id="popupModal">
        <div id="myModal" class="modal1">
            <input type="hidden" id="bannerKey" value="">
            <input type="hidden" id="pos" value="">
            <input type="hidden" id="ctgKey" value="">
            <!-- Modal content -->
            <div class="modal-content1">
                <div class="form-group row">
                    <label class="text-right control-label col-form-label">타이틀</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="title">
                    </div>
                </div>
                <div class="form-group row">
                    <label class="text-right control-label col-form-label">이미지</label>
                    <div class="col-sm-9">
                        <label class="custom-file">
                            <input type="file" id="attachFile" class="custom-file-input" required>
                            <span class="custom-file-control"></span>
                        </label>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="text-right control-label col-form-label">배경이미지</label>
                    <div class="col-sm-9">
                        <label class="custom-file1">
                            <input type="file" id="attachFile1" class="custom-file-input1" required>
                            <span class="custom-file-control1"></span>
                        </label>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="text-right control-label col-form-label">배경색상</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="bannerColor">
                    </div>
                </div>
                <div class="form-group row">
                    <label class="text-right control-label col-form-label">새창열기</label>
                    <div class="col-sm-9">
                        <div style="margin-top: -23px;">
                            OFF
                            <label class="switch">
                                <input type="checkbox" id="newPopYn">
                                <span class="slider"></span>
                            </label>
                            ON
                        </div>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="text-right control-label col-form-label">링크url</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="bannerLink">
                    </div>
                </div>
                <div class="form-group row">
                    <button type="button" class="btn btn-info" onclick="modify()">저장</button>
                    <button type="button" class="btn btn-info"   onClick="close_pop();">닫기</button>
                </div>
            </div>
        </div>
    </form>
</div>
<%@include file="/common/jsp/footer.jsp" %>
<script>
    function fn_clearFilePath(val){
        var tmpStr = val;

        var cnt = 0;
        while(true){
            cnt = tmpStr.indexOf("/");
            if(cnt == -1) break;
            tmpStr = tmpStr.substring(cnt+1);
        }
        while(true){
            cnt = tmpStr.indexOf("\\");
            if(cnt == -1) break;
            tmpStr = tmpStr.substring(cnt+1);
        }

        return tmpStr;
    }
</script>
