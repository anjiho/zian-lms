<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<%
    String JKey = request.getParameter("param_key");
    String type = request.getParameter("type");
%>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/orderManageService.js'></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    var JKey = '<%=JKey%>';
    var type = '<%=type%>';

    function init() {
        //탭 메뉴 색상 변경
        $("#playForm ul").each(function(idx) {
            var ul = $(this);
            ul.find("li").addClass("done").attr("aria-selected", "false");
            ul.find("li").eq(0).removeClass("done").attr("aria-selected", "true");
        });

        var num = '';
        if(type == 'orderList') num = 1;
        else if(type == 'playOrderList') num = 2;
        else if(type == 'rePlayOrderList') num = 3;
        else if(type == 'academyLectureOrderList') num = 4;
        else if(type == 'bookOrderList') num = 5;
        else if(type == 'promotionOrderList') num = 6;
        else if(type == 'cancelOrderList') num = 7;
        menuActive('menu-3', num);
        deliveryCompanySelectbox("deliveryMaster","");//택배사
        orderDeliveryInfoSelectbox('deliveryStatusSel', '');//
        getEmailSelectbox('deliveryUserEmail2', '');//이메일

        /*주문상세정보 가져오기*/
        orderManageService.getOrderDetail(JKey, function(info) {
            /* 결제정보 가져오기 */
            var payInfo = info.payInfo;
            innerHTML("JId", payInfo.JId);//주문번호
            innerHTML("payStatusName", payInfo.payStatusName);//진행상태
            innerHTML("payTypeName", payInfo.payTypeName);//결제방법
            innerHTML("price", payInfo.price  == ''? '0원' : format(payInfo.price)+"원");//주문금액
            innerHTML("deliveryPrice", payInfo.deliveryPrice == ''? '0원' : format(payInfo.deliveryPrice)+"원");//배송비
            innerHTML("dcWelfare", payInfo.dcWelfare == ''? '0원' : format(payInfo.dcWelfare)+"원");//복지할인
            innerHTML("dcCoupon", payInfo.dcCoupon == ''? '0원' : format(payInfo.dcCoupon)+"원");//쿠폰할인
            innerHTML("dcPoint", payInfo.dcPoint == ''? '0원' : format(payInfo.dcPoint)+"원");//사용마일리지
            innerHTML("point", payInfo.point == ''? '0원' : format(payInfo.point)+"원");//적립마일리지
            innerHTML("remainPoint", payInfo.remainPoint == ''? '0원' : format(payInfo.remainPoint)+"원");//남은마일리지
            innerHTML("payDate", payInfo.payDate);//결제일
            innerHTML("pricePay", payInfo.pricePay == ''? '0원' : format(payInfo.pricePay)+"원");//결제금액
            innerHTML("cancelDate", payInfo.cancelDate);//취소일
            innerHTML("cancelDate1", payInfo.cancelDate);//취소일
            innerHTML("cashReceiptTypeName", payInfo.cashReceiptTypeName);//현금영수증방법
            innerHTML("cashReceiptNumber", payInfo.cashReceiptNumber);//현금영수증번호
            innerHTML("pgMsg", payInfo.pgMsg);//PG사 메세지
            innerHTML("bank", payInfo.bank);//(무통장입금) 은행명
            innerHTML("bankAccount", payInfo.bankAccount);//(무통장입금) 계좌버노
            innerHTML("depositUser", payInfo.depositUser);//(무통장입금) 입금예정자 이름

            if(payInfo.payTypeName == '신용카드') $('#cardContent').show();
            else if(payInfo.payTypeName == '무통장입금') $('#accountContent').show();
            else $('#otherContent').show();  /*무료 / 현금+신카 / 온라인 / 현금 / 실시간계좌이체*/

            /* 주문자정보 가져오기 */
            if(info.orderUserInfo != null) {
                var orderUserInfo = info.orderUserInfo;
                innerHTML("email", orderUserInfo.email);
                innerHTML("name", orderUserInfo.name);
                innerHTML("address", orderUserInfo.address);
                innerHTML("addressNumber", orderUserInfo.addressNumber);
                innerHTML("addressRoad", orderUserInfo.addressRoad);
                innerHTML("telephone", orderUserInfo.telephone);
                innerHTML("telephoneMobile", orderUserInfo.telephoneMobile);
                innerHTML("zipcode", orderUserInfo.zipcode);
            }
            /* 주문상품정보 */
            if(info.orderProductList != null){
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
            }
            /*배송지정보 가져오기*/
            if(info.deliveryAddressInfo != null){
                var deliveryAddressInfo = info.deliveryAddressInfo;
                innerValue('postcode', deliveryAddressInfo.deliveryZipcode);
                innerValue('deliveryUserName', deliveryAddressInfo.deliveryNane);
                innerValue('jibunAddress', deliveryAddressInfo.deliveryAddress);
                innerValue('roadAddress', deliveryAddressInfo.deliveryAddressRoad);
                innerValue('detailAddress', deliveryAddressInfo.deliveryAddressAdd);
                if(deliveryAddressInfo.deliveryEmail){
                    var email = deliveryAddressInfo.deliveryEmail;
                    var splitEmail =  email.split('@');
                    innerValue('deliveryUserEmail1',splitEmail[0]);
                    innerValue('InputEmail', splitEmail[1]);//이메일
                }
                if(deliveryAddressInfo.deliveryTelephone){
                    var telephone = deliveryAddressInfo.deliveryTelephone;
                    var splitTelephone =  telephone.split('-');
                    innerValue('tel1',splitTelephone[0]);
                    innerValue('tel2',splitTelephone[1]);
                    innerValue('tel3',splitTelephone[2]);
                }
                if(deliveryAddressInfo.deliveryTelephoneMobile){
                    var telephoneMobile = deliveryAddressInfo.deliveryTelephoneMobile;
                    var splitMobile =  telephoneMobile.split('-');
                    innerValue('phone1',splitMobile[0]);
                    innerValue('phone2',splitMobile[1]);
                    innerValue('phone3',splitMobile[2]);
                }
            }

            /* 배송정보 가져오기*/
            if(info.deliveryInfo != null) {
                var deliveryInfo = info.deliveryInfo;
                deliveryCompanySelectbox("deliveryMaster", deliveryInfo.deliveryMasterKey);//택배사
                orderDeliveryInfoSelectbox('deliveryStatusSel', deliveryInfo.status);//
                innerHTML("deliveryStartDate", deliveryInfo.deliveryStartDate);//시작일자
                innerHTML("deliveryEndDate", deliveryInfo.deliveryEndDate);//완료일자
                innerValue("deliveryNo", deliveryInfo.deliveryNo);//송장번호
                innerValue("JDeliveryKey", deliveryInfo.JDeliveryKey);//JDeliveryKey
            }
        });
    }

    function emailSelChange(val) {
        if(val == '1') $('#InputEmail').val('');
        else $('#InputEmail').val(val);
    }

    function saveDeliveryAddressInfo() { //배송지정보 저장
        var deliveryName       = getInputTextValue("deliveryUserName");
        var deliveryUserEmail1 = getInputTextValue("deliveryUserEmail1");
        var InputEmail         = getInputTextValue("InputEmail");
        var deliveryEmail      =  deliveryUserEmail1+"@"+InputEmail;
        var tel1 = getInputTextValue("tel1");
        var tel2 = getInputTextValue("tel2");
        var tel3 = getInputTextValue("tel3");
        var deliveryTelephone  =  tel1+"-"+tel2+"-"+tel3;
        var phone1 = getInputTextValue("phone1");
        var phone2 = getInputTextValue("phone2");
        var phone3 = getInputTextValue("phone3");
        var deliveryTelephoneMobile  =  phone1+"-"+phone2+"-"+phone3;
        var deliveryZipcode     = getInputTextValue('postcode');
        var deliveryAddressRoad = getInputTextValue('roadAddress');
        var deliveryAddress     = getInputTextValue('jibunAddress');
        var deliveryAddressAdd  = getInputTextValue('detailAddress');

        if(deliveryEmail != ""){
            var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
            if(exptext.test(deliveryEmail)==false){
                alert("이메일형식이 올바르지 않습니다.");
                $('#InputEmail').focus();
                return false;
            }
        }

        if(confirm('배송지정보를 저장하시겠습니까?')){
            orderManageService.saveDeliveryAddressInfo(JKey, deliveryName, deliveryEmail,
                deliveryTelephone, deliveryTelephoneMobile, deliveryZipcode, deliveryAddress, deliveryAddressRoad, deliveryAddressAdd, function(info) {isReloadPage();});
        }
    }

    function copyDeliveryInfo() { //주문자정보 복사
        var loading = new Loading({
            direction: 'hor',
            discription: '주문자 정보를 가져오는중',
            animationIn: false,
            animationOut: false,
            defaultApply: 	true,
        });

        orderManageService.getOrderDetail(JKey, function(info) {
            var orderUserInfo = info.orderUserInfo;

            innerValue("deliveryUserName", orderUserInfo.name);
            if(orderUserInfo.email){
                var email = orderUserInfo.email;
                var splitEmail =  email.split('@');
                innerValue('deliveryUserEmail1', splitEmail[0]);
                innerValue('InputEmail', splitEmail[1]);
            }
            if(orderUserInfo.telephone){
                var telephone = orderUserInfo.telephone;
                var splitTelephone =  telephone.split('-');
                innerValue('tel1',splitTelephone[0]);
                innerValue('tel2',splitTelephone[1]);
                innerValue('tel3',splitTelephone[2]);
            }
            if(orderUserInfo.telephoneMobile){
                var telephoneMobile = orderUserInfo.telephoneMobile;
                var splitMobile =  telephoneMobile.split('-');
                innerValue('phone1',splitMobile[0]);
                innerValue('phone2',splitMobile[1]);
                innerValue('phone3',splitMobile[2]);
            }
            innerValue('phone3',splitMobile[2]);
            innerValue("postcode", orderUserInfo.zipcode);
            innerValue("roadAddress", orderUserInfo.addressRoad);
            innerValue("jibunAddress", orderUserInfo.addressNumber);
            innerValue("detailAddress", orderUserInfo.address);

            loadingOut(loading);
        });
    }

    function saveDeliveryInfo() { //배송정보 저장
        var deliveryMasterKey = getSelectboxValue('deliverycompany');
        var status = getSelectboxValue('deliveryType');
        var deliveryNo = getInputTextValue('deliveryNo');
        var JDeliveryKey = getInputTextValue('JDeliveryKey');

        if(JDeliveryKey == null || JDeliveryKey == undefined || JDeliveryKey == "")  JDeliveryKey = 0;
        if(confirm('배송정보를 저장하시겠습니까?')){
            orderManageService.saveDeliveryInfo(JDeliveryKey, JKey, deliveryMasterKey, status, deliveryNo, function() {isReloadPage();});
        }
    }

    //배송조회 팝업
    function trackingDelivery() {
        var deliveryNumber = getInputTextValue("deliveryNo");
        var targetUrl = "https://www.doortodoor.co.kr/doortodoor.do?fsp_action=PARC_ACT_002&fsp_cmd=retrieveInvNoACT&invc_no=" + deliveryNumber;
        gfn_winPop(1000, 2000, targetUrl, '');
    }
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
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0;">결제금액</label>
                                    <div class="col-lg-3">
                                        <span id="pricePay" style="color: blue;"></span>
                                    </div>
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0"></label>
                                    <div class="col-lg-3">
                                        <span></span>
                                    </div>
                                </div>
                                <!--신용카드-->
                                <div class="row mb-3" id="cardContent" style="display: none;">
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">취소일</label>
                                    <div class="col-lg-3">
                                        <span id="cancelDate"></span>
                                    </div>
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">PG사메세지</label>
                                    <div class="col-lg-3">
                                        <span id="pgMsg" style="color: red;"></span>
                                    </div>
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0"></label>
                                    <div class="col-lg-3">
                                        <span></span>
                                    </div>
                                </div>
                                <!--//신용카드-->
                                <!--무통장입금-->
                                <div class="row mb-3" id="accountContent" style="display: none;">
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">입금예정 은행</label>
                                    <div class="col-lg-3">
                                        <span id="bank"></span>
                                    </div>
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">입금예정 계좌번호</label>
                                    <div class="col-lg-3">
                                        <span id="bankAccount"></span>
                                    </div>
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">입금예정자 이름</label>
                                    <div class="col-lg-3">
                                        <span id="depositUser"></span>
                                    </div>
                                </div>
                                <!--//무통장입금-->
                                <!--무료 / 현금+신카 / 온라인 / 현금-->
                                <div class="row mb-3" id="otherContent" style="display: none;">
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">취소일</label>
                                    <div class="col-lg-3">
                                        <span id="cancelDate1"></span>
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
                                <!--//무통장입금-->
                                <div class="row mb-3">
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">현금영수증방법</label>
                                    <div class="col-lg-3">
                                        <span id="cashReceiptTypeName"></span>
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
                                    <div class="col-lg-6">
                                        <span id='zipcode'></span>
                                        <span id='addressRoad'></span>
                                    </div>
                                    <div class="col-lg-6">
                                        <span id="addressNumber"></span>
                                    </div>
                                    <div class="col-lg-3">
                                        <span id='address'></span>
                                    </div>
                                </div>
                            </div>
                        </section>
                        <!-- // 1.기본정보 Tab -->
                        <!-- 2.배송지정보 Tab -->
                      <h3>배송지정보</h3>
                        <section>
                            <div class="mb-3">
                                <button type="button" class="btn btn-outline-primary btn-sm" onclick="saveDeliveryAddressInfo();">저장</button>
                                <button type="button" class="btn btn-info btn-sm" onclick="copyDeliveryInfo();">주문자 정보 복사</button>
                            </div>
                            <div id="section2">
                                <div class="col-md-12">
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">수취인</label>
                                        <input type="text" class="col-sm-6 form-control" style="display: inline-block;" id="deliveryUserName">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">E-Mail</label>
                                        <input type="text" class="col-sm-3 form-control" style="display: inline-block;" id="deliveryUserEmail1" >
                                        @
                                        <div class="col-lg-5 row">
                                            <input type="text" id="InputEmail" class="col-sm-4 form-control">
                                            <div class="col-sm-7 pl-0 pr-0">
                                                <span id="deliveryUserEmail2"></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">연락처</label>
                                        <input type="text" class="col-sm-2 form-control" style="display: inline-block;" id="tel1">
                                        -
                                        <input type="text" class="col-sm-2 form-control" style="display: inline-block;" id="tel2">
                                        -
                                        <input type="text" class="col-sm-2 form-control" style="display: inline-block;" id="tel3">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">휴대전화</label>
                                        <input type="text" class="col-sm-2 form-control" style="display: inline-block;" id="phone1">
                                        -
                                        <input type="text" class="col-sm-2 form-control" style="display: inline-block;" id="phone2">
                                        -
                                        <input type="text" class="col-sm-2 form-control" style="display: inline-block;" id="phone3">
                                    </div>
                                    <!--주소 -->
                                    <div class="form-group">
                                        <!--<label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">주소</label>
                                        <input type="text" class="col-sm-2 form-control" style="display: inline-block;" id="addressDeliveryNumber">
                                        <button type="button" class="btn btn-info btn-sm" onclick="addProductOptionInfo();">우편번호 찾기</button>
                                        <span id="address1"></span><br>
                                        <span id="address2"></span>
                                        <input type="text" class="col-sm-4 form-control" style="display: inline-block;" id="detailAddress">-->
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">주소</label>
                                        <input type="text" id="postcode" class="col-sm-2 form-control" style="display: inline-block;" placeholder="우편번호">
                                        <input type="button" onclick="execDaumPostcode()" class="btn btn-info btn-sm" style="display: inline-block;" value="우편번호 찾기"><br>
                                        <input type="text" id="roadAddress" class="col-sm-4 form-control" style="display: inline-block;" placeholder="도로명주소">
                                        <input type="text" id="jibunAddress"  class="col-sm-4 form-control" style="display: inline-block;" placeholder="지번주소">
                                        <span id="guide" style="color:#999;display:none"></span>
                                        <input type="text" id="detailAddress" class="col-sm-4 form-control" placeholder="상세주소">
                                        <!--<input type="text" id="sample4_extraAddress"  class="form-control" placeholder="참고항목">-->
                                    </div>



                                </div>
                            </div>
                        </section>
                      <!--3.배송지정보 Tab -->
                        <h3>배송정보</h3>
                        <section>
                            <div class="mb-3">
                                <button type="button" class="btn btn-outline-primary btn-sm" onclick="saveDeliveryInfo();">저장</button>
                            </div>
                            <div id="section3">
                                <div class="col-md-12">
                                    <input type="hidden" id="JDeliveryKey" value="">
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">택배사</label>
                                        <div class="col-sm-5 pl-0 pr-0">
                                            <span id="deliveryMaster"></span>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">배송상태</label>
                                        <div class="col-sm-5 pl-0 pr-0">
                                            <span id="deliveryStatusSel"></span>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">배송시작 일자</label>
                                        <span id="deliveryStartDate"></span>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">배송완료 일자</label>
                                        <span id="deliveryEndDate"></span>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">송장번호</label>
                                        <input type="text" id="deliveryNo"  class="col-sm-4 form-control" style="display: inline-block;">
                                        <button type="button" class="btn btn-outline-danger btn-sm" style="display: inline-block;" onclick="trackingDelivery();">배송추적</button>
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

    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }

                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }

                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("roadAddress").value = roadAddr;
                document.getElementById("jibunAddress").value = data.jibunAddress;

                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                /*if(roadAddr !== ''){
                    document.getElementById("extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("extraAddress").value = '';
                }*/

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
</script>

<%@include file="/common/jsp/footer.jsp" %>
