<%@ page import="com.zianedu.lms.utils.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/productManageService.js'></script>
<!-- 강의교재 메뉴 팝업 관련 스크립트 include -->
<script src="common/js/bookGiftListPopup.js"></script>
<script>
    function init() {
        menuActive('menu-1', 4);
        getOptionSelectboxAddTag("", "sel_option");//옵션명 셀렉트박스
        /*카테고리*/
        getNewCategoryList2("categoryTable","214",'1183');
        getCategoryNoTag2('categoryTable','1183', '3');
        /*//카테고리*/
        getNewSelectboxListForCtgKey("l_classGroup", "4309", "");
        getNewSelectboxListForCtgKey2("l_subjectGroup", "70", "");
        getNewSelectboxListForCtgKey3("l_stepGroup", "202", "");
        getLectureStatusSelectbox("status", "");//강좌정보- 진행상태
        getLectureCountSelectbox("limitCount", "");//강좌정보 강좌수
        getClassRegistraionDaySelectbox("limitDay", "");//수강일수
        getLectureCountSelectbox("lecTime", "");//강좌시간
        getExamPrepareSelectbox("examYear", "");//시험대비년도 셀렉트박스
        getSelectboxListForCtgKeyNoTag2('teacherTable', '70', 0);
        selectTeacherSelectboxNoTag2('teacherTable', 1);
        getProductSearchTypeSelectbox("l_productSearch");
        getEmphasisSelectbox("l_emphasis", "");
    }
    $( document ).ready(function() {
        $('#description').summernote({ //기본정보-에디터
            height: 300,
            minHeight: null,
            maxHeight: null,
            focus: false,
            lang: 'ko-KR',
            placeholder: '내용을 적어주세요.'
            ,hint: {
                match: /:([\-+\w]+)$/,
                search: function (keyword, callback) {
                    callback($.grep(emojis, function (item) {
                        return item.indexOf(keyword) === 0;
                    }));
                },
                template: function (item) {
                    var content = emojiUrls[item];
                    return '<img src="' + content + '" width="20" /> :' + item + ':';
                },
                content: function (item) {
                    var url = emojiUrls[item];
                    if (url) {
                        return $('<img />').attr('src', url).css('width', 20)[0];
                    }
                    return '';
                }
            },
            popover: {
                image: [],
                link: [],
                air: []
            }
        });

        //탭 메뉴 색상 변경
        $("#playForm ul").each(function(idx) {
            var ul = $(this);
            ul.find("li").addClass("done").attr("aria-selected", "false");
            ul.find("li").eq(0).removeClass("done").attr("aria-selected", "true");
        });

        //모달 초기화
        $('.bookModal').on('hidden.bs.modal', function (e) {
            $('form').each(function(){
                this.reset();
            });
        });
    });

    //옵션 추가 버튼
    function addProductOptionInfo() {
        var fistTrStyle = $("#optionList tr").eq(0).attr("style");

        if (fistTrStyle == "display:none") {
            $('#optionList tr').eq(0).removeAttr("style", null);
        } else {
            var $tableBody = $("#optionTable").find("tbody"),
                $trLast = $tableBody.find("tr:last"),
                $trNew = $trLast.clone();
            $trLast.after($trNew);

            $trNew.find("td select").val('');
            $trNew.find("td input").eq(0).val('');
            $trNew.find("td input").eq(1).val('');
            $trNew.find("td input").eq(2).val('');
            $trNew.find("td input").eq(3).val('');
            $trNew.find("td span").html('');
            $trNew.find("td button").attr('disabled', false);
            $trNew.find("td").eq(7).attr('style', "display:''");
        }
    }

    //카테고리 추가 버튼
    function addCategoryInfo() {
        /* 카테고리 추가시 예외처리 */
        /*for(var i=0; i < $("#categoryList").find("tr").length; i++){
            var cateName1 =  $("#categoryList").find("tr").eq(i).find("td select").eq(1).val();
            if(cateName1 == "" || cateName1 == undefined){
                alert("카테고리 선택후 추가해 주세요.");
                $("#categoryList").find("tr").eq(i).find("td select").eq(1).focus();
                return false;
            }
        }*/
        var ctgKeys = get_array_values_by_name("input", "inputCtgKey[]");
        var nextIcon = "<i class=\"m-r-10 mdi mdi-play\" style=\"font-size:18px;color:darkblue\"></i>";

        if (ctgKeys.length > 0) {
            for(var i=0; i < $("#categoryList").find("tr").length; i++) {
                var cateName1 = $("#categoryList").find("tr").eq(i).find("td select").eq(1).val();
                if (cateName1 == "" || cateName1 == undefined) {
                    alert("카테고리 선택후 추가해 주세요.");
                    $("#categoryList").find("tr").eq(i).find("td select").eq(1).focus();
                    return false;
                }
            }
            var $tableBody = $("#categoryTable").find("tbody"),
                $trLast = $tableBody.find("tr:last"),
                $trNew = $trLast.clone();
            $trLast.after($trNew);

            getCategoryNoTag2('categoryTable','1183', '3');
        } else { //카테고리 없을 경우
            var cellData = [
                function() {return "<input type='hidden' name='inputCtgKey[]' value=''>";},
                function() {return  getNewCategoryList2("categoryTable","214",'1183');},
                function() {return nextIcon},
                function() {return getCategoryNoTag('categoryTable','1183', '3');},
                function() {return nextIcon},
                function() {return defaultCategorySelectbox();},
                function() {return nextIcon},
                function() {return defaultCategorySelectbox();},
                function() {return nextIcon},
                function() {return defaultCategorySelectbox();},
                function() {return "<button type=\"button\" onclick=\"deleteTableRow('categoryTable', 'delBtn');\" class=\"btn btn-outline-danger btn-sm delBtn\" style=\"margin-top:8%;\" >삭제</button>"},
            ];
            dwr.util.addRows("categoryList", [0], cellData, {escapeHtml: false});
            //$('#categoryList tr').eq(0).attr("style", "display:none");
        }


    }

    //강사 추가 버튼
    function addTeacherInfo() {
        var fistTrStyle = $("#teacherList tr").eq(0).attr("style");

        if (fistTrStyle == "display:none") {
            $('#teacherList tr').eq(0).removeAttr("style", null);
        } else {
            var $tableBody = $("#teacherTable").find("tbody"),
                $trLast = $tableBody.find("tr:last"),
                $trNew = $trLast.clone();
            $trLast.after($trNew);

            $trNew.find("td input").eq(0).val("100");
            //$trNew.find("td input").eq(1).val("");
            //$trNew.find("td input").eq(2).val("");

            getSelectboxListForCtgKeyNoTag2('teacherTable', '70', 0);
            selectTeacherSelectboxNoTag2('teacherTable', 1);
        }
    }

    //옵션 - 할인률 계산
    function saleInputPrice(val) {
        var checkBtn = val;
        var tr = checkBtn.parent().parent();
        var td = tr.children();

        var sellPrice = td.find("input").eq(1).val();
        var extendPercent = td.find("input").eq(3).val();

        var sum = Math.round(sellPrice -((sellPrice * extendPercent) / 100));
        //td.find("span").html(sum);
        $("#sum_0").val(sum);
        //innerHTML(calcPrice, sum);
    }
    //카테코리 셀렉트 박스 변경 시
    function changeCategory(tableId, val, tdNum) {
        //if(tdNum == '5') return false;
        getCategoryNoTag2(val, tableId, tdNum);
    }

    //강사목록 새로 등록하는 값 주입하기(강사키)
    function injectSubjectKey(val) {
        $("#teacherTable").find("tbody").find("tr:last").find("td input").eq(1).val(val);
    }

    //강사목록 새로 등록하는 값 주입하기(과목키)
    function injectTeacherKey(val) {
        $("#teacherTable").find("tbody").find("tr:last").find("td input").eq(0).val(val);
    }

    function academyLectureSave() {
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
            var price = uncomma($(this).find("td input").eq(0).val());
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

        /* 3. 카테고리 저장 */
        var categoryArr = new Array();
        var ctgKeys = get_array_values_by_name("input", "inputCtgKey[]");
        if(ctgKeys.length > 0){
            $.each(ctgKeys, function(index, key) {
                if(key != '1183') {
                    var data = {
                        ctgGKey: 0,
                        ctgKey: key,
                        gKey: 0,
                        pos: 0
                    };
                    categoryArr.push(data);
                }
            });
        }

        /* 2. 강좌정보 저장 */
        var lectureObj = getJsonObjectFromDiv("section4");


        /* 강사목록 */
        var array2 = new Array();
        $('#teacherTable tbody tr').each(function(index){
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

        if($("#price_0").val() == ""){alert("옵션정보를 입력해 주세요."); return false;}
        else if(lectureObj.classGroupCtgKey == ""){alert("강좌정보 (급수)를 선택해 주세요."); return  false;}
        else if(lectureObj.examYear == ""){alert("강좌정보 (시험대비년도)를 선택해 주세요."); return  false;}
        else if(lectureObj.multiple == ""){alert("강좌정보 (배수)를 선택해 주세요."); return  false;}
        else if(lectureObj.status == ""){alert("강좌정보 (진행상태)를 선택해 주세요."); return  false;}
        else if(lectureObj.subjectCtgKey == ""){alert("강좌정보 (과목)을 선택해 주세요."); return  false;}
        else if(lectureObj.stepCtgKey == ""){alert("강좌정보 (유형)를 선택해 주세요."); return  false;}
        else if(lectureObj.limitCount == ""){alert("강좌정보 (강좌수)를 선택해 주세요."); return  false;}
        else if(lectureObj.lecTime == ""){alert("강좌정보 (수강시간)를 선택해 주세요."); return  false;}
        else {(confirm("저장하시겠습니까?"))
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
                        alert("저장되었습니다.");
                        goPage('productManage', 'academyLectureList');
                    }
                }
            });
        }
    }
