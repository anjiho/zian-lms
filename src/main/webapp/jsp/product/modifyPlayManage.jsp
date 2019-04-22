<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<%
    String gKey = request.getParameter("gKey");
%>
<script src='https://code.jquery.com/ui/1.11.4/jquery-ui.min.js'></script>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/productManageService.js'></script>
<script type='text/javascript' src='/dwr/interface/selectboxService.js'></script>
<script>
    var gKey = '<%=gKey%>';
    $( document ).ready(function() {
        //getSelectboxListForCtgKey("SubjectList_0","70");//과목 셀렉트박스
        //selectTeacherSelectbox("teacherList_0","");//선생님 셀렉트박스
        playDetailList();//정보불러오기
        getCategoryList("sel_0",214);
        $('#description').summernote({ //기본정보-에디터
            width: 750,
            height: 300,
            focus: true,
            theme: 'cerulean'
        });
    });

    //파일 선택시 파일명 보이게 하기
    $(document).on('change', '.custom-file-input', function() {
        $(this).parent().find('.custom-file-control').html($(this).val().replace(/C:\\fakepath\\/i, ''));
    });
    $(document).on('change', '.dataAddFile', function() {
        $(this).parent().find('.custom-file-control2').html($(this).val().replace(/C:\\fakepath\\/i, ''));
    });

    $(document).on('change', '.addFile', function() {
        $(this).parent().find('.custom-file-control1').html($(this).val().replace(/C:\\fakepath\\/i, ''));
    });

    function changesel(id, val){ //카테고리 셀렉트박스 불러오기
        getCategoryList(id, val);
    }

    function optionDelete(val) { //단일 삭제
        if(val == 'optionDelete'){
            $('#optionTable > tbody:last > tr:last').remove();
        }else if(val == 'allMockTitleDelete'){
            $('#allMockList > tbody:last > tr:last').remove();
        }else if(val == 'examQuestionDelete'){
            $('#examQuestionList > tbody:last > tr:last').remove();
        }else if(val == 'setOptionDelete'){
            $('#optionTable > tbody:last > tr:last').remove();
        }else if(val == 'bookTitleDelete'){
            $('#bookList > tbody:last > tr:last').remove();
        }else if(val == 'teacherDelete'){
            $('#teacherTabel > tbody:last > tr:last').remove();
        }else if(val == 'categoryDelete'){
            $('#categoryTable > tbody:last > tr:last').remove();
        }else if(val == 'giftDelete'){
            $('#giftList > tbody:last > tr:last').remove();
        }
    }

    function addOption(val){ //옵션명 추가
        if(val == 'new'){//옵션새로추가
            var optionCnt = $("#optionTable tr").length-1;
            AddOptionCnt(optionCnt);
        }else{//기존옵션 배열
            var optionCnt =  val-1;
            for(var i = 0; i < optionCnt; i++){
                AddOptionCnt(i+1);
            }
        }
    }

    function AddOptionCnt(val) {
        var optionCnt = val;
        var getOption = "kind_"+optionCnt;
        getVideoOptionTypeList(getOption, "");
        var optionHtml = "<tr>";
        optionHtml += "<td style=\"padding: 0.3rem;text-align: center;\">";
        optionHtml += "<select class=\"select2 form-control custom-select\" style=\"height:36px;\"  id='kind_"+optionCnt+"'  name='kind_"+optionCnt+"'>";
        optionHtml += "<option>선택</option>";
        optionHtml += "</select>";
        optionHtml += "</td>";
        optionHtml += "<td style=\"padding: 0.3rem;\">";
        optionHtml += "<input type=\"number\" class=\"form-control\" id='price_"+optionCnt+"'  name='price_"+optionCnt+"'>";
        optionHtml += "</td>";
        optionHtml += "<td style=\"padding: 0.3rem;\">";
        optionHtml += "<input type=\"number\" class=\"form-control\"  id='sellPrice_"+optionCnt+"'  name='sellPrice_"+optionCnt+"'>";
        optionHtml += "</td>";
        optionHtml += " <td style=\"padding: 0.3rem;\">";
        optionHtml += "<input type=\"text\" class=\"form-control\" id='point_"+optionCnt+"'  name='point_"+optionCnt+"'>";
        optionHtml += "</td>";
        optionHtml += " <td style=\"padding: 0.3rem;\">";
        optionHtml += "<input type=\"number\" style=\"display: inline-block\" class=\"form-control\" id='extendPercent_"+optionCnt+"'  name='extendPercent_"+optionCnt+"' onchange='saleInputPrice(this.value"+","+optionCnt+")' >";
        optionHtml += "</td>";
        optionHtml += "<td style=\"padding: 0.3rem;\">";
        optionHtml += "<input type=\"number\" class=\"form-control\" id='resultPrice_"+optionCnt+"'  readonly>";
        optionHtml += "</td>";
        optionHtml += " <td style=\"padding: 0.3rem;\">";
        optionHtml += "<button type=\"button\" onclick=\"optionDelete('setOptionDelete')\" class='btn btn-outline-danger btn-sm' style=\"margin-top:8%;\">삭제</button>";
        optionHtml += "</a>";
        optionHtml += "</td>";
        optionHtml += "</tr>";
        $('#optionTable > tbody:first').append(optionHtml);
    }



    function addTeacher(val){ //강사 추가
        if(val == 'new'){
            var optionCnt = $("#teacherTabel tr").length-1;
            addTeacherCnt(optionCnt,"new");
        }else{
            var optionCnt =  val-1;
            for(var i = 0; i < optionCnt; i++){
                addTeacherCnt(i+1,"old");
            }
        }
    }

    // function addTeacherCnt(val, option) {
    //     var optionCnt = val;
    //     var SubjectCnt = "SubjectList_"+optionCnt;
    //     var teacherCnt = "teacherList_"+optionCnt;
    //     var deleteSel = "teacherDelete";
    //     getSelectboxListForCtgKey(SubjectCnt,"70");//과목 셀렉트박스
    //     selectTeacherSelectbox(teacherCnt,"");//선생님 셀렉트박스
    //     var optionHtml  = "<tr>";
    //     optionHtml  += "<input type=\"hidden\" class=\"form-control\" id='GTeacherKey_"+optionCnt+"' name='GTeacherKey_"+optionCnt+"'>";
    //     optionHtml  += "<input type=\"hidden\" class=\"form-control\" id='subjectHidden_"+optionCnt+"' name='subjectHidden_"+optionCnt+"'>";
    //     optionHtml  += "<input type=\"hidden\" class=\"form-control\" id='teacherHidden_"+optionCnt+"' name='teacherHidden_"+optionCnt+"'>";
    //     optionHtml  += "<td style=\"padding: 0.3rem;text-align: center;width: 20%;vertical-align: middle\">";
    //    if(option == 'new'){
    //     optionHtml  += "<select class=\"select2 form-control custom-select\" style=\"height:36px;\" id='SubjectList_"+optionCnt+"'>";
    //     optionHtml  += "<option>선택</option>";
    //     optionHtml  += "</select>";
    //    }else{
    //    optionHtml  += "<input type='text' id='SubjectList_"+optionCnt+"' class='form-control' readonly>";
    //    }
    //     optionHtml  += "</td>";
    //     optionHtml  += "<td style=\"padding: 0.3rem; vertical-align: middle;width:2%;text-align: center;\">";
    //     optionHtml  += "<i class=\"m-r-10 mdi mdi-play\" style=\"font-size:18px;color:darkblue\"></i>";
    //     optionHtml  += "</td>";
    //     optionHtml  += "<td style=\"padding: 0.3rem;text-align: center;width: 20%;vertical-align: middle\">";
    //     if(option == 'new'){
    //     optionHtml += "<select class=\"select2 form-control custom-select\" style=\"height:36px;\" id='teacherList_" + optionCnt + "'>";
    //     optionHtml += " <option>선택</option>";
    //     optionHtml += "</select>";
    //     }else{
    //         optionHtml  += "<input type='text' id='teacherList_" + optionCnt + "' class='form-control' readonly>";
    //     }
    //     optionHtml  += "</td>";
    //     optionHtml  += "<td style=\"padding: 0.3rem;width:60%;text-align:right;vertical-align: middle\">";
    //     if(option == 'new'){
    //     optionHtml += "<label style=\"display: inline-block\">조건 : </label>";
    //     optionHtml += "<input type=\"text\" class=\"form-control\" style=\"display: inline-block;width:60%\" id='calculateRate_" + optionCnt + "' name='calculateRate_" + optionCnt + "'> %";
    //     }else{
    //         optionHtml += "<label style=\"display: inline-block\">조건 : </label>";
    //         optionHtml += "<input type=\"text\" class=\"form-control\" style=\"display: inline-block;width:60%\" id='calculateRate_" + optionCnt + "' name='calculateRate_" + optionCnt + "' readonly> %";
    //     }
    //     optionHtml  += "</td>";
    //     optionHtml  += "<td style=\"width:3%;vertical-align: middle\">";
    //     optionHtml     += "<button type=\"button\" class=\"btn btn-outline-danger btn-sm\" onclick=optionDelete("+"'"+deleteSel+"'"+")>삭제</button>";
    //     optionHtml  += "</td>";
    //     optionHtml  += "</tr>";
    //     $('#teacherTabel > tbody:first').append(optionHtml);
    // }

    //전범위 모의고사 리스트불러오기
    function fn_search(val) {
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
                        var text = "'mockBtn'";
                        var lectureSelBtn = '<button type="button" onclick="sendChildValue('+cmpList.examKey+","+text+')"  class="btn btn-outline-info mx-auto">선택</button>';
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

    //기출문제 리스트 불러오기
    function fn_search2(val) {
        var paging = new Paging();
        var sPage = $("#sPage2").val();
        var searchType = getSelectboxValue("examsearchType");
        var searchText = getInputTextValue("examsearchType");

        if(val == "new") sPage = "1";
        if (searchType == undefined) searchType = "";
        if (searchText == undefined) searchText = "";

        dwr.util.removeAllRows("dataList2");
        gfn_emptyView2("H", "");//페이징 예외사항처리

        productManageService.getMockExamListCount(searchType, searchText, function(cnt) {
            paging.count2(sPage, cnt, '10', '10', comment.blank_list);
            var listNum = ((cnt-1)+1)-((sPage-1)*10); //리스트 넘버링
            productManageService.getMockExamList(sPage, '10',searchType, searchText, function (selList) {
                if (selList.length > 0) {
                    for (var i = 0; i < selList.length; i++) {
                        var cmpList = selList[i];
                        var acceptDateHtml = "<td style='vertical-align:middle'>"+split_minute_getDay(cmpList.acceptStartDate)+" "+split_minute_getDay(cmpList.acceptEndDate)+"</td>";
                        var onlineDateHtml = "<td style='vertical-align:middle'>"+split_minute_getDay(cmpList.onlineStartDate)+" "+split_minute_getDay(cmpList.onlineEndDate)+"</td>";
                        var onlineTimeHtml = cmpList.onlineTime+'분';
                        var text = "'examBtn'";
                        var lectureSelBtn = '<button type="button" onclick="sendChildValue('+cmpList.examKey+","+text+')"    class="btn btn-outline-info mx-auto">선택</button>';
                        if (cmpList != undefined) {
                            var cellData = [
                                function(data) {return cmpList.name;},
                                function(data) {return acceptDateHtml;},
                                function(data) {return onlineDateHtml;},
                                function(data) {return onlineTimeHtml;},
                                function(data) {return lectureSelBtn;}
                            ];
                            dwr.util.addRows("dataList2", [0], cellData, {escapeHtml: false});
                        }
                    }
                }else{
                    gfn_emptyView2("V", comment.blank_list2);
                }
            });
        });
    }

    //강의교재 리스트 불러오기
    function fn_search3(val) {
        var paging = new Paging();
        var sPage = $("#sPage3").val();
        var searchType = getSelectboxValue("booksearchType");
        var searchText = getInputTextValue("booksearchType");

        if(val == "new") {
            sPage = "1";
        }
        if (searchType == undefined) {
            searchType = "";
        }
        if (searchText == undefined) {
            searchText = "";
        }

        dwr.util.removeAllRows("dataList3");
        gfn_emptyView3("H", "");//페이징 예외사항처리
        productManageService.getProductListCount(searchType, searchText, 'BOOK', function(cnt) {
            paging.count3(sPage, cnt, '10', '10', comment.blank_list);
            var listNum = ((cnt-1)+1)-((sPage-1)*10); //리스트 넘버링
            productManageService.getProductList(sPage, '10',searchType, searchText, 'BOOK', function (selList) {
                if (selList.length > 0) {
                    for (var i = 0; i < selList.length; i++) {
                        var cmpList = selList[i];
                        var text = "'bookBtn'";
                        var bookSelBtn = '<button type="button" onclick="sendChildValue_2('+cmpList.GKey+","+text+')"  class="btn btn-outline-info mx-auto">선택</button>';
                        if (cmpList != undefined) {
                            var cellData = [
                                function(data) {return cmpList.goodsName;},
                                function(data) {return cmpList.isShow;},
                                function(data) {return cmpList.isSell;},
                                function(data) {return cmpList.isFree;},
                                function(data) {return bookSelBtn;}
                            ];
                            dwr.util.addRows("dataList3", [0], cellData, {escapeHtml: false});
                        }
                    }
                }else{
                    gfn_emptyView3("V", comment.blank_list2);
                }
            });
        });
    }


    //사은품 리스트 불러오기
    function fn_search4(val) {
        var paging = new Paging();
        var sPage = $("#sPage4").val();
        var searchType = getSelectboxValue("gifrsearchType");
        var searchText = getInputTextValue("giftsearchType");

        if(val == "new") {
            sPage = "1";
        }
        if (searchType == undefined) {
            searchType = "";
        }
        if (searchText == undefined) {
            searchText = "";
        }

        dwr.util.removeAllRows("dataList4");
        gfn_emptyView4("H", "");//페이징 예외사항처리
        productManageService.getProductListCount(searchType, searchText, 'BOOK', function(cnt) {
            paging.count4(sPage, cnt, '10', '10', comment.blank_list);
            var listNum = ((cnt-1)+1)-((sPage-1)*10); //리스트 넘버링
            productManageService.getProductList(sPage, '10',searchType, searchText, 'BOOK', function (selList) {
                if (selList.length > 0) {
                    for (var i = 0; i < selList.length; i++) {
                        var cmpList = selList[i];
                        var text = "'giftBtn'";
                        var bookSelBtn = '<button type="button" onclick="sendChildValue_2('+cmpList.GKey+","+text+')"  class="btn btn-outline-info mx-auto">선택</button>';
                        if (cmpList != undefined) {
                            var cellData = [
                                function(data) {return cmpList.goodsName;},
                                function(data) {return cmpList.isShow;},
                                function(data) {return cmpList.isSell;},
                                function(data) {return cmpList.isFree;},
                                function(data) {return bookSelBtn;}
                            ];
                            dwr.util.addRows("dataList4", [0], cellData, {escapeHtml: false});
                        }
                    }
                }else{
                    gfn_emptyView4("V", comment.blank_list2);
                }
            });
        });
    }


    // 전범위 모의고사 / 기출문제 선택시 값전달
    function sendChildValue(examKey,set) {
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
                var MockListHtml = "<tr>";
                MockListHtml     += "<td class=\"text-left\" style=\"padding: 0.3rem;vertical-align: middle;width:95%\">";
                //MockListHtml     += "<span id='"+getallMockOption+"'></span>";
                MockListHtml     += "<input type='text'  id='"+getallMockOption+"' value='' class=\"form-control\" readonly>";
                MockListHtml     += "</td>";//examKey
                MockListHtml     += "<td>";
                MockListHtml     += "<input type='hidden'  value='"+selList.mokExamInfo.examKey+"' name='res_key[]' >";
                MockListHtml     += "</td>";//examKey
                MockListHtml     += "<td class=\"text-left\" style=\"padding:0.3rem;vertical-align:middle;\">";
                MockListHtml     += "<button type=\"button\" class=\"btn btn-outline-danger btn-sm\" onclick=optionDelete("+"'"+deleteSel+"'"+")>삭제</button>";
                MockListHtml     += "</td>";
                MockListHtml     += "</tr>";

                if(set == 'mockBtn'){ //전범위 모의고사
                    $('#allMockList > tbody:first').append(MockListHtml);//선택 모의고사 리스트 뿌리기
                    $("#"+getallMockOption).val(title);//모의고사 제목 뿌리기
                }else if(set == 'examBtn'){ //기출문제
                    $('#examQuestionList > tbody:first').append(MockListHtml);//선택 기출문제 리스트 뿌리기
                    $("#"+getallMockOption).val(title);//기출문제 제목 뿌리기
                }
                //$("#lecturePopupClose").click();
            }
        });
    }

    //강의교재 , 사은품 선택시 전달값
    function sendChildValue_2(GKey,set) {
        productManageService.getProductDetailInfo(GKey, 'BOOK', function (selList) {
            var bookkCnt = $("#bookList tr").length-1; //강의교재
            var giftCnt = $("#giftList tr").length-1;//기출문제

            var deleteSel = "";
            var bookgiftOption = "";
            if(set == 'bookBtn'){
                bookgiftOption = "bookName_"+bookkCnt;
                deleteSel = "bookTitleDelete";
            }else if(set == 'giftBtn'){
                bookgiftOption = "giftName_"+giftCnt;
                deleteSel = "giftDelete";
            }
            if (selList.productInfo) {

                var title =  selList.productInfo.name;
                var bookkListHtml = "<tr>";
                bookkListHtml     += " <td class=\"text-left\" style=\"padding:0.3rem;vertical-align: middle;width: 65%\">";
                bookkListHtml     += "<input type='text' class=\"form-control\" id='"+bookgiftOption+"' value='' readonly>";
                bookkListHtml     += "</td>";
                bookkListHtml     += " <td>";
                bookkListHtml     += "<input type='hidden'  value='"+selList.productInfo.GKey+"' name='res_key[]'>";
                bookkListHtml     += "</td>";
                if(set == 'bookBtn'){
                    bookkListHtml     += "<td class=\"text-left\" style=\"padding: 0.3rem; vertical-align: middle;width: 30%\">";
                    bookkListHtml     += " <div class='col-sm-10'>";
                    bookkListHtml     += " <div style=\"margin-top: -23px;\">";
                    bookkListHtml     += "부교재";
                    bookkListHtml     += " <label class=\"switch\">";
                    bookkListHtml     += " <input type=\"checkbox\" style=\"display:none;\">";
                    bookkListHtml     += "<span class=\"slider\"></span>";
                    bookkListHtml     += "</label>";
                    bookkListHtml     += "주교재";
                    bookkListHtml     += "  </div>";
                    bookkListHtml     += "</div>";
                    bookkListHtml     += "</td>";
                }
                bookkListHtml     += "<td class=\"text-left\" style=\"padding:0.3rem;vertical-align:middle;\">";
                bookkListHtml     += "<button type=\"button\" class=\"btn btn-outline-danger btn-sm\" onclick=optionDelete("+"'"+deleteSel+"'"+")>삭제</button>";
                bookkListHtml     += "</td>";
                bookkListHtml     += " </tr>";

                if(set == 'bookBtn'){ //전범위 모의고사
                    $('#bookList > tbody:first').append(bookkListHtml);//선택 모의고사 리스트 뿌리기
                    $("#"+bookgiftOption).val(title);//모의고사 제목 뿌리기
                }else if(set == 'giftBtn'){ //기출문제
                    $('#giftList > tbody:first').append(bookkListHtml);//선택 기출문제 리스트 뿌리기
                    $("#"+bookgiftOption).val(title);//기출문제 제목 뿌리기
                }
                //$("#lecturePopupClose").click();
            }
        });
    }

    //카테고리 리스트 추가
    function addCategory(val) {
        if(val == 'new'){//옵션새로추가
            var categoryCnt = $("#categoryTable tr").length-1;
            addCategoryCnt(categoryCnt);
        }else{//기존옵션 배열
            var categoryCnt =  val-1;
            for(var i = 0; i < categoryCnt; i++){
                addCategoryCnt(i+1);
            }
        }
    }

    //카테고리 리스트 추가
    function addCategoryCnt(val) {
        var categoryCnt = val;
        var selOption = "sel_"+categoryCnt;
        getCategoryList(selOption, 214);
        var categoryHtml = "<tr>";
        categoryHtml += "<td>";                                                                                                 //saleInputPrice(this.value"+","+optionCnt+")' >"
        categoryHtml += "<select class=\"col-sm-8 form-control custom-select\"  id='sel_"+categoryCnt+"' onchange='changesel("+'"'+'2sel_'+categoryCnt+'"'+","+"this.value)' >";
        categoryHtml += " <option>선택</option>";
        categoryHtml += " </select>";
        categoryHtml += "<td>";
        categoryHtml += " <select class=\"col-sm-8 form-control custom-select\" id='2sel_"+categoryCnt+"' onchange='changesel("+'"'+'3sel_'+categoryCnt+'"'+","+"this.value)' >";
        categoryHtml += "<option>선택</option>";
        categoryHtml += "</select>";
        categoryHtml += "</td>";
        categoryHtml += " <td>";
        categoryHtml += "<select class=\"col-sm-8 form-control custom-select\" id='3sel_"+categoryCnt+"' onchange='changesel("+'"'+'4sel_'+categoryCnt+'"'+","+"this.value)' >";
        categoryHtml += " <option>선택</option>";
        categoryHtml += " </select>";
        categoryHtml += "</td>";
        categoryHtml += "<td>";
        categoryHtml += " <select class=\"col-sm-8 form-control custom-select\"  id='4sel_"+categoryCnt+"' onchange='changesel("+'"'+'5sel_'+categoryCnt+'"'+","+"this.value)' >";
        categoryHtml += "<option>선택</option>";
        categoryHtml += " </select>";
        categoryHtml += "</td>";
        categoryHtml += "<td>";
        categoryHtml += " <select class=\"col-sm-8 form-control custom-select\"  id='5sel_"+categoryCnt+"' >";
        categoryHtml += " <option>선택</option>";
        categoryHtml += "  </select>";
        categoryHtml += " </td>";
        categoryHtml += "<td>";
        categoryHtml += "<button type=\"button\" onclick=\"optionDelete('categoryDelete')\" class='btn btn-outline-danger btn-sm' style=\"margin-top:8%;\">삭제</button>";
        categoryHtml += "</td>";
        categoryHtml += "</tr>";
        $('#categoryTable > tbody:first').append(categoryHtml);
    }

    function playDetailList() { //동영상정보
        productManageService.getProductDetailInfo(gKey, 'VIDEO', function (selList) {
            console.log(selList);
            if (selList.productInfo) {/*---기본정보---*/
                innerValue("name", selList.productInfo.name);//이름
                innerValue("indate", split_minute_getDay(selList.productInfo.indate));//등록일
                innerValue("sellstartdate", split_minute_getDay(selList.productInfo.sellstartdate));//판매시작일
                isCheckbox("isShow", false);//노출
                isCheckbox("isSell", true);//판매
                isCheckbox("isFree", true);//무료
                $('.custom-file-control').html(fn_clearFilePath(selList.productInfo.imageList));//리스트이미지
                $('.custom-file-control1').html(fn_clearFilePath(selList.productInfo.imageView));//상세이미지
                $("#emphasis").val(selList.productInfo.emphasis);//강조표시
                isCheckbox("isFreebieDeliveryFree", true);//사은품 배송비무료
                innerValue("description", selList.productInfo.description);//상세설명
            }
            if (selList.productOptionInfo) {/*---옵션---*/
                addOption(selList.productOptionInfo.length);
                for (var i = 0; i < selList.productOptionInfo.length; i++) {
                    var selName = "kind_" + i;
                    var selVal = selList.productOptionInfo[i].kind;
                    getVideoOptionTypeList(selName, selList.productOptionInfo[i].kind);

                    var priceId = "price_" + i;
                    var priceVal = selList.productOptionInfo[i].price;
                    innerValue(priceId, priceVal);

                    var sellPriceId = "sellPrice_" + i;
                    var sellPriceVal = selList.productOptionInfo[i].sellPrice;
                    innerValue(sellPriceId, sellPriceVal);

                    var pointId = "point_" + i;
                    var pointVal = selList.productOptionInfo[i].point;
                    innerValue(pointId, pointVal);

                    var extendPercentId = "extendPercent_" + i;
                    var extendPercentVal = selList.productOptionInfo[i].extendPercent;
                    innerValue(extendPercentId, extendPercentVal);

                    saleInputPrice(extendPercentVal, i);//재수강 할인가격
                }
            }

            if (selList.productCategoryInfo) { /*---카테고리---*/
                addCategory(selList.productCategoryInfo.length);
                for (var i = 0; i < selList.productCategoryInfo.length; i++) {
                    var ctgSelOne = "sel_" + i;
                    var ctgSelTwo = "2sel_" + i;
                    var ctgSelThr = "3sel_" + i;
                    var ctgSelFour = "4sel_" + i;
                    var ctgSelFive = "5sel_" + i;
                    getCategoryList(ctgSelOne, 214);
                    for (var j = 0; j < selList.productCategoryInfo[i].length; j++) {
                        getCategoryList(ctgSelTwo, selList.productCategoryInfo[i][3].parentKey);
                        getCategoryList(ctgSelThr, selList.productCategoryInfo[i][2].parentKey);
                        getCategoryList(ctgSelFour, selList.productCategoryInfo[i][1].ctgKey);
                        getCategoryList(ctgSelFive, selList.productCategoryInfo[i][0].ctgKey);
                    }
                }
            }

            if (selList.productLectureInfo) {/*---강좌정보----*/
                getSelectboxListForCtgKey("classGroupCtgKey", "4309");//급수 셀렉트박스
                getSelectboxListForCtgKey("subjectCtgKey", "70");//과목 셀렉트박스
                getSelectboxListForCtgKey("stepCtgKey", "202");//유형 셀렉트박스
                getLectureStatusSelectbox("status", selList.productLectureInfo.status);//강좌정보- 진행상태
                getLectureCountSelectbox("limitCount",selList.productLectureInfo.limitCount);//강좌정보 강좌수
                getClassRegistraionDaySelectbox("limitDay", selList.productLectureInfo.limitDay);//수강일수
                getLectureCountSelectbox("lecTime", selList.productLectureInfo.lecTime);//강좌시간
                getExamPrepareSelectbox("examYear", selList.productLectureInfo.examYear);//시험대비년도 셀렉트박스
                getLectureCountSelectbox("limitCount", selList.productLectureInfo.limitCount);//강좌정보 강좌수
                getClassRegistraionDaySelectbox("limitDay", selList.productLectureInfo.limitDay);//수강일수
                getLectureCountSelectbox("lecTime", selList.productLectureInfo.lecTime);//강좌시간

                $("#classGroupCtgKey").val(selList.productLectureInfo.classGroupCtgKey).prop("selected", true);
                $("#classGroupCtgKey").val(selList.productLectureInfo.classGroupCtgKey);
                $("#subjectCtgKey").val(selList.productLectureInfo.subjectCtgKey);
                $("#stepCtgKey").val(selList.productLectureInfo.stepCtgKey);
                $("#status").val(selList.productLectureInfo.status);
                $("#limitCount").val(selList.productLectureInfo.limitCount);
                $("#limitDay").val(selList.productLectureInfo.limitDay);
                $("#lecTime").val(selList.productLectureInfo.lecTime);
                $("#examYear").val(selList.productLectureInfo.examYear);
                innerValue("multiple", selList.productLectureInfo.multiple);
                innerValue("lecKey",selList.productLectureInfo.lecKey);
            }

            if (selList.productTeacherInfo) { /* 강사목록 불러오기 */
                //addTeacher(selList.productTeacherInfo.length);
                for (var i = 0; i < selList.productTeacherInfo.length; i++) {
                    var cmpList = selList.productTeacherInfo[i];
                    var inputHidden = "<input type='hidden' style='display: none;' id='gTeacherKey_" + i +"' value='" + cmpList.GTeacherKey + "'>";
                    var cellData = [
                        function(data) {return inputHidden},
                        function(data) {return cmpList.subjectName},
                        function(data) {return cmpList.teacherName},
                        function(data) {return cmpList.calculateRate}
                    ];
                    dwr.util.addRows("teacherListTbody", [0], cellData, {escapeHtml: false});

                    // var productTeacherId = "SubjectList_" + i;
                    // var subjectHiddenId = "subjectHidden_" + i;

                    // $("#SubjectList_" + i).val(selList.productTeacherInfo[i].subjectName);
                    // $("#subjectHidden_" + i).val(selList.productTeacherInfo[i].subjectCtgKey);
                    // //$("#SubjectList_1").val(4282);
                    //
                    // var teacherNameId = "teacherList_" + i;
                    // var teacherHiddenId = "teacherHidden_" + i;
                    //
                    // $("#"+teacherNameId).val(selList.productTeacherInfo[i].teacherName);
                    // $("#"+teacherHiddenId).val(selList.productTeacherInfo[i].teacherKey);
                    //
                    // var calculateRateId = "calculateRate_" + i;
                    // var calculateRateNameVal = selList.productTeacherInfo[i].calculateRate;
                    // innerValue(calculateRateId, calculateRateNameVal);
                    //
                    // var GTeacherKey = "gTeacherKey_" + i;
                    // var GTeacherKeyVal = selList.productTeacherInfo[i].GTeacherKey;
                    // innerValue(GTeacherKey, GTeacherKeyVal);
                    $("#lectureCurriTabel tbody tr").each(function(index) {
                        var id = $(this).attr("id");
                        var curriKey = id;
                        var pos = index;
                        var data = {
                            curriKey : curriKey,
                            pos : pos
                        };
                        arr.push(data);
                    });

                    $("#teacherListTbody > tr").each(function(idx) {
                        var id = idx;

                    });
                }
            }

            if (selList.productOtherInfo) {
                for (var i = 0; i < selList.productOtherInfo.length; i++) {
                    var selList2 = selList.productOtherInfo[i];
                    for (var j = 0; j < selList2.length; j++) {
                        if (selList2[j].resType == '8') {
                            var MockListHtml = "<tr>";
                            MockListHtml += "<td class=\"text-left\" style=\"padding: 0.3rem;vertical-align: middle;width:95%\">";
                            MockListHtml += "<input type='text'  class=\"form-control\" id='" + selList2[j].linkKey + "' value='" + selList2[j].goodsName + "' readonly>";
                            MockListHtml += "</td>";//examKey
                            MockListHtml += "<td class=\"text-left\" style=\"padding: 0.3rem;vertical-align: middle;width:95%\">";
                            MockListHtml += "<input type='hidden'   value='" + selList2[j].resKey + "' name='res_key[]'>";
                            MockListHtml += "</td>";//examKey
                            MockListHtml += "<td class=\"text-left\" style=\"padding:0.3rem;vertical-align:middle;\">";
                            MockListHtml += "<button type=\"button\" onclick=\"optionDelete('allMockTitleDelete')\" class='btn btn-outline-danger btn-sm' style=\"margin-top:8%;\">삭제</button>";
                            MockListHtml += "</td>";
                            MockListHtml += "</tr>";
                            $('#allMockList > tbody:first').append(MockListHtml);
                        } else if (selList2[j].resType == '9') {
                            var examListHtml = "<tr>";
                            examListHtml += "<td class=\"text-left\" style=\"padding: 0.3rem;vertical-align: middle;width:95%\">";
                            examListHtml += "<input type='text'  class=\"form-control\" id='" + selList2[j].linkKey + "' value='" + selList2[j].goodsName + "' readonly>";
                            examListHtml += "</td>";//examKey
                            examListHtml += "<td class=\"text-left\" style=\"padding: 0.3rem;vertical-align: middle;width:95%\">";
                            examListHtml += "<input type='hidden'  value='" + selList2[j].resKey + "' name='res_key[]'>";
                            examListHtml += "</td>";//examKey
                            examListHtml += "<td class=\"text-left\" style=\"padding:0.3rem;vertical-align:middle;\">";
                            examListHtml += "<button type=\"button\" onclick=\"optionDelete('examQuestionDelete')\" class='btn btn-outline-danger btn-sm' style=\"margin-top:8%;\">삭제</button>";
                            examListHtml += "</td>";
                            examListHtml += "</tr>";
                            $('#examQuestionList > tbody:first').append(examListHtml);
                        } else if (selList2[j].resType == '5') {
                            var bookListHtml = "<tr>";
                            bookListHtml += "<td class=\"text-left\" style=\"padding: 0.3rem;vertical-align: middle;width:95%\">";
                            bookListHtml += "<input type='text' class=\"form-control\" id='" + selList2[j].linkKey + "' value='" + selList2[j].goodsName + "' readonly>";
                            bookListHtml += "</td>";//examKey
                            bookListHtml += "<td class=\"text-left\" style=\"padding: 0.3rem;vertical-align: middle;width:95%\">";
                            bookListHtml += "<input type='hidden'  value='" + selList2[j].resKey + "' name='res_key[]'>";
                            bookListHtml += "</td>";//examKey
                            bookListHtml += "<td class=\"text-left\" style=\"padding:0.3rem;vertical-align:middle;\">";
                            bookListHtml += "<button type=\"button\" onclick=\"optionDelete('bookTitleDelete')\" class='btn btn-outline-danger btn-sm' style=\"margin-top:8%;\">삭제</button>";
                            bookListHtml += "</td>";
                            bookListHtml += "</tr>";
                            $('#bookList > tbody:first').append(bookListHtml);
                        } else if (selList2[j].resType == '4') {
                            var giftListtHtml = "<tr>";
                            giftListtHtml += "<td class=\"text-left\" style=\"padding: 0.3rem;vertical-align: middle;width:95%\">";
                            giftListtHtml += "<input type='text' class=\"form-control\" id='" + selList2[j].linkKey + "' value='" + selList2[j].goodsName + "' readonly>";
                            giftListtHtml += "</td>";//examKey
                            giftListtHtml += "<td class=\"text-left\" style=\"padding: 0.3rem;vertical-align: middle;width:95%\">";
                            giftListtHtml += "<input type='hidden'  value='" + selList2[j].resKey + "' name='res_key[]'>";
                            giftListtHtml += "</td>";//examKey
                            giftListtHtml += "<td class=\"text-left\" style=\"padding:0.3rem;vertical-align:middle;\">";
                            giftListtHtml += "<button type=\"button\" onclick=\"optionDelete('giftDelete')\" class='btn btn-outline-danger btn-sm' style=\"margin-top:8%;\">삭제</button>";
                            giftListtHtml += "</td>";
                            giftListtHtml += "</tr>";
                            $('#giftList > tbody:first').append(giftListtHtml);
                        }
                    }
                }
            }
        });

        //동영상 - 강의목록 불러오기
        productManageService.getLectureCurriList(gKey, function (selList) {
            $( "#lectureCurriTabel tbody" ).sortable({
                update: function( event, ui ) {
                    $(this).children().each(function(index) {
                        $(this).find('tr').last().html(index + 1);
                    });
                }
            });
            if (selList.length > 0) {
                for (var i = 0; i < selList.length; i++) {
                    console.log(selList);
                    var cmpList = selList[i];
                    if (cmpList != undefined) {
                        var text = "'CURRI'";
                        var btn = '<button type="button" onclick="deleteOtherInfo(' + cmpList.curriKey + "," + text + ')"  class="btn btn-outline-danger btn-sm">삭제</button>';
                        var deleteBtn =  '<button type="button" onclick="LectureCurriPopup('+cmpList.curriKey+","+cmpList.lecKey+","+cmpList.pos+')"  class="btn btn-success btn-sm">수정</button>';
                        var textYn = "";
                        if(cmpList.isShow == '1' ||  cmpList.isSample =='1'){
                            textYn = 'O';
                        }else{
                            textYn = 'X';
                        }
                        var cellData = [
                            function (data) {return cmpList.name;},
                            function (data) {return cmpList.vodTime;},
                            function (data) {return textYn;},
                            function (data) {return textYn;},
                            function (data) {return btn+deleteBtn;}
                        ];
                        //dwr.util.addRows("lectureCurriList", [0], cellData, {escapeHtml: false});
                        dwr.util.addRows(lectureCurriList, [0], cellData, {
                            rowCreator:function(options) {
                                var row = document.createElement("tr");
                                var index = options.rowIndex * 50;
                                row.id = cmpList.curriKey;
                                row.className = "ui-state-default even ui-sortable-handle";
                                return row;
                            },
                            escapeHtml:false});
                    }
                }
            }
        });
    }

    //강의목록 순서변경저장
    function changelectureListSave() {
        var arr = new Array();    // 배열 선언
        $("#lectureCurriTabel tbody tr").each(function(index) {
            var id = $(this).attr("id");
            var curriKey = id;
            var pos = index;
            var data = {
                curriKey : curriKey,
                pos : pos
            };
            arr.push(data);
        });
        productManageService.changeNumberVideoLecture(arr, function () {
            location.reload();
        });
    }

    //강의목록 삭제
    function deleteOtherInfo(key, val) {
        if(confirm("삭제하시겠습니까?")) {
            productManageService.deleteVideoOtherInfo(key, val, function () {
                if(val == 'CURRI'){
                    $('#lectureCurriTabel > tbody:last > tr:last').remove(); //여기
                }else if(val == 'CATE_GOODS'){
                    $('#categoryTable > tbody:last > tr:last').remove(); //여기
                }
                location.reload();
            });
        }
    }

    //강의목록 수정 팝업
    function LectureCurriPopup() {
        $('#lectureListPopup').show();
        productManageService.getProductDetailInfo(gKey, "1", function (selList) {
            innerValue("lectureName",);//강의이름
            //노출여부,샘플여부
            isCheckbox("lectureIsShow", false);//노출
            isCheckbox("isSample", true);//판매
            innerValue("vodFileLow",);//동영상 저화질 경로
            innerValue("vodFileHigh",);//동영상 저화질 경로
            innerValue("vodFileMobileLow",);//모바일 동영상 저화질 경로
            innerValue("vodFileMobileHigh",);//모바일동영상 저화질 경로
            //강의자료

            innerValue("vodTime",);//모바일동영상 저화질 경로


        });
    }
    //옵션 - 할인률 계산
    function saleInputPrice(val,cnt) {
        selPriceCnt = "sellPrice_"+cnt;
        resultPirceCnt = "resultPrice_"+cnt;
        var sellPrice = getInputTextValue(selPriceCnt);
        totalprice = Math.round(sellPrice -((sellPrice * val) / 100));
        innerValue(resultPirceCnt,totalprice);
    }


    //강의목록- 입력 저장
    function videoLectureSave() {
        var data = new FormData();
        $.each($('#dataFile')[0].files, function(i, file) {
            data.append('file_name', file);
        });
        $.ajax({
            url: "/file/videoDataFileUpload",
            method: "post",
            dataType: "JSON",
            data: data,
            cache: false,
            processData: false,
            contentType: false,
            success: function (data) {
                var name = getInputTextValue("lectureName");
                var isShow = "";
                if($('input:checkbox[name="lectureIsShow"]').is(":checked") == true) isShow = '1';
                else{isShow = '0';}
                var isSample = "";
                if($('input:checkbox[name="isSample"]').is(":checked") == true) isSample = '1';
                else{isSample = '0';}
                var vodFileLow = getInputTextValue("vodFileLow");
                var vodFileHigh = getInputTextValue("vodFileHigh");
                var vodFileMobileLow = getInputTextValue("vodFileMobileLow");
                var vodFileMobileHigh = getInputTextValue("vodFileMobileHigh");
                var vodTime = getInputTextValue("vodTime");
                var dataFile = "";
                if(data.result != null) dataFile = data.result;
                var data = {
                    curriKey:0,
                    lecKey:gKey,
                    name:name,
                    isShow:isShow,
                    isSample:isSample,
                    vodFileLow:vodFileLow,
                    vodFileHigh:vodFileHigh,
                    vodFileMobileLow:vodFileMobileLow,
                    vodFileMobileHigh:vodFileMobileHigh,
                    vodTime:vodTime,
                    dataPage:0,
                    pos:0,
                    dataFile: dataFile
                };
                productManageService.saveVideoLectureInfo(data, function (data) {
                    if(data){//lectureListPopup
                        alert("저장되었습니다.");
                        innerValue("lectureName",'');
                        isCheckbox("lectureIsShow", false);//노출
                        isCheckbox("isSample", false);//노출
                        innerValue("vodFileLow",'');
                        innerValue("vodFileHigh",'');
                        innerValue("vodFileMobileLow",'');
                        innerValue("vodFileMobileHigh",'');
                        innerValue("vodTime",'');
                        $('.custom-file-control2').html('');
                    }
                });
            }
        });

    }

    //기본정보 수정 함수
    function basicModify() {
        if(confirm("기본정보를 수정 하시겠습니까?")){
            var data = getJsonObjectFromDiv("section1");
            if(data.isShow == 'on')  data.isShow = '1';//노출 checkbox
            else data.isShow = '0';
            if(data.isSell == 'on')  data.isSell = '1';//판매
            else data.isSell = '0';
            if(data.isFree == 'on')  data.isFree = '1';//무료
            else data.isFree = '0';
            if(data.isFreebieDeliveryFree == 'on')  data.isFreebieDeliveryFree = '1';//사은품배송비무료
            else data.isFreebieDeliveryFree = '0';
            var imageListFile = $(".custom-file-control").text();
            var imageViewFile = $(".custom-file-control2").text();

            productManageService.upsultGoodsInfo(data, imageListFile, imageViewFile,function (data) {
                location.reload();
            });
        }
    }

    function optionTapModify() {
        if(confirm("옵션정보를 수정 하시겠습니까?")){
            var optionArray = new Array();
            $('#optionTable tbody tr').each(function(index){
                var optionName = $(this).find("td select").eq(0).val();
                var price = $(this).find("td input").eq(0).val();
                var sellPrice = $(this).find("td input").eq(1).val();
                var point = $(this).find("td input").eq(2).val();
                var extendPercent = $(this).find("td input").eq(3).val();
                var data = {
                    priceKey:'0',
                    gKey:'0',
                    kind:optionName,
                    ctgKey:'0',
                    name:'0',
                    price:price,
                    sellPrice:sellPrice,
                    point:point,
                    extendPercent:extendPercent
                };
                optionArray.push(data);
            });

            productManageService.upsultTGoodsPriceOption(optionArray, gKey,function () {
                location.reload();
            });
        }
    }

    function categoryModify() {
        if(confirm("카테고리를 수정 하시겠습니까?")){
            var categoryArray = new Array();
            $('#categoryTable tbody tr').each(function(index){
                var cate4 = $(this).find("td select").eq(4).val();
                if(cate4 == '선택')  cate4 = "";
                var data = {
                    ctgGKey:0,
                    ctgKey:cate4,
                    gKey:0,
                    pos:0
                };
                categoryArray.push(data);
            });

            productManageService.upsultTCategoryGoods(categoryArray, gKey,function () {
                location.reload();
            });
        }
    }


    function lectureInfoModify() {
        if(confirm("강좌정보를 수정 하시겠습니까?")){
            var lectureObj = getJsonObjectFromDiv("section4");
            productManageService.upsultTLec(lectureObj, gKey,function () {
                location.reload();
            });
        }
    }

    //강사목록 수정
    function techerModify() {
        if(confirm("강사정보를 수정 하시겠습니까?")){
            var teacherArray = new Array();
            $('#teacherTabel tbody tr').each(function(index){
                var gTeacherKey = $("#gTeacherKey_" + index).val();
                if(gTeacherKey == "") gTeacherKey == '0';
                var subject = $(this).find("td select").eq(0).val();
                var teacher1 = $(this).find("td select").eq(1).val();
                //var subject = $(this).find("td input").eq(1).val();
                //var teacher = $(this).find("td input").eq(2).val();
                var calculateRate = $(this).find("td input").eq(1).val();
                var data = {
                    gTeacherKey: gTeacherKey,
                    gKey:gKey,
                    isPublicSubject:'0',
                    subjectCtgKey:subject,
                    teacherKey:teacher1,
                    calculateRate:calculateRate,
                    subjectName: "",
                    teacherName: ""
                };
                teacherArray.push(data);
            });
            console.log(teacherArray);

            // productManageService.upsultTGoodTeacherLink(teacherArray, gKey,function () {
            //     location.reload();
            // });
        }
    }

    function mocklISTModify() {
        if(confirm("수정 하시겠습니까?")){
            /*  6.선택 obj  */
            var array3 = new Array();
            $('#allMockList tbody tr').each(function(index){
                //var mockTitle = $(this).find("td input").eq(0).val();
                var mockKey = $(this).find("td input").eq(1).val();
                var data = {
                    linkKey: 0,
                    reqKey: gKey,
                    resKey:mockKey,
                    resType: 8,
                    pos: 0,
                    valueBit: 0
                };
                array3.push(data);
            });
            $('#examQuestionList tbody tr').each(function(index){
                //var examQuestionTitle = $(this).find("td input").eq(0).val();
                var examKey = $(this).find("td input").eq(1).val();
                var data = {
                    linkKey: 0,
                    reqKey: gKey,
                    resKey:examKey,
                    resType: 9,
                    pos: 0,
                    valueBit: 0
                };
                array3.push(data);
            });
            $('#bookList tbody tr').each(function(index){
                //var bookTitle = $(this).find("td input").eq(0).val();
                var bookKey = $(this).find("td input").eq(1).val();
                var data = {
                    linkKey: 0,
                    reqKey: gKey,
                    resKey:bookKey,
                    resType: 5,
                    pos: 0,
                    valueBit: 0
                };
                array3.push(data);
            });
            $('#giftList tbody tr').each(function(index){
                //var giftTitle = $(this).find("td input").eq(0).val();
                var gifyKey = $(this).find("td input").eq(1).val();
                var data = {
                    linkKey: 0,
                    reqKey: gKey,
                    resKey:gifyKey,
                    resType: 4,
                    pos: 0,
                    valueBit: 0
                };
                array3.push(data);
            });
            productManageService.upsultTLinkKink(array3, gKey,function () {

            });
        }
    }
