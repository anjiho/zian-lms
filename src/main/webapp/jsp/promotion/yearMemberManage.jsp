<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/promotionManageService.js'></script>
<script type='text/javascript' src='/dwr/interface/productManageService.js'></script>
<script>
    function init() {
        menuActive('menu-2', 6);
        getNewSelectboxListForCtgKey("l_classGroup", "4309", "");
        getExamPrepareSelectbox("examYear", "");//시험대비년도 셀렉트박스
        getProductSearchTypeSelectbox("l_productSearch");
        getAllOptionSelectboxAddTag("sel_option", "");
        getSelectboxListForCtgKey('affiliationCtgKey','133','');
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

    function promotionPacakgeSave() {
        var data = new FormData();

        var basicObj = getJsonObjectFromDiv("section1");
        basicObj.imageList = "";
        basicObj.imageView = "";
        basicObj.emphasis = 0;
        basicObj.calculateRate = 0;
        basicObj.isFreebieDeliveryFree = 0;
        basicObj.isQuickDelivery = 0;

        /*  2.옵션 obj */
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
                gKey:'0',
                kind:optionName,
                ctgKey:'0',
                name:'',
                price:price,
                sellPrice:sellPrice,
                point:point,
                extendPercent:extendPercent
            };
            optionArray.push(data);
        });

        var categoryArr = new Array();
        var data = {
            ctgGKey:0,
            ctgKey:0,
            gKey:0,
            pos:0
        };
        categoryArr.push(data);

        /* 4. 프로모션정보 저장 */
        var promotionInfo = getJsonObjectFromDiv("section4");

        /* 5. 포함된온라인강좌 저장 */
        var onlineLecInfo = new Array();
        var data = {
            linkKey: 0,
            reqKey: 0,
            resKey:0,
            resType: 0,
            pos: 0,
        };
        onlineLecInfo.push(data);

        if(confirm("저장하시겠습니까?")) {
            promotionManageService.savePackage(basicObj, optionArray, categoryArr, promotionInfo, onlineLecInfo, function () {isReloadPage(true);});
        }
    }
</script>
<input type="hidden" name="sPage3" id="sPage3">
<div class="page-breadcrumb">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">연간회원제 등록</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">프로모션 관리</li>
                        <li class="breadcrumb-item active" aria-current="page">연간회원제 등록</li>
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
                                <input type="hidden" value="0" name="goodsId">
                                <input type="hidden" value="" name="goodsTypeName">
                                <input type="hidden" value="" name="summary">
                                <div class="col-md-12">
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">상품타입</label>
                                        <span>프로모션</span>
                                        <input type="hidden" class="col-sm-6 bg-light required form-control" id="type" name='type' value="5">
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
                                        <label class="col-sm-2 control-label col-form-label"  style="margin-bottom: 0">판매</label>
                                        <div class="col-sm-6 input-group pl-0 pr-0">
                                            <input type="text" class="form-control mydatepicker" placeholder="yyyy-mm-dd" name="sellstartdate" id="sellstartdate">
                                            <div class="input-group-append">
                                                <span class="input-group-text"><i class="fa fa-calendar"></i></span>
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
                                    <input type="hidden" name="priceKey" value="0">
                                    <input type="hidden" name="gKey" value="0">
                                    <input type="hidden" name="ctgKey" value="0">
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
                                        <td style="padding:0.3rem;vertical-align:middle;width:20%">
                                            <input type="text" class="form-control text-right" name="expendPercent[]"  onkeypress='saleInputPrice($(this));' style="width:93%;display:inline-block;">
                                            <!--<span style="display: inline-block;">%</span>-->
                                        </td>
                                        <td style="padding: 0.3rem;vertical-align: middle;width:15%">
                                            <span id="sum_0"></span>
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

                        <!-- 프로모션 정보 -->
                        <h3>프로모션정보</h3>
                        <section class="col-md-auto">
                            <div id="section4">
                                <input type="hidden" value="0" name="pmKey">
                                <input type="hidden" value="0" name="gKey">
                                <input type="hidden" value="50" name="pmType">
                                <input type="hidden" value="YEAR_MEMBER" name="pmTypeStr">
                                <div class="col-md-12">
                                    <div class="form-group row">
                                        <label  class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">시험대비년도</label>
                                        <div class="col-sm-6 pl-0 pr-0">
                                            <select class="col-sm-3 select2 form-control custom-select"  id="examYear" name="examYear">
                                                <option value="">선택</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label  class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">급수</label>
                                        <div class="col-sm-6 pl-0 pr-0">
                                            <span id="l_classGroup"></span>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label  class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">직렬</label>
                                        <div class="col-sm-6 pl-0 pr-0">
                                            <select class="col-sm-3 select2 form-control custom-select"  id="affiliationCtgKey" name="affiliationCtgKey">
                                                <option value="">선택</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>
                        <!-- 프로모션정보 -->
                    </div>
                </div>
            </div>
        </div>
        <!-- //div.card -->
    </div>
</form>
<!-- // 기본소스-->
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
            promotionPacakgeSave();
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
</script>

<%@include file="/common/jsp/footer.jsp" %>
