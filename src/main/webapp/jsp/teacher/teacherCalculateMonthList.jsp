<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<%
    String teacherDateSel = request.getParameter("teacher_date_key");
    String teacherNameSel = request.getParameter("teacher_name_key");
%>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/statisManageService.js'></script>
<script>
    var teacherDateSel = '<%=teacherDateSel%>';
    var teacherNameSel = '<%=teacherNameSel%>';

    function init() {
        menuActive('menu-7', 1);
        getSmsYearSelectbox("l_monthYearSel", teacherDateSel);
        var authority =  <%=authority%>;
        var teacherKey = <%=teacherKey%>;

        if(authority == 5){
            selectTeacherSelectbox2("teacherList", teacherKey);//선생님 셀렉트박스
        }else{
            selectTeacherSelectbox("teacherList", teacherNameSel);//선생님 셀렉트박스
        }

        if(teacherNameSel > 0){
            fn_search('new');
        }
    }

    function fn_search(val) {
        innerValue("isSearch", 1);
        dwr.util.removeAllRows("onlineList"); //테이블 리스트 초기화
        dwr.util.removeAllRows("acaList"); //테이블 리스트 초기화
        dwr.util.removeAllRows("pacakgeList"); //테이블 리스트 초기화

        //옵션 목록 삭제
        var trLength=$("#sumList tr").length;
        if(trLength>6){
            for(var i=0;i<trLength-6;i++){
                $("#option"+i).remove();
            }
        }

        var teacherKey      = getSelectboxValue("sel_1");
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
        innerValue("optionPriceSum", "0");

        var loading = new Loading({
            direction: 'hor',
            discription: '검색중',
            animationIn: false,
            animationOut: false,
            defaultApply: 	true,
        });

        var teacherSelKey = 0;
        if(teacherKey) teacherSelKey = teacherKey;
        else teacherSelKey = teacherNameSel;

        statisManageService.getTeacherCalculateByMonth(teacherSelKey, searchYearMonth, function (selList) {
            var videoCalculateResult   = selList.videoCalculateResult; //온라인강좌
            var academyCalculateResult = selList.academyCalculateResult; //학원강의
            var packageCalculateResult = selList.packageCalculateResult; // 패키지
            var calculateOptionList    = selList.calculateOptionList; // 옵션 리스트

            var optionPirce =  0;
            if(selList.calculateOptionList != null) {
                if (calculateOptionList.length > 0) {
                    for (var i = 0; i < calculateOptionList.length; i++) {
                        var cmpList = calculateOptionList[i];
                        optionPirce += cmpList.price;
                        if (cmpList != undefined) {
                            var cloneTr = $("#sumList").find("tr:last").clone();
                            $('#sumList > tr').eq(3).after(cloneTr);
                            cloneTr.show();
                            cloneTr.attr('id', 'option'+i);
                            cloneTr.find("td").eq(0).html(cmpList.title);
                            cloneTr.find("td").eq(4).html(format(cmpList.price));
                            cloneTr.find("td").eq(5).attr('id',cmpList.calculateOptionKey);
                        }
                    }
                    innerValue("optionPriceSum", optionPirce);
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
                        onlinePayPriceTotal += roundingDownWon(cmpList.payPrice);
                        onlineCancelCntTotal += cmpList.cancelCnt;
                        onlineCancelPriceTotal += roundingDownWon(cmpList.cancelPrice);

                        var kind = "";
                        if (cmpList.kind == '100') kind = "VOD";
                        else if (cmpList.kind == '101') kind = "MOBILE";
                        else kind = "VOD+MOBILE";

                        if (cmpList != undefined) {
                            var cellData = [
                                function () {return kind;},
                                function () {return cmpList.name},
                                function () {return cmpList.payCnt},
                                function () {return format(roundingDownWon(cmpList.payPrice))},
                                function () {return cmpList.cancelCnt},
                                function () {return format(roundingDownWon(cmpList.cancelPrice))},
                            ];
                            dwr.util.addRows("onlineList", [0], cellData, {escapeHtml: false});
                        }
                    }
                    innerHTML("onlineTotalCnt", onlineTotalCnt); //온라인강좌 - 인원 합계
                    innerHTML("onlinePayPriceTotal", format(roundingDownWon(onlinePayPriceTotal))); //온라인강좌 - 금액 합계
                    innerHTML("onlineCancelCntTotal", onlineCancelCntTotal == ""? "0":onlineCancelCntTotal); //온라인강좌 - 환불인원 합계
                    innerHTML("onlineCancelPriceTotal", format(roundingDownWon(onlineCancelPriceTotal))); //온라인강좌 - 환불금액 합계
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
                        acaPayPriceTotal += roundingDownWon(cmpList.payPrice);
                        acaCancelTotalCnt += cmpList.cancelCnt;
                        acaCancelPriceTotal += roundingDownWon(cmpList.cancelPrice);

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
                                    return format(roundingDownWon(cmpList.payPrice))
                                },
                                function () {
                                    return cmpList.cancelCnt
                                },
                                function () {
                                    return format(roundingDownWon(cmpList.cancelPrice))
                                },
                            ];
                            dwr.util.addRows("acaList", [0], cellData, {escapeHtml: false});
                        }
                    }
                    innerHTML("acaTotalCnt", acaTotalCnt); //학원강의 - 인원 합계
                    innerHTML("acaPayPriceTotal", format(roundingDownWon(acaPayPriceTotal))); //학원강의 - 금액 합계
                    innerHTML("acaCancelTotalCnt", acaCancelTotalCnt); //학원강의 - 환불인원 합계
                    innerHTML("acaCancelPriceTotal", format(roundingDownWon(acaCancelPriceTotal))); //학원강의 - 환불금액 합계
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
                        packagePayPriceTotal += roundingDownWon(cmpList.payPrice);
                        packageCancelCntTotal += cmpList.cancelCnt;
                        packageCancelPriceTotal += roundingDownWon(cmpList.cancelPrice);

                        var kind = "";
                        if (cmpList.kind == '100') kind = "VOD";
                        else if (cmpList.kind == '101') kind = "MOBILE";
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
                                    return format(roundingDownWon(cmpList.payPrice))
                                },
                                function () {
                                    return cmpList.cancelCnt
                                },
                                function () {
                                    return format(roundingDownWon(cmpList.cancelPrice))
                                },
                            ];
                            dwr.util.addRows("pacakgeList", [0], cellData, {escapeHtml: false});
                        }
                    }
                    innerHTML("packageTotalCnt", packageTotalCnt); //패키지 - 인원 합계
                    innerHTML("packagePayPriceTotal", format(roundingDownWon(packagePayPriceTotal))); //패키지 - 금액 합계
                    innerHTML("packageCancelCntTotal", packageCancelCntTotal == ""? "0":packageCancelCntTotal); //패키지 - 환불인원 합계
                    innerHTML("packageCancelPriceTotal", format(roundingDownWon(packageCancelPriceTotal))); //패키지 - 환불금액 합계
                } else {
                    $("#pacakgeTable").hide();
                    $("#pacakgeLable").hide();
                }
            }

                var totalCnt         = onlineTotalCnt + acaTotalCnt + packageTotalCnt;
                var totalPrice       = onlinePayPriceTotal + acaPayPriceTotal + packagePayPriceTotal; //판매합계
                var cancelTotalCnt   = onlineCancelCntTotal + acaCancelTotalCnt + packageCancelCntTotal;
                var cancelTotalPrice = onlineCancelPriceTotal + acaCancelPriceTotal + packageCancelPriceTotal;
                var alltotalCnt      = (totalCnt-cancelTotalCnt);
                var optionPriceSum   = getInputTextValue("optionPriceSum");

                var alltotalPrice    = (totalPrice - cancelTotalPrice); // 총 합계 (판매합계 - 환불금액)

                if(alltotalPrice >= 0){
                    var allTotalAndOptionSum = (roundingDownWon(alltotalPrice) +  Number(roundingDownWon(optionPriceSum)));

                    if(allTotalAndOptionSum>0) var taxPrice = allTotalAndOptionSum*0.033; //소득세,주민세
                    taxPrice = roundingDownWon(taxPrice) * -1;

                    var duesPrice  = 0; //사우회비
                    var totalPlusOption =Number(totalPrice)+Number(optionPriceSum);
                    if(totalPlusOption > 100000) duesPrice = -10000;
                    else  duesPrice = 0;

                    var actualPay = roundingDownWon(alltotalPrice) + roundingDownWon(taxPrice) + duesPrice + Number(roundingDownWon(optionPriceSum));//실지급액

                    innerHTML("taxPrice", format(roundingDownWon(taxPrice)));
                    innerHTML("actualPay", format(roundingDownWon(actualPay)));
                    innerHTML("duesPrice", format(roundingDownWon(duesPrice)));
                    innerHTML("totalCnt", totalCnt);
                    innerHTML("totalPrice", format(roundingDownWon(totalPrice)));
                    innerHTML("cancelTotalCnt", cancelTotalCnt);
                    innerHTML("cancelTotalPrice", format(roundingDownWon(cancelTotalPrice)));
                    innerHTML("alltotalCnt", alltotalCnt);
                    innerHTML("alltotalPrice", format(roundingDownWon(alltotalPrice)));
                }
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
        var searchYearMonth  = getSelectboxValue("searchYearMonth");
        if(optionTitles.length >= 1){
            alert("상위 옵션을 추가해 주세요.");
            return false;
        }else if(searchYearMonth == ""){
            alert("년월을 선택해 주세요.");
            $("#searchYearMonth").focus();
            return false;
        }else if(teacherKey == ""){
            alert("강사선택을 해주세요.");
            $("#sel_1").focus();
            return false;
        }

        var html = "";
            html += "<tr>";
                html += " <td colspan=\"4\"><input type='text' placeholder='제목을 입력해주세요.' style='width:300px;' id='optionTitle' name='optionTitle'></td>";
                html += " <td></td>";
                html += " <td></td>";
                html += " <td><input type='number' placeholder='가격을 입력해 주세요.' style='width:200px;' id='optionPrice'></td>";
                html += " <td><button type='button' class='btn btn-sm' onclick='optionSave();'>옵션저장</button></td><td></td>";
             html += "</tr>";

             $("#sumList").append(html);
    }

    function optionSave() {
        var teacherKey      = getSelectboxValue("sel_1"); //31, "201903",
        var optionTitle     = $("#optionTitle").val();
        var optionPrice     = $("#optionPrice").val();
        var searchYearMonth  = getSelectboxValue("searchYearMonth");
        if(optionTitle == ""){
            alert("옵션명을 입력해 주세요.");
            $("#optionTitle").focus();
            return false;
        }
        if(optionPrice == ""){
            alert("추가된 옵션 가격을 입력해 주세요.");
            $("#optionPrice").focus();
            return false;
        }
        if(confirm("옵션을 저장하시겠습니까?")){
           statisManageService.saveTeacherCalculateOptionInfo(teacherKey, optionTitle, optionPrice, searchYearMonth, function () {
               var searchYearMonth =  getSelectboxValue('searchYearMonth');
               var teacherName =  getSelectboxValue('sel_1');

               innerValue("teacher_date_key", searchYearMonth);
               innerValue("teacher_name_key", teacherName);
               goPage('teacherManage', 'teacherCalculateMonthList');
           });
        }
    }

    function optionUpdate(td,tr){
        var html = "";
        html += "<tr>";
        html += " <td colspan=\"4\"><input type='text' placeholder='제목을 입력해주세요.' style='width:300px;' id='optionTitle' name='optionTitle'></td>";
        html += " <td></td>";
        html += " <td></td>";
        html += " <td><input type='number' placeholder='가격을 입력해 주세요.' style='width:200px;' id='optionPrice'></td>";
        html += " <td><button type='button' class='btn btn-sm' onclick='optionUpdateGo(" + td + ");'>옵션수정</button></td><td></td>";
        html += "</tr>";

        $("#"+tr).after(html);
    }

    function optionUpdateGo(val){
        var optionTitle     = $("#optionTitle").val();
        var optionPrice     = $("#optionPrice").val();
        var searchYearMonth  = getSelectboxValue("searchYearMonth");

        if(optionTitle == ""){
            alert("옵션명을 입력해 주세요.");
            $("#optionTitle").focus();
            return false;
        }
        if(optionPrice == ""){
            alert("옵션 가격을 입력해 주세요.");
            $("#optionPrice").focus();
            return false;
        }

        if(confirm("옵션을 수정하시겠습니까?")){
            statisManageService.updateTeacherCalculateOptionInfo(val, optionTitle, optionPrice, searchYearMonth, function () {
                var searchYearMonth =  getSelectboxValue('searchYearMonth');
                innerValue("teacher_date_key", searchYearMonth);
                goPage('teacherManage', 'teacherCalculateMonthList');
            });
        }
    }

    function optionDelete(val){
        if(confirm("옵션을 삭제하시겠습니까?")){
            statisManageService.deleteTeacherCalculateOptionInfo(val, function () {
                goPage('teacherManage', 'teacherCalculateMonthList');
            });
        }
    }

    function ReportToExcelConverter() {
        if (getSelectboxValue("searchYearMonth") == "") {
            alert("년원일을 선택하세요.");
            return;
        }
        if (getSelectboxValue("sel_1") == "") {
            alert("강사를 선택하세요.");
            return;
        }
        if (getInputTextValue("isSearch") == "") {
            alert("검색버튼을 눌러주세요.");
            return;
        }
        var month = getSelectboxValue("searchYearMonth");
        var teacherName = $("#sel_1 option:selected").text();

        $('.ttss').html('<div style="width:200px">');
        $('.ttss').html('<button type="button" class="btn btn-primary btn-sm" onclick="optionUpdate($(this).closest(\'td\').attr(\'id\'),$(this).closest(\'tr\').attr(\'id\'));">수정</button>');
        $('.ttss').html('<button type="button" class="btn btn-secondary btn-sm" onclick="optionDelete($(this).closest(\'td\').attr(\'id\'));">삭제</button>');
        $('.ttss').html('</div>');

        $("#excelDownloadDiv").table2excel({
            exclude: ".noExl",
            name: month + "_" + teacherName,
            filename: month + "_" + teacherName +'.xls',
            //확장자를 여기서 붙여줘야한다.
            fileext: ".xls",
            exclude_img: true,
            exclude_links: true,
            exclude_inputs: true
        });

        var searchYearMonth =  getSelectboxValue('searchYearMonth');
        var teacherName =  getSelectboxValue('sel_1');

        innerValue("teacher_date_key", searchYearMonth);
        innerValue("teacher_name_key", teacherName);
        goPage('teacherManage', 'teacherCalculateMonthList');

    }

