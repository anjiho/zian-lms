<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<%
    String JKey = request.getParameter("JKey");
%>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/orderManageService.js'></script>
<script>
    var JKey = '<%=JKey%>';
    function init() {
        menuActive('menu-3', 1);
        deliveryNameSelectbox('deliveryNameSel', '');
        orderDeliveryInfoSelectbox('deliveryStatusSel', '');

        /*주문상세정보 가져오기*/
        orderManageService.getOrderDetail(JKey, function(info) {
            console.log(info);
            /* 결제정보 가져오기 */
            var payInfo = info.payInfo;
            innerHTML("JId", payInfo.JId);//주문번호
            innerHTML("payStatusName", payInfo.payStatusName);//진행상태
            innerHTML("payTypeName", payInfo.payTypeName);//결제방법
            innerHTML("price", payInfo.price  == ''? '0원' : format(payInfo.price)+"원");//주문금액
            innerHTML("deliveryPrice", payInfo.deliveryPrice == ''? '0원' : payInfo.deliveryPrice+"원");//배송비
            innerHTML("dcWelfare", payInfo.dcWelfare == ''? '0원' : payInfo.dcWelfare+"원");//복지할인
            innerHTML("dcCoupon", payInfo.dcCoupon == ''? '0원' : payInfo.dcCoupon+"원");//쿠폰할인
            innerHTML("dcPoint", payInfo.dcPoint == ''? '0원' : payInfo.dcPoint+"원");//사용마일리지
            innerHTML("point", payInfo.point == ''? '0원' : payInfo.point+"원");//적립마일리지
            innerHTML("remainPoint", payInfo.remainPoint == ''? '0원' : payInfo.remainPoint+"원");//남은마일리지
            innerHTML("payDate", payInfo.payDate);//결제일
            innerHTML("pricePay", payInfo.pricePay == ''? '0원' : format(payInfo.pricePay)+"원");//결제금액
            innerHTML("cancelDate", payInfo.cancelDate);//취소일
            innerHTML("cashReceiptType", payInfo.cashReceiptType);//현금영수증방법
            innerHTML("cashReceiptNumber", payInfo.cashReceiptNumber);//현금영수증번호
            innerHTML("pgMsg", payInfo.pgMsg);//PG사 메세지

            /* 주문자정보 가져오기 */
            var orderUserInfo = info.orderUserInfo;
            innerHTML("email", orderUserInfo.email);
            innerHTML("name", orderUserInfo.name);
            innerHTML("address", orderUserInfo.address);
            innerHTML("addressNumber", orderUserInfo.addressNumber);
            innerHTML("addressRoad", orderUserInfo.addressRoad);
            innerHTML("telephone", orderUserInfo.telephone);
            innerHTML("telephoneMobile", orderUserInfo.telephoneMobile);

            /* 주문상품정보 */
            var orderProductList = info.orderProductList;
            if (orderProductList.length > 0) {
                dwr.util.addRows("dataList", orderProductList, [
                    function(data) {return "<input type='hidden' name='JGKey[]' value='"+ data.JGKey +"'>"},//코드
                    function(data) {return data.productTypeName},//코드
                    function(data) {return data.name},//출제구분
                    function(data) {return data.productOptionName},//출제구분
                    function(data) {return data.cnt},//출제구분
                    function(data) {return format(data.sellPrice)},//출제구분
                ], {escapeHtml:false});
                $('#dataList tr').each(function(){
                    var tr = $(this);
                    tr.children().eq(0).attr("style", "display:none");
                });
            }

            var deliveryUserInfo = info.deliveryUserInfo;


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
</script>
<div class="page-breadcrumb">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">주문상세</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">주문관리</li>
                        <li class="breadcrumb-item active" aria-current="page">주문상세</li>
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
                                <div class="row mb-3">
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">주문번호</label>
                                    <div class="col-lg-3">
                                        <span id="JId"></span>
                                    </div>
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0"></label>
                                    <div class="col-lg-3">
                                        <span></span>
                                    </div>
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0"></label>
                                    <div class="col-lg-3">
                                        <span></span>
                                    </div>
                                </div>
                                <div class="row mb-2" style="background-color:#dee2e6 ;height: 35px;">
                                    <h4>결제정보</h4>
                                </div>
                                <div class="row mb-3">
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">진행상태</label>
                                    <div class="col-lg-3">
                                        <span id="payStatusName"></span>
                                    </div>
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">결제방법</label>
                                    <div class="col-lg-3">
                                        <span id="payTypeName"></span>
                                    </div>
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">주문금액</label>
                                    <div class="col-lg-3">
                                        <span id="price"></span>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">배송비</label>
                                    <div class="col-lg-3">
                                        <span id="deliveryPrice"></span>
                                    </div>
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">복지할인</label>
                                    <div class="col-lg-3">
                                        <span id="dcWelfare"></span>
                                    </div>
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">쿠폰할인</label>
                                    <div class="col-lg-3">
                                        <span id="dcCoupon"></span>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">사용 마일리지</label>
                                    <div class="col-lg-3">
                                        <span id="dcPoint"></span>
                                    </div>
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">적립 마일리지</label>
                                    <div class="col-lg-3">
                                        <span id="point"></span>
                                    </div>
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">남은 마일리지</label>
                                    <div class="col-lg-3">
                                        <span id="remainPoint"></span>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">결제일</label>
                                    <div class="col-lg-3">
                                        <span id="payDate"></span>
                                    </div>
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">결제금액</label>
                                    <div class="col-lg-3">
                                        <span id="pricePay"></span>
                                    </div>
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0"></label>
                                    <div class="col-lg-3">
                                        <span></span>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">취소일</label>
                                    <div class="col-lg-3">
                                        <span id="cancelDate"></span>
                                    </div>
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">PG사메세지</label>
                                    <div class="col-lg-3">
                                        <span id="pgMsg"></span>
                                    </div>
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0"></label>
                                    <div class="col-lg-3">
                                        <span></span>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">현금영수증방법</label>
                                    <div class="col-lg-3">
                                        <span id="cashReceiptType"></span>
                                    </div>
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">현금영수증번호</label>
                                    <div class="col-lg-3">
                                        <span id="cashReceiptNumber"></span>
                                    </div>
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0"></label>
                                    <div class="col-lg-3">
                                        <span></span>
                                    </div>
                                </div>
                                <div class="row mb-2" style="background-color:#dee2e6 ;height: 35px;">
                                    <h4>주문상품정보</h4>
                                </div>
                                <table class="table table-hover text-center">
                                    <input type="hidden" id="examKey" name="examKey" value="">
                                    <thead>
                                    <tr>
                                        <th scope="col" style="width: 10%;">상품종류</th>
                                        <th scope="col" style="width: 50%;">상품명</th>
                                        <th scope="col" style="width: 15%;">옵션</th>
                                        <th scope="col" style="width: 5%;">수량</th>
                                        <th scope="col" style="width: 10%;">판매금액</th>
                                    </tr>
                                    </thead>
                                    <tbody id="dataList"></tbody>
                                </table>
                                <div class="row mb-2" style="background-color:#dee2e6 ;height: 35px;">
                                    <h4>주문자정보</h4>
                                </div>
                                <div class="row mb-3">
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">이름</label>
                                    <div class="col-lg-3">
                                        <span id="name"></span>
                                    </div>
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">E-Mail</label>
                                    <div class="col-lg-3">
                                        <span id="email"></span>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">연락처</label>
                                    <div class="col-lg-3">
                                        <span id="telephone"></span>
                                    </div>
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">휴대전화</label>
                                    <div class="col-lg-3">
                                        <span id="telephoneMobile"></span>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">주소</label>
                                    <div class="col-lg-3">
                                        <span id='addressNumber'></span>
                                    </div>
                                    <div class="col-lg-3">
                                        <span id="addressRoad"></span>address
                                    </div>
                                    <div class="col-lg-3">
                                        <span id='address'></span>
                                    </div>
                                </div>
                            </div>
                        </section>
                        <!-- // 1.기본정보 Tab -->
                        <!-- 2.옵션 Tab -->
                      <h3>배송지정보</h3>
                        <section>
                            <div class="float-right mb-3">
                                <button type="button" class="btn btn-info btn-sm" onclick="addProductOptionInfo();">추가</button>
                            </div>
                            <div id="section2">
                                <div class="col-md-12">
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">수취인</label>
                                        <input type="text" class="col-sm-6 form-control" style="display: inline-block;" id="" name="">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">E-Mail</label>
                                        <input type="text" class="col-sm-6 form-control" style="display: inline-block;" id="" name="">
                                        @
                                        <span></span>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">연락처</label>
                                        <input type="text" class="col-sm-6 form-control" style="display: inline-block;">
                                        -
                                        <input type="text" class="col-sm-6 form-control" style="display: inline-block;">
                                        -
                                        <input type="text" class="col-sm-6 form-control" style="display: inline-block;">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">휴대전화</label>
                                        <input type="text" class="col-sm-6 form-control" style="display: inline-block;">
                                        -
                                        <input type="text" class="col-sm-6 form-control" style="display: inline-block;">
                                        -
                                        <input type="text" class="col-sm-6 form-control" style="display: inline-block;">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">주소</label>
                                        <input type="text" class="col-sm-6 form-control" style="display: inline-block;">
                                        <button type="button" class="btn btn-info btn-sm" onclick="addProductOptionInfo();">우편번호 찾기</button>
                                        <span></span>
                                        <input type="text" class="col-sm-6 form-control" style="display: inline-block;">
                                    </div>
                                </div>
                            </div>
                        </section>
                      <!--2.옵션 Tab -->
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
        enablePagination : false,
        onFinished: function(event, currentIndex) {
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
