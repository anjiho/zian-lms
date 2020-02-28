\<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<%
    String subDomainSel = request.getParameter("param_key");
%>
<script src='https://code.jquery.com/ui/1.11.4/jquery-ui.min.js'></script>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/dataManageService.js'></script>
<script type='text/javascript' src='/dwr/interface/selectboxService.js'></script>
<script>
    var subDomainSel = '<%=subDomainSel%>';
    function init() {
        menuActive('menu-0', 2);
        getSubDomainList("sel_subDomain", subDomainSel);//서브도메인 select 불러오기
        changeBox2(subDomainSel);
        getNewSelectboxListForCtgKey2("l_subjectGroup", "3710", "");//과목
        selectTeacherSelectbox("teacherSel", "");
    }
    //파일 선택시 파일명 보이게 하기
    $(document).on('change', '.custom-file-input', function() {
        $(this).parent().find('.custom-file-control').html($(this).val().replace(/C:\\fakepath\\/i, ''));
    });

    function getThumbnailPrivew(html, $target) {
        if (html.files && html.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                $target.css('display', '');
                //$target.css('background-image', 'url(\"' + e.target.result + '\")'); // 배경으로 지정시
                $target.html('<img src="' + e.target.result + '" border="0" style="max-width:100%; margin-top: 5px;margin-bottom: 5px;height: auto;" alt="" />');
            }
            reader.readAsDataURL(html.files[0]);
        }
    }

    function changeBox2(val) {
        $(".card").remove();

        dataManageService.getBannerList(val,function (selList) {
            if (selList.length > 0) {
                for (var i = 0; i < selList.length; i++) {
                    var cmpList = selList[i];
                    var result = cmpList.result;
                    var addBtn = "";
                    if(result.name == "지안교수진"){
                        addBtn = "<button type='button' onclick='popup_teacher_save(0,"+result.ctgKey+",0,)' data-toggle=\"modal\" data-target=\"#teacherModal\" class=\"row btn btn-info btn-sm\" style=\"float: right;margin-right: 1.25rem\">추가</button>";
                    }else{
                        addBtn = "<button type='button' onclick='popup_save(0,"+result.ctgKey+",0,)' data-toggle=\"modal\" data-target=\"#myModal\" class=\"row btn btn-info btn-sm\" style=\"float: right;margin-right: 1.25rem\">추가</button>";
                    }

                    var posListBtn = "  <button type=\"button\" class=\"btn btn-outline-info btn-sm float-right mr-3 mb-3\" onclick=\"changeBannerList("+i+");\">순서변경저장</button>";
                    if(result.name){
                        var bannerNameHtml = "<div class='card'>";
                        bannerNameHtml += '<div class=\'card-body\'>';
                        bannerNameHtml += '<div class=\'row\'>';
                        bannerNameHtml += "<label class=\'text-right control-label col-form-label\'>" + result.name + "</label>";
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
                    bannerContentHtml += '<th width="25%">타이틀</th>';
                    bannerContentHtml += '<th width="25%">이미지명</th>';
                    bannerContentHtml += '<th width="10%">새창열기</th>';
                    bannerContentHtml += '<th width="20%">링크URL</th>';
                    bannerContentHtml += '<th width="10%"></th>';
                    bannerContentHtml += '</tr>';
                    bannerContentHtml += '</thead>';
                    bannerContentHtml += "<tbody id='dataList"+i+"'></tbody>";
                    bannerContentHtml += '</table>';
                    $('#'+result.ctgKey).append(bannerContentHtml);

                    $( "#dragtable_" + i +" tbody" ).sortable({
                        update: function( event, ui ) {
                            $(this).children().each(function(index) {
                                $(this).find('tr').last().html(index + 1);
                            });
                        }
                    });

                    var selList2 = cmpList.resultList;
                    var dataList =  "dataList"+i;
                    for (var j = 0; j < selList2.length; j++) {
                        var cmpList1 = selList2[j];
                        if(result.name == "지안교수진"){
                            var btn = '<button type="button" data-toggle=\"modal\" data-target=\"#teacherModal\" onclick="teacherPopup('+cmpList1.ctgInfoKey+","+cmpList1.ctgKey+","+cmpList1.pos+')"  class="btn btn-outline-success btn-sm">수정</button><button type="button" onclick="bannerDelete('+cmpList1.ctgInfoKey+","+cmpList1.ctgKey+","+cmpList1.pos+')"  class="btn btn-outline-danger btn-sm delBtn">삭제</button>';
                        }else{
                            var btn = '<button type="button" data-toggle=\"modal\" data-target=\"#myModal\" onclick="popup('+cmpList1.ctgInfoKey+","+cmpList1.ctgKey+","+cmpList1.pos+')"  class="btn btn-outline-success btn-sm">수정</button><button type="button" onclick="bannerDelete('+cmpList1.ctgInfoKey+","+cmpList1.ctgKey+","+cmpList1.pos+')"  class="btn btn-outline-danger btn-sm delBtn">삭제</button>';
                        }

                        var bitText = "";

                        if(cmpList1.valueBit1 == "1") bitText = "<i class=\"mdi mdi-check\" style=\"color:green;\"></i>";
                        else bitText = "<i class=\"mdi mdi-close\" style=\"color: red\"></i>";

                        if (cmpList1 != undefined) {
                            var cellData = [
                                function(data) {return cmpList1.value5 == null ? "-" : cmpList1.value5;},
                                function(data) {return cmpList1.value1 == null ? "-" : fn_clearFilePath(cmpList1.value1);},
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
        $('#myModal').show();
        dataManageService.getBannerDetailInfo(val, function (selList) {
            $("#bannerKey").val(val);
            $("#ctgKey").val(ctgKey);
            $("#pos").val(pos);
            innerValue("title",selList.value5);
            $("#bannerColor").val(selList.value3);
            $("#bannerLink").val(selList.value4);
            $("#newPopYn").prop('checked', selList.valueBit1);
            if (selList.value1 != null) { /*파일명보이게*/
                $(document).ready(function () {
                    $('.custom-file-control').html(fn_clearFilePath(selList.value1));
                });
            }
        });
    }

    //지안교수진 팝업 수정
    function teacherPopup(val,ctgKey,pos) {
        dataManageService.getBannerDetailInfo(val, function (selList) {
            getNewSelectboxListForCtgKey2("l_subjectGroup", "3710", selList.valueLong1);//과목
            selectTeacherSelectbox("teacherSel", selList.valueLong2);
            $("#teacherBannerKey").val(val);
            $("#teacherCtgKey").val(ctgKey);
            $("#teacherPos").val(pos);
            $("#bannerTeacherLink").val(selList.value4);
            $("#newPopYn1").prop('checked', selList.valueBit1);
        });
    }

    function popup_teacher_save(val,ctgKey,pos) {
        $("#teacherBannerKey").val(val);
        $("#teacherCtgKey").val(ctgKey);
        $("#newPopYn1").prop('checked', false);
        $("#bannerTeacherLink").val("");
        getNewSelectboxListForCtgKey2("l_subjectGroup", "3710", "");//과목
        selectTeacherSelectbox("teacherSel", "");
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
    }

    function modify() {
        //저장일경우 pos, ctgingoKey == 0 , ctgKey값만 넘김
        var data = new FormData();
        $.each($('#attachFile')[0].files, function(i, file) {
            data.append('file_name', file);
        });
        var attachFile = fn_clearFilePath($('#attachFile').val());
        var ctgKey     = getInputTextValue("ctgKey");
        var pos        = getInputTextValue("pos");
        var bannerKey  = getInputTextValue("bannerKey");
        var title      = getInputTextValue("title");
        var bannerColor= getInputTextValue("bannerColor");
        var bannerLink = getInputTextValue("bannerLink");
        var checkYn = "";
        if($("input:checkbox[id='newPopYn']:checked").val()=='on') checkYn = '1';
        else checkYn = '0';

        var saveModifttext = '';
        if(bannerKey == '0') saveModifttext = '저장 하시겠습니까?';
        else saveModifttext = '수정 하시겠습니까?';

        data.append("pos", pos);
        data.append("ctgInfoKey", bannerKey);
        data.append("ctgKey", ctgKey);
        data.append("value5", title);
        data.append("value3", bannerColor);
        data.append("valueBit1", checkYn);
        data.append("value4", bannerLink);
        if(confirm(saveModifttext)) {
            $.ajax({
                url: "/file/bannerUpload",
                method: "post",
                dataType: "JSON",
                data: data,
                cache: false,
                processData: false,
                contentType: false,
                success: function (data) {
                    //location.reload();
                    var sel_subDomain =  getSelectboxValue('sel_subDomain');
                    innerValue("param_key", sel_subDomain);
                    goPage('dataManage', 'bannerSave');
                }
            });
        }
    }

    //지안교수진 팝업 수정
    function teacherModify() {
        var ctgKey        = getInputTextValue("teacherCtgKey");
        var subjectCtgKey = getSelectboxValue("selSubjectCtgKey");
        var teacherKey    = getSelectboxValue("sel_1");
        var url   = getInputTextValue("bannerTeacherLink");
        var isNew = "";
        if($("input:checkbox[id='newPopYn1']:checked").val()=='on') isNew = '1';
        else isNew = '0';
        var ctgInfoKey =  getInputTextValue("teacherBannerKey");

        if(ctgInfoKey == '0'){
            if(confirm("저장하시겠습니까?")){
                dataManageService.saveTeacherBannerInfo(ctgKey, subjectCtgKey, teacherKey, isNew, url, function () {
                    var sel_subDomain =  getSelectboxValue('sel_subDomain');
                    innerValue("param_key", sel_subDomain);
                    goPage('dataManage', 'bannerSave');
                });
            }
        }else{
            if(confirm("수정하시겠습니까?")){
                dataManageService.modifyTeacherBannerInfo(ctgInfoKey, subjectCtgKey, teacherKey, isNew, url, function () {
                    var sel_subDomain =  getSelectboxValue('sel_subDomain');
                    innerValue("param_key", sel_subDomain);
                    goPage('dataManage', 'bannerSave');
                });
            }
        }
    }

    function bannerDelete(val, ctgKey, pos) {
        if(confirm("삭제하시겠습니까?")) {
            dataManageService.deleteBannerInfo(val, ctgKey, function () {
                var sel_subDomain =  getSelectboxValue('sel_subDomain');
                innerValue("param_key", sel_subDomain);
                goPage('dataManage', 'bannerSave');
            });
        }
    }

    function changeBannerList(val) {
        var arr = new Array();    // 배열 선언
        var tableName =  "dragtable_"+val;
        if(val == '0'){
            if(confirm("순서변경 하시겠습니까?")){
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
                dataManageService.changeBannerPosition(arr, function () {});
            }
        }else if(val == "1"){
            if(confirm("순서변경 하시겠습니까?")) {
                $("#dragtable_1 tbody tr").each(function (index) {
                    var id = $(this).attr("id");
                    var ctgInfoKey = id;
                    var pos = index;
                    var data = {
                        ctgInfoKey: ctgInfoKey,
                        pos: pos
                    };
                    arr.push(data);
                });
                dataManageService.changeBannerPosition(arr, function () {
                    location.reload();
                });
            }
        }else if(val == "2"){
            if(confirm("순서변경 하시겠습니까?")) {
                $("#dragtable_2 tbody tr").each(function (index) {
                    var id = $(this).attr("id");
                    var ctgInfoKey = id;
                    var pos = index;
                    var data = {
                        ctgInfoKey: ctgInfoKey,
                        pos: pos
                    };
                    arr.push(data);
                });
                dataManageService.changeBannerPosition(arr, function () {
                    location.reload();
                });
            }
        }else if(val == "3"){
            if(confirm("순서변경 하시겠습니까?")) {
                $("#dragtable_3 tbody tr").each(function (index) {
                    var id = $(this).attr("id");
                    var ctgInfoKey = id;
                    var pos = index;
                    var data = {
                        ctgInfoKey: ctgInfoKey,
                        pos: pos
                    };
                    arr.push(data);
                });
                dataManageService.changeBannerPosition(arr, function () {
                    location.reload();
                });
            }
        }else if(val == "4"){
            if(confirm("순서변경 하시겠습니까?")) {
                $("#dragtable_4 tbody tr").each(function (index) {
                    var id = $(this).attr("id");
                    var ctgInfoKey = id;
                    var pos = index;
                    var data = {
                        ctgInfoKey: ctgInfoKey,
                        pos: pos
                    };

                    arr.push(data);
                });
                dataManageService.changeBannerPosition(arr, function () {
                    location.reload();
                });
            }
        }
    }
</script>
<div class="page-breadcrumb">
    <input type="hidden" id="param_key" value="">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">배너관리</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">데이터관리</li>
                        <li class="breadcrumb-item active" aria-current="page">배너관리</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</div>
<div class="container-fluid">
    <div class="form-group">
        <div class="row col-md-6">
            <label class="text-left control-label col-form-label">서브도메인</label>
            <div class="col-sm-5">
                <select id="sel_subDomain" class="form-control" onchange="changeBox2(this.value);">
                    <option value="#">행정직학원</option>
                </select>
            </div>
        </div>
    </div>

    <div id="bannerName"></div>

    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog" role="document" style="max-width: 581px;">
            <div class="modal-content">
                <input type="hidden" id="bannerKey" value="">
                <input type="hidden" id="pos" value="">
                <input type="hidden" id="ctgKey" value="">
                <div class="modal-header">
                    <h5 class="modal-title">배너추가</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <form>
                    <input type="hidden" id="key" value="">
                    <!-- modal body -->
                    <div class="modal-body">
                        <div class="form-group row">
                            <label class="col-sm-3 text-center control-label col-form-label">타이틀</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="title">
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-3 text-center control-label col-form-label">이미지</label>
                            <div class="col-md-9">
                                <div class="custom-file">
                                    <input type="file" class="custom-file-input" id="attachFile"  required>
                                    <span class="custom-file-control custom-file-label"></span>
                                    <!--<div id="cma_image" style="width:30%;max-width:30%;display:none;"></div>-->
                                </div>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-3 text-center control-label col-form-label">배경색상</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="bannerColor">
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-3 text-center control-label col-form-label">새창열기</label>
                            <div class="col-sm-9">
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
                            <label class="col-sm-3 text-center control-label col-form-label">링크url</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="bannerLink">
                            </div>
                        </div>
                        <div style="text-align: center;">
                            <button type="button" class="btn btn-info" style="text-align: center" onkeypress="if(event.keyCode==13) {return false;}" onclick="modify();">저장</button>
                        </div>
                    </div>
                    <!-- //modal body -->
                </form>
            </div>
        </div>
    </div>


    <div class="modal fade" id="teacherModal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog" role="document" style="max-width: 581px;">
            <div class="modal-content">
                <input type="hidden" id="teacherBannerKey" value="">
                <input type="hidden" id="teacherPos" value="">
                <input type="hidden" id="teacherCtgKey" value="">
                <div class="modal-header">
                    <h5 class="modal-title">배너추가</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <form>
                    <!--<input type="hidden" id="key" value="">-->
                    <!-- modal body -->
                    <div class="modal-body">
                        <div class="form-group row">
                            <label class="col-sm-3 text-center control-label col-form-label">과목</label>
                            <div class="col-sm-9">
                                <span id="l_subjectGroup"></span>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-3 text-center control-label col-form-label">강사</label>
                            <div class="col-sm-9">
                                <span id="teacherSel"></span>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-3 text-center control-label col-form-label">새창열기</label>
                            <div class="col-sm-9">
                                <div style="margin-top: -23px;">
                                    OFF
                                    <label class="switch">
                                        <input type="checkbox" id="newPopYn1" name="newPopYn1" style="display:none;">
                                        <span class="slider"></span>
                                    </label>
                                    ON
                                </div>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-3 text-center control-label col-form-label">링크url</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="bannerTeacherLink">
                            </div>
                        </div>
                        <div style="text-align: center;">
                            <button type="button" class="btn btn-info" style="text-align: center" onkeypress="if(event.keyCode==13) {return false;}" onclick="teacherModify();">저장</button>
                        </div>
                    </div>
                    <!-- //modal body -->
                </form>
            </div>
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
