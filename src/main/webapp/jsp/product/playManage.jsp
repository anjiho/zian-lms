<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/productManageService.js'></script>
<!-- 강의교재 메뉴 팝업 관련 스크립트 include -->
<script src="common/js/bookGiftListPopup.js"></script>
<script>
    function init() {
        menuActive('menu-1', 2);
        getProductSearchTypeSelectbox("l_productSearch");
        //탭 메뉴 색상 변경
        $("#playForm ul").each(function(idx) {
            var ul = $(this);
            ul.find("li").addClass("done").attr("aria-selected", "false");
            ul.find("li").eq(0).removeClass("done").attr("aria-selected", "true");
        });
    }
    $( document ).ready(function() {
        getVideoOptionTypeList("kind_0","");
        getCategoryList("sel_category","214");
        getNewSelectboxListForCtgKey("l_classGroup", "4309", "");//급수
        getNewSelectboxListForCtgKey2("l_subjectGroup", "70", "");//과목
        getNewSelectboxListForCtgKey3("l_stepGroup", "202", "");//유형
        getSelectboxListForCtgKey("SubjectList_0","70");//과목 셀렉트박스
        selectTeacherSelectbox("teacherList_0","");//선생님 셀렉트박스
        getLectureCountSelectbox("lectureTimeCnt","");//강좌시간
        getLectureCountSelectbox("lectureCnt","");//강좌정보 강좌수
        getClassRegistraionDaySelectbox("lectureDayCnt","");//수강일수
        selectExamSearchSelectbox("searchType","");
        selectExamSearchSelectbox("examsearchType","");
        selectExamSearchSelectbox("booksearchType","");
        getExamPrepareSelectbox("examYear","");//시험대비년도 셀렉트박스
        getLectureStatusSelectbox("status","");//강좌정보- 진행상태
        $('#description').summernote({ //기본정보-에디터
            height: 430,
            focus: true,
            theme: 'cerulean',
            popover: {
                image: [],
                link: [],
                air: []
            }
        });
        $('.sModal3').on('hidden.bs.modal', function (e) { /*modal 초기화*/
            $('form').each(function(){
                this.reset();
            });
        });
        $('.sModal4').on('hidden.bs.modal', function (e) {
            $('form').each(function(){
                this.reset();
            });
        });
        $('.bookModal').on('hidden.bs.modal', function (e) {
            $('form').each(function(){
                this.reset();
            });
        });
    });

    //테이블 로우 삭제
    function deleteTableRow(tableId) {
        $("#categoryTable > tbody > tr").length;

        if (tableId == "productOption") {
            if ($("#optionTable > tbody > tr").length == 1) {
                $('#optionTable > tbody:first > tr:first').attr("style", "display:none");
            } else {
                $('#optionTable > tbody:last > tr:last').remove();
            }
        } else if (tableId == "productCategory") {
            if ($("#categoryTable > tbody > tr").length == 1) {
                $('#categoryTable > tbody:first > tr:first').attr("style", "display:none");
            } else {
                $('#categoryTable > tbody:last > tr:last').remove();
            }
        } else if (tableId == "productTeacher") {
            if ($("#teacherTabel > tbody > tr").length == 1) {
                $('#teacherTabel > tbody:first > tr:first').attr("style", "display:none");
            } else {
                $('#teacherTabel > tbody:last > tr:last').remove();
            }
        }  else if(tableId == 'productBook'){
            $('#bookTable > tbody:last > tr:last').remove();
        }
    }

    function addOption(){ //옵션명 추가
        var optionCnt = $("#optionTable tr").length-1;
        var getOption = "kind_"+optionCnt;
        getVideoOptionTypeList(getOption, "");
        var optionHtml = "<tr>";
                optionHtml += "<td style=\"padding: 0.3rem;text-align: center;\">";
                    optionHtml += "<select class=\"select2 form-control custom-select\" style=\"height:36px;\"  id='kind_"+optionCnt+"'  name='kind_"+optionCnt+"'>";
                        optionHtml += "<option>선택</option>";
                    optionHtml += "</select>";
                optionHtml += "</td>";
                    optionHtml += "<td style=\"padding: 0.3rem;\">";
                    optionHtml += "<input type=\"number\" class=\"form-control\">";
                optionHtml += "</td>";
                    optionHtml += "<td style=\"padding: 0.3rem;\">";
                    optionHtml += "<input type=\"number\" class=\"form-control\"  id='sellPrice_"+optionCnt+"'  name='sellPrice_"+optionCnt+"'>";
                optionHtml += "</td>";
                optionHtml += " <td style=\"padding: 0.3rem;\">";
                    optionHtml += "<input type=\"text\" class=\"form-control\" >";
                optionHtml += "</td>";
                optionHtml += " <td style=\"padding: 0.3rem;\">";
                     optionHtml += "<input type=\"number\" style=\"display: inline-block\" class=\"form-control\" id=\"extendPercent\" name=\"extendPercent\" onchange='saleInputPrice(this.value"+","+optionCnt+")' >";
                optionHtml += "</td>";
                optionHtml += "<td style=\"padding: 0.3rem;\">";
                    optionHtml += "<input type=\"number\" class=\"form-control\" id='resultPrice_"+optionCnt+"'  readonly>";
                optionHtml += "</td>";
                optionHtml += " <td style=\"padding: 0.3rem;\">";
                    optionHtml += "<button type=\"button\" onclick=\"deleteTableRow('productOption')\" class=\"btn btn-outline-danger btn-sm\" style=\"margin-top:8%;\">삭제</button>";
                optionHtml += "</a>";
                optionHtml += "</td>";
        optionHtml += "</tr>";
            $('#optionTable > tbody:first').append(optionHtml);
    }

    function addTeacher(){
        var optionCnt = $("#teacherTabel tr").length-1;
        var SubjectCnt = "SubjectList_"+optionCnt;
        var teacherCnt = "teacherList_"+optionCnt;
        getSelectboxListForCtgKey(SubjectCnt,"70");//과목 셀렉트박스
        selectTeacherSelectbox(teacherCnt,"");//선생님 셀렉트박스

        var optionHtml  = "<tr>";
         optionHtml  += "<td style=\"padding: 0.3rem;text-align: center;width: 20%;vertical-align: middle\">";
         optionHtml  += "<select class=\"select2 form-control custom-select\" style=\"height:36px;\" id='SubjectList_"+optionCnt+"'>";
         optionHtml  += "<option>선택</option>";
         optionHtml  += "</select>";
         optionHtml  += "</td>";
         optionHtml  += "<td style=\"padding: 0.3rem; vertical-align: middle;width:2%;text-align: center;\">";
         optionHtml  += "<i class=\"m-r-10 mdi mdi-play\" style=\"font-size:18px;color:darkblue\"></i>";
         optionHtml  += "</td>";
         optionHtml  += "<td style=\"padding: 0.3rem;width: 20%\">";
         optionHtml  += "<select class=\"select2 form-control custom-select\" style=\"height:36px;\" id='teacherList_"+optionCnt+"'>";
         optionHtml  += " <option>선택</option>";
         optionHtml  += "</select>";
         optionHtml  += "</td>";
         optionHtml  += "<td style=\"padding: 0.3rem;width:60%;text-align:right;vertical-align: middle\">";
         optionHtml  += "<label style=\"display: inline-block\">조건 : </label>";
         optionHtml  += "<input type=\"text\" class=\"form-control\" value='100' style=\"display: inline-block;width:60%;text-align: right;\"> %";
         optionHtml  += "</td>";
         optionHtml  += "<td style=\"width:3%;vertical-align: middle\">";
         optionHtml += "<button type=\"button\" onclick=\"deleteTableRow('productTeacher')\" class=\"btn btn-outline-danger btn-sm\" style=\"margin-top:8%;\">삭제</button>";
         optionHtml  += "</td>";
         optionHtml  += "</tr>";
        $('#teacherTabel > tbody:first').append(optionHtml);
    }

    //파일 선택시 파일명 보이게 하기
    $(document).on('change', '.custom-file-input', function() {
        $(this).parent().find('.custom-file-control').html($(this).val().replace(/C:\\fakepath\\/i, ''));
    });
    $(document).on('change', '.addFile', function() {
        $(this).parent().find('.custom-file-control1').html($(this).val().replace(/C:\\fakepath\\/i, ''));
    });




    //옵션 - 판매가 재수강시 할인율적용 함수
    function saleInputPrice(val,cnt) {
        selPriceCnt = "sellPrice_"+cnt;
        resultPirceCnt = "resultPrice_"+cnt;
        var sellPrice = getInputTextValue(selPriceCnt);
        totalprice = Math.round(sellPrice -((sellPrice * val) / 100));
        innerValue(resultPirceCnt,totalprice);
    }

    //카테고리 추가 버튼
    function addCategoryInfo() {
        var fistTrStyle = $("#categoryTable tr").eq(0).attr("style");

        if (fistTrStyle == "display:none") {
            $('#categoryTable tr').eq(0).removeAttr("style", null);
        } else {
            var $tableBody = $("#categoryTable").find("tbody"),
                $trLast = $tableBody.find("tr:last"),
                $trNew = $trLast.clone();
            $trLast.after($trNew);

            getCategoryNoTag2('categoryTable','1183', '2');
            /*$trNew.find("td").eq(3).html(defaultCategorySelectbox());
            $trNew.find("td").eq(5).html(defaultCategorySelectbox());
            $trNew.find("td").eq(7).html(defaultCategorySelectbox());*/
        }
    }
    //카테코리 셀렉트 박스 변경 시
    function changeCategory(tableId, val, tdNum) {
        if(tdNum == '5') return false;
        getCategoryNoTag2(val, tableId, tdNum);
    }

    //저장
    function playSave() {
        var data = new FormData();
        $.each($('#imageListFile')[0].files, function(i, file) {
            data.append('imageListFile', file);
        });

        $.each($('#imageViewFile')[0].files, function(i, file) {
            data.append('imageViewFile', file);
        });

        /* 1. 기본정보 obj */
        var obj = getJsonObjectFromDiv("section1");
        if(obj.isShow == 'on')  obj.isShow = '1';//노출 checkbox
        else obj.isShow = '0';
        if(obj.isSell == 'on')  obj.isSell = '1';//판매
        else obj.isSell = '0';
        if(obj.isFree == 'on')  obj.isFree = '1';//무료
        else obj.isFree = '0';
        if(obj.isFreebieDeliveryFree == 'on')  obj.isFreebieDeliveryFree = '1';//사은품배송비무료
        else obj.isFreebieDeliveryFree = '0';

        /*  //기본정보 obj */

        /*  2.옵션 obj */
        var array = new Array();
        $('#optionTable tbody tr').each(function(index){
            var i =0;
            var optionName = $(this).find("td select").eq(0).val();
            var price = $(this).find("td input").eq(0).val();
            var sellPrice = $(this).find("td input").eq(1).val();
            var point = $(this).find("td input").eq(2).val();
            var extendPercent = $(this).find("td input").eq(3).val();
            var data = {
                priceKey:'0',
                gKey:'0',
                kind:optionName,
                ctgKey:'0',
                name:'0',
                price:price,
                sellPrice:sellPrice,
                point:point,
                extendPercent:extendPercent
            };
            array.push(data);
        });
        /* //옵션 obj */

        /* 3. 카테고리 저장 */
        var categoryArr = new Array();
        $('#categoryTable tbody tr').each(function(index){
            var ctgKey = $(this).find("td select").eq(4).val();
            alert(ctgKey);
            var data = {
                ctgGKey:0,
                ctgKey:ctgKey,
                gKey:0,
                pos:0
            };
            categoryArr.push(data);
        });

        /*  4.강좌정보 obj  */
        var lectureObj = getJsonObjectFromDiv("section4");
        /*  //강좌정보 obj  */

        /*  5.강사정보 obj  */
        var array2 = new Array();
        $('#teacherTabel tbody tr').each(function(index){
            var teacher = $(this).find("td select").eq(0).val();
            var teacher1 = $(this).find("td select").eq(1).val();
            var teacher2 = $(this).find("td input").eq(0).val();

            var data = {
                gTeacherKey:'0',
                gKey:'0',
                isPublicSubject:'0',
                subjectCtgKey:teacher,
                teacherKey:teacher1,
                calculateRate:teacher2,
                subjectName: "",
                teacherName: ""
            };
            array2.push(data);
        });
        /*  //강사정보 obj  */

        /*  6.선택 obj  */
        var array3 = new Array();
        $('#bookTable tbody tr').each(function(index){
            var bookKey = $(this).find("td input").eq(0).val();
            var isBookMainId = "isBookMain_" + bookKey;
            var isBookMain = $("input:checkbox[id=" + "'" + isBookMainId + "'" + "]").is(":checked");
            //주교재 여부 값 변환
            if (isBookMain) valueBit = 1;
            else valueBit = 0;

            var data = {
                linkKey: 0,
                reqKey: 0,
                resKey:bookKey,
                resType: 5,
                pos: 0,
                valueBit: valueBit
            };
            array3.push(data);
        });

        data.append("videoInfo", JSON.stringify(obj));
        data.append("videoOptionInfo",JSON.stringify(array));
        data.append("videoCategoryInfo",JSON.stringify(categoryArr));
        data.append("videoLectureInfo",JSON.stringify(lectureObj));
        data.append("videoTeacherInfo",JSON.stringify(array2));
        data.append("videoOtherInfo",JSON.stringify(array3));
        if(confirm("저장하시겠습니까?")) {
            $.ajax({
                url: "/file/productUpload",
                method: "post",
                dataType: "JSON",
                data: data,
                cache: false,
                processData: false,
                contentType: false,
                success: function (data) {
                    if(data.result){
                        goPage('productManage', 'playList');
                    }else{
                        alert("result 값이없음, 에러 ");
                    }
                }
            });
        }

    }