</script>
<div class="page-breadcrumb">
    <input type="hidden" id="sPage">
    <input type="hidden" id="param_key" name="param_key" value="">
    <input type="hidden" id="teacher_date_key" name="teacher_date_key" value="">
    <input type="hidden" id="teacher_name_key" name="teacher_name_key" value="">
    <div class="row">
        <input type="hidden" id="isSearch" value="">
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
<div class="container-fluid" id="excelDownloadDiv">
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
                            <button type="button" class="btn btn-outline-info mx-auto" onclick="ReportToExcelConverter()"><i class="mdi mdi-file-excel"></i>엑셀다운로드</button>
                        </div>
                    </div>
                </div>
                <!--온라인강좌-->
                <table style="float: left;display:none"  id="onlineLable">
                    <tr><td></td></tr>
                    <tr><td  class="col-sm-3 control-label col-form-label">온라인강좌</td></tr>
                </table>
                <table class="table" id="onlineTable" style="display: none;">
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
                <table style="float: left;display:none"  id="acaLable">
                    <tr><td></td></tr>
                    <tr><td  class="col-sm-3 control-label col-form-label">학원강의</td></tr>
                </table>
                <table class="table"  id="acaTable" style="display: none;">
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
                            <td colspan="2">학원강의 소계</td>
                            <td id="acaTotalCnt"></td>
                            <td id="acaPayPriceTotal"></td>
                            <td id="acaCancelTotalCnt"></td>
                            <td id="acaCancelPriceTotal"></td>
                        </tr>
                    </tfoot>
                </table>
                <!--//학원강의-->
                <!--패키지-->
                <table style="float: left;display:none"  id="pacakgeLable">
                    <tr><td></td></tr>
                    <tr><td  class="col-sm-3 control-label col-form-label">패키지</td></tr>
                </table>
                <table class="table calculate-list" id="pacakgeTable" style="display: none;">
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
                            <td colspan="2">패키지 소계</td>
                            <td id="packageTotalCnt"></td>
                            <td id="packagePayPriceTotal"></td>
                            <td id="packageCancelCntTotal"></td>
                            <td id="packageCancelPriceTotal"></td>
                        </tr>
                    </tfoot>
                </table>
                <!--//패키지-->
                <table style="float: left;display:none">
                    <tr><td></td></tr>
                </table>
                <table class="table text-center SumTable">
                    <input type="hidden" id="optionPriceSum" value="">
                    <tbody id="sumList">
                        <tr>
                            <td colspan="2">판매합계</td>
                            <td></td>
                            <td></td>
                            <td id="totalCnt"></td>
                            <td id="totalPrice"></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="2">환불합계</td>
                            <td></td>
                            <td></td>
                            <td id="cancelTotalCnt"></td>
                            <td id="cancelTotalPrice"></td>
                            <td></td>
                        </tr>
                        <tr id="test">
                        </tr>
                        <tr>
                            <td colspan="2">총 합계</td>
                            <td></td>
                            <td></td>
                            <td id="alltotalCnt"></td>
                            <td id="alltotalPrice"></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="2">소득세(0.3%) +  주민세(0.03%)</td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td id="taxPrice"></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="2">사우회비</td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td id="duesPrice"></td>
                            <td></td>
                        </tr>
                        <tr style="display:none;">
                            <td colspan="2"></td>
                            <td style="width:200px"></td>
                            <td></td>
                            <td style="width:340px"></td>
                            <td style="width:1px"></td>
                            <td style="width:200px" class="ttss">
                                <button type="button" class="btn btn-primary btn-sm" onclick="optionUpdate($(this).closest('td').attr('id'),$(this).closest('tr').attr('id'));">수정</button>
                                <button type="button" class="btn btn-secondary btn-sm" onclick="optionDelete($(this).closest('td').attr('id'));">삭제</button>
                            </td>
                        </tr>
                        <tfoot>
                            <tr>
                                <td colspan="2" style="color: yellow">실지급액</td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td id="actualPay" style="color: yellow"></td>
                                <td></td>
                            </tr>
                        </tfoot>
                    </tbody>
                </table>
                <div style="text-align: center;margin-bottom: 10px;">
                    <button type="button" class="btn btn-info" onclick="optionAdd('save');">옵션추가</button>
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