</script>
<div class="page-breadcrumb">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">동영상 수정</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">상품관리</li>
                        <li class="breadcrumb-item active" aria-current="page">동영상상품관리</li>
                        <li class="breadcrumb-item active" aria-current="page">동영상 수정</li>
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
                    <input type="hidden" id="gKey" name="gKey" value="<%=gKey%>">
                    <div>
                        <!-- 1.기본정보 Tab -->
                        <h3>기본정보</h3>
                        <section class="col-md-auto">
                            <input type="button" value="수정" onclick="basicModify();">
                            <div id="section1">
                                <input type="hidden" value="0" name="gKey">
                                <input type="hidden" value="0" name="cpKey">
                                <input type="hidden" value="0" name="isNodc">
                                <input type="hidden" value="0" name="tags">
                                <input type="hidden" value="0" name="calculateRate">
                                <input type="hidden" value="0" name="isQuickDelivery">
                                <input type="hidden" value="" name="goodsId">
                                <input type="hidden" value="" name="goodsTypeName">
                                <input type="hidden" value="" name="summary">
                                <div class="form-group">
                                    <label class="col-sm-1 control-label col-form-label" style="margin-bottom: 0">상품타입</label>
                                    <span>온라인강좌</span>
                                    <input type="hidden" class="form-control" id="type" name='type' value="1">
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-1 control-label col-form-label" style="margin-bottom: 0">이름</label>
                                    <input type="text" class="col-sm-3 form-control" style="display: inline-block;" id="name" name="name">
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-1 control-label col-form-label"  style="margin-bottom: 0">등록일</label>
                                    <div class="input-group col-sm-10" id="dateRangePicker">
                                        <input type="text" class="form-control mydatepicker" placeholder="yyyy.mm.dd" name="indate" id="indate">
                                        <div class="input-group-append">
                                            <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-1 control-label col-form-label"  style="margin-bottom: 0">판매시작일</label>
                                    <div class="input-group col-sm-3">
                                        <input type="text" class="form-control mydatepicker" placeholder="mm/dd/yyyy" name="sellstartdate" id="sellstartdate">
                                        <div class="input-group-append">
                                            <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group row mt-4" style="">
                                    <label class="col-sm-1 control-label col-form-label"  style="margin-bottom: 0">노출</label>
                                    <div class="col-sm-10">
                                        <div style="margin-top: -23px;">
                                            OFF
                                            <label class="switch">
                                                <input type="checkbox" id="isShow" name="isShow" style="display:none;">
                                                <span class="slider"></span>
                                            </label>
                                            ON
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-1 control-label col-form-label" style="margin-bottom: 0">판매</label>
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
                                <div class="form-group row">
                                    <label class="col-sm-1 control-label col-form-label" style="margin-bottom: 0">무료</label>
                                    <div class="col-sm-10">
                                        <div style="margin-top: -23px;">
                                            OFF
                                            <label class="switch">
                                                <input type="checkbox" id="isFree" name="isFree" style="display:none;">
                                                <span class="slider"></span>
                                            </label>
                                            ON
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-1 control-label col-form-label" style="margin-bottom: 0">리스트이미지</label>
                                    <div>
                                        <div class="custom-file col-sm-5">
                                            <input type="file" class="custom-file-input" id="imageListFile"  name="imageListFile" required>
                                            <span class="custom-file-control custom-file-label"></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-1 control-label col-form-label" style="margin-bottom: 0">상세이미지</label>
                                    <div>
                                        <div class="custom-file col-sm-5">
                                            <input type="file" class="custom-file-input addFile" id="imageViewFile" name="imageViewFile" required>
                                            <span class="custom-file-control1 custom-file-label"></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label  class="col-sm-1 control-label col-form-label" style="margin-bottom: 0">강조표시</label>
                                    <select class="col-sm-3 select2 form-control custom-select" id="emphasis" name="emphasis">
                                        <option  value="0">없음</option>
                                        <option value="1">BEST</option>
                                        <option value="2">NEW</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-1 control-label col-form-label" style="margin-bottom: 0">사은품 배송비 무료</label>
                                    <div>
                                        <div style="margin-top: -23px;" class="col-sm-5">
                                            OFF
                                            <label class="switch">
                                                <input type="checkbox" style="display:none;" id="isFreebieDeliveryFree" name="isFreebieDeliveryFree">
                                                <span class="slider"></span>
                                            </label>
                                            ON
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-form-label">상세설명</label>
                                    <div>
                                        <textarea name="content"  value="" id="description" name="description"></textarea>
                                    </div>
                                </div>
                            </div>
                        </section>
                        <!-- // 1.기본정보 Tab -->

                        <!-- 2.옵션 Tab -->
                        <h3>옵션</h3>
                        <section>
                            <input type="button" value="수정" onclick="optionTapModify();">
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
                                    <tbody>
                                    <tr>
                                        <td style="padding: 0.3rem;text-align: center;"><!--옵션명selbox-->
                                            <select class="select2 form-control custom-select" style="height:36px;" id="kind_0" name="kind_0">
                                                <option>선택</option>
                                            </select>
                                        </td>
                                        <td style="padding: 0.3rem;"><!--원가-->
                                            <input type="number" class="form-control" id="price_0" name="price_0">
                                        </td>
                                        <td style="padding: 0.3rem;"><!--판매가-->
                                            <input type="number" class="form-control" id="sellPrice_0" name="sellPrice_0">
                                        </td>
                                        <td style="padding: 0.3rem;"><!--포인트-->
                                            <input type="text" class="form-control" id="point_0" name="point_0">
                                        </td>
                                        <td style="padding: 0.3rem;"><!--재수강1-->
                                            <input type="number" style="display: inline-block" class="form-control" id="extendPercent_0" name="extendPercent" onchange="saleInputPrice(this.value,0)">
                                        </td>
                                        <td style="padding: 0.3rem;"><!--재수강2-->
                                            <input type="number" class="form-control" id="resultPrice_0" readonly>
                                        </td>
                                        <td style="padding: 0.3rem;">
                                            <button type="button" onclick="optionDelete('optionDelete');" class="btn btn-outline-danger btn-sm" style="margin-top:8%;">삭제</button>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                                <div class="mx-auto" style="width:5.5%">
                                    <button type="button" class="btn btn-outline-info mx-auto" onclick="addOption('new');">추가</button>
                                </div>
                            </div>
                        </section>
                        <!-- //2.옵션 Tab -->

                        <!-- 3.카테고리 목록 Tab -->
                        <h3>카테고리</h3>
                        <section>
                            <input type="button" value="수정" onclick="categoryModify();">
                            <div id="section3">
                                <table class="table" id="categoryTable">
                                    <input type="hidden" name="ctgGKey" value="0">
                                    <input type="hidden" name="gKey" value="0">
                                    <input type="hidden" name="pos" value="0">
                                    <thead>
                                    <tr style="border-top:0">
                                        <th scope="col" style="text-align:center;width:20%"></th>
                                        <th scope="col" style="text-align:center;"></th>
                                        <th scope="col" style="text-align:center;width:20%"></th>
                                        <th scope="col" style="text-align:center;width:20%"></th>
                                        <th scope="col" colspan="2" style="text-align:center;width:20%"></th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td><!--옵션명selbox-->
                                            <select class="col-sm-8 form-control custom-select" id="sel_0" onchange="changesel('2sel_0', this.value);">
                                                <option>선택</option>
                                            </select>
                                        </td>
                                        <td><!--원가-->
                                            <select class="col-sm-8 form-control custom-select" id="2sel_0"  onchange="changesel('3sel_0', this.value);">
                                                <option>선택</option>
                                            </select>
                                        </td>
                                        <td><!--판매가-->
                                            <select class="col-sm-8 form-control custom-select" id="3sel_0" onchange="changesel('4sel_0', this.value);">
                                                <option>선택</option>
                                            </select>
                                        </td>
                                        <td><!--포인트-->
                                            <select class="col-sm-8 form-control custom-select" id="4sel_0" onchange="changesel('5sel_0', this.value);">
                                                <option>선택</option>
                                            </select>
                                        </td>
                                        <td><!--재수강1-->
                                            <select class="col-sm-8 form-control custom-select" id="5sel_0">
                                                <option>선택</option>
                                            </select>
                                        </td>
                                        <td style="width:3%;vertical-align: middle">
                                            <button type="button"  onclick="optionDelete('categoryDelete')"  class='btn btn-outline-danger btn-sm' style="margin-top:8%;">삭제</button>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                                <div class="mx-auto" style="width:5.5%">
                                    <button type="button" class="btn btn-outline-info mx-auto" onclick="addCategory('new');">추가</button>
                                </div>
                            </div>
                        </section>
                        <!-- //3.카테고리 목록 Tab -->

                        <!-- 4.강좌 정보 Tab -->
                        <h3>강좌정보</h3>
                        <section>
                            <!--<div class="form-group">
                                <label class="control-label col-form-label" style="margin-bottom: 0">강좌 CODE</label>
                                <input type="text" class="form-control" value="" readonly>
                            </div>-->
                            <input type="button" value="수정" onclick="lectureInfoModify();">
                            <div id="section4">

                                <input type="hidden" name="lecKey" id="lecKey">
                                <input type="hidden" name="gKey" value="0">
                                <input type="hidden" name="teacherKey" value="0">
                                <input type="hidden" name="regdate" value="">
                                <input type="hidden" name="startdate" value="">
                                <input type="hidden" name="isPack" value="0">
                                <input type="hidden" name="goodsId" value="0">
                                <input type="hidden" name="lecDateYear" value="0">
                                <input type="hidden" name="lecDateMonth" value="0">
                                <div class="form-group">
                                    <label class="col-sm-1 control-label col-form-label" style="margin-bottom: 0">급수</label>
                                    <select class="col-sm-3 select2 form-control custom-select" id="classGroupCtgKey" name="classGroupCtgKey">
                                        <option value="">선택</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-1 control-label col-form-label" style="margin-bottom: 0">과목</label>
                                    <select class="col-sm-3 select2 form-control custom-select" id="subjectCtgKey" name="subjectCtgKey">
                                        <option value="">선택</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">유형</label>
                                    <select class="col-sm-3 select2 form-control custom-select" id="stepCtgKey" name="stepCtgKey">
                                        <option value="">선택</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">진행상태</label>
                                    <select class="col-sm-3 select2 form-control custom-select" name="status" id="status">
                                        <option value="">선택</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">강좌수</label>
                                    <select  class="col-sm-3 select2 form-control custom-select"  id="limitCount" name="limitCount">
                                        <option value="">선택</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">수강일수</label>
                                    <select class="col-sm-3 select2 form-control custom-select"  id="limitDay" name="limitDay">
                                        <option value="">선택</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">강좌시간</label>
                                    <select class="col-sm-3 select2 form-control custom-select"  id="lecTime" name="lecTime">
                                        <option value="">선택</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">배수</label>
                                    <input type="text" class="col-sm-3 form-control" style="display: inline-block;" name="multiple" id="multiple"><span style="font-size:11px;vertical-align:middle;color:#999;font-weight:500;margin-left:10px">*배수가 0이면 무제한</span>
                                </div>
                                <div class="form-group">
                                    <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">시험대비년도</label>
                                    <select class="col-sm-3 select2 form-control custom-select" id="examYear" name="examYear">
                                        <option value="">선택</option>
                                    </select>
                                </div>
                            </div>
                        </section>
                        <!-- //4.강좌 정보 Tab -->

                        <!-- 5.강사 목록 Tab -->
                        <h3>강사목록</h3>
                        <section>
                            <input type="button" value="수정" onclick="techerModify();">
                            <div id="section5">
                                <table class="table" id="teacherTabel">
                                    <%--                                    <input type="hidden" id="gTeacherKey_0" >--%>
                                    <%--                                    <input type="hidden" id="subjectHidden_0" >--%>
                                    <%--                                    <input type="hidden" id="teacherHidden_0" >--%>
                                    <%--                                    <input type="hidden" name="gKey" value="0">--%>
                                    <thead>
                                    <tr>
                                        <th scope="col" colspan="5" style="text-align:center;width:30%">강사목록</th>
                                    </tr>
                                    </thead>
                                    <tbody id="teacherListTbody">
                                    <%--                                    <tr>--%>
                                    <%--                                        <td style="padding: 0.3rem;text-align: center;width: 20%;vertical-align: middle">--%>
                                    <%--                                            <!--<select  class="select2 form-control custom-select"  id="SubjectList_0" name="SubjectList_0" readonly>--%>
                                    <%--                                                <option value="">선택</option>--%>
                                    <%--                                            </select>-->--%>
                                    <%--                                            <input type="text" id="SubjectList_0" name="SubjectList_0" class="form-control"  readonly>--%>
                                    <%--                                        </td>--%>
                                    <%--                                        <td style="padding: 0.3rem; vertical-align: middle;width:2%;text-align: center;">--%>
                                    <%--                                            <i class="m-r-10 mdi mdi-play" style="font-size:18px;color:darkblue"></i>--%>
                                    <%--                                        </td>--%>
                                    <%--                                        <td style="padding: 0.3rem;width: 20%">--%>
                                    <%--                                           <!--<select  class="select2 form-control custom-select"  id="teacherList_0" name="teacherList_0" readonly>--%>
                                    <%--                                                <option value="">선택</option>--%>
                                    <%--                                            </select>-->--%>
                                    <%--                                            <input type="text" id="teacherList_0" name="teacherList_0" class="form-control"  readonly>--%>
                                    <%--                                        </td>--%>
                                    <%--                                        <td style="padding: 0.3rem;width:60%;text-align:right;vertical-align: middle">--%>
                                    <%--                                            <label style="display: inline-block">조건 : </label>--%>
                                    <%--                                            <input type="text" class="form-control" style="display: inline-block;width:60%" name="calculateRate_0" id="calculateRate_0" readonly> %--%>
                                    <%--                                        </td>--%>
                                    <%--                                        <td style="width:3%;vertical-align: middle">--%>
                                    <%--                                            <button type="button"  class='btn btn-outline-danger btn-sm' onclick="optionDelete('teacherDelete')" style="margin-top:8%;">삭제</button>--%>
                                    <%--                                        </td>--%>
                                    <%--                                    </tr>--%>
                                    </tbody>
                                </table>
                                <div class="mx-auto" style="width:5.5%">
                                    <button type="button" class="btn btn-outline-info mx-auto" style="margin-bottom:18px;" onclick="addTeacher('new');">추가</button>
                                </div>
                            </div>
                        </section>
                        <!-- //5.강사 목록 Tab -->

                        <!-- 6.선택 Tab -->
                        <h3>선택</h3>
                        <section>
                            <input type="button" value="수정" onclick="mocklISTModify();">
                            <div id="section6">
                                <table class="table text-center table-hover" id="allMockList">
                                    <thead>
                                    <tr>
                                        <th scope="col" colspan="2">전범위 모의고사
                                            <button type="button" style="float: right" class="btn btn-outline-info btn-sm" data-toggle="modal" data-target="#sModal3" onclick="fn_search('new');">추가</button>
                                        </th>
                                    </tr>
                                    </thead>
                                    <tbody id="MockTitle"></tbody>
                                </table>
                                <table class="table table-hover text-center" id="examQuestionList">
                                    <thead>
                                    <tr>
                                        <th scope="col" colspan="2">기출문제 회차별
                                            <button type="button" style="float: right"  class="btn btn-outline-info btn-sm" data-toggle="modal" data-target="#sModal4" onclick="fn_search2('new');">추가</button>
                                        </th>
                                    </tr>
                                    </thead>
                                    <tbody id="examQuestionTitle"></tbody>
                                </table>
                                <table class="table text-center table-hover" id="bookList">
                                    <thead>
                                    <tr>
                                        <th scope="col" colspan="3">강의교재
                                            <button type="button"  style="float: right" class="btn btn-outline-info btn-sm" data-toggle="modal" data-target="#bookModal" onclick="fn_search3('new');">추가</button>
                                        </th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                                <table class="table text-center table-hover" id="giftList">
                                    <thead>
                                    <tr>
                                        <th scope="col" colspan="2">사은품
                                            <button type="button" style="float: right"  class="btn btn-outline-info btn-sm"  data-toggle="modal" data-target="#giftModal" onclick="fn_search4('new');">추가</button>
                                        </th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        </section>
                        <!-- //6.선택 Tab -->

                        <!-- 7.강의 목록 Tab -->
                        <h3>강의목록</h3>
                        <section>
                            <div class="mb-3 float-right">
                                <button type="button" class="btn btn-outline-info btn-sm" onclick="changelectureListSave();">순서변경저장</button>
                                <button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#lectureListPopup">추가</button>
                            </div>
                            <table class="table text-center table-hover"  id="lectureCurriTabel">
                                <thead>
                                <tr>
                                    <th scope="col" colspan="1" style="width:40%">강의제목</th>
                                    <th scope="col" colspan="1" style="width:20%">시간</th>
                                    <th scope="col" colspan="1" style="width:10%">출력</th>
                                    <th scope="col" colspan="1" style="width:10%">샘플사용</th>
                                    <th scope="col" colspan="1" style="width:7%"></th>
                                </tr>
                                </thead>
                                <tbody id="lectureCurriList">
                                </tbody>
                            </table>
                        </section>
                    </div>
                </div>
            </div>
        </div>
        <!-- //div.card -->
    </div>
