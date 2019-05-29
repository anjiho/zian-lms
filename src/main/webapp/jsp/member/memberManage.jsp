<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<%
    String popupKey = request.getParameter("param_key");
%>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/popupCouponManageService.js'></script>
<script type='text/javascript' src='/dwr/interface/dataManageService.js'></script>
<script type='text/javascript' src='/dwr/interface/productManageService.js'></script>
<script>
    var popupKey = '<%=popupKey%>';
    $( document ).ready(function() {
        $('textarea[name=contents]').summernote({ //기본정보-에디터
            height: 250,
            minHeight: null,
            maxHeight: null,
            focus: false,
            lang: 'ko-KR',
            placeholder: '내용을 적어주세요.'
            ,hint: {
                match: /:([\-+\w]+)$/,
                search: function (keyword, callback) {
                    callback($.grep(emojis, function (item) {
                        return item.indexOf(keyword) === 0;
                    }));
                },
                template: function (item) {
                    var content = emojiUrls[item];
                    return '<img src="' + content + '" width="20" /> :' + item + ':';
                },
                content: function (item) {
                    var url = emojiUrls[item];
                    if (url) {
                        return $('<img />').attr('src', url).css('width', 20)[0];
                    }
                    return '';
                }
            },
            popover: {
                image: [],
                link: [],
                air: []
            }
        });

        //탭 메뉴 색상 변경
        $("#playForm ul").each(function(idx) {
            var ul = $(this);
            ul.find("li").addClass("done").attr("aria-selected", "false");
            ul.find("li").eq(0).removeClass("done").attr("aria-selected", "true");
        });
    });

    function init() {
        menuActive('menu-5', 1);

        /* 패키시상품 정보 가져오기 */
        popupCouponManageService.getPopupDetailInfo(popupKey, function(info) {

        });

    }

    function deleteCategory(linkKey){
        if(confirm("삭제하시겠습니까?")) {
            productManageService.deleteVideoOtherInfo(linkKey, 'TLINK',function () {isReloadPage();});
        }
    }

    function popupSave() {
        var basicObj = getJsonObjectFromDiv("section1");

        if (basicObj.isShow == 'on') basicObj.isShow = '1';//노출 checkbox
        else basicObj.isShow = '0';

        basicObj.startDate = basicObj.startDate+" "+$('select[name=timeHour]').eq(0).val()+":"+$('select[name=timeMinute]').eq(0).val()+":"+"00";
        basicObj.endDate   = basicObj.endDate+" "+$('select[name=timeHour]').eq(1).val()+":"+$('select[name=timeMinute]').eq(1).val()+":"+"00";

        var categoryArr = new Array();
        $('#categoryTable tbody tr').each(function (index) {
            //alert($(this).find("td select").eq(3).val());
            if($(this).find("td").eq(0).html() == ""){
                var ctgKey = $(this).find("td select").eq(3).val();
                categoryArr.push(ctgKey);
            }
        });
        if(confirm("수정 하시겠습니까?")) {
            popupCouponManageService.updatePopupCategoryInfo(popupKey, categoryArr, function () {});
            popupCouponManageService.updatePopupInfo(basicObj, function () {isReloadPage(true);});
        }
    }
    
    function addconsultMemo() {
        
    }

</script>
<div class="page-breadcrumb">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">회원정보</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">회원 관리</li>
                        <li class="breadcrumb-item active" aria-current="page">회원정보</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</div>
<!--//순서-->

<!-- 기본 소스-->
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
                        <h3>회원 기본정보</h3>
                        <section class="col-md-auto">
                            <div id="section1">
                                <input type="hidden" name="popupKey" value="<%=popupKey%>">
                                <input type="hidden" name="cKey" value="0">
                                <input type="hidden" name="type" value="0">
                                <div class="col-md-12">
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">유저 코드</label>
                                        <span id="userKey"></span>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">아이디</label>
                                        <span id="userId"></span>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">이름</label>
                                        <span id="userName"></span>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">비밀번호</label>
                                        <span id="userPassword"></span>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">권한</label>
                                        <span id=""></span>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">관리자권한등급</label>
                                        <span id=""></span>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">등록일</label>
                                        <span id=""></span>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">생년월일</label>
                                        <span id=""></span>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">음력 / 성별</label>
                                        <span id=""></span>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">전화번호</label>
                                        <span id=""></span>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">휴대전화번호</label>
                                        <span id=""></span>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">E-mail</label>
                                        <span id=""></span>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">E-mail 수신여부</label>
                                        <span id=""></span>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">SMS 수신여부</label>
                                        <span id=""></span>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">주소</label>
                                        <span id=""></span>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">복지할인율</label>
                                        <span id=""></span>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">준비직렬</label>
                                        <span id=""></span>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">가입경로</label>
                                        <span id=""></span>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">등급</label>
                                        <span id=""></span>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">등급변경일</label>
                                        <span id=""></span>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">등급세부항목</label>
                                        <span id=""></span>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">등급가격</label>
                                        <span id=""></span>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">비고</label>
                                        <span id=""></span>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">인증키</label>
                                        <span id=""></span>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">가입디바이스종류</label>
                                        <span id=""></span>
                                    </div>
                                </div>
                            </div>
                        </section>
                        <!-- // 1.기본정보 Tab -->
                        <!-- 3.카테고리 목록 Tab -->
                        <h3>상담내역</h3>
                        <section>
                            <div class="float-right mb-3">
                                <button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#consultModal">상담내용 추가</button>
                            </div>
                            <div id="section3">
                                <table class="table table-hover text-center">
                                    <thead>
                                    <tr>
                                        <th scope="col" style="width: 5%;">상담번호</th>
                                        <th scope="col" style="width: 5%;">상담구분</th>
                                        <th scope="col" style="width: 45%;">연락처</th>
                                        <th scope="col" style="width: 10%;">접수일</th>
                                        <th scope="col" style="width: 5%;">처리시작일</th>
                                        <th scope="col" style="width: 5%;">완료일</th>
                                    </tr>
                                    </thead>
                                    <tbody id="dataList"></tbody>
                                    <tr>
                                        <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
                                    </tr>
                                </table>
                                <%@ include file="/common/inc/com_pageNavi.inc" %>
                            </div>
                        </section>
                        <!-- //3.카테고리 목록 Tab -->
                    </div>
                </div>
            </div>
        </div>
        <!-- //div.card -->
    </div>