</script>
<div class="page-breadcrumb">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">동영상 등록</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">상품관리</li>
                        <li class="breadcrumb-item active" aria-current="page">동영상 등록</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</div>
<!--//순서-->

<!-- 기본 소스-->
<form id="basic">
<div class="container-fluid">
    <div class="card">
        <div class="card-body wizard-content">
            <h4 class="card-title"></h4>
            <h6 class="card-subtitle"></h6>
            <div id="playForm" method="" action="" class="m-t-40">
                <div>
                    <!-- 1.기본정보 Tab -->
                    <h3>기본정보</h3>
                    <section class="col-md-auto">
                        <div id="section1">
                            <input type="hidden" value="0" name="gKey">
                            <input type="hidden" value="0" name="cpKey">
                            <input type="hidden" value="0" name="isNodc">
                            <input type="hidden" value="0" name="tags">
                            <input type="hidden" value="0" name="calculateRate">
                            <input type="hidden" value="0" name="isQuickDelivery">
                            <input type="hidden" value="0" name="goodsId">
                            <input type="hidden" value="" name="goodsTypeName">
                            <input type="hidden" value="" name="summary">
                            <div class="col-md-12">
                                <div class="form-group row">
                                    <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">상품타입</label>
                                    <span>온라인강좌</span>
                                    <input type="hidden" class="col-sm-6 bg-light required form-control" id="type" name='type' value="1">
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">이름</label>
                                    <input type="text" class="col-sm-6 form-control" id="name" name="name">
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">등록일</label>
                                    <div class="col-sm-6 input-group pl-0 pr-0" id="dateRangePicker">
                                        <input type="text" class="form-control mydatepicker" placeholder="yyyy.mm.dd" name="indate" id="indate">
                                        <div class="input-group-append">
                                            <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">판매시작일</label>
                                    <div class="col-sm-6 input-group pl-0 pr-0">
                                        <input type="text" class="form-control mydatepicker" placeholder="mm/dd/yyyy" name="sellstartdate" id="sellstartdate">
                                        <div class="input-group-append">
                                            <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group row mt-4">
                                    <label class="col-sm-2 text-left control-label col-form-label">노출</label>
                                    <div class="col-sm-10">
                                        <div style="margin-top: -23px;">
                                            OFF
                                            <label class="switch">
                                                <input type="checkbox" id="isShow" name="isShow" style="display:none;">
                                                <span class="slider"></span>
                                            </label>
                                            ON
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-2 text-left control-label col-form-label">판매</label>
                                    <div class="col-sm-10">
                                        <div style="margin-top: -23px;">
                                            OFF
                                            <label class="switch">
                                                <input type="checkbox" id="is_sell" name="isSell" style="display:none;">
                                                <span class="slider"></span>
                                            </label>
                                            ON
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-2 text-left control-label col-form-label">무료</label>
                                    <div class="col-sm-10">
                                        <div style="margin-top: -23px;">
                                            OFF
                                            <label class="switch">
                                                <input type="checkbox" id="is_free" name="isFree" style="display:none;">
                                                <span class="slider"></span>
                                            </label>
                                            ON
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">리스트이미지</label>
                                    <div class="col-sm-6 pl-0 pr-0">
                                        <div class="custom-file">
                                            <input type="file" class="custom-file-input" id="imageListFile"  name="imageListFile" required>
                                            <span class="custom-file-control custom-file-label"></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">상세이미지</label>
                                    <div class="col-sm-6 pl-0 pr-0">
                                        <div class="custom-file">
                                            <input type="file" class="custom-file-input addFile"  id="imageViewFile" name="imageViewFile" required>
                                            <span class="custom-file-control1 custom-file-label"></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label  class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">강조표시</label>
                                    <div class="col-sm-2 pl-0 pr-0">
                                        <select class="select2 form-control custom-select" id="emphasis" name="emphasis">
                                            <option value="0">없음</option>
                                            <option value="1">BEST</option>
                                            <option value="2">NEW</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-2 control-label col-form-label">사은품 배송비 무료</label>
                                    <div class="col-sm-10">
                                        <div style="margin-top: -23px;">
                                            OFF
                                            <label class="switch">
                                                <input type="checkbox" style="display:none;" id="is_freebie_delivery_free" name="isFreebieDeliveryFree">
                                                <span class="slider"></span>
                                            </label>
                                            ON
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-form-label">상세설명</label>
                                    <div>
                                        <textarea  name="description"  value="" id="description"></textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                    <!-- // 1.기본정보 Tab -->

                    <!-- 2.옵션 Tab -->
                    <h3>옵션</h3>
                    <section>
                        <div id="section2">
                            <table class="table" id="optionTable">
                                <input type="hidden" value="0" name="goodsTypeName">
                                <thead>
                                <tr style="border-top:0">
                                    <th scope="col" style="text-align:center;width:30%">옵션명</th>
                                    <th scope="col" style="text-align:center;">원가</th>
                                    <th scope="col" style="text-align:center;">판매가</th>
                                    <th scope="col" style="text-align:center;">포인트</th>
                                    <th scope="col" colspan="2" style="text-align:center;">재수강</th>
                                    <th scope="col" style="text-align:center;"></th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td style="padding: 0.3rem;text-align: center;"><!--옵션명selbox-->
                                        <select class="select2 form-control custom-select" style="height:36px;" id="kind_0" name="kind_0">
                                            <option>선택</option>
                                        </select>
                                    </td>
                                    <td style="padding: 0.3rem;"><!--원가-->
                                        <input type="number" class="form-control" id="price" name="price">
                                    </td>
                                    <td style="padding: 0.3rem;"><!--판매가-->
                                        <input type="number" class="form-control" id="sellPrice_0" name="sellPrice_0">
                                    </td>
                                    <td style="padding: 0.3rem;"><!--포인트-->
                                        <input type="text" class="form-control" id="point" name="point">
                                    </td>
                                    <td style="padding: 0.3rem;"><!--재수강1-->
                                        <input type="number" style="display: inline-block" class="form-control" id="extendPercent" name="extendPercent" onchange="saleInputPrice(this.value,0)">
                                    </td>
                                    <td style="padding: 0.3rem;"><!--재수강2-->
                                        <input type="number" class="form-control" id="resultPrice_0" readonly>
                                    </td>
                                    <td style="padding: 0.3rem;">
                                        <button type="button" onclick="deleteTableRow('optionDelete');" class="btn btn-outline-danger btn-sm" style="margin-top:8%;">삭제</button>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                            <div class="mx-auto" style="width:5.5%">
                                <button type="button" class="btn btn-outline-info mx-auto" onclick="addOption();">추가</button>
                            </div>
                        </div>
                    </section>
                    <!-- //2.옵션 Tab -->

                    <!-- 3.카테고리 목록 Tab -->
                    <h3>카테고리</h3>
                    <section>
                        <div class="float-right mb-3">
                            <button type="button" class="btn btn-info btn-sm" onclick="addCategoryInfo();">추가</button>
                        </div>
                        <div id="section3">
                                <table class="table" id="categoryTable">
                                    <input type="hidden" name="ctgGKey" value="0">
                                    <input type="hidden" name="gKey" value="0">
                                    <input type="hidden" name="pos" value="0">
                                    <thead>
                                    <tr style="display:none;">
                                        <th></th>
                                        <th scope="col"></th>
                                        <th scope="col"></th>
                                        <th scope="col"></th>
                                        <th scope="col"></th>
                                        <th scope="col"></th>
                                        <th scope="col"></th>
                                        <th scope="col"></th>
                                    </tr>
                                    </thead>
                                    <tbody id="categoryList">
                                    <tr>
                                        <td><!--옵션명selbox-->
                                            <select class='form-control'  id='sel_category' onchange="getCategoryNoTag2('categoryTable','1183', '2');">
                                            </select>
                                        </td>
                                        <td>
                                            <i class="m-r-10 mdi mdi-play" style="font-size:18px;color:darkblue"></i>
                                        </td>
                                        <td>
                                            <select class='form-control'>
                                            </select>
                                        </td>
                                        <td>
                                            <i class="m-r-10 mdi mdi-play" style="font-size:18px;color:darkblue"></i>
                                        </td>
                                        <td>
                                            <select class='form-control'>
                                            </select>
                                        </td>
                                        <td>
                                            <i class="m-r-10 mdi mdi-play" style="font-size:18px;color:darkblue"></i>
                                        </td>
                                        <td>
                                            <select class='form-control'>
                                            </select>
                                        </td>
                                        <td>
                                            <i class="m-r-10 mdi mdi-play" style="font-size:18px;color:darkblue"></i>
                                        </td>
                                        <td>
                                            <select class='form-control'  name="ctgKey">
                                            </select>
                                        </td>
                                        <td>
                                            <button type="button" onclick="deleteTableRow('productCategory')" class='btn btn-outline-danger btn-sm' style="margin-top:8%;">삭제</button>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                        </div>
                    </section>
                    <!-- //3.카테고리 목록 Tab -->

                    <!-- 4.강좌 정보 Tab -->
                    <h3>강좌정보</h3>
                    <section>
                        <!--<div class="form-group">
                            <label class="control-label col-form-label" style="margin-bottom: 0">강좌 CODE</label>
                            <input type="text" class="form-control" value="" readonly>
                        </div>-->
                        <div id="section4">
                            <input type="hidden" name="lecKey" value="0">
                            <input type="hidden" name="gKey" value="0">
                            <input type="hidden" name="teacherKey" value="0">
                            <input type="hidden" name="regdate" value="">
                            <input type="hidden" name="startdate" value="">
                            <input type="hidden" name="isPack" value="0">
                            <input type="hidden" name="goodsId" value="0">
                            <input type="hidden" name="lecDateYear" value="0">
                            <input type="hidden" name="lecDateMonth" value="0">
                            <div class="form-group">
                                <label class="col-sm-1 control-label col-form-label" style="margin-bottom: 0">급수</label>
                                <span id="l_classGroup"></span>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-1 control-label col-form-label" style="margin-bottom: 0">과목</label>
                                <span id="l_subjectGroup"></span>
                            </div>
                            <div class="form-group">
                                <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">유형</label>
                                <span id="l_stepGroup"></span>
                            </div>
                            <div class="form-group">
                                <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">진행상태</label>
                                <select class="col-sm-3 select2 form-control custom-select" name="status" id="status">
                                    <option value="">선택</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">강좌수</label>
                                <select  class="col-sm-3 select2 form-control custom-select"  id="lectureCnt" name="limitCount">
                                    <option value="">선택</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">수강일수</label>
                                <select class="col-sm-3 select2 form-control custom-select"  id="lectureDayCnt" name="limitDay">
                                    <option value="">선택</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">강좌시간</label>
                                <select class="col-sm-3 select2 form-control custom-select"  id="lectureTimeCnt" name="lecTime">
                                    <option value="">선택</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">배수</label>
                                <input type="text" class="col-sm-3 form-control" style="display: inline-block;" id="multiple" name="multiple"><span style="font-size:11px;vertical-align:middle;color:#999;font-weight:500;margin-left:10px">*배수가 0이면 무제한</span>
                            </div>
                            <div class="form-group">
                                <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">시험대비년도</label>
                                <select class="col-sm-3 select2 form-control custom-select" id="examYear" name="examYear">
                                </select>
                            </div>
                        </div>
                    </section>
                    <!-- //4.강좌 정보 Tab -->

                    <!-- 5.강사 목록 Tab -->
                    <h3>강사목록</h3>
                    <section>
                        <div class="float-right mb-3">
                            <button type="button" class="btn btn-info btn-sm" onclick="addTeacher();">추가</button>
                        </div>
                        <div id="section5">
                            <table class="table" id="teacherTabel">
                                <input type="hidden" name="gTeacherKey" value="0">
                                <input type="hidden" name="gKey" value="0">
                                <thead>
                                <tr>
                                    <th scope="col" colspan="5" style="text-align:center;width:30%">강사목록</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td style="padding: 0.3rem;text-align: center;width: 20%;vertical-align: middle">
                                        <select class="select2 form-control custom-select" style="height:36px;" id="SubjectList_0" >
                                            <option>선택</option>
                                        </select>
                                    </td>
                                    <td style="padding: 0.3rem; vertical-align: middle;width:2%;text-align: center;">
                                        <i class="m-r-10 mdi mdi-play" style="font-size:18px;color:darkblue"></i>
                                    </td>
                                    <td style="padding: 0.3rem;width: 20%">
                                        <select class="select2 form-control custom-select" style="height:36px;" id="teacherList_0">
                                            <option>선택</option>
                                        </select>
                                    </td>
                                    <td style="padding: 0.3rem;width:60%;text-align:right;vertical-align: middle">
                                        <label style="display: inline-block">조건 : </label>
                                        <input type="text" class="form-control" style="display: inline-block;width:60%;text-align: right" name="calculate_rate" value="100"> %
                                    </td>
                                    <td style="width:3%;vertical-align: middle">
                                        <button type="button" onclick="deleteTableRow('productTeacher')" class='btn btn-outline-danger btn-sm' style="margin-top:8%;">삭제</button>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </section>
                    <!-- //5.강사 목록 Tab -->

                    <!-- 6.선택 Tab -->
                    <h3>강의 교재선택</h3>
                    <section>
                        <div class="float-right mb-3">
                            <button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#bookModal" onclick="fn_search3('new');">추가</button>
                        </div>
                        <div id="section6">
                            <table class="table text-center table-hover" id="bookTable">
                                <thead>
                                </thead>
                                <tbody id="bookList"></tbody>
                            </table>
                        </div>
                    </section>
                    <!-- //6.선택 Tab -->
                </div>
            </div>
        </div>
    </div>
    <!-- //div.card -->
