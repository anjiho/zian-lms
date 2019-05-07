<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/productManageService.js'></script>
<script>
    function init() {
        menuActive('menu-1', 6);
        getCategoryList("sel_category","214");
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
        $('textarea[name=description]').summernote({ //기본정보-에디터
            height: 250,
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
            if ($("#teacherTable > tbody > tr").length == 1) {
                $('#teacherTable > tbody:first > tr:first').attr("style", "display:none");
            } else {
                $('#teacherTable > tbody:last > tr:last').remove();
            }
        }  else if(tableId == 'productBook'){
            $('#bookTable > tbody:last > tr:last').remove();
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
        td.find("span").html(sum);
        //innerHTML(calcPrice, sum);
    }
    //카테코리 셀렉트 박스 변경 시
    function changeCategory(tableId, val, tdNum) {
        if(tdNum == '5') return false;
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

    //과년도 도서 추가
    function fn_search3(val) {
        var paging = new Paging();
        var sPage = $("#sPage3").val();
        var searchType = getSelectboxValue("searchType");
        var searchText = getInputTextValue("productSearchType");

        if(val == "new") {
            sPage = "1";
        }

        dwr.util.removeAllRows("dataList3");
        gfn_emptyView3("H", "");//페이징 예외사항처리
        productManageService.getProductListCount(searchType, searchText, 'BOOK', function(cnt) {
            paging.count3(sPage, cnt, '10', '10', comment.blank_list);
            var listNum = ((cnt-1)+1)-((sPage-1)*10); //리스트 넘버링
            productManageService.getProductList(sPage, '10',searchType, searchText, 'BOOK', function (selList) {
                if (selList.length > 0) {
                    for (var i = 0; i < selList.length; i++) {
                        var cmpList = selList[i];
                        var isShow = "";
                        var isSell = "";
                        var isFree = "";
                        if(cmpList.isShow == '1') isShow = '<i class="mdi mdi-check" style="color:green;"></i>';
                        else isShow = '<i class="mdi mdi-close" style="color: red"></i>';
                        if(cmpList.isSell == '1') isSell = '<i class="mdi mdi-check" style="color:green;"></i>';
                        else isSell = '<i class="mdi mdi-close" style="color: red"></i>';
                        if(cmpList.isFree == '1') isFree = '<i class="mdi mdi-check" style="color:green;"></i>';
                        else isFree = '<i class="mdi mdi-close" style="color: red"></i>';

                        var bookSelBtn = '<input type="button" id="addBookBtn" onclick="sendChildValue_2($(this))" value="선택" class="btn btn-outline-info mx-auto"/>';
                        if (cmpList != undefined) {
                            var cellData = [
                                function(data) {return '<input name="bookKey[]" value=' + "'" + cmpList.GKey + "'" + '>';},
                                function(data) {return cmpList.goodsName;},
                                function(data) {return isShow;},
                                function(data) {return isSell;},
                                function(data) {return isFree;},
                                function(data) {return bookSelBtn;}
                            ];
                            dwr.util.addRows("dataList3", [0], cellData, {escapeHtml: false});
                            $('#dataList3 tr').each(function(){
                                var tr = $(this);
                                tr.children().eq(0).attr("style", "display:none");
                            });
                        }
                    }
                }else{
                    gfn_emptyView3("V", comment.blank_list2);
                }
            });
        });
    }

    //과년도 도서 전달값
    function sendChildValue_2(val) {
        var checkBtn = val;

        var tr = checkBtn.parent().parent();
        var td = tr.children();

        var gKey = td.find("input").val();
        var goodsName = td.eq(1).text();

        var resKeys = get_array_values_by_name("input", "res_key[]");
        if ($.inArray(gKey, resKeys) != '-1') {
            alert("이미 선택된 과목입니다.");
            return;
        }
        $("#goodName").html(goodsName);
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
        var basicObj = getJsonObjectFromDiv("section1");
        if(basicObj.isShow == 'on')  obj.isShow = '1';//노출 checkbox
        else basicObj.isShow = '0';
        if(basicObj.isSell == 'on')  obj.isSell = '1';//판매
        else basicObj.isSell = '0';
        if(basicObj.isFree == 'on')  obj.isFree = '1';//무료
        else basicObj.isFree = '0';
        if(basicObj.isFreebieDeliveryFree == 'on')  basicObj.isFreebieDeliveryFree = '1';//사은품배송비무료
        else basicObj.isFreebieDeliveryFree = '0';
        /*  //기본정보 obj */

        /*  2.옵션 obj */
        var optionArray = new Array();
        $('#optionTable tbody tr').each(function(index){
            var i = 0;
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
            optionArray.push(data);
        });

        /* 2. 카테고리 저장 */
        var categoryArr = new Array();
        $('#categoryTable tbody tr').each(function(index){
            var ctgKey = $(this).find("td select").eq(4).val();
            var data = {
                ctgGKey:0,
                ctgKey:ctgKey,
                gKey:0,
                pos:0
            };
            categoryArr.push(data);
        });


        data.append("videoInfo", JSON.stringify(basicObj));
        data.append("videoOptionInfo",JSON.stringify(optionArray));
        data.append("videoCategoryInfo",JSON.stringify(categoryArr));

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

                    }
                }
            });
        }
    }
    
    function imageSave() {
        //previewFileUpload
        var data = new FormData();
        $.each($('#PreviewFile')[0].files, function(i, file) {
            data.append('PreviewFile', file);
            if(confirm("이미지를 저장 하시겠습니까?")) {
                $.ajax({
                    url: "/file/previewFileUpload",
                    method: "post",
                    dataType: "JSON",
                    data: data,
                    cache: false,
                    processData: false,
                    contentType: false,
                    success: function (data) {
                        if(data.result){
                           $(".custom-file-control3").html('');
                        }
                    }
                });
            }
        });
    }