</form>
<!-- // 기본소스-->
<!-- 6.선택 전범위 모의고사 팝업창 -->
<div class="modal fade" id="sModal3" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document" style="max-width: 900px">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">강의 입력</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close" id="lecturePopupClose">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form>
                <!-- modal body -->
                <div class="modal-body">
                    <div style=" display:inline;">
                        <div style=" float: left; width: 10%">
                            <select class="form-control" id="searchType">
                                <option>선택</option>
                            </select>
                        </div>
                        <div style=" float: left; width: 33%">
                            <input type="text" class="form-control" id="searchText">
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
                                <th style="width:45%">시험명</th>
                                <th style="width:15%">시험신청기간</th>
                                <th style="width:15%">시험기간</th>
                                <th style="width:15%">진행시간</th>
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
<!-- //선택 전범위 모의고사 추가 팝업창 -->

<!-- 기출문제 회차별 팝업창 -->
<div class="modal fade" id="sModal4" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document" style="max-width: 900px">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">강의 입력</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close" id="examPopupClose">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form>
                <!-- modal body -->
                <div class="modal-body">
                    <div style=" display:inline;">
                        <div style=" float: left; width: 10%">
                            <select class="form-control" id="examsearchType">
                                <option>선택</option>
                            </select>
                        </div>
                        <div style=" float: left; width: 33%">
                            <input type="text" class="form-control" id="examsearchText">
                        </div>
                        <div style=" float: left; width: 33%">
                            <button type="button" class="btn btn-outline-info mx-auto" onclick="fn_search2('new')">검색</button>
                        </div>
                    </div>
                    <div class="table-responsive">
                        <input type="hidden" id="sPage2" >
                        <table id="zero_config" class="table table-hover text-center">
                            <thead class="thead-light">
                            <tr>
                                <th style="width:45%">시험명</th>
                                <th style="width:15%">시험신청기간</th>
                                <th style="width:15%">시험기간</th>
                                <th style="width:15%">진행시간</th>
                                <th style="width:5%"></th>
                            </tr>
                            </thead>
                            <tbody id="dataList2"></tbody>
                            <tr>
                                <td id="emptys2" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
                            </tr>
                        </table>
                        <%@ include file="/common/inc/com_pageNavi2.inc" %>
                    </div>
                </div>
                <!-- //modal body -->
            </form>
        </div>
    </div>