</form><!-- // 기본소스-->

<!-- 출판사 팝업창-->
<div class="modal fade" id="consultModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document" style="max-width: 980px;">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">상담</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form>
                <!-- modal body -->
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group row">
                                <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">상담코드</label>
                                <div class="col-sm-6 pl-0 pr-0">
                                    <span id="consultCode"></span>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">상담구분</label>
                                <div class="col-sm-6 pl-0 pr-0">
                                    <span id="consultGbn"></span>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-sm-3 control-label col-form-label" style="margin-bottom: 0">회원아이디</label>
                                <div class="col-sm-6 pl-0 pr-0">
                                    <span id=""></span>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">전화번호</label>
                                <div class="col-sm-6 pl-0 pr-0">
                                    <span id=""></span>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">접수일</label>
                                <div class="col-sm-6 pl-0 pr-0">
                                    <span id=""></span>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">완료일</label>
                                <div class="col-sm-6 pl-0 pr-0">
                                    <span id=""></span>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <!--<div class="form-group row">
                                <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">노출날짜</label>
                                <div class="col-sm-6 input-group pl-0 pr-0">
                                    <input type="text" class="form-control mydatepicker" placeholder="yyyy-mm-dd" name="dspDate" id="dspDate">
                                    <div class="input-group-append">
                                        <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                    </div>
                                    <span style="display: block;padding-top:5px">암기노트등, 출력날짜가 필요할때만 사용</span>
                                </div>
                            </div>-->
                                <div class="form-group row">
                                    <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">작성자</label>
                                    <div class="col-sm-6 pl-0 pr-0">
                                        <span id=""></span>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">진행상태</label>

                                    <div class="col-sm-6 pl-0 pr-0">
                                        <span id=""></span>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">회원이름</label>
                                    <span id=""></span>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-4 control-label col-form-label" style="margin-bottom: 0">휴대전화번호</label>
                                    <div class="col-sm-6 pl-0 pr-0">
                                        <span id=""></span>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-4 control-label col-form-label" style="margin-bottom: 0">처리시작일</label>
                                    <div class="col-sm-6 pl-0 pr-0">
                                        <span id=""></span>
                                    </div>
                                </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">메모</label>
                        <input type="text" class="col-sm-6 form-control" style="display: inline-block;height: 100px;" id="answer1Reason" name="answer1Reason">
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">내용</label>
                        <input type="text" class="col-sm-6 form-control" style="display: inline-block;height: 100px;" id="answer2Reason" name="answer2Reason">
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">첨부 이미지1</label>
                        <div class="col-sm-6 pl-0 pr-0">
                            <div class="custom-file">
                                <input type="file" class="custom-file-input" id="questionImage"  name="questionImage" required>
                                <span class="custom-file-control custom-file-label"></span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">첨부 이미지2</label>
                        <div class="col-sm-6 pl-0 pr-0">
                            <div class="custom-file">
                                <input type="file" class="custom-file-input addFile" id="commentaryImage" name="commentaryImage" required>
                                <span class="custom-file-control1 custom-file-label"></span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">첨부 이미지3</label>
                        <div class="col-sm-6 pl-0 pr-0">
                            <div class="custom-file">
                                <input type="file" class="custom-file-input addFile" id="commentaryImage" name="commentaryImage" required>
                                <span class="custom-file-control1 custom-file-label"></span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">첨부 이미지4</label>
                        <div class="col-sm-6 pl-0 pr-0">
                            <div class="custom-file">
                                <input type="file" class="custom-file-input addFile" id="commentaryImage" name="commentaryImage" required>
                                <span class="custom-file-control1 custom-file-label"></span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">첨부 이미지5</label>
                        <div class="col-sm-6 pl-0 pr-0">
                            <div class="custom-file">
                                <input type="file" class="custom-file-input addFile" id="commentaryImage" name="commentaryImage" required>
                                <span class="custom-file-control1 custom-file-label"></span>
                            </div>
                        </div>
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
            popupSave();
        },
    });

    $('#startDate').datepicker({
        format: "yyyy-mm-dd",
        language: "kr"
    });
    $('#endDate').datepicker({
        format: "yyyy-mm-dd",
        language: "kr"
    });
</script>

<%@include file="/common/jsp/footer.jsp" %>