</script>
<input type="hidden" name="sPage3" id="sPage3">
<div class="page-breadcrumb">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">학원강의 등록</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">상품관리</li>
                        <li class="breadcrumb-item active" aria-current="page">학원강의 등록</li>
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
                                        <span>학원강의</span>
                                        <input type="hidden" class="col-sm-6 bg-light required form-control" id="type" name='type' value="2">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">이름</label>
                                        <input type="text" class="col-sm-5 form-control" style="display: inline-block;" id="name" name="name">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">등록일</label>
                                        <div class="col-sm-5 input-group pl-0 pr-0" id="dateRangePicker">
                                            <input type="text" class="form-control mydatepicker" placeholder="yyyy-mm-dd" name="indate" id="indate">
                                            <div class="input-group-append">
                                                <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label"  style="margin-bottom: 0">판매시작일</label>
                                        <div class="col-sm-5 input-group pl-0 pr-0">
                                            <input type="text" class="form-control mydatepicker" placeholder="yyyy-mm-dd" name="sellstartdate" id="sellstartdate">
                                            <div class="input-group-append">
                                                <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row mt-4">
                                        <label class="col-sm-2 text-left control-label col-form-label"  style="margin-bottom: 0">노출</label>
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
                                        <label class="col-sm-2 text-left control-label col-form-label" style="margin-bottom: 0">판매</label>
                                        <div class="col-sm-10">
                                            <div style="margin-top: -23px;">
                                                OFF
                                                <label class="switch">
                                                    <input type="checkbox" id="isSell" name="isSell" style="display:none;">
                                                    <span class="slider"></span>
                                                </label>
                                                ON
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 text-left control-label col-form-label" style="margin-bottom: 0">무료</label>
                                        <div class="col-sm-10">
                                            <div style="margin-top: -23px;">
                                                OFF
                                                <label class="switch">
                                                    <input type="checkbox" id="isFree" name="isFree" style="display:none;">
                                                    <span class="slider"></span>
                                                </label>
                                                ON
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">리스트이미지</label>
                                        <div class="col-sm-5 pl-0 pr-0">
                                            <div class="custom-file">
                                                <input type="file" class="custom-file-input" id="imageListFile"  name="imageListFile" required>
                                                <span class="custom-file-control custom-file-label"></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">상세이미지</label>
                                        <div class="col-sm-5 pl-0 pr-0">
                                            <div class="custom-file">
                                                <input type="file" class="custom-file-input addFile" id="imageViewFile" name="imageViewFile" required>
                                                <span class="custom-file-control1 custom-file-label"></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label  class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">강조표시</label>
                                        <div class="col-sm-7 pl-0 pr-0">
                                            <span id="l_emphasis"></span>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">사은품 배송비 무료</label>
                                        <div class="col-sm-10">
                                            <div style="margin-top: -23px;" class="col-sm-5">
                                                OFF
                                                <label class="switch">
                                                    <input type="checkbox" style="display:none;" id="isFreebieDeliveryFree" name="isFreebieDeliveryFree">
                                                    <span class="slider"></span>
                                                </label>
                                                ON
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">정산률</label>
                                        <input type="text" class="col-sm-2 form-control" id="calculateRate" name="calculateRate">
                                        <span style="margin-top: 6px;">%</span>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-form-label">상세설명</label>
                                        <div>
                                            <textarea value="" id="description" name="description"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>
                        <!-- // 1.기본정보 Tab -->
                        <!-- 2.옵션 Tab -->
                        <h3>옵션</h3>
                        <section>
                            <!--<div class="float-right mb-3">
                                <button type="button" class="btn btn-info btn-sm" onclick="addProductOptionInfo();">추가</button>
                            </div>-->
                            <div id="section2">
                                <table class="table" id="optionTable">
                                    <input type="hidden" value="0" name="goodsTypeName">
                                    <thead>
                                    <tr style="border-top:0">
                                        <th scope="col" style="text-align:center;width:21%">옵션명</th>
                                        <th scope="col" style="text-align:center;width:13%">원가</th>
                                        <th scope="col" style="text-align:center;width:13%">판매가</th>
                                        <th scope="col" style="text-align:center;widht:13%">포인트</th>
                                        <th scope="col" colspan="2" style="text-align:center;width:35%">재수강</th>
                                    </tr>
                                    </thead>
                                    <tbody id="optionList">
                                        <tr>
                                            <td style="padding: 0.3rem;vertical-align: middle">
                                                <select class="select2 form-control custom-select" style="height:36px;" id="sel_option" name='selOption[]'>
                                                    <option>선택</option>
                                                </select>
                                            </td>
                                            <td style="padding: 0.3rem;vertical-align: middle">
                                                <input type="text" class="form-control" name="price[]" id='price_0'>
                                            </td>
                                            <td style="padding: 0.3rem;vertical-align: middle">
                                                <input type="text" class="form-control" name="sellPrice[]" id='sellPrice_0'>
                                            </td>
                                            <td style="padding: 0.3rem;vertical-align: middle">
                                                <input type="text" class="form-control" name="point[]" id='point_0'>
                                            </td>
                                            <!--<td style="padding:0.3rem;vertical-align:middle;width:20%">
                                                <input type="text" class="form-control text-right" name="expendPercent[]"  onkeypress='saleInputPrice($(this));' style="width:93%;display:inline-block;">
                                            </td>-->
                                            <td style="padding: 0.3rem;text-align: center;vertical-align: middle">
                                                <input type="text" class="form-control text-right" style="display: inline-block;width:60%;text-align: right" name="expendPercent[]"  onkeypress='saleInputPrice($(this));' > %
                                            </td>
                                            <td style="padding: 0.3rem;vertical-align: middle;width:15%">
                                                <input type="number" class="form-control" id="sum_0" readonly>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
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
                                        <td style="display: none">
                                            <input type='hidden' name='inputCtgKey[]' value=''>
                                        </td>
                                        <td>
                                            <select class='form-control'  id='sel_category'  name="sel_category" disabled>
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
                                            <button type="button" onclick="deleteTableRow('categoryTable', 'delBtn')" class='btn btn-outline-danger btn-sm delBtn' style="margin-top:1%;">삭제</button>
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
                                    <select  class="col-sm-3 select2 form-control custom-select"  id="limitCount" name="limitCount">
                                        <option value="">선택</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">수강일수</label>
                                    <select class="col-sm-3 select2 form-control custom-select"  id="limitDay" name="limitDay">
                                        <option value="">선택</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">강좌시간</label>
                                    <select class="col-sm-3 select2 form-control custom-select"  id="lecTime" name="lecTime">
                                        <option value="">선택</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">배수</label>
                                    <input type="text" class="col-sm-3 form-control" style="display: inline-block;" name="multiple" id="multiple"><span style="font-size:11px;vertical-align:middle;color:#999;font-weight:500;margin-left:10px">*배수가 0이면 무제한</span>
                                </div>
                                <div class="form-group">
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">시험대비년도</label>
                                    <select class="col-sm-3 select2 form-control custom-select" id="examYear" name="examYear">
                                        <option value="">선택</option>
                                    </select>
                                </div>
                            </div>
                        </section>
                        <!-- //4.강좌 정보 Tab -->

                        <!-- 5.강사 목록 Tab -->
                        <h3>강사목록</h3>
                        <section>
                            <span></span>
                            <div class="float-right mb-3">
                                <button type="button" class="btn btn-info btn-sm" onclick="addTeacherInfo();">추가</button>
                            </div>
                            <div id="section5">
                                <table class="table"id="teacherTable">
                                    <input type="hidden" id="gTeacherKey_0" >
                                    <input type="hidden" id="subjectHidden_0" >
                                    <input type="hidden" id="teacherHidden_0" >
                                    <input type="hidden" name="gKey" value="0">
                                    <colgroup>
                                        <col width="30%" />
                                        <col width="10%" />
                                        <col width="60%" />
                                    </colgroup>
                                    <thead>
                                    <tr style="">
                                        <th>과목</th>
                                        <th>선생님명</th>
                                        <th style="padding-left: 9%;">정산률(%)</th>
                                        <th></th>
                                    </tr>
                                    </thead>
                                    <tbody id="teacherList">
                                    <tr>
                                        <td style="padding: 0.3rem;text-align: center;width: 20%;vertical-align: middle">
                                            <select class="select2 form-control custom-select" style="height:36px;" name="teacherKeys[]"></select>
                                        </td>
                                        <td style="padding: 0.3rem;text-align: center;width: 20%;vertical-align: middle">
                                            <select class="select2 form-control custom-select" style="height:36px;" name="subjectKeys[]"></select>
                                        </td>
                                        <td style="padding: 0.3rem;text-align: center;vertical-align: middle">
                                            <input type="text" class="form-control text-right" style="display: inline-block;width:60%;text-align: right" name='calcRate[]' value="100"> %
                                        </td>
                                        <td style="padding: 0.3rem;width: 20%">
                                            <button type="button" onclick="deleteTableRow('teacherTable', 'delBtn')" class='btn btn-outline-danger btn-sm delBtn' style="margin-top:8%;">삭제</button>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </section>
                        <!-- //5.강사 목록 Tab -->

                        <!-- 6.강의 교재선택 Tab -->
                        <h3>강의 교재선택</h3>
                        <section>
                            <div class="float-right mb-3">
                                <button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#bookModal" onclick="fn_search3('new');">교재 추가</button>
                            </div>
                            <div id="section6">
                                <table class="table table-hover" id="bookTable">
                                    <thead>
                                    <tr>
                                        <th scope="col" colspan="5" style="text-align:center;width:30%">강의교재목록</th>
                                    </tr>
                                    </thead>
                                    <tbody id="bookList"></tbody>
                                </table>
                            </div>
                        </section>
                        <!-- //6.강의 교재선택 Tab -->
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
                <h5 class="modal-title">강의교재 선택</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close" id="lectureBookClose">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form>
                <!-- modal body -->
                <div class="modal-body">
                    <div style="margin-bottom: 45px;">
                        <div style=" float: left;">
                            <span id="l_productSearch"></span>
                        </div>
                        <div style=" float: left; width: 33%; margin-left: 5px">
                            <input type="text" class="form-control" id="productSearchType" onkeypress="if(event.keyCode==13) {fn_search3('new'); return false;}">
                        </div>
                        <div style=" float: left; width: 33%; margin-left: 5px;">
                            <button type="button" class="btn btn-outline-info mx-auto" onclick="fn_search3('new')">검색</button>
                        </div>
                    </div>
                    <div class="table-responsive  scrollable" style="height:800px;">
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

