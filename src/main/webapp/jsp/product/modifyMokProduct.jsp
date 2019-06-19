<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<%
    String gKey = request.getParameter("param_key");
%>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/productManageService.js'></script>
<script>
    var gKey = '<%=gKey%>';
    function init() {
        menuActive('menu-1', 9);
        getProductSearchSelectbox("l_searchSel");
        getCategoryList("sel_category","214");
        getEmphasisSelectbox("l_emphasis", "");
        //탭 메뉴 색상 변경
        $("#playForm ul").each(function(idx) {
            var ul = $(this);
            ul.find("li").addClass("done").attr("aria-selected", "false");
            ul.find("li").eq(0).removeClass("done").attr("aria-selected", "true");
        });
        productManageService.getExamProductDetailInfo(gKey, function(info) {
            var MokproductInfo = info.productInfo;
            innerValue("name", MokproductInfo.name);
            innerValue("indate", split_minute_getDay(MokproductInfo.indate));
            innerValue("sellstartdate", split_minute_getDay(MokproductInfo.sellstartdate));
            innerValue("calculateRate", MokproductInfo.calculateRate);
            isCheckboxByNumber("isShow", MokproductInfo.isShow);//노출
            isCheckboxByNumber("isSell", MokproductInfo.isSell);//판매
            isCheckboxByNumber("isFree", MokproductInfo.isFree);//무료
            isCheckboxByNumber("isFreebieDeliveryFree", MokproductInfo.isFreebieDeliveryFree);//무료
            getEmphasisSelectbox("l_emphasis", MokproductInfo.emphasis);   //강조표시


            /*모의고사 정보 가져오기*/
            var productOtherInfo = info.productOtherInfo;
            for(var i = 0; i < productOtherInfo.length; i++ ){
                innerValue("linkKey", productOtherInfo[i].linkKey);
                isCheckboxByNumber("resType", productOtherInfo[i].resType);
                innerHTML("MokInfoName", productOtherInfo[i].goodsName);
                innerValue("examKey", productOtherInfo[i].resKey);
            }

            /**
             * 모의고사 상품 옵션정보 가져오기
             */
            var productOptionInfo = info.productOptionInfo;
            console.log(productOptionInfo);
            if (productOptionInfo.length == 0) {
                var cellData = [
                    function() {return getAllListOptionSelectbox("", true);},
                    function() {return "<input type=\"text\" class=\"form-control \" name=\"price[]\" id='price_0'>"},
                    function() {return "<input type=\"text\" class=\"form-control \" name=\"sellPrice[]\" id='sellPrice_0'>"},
                    function() {return "<input type=\"text\" class=\"form-control \" name=\"point[]\" id='point_0'>"},
                    function() {return "<input type=\"text\" class=\"form-control \" name=\"expendPercent[]\" id='point_0' onkeyup='saleInputPrice($(this));'>"},
                    function() {return "%"},
                    function() {return "<span id='sum_0'></span>"},
                    function() {return "<button type=\"button\" onclick=\"deleteTableRow('optionTable','delBtn');\" class=\"btn btn-outline-danger btn-sm delBtn\" style=\"margin-top:8%;\" >삭제</button>"}
                ];
                dwr.util.addRows("optionList", [0], cellData, {escapeHtml: false});
                $('#optionList tr').eq(0).attr("style", "display:none");

            } else {
                dwr.util.addRows("optionList", productOptionInfo, [
                    function(data) {return getAllListOptionSelectbox(data.kind, true);},
                    function(data) {return "<input type=\"text\" class=\"form-control \" name=\"price[]\" id='price_" + data.priceKey + "'  value='"+ format(data.price) +"' >"},
                    function(data) {return "<input type=\"text\" class=\"form-control \" name=\"sellPrice[]\" id='sellPrice_" + data.priceKey + "'  value='"+ format(data.sellPrice) +"' >"},
                    function(data) {return "<input type=\"text\" class=\"form-control \" name=\"point[]\" id='point_" + data.priceKey + "'  value='"+ format(data.point) +"' >"},
                    function(data) {return "<input type=\"text\" class=\"form-control \" name=\"expendPercent[]\" id='point_" + data.priceKey + "'  value='"+ data.extendPercent +"' onkeyup='saleInputPrice($(this));'>"},
                    function(data) {return "%"},
                    function(data) {return "<span id='sum_" + data.priceKey + "'>" + format(Math.round(data.sellPrice -((data.sellPrice * data.extendPercent) / 100))) + "</span>"},
                    function(data) {return "<button type=\"button\" onclick=\"deleteTableRow('optionTable','delBtn');\" class=\"btn btn-outline-danger btn-sm delBtn\">삭제</button>"}
                ], {escapeHtml:false});
                $('#optionList tr').eq(0).children().eq(7).attr("style", "display:none");
            }

            /**
             * 모의고사 상품 카테고리 정보 가져오기
             */
            var productCategoryInfo = info.productCategoryInfo;
            var nextIcon = "<i class=\"m-r-10 mdi mdi-play\" style=\"font-size:18px;color:darkblue\"></i>";
            if(productCategoryInfo.length > 0){
                dwr.util.addRows("categoryList", productCategoryInfo, [
                    function(data) {return "<input type='hidden' name='inputCtgKey[]' value='"+data[0].ctgKey+"'>";},
                    function()     {return "지안에듀";},
                    function()     {return nextIcon},
                    function(data) {return data[3].name == "지안에듀"? data[2].name : data[3].name;},
                    function()     {return nextIcon},
                    function(data) {return data[3].name == "지안에듀"? data[1].name : data[2].name;},
                    function()     {return nextIcon},
                    function(data) {return data[3].name == "지안에듀"? data[0].name : data[1].name;},
                    function(data) {return data[3].name == "지안에듀"? "" : nextIcon;},
                    function(data) {return data[3].name == "지안에듀"? "" : data[0].name;},
                    function(data) {return "<button type=\"button\" onclick=\"deleteTableRow('categoryTable', 'delBtn');\" class=\"btn btn-outline-danger btn-sm delBtn\">삭제</button>"},
                    // function(data) {return "<input type='hidden' name='selOption[]' value='" + data[0].ctgKey + "'>";}
                ], {escapeHtml:false});

                $('#categoryList tr').each(function(){
                    var tr = $(this);
                    tr.children().eq(0).attr("style", "display:none");
                    tr.children().eq(11).attr("style", "display:none");
                });
            }else{
                var cellData = [
                    function() {return "<input type='hidden' name='inputCtgKey[]' value=''>";},
                    function() {return "지안에듀";},
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
            }
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
        var fistTrStyle = $("#categoryList tr").eq(0).attr("style");

        if (fistTrStyle == "display:none") {
            $('#categoryList tr').eq(0).removeAttr("style", null);
        } else {
            var $tableBody = $("#categoryTable").find("tbody"),
                $trLast = $tableBody.find("tr:last"),
                $trNew = $trLast.clone();
            $trLast.after($trNew);

            $trNew.find("td input").eq(0).val("");
            $trNew.find("td").eq(1).html("지안에듀");
            getCategoryNoTag('categoryTable','1183', '3');
            $trNew.find("td").eq(5).html(defaultCategorySelectbox());
            $trNew.find("td").eq(7).html(defaultCategorySelectbox());
            $trNew.find("td").eq(9).html(defaultCategorySelectbox());
        }
    }


    //옵션 - 할인률 계산
    function saleInputPrice(val) {
        var checkBtn = val;
        var tr = checkBtn.parent().parent();
        var td = tr.children();

        var sellPrice = td.find("input").eq(1).val();
        var extendPercent = td.find("input").eq(3).val();
        var sum = Math.round(removeComma(sellPrice) -((removeComma(sellPrice) * extendPercent) / 100));
        td.find("span").html(sum);
        //innerHTML(calcPrice, sum);
    }
    //카테코리 셀렉트 박스 변경 시
    function changeCategory(tableId, val, tdNum) {
        getCategoryNoTag2(val, tableId, tdNum);
    }

    /*기본정보 수정*/
    function basicModify() {
        var obj = getJsonObjectFromDiv("section1");
        if(obj.isShow == 'on')  obj.isShow = '1';//노출 checkbox
        else obj.isShow = '0';
        if(obj.isSell == 'on')  obj.isSell = '1';//판매
        else obj.isSell = '0';
        if(obj.isFree == 'on')  obj.isFree = '1';//무료
        else obj.isFree = '0';
        if(obj.isFreebieDeliveryFree == 'on')  obj.isFreebieDeliveryFree = '1';//사은품배송비무료
        else obj.isFreebieDeliveryFree = '0';
        if(confirm("기본정보를 수정 하시겠습니까?")) {
            productManageService.upsultGoodsInfo(obj, " ", " ", function () {
                isReloadPage(true);
            });
        }
    }

    /*옵션정보 수정*/
    function updateOptionInfo() {
        var optionNames = get_array_values_by_name("select", "selOption[]");
        var optionPrices = get_array_values_by_name("input", "price[]");
        var sellPrices = get_array_values_by_name("input", "sellPrice[]");
        var points = get_array_values_by_name("input", "point[]");
        var expendPercents = get_array_values_by_name("input", "expendPercent[]");

        var dataArr = new Array();
        for (var i=0; i<optionNames.length; i++) {
            var data = {
                priceKey:'0',
                gKey:'0',
                kind:optionNames[i],
                ctgKey:'0',
                name:'0',
                price:removeComma(optionPrices[i]),
                sellPrice:removeComma(sellPrices[i]),
                point:removeComma(points[i]),
                extendPercent:expendPercents[i]
            }
            dataArr.push(data)
        }
        if(confirm("옵션정보를 수정 하시겠습니까?")){
            productManageService.upsultTGoodsPriceOption(dataArr, gKey,function () {
                isReloadPage(true);
            });
        }
    }

    //카테고리정보 수정
    function updateCategoryInfo() {
        var ctgKeys = get_array_values_by_name("input", "inputCtgKey[]");

        if(confirm("카테고리를 수정 하시겠습니까?")){

            var fistTrStyle = $("#categoryList tr").eq(0).attr("style");

            if (fistTrStyle == "display:none") {
                productManageService.deleteTCategoryGoods(gKey, function(){
                    isReloadPage(true);
                });
            } else {
                var dataArr = new Array();
                $.each(ctgKeys, function(index, key) {
                    if(key == '1183'){
                        var data = {
                            ctgGKey:0,
                            ctgKey:key,
                            gKey:0,
                            pos:0
                        };
                        dataArr.push(data);
                    }
                });
                console.log(dataArr);
                productManageService.upsultTCategoryGoods(dataArr, gKey,function () {
                    isReloadPage(true);
                });
            }
        }
    }

    //모의고사 정보 저장
    function updateMockInfo() {
        if(confirm("모의고사 정보를 저장 하시겠습니까?")){
            var obj = getJsonObjectFromDiv("section4");
            if(obj.resType == 'on')  obj.resType = '2';//노출 checkbox
            else obj.resType = '3';

            var dataArr = new Array();
            var TLinkKeyVO = {
                reqKey: gKey,
                resKey: obj.examKey,
                reqType: 1,
                resType: obj.resType,
                valueBit: 0,
                pos: 0
            };
            dataArr.push(TLinkKeyVO);
           productManageService.upsultTLinkKink(dataArr, gKey,function () {
                isReloadPage(true);
            });
        }
    }

    function fn_search(val) {
        //모의고사 팝업시 검색 종류 셀렉트 박스 구현
        getMockExamSearchTypeSelectbox("l_mockSearchType");

        var paging = new Paging();
        var sPage = $("#sPage").val();
        var searchType = getSelectboxValue("searchType");
        var searchText = getInputTextValue("searchText");

        if(val == "new") sPage = "1";
        if (searchType == undefined) searchType = "";
        if (searchText == undefined) searchText = "";

        dwr.util.removeAllRows("dataList");
        gfn_emptyView("H", "");//페이징 예외사항처리
        productManageService.getMockExamListCount(searchType, searchText, function(cnt) {
            paging.count(sPage, cnt, '10', '10', comment.blank_list);
            var listNum = ((cnt-1)+1)-((sPage-1)*10); //리스트 넘버링
            productManageService.getMockExamList(sPage, '10',searchType, searchText, function (selList) {
                console.log(selList);
                if (selList.length > 0) {
                    for (var i = 0; i < selList.length; i++) {
                        var cmpList = selList[i];
                        var acceptDateHtml = "<td style='vertical-align:middle'>"+split_minute_getDay(cmpList.acceptStartDate)+" "+split_minute_getDay(cmpList.acceptEndDate)+"</td>";
                        var onlineDateHtml = "<td style='vertical-align:middle'>"+split_minute_getDay(cmpList.onlineStartDate)+" "+split_minute_getDay(cmpList.onlineEndDate)+"</td>";
                        var onlineTimeHtml = cmpList.onlineTime+'분';
                        var lectureSelBtn = '<button type="button" onclick="sendChildValue($(this))"  class="btn btn-outline-info mx-auto">선택</button>';
                        var examKey = "<input type='hidden' id='examKey[]' value='"+ cmpList.examKey +"'>";
                        if (cmpList != undefined) {
                            var cellData = [
                                function(data) {return examKey;},
                                function(data) {return cmpList.name;},
                                function(data) {return acceptDateHtml;},
                                function(data) {return onlineDateHtml;},
                                function(data) {return onlineTimeHtml;},
                                function(data) {return lectureSelBtn;}
                            ];
                            dwr.util.addRows("dataList", [0], cellData, {escapeHtml: false});
                            $('#dataList tr').each(function(){
                                var tr = $(this);
                                tr.children().eq(0).attr("style", "display:none");
                            });
                        }
                    }
                }else{
                    gfn_emptyView("V", comment.blank_list2);
                }
            });
        });
    }
    
    function sendChildValue(val) {
        var checkBtn = val;

        var tr = checkBtn.parent().parent();
        var td = tr.children();

        var examKey = td.find("input").val();
        var goodsName = td.eq(1).text();

        var resKeys = get_array_values_by_name("input", "res_key[]");
        if ($.inArray(gKey, resKeys) != '-1') {
            alert("이미 선택된 모의고사입니다.");
            return;
        }
        $("#MokInfoName").html(goodsName);
        $("#examKey").val(examKey);
    }


</script>
<input type="hidden" name="sPage" id="sPage">
<div class="page-breadcrumb">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">모의고사 상품 수정</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">상품관리</li>
                        <li class="breadcrumb-item active" aria-current="page">모의고사 상품 수정</li>
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
                                <input type="hidden" value="<%=gKey%>" name="GKey">
                                <input type="hidden" value="0" name="cpKey">
                                <input type="hidden" value="0" name="isQuickDelivery">
                                <input type="hidden" value="0" name="isNodc">
                                <input type="hidden" value="" name="tags">
                                <input type="hidden" value="0" name="goodsId">
                                <input type="hidden" value="" name="goodsTypeName">
                                <input type="hidden" value="" name="summary">
                                <div class="col-md-12">
                                    <button type="button" class="btn btn-outline-primary btn-sm float-right" onclick="basicModify();">수정</button>
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
                                <button type="button" class="btn btn-outline-primary btn-sm" onclick="updateOptionInfo();">수정</button>
                                <button type="button" class="btn btn-info btn-sm" onclick="addProductOptionInfo();">추가</button>
                            </div>
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
                                        <th scope="col" style="text-align:center;"></th>
                                    </tr>
                                    </thead>
                                    <tbody id="optionList">
                                    </tbody>
                                </table>
                            </div>
                        </section>
                        <!-- //2.옵션 Tab -->

                        <!-- 3.카테고리 목록 Tab -->
                        <h3>카테고리</h3>
                        <section>
                            <div class="float-right mb-3">
                                <button type="button" class="btn btn-outline-primary btn-sm" onclick="updateCategoryInfo();">수정</button>
                                <button type="button" class="btn btn-info btn-sm" onclick="addCategoryInfo()">추가</button>
                            </div>
                            <div id="section3">
                                <table class="table" id="categoryTable">
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
                                    <tbody id="categoryList"></tbody>
                                </table>
                            </div>
                        </section>
                        <!-- //3.카테고리 목록 Tab -->

                        <!-- 4. 모의고사정보 -->
                        <h3>모의고사 정보</h3>
                        <section>
                            <div class="float-right mb-3">
                                <button type="button" class="btn btn-outline-primary btn-sm" onclick="updateMockInfo();">수정</button>
                            </div>
                            <div id="section4">
                                <div class="form-group row">
                                    <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">온라인/오프라인</label>
                                    <div class="col-sm-10">
                                        <div style="margin-top: -23px;" class="col-sm-5">
                                            오프라인
                                            <label class="switch">
                                                <input type="checkbox" style="display:none;" id="resType" name="resType">
                                                <span class="slider"></span>
                                            </label>
                                            온라인
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">모의고사</label>
                                    <div class="col-sm-10 pl-0 pr-0">
                                        <input type="hidden" id="examKey" name='examKey' value="">
                                        <input type="hidden" id="linkKey" name='linkKey' value="">
                                        <span id="MokInfoName" class="pr-2"></span>
                                        <button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#mokModal" onclick="fn_search('new');">모의고사 선택</button>
                                    </div>
                                </div>
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

<!-- 모의고사정보 팝업창-->
<div class="modal fade" id="mokModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document" style="max-width: 900px">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">모의고사 선택</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form>
                <!-- modal body -->
                <div class="modal-body">
                    <div style="margin-bottom: 45px;">
                        <div style=" float: left;">
                            <span id="l_mockSearchType"></span>
                        </div>
                        <div style=" float: left; width: 33%; margin-left: 5px">
                            <input type="text" class="form-control" id="SearchType" onkeypress="if(event.keyCode==13) {fn_search('new'); return false;}">
                        </div>
                        <div style=" float: left; width: 33%; margin-left: 5px;">
                            <button type="button" class="btn btn-outline-info mx-auto" onclick="fn_search('new')">검색</button>
                        </div>
                    </div>

                    <div class="table-responsive scrollable" style="height:800px;">
                        <input type="hidden" id="sPage" >
                        <table id="zero_config" class="table table-hover">
                            <thead class="thead-light">
                            <tr>
                                <th style="width:45%">시험명</th>
                                <th style="width:15%">시험신청기간</th>
                                <th style="width:15%">시험기간</th>
                                <th style="width:15%">진행기간</th>
                                <th style="width:15%"></th>
                            </tr>
                            </thead>
                            <tbody id="dataList"></tbody>
                            <tr>
                                <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
                            </tr>
                        </table>
                        <%@ include file="/common/inc/com_pageNavi.inc" %>
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
        enablePagination : false,
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