</script>
<input type="hidden" name="sPage3" id="sPage3">
<div class="page-breadcrumb">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">도서 정보등록</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">상품관리</li>
                        <li class="breadcrumb-item active" aria-current="page">도서 등록</li>
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
                                <input type="hidden" value="" name="goodsId">
                                <input type="hidden" value="" name="goodsTypeName">
                                <input type="hidden" value="" name="summary">
                                <div class="col-md-12">
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">상품타입</label>
                                        <span>도서</span>
                                        <input type="hidden" class="col-sm-6 bg-light required form-control" id="type" name='type' value="1">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">이름</label>
                                        <input type="text" class="col-sm-6 form-control" style="display: inline-block;" id="name" name="name">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">등록일</label>
                                        <div class="col-sm-6 input-group pl-0 pr-0" id="dateRangePicker">
                                            <input type="text" class="form-control mydatepicker" placeholder="yyyy-mm-dd" name="indate" id="indate">
                                            <div class="input-group-append">
                                                <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label"  style="margin-bottom: 0">판매시작일</label>
                                        <div class="col-sm-6 input-group pl-0 pr-0">
                                            <input type="text" class="form-control mydatepicker" placeholder="mm/dd/yyyy" name="sellstartdate" id="sellstartdate">
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
                                                <input type="file" class="custom-file-input addFile" id="imageViewFile" name="imageViewFile" required>
                                                <span class="custom-file-control1 custom-file-label"></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label  class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">강조표시</label>
                                        <div class="col-sm-6 pl-0 pr-0">
                                            <span id="l_emphasis"></span>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">정산율</label>
                                        <div class="col-sm-6 pl-0 pr-0">
                                        <input type="text" class="col-sm-6 form-control" style="display: inline-block;" id="" name="">%
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
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">황금날개배송</label>
                                        <div class="col-sm-10">
                                            <div style="margin-top: -23px;" class="col-sm-5">
                                                OFF
                                                <label class="switch">
                                                    <input type="checkbox" style="display:none;" id="" name="">
                                                    <span class="slider"></span>
                                                </label>
                                                ON
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-form-label">간략설명(리스트)</label>
                                        <div>
                                            <textarea value="" id="description" name="description"></textarea>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                    <label class="control-label col-form-label">상세설명</label>
                                    <div>
                                        <textarea value="" id="description1" name="description"></textarea>
                                    </div>
                                </div>
                                <div class="form-group">
                                <label class="control-label col-form-label">목차</label>
                                <div>
                                    <textarea value="" id="description2" name="description"></textarea>
                                </div>
                            </div>
                                </div>
                            </div>
                        </section>
                        <!-- // 1.기본정보 Tab -->
                        <!-- 2.옵션 Tab -->
                        <h3>옵션</h3>
                        <section>
                            <div class="float-right mb-3">
                                <button type="button" class="btn btn-info btn-sm" onclick="addProductOptionInfo();">추가</button>
                            </div>
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
                                        <th scope="col" style="text-align:center;width:5%"></th>
                                    </tr>
                                    </thead>
                                    <tbody id="optionList">
                                    <tr>
                                        <td style="padding: 0.3rem;vertical-align: middle">
                                            <select class="select2 form-control custom-select" style="height:36px;" id="sel_option" name='selOption[]'>
                                                <option>기본옵션</option>
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
                                        <td style="padding:0.3rem;vertical-align:middle;width:20%">
                                            <input type="text" class="form-control text-right" name="expendPercent[]"  onkeypress='saleInputPrice($(this));' style="width:93%;display:inline-block;">
                                            <!--<span style="display: inline-block;">%</span>-->
                                        </td>
                                        <td style="padding: 0.3rem;vertical-align: middle;width:15%">
                                            <span id="sum_0"></span>
                                        </td>
                                        <td style="vertical-align: middle">
                                            <button type="button" class="btn btn-outline-danger btn-sm"  onclick="deleteTableRow('productOption');">삭제</button>
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

                        <!-- 도서정보 -->
                        <h3>도서정보</h3>
                        <section class="col-md-auto">
                            <div id="section4">
                                <div class="col-md-12">
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">도서코드</label>
                                        <span>0</span>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">판매상태</label>
                                        <select class="col-sm-3 select2 form-control custom-select" id="" name=''>
                                            <option>선택</option>
                                            <option>예약</option>
                                            <option>판매중</option>
                                            <option>품절</option>
                                            <option>절판</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">급수</label>
                                        <span id="l_classGroup"></span>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">과목</label>
                                        <span id="l_subjectGroup"></span>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">저자</label>
                                        <input type="text" class="col-sm-3 form-control" style="display: inline-block;" name="" id="">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">최신발행일</label>
                                        <div class="col-sm-3 input-group pl-0 pr-0">
                                            <input type="text" class="form-control mydatepicker" placeholder="yyyy-mm-dd" name="" id="">
                                            <div class="input-group-append">
                                                <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">ISBN</label>
                                        <input type="text" class="col-sm-3 form-control" style="display: inline-block;" name="" id="">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">페이지 수</label>
                                        <input type="text" class="col-sm-3 form-control" style="display: inline-block;" name="" id="">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">출판사</label>
                                        <button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#bookModal" onclick="fn_search3('new');">출판사 추가</button>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">배송비 무료</label>
                                        <div class="col-sm-10">
                                            <div style="margin-top: -23px;" class="col-sm-5">
                                                OFF
                                                <label class="switch">
                                                    <input type="checkbox" style="display:none;" id="" name="">
                                                    <span class="slider"></span>
                                                </label>
                                                ON
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">세트상품</label>
                                        <div class="col-sm-10">
                                            <div style="margin-top: -23px;" class="col-sm-5">
                                                OFF
                                                <label class="switch">
                                                    <input type="checkbox" style="display:none;" id="" name="">
                                                    <span class="slider"></span>
                                                </label>
                                                ON
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">과년도 도서</label>
                                        <div class="col-sm-7 pl-0 pr-0">
                                        <span id="goodName" class="pr-2"></span>
                                        <button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#bookModal" onclick="fn_search3('new');">과년도 도서 추가</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>
                        <!-- // 1.기본정보 Tab -->
                        <!-- 도서정보 -->

                        <!-- 6.강의 교재선택 Tab -->
                        <h3>미리보기이미지</h3>
                        <section>
                            <div class="float-right mb-3">
                                <button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#sModal">추가</button>
                            </div>
                            <div id="section6">
                                <table class="table text-center table-hover" id="bookTable">
                                    <thead>
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