</div>
</form>
<!-- // 기본소스-->

<!-- 6.선택 강의교재  팝업창 -->
<div class="modal fade" id="bookModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document" style="max-width: 900px">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">상품선택</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close" id="lectureBookClose">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form>
                <!-- modal body -->
                <div class="modal-body">
                    <div style=" display:inline;">
                        <div style=" float: left; width: 10%">
                            <span id="l_productSearch"></span>
                        </div>
                        <div style=" float: left; width: 33%">
                            <input type="text" class="form-control" id="productSearchType">
                        </div>
                        <div style=" float: left; width: 33%">
                            <button type="button" class="btn btn-outline-info mx-auto" onclick="fn_search3('new')">검색</button>
                        </div>
                    </div>
                    <div class="table-responsive">
                        <input type="hidden" id="sPage3" >
                        <table id="zero_config" class="table table-hover text-center">
                            <thead class="thead-light">
                            <tr>
                                <th style="width:45%">상품명</th>
                                <th style="width:15%">노출</th>
                                <th style="width:15%">판매</th>
                                <th style="width:15%">무료</th>
                                <th style="width:15%"></th>
                            </tr>
                            </thead>
                            <tbody id="dataList3"></tbody>
                            <tr>
                                <td id="emptys3" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
                            </tr>
                        </table>
                        <%@ include file="/common/inc/com_pageNavi3.inc" %>
                    </div>
                </div>
                <!-- //modal body -->
            </form>
        </div>
    </div>
