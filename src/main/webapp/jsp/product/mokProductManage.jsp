<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/productManageService.js'></script>
<script>
    function init() {
        menuActive('menu-1', 10);
        /*카테고리*/
        getNewCategoryList("sel_category","214",'1183');
        getCategoryNoTag2('categoryTable','1183', '3');
        /*카테고리*/
        getEmphasisSelectbox("l_emphasis", "");
        getAllOptionSelectboxAddTag("sel_option","");
        //탭 메뉴 색상 변경
        $("#playForm ul").each(function(idx) {
            var ul = $(this);
            ul.find("li").addClass("done").attr("aria-selected", "false");
            ul.find("li").eq(0).removeClass("done").attr("aria-selected", "true");
        });
    }

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
                function() {return getNewCategoryList2("categoryTable","214",'1183');},
                function() {return nextIcon},
                function() {return getCategoryNoTag('categoryTable','1183', '3');},
                function() {return nextIcon},
                function() {return defaultCategorySelectbox();},
                function() {return nextIcon},
                function() {return defaultCategorySelectbox();},
                function() {return nextIcon},
                function() {return defaultCategorySelectbox();},
                function() {return "<button type=\"button\" onclick=\"deleteTableRow('categoryTable', 'delBtn');\" class=\"btn btn-outline-danger btn-sm delBtn\">삭제</button>"},
            ];
            dwr.util.addRows("categoryList", [0], cellData, {escapeHtml: false});
            //$('#categoryList tr').eq(0).attr("style", "display:none");
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
        td.find("input").eq(4).val(sum);
    }
    //카테코리 셀렉트 박스 변경 시
    function changeCategory(tableId, val, tdNum) {
        getCategoryNoTag2(val, tableId, tdNum);
    }

    //저장
    function mokProductInfoSave() {
        var data = new FormData();
       /* $.each($('#imageListFile')[0].files, function(i, file) {
            data.append('imageListFile', file);
        });

        $.each($('#imageViewFile')[0].files, function(i, file) {
            data.append('imageViewFile', file);
        });*/

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

        if(confirm("저장하시겠습니까?")) {
            productManageService.upsultGoodsInfo(obj, " ", " ", function (gKey) {

                if(gKey > 0){
                    var optionArray = new Array();
                    $('#optionTable tbody tr').each(function(index){
                        var i =0;
                        var optionName = $(this).find("td select").eq(0).val();
                        var price = $(this).find("td input").eq(0).val();
                        var sellPrice = $(this).find("td input").eq(1).val();
                        var point = $(this).find("td input").eq(2).val();
                        var extendPercent = $(this).find("td input").eq(3).val();
                        var data = {
                            priceKey:'0',
                            gKey: gKey,
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

                    var categoryArr = new Array();
                    var ctgKeys = get_array_values_by_name("input", "inputCtgKey[]");
                    if(ctgKeys.length > 0){
                        $.each(ctgKeys, function(index, key) {
                            if(key != '1183'){
                                var data = {
                                    ctgGKey:0,
                                    ctgKey:key,
                                    gKey:0,
                                    pos:0
                                };
                                categoryArr.push(data);
                            }
                        });
                    }
                }
                if(categoryArr.length > 0){
                    productManageService.upsultTGoodsPriceOption(optionArray, gKey, function () {});
                }
                productManageService.upsultTCategoryGoods(categoryArr, gKey, function () {});
            });
        }
    }

</script>
<input type="hidden" name="sPage3" id="sPage3">
<div class="page-breadcrumb">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">모의고사 상품 등록</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">상품관리</li>
                        <li class="breadcrumb-item active" aria-current="page">모의고사 상품 등록</li>
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
                        <input type="hidden" value="0" name="gKey">
                        <input type="hidden" value="0" name="cpKey">
                        <input type="hidden" value="0" name="isNodc">
                        <input type="hidden" value="" name="tags">
                        <input type="hidden" value="0" name="isQuickDelivery">
                        <input type="hidden" value="0" name="goodsId">
                        <input type="hidden" value="" name="goodsTypeName">
                        <input type="hidden" value="" name="summary">
                        <!-- 1.기본정보 Tab -->
                        <h3>기본정보</h3>
                        <section class="col-md-auto">
                            <div id="section1">
                                <div class="col-md-12">
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">상품타입</label>
                                        <span>모의고사</span>
                                        <input type="hidden" class="col-sm-6 bg-light required form-control" id="type" name='type' value="4">
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
                                        <label  class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">강조표시</label>
                                        <div class="col-sm-6 pl-0 pr-0">
                                            <span id="l_emphasis"></span>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">정산율</label>
                                        <div class="col-sm-6 pl-0 pr-0">
                                            <input type="text" class="col-sm-6 form-control" style="display: inline-block;" id="calculateRate" name="calculateRate">%
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
                                    <input type="hidden" name="gKey" value="0">
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
                                        <td style="padding: 0.3rem;text-align: center;vertical-align: middle">
                                            <input type="number" class="form-control text-right" id="extendPercent" name="extendPercent" style="display: inline-block;width:60%;text-align: right"  onchange="saleInputPrice($(this))"> %
                                        </td>
                                        <td style="padding: 0.3rem;vertical-align: middle"><!--재수강2-->
                                            <input type="number" class="form-control" id="resultPrice" name="resultPrice" readonly>
                                        </td>
                                        <td style="vertical-align: middle">
                                            <button type="button" class="btn btn-outline-danger btn-sm delBtn"  onclick="deleteTableRow('optionTable', 'delBtn');">삭제</button>
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
                                    <input type="hidden" name="gKey" value="0">
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
                                        <td><!--옵션명selbox-->
                                            <select class='form-control'  id='sel_category' disabled>
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
                                            <button type="button" onclick="deleteTableRow('categoryTable', 'delBtn')" class='btn btn-outline-danger btn-sm delBtn'>삭제</button>
                                        </td>
                                    </tr>

                                    </tbody>
                                </table>
                            </div>
                        </section>
                        <!-- //3.카테고리 목록 Tab -->
                    </div>
                </div>
            </div>
        </div>
        <!-- //div.card -->
    </div>
</form>
<!-- // 기본소스-->
<!-- 과년도 도서 팝업창-->
<div class="modal fade" id="bookModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document" style="max-width: 900px">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">상품선택</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
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
            mokProductInfoSave();
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
    $('#cpdate').datepicker({
        format: "yyyy-mm-dd",
        language: "kr"
    });
</script>

<%@include file="/common/jsp/footer.jsp" %>
