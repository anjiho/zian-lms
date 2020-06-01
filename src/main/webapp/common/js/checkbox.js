function getBookMainCheckbox(resKey) {
    var bookMainCheckbox = "";
    bookMainCheckbox     += " <div class='col-sm-10'>";
    bookMainCheckbox     += " <div style=\"margin-top: -23px;\">";
    bookMainCheckbox     += "부교재";
    bookMainCheckbox     += " <label class=\"switch\">";
    bookMainCheckbox     += " <input type='checkbox' id='isBookMain_"+ resKey + "' style='display:none;' >";
    bookMainCheckbox     += "<span class=\"slider\" ></span>";
    bookMainCheckbox     += "</label>";
    bookMainCheckbox     += "주교재";
    bookMainCheckbox     += "  </div>";
    bookMainCheckbox     += "</div>";
    return bookMainCheckbox;
}


/* 주문관리 - 주문/결제취소목록 - 처리상태  */
function orderPayStatusTypeCheckbox(tagId, val) {

    var html ="";
    var tid=JSON.stringify(tagId);

    if(val == '-1'||val=='') html += "<label>전체</label><input type='checkbox' id='check1' name='checkbox' value='-1'  checked onclick='allBoxChecked(" + tid + ")'>";
    else html += "<label>전체</label><input type='checkbox' id='check1' name='checkbox' value='-1' onclick='allBoxChecked(" + tid + ")'>";
    if(val == '8') html += "<label>결제취소</label><input type='checkbox' id='check2' name='checkbox' value='8' checked onclick='boxChecked(" + tid + ")'>";
    else html += "<label>결제취소</label><input type='checkbox' id='check2' name='checkbox' value='8' onclick='boxChecked(" + tid + ")'>";
    if(val == '9') html += "<label>주문취소</label><input type='checkbox' id='check3' name='checkbox' value='9' checked onclick='boxChecked(" + tid + ")'>";
    else html += "<label>주문취소</label><input type='checkbox' id='check3' name='checkbox' value='9' onclick='boxChecked(" + tid + ")'>";
    if(val == '10') html += "<label>결제실패</label><input type='checkbox' id='check4' name='checkbox' value='10' checked onclick='boxChecked(" + tid + ")'>";
    else html += "<label>결제실패</label><input type='checkbox' id='check4' name='checkbox' value='10' onclick='boxChecked(" + tid + ")'>";

    innerHTML(tagId, html);
}


/* 주문관리 - 주문/결제취소목록 - 구매장소  */
function isOfflineCheckbox(tagId, val) {

    var html = "";
    var tid=JSON.stringify(tagId);

    if(val == '-1'||val=='') html += "<label>전체</label><input type='checkbox' id='check1' name='checkbox' value='-1' checked onclick='allBoxChecked(" + tid + ")'>";
    else html += "<label>전체</label><input type='checkbox' id='check1' name='checkbox' value='-1' onclick='allBoxChecked(" + tid + ")'>";
    if(val == '0') html += "<label>온라인</label><input type='checkbox' id='check2' name='checkbox' value='0' checked onclick='boxChecked(" + tid + ")'>";
    else html += "<label>온라인</label><input type='checkbox' id='check2' name='checkbox' value='0' onclick='boxChecked(" + tid + ")'>";
    if(val == '1') html += "<label>오프라인</label><input type='checkbox' id='check3' name='checkbox' value='1' checked onclick='boxChecked(" + tid + ")'>";
    else html += "<label>오프라인</label><input type='checkbox' id='check3' name='checkbox' value='1' onclick='boxChecked(" + tid + ")'>";

    innerHTML(tagId, html);
}



/* 주문관리 - 주문/결제취소목록 - 디바이스  */
function deviceCheckbox(tagId, val) {

    var html = "";
    var tid=JSON.stringify(tagId);

    if(val == '-1'||val=='') html += "<label>전체</label><input type='checkbox' id='check1' name='checkbox' value='-1' checked onclick='allBoxChecked(" + tid + ")'>";
    else html += "<label>전체</label><input type='checkbox' id='check1' name='checkbox' value='-1' onclick='allBoxChecked(" + tid + ")'>";
    if(val == '0') html += "<label>PC</label><input type='checkbox' id='check2' name='checkbox' value='0' checked onclick='boxChecked(" + tid + ")'>";
    else html += "<label>PC</label><input type='checkbox' id='check2' name='checkbox' value='0' onclick='boxChecked(" + tid + ")'>";
    if(val == '1') html += "<label>Mobile</label><input type='checkbox' id='check3' name='checkbox' value='1' checked onclick='boxChecked(" + tid + ")'>";
    else html += "<label>Mobile</label><input type='checkbox' id='check3' name='checkbox' value='1' onclick='boxChecked(" + tid + ")'>";

    innerHTML(tagId, html);
}