<!--미리보기 이미지 팝업창-->
<div class="modal fade" id="sModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <input type="hidden" id="key" value="modify">
            <input type="hidden" id="searchKeywordKey" value="">
            <div class="modal-header">
                <h5 class="modal-title">리소스 수정</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <!-- modal body -->
            <div class="modal-body">
                <div class="form-group row">
                    <label class="col-sm-3 text-right control-label col-form-label">이미지</label>
                    <div class="col-sm-9">
                        <div class="custom-file">
                            <input type="file" class="custom-file-input PreviewFile" id="PreviewFile" name="PreviewFile" required>
                            <span class="custom-file-control3 custom-file-label"></span>
                        </div>
                    </div>
                </div>
                <button type="button" class="btn btn-info float-right" onclick="imageSave();">저장</button>
            </div>
            <!-- //modal body -->
        </div>
    </div>
</div>

<!-- 과년도 도서 팝업창-->

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
        // onContentLoaded: function (event, currentIndex) {
        //
        // }
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

    //파일 선택시 파일명 보이게 하기
    $(document).on('change', '.custom-file-input', function() {
        $(this).parent().find('.custom-file-control').html($(this).val().replace(/C:\\fakepath\\/i, ''));
    });
    $(document).on('change', '.addFile', function() {
        $(this).parent().find('.custom-file-control1').html($(this).val().replace(/C:\\fakepath\\/i, ''));
    });
    $(document).on('change', '.PreviewFile', function() {
        $(this).parent().find('.custom-file-control3').html($(this).val().replace(/C:\\fakepath\\/i, ''));
    });

</script>

<%@include file="/common/jsp/footer.jsp" %>
