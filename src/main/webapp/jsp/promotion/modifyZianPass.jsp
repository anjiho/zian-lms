<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<%
    String gKey = request.getParameter("param_key");
%>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/promotionManageService.js'></script>
<script type='text/javascript' src='/dwr/interface/productManageService.js'></script>
<script>
    var gKey = '<%=gKey%>';
    function init() {
        menuActive('menu-2', 3);
        getNewSelectboxListForCtgKey("l_classGroup", "4309", "");
        getExamPrepareSelectbox("examYear", "");//시험대비년도 셀렉트박스
        getProductSearchTypeSelectbox("l_productSearch");
        getAllOptionSelectboxAddTag("sel_option", "");
        getSelectboxListForCtgKey('affiliationCtgKey','133','');

        /* 지안패스 정보 가져오기 */
        promotionManageService.getPackageDetailInfo(gKey, function(info) {
            var productInfo = info.productInfo;
            innerValue("name", productInfo.name);
            innerValue("indate", split_minute_getDay(productInfo.indate));
            if(productInfo.sellstartdate == null) productInfo.sellstartdate = "";
            innerValue("sellstartdate", split_minute_getDay(productInfo.sellstartdate));
            isCheckboxByNumber("isSell", productInfo.isSell);//판매
            /**
             * 옵션정보 가져오기
             */
            var productOptionInfo = info.productOptionInfo;
            if (productOptionInfo.length == 0) {
                var cellData = [
                    function() {return getAllListOptionSelectbox('');},
                    function() {return "<input type=\"text\" class=\"form-control \" name=\"price[]\" id='price_0'>"},
                    function() {return "<input type=\"text\" class=\"form-control \" name=\"sellPrice[]\" id='sellPrice_0'>"},
                    function() {return "<input type=\"text\" class=\"form-control \" name=\"point[]\" id='point_0'>"},
                    function() {return "<input type=\"text\" class=\"form-control \" name=\"expendPercent[]\" id='point_0' onkeypress='saleInputPrice($(this));'>"},
                    function() {return "%"},
                    function() {return "<span id='sum_0'></span>"},
                    function() {return "<button type=\"button\" onclick=\"deleteTableRow('optionTable', 'delBtn');\" class=\"btn btn-outline-danger btn-sm delBtn\" style=\"margin-top:8%;\" >삭제</button>"}
                ];
                dwr.util.addRows("optionList", [0], cellData, {escapeHtml: false});
                $('#optionList tr').eq(0).attr("style", "display:none");

            } else {
                dwr.util.addRows("optionList", productOptionInfo, [
                    function(data) {return getAllListOptionSelectbox(data.kind);},
                    function(data) {return "<input type=\"text\" class=\"form-control \" name=\"price[]\" id='price_" + data.priceKey + "'  value='"+ format(data.price) +"' >"},
                    function(data) {return "<input type=\"text\" class=\"form-control \" name=\"sellPrice[]\" id='sellPrice_" + data.priceKey + "'  value='"+ format(data.sellPrice) +"' >"},
                    function(data) {return "<input type=\"text\" class=\"form-control \" name=\"point[]\" id='point_" + data.priceKey + "'  value='"+ format(data.point) +"' >"},
                    function(data) {return "<input type=\"text\" class=\"form-control \" name=\"expendPercent[]\" id='point_" + data.priceKey + "'  value='"+ data.extendPercent +"' onkeypress='saleInputPrice($(this));'>"},
                    //function(data) {return "<input type=\"text\" class=\"form-control \" name=\"expendPercent[]\" id='point_" + data.priceKey + "'  value='"+ data.extendPercent +"' onkeypress='saleInputPrice(this.value"+ ","+ '"' + data.sellPrice + '"' + ","+ '"' + data.priceKey + '"' + ");'>"},
                    function(data) {return "%"},
                    function(data) {return "<span id='sum_" + data.priceKey + "'>" + format(Math.round(data.sellPrice -((data.sellPrice * data.extendPercent) / 100))) + "</span>"},
                    function(data) {return "<button type=\"button\" onclick=\"deleteTableRow('optionTable', 'delBtn');\" class=\"btn btn-outline-danger btn-sm delBtn\" style=\"margin-top:8%;\" >삭제</button>"},
                ], {escapeHtml:false});
                $('#optionList tr').eq(0).children().eq(7).attr("style", "display:none");
            }

            //프로모션정보 가져오기
            var productPromotionInfo = info.productPromotionInfo;
            deviceLimitSelectbox('deviceLimitCount', productPromotionInfo.deviceLimitCount);
            getExamPrepareSelectbox("examYear", productPromotionInfo.examYear);//시험대비년도 셀렉트박스
            getNewSelectboxListForCtgKey("l_classGroup", "4309", productPromotionInfo.classGroupCtgKey);//급수
            getNewSelectboxListForCtgKey('affiliationCtgKey', '133', productPromotionInfo.affiliationCtgKey);//직렬
            innerValue("pmKey", productPromotionInfo.pmKey);

            /*포함된 온라인강좌 가져오기*/
            var productOnlineLectureInfo = info.productOnlineLectureInfo;
            if (productOnlineLectureInfo.length == 0) {

            } else {
                dwr.util.addRows("promotionOnlineList", productOnlineLectureInfo, [
                    function(data) {return data.goodsName;},
                    function(data) {return "<input type='hidden' name='res_key[]' value='" + data.resKey + "'>";},
                    function(data) {return "<input type='hidden' name='linkKey[]' value='" + data.linkKey + "'>";},
                    function(data) {return "<input type='hidden' name='reqKey[]' value='" + data.reqKey + "'>";},
                    function() {return "<button type=\"button\" onclick=\"deleteTableRow('promotionOnlineTable', 'delBtn');\" class=\"btn btn-outline-danger btn-sm delBtn\">삭제</button>"}
                ], {escapeHtml:false});
                $('#promotionOnlineList tr').each(function(){
                    var tr = $(this);
                    tr.children().eq(2).addClass("text-left").attr("style", "padding: 0.3rem; vertical-align: middle;width: 30%");
                });
            }
        });
    }

    $( document ).ready(function() {
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

    //포함된 온라인강좌 팝업창
    function fn_search(val) {
        var paging = new Paging();
        var sPage = $("#sPage").val();
        var searchType = getSelectboxValue("searchType");
        var searchText = getInputTextValue("productSearchType");

        if(val == "new")  sPage = "1";
        dwr.util.removeAllRows("dataList");
        gfn_emptyView("H", "");//페이징 예외사항처리

        productManageService.getProductListCount(searchType, searchText, "VIDEO", function(cnt) {
            paging.count(sPage, cnt, '10', '10', comment.blank_list);
            var listNum = ((cnt-1)+1)-((sPage-1)*10); //리스트 넘버링
            productManageService.getProductList(sPage, '10',searchType, searchText, "VIDEO", function (selList) {
                console.log(selList);
                if (selList.length > 0) {
                    for (var i = 0; i < selList.length; i++) {
                        var cmpList = selList[i];
                        var bookSelBtn = '<input type="button" id="addBookBtn" onclick="sendChildValue($(this))" value="선택" class="btn btn-outline-info mx-auto"/>';
                        var keyHtml = "<input type='hidden' value='"+ cmpList.GKey +"' id='promotiongKey[]'>";
                        if (cmpList != undefined) {
                            var cellData = [
                                function(data) {return keyHtml;},
                                function(data) {return cmpList.goodsName;},
                                function(data) {return cmpList.isShow == 0 ? "<i class='mdi mdi-close' style='color: red'></i>" : "<i class='mdi mdi-check' style='color:green;'></i>";},
                                function(data) {return cmpList.isSell == 0 ? "<i class='mdi mdi-close' style='color: red'></i>" : "<i class='mdi mdi-check' style='color:green;'></i>";},
                                function(data) {return cmpList.isFree == 0 ? "<i class='mdi mdi-close' style='color: red'></i>" : "<i class='mdi mdi-check' style='color:green;'></i>";},
                                function(data) {return cmpList.teacherName;},
                                function(data) {return cmpList.statusStr;},
                                function(data) {return bookSelBtn;}
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

    //포함된 온라인강좌 전달값
    function sendChildValue(val) {
        var checkBtn = val;

        var tr = checkBtn.parent().parent();
        var td = tr.children();

        var gKey = td.find("input").val();
        var goodsName = td.eq(1).text();

        var resKeys = get_array_values_by_name("input", "res_key[]");
        if ($.inArray(gKey, resKeys) != '-1') {
            alert("이미 선택된 온라인강좌입니다.");
            return;
        }
        var onlineListHtml = "<tr scope='col' colspan='3'>";
        onlineListHtml     += " <td>";
        onlineListHtml     += "<span>" + goodsName + "</span>";
        onlineListHtml     += "</td>";
        onlineListHtml     += " <td>";
        onlineListHtml     += "<input type='hidden'  value='" + gKey + "' name='res_key[]'>";
        onlineListHtml     += "</td>";
        onlineListHtml     += " <td>";
        onlineListHtml     += "<button type=\"button\" onclick=\"deleteTableRow('promotionOnlineTable', 'delBtn');\" class=\"btn btn-outline-danger btn-sm delBtn\">삭제</button>";
        onlineListHtml     += "</td>";
        $('#promotionOnlineTable > tbody:first').append(onlineListHtml);
        $('#promotionOnlineTable tr').each(function(){
            var tr = $(this);
        });
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
        if(basicObj.isSell == 'on')  basicObj.isSell = '1';//판매
        else basicObj.isSell = '0';
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
                gKey: gKey,
                kind:optionName,
                ctgKey:'0',
                name:'',
                price:removeComma(price),
                sellPrice:removeComma(sellPrice),
                point:removeComma(point),
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
        $('#promotionOnlineTable tbody tr').each(function(index){
            var onlineKey = $(this).find("td input").eq(0).val();
            var data = {
                linkKey: 0,
                reqKey: gKey,
                resKey: onlineKey,
                resType: 5,
                pos: 0,
            };
            onlineLecInfo.push(data);
        });

        if(confirm("수정 하시겠습니까?")) {
            promotionManageService.savePackage(basicObj, optionArray, categoryArr, promotionInfo, onlineLecInfo, function () {
                isReloadPage(true);
            });
        }
    }
</script>
<input type="hidden" name="sPage3" id="sPage3">
<div class="page-breadcrumb">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">지안패스 수정</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">프로모션 관리</li>
                        <li class="breadcrumb-item active" aria-current="page">지안패스 수정</li>
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
                                <input type="hidden" value=<%=gKey%>  name="GKey">
                                <input type="hidden" value="0" name="cpKey">
                                <input type="hidden" value="0" name="isNodc">
                                <input type="hidden" value="0" name="tags">
                                <input type="hidden" value="0" name="goodsId">
                                <input type="hidden" value="" name="goodsTypeName">
                                <input type="hidden" value="" name="summary">
                                <input type="hidden" value="0" name="isShow">
                                <input type="hidden" value="0" name="isFree">
                                <input type="hidden" value="0" name="isNodc">
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
                                        <label class="col-sm-2 control-label col-form-label"  style="margin-bottom: 0">판매시작일</label>
                                        <div class="col-sm-6 input-group pl-0 pr-0">
                                            <input type="text" class="form-control mydatepicker" placeholder="yyyy-mm-dd" name="sellstartdate" id="sellstartdate">
                                            <div class="input-group-append">
                                                <span class="input-group-text"><i class="fa fa-calendar"></i></span>
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
                                        <th scope="col" style="text-align:center;width:30%">옵션명</th>
                                        <th scope="col" style="text-align:center;">원가</th>
                                        <th scope="col" style="text-align:center;">판매가</th>
                                        <th scope="col" style="text-align:center;">포인트</th>
                                        <th scope="col" colspan="2" style="text-align:center;">재수강</th>
                                        <th scope="col" style="text-align:center;"></th>
                                    </tr>
                                    </thead>
                                    <tbody id="optionList">
                                    </tbody>
                                </table>
                            </div>
                        </section>
                        <!-- //2.옵션 Tab -->
                        <!-- 프로모션 정보 -->
                        <h3>프로모션정보</h3>
                        <section class="col-md-auto">
                            <div id="section4">
                                <input type="hidden" value="" name="pmKey" id="pmKey">
                                <input type="hidden" value="100" name="pmType">
                                <input type="hidden" value="ZIAN_PASS" name="pmTypeStr">
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
                                    <div class="form-group row">
                                        <label  class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">디바이스 제한 대수</label>
                                        <div class="col-sm-6 pl-0 pr-0">
                                            <span id="sel_serial"></span>
                                            <select class="col-sm-3 select2 form-control custom-select"  id="deviceLimitCount" name="deviceLimitCount">
                                                <option value="">선택</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>
                        <!-- 프로모션정보 -->
                        <!-- 4.포함된 온라인강좌-->
                        <h3>포함된 온라인강좌</h3>
                        <section>
                            <div class="float-right mb-3">
                                <button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#promotionOnlineModal" onclick="fn_search('new');">추가</button>
                            </div>
                            <div id="section6">
                                <table class="table table-hover" id="promotionOnlineTable">
                                    <thead>
                                    <tr>
                                        <th scope="col" colspan="5" style="text-align:center;width:30%">포함온라인강좌 목록</th>
                                    </tr>
                                    </thead>
                                    <tbody id="promotionOnlineList"></tbody>
                                </table>
                            </div>
                        </section>
                        <!-- //4.포함된 온라인강좌 -->
                    </div>
                </div>
            </div>
        </div>
        <!-- //div.card -->
    </div>
</form>
<!-- // 기본소스-->

<!-- 포함된 온라인강좌 팝업창-->
<div class="modal fade" id="promotionOnlineModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document" style="max-width: 900px">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">상품선택</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
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
                            <input type="text" class="form-control" id="productSearchType" onkeypress="if(event.keyCode==13) {fn_search('new'); return false;}">
                        </div>
                        <div style=" float: left; width: 33%; margin-left: 5px;">
                            <button type="button" class="btn btn-outline-info mx-auto" onclick="fn_search('new')">검색</button>
                        </div>
                    </div>
                    <div class="table-responsive   scrollable" style="height:800px;">
                        <input type="hidden" id="sPage" >
                        <table id="zero_config" class="table table-hover">
                            <thead class="thead-light">
                            <tr>
                                <th style="width:48%">상품명</th>
                                <th style="width:8%">노출</th>
                                <th style="width:8%">판매</th>
                                <th style="width:8%">무료</th>
                                <th style="width:18%">강사</th>
                                <th style="width:27%">진행상태</th>
                                <th style="width:5%"></th>
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