</div>
<!-- //선택 추가 팝업창 -->

<!-- 강의목록 추가 팝업창 -->
<div class="modal" id="sModal4" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document" style="max-width:620px;">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">강의 입력</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <!-- modal body -->
            <div class="modal-body">
                <div class="form-group row">
                    <label class="col-sm-3 text-right control-label col-form-label">강좌 CODE</label>
                    <div class="col-sm-9">
                        <span style="display: block;padding-top:5px">0</span>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-3 text-right control-label col-form-label">강의 CODE</label>
                    <div class="col-sm-9">
                        <span style="display: block;padding-top:5px">0</span>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-3 text-right control-label col-form-label">강의 이름</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-3 text-right col-sm-2 text-left control-label col-form-label">노출 여부</label>
                    <div class="col-sm-9">
                        <div style="margin-top: -23px;">
                            OFF
                            <label class="switch">
                                <input type="checkbox" />
                                <span class="slider"></span>
                            </label>
                            ON
                        </div>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-3 text-right col-sm-2 text-left control-label col-form-label">샘플 여부</label>
                    <div class="col-sm-9">
                        <div style="margin-top: -23px;">
                            OFF
                            <label class="switch">
                                <input type="checkbox" />
                                <span class="slider"></span>
                            </label>
                            ON
                        </div>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-3 text-right control-label col-form-label">동영상 저화질 경로</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group row">
                    <label  class="col-sm-3 text-right control-label col-form-label">동영상 고화지 경로</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group row">
                    <label  class="col-sm-3 text-right control-label col-form-label">모바일용 동영상 저화질 경로</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group row">
                    <label  class="col-sm-3 text-right control-label col-form-label">모바일용 동영상 고화질 경로</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-3 text-right control-label col-form-label" style="margin-bottom: 0">강의 자료</label>
                    <div class="col-sm-9">
                        <div class="custom-file">
                            <input type="file" class="custom-file-input" id="validatedCustomFile" required>
                            <label class="custom-file-label" for="validatedCustomFile">Choose file...</label>
                            <div class="invalid-feedback">Example invalid custom file feedback</div>
                        </div>
                    </div>
                </div>
                <div class="form-group row">
                    <label  class="col-sm-3 text-right control-label col-form-label">강의 시간 (분단위)</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="scode">
                    </div>
                </div>
                <div class="form-group row">
                    <label  class="col-sm-3 text-right control-label col-form-label">단원 선택</label>
                    <div class="col-sm-9">
                        <div>
                            <select class="select2 form-control custom-select" style="width:24%">
                                <option>준비중</option>
                                <option value="#">2010</option>
                                <option value="#">2011</option>
                            </select>
                            <select class="select2 form-control custom-select" style="width:24%">
                                <option>준비중</option>
                                <option value="#">2010</option>
                                <option value="#">2011</option>
                            </select>
                            <select class="select2 form-control custom-select" style="width:24%">
                                <option>준비중</option>
                                <option value="#">2010</option>
                                <option value="#">2011</option>
                            </select>
                            <select class="select2 form-control custom-select" style="width:24%">
                                <option>준비중</option>
                                <option value="#">2010</option>
                                <option value="#">2011</option>
                            </select>
                        </div>
                    </div>
                </div>
                <button type="button" class="mt-3 mb-1 btn btn-info float-right">확인</button>
            </div>
            <!-- //modal body -->
        </div>
    </div>