</div>
<!-- //기출문제 회차별 팝업창 -->

<!-- 6.선택 강의교재  팝업창 -->
<div class="modal fade" id="bookModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document" style="max-width: 900px">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">상품선택</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close" id="lectureBookClose">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form>
                <!-- modal body -->
                <div class="modal-body">
                    <div style=" display:inline;">
                        <div style=" float: left; width: 10%">
                            <select class="form-control" id="booksearchType">
                                <option>선택</option>
                            </select>
                        </div>
                        <div style=" float: left; width: 33%">
                            <input type="text" class="form-control" id="booksearchTextBook">
                        </div>
                        <div style=" float: left; width: 33%">
                            <button type="button" class="btn btn-outline-info mx-auto" onclick="fn_search3('new')">검색</button>
                        </div>
                    </div>
                    <div class="table-responsive">
                        <input type="hidden" id="sPage3" >
                        <table id="zero_config" class="table table-hover text-center">
                            <thead class="thead-light">
                            <tr>
                                <th style="width:45%">상품명</th>
                                <th style="width:15%">노출</th>
                                <th style="width:15%">판매</th>
                                <th style="width:15%">무료</th>
                                <th style="width:15%"></th>
                            </tr>
                            </thead>
                            <tbody id="dataList3"></tbody>
                            <tr>
                                <td id="emptys3" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
                            </tr>
                        </table>
                        <%@ include file="/common/inc/com_pageNavi3.inc" %>
                    </div>
                </div>
                <!-- //modal body -->
            </form>
        </div>
    </div>
