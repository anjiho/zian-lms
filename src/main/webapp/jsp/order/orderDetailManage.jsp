<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<%
    String JKey = request.getParameter("JKey");
    String Type = request.getParameter("Type");
%>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/orderManageService.js'></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    var JKey = '<%=JKey%>';
    var Type = '<%=Type%>';

    function init() {
        var num = '';
        if(Type == 'orderList') num = 1;
        else if(Type == 'playOrderList') num = 2;
        else if(Type == 'rePlayOrderList') num = 3;
        else if(Type == 'academyLectureOrderList') num = 4;
        else if(Type == 'bookOrderList') num = 5;
        else if(Type == 'promotionOrderList') num = 6;
        else if(Type == 'cancelOrderList') num = 7;
        menuActive('menu-3', num);
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

            /*배송지정보 가져오기*/
            var deliveryUserInfo = info.deliveryUserInfo;
            //우편번호 postcode  zipcode
            innerValue('postcode', deliveryUserInfo.zipcode);
            innerValue('deliveryUserName', deliveryUserInfo.name);
            innerValue('jibunAddress', deliveryUserInfo.addressNumber);
            innerValue('roadAddress', deliveryUserInfo.addressRoad);
            if(deliveryUserInfo.email){
                var email = deliveryUserInfo.email;
                var splitEmail =  email.split('@');
                innerValue('deliveryUserEmail1',splitEmail[0]);
                innerValue('deliveryUserEmail2',splitEmail[1]);
            }
            if(deliveryUserInfo.telephone){
                var telephone = deliveryUserInfo.telephone;
                var splitTelephone =  telephone.split('-');
                innerValue('tel1',splitTelephone[0]);
                innerValue('tel2',splitTelephone[1]);
                innerValue('tel3',splitTelephone[2]);
            }
            if(deliveryUserInfo.telephoneMobile){
                var telephoneMobile = deliveryUserInfo.telephoneMobile;
                var splitMobile =  telephoneMobile.split('-');
                innerValue('phone1',splitMobile[0]);
                innerValue('phone2',splitMobile[1]);
                innerValue('phone3',splitMobile[2]);
            }
            innerValue('detailAddress', deliveryUserInfo.address);
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
                        <!-- 2.배송지정보 Tab -->
                      <h3>배송지정보</h3>
                        <section>
                            <div class="float-right mb-3">
                                <button type="button" class="btn btn-info btn-sm" onclick="addProductOptionInfo();">저장</button>
                                <button type="button" class="btn btn-info btn-sm" onclick="addProductOptionInfo();">주문자 정보 복사</button>
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
                                        <input type="text" class="col-sm-3 form-control" style="display: inline-block;" id="deliveryUserEmail2" >
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
                            <div class="float-right mb-3">
                                <button type="button" class="btn btn-info btn-sm" onclick="addProductOptionInfo();">저장</button>
                            </div>
                            <div id="section3">
                                <div class="col-md-12">
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">택배사</label>
                                        <span></span>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">배송상태</label>
                                        <span></span>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">배송시작 일자</label>
                                        <input type="text" class="col-sm-2 form-control" style="display: inline-block;">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">배송완료 일자</label>
                                        <span></span>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">송장번호</label>
                                        <input type="text" class="col-sm-2 form-control" style="display: inline-block;">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">송장번호</label>
                                        <button type="button" class="btn btn-outline-danger btn-sm" style="display: inline-block;">배송추적</button>
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