</div>
<!-- //강의목록 추가 팝업창 -->
<!-- 시험일정 추가 팝업창 -->
<div class="modal fade" id="sModal2" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">텍스트 입력</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <!-- modal body -->
            <div class="modal-body">
                <div class="form-group row">
                    <label class="col-sm-3 text-right control-label col-form-label">텍스트</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control">
                    </div>
                </div>
                <button type="button" class="btn btn-info float-right">확인</button>
            </div>
            <!-- //modal body -->
        </div>
    </div>
</div>
<!-- //시험일정 추가 팝업창 -->
<!-- End Container fluid  -->
    <%@include file="/common/jsp/footer.jsp" %>
    <script>
        // Basic Example with form
        var form = $("#playForm");
        form.children("div").steps({
            headerTag: "h3",
            bodyTag: "section",
            enableAllSteps: true,
            saveState : true, //현재 단계 쿠키저장
            onFinished: function(event, currentIndex) {
                playSave();
            },
            /*onFinishing: function(event, currentIndex) {
                //form.validate().settings.ignore = ":disabled";
                //return form.valid();
            },
            onFinished: function(event, currentIndex) {
                //alert("Submitted!");
            }*/
            // aria-selected:"false"
        });
        $('#indate').datepicker({
            format: "yyyy-mm-dd",
            language: "kr"
        });
        $('#sellstartdate').datepicker({
            format: "yyyy-mm-dd",
            language: "kr"
        });


    </script>
<style>

</style>