</div>
<!-- //선택 추가 팝업창 -->


<!-- 6.선택 사은품  팝업창 -->
<div class="modal fade" id="giftModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document" style="max-width: 900px">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">상품선택</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close" >
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form>
                <!-- modal body -->
                <div class="modal-body">
                    <div style=" display:inline;">
                        <div style=" float: left; width: 10%">
                            <select class="form-control" id="giftsearchType">
                                <option>선택</option>
                            </select>
                        </div>
                        <div style=" float: left; width: 33%">
                            <input type="text" class="form-control" id="giftsearchTextBook">
                        </div>
                        <div style=" float: left; width: 33%">
                            <button type="button" class="btn btn-outline-info mx-auto" onclick="fn_search3('new')">검색</button>
                        </div>
                    </div>
                    <div class="table-responsive">
                        <input type="hidden" id="sPage4" >
                        <table id="zero_config" class="table table-hover text-center">
                            <thead class="thead-light">
                            <tr>
                                <th style="width:45%">상품명</th>
                                <th style="width:15%">노출</th>
                                <th style="width:15%">판매</th>
                                <th style="width:15%">무료</th>
                                <th style="width:15%"></th>
                            </tr>
                            </thead>
                            <tbody id="dataList4"></tbody>
                            <tr>
                                <td id="emptys4" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
                            </tr>
                        </table>
                        <%@ include file="/common/inc/com_pageNavi4.inc" %>
                    </div>
                </div>
                <!-- //modal body -->
            </form>
        </div>
    </div>
