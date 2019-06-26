<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/statisManageService.js'></script>
<script>
    function init() {
        menuActive('menu-7', 1);
        getSmsYearSelectbox("l_monthYearSel","");
        var authority =  <%=authority%>;
        var teacherKey = <%=teacherKey%>;

        if(authority == 5){
            selectTeacherSelectbox2("teacherList", teacherKey);//선생님 셀렉트박스
        }else{
            selectTeacherSelectbox("teacherList", "");//선생님 셀렉트박스
        }
    }

    function fn_search(val) {
        dwr.util.removeAllRows("onlineList"); //테이블 리스트 초기화
        dwr.util.removeAllRows("acaList"); //테이블 리스트 초기화
        dwr.util.removeAllRows("pacakgeList"); //테이블 리스트 초기화
        //옵션 목록 삭제
        $("#sumList tr").each(function () {
            var tr = $(this);
            if (tr.attr("id") == 'option') {
                tr.remove();
            }
        });


        //alert(tr[0].id);


        var teacherKey     = getSelectboxValue("sel_1"); //31, "201903",
        var searchYearMonth = getSelectboxValue("searchYearMonth");

        if(searchYearMonth == ""){
            alert("날짜를 선택해주세요");
            return false;
        }
        if(teacherKey == "") {
            alert("강사를 선택해주세요");
            return false;
        }

        $("#taxPrice").html(0);
        $("#actualPay").html(0);
        $("#duesPrice").html(0);
        $("#totalCnt").html(0);
        $("#totalPrice").html(0);
        $("#cancelTotalCnt").html(0);
        $("#cancelTotalPrice").html(0);
        $("#alltotalCnt").html(0);
        $("#alltotalPrice").html(0);

        var loading = new Loading({
            direction: 'hor',
            discription: '검색중',
            animationIn: false,
            animationOut: false,
            defaultApply: 	true,
        });

        statisManageService.getTeacherCalculateByMonth(teacherKey, searchYearMonth, function (selList) {
            if (selList.length == 0) return;
            var videoCalculateResult   = selList.videoCalculateResult; //온라인강좌
            var academyCalculateResult = selList.academyCalculateResult; //학원강의
            var packageCalculateResult = selList.packageCalculateResult; // 패키지
            var calculateOptionList    = selList.calculateOptionList; // 옵션 리스트

            var optionPirceSum =  0;
            if(selList.calculateOptionList != null) {
                if (calculateOptionList.length > 0) {
                    for (var i = 0; i < calculateOptionList.length; i++) {
                        var cmpList = calculateOptionList[i];
                        optionPirceSum += cmpList.price;
                        if (cmpList != undefined) {
                            var cloneTr = $("#sumList").find("tr:last").clone();
                            //$("#sumList").append(cloneTr);
                            $('#sumList > tr').eq(1).after(cloneTr);
                            //$("#sumList").find("tr").eq(1). append(cloneTr);
                            cloneTr.attr('id', 'option');
                            cloneTr.find("td").eq(0).html(cmpList.title);
                            //cloneTr.find("td").eq(1).attr('id', 'option');
                            cloneTr.find("td").eq(4).html(format(cmpList.price));
                        }
                    }
                }
            }

            var onlineTotalCnt = 0;
            var onlinePayPriceTotal  = 0;
            var onlineCancelCntTotal = 0;
            var onlineCancelPriceTotal = 0;
            if(selList.videoCalculateResult != null) {
                if (videoCalculateResult.length > 0) { //온라인강좌
                    $("#onlineTable").show();
                    $("#onlineLable").show();
                    for (var i = 0; i < videoCalculateResult.length; i++) {
                        var cmpList = videoCalculateResult[i];

                        onlineTotalCnt += cmpList.payCnt;
                        onlinePayPriceTotal += cmpList.payPrice;
                        onlineCancelCntTotal += cmpList.cancelCnt;
                        onlineCancelPriceTotal += cmpList.cancelPrice;

                        var kind = "";
                        if (cmpList.kind == '100') kind = "VOD";
                        else if (cmpList.kind == '100') kind = "MOBILE";
                        else kind = "VOD+MOBILE";

                        if (cmpList != undefined) {
                            var cellData = [
                                function () {return kind;},
                                function () {return cmpList.name},
                                function () {return cmpList.payCnt},
                                function () {return format(cmpList.payPrice)},
                                function () {return cmpList.cancelCnt},
                                function () {return format(cmpList.cancelPrice)},
                            ];
                            dwr.util.addRows("onlineList", [0], cellData, {escapeHtml: false});
                        }
                    }
                    innerHTML("onlineTotalCnt", onlineTotalCnt); //온라인강좌 - 인원 합계
                    innerHTML("onlinePayPriceTotal", format(onlinePayPriceTotal)); //온라인강좌 - 금액 합계
                    innerHTML("onlineCancelCntTotal", onlineCancelCntTotal); //온라인강좌 - 환불인원 합계
                    innerHTML("onlineCancelPriceTotal", format(onlineCancelPriceTotal)); //온라인강좌 - 환불금액 합계
                } else {
                    $("#onlineTable").hide();
                    $("#onlineLable").hide();
                }
            }

            var acaTotalCnt         = 0;
            var acaPayPriceTotal    = 0;
            var acaCancelTotalCnt   = 0;
            var acaCancelPriceTotal = 0;
            if(selList.academyCalculateResult != null) {
                if (academyCalculateResult.length > 0) { //학원강의
                    $("#acaTable").show();
                    $("#acaLable").show();
                    for (var i = 0; i < academyCalculateResult.length; i++) {
                        var cmpList = academyCalculateResult[i];
                        acaTotalCnt += cmpList.payCnt;
                        acaPayPriceTotal += cmpList.payPrice;
                        acaCancelTotalCnt += cmpList.cancelCnt;
                        acaCancelPriceTotal += cmpList.cancelPrice;

                        if (cmpList != undefined) {
                            var cellData = [
                                function () {
                                    return "-";
                                },
                                function () {
                                    return cmpList.name
                                },
                                function () {
                                    return cmpList.payCnt
                                },
                                function () {
                                    return format(cmpList.payPrice)
                                },
                                function () {
                                    return cmpList.cancelCnt
                                },
                                function () {
                                    return format(cmpList.cancelPrice)
                                },
                            ];
                            dwr.util.addRows("acaList", [0], cellData, {escapeHtml: false});
                        }
                    }
                    innerHTML("acaTotalCnt", acaTotalCnt); //학원강의 - 인원 합계
                    innerHTML("acaPayPriceTotal", format(acaPayPriceTotal)); //학원강의 - 금액 합계
                    innerHTML("acaCancelTotalCnt", acaCancelTotalCnt); //학원강의 - 환불인원 합계
                    innerHTML("acaCancelPriceTotal", format(acaCancelPriceTotal)); //학원강의 - 환불금액 합계
                } else {
                    $("#acaTable").hide();
                    $("#acaLable").hide();
                }
            }

            var packageTotalCnt         = 0;
            var packagePayPriceTotal    = 0;
            var packageCancelCntTotal   = 0;
            var packageCancelPriceTotal = 0;
            if(selList.packageCalculateResult != null) {
                if (packageCalculateResult.length > 0) { //패키지
                    $("#pacakgeTable").show();
                    $("#pacakgeLable").show();
                    for (var i = 0; i < packageCalculateResult.length; i++) {
                        var cmpList = packageCalculateResult[i];

                        packageTotalCnt += cmpList.payCnt;
                        packagePayPriceTotal += cmpList.payPrice;
                        packageCancelCntTotal += cmpList.cancelCnt;
                        packageCancelPriceTotal += cmpList.cancelPrice;

                        var kind = "";
                        if (cmpList.kind == '100') kind = "VOD";
                        else if (cmpList.kind == '100') kind = "MOBILE";
                        else kind = "VOD+MOBILE";

                        if (cmpList != undefined) {
                            var cellData = [
                                function () {
                                    return kind;
                                },
                                function () {
                                    return cmpList.name
                                },
                                function () {
                                    return cmpList.payCnt
                                },
                                function () {
                                    return format(cmpList.payPrice)
                                },
                                function () {
                                    return cmpList.cancelCnt
                                },
                                function () {
                                    return format(cmpList.cancelPrice)
                                },
                            ];
                            dwr.util.addRows("pacakgeList", [0], cellData, {escapeHtml: false});
                        }
                    }
                    innerHTML("packageTotalCnt", packageTotalCnt); //패키지 - 인원 합계
                    innerHTML("packagePayPriceTotal", format(packagePayPriceTotal)); //패키지 - 금액 합계
                    innerHTML("packageCancelCntTotal", packageCancelCntTotal); //패키지 - 환불인원 합계
                    innerHTML("packageCancelPriceTotal", format(packageCancelPriceTotal)); //패키지 - 환불금액 합계
                } else {
                    $("#pacakgeTable").hide();
                    $("#pacakgeLable").hide();
                }
            }
            var totalCnt         = onlineTotalCnt + acaTotalCnt + packageTotalCnt;
            var totalPrice       = onlinePayPriceTotal + acaPayPriceTotal + packagePayPriceTotal;
            var cancelTotalCnt   = onlineCancelCntTotal + acaCancelTotalCnt + packageCancelCntTotal;
            var cancelTotalPrice = onlineCancelPriceTotal + acaCancelPriceTotal + packageCancelPriceTotal;
            var alltotalCnt      = (totalCnt-cancelTotalCnt);
            var alltotalPrice    = (totalPrice-cancelTotalPrice);


            var taxPrice =  alltotalPrice*0.033; //소득세,주민세
                taxPrice = taxPrice * -1;
            var result = Math.ceil(taxPrice).toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, '$1,');

            var duesPrice  = 0; //사우회비
            if(totalPrice > 10000) duesPrice = -10000;
            else  duesPrice = 0;

            var actualPay = alltotalPrice+taxPrice+duesPrice+optionPirceSum;//실지급액
            var actualPayResult = Math.ceil(actualPay).toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, '$1,');

            innerHTML("taxPrice", format(result));
            innerHTML("actualPay", format(actualPayResult));
            innerHTML("duesPrice", format(duesPrice));
            innerHTML("totalCnt", totalCnt);
            innerHTML("totalPrice", format(totalPrice));
            innerHTML("cancelTotalCnt", cancelTotalCnt);
            innerHTML("cancelTotalPrice", format(cancelTotalPrice));
            innerHTML("alltotalCnt", alltotalCnt);
            innerHTML("alltotalPrice", format(alltotalPrice));
        });
        loadingOut(loading);
    }

    function MemberDetail(userKey) {
        innerValue("param_key", userKey);
        goPage('memberManage', 'memberManage');
    }

    function optionAdd() {
        var optionTitles = get_array_values_by_name("input", "optionTitle");
        var teacherKey   = getSelectboxValue("sel_1"); //31, "201903",

        if(optionTitles.length >= 1){
            alert("상위 옵션을 추가해 주세요.");
            return false;
        }else if(teacherKey == ""){
            alert("강사선택을 해주세요.");
            return false;
        }

        var html = "";
            html += "<tr>";
                html += " <td colspan=\"4\"><input type='text' placeholder='제목을 입력해주세요.' style='width:300px;' id='optionTitle' name='optionTitle'></td>";
                html += " <td></td>";
                html += " <td></td>";//onkeyup='inputNumberFormat(this);'
                html += " <td><input type='text' placeholder='가격을 입력해 주세요.' style='width:200px;' id='optionPrice'></td>";
                html += " <td><button type='button' class='btn btn-sm' onclick='optionSave();'>옵션저장</button></td>";
             html += "</tr>";

             $("#sumList").append(html);
    }

    function optionSave() {
        var teacherKey      = getSelectboxValue("sel_1"); //31, "201903",
        var optionTitle     = $("#optionTitle").val();
        var optionPrice     = $("#optionPrice").val();

        if(confirm("옵션을 저장하시겠습니까?")){
            statisManageService.saveTeacherCalculateOptionInfo(teacherKey, optionTitle, optionPrice, function () {});
        }
    }