<!-- 강의목록 강의입력 추가 팝업창 -->
<div class="modal fade" id="lectureListPopup" tabindex="-1" role="dialog" aria-hidden="true">
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
                <input type="hidden" id="curri_lecKey">
                <input type="hidden" id="curriKey">
                <div class="form-group row">
                    <label class="col-sm-3 text-right control-label col-form-label">강의 이름</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="lectureName">
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-3 text-right col-sm-2 text-left control-label col-form-label">노출 여부</label>
                    <div class="col-sm-9">
                        <div style="margin-top: -23px;">
                            OFF
                            <label class="switch">
                                <input type="checkbox" id="lectureIsShow" name="lectureIsShow"/>
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
                                <input type="checkbox" id="isSample" name="isSample"/>
                                <span class="slider"></span>
                            </label>
                            ON
                        </div>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-3 text-right control-label col-form-label">동영상 저화질 경로</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="vodFileLow">
                    </div>
                </div>
                <div class="form-group row">
                    <label  class="col-sm-3 text-right control-label col-form-label">동영상 고화지 경로</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="vodFileHigh">
                    </div>
                </div>
                <div class="form-group row">
                    <label  class="col-sm-3 text-right control-label col-form-label">모바일용 동영상 저화질 경로</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="vodFileMobileLow">
                    </div>
                </div>
                <div class="form-group row">
                    <label  class="col-sm-3 text-right control-label col-form-label">모바일용 동영상 고화질 경로</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="vodFileMobileHigh">
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-3 text-right control-label col-form-label" style="margin-bottom: 0">강의 자료</label>
                    <div class="col-sm-9">
                        <div class="custom-file">
                            <input type="file" class="custom-file-input dataAddFile" id="dataFile" name="dataFile" required>
                            <span class="custom-file-control2 custom-file-label"></span>
                        </div>
                    </div>
                </div>
                <div class="form-group row">
                    <label  class="col-sm-3 text-right control-label col-form-label">강의 시간 (분단위)</label>
                    <div class="col-sm-9">
                        <input type="number" class="form-control" id="vodTime" name="vodTime">
                    </div>
                </div>
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
        startIndex : 0,
        saveState : true, //현재 단계 쿠키저장
        enablePagination : true,
        onFinished: function(event, currentIndex) {
            academyLectureSave();
        },
    });

    $('#indate').datepicker({
        format: "yyyy-mm-dd",
        language: "kr"
    });
    $('#sellstartdate').datepicker({
        format: "yyyy-mm-dd",
        language: "kr"
    });

    //파일 선택시 파일명 보이게 하기
    $(document).on('change', '.custom-file-input', function() {
        $(this).parent().find('.custom-file-control').html($(this).val().replace(/C:\\fakepath\\/i, ''));
    });
    $(document).on('change', '.dataAddFile', function() {
        $(this).parent().find('.custom-file-control2').html($(this).val().replace(/C:\\fakepath\\/i, ''));
    });

    $(document).on('change', '.addFile', function() {
        $(this).parent().find('.custom-file-control1').html($(this).val().replace(/C:\\fakepath\\/i, ''));
    });

</script>
<script src='https://code.jquery.com/ui/1.11.4/jquery-ui.min.js'></script>