</div>
<!-- //선택 추가 팝업창 -->


<!-- 강의목록 강의입력 추가 팝업창 -->
<div class="modal" id="lectureListPopup" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document" style="max-width:620px;">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">강의 입력</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <!-- modal body -->
            <div class="modal-body">
                <div class="form-group row">
                    <label class="col-sm-3 text-right control-label col-form-label">강좌 CODE</label>
                    <div class="col-sm-9">
                        <input type="text" id="lecCurriKey" value="<%=gKey%>" class="form-control" readonly>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-3 text-right control-label col-form-label">강의 CODE</label>
                    <div class="col-sm-9">
                        <input type="text" id="curriKey" class="form-control" readonly>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-3 text-right control-label col-form-label">강의 이름</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="lectureName">
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-3 text-right col-sm-2 text-left control-label col-form-label">노출 여부</label>
                    <div class="col-sm-9">
                        <div style="margin-top: -23px;">
                            OFF
                            <label class="switch">
                                <input type="checkbox" id="lectureIsShow" name="lectureIsShow"/>
                                <span class="slider"></span>
                            </label>
                            ON
                        </div>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-3 text-right col-sm-2 text-left control-label col-form-label">샘플 여부</label>
                    <div class="col-sm-9">
                        <div style="margin-top: -23px;">
                            OFF
                            <label class="switch">
                                <input type="checkbox" id="isSample" name="isSample"/>
                                <span class="slider"></span>
                            </label>
                            ON
                        </div>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-3 text-right control-label col-form-label">동영상 저화질 경로</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="vodFileLow">
                    </div>
                </div>
                <div class="form-group row">
                    <label  class="col-sm-3 text-right control-label col-form-label">동영상 고화지 경로</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="vodFileHigh">
                    </div>
                </div>
                <div class="form-group row">
                    <label  class="col-sm-3 text-right control-label col-form-label">모바일용 동영상 저화질 경로</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="vodFileMobileLow">
                    </div>
                </div>
                <div class="form-group row">
                    <label  class="col-sm-3 text-right control-label col-form-label">모바일용 동영상 고화질 경로</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="vodFileMobileHigh">
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-3 text-right control-label col-form-label" style="margin-bottom: 0">강의 자료</label>
                    <div class="col-sm-9">
                        <div class="custom-file">
                            <input type="file" class="custom-file-input dataAddFile" id="dataFile" name="dataFile" required>
                            <span class="custom-file-control2 custom-file-label"></span>
                        </div>
                    </div>
                </div>
                <div class="form-group row">
                    <label  class="col-sm-3 text-right control-label col-form-label">강의 시간 (분단위)</label>
                    <div class="col-sm-9">
                        <input type="number" class="form-control" id="vodTime" name="vodTime">
                    </div>
                </div>
                <!--<div class="form-group row">
                    <label  class="col-sm-3 text-right control-label col-form-label">단원 선택</label>
                    <div class="col-sm-9">
                        <div>
                            <select class="select2 form-control custom-select" style="width:24%">
                                <option>준비중</option>
                                <option value="#">2010</option>
                                <option value="#">2011</option>
                            </select>
                            <select class="select2 form-control custom-select" style="width:24%">
                                <option>준비중</option>
                                <option value="#">2010</option>
                                <option value="#">2011</option>
                            </select>
                            <select class="select2 form-control custom-select" style="width:24%">
                                <option>준비중</option>
                                <option value="#">2010</option>
                                <option value="#">2011</option>
                            </select>
                            <select class="select2 form-control custom-select" style="width:24%">
                                <option>준비중</option>
                                <option value="#">2010</option>
                                <option value="#">2011</option>
                            </select>
                        </div>
                    </div>
                </div>-->
                <button type="button" class="mt-3 mb-1 btn btn-info float-right" onclick="videoLectureSave();">저장</button>
            </div>
            <!-- //modal body -->
        </div>
    </div>
</div>
<!-- //강의목록 추가 팝업창 -->
<!-- 시험일정 추가 팝업창 -->
<div class="modal fade" id="sModal2" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">텍스트 입력</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <!-- modal body -->
            <div class="modal-body">
                <div class="form-group row">
                    <label class="col-sm-3 text-right control-label col-form-label">텍스트</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control">
                    </div>
                </div>
                <button type="button" class="btn btn-info float-right">확인</button>
            </div>
            <!-- //modal body -->
        </div>
    </div>
</div>
<!-- //시험일정 추가 팝업창 -->
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
        onFinished: function(event, currentIndex) {
            playSave();
        },
        onContentLoaded: function (event, currentIndex) {

        }
        /*onFinishing: function(event, currentIndex) {
            //form.validate().settings.ignore = ":disabled";
            //return form.valid();
        },
        onFinished: function(event, currentIndex) {
            //alert("Submitted!");
        }*/
        // aria-selected:"false"
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
<style>

</style>
