<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/promotionManageService.js'></script>
<script type='text/javascript' src='/dwr/interface/productManageService.js'></script>
<script>
    function init() {
        menuActive('menu-3', 1);
        deliveryNameSelectbox('deliveryNameSel', '');
        orderDeliveryInfoSelectbox('deliveryStatusSel', '');
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
<input type="hidden" name="sPage3" id="sPage3">
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
                                        <span></span>
                                    </div>
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">수강번호</label>
                                    <div class="col-lg-3">
                                        <span></span>
                                    </div>
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0"></label>
                                    <div class="col-lg-3">
                                        <span></span>
                                    </div>
                                </div>
                                <div class="row mb-2" style="background-color:#dee2e6 ;height: 35px;">
                                    <span>결제정보</span>
                                </div>
                                <div class="row mb-3">
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">진행상태</label>
                                    <div class="col-lg-3">
                                        <span></span>
                                    </div>
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">결제방법</label>
                                    <div class="col-lg-3">
                                        <span></span>
                                    </div>
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">주문금액</label>
                                    <div class="col-lg-3">
                                        <span></span>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">배송비</label>
                                    <div class="col-lg-3">
                                        <span></span>
                                    </div>
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">복지할인</label>
                                    <div class="col-lg-3">
                                        <span></span>
                                    </div>
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">VIP 할인</label>
                                    <div class="col-lg-3">
                                        <span></span>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">쿠폰할인</label>
                                    <div class="col-lg-3">
                                        <span></span>
                                    </div>
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">임의할인</label>
                                    <div class="col-lg-3">
                                        <span></span>
                                    </div>
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0"></label>
                                    <div class="col-lg-3">
                                        <span></span>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">사용 마일리지</label>
                                    <div class="col-lg-3">
                                        <span></span>
                                    </div>
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">적립 마일리지</label>
                                    <div class="col-lg-3">
                                        <span></span>
                                    </div>
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">남은 마일리지</label>
                                    <div class="col-lg-3">
                                        <span></span>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">결제일</label>
                                    <div class="col-lg-3">
                                        <span></span>
                                    </div>
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">결제금액</label>
                                    <div class="col-lg-3">
                                        <span></span>
                                    </div>
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">취소일</label>
                                    <div class="col-lg-3">
                                        <span></span>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">현금영수증방법</label>
                                    <div class="col-lg-3">
                                        <span></span>
                                    </div>
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">현금영수증번호</label>
                                    <div class="col-lg-3">
                                        <span></span>
                                    </div>
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0"></label>
                                    <div class="col-lg-3">
                                        <span></span>
                                    </div>
                                </div>
                                <div class="row mb-2" style="background-color:#dee2e6 ;height: 35px;">
                                    <span>주문상품정보</span>
                                </div>
                                <div class="row mb-3">
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">상품종류</label>
                                    <div class="col-lg-3">
                                        <span></span>
                                    </div>
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">상품명</label>
                                    <div class="col-lg-3">
                                        <span></span>
                                    </div>
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0"></label>
                                    <div class="col-lg-3">
                                        <span></span>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">옵션</label>
                                    <div class="col-lg-3">
                                        <span></span>
                                    </div>
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">수량</label>
                                    <div class="col-lg-3">
                                        <span></span>
                                    </div>
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">판매금액</label>
                                    <div class="col-lg-3">
                                        <span></span>
                                    </div>
                                </div>
                                <div class="row mb-2" style="background-color:#dee2e6 ;height: 35px;">
                                    <span>주문자정보</span>
                                </div>
                                <div class="row mb-3">
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">이름</label>
                                    <div class="col-lg-3">
                                        <span></span>
                                    </div>
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">E-Mail</label>
                                    <div class="col-lg-3">
                                        <span></span>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">연락처</label>
                                    <div class="col-lg-3">
                                        <span></span>
                                    </div>
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">휴대전화</label>
                                    <div class="col-lg-3">
                                        <span></span>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">주소</label>
                                    <div class="col-lg-3">
                                        <span></span>
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
                        <!-- //2.옵션 Tab -->

                        <!-- 프로모션 정보 -->
                        <h3>배송정보</h3>
                        <section>
                            <div class="float-right mb-3">
                                <button type="button" class="btn btn-info btn-sm" >배송정보 저장</button>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group row">
                                    <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">택배사</label>
                                    <div class="col-sm-4 pl-0 pr-0">
                                     <span id="deliveryNameSel"></span>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">배송상태</label>
                                    <div class="col-sm-4 pl-0 pr-0">
                                        <span id="deliveryStatusSel"></span>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">배송시작 일자</label>
                                    <span></span>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">배송완료 일자</label>
                                    <span></span>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">송장번호</label>
                                    <input type="text" class="col-sm-6 form-control" style="display: inline-block;">
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">배송추적</label>
                                    <button type="button" class="btn btn-info btn-sm">배송추적</button>
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
                    <div style=" display:inline;">
                        <div style=" float: left; width: 10%">
                            <span id="l_productSearch"></span>
                        </div>
                        <div style=" float: left; width: 33%">
                            <input type="text" class="form-control" id="productSearchType" onkeypress="if(event.keyCode==13) {fn_search('new'); return false;}">
                        </div>
                        <div style=" float: left; width: 33%">
                            <button type="button" class="btn btn-outline-info mx-auto" onclick="fn_search('new')">검색</button>
                        </div>
                    </div>
                    <div class="table-responsive">
                        <input type="hidden" id="sPage" >
                        <table id="zero_config" class="table table-hover text-center">
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
