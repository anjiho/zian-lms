<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<script src='https://code.jquery.com/ui/1.11.4/jquery-ui.min.js'></script>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/dataManageService.js'></script>
<script type='text/javascript' src='/dwr/interface/selectboxService.js'></script>

<script>
    $(document).ready(function() {
        changeBox2();
        menuActive('menu-0', 3);
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
            if (selList.length > 0) {
                for (var i = 0; i < selList.length; i++) {
                    var cmpList = selList[i];
                    var result = cmpList.result;
                    var addBtn = "<button type='button' onclick='popup_save(0,"+result.ctgKey+",0)' data-toggle=\"modal\" data-target=\"#myModal\" class=\"row btn btn-info btn-sm\" style=\"float: right;margin-right: 1.25rem\">추가</button>";
                    var posListBtn = "  <button type=\"button\" class=\"btn btn-outline-info btn-sm float-right mr-3 mb-3\" onclick=\"changeBannerList("+i+");\">순서변경저장</button>";
                    if(result.name){
                        var bannerNameHtml = "<div class='card'>";
                        bannerNameHtml += '<div class=\'card-body\'>';
                        bannerNameHtml += '<div class=\'row\'>';
                        //bannerNameHtml += "<label class=\'text-right control-label col-form-label\'>" + result.name + "</label>";
                        bannerNameHtml += '</div>';
                        bannerNameHtml += "<div id='"+result.ctgKey+"'>";
                        bannerNameHtml += addBtn;
                        bannerNameHtml += posListBtn;
                        bannerNameHtml += '</div>';
                        bannerNameHtml += '</div>';
                        bannerNameHtml += '</div>';
                        $("#bannerName").append(bannerNameHtml);
                    }

                    var bannerContentHtml = "<table class='table'  id='dragtable_"+i+"' cellspacing='0' cellpadding='2'>";
                    bannerContentHtml += '<thead>';
                    bannerContentHtml += ' <tr>';
                    bannerContentHtml += '<th>타이틀</th>';
                    bannerContentHtml += '<th>이미지</th>';
                    bannerContentHtml += '<th>새창열기</th>';
                    bannerContentHtml += '<th>링크URL</th>';
                    bannerContentHtml += '<th></th>';
                    bannerContentHtml += '</tr>';
                    bannerContentHtml += '</thead>';
                    bannerContentHtml += "<tbody id='dataList"+i+"'></tbody>";
                    bannerContentHtml += '</table>';
                    $('#'+result.ctgKey).append(bannerContentHtml);

                    $( "#dragtable_" + i +" tbody" ).sortable({
                        update: function( event, ui ) {
                            $(this).children().each(function(index) {
                                $(this).find('tr').last().html(index + 1);
                                //$(this).attr("style", 'background-color:gray');
                            });
                        },
                        hover: function() {
                            $(this).css('backgroundColor', 'red');
                        }
                    });

                    var selList2 = cmpList.resultList;
                    var dataList =  "dataList"+i;
                    for (var j = 0; j < selList2.length; j++) {
                        var cmpList1 = selList2[j];

                        var btn = '<button type="button" data-toggle=\"modal\" data-target=\"#myModal\"  onclick="popup('+cmpList1.ctgInfoKey+","+cmpList1.ctgKey+","+cmpList1.pos+')"  class="btn btn-outline-success btn-sm">수정</button><button type="button" onclick="bannerDelete('+cmpList1.ctgInfoKey+","+cmpList1.ctgKey+","+cmpList1.pos+')"  class="btn btn-outline-danger btn-sm">삭제</button>';
                        if(cmpList1.valueBit1 == "1") bitText = "<i class=\"mdi mdi-check\" style=\"color:green;\"></i>";
                        else bitText = "<i class=\"mdi mdi-close\" style=\"color: red\"></i>";

                        if (cmpList1 != undefined) {
                            var cellData = [
                                //return cmpList1.valueBit1 == null ? "-" : cmpList1.value1;
                                function(data) {return cmpList1.value5 == null ? "-" : cmpList1.value5;},
                                function(data) {return cmpList1.value1 == null ? "-" : fn_clearFilePath(cmpList1.value1);},
                                //function(data) {return cmpList1.value2 == null ? "-" : cmpList1.value2;},
                                //function(data) {return cmpList1.value3 == null ? "-" : cmpList1.value3;},
                                function(data) {return cmpList1.valueBit1 == null ? "-" : bitText;},
                                function(data) {return cmpList1.value4 == null ? "-" : gfn_substr(cmpList1.value4, 1, 30)+"...";},
                                function(data) {return btn;}
                            ];
                            dwr.util.addRows(dataList, [0], cellData, {
                                rowCreator:function(options) {
                                    var row = document.createElement("tr");
                                    var index = options.rowIndex * 50;
                                    row.id = cmpList1.ctgInfoKey;
                                    row.className = "ui-state-default even ui-sortable-handle";
                                    return row;
                                },
                                escapeHtml:false});
                        }
                    }
                }
            }
        });
    }

    function popup(val,ctgKey,pos) { //수정팝업
        dataManageService.getBannerDetailInfo(val, function (selList) {
            $("#bannerKey").val(val);
            $("#ctgKey").val(ctgKey);
            $("#pos").val(pos);
            $("#title").val(selList.value5);
            $("#bannerColor").val(selList.value3);
            $("#bannerLink").val(selList.value4);
            $("#newPopYn").prop('checked', selList.valueBit1);
            if (selList.value1 != null) { /*파일명보이게*/
                $(document).ready(function () {
                    $('.custom-file-control').html(selList.value1);
                });
            }
        });
    }
    function popup_save(val,ctgKey,pos) { //추가팝업
        $("#title").val("");
        $("#bannerColor").val("");
        $("#bannerLink").val("");
        $('.custom-file-control').html("");
        $("#bannerKey").val(val);
        $("#ctgKey").val(ctgKey);
        $("#pos").val(pos);
        $("#newPopYn").prop('checked', false);
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
        var bannerLink = $("#bannerLink").val();
        var checkYn = "";
        if($("input:checkbox[id='newPopYn']:checked").val()=='on'){
            checkYn = '1';
        }else{
            checkYn = '0';
        }
        data.append("pos", pos);
        data.append("ctgInfoKey", bannerKey);
        data.append("ctgKey", ctgKey);
        data.append("value5", title);
        data.append("value3", bannerColor);
        data.append("valueBit1", checkYn);
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

    function changeBannerList(val) {
        if(confirm("순서변경을 하시겠습니까?")){
            var arr = new Array();    // 배열 선언
            var tableName =  "dragtable_"+val;
            if(val == '0'){
                $("#dragtable_0 tbody tr").each(function(index) {
                    var id = $(this).attr("id");
                    var ctgInfoKey = id;
                    var pos = index;
                    var data = {
                        ctgInfoKey : ctgInfoKey,
                        pos : pos
                    };
                    arr.push(data);
                });
                dataManageService.changeBannerPosition(arr, function () {
                    location.reload();
                });
            }else if(val == "1"){
                $("#dragtable_1 tbody tr").each(function(index) {
                    var id = $(this).attr("id");
                    var ctgInfoKey = id;
                    var pos = index;
                    var data = {
                        ctgInfoKey : ctgInfoKey,
                        pos : pos
                    };
                    arr.push(data);
                });
                dataManageService.changeBannerPosition(arr, function () {location.reload();});
            }
        }
    }
</script>
<div class="page-breadcrumb">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">사이드바 배너관리</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">데이터관리</li>
                        <li class="breadcrumb-item active" aria-current="page">사이드배너관리</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</div>
<div class="container-fluid">
    <div id="bannerName"></div>
</div>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document" style="max-width:600px;max-height: 200px;">
        <div class="modal-content">
            <input type="hidden" id="bannerKey" value="">
            <input type="hidden" id="pos" value="">
            <input type="hidden" id="ctgKey" value="">
            <div class="modal-header">
                <h5 class="modal-title">사이드배너 추가</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form>
                <input type="hidden" id="key" value="">
                <!-- modal body -->
                <div class="modal-body">
                    <div class="form-group row">
                        <label class="col-sm-2 text-center control-label col-form-label">타이틀명</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="title">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-2 text-center control-label col-form-label">이미지명</label>
                        <div class="col-md-10">
                            <div class="custom-file">
                                <input type="file" class="custom-file-input" id="attachFile"  onchange="getThumbnailPrivew(this,$('#cma_image'))" required>
                                <span class="custom-file-control custom-file-label"></span>
                                <div id="cma_image" style="width:30%;max-width:30%;display:none;"></div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-2 text-center control-label col-form-label">배경색상</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="bannerColor">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-2 text-center control-label col-form-label">새창열기</label>
                        <div class="col-sm-10">
                            <div style="margin-top: -23px;">
                                OFF
                                <label class="switch">
                                    <input type="checkbox" id="newPopYn" name="newPopYn" style="display:none;">
                                    <span class="slider"></span>
                                </label>
                                ON
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-2 text-center control-label col-form-label">링크url</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="bannerLink">
                        </div>
                    </div>
                    <div style="text-align: center;">
                        <button type="button" class="btn btn-info" style="text-align: center" onclick="modify();">저장</button>
                    </div>
                </div>
                <!-- //modal body -->
            </form>
        </div>
    </div>
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