/* 주문관리 - 주문/결제취소목록 - 결제방법  */
function orderPayTypeCheckbox(tagId, val) {

    var html = "";
    var tid=JSON.stringify(tagId);

    if(val == '-1'||val=='') html += "<label>전체</label><input type='checkbox' id='check1' name='checkbox' value='-1' checked onclick='allBoxChecked(" + tid + ")'>";
    else html += "<label>전체</label><input type='checkbox' id='check1' name='checkbox' value='-1' onclick='allBoxChecked(" + tid + ")'>";
    if(val == '0') html += "<label>신용카드</lbel><input type='checkbox' id='check2' name='checkbox' value='0' checked onclick='boxChecked(" + tid + ")'>";
    else html += "<label>신용카드</label><input type='checkbox' id='check2' name='checkbox' value='0' onclick='boxChecked(" + tid + ")'>";
    if(val == '19') html += "<label>무통장입금</label><input type='checkbox' id='check3' name='checkbox' value='19' checked onclick='boxChecked(" + tid + ")'>";
    else html += "<label>무통장입금</label><input type='checkbox' id='check3' name='checkbox' value='19' onclick='boxChecked(" + tid + ")'>";
    if(val == '20') html += "<label>무료</label><input type='checkbox' value='20' id='check4' name='checkbox' checked onclick='boxChecked(" + tid + ")'>";
    else html += "<label>무료</label><input type='checkbox' value='20' id='check4' name='checkbox' onclick='boxChecked(" + tid + ")'>";
    if(val == '21') html += "<label>현금</label><input type='checkbox' id='check5' name='checkbox' value='21' checked onclick='boxChecked(" + tid + ")'>";
    else html += "<label>현금</label><input type='checkbox' id='check5' name='checkbox' value='21' onclick='boxChecked(" + tid + ")'>";
    if(val == '22') html += "<label>현금+신용카드</label><input type='checkbox' id='check6' name='checkbox' value='22' checked onclick='boxChecked(" + tid + ")'>";
    else html += "<label>현금+신용카드</label><input type='checkbox' id='check6' name='checkbox' value='22' onclick='boxChecked(" + tid + ")'>";
    if(val == '23') html += "<label>온라인</label><input type='checkbox' id='check7' name='checkbox' value='23' checked onclick='boxChecked(" + tid + ")'>";
    else html += "<label>온라인</label><input type='checkbox' id='check7' name='checkbox' value='23' onclick='boxChecked(" + tid + ")'>";

    innerHTML(tagId, html);
}



//수강내역목록 - 진행상태 체크박스
function getlectureWatchOrderStatusCheckbox(tagId, val) {

    var html = "";
    var tid=JSON.stringify(tagId);

    if(val == '-1'||val=='') html += "<label>전체</label><input type='checkbox' value='-1' id='check1' name='orderStatus' checked onclick='allBoxChecked(" + tid + ")'>";
    else html += "<label>전체</label><input type='checkbox' value='-1' id='check1' name='orderStatus' onclick='allBoxChecked(" + tid + ")'>";
    if(val == '0') html += "<label>대기중</label><input type='checkbox' value='0' id='check2' name='orderStatus' checked onclick='boxChecked(" + tid + ")'>";
    else html += "<label>대기중</label><input type='checkbox' value='0' id='check2' name='orderStatus' onclick='boxChecked(" + tid + ")'>";
    if(val == '1') html += "<label>시작</label><input type='checkbox' value='1' id='check3' name='orderStatus' checked onclick='boxChecked(" + tid + ")'>";
    else html += "<label>시작</label><input type='checkbox' value='1' id='check3' name='orderStatus' onclick='boxChecked(" + tid + ")'>";
    if(val == '2') html += "<label>일시정지</label><input type='checkbox' value='2' id='check4' name='orderStatus' checked onclick='boxChecked(" + tid + ")'>";
    else html += "<label>일시정지</label><input type='checkbox' value='2' id='check4' name='orderStatus' onclick='boxChecked(" + tid + ")'>";
    if(val == '3') html += "<label>종강</label><input type='checkbox' value='3' id='check5' name='orderStatus' checked onclick='boxChecked(" + tid + ")'>";
    else html += "<label>종강</label><input type='checkbox' value='3' id='check5' name='orderStatus' onclick='boxChecked(" + tid + ")'>";
    if(val == '4') html += "<label>재시작대기</label><input type='checkbox' value='4' id='check6' name='orderStatus' checked onclick='boxChecked(" + tid + ")'>";
    else html += "<label>재시작대기</label><input type='checkbox' value='4' id='check6' name='orderStatus' onclick='boxChecked(" + tid + ")'>";

    innerHTML(tagId, html);
}