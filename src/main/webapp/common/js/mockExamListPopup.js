/**
 * 전범위 모의고사, 기출문제 회차별 팝업 리스트불러오기
 */
function fn_search(val, type) {
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
            if (selList.length > 0) {
                for (var i = 0; i < selList.length; i++) {
                    var cmpList = selList[i];
                    var acceptDateHtml = "<td style='vertical-align:middle'>"+split_minute_getDay(cmpList.acceptStartDate)+" "+split_minute_getDay(cmpList.acceptEndDate)+"</td>";
                    var onlineDateHtml = "<td style='vertical-align:middle'>"+split_minute_getDay(cmpList.onlineStartDate)+" "+split_minute_getDay(cmpList.onlineEndDate)+"</td>";
                    var onlineTimeHtml = cmpList.onlineTime+'분';
                    var lectureSelBtn = '<button type="button" onclick="sendChildValue('+cmpList.examKey+","+ "'" + type+ "'" + ')"  class="btn btn-outline-info mx-auto">선택</button>';
                    if (cmpList != undefined) {
                        var cellData = [
                            function(data) {return cmpList.name;},
                            function(data) {return acceptDateHtml;},
                            function(data) {return onlineDateHtml;},
                            function(data) {return onlineTimeHtml;},
                            function(data) {return lectureSelBtn;}
                        ];
                        dwr.util.addRows("dataList", [0], cellData, {escapeHtml: false});
                    }
                }
            }else{
                gfn_emptyView("V", comment.blank_list2);
            }
        });
    });
}

// 전범위 모의고사 / 기출문제 선택시 값전달
function sendChildValue(examKey, set) {
    productManageService.getMockExamInfo(examKey, function (selList) {
        var allMockCnt = $("#allMockList tr").length-1; //모의고사
        var examQuestionListCnt = $("#examQuestionList tr").length-1;//기출문제

        var deleteSel = "";
        var getallMockOption = "";
        if(set == 'mockBtn'){
            getallMockOption = "MockName_"+allMockCnt;
            deleteSel = "allMockTitleDelete";
        }else if(set == 'examBtn'){
            getallMockOption = "examName_"+examQuestionListCnt;
            deleteSel = "examQuestionDelete";
        }

        if (selList.mokExamInfo) {
            var title =  selList.mokExamInfo.name;
            var MockListHtml = "<tr scope='col' colspan='3'>";
            MockListHtml     += "<td>";
            //MockListHtml     += "<span id='"+getallMockOption+"'></span>";
            MockListHtml     += "<input type='text'  id='"+getallMockOption+"' value='' class=\"form-control\" readonly>";
            MockListHtml     += "</td>";//examKey
            MockListHtml     += "<td>";
            MockListHtml     += "<button type=\"button\" class=\"btn btn-outline-danger btn-sm\" onclick=deleteTableRow("+"'"+deleteSel+"'"+")>삭제</button>";
            MockListHtml     += "</td>";
            MockListHtml     += "<td>";
            MockListHtml     += "<input type='hidden'  value='"+selList.mokExamInfo.examKey+"' name='res_key[]' >";
            MockListHtml     += "</td>";//examKey
            MockListHtml     += "</tr>";

            if(set == 'mockBtn'){ //전범위 모의고사
                $('#allMockList > tbody:first').append(MockListHtml);//선택 모의고사 리스트 뿌리기
                $("#"+getallMockOption).val(title);//모의고사 제목 뿌리기
            }else if(set == 'examBtn'){ //기출문제
                $('#examQuestionList > tbody:first').append(MockListHtml);//선택 기출문제 리스트 뿌리기
                $("#"+getallMockOption).val(title);//기출문제 제목 뿌리기
            }

            if(set == 'mockBtn'){
                $('#allMockList tr').each(function(){
                    var tr = $(this);
                    tr.children().eq(2).attr("style", "display:none");
                });
            }else if(set == 'examBtn'){
                $('#examQuestionList tr').each(function(){
                    var tr = $(this);
                    tr.children().eq(2).attr("style", "display:none");
                });
            }

        }
    });
}