</script>
<div class="page-breadcrumb">
    <input type="hidden" id="sPage">
    <input type="hidden" id="param_key" name="param_key" value="">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">월별 정산내역</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">통계</li>
                        <li class="breadcrumb-item active" aria-current="page">월별 정산내역</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</div>
<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <div>
                        <div style=" float: left; width: 10%">
                            <span id="l_monthYearSel"></span>
                        </div>
                        <div style=" float: left; width: 10%;margin-left: 10px">
                            <span id="teacherList"></span>
                        </div>
                        <div style=" float: left; width: 33%; margin-left: 10px;">
                            <button type="button" class="btn btn-outline-info mx-auto" onclick="fn_search('new')">검색</button>
                        </div>
                    </div>
                </div>
                <!--온라인강좌-->
                <table class="table" id="onlineTable" style="display: none;">
                    <div style="float: left;display: none;" id="onlineLable">
                        <label  class="col-sm-3 control-label col-form-label card-title">온라인강좌</label>
                    </div>
                    <thead>
                    <tr>
                        <th scope="col" style="width: 10%;">구분</th>
                        <th scope="col" style="width: 25%;">강좌명</th>
                        <th scope="col" style="width: 10%;">인원</th>
                        <th scope="col" style="width: 10%;">금액</th>
                        <th scope="col" style="width: 10%;">환불인원</th>
                        <th scope="col" style="width: 15%;">환불금액</th>
                    </tr>
                    </thead>
                    <tbody id="onlineList"></tbody>
                    <tfoot>
                        <tr class="caculate-list">
                            <td colspan="2" >온라인강좌 소계</td>
                            <td id="onlineTotalCnt"></td>
                            <td id="onlinePayPriceTotal"></td>
                            <td id="onlineCancelCntTotal"></td>
                            <td id="onlineCancelPriceTotal"></td>
                        </tr>
                    </tfoot>
                </table>
                <!--//온라인강좌-->
                <!--학원강의-->
                <table class="table text-center"  id="acaTable" style="display: none;">
                    <div style="float: left;display: none;" id="acaLable">
                        <label  class="col-sm-3 control-label col-form-label card-title">학원강의</label>
                    </div>
                    <thead>
                    <tr>
                        <th scope="col" style="width: 10%;">구분</th>
                        <th scope="col" style="width: 25%;">강좌명</th>
                        <th scope="col" style="width: 10%;">인원</th>
                        <th scope="col" style="width: 10%;">금액</th>
                        <th scope="col" style="width: 10%;">환불인원</th>
                        <th scope="col" style="width: 15%;">환불금액</th>
                    </tr>
                    </thead>
                    <tbody id="acaList"></tbody>
                    <tfoot>
                        <tr class="caculate-list">
                            <td colspan="2">온라인강좌 소개</td>
                            <td id="acaTotalCnt"></td>
                            <td id="acaPayPriceTotal"></td>
                            <td id="acaCancelTotalCnt"></td>
                            <td id="acaCancelPriceTotal"></td>
                        </tr>
                    </tfoot>
                </table>
                <!--//학원강의-->
                <!--패키지-->
                <table class="table calculate-list" id="pacakgeTable" style="display: none;">
                    <div style="float: left;display: none;"  id="pacakgeLable">
                        <label  class="col-sm-3 control-label col-form-label">패키지</label>
                    </div>
                    <thead>
                    <tr>
                        <th scope="col" style="width: 10%;">구분</th>
                        <th scope="col" style="width: 25%;">강좌명</th>
                        <th scope="col" style="width: 10%;">인원</th>
                        <th scope="col" style="width: 10%;">금액</th>
                        <th scope="col" style="width: 10%;">환불인원</th>
                        <th scope="col" style="width: 15%;">환불금액</th>
                    </tr>
                    </thead>
                    <tbody id="pacakgeList"></tbody>
                    <tfoot>
                        <tr class="caculate-list">
                            <td colspan="2">온라인강좌 소개</td>
                            <td id="packageTotalCnt"></td>
                            <td id="packagePayPriceTotal"></td>
                            <td id="packageCancelCntTotal"></td>
                            <td id="packageCancelPriceTotal"></td>
                        </tr>
                    </tfoot>
                </table>
                <!--//패키지-->
                <table class="table text-center SumTable">
                    <tbody id="sumList">
                        <tr>
                            <td colspan="4">판매합계</td>
                            <td></td>
                            <td></td>
                            <td id="totalCnt"></td>
                            <td id="totalPrice"></td>
                        </tr>
                        <tr>
                            <td colspan="4">환불합계</td>
                            <td></td>
                            <td></td>
                            <td id="cancelTotalCnt"></td>
                            <td id="cancelTotalPrice"></td>
                        </tr>
                        <tr>
                            <td colspan="4">총 합계</td>
                            <td></td>
                            <td></td>
                            <td id="alltotalCnt"></td>
                            <td id="alltotalPrice"></td>
                        </tr>
                        <tr>
                            <td colspan="4">소득세(0.3%) +  주민세(0.03%)</td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td id="taxPrice"></td>
                        </tr>
                        <tr>
                            <td colspan="4">사우회비</td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td id="duesPrice"></td>
                        </tr>
                        <tfoot>
                            <tr>
                                <td colspan="4" style="color: yellow">실지급액</td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td id="actualPay"></td>
                            </tr>
                        </tfoot>
                    </tbody>
                </table>
                <div style="text-align: center;margin-bottom: 10px;">
                    <button type="button" class="btn btn-info" onclick="optionAdd();">옵션추가</button>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    .SumTable tr{
        background-color: #4d6082;
    }
    .SumTable tr td{
        color: white;
        font-weight: bold;
    }

    .caculate-list {
        background-color: #777777;
    }

    .caculate-list td{
        color: white;
        font-weight: bold;
    }


</style>
<%@include file="/common/jsp/footer.jsp" %>
