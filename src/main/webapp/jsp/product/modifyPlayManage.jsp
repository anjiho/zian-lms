<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<%
    String gKey = request.getParameter("gKey");
%>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/productManageService.js'></script>
<script type='text/javascript' src='/dwr/interface/selectboxService.js'></script>
<script>
    var gKey = '<%=gKey%>';
    $( document ).ready(function() {
        playDetailList();//정보불러오기
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

    function optionDelete(val) {
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
            optionHtml += "<button type=\"button\" onclick=\"optionDelete('setOptionDelete')\" class=\"btn btn-danger btn-sm\" style=\"margin-top:8%;\">삭제</button>";
            optionHtml += "</a>";
            optionHtml += "</td>";
            optionHtml += "</tr>";
            $('#optionTable > tbody:first').append(optionHtml);
    }



    function addTeacher(val){
        if(val == 'new'){//옵션새로추가
            var optionCnt = $("#teacherTabel tr").length-1;
            addTeacherCnt(optionCnt);
        }else{//기존옵션 배열
            var optionCnt =  val-1;
            for(var i = 0; i < optionCnt; i++){
                addTeacherCnt(i+1);
            }
        }
    }
    
    function addTeacherCnt(val) {
        var optionCnt = val;
        var SubjectCnt = "SubjectList_"+optionCnt;
        var teacherCnt = "teacherList_"+optionCnt;

        var optionHtml  = "<tr>";
        optionHtml  += "<td style=\"padding: 0.3rem;text-align: center;width: 20%;vertical-align: middle\">";
        optionHtml  += "<input type=\"text\" class=\"form-control\" id='SubjectList_"+optionCnt+"' name='SubjectList_"+optionCnt+"'>";
        optionHtml  += "</td>";
        optionHtml  += "<td style=\"padding: 0.3rem; vertical-align: middle;width:2%;text-align: center;\">";
        optionHtml  += "<i class=\"m-r-10 mdi mdi-play\" style=\"font-size:18px;color:darkblue\"></i>";
        optionHtml  += "</td>";
        optionHtml  += "<td style=\"padding: 0.3rem;text-align: center;width: 20%;vertical-align: middle\">";
        optionHtml  += "<input type=\"text\" class=\"form-control\" id='teacherList_"+optionCnt+"' name='teacherList_"+optionCnt+"'>";
        optionHtml  += "</td>";
        optionHtml  += "<td style=\"padding: 0.3rem;width:60%;text-align:right;vertical-align: middle\">";
        optionHtml  += "<label style=\"display: inline-block\">조건 : </label>";
        optionHtml  += "<input type=\"text\" class=\"form-control\" style=\"display: inline-block;width:60%\" id='calculateRate_"+optionCnt+"' name='calculateRate_"+optionCnt+"'> %";
        optionHtml  += "</td>";
        optionHtml  += "<td style=\"width:3%;vertical-align: middle\">";
        optionHtml  += "<a href=\"#\" data-toggle=\"tooltip\" data-placement=\"top\" title=\"삭제\">";
        optionHtml  += "<i class=\"mdi mdi-close\"></i>";
        optionHtml  += "</a>";
        optionHtml  += "</td>";
        optionHtml  += "</tr>";
        $('#teacherTabel > tbody:first').append(optionHtml);
    }

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
                MockListHtml     += "<input type='text'  id='"+getallMockOption+"' value='' readonly>";
                MockListHtml     += "</td>";//examKey
                MockListHtml     += "<td>";
                MockListHtml     += "<input type='hidden'  value='"+selList.mokExamInfo.examKey+"' readonly>";
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
                bookkListHtml     += "<input type='text'  id='"+bookgiftOption+"' value='' readonly>";
                bookkListHtml     += "</td>";
                bookkListHtml     += " <td>";
                bookkListHtml     += "<input type='hidden'  value='"+selList.productInfo.GKey+"' readonly>";
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
        categoryHtml += "<tr>";
        categoryHtml += "<td>";
        categoryHtml += "<input type='text' class='form-control' id='ctgSelOne_"+categoryCnt+"' name='ctgSelOne_"+categoryCnt+"'>";
        categoryHtml += " </td>";
        categoryHtml += "<td>";
        categoryHtml += "<input type='text' class='form-control' id='ctgSelTwo_"+categoryCnt+"' name='ctgSelTwo_"+categoryCnt+"'>";
        categoryHtml += " </td>";
        categoryHtml += "<td>";
        categoryHtml += "<input type='text' class='form-control' id='ctgSelThr_"+categoryCnt+"' name='ctgSelThr_"+categoryCnt+"'>";
        categoryHtml += " </td>";
        categoryHtml += "<td>";
        categoryHtml += "<input type='text' class='form-control' id='ctgSelFour_"+categoryCnt+"' name='ctgSelFour_"+categoryCnt+"'>";
        categoryHtml += " </td>";
        categoryHtml += "<td>"
        categoryHtml += "<input type='text' class='form-control' id='ctgSelFive_"+categoryCnt+"' name='ctgSelFive_"+categoryCnt+"'>";
        categoryHtml += " </td>";
        categoryHtml += "</tr>";
        $('#categoryTable > tbody:first').append(categoryHtml);
    }

    function playDetailList() { //동영상정보
        productManageService.getProductDetailInfo(gKey, 'VIDEO', function (selList) {
            console.log(selList);
            if(selList.productInfo){/*---기본정보---*/
                innerValue("name",selList.productInfo.name);//이름
                innerValue("indate",split_minute_getDay(selList.productInfo.indate));//등록일
                innerValue("sellstartdate",split_minute_getDay(selList.productInfo.sellstartdate));//판매시작일
                isCheckbox("isShow", false);//노출
                isCheckbox("isSell", true);//판매
                isCheckbox("isFree", true);//무료
                $('.custom-file-control').html(selList.productInfo.imageList);//리스트이미지
                $('.addFile').html(selList.productInfo.imageView);//상세이미지
                $("#emphasis").val(0);//강조표시
                isCheckbox("isFreebieDeliveryFree", true);//사은품 배송비무료
                innerValue("description",selList.productInfo.description);//상세설명
            }
            if(selList.productOptionInfo){/*---옵션---*/
                addOption(selList.productOptionInfo.length);
                for(var i = 0; i < selList.productOptionInfo.length; i++){
                    var selName = "kind_"+i;
                    var selVal = selList.productOptionInfo[i].kind;
                    getVideoOptionTypeList(selName, "");
                    $("#"+selName).val(selVal);

                    var priceId = "price_"+i;
                    var priceVal = selList.productOptionInfo[i].price;
                    innerValue(priceId, priceVal);

                    var sellPriceId = "sellPrice_"+i;
                    var sellPriceVal = selList.productOptionInfo[i].sellPrice;
                    innerValue(sellPriceId, sellPriceVal);

                    var pointId = "point_"+i;
                    var pointVal = selList.productOptionInfo[i].point;
                    innerValue(pointId, pointVal);

                    var extendPercentId = "extendPercent_"+i;
                    var extendPercentVal = selList.productOptionInfo[i].extendPercent;
                    innerValue(extendPercentId, extendPercentVal);

                    saleInputPrice(extendPercentVal,i);//재수강 할인가격
                }
            }

            if(selList.productCategoryInfo){ /*---카테고리---*/
                addCategory(selList.productCategoryInfo.length);
                for(var i = 0; i < selList.productCategoryInfo.length; i++){
                    var ctgSelOne  =  "ctgSelOne_"+ i;
                    var ctgSelTwo  =  "ctgSelTwo_"+ i;
                    var ctgSelThr  =  "ctgSelThr_"+ i;
                    var ctgSelFour =  "ctgSelFour_"+ i;
                    var ctgSelFive =  "ctgSelFive_"+ i;
                   for(var j = 0; j < selList.productCategoryInfo[i].length; j++){
                       innerValue(ctgSelOne,"지안에듀");
                       innerValue(ctgSelTwo,selList.productCategoryInfo[i][3].name);
                       innerValue(ctgSelThr,selList.productCategoryInfo[i][2].name);
                       innerValue(ctgSelFour,selList.productCategoryInfo[i][1].name);
                       innerValue(ctgSelFive,selList.productCategoryInfo[i][0].name);

                   }
                }
            }

            if(selList.productLectureInfo){/*---강좌정보----*/
                getSelectboxListForCtgKey("classGroupCtgKey","4309");//급수 셀렉트박스
                getSelectboxListForCtgKey("subjectCtgKey","70");//과목 셀렉트박스
                getSelectboxListForCtgKey("stepCtgKey","202");//유형 셀렉트박스
                getLectureStatusSelectbox("status","");//강좌정보- 진행상태
                getLectureCountSelectbox("limitCount","");//강좌정보 강좌수
                getClassRegistraionDaySelectbox("limitDay","");//수강일수
                getLectureCountSelectbox("lecTime","");//강좌시간
                getExamPrepareSelectbox("examYear","");//시험대비년도 셀렉트박스

                $("#classGroupCtgKey").val(selList.productLectureInfo.classGroupCtgKey);
                $("#subjectCtgKey").val(selList.productLectureInfo.subjectCtgKey);
                $("#stepCtgKey").val(selList.productLectureInfo.stepCtgKey);
                $("#status").val(selList.productLectureInfo.status);
                $("#limitCount").val(selList.productLectureInfo.limitCount);
                $("#limitDay").val(selList.productLectureInfo.limitDay);
                $("#lecTime").val(selList.productLectureInfo.lecTime);
                $("#examYear").val(selList.productLectureInfo.examYear);
                innerValue("multiple",selList.productLectureInfo.multiple);
            }

            if(selList.productTeacherInfo){
                addTeacher(selList.productTeacherInfo.length);
                for(var i = 0; i < selList.productTeacherInfo.length; i++){
                    var productTeacherId = "SubjectList_"+i;
                    var subjectNameVal = selList.productTeacherInfo[i].subjectName;
                    innerValue(productTeacherId, subjectNameVal);

                    var teacherNameId = "teacherList_"+i;
                    var teacherNameVal = selList.productTeacherInfo[i].teacherName;
                    innerValue(teacherNameId, teacherNameVal);

                    var calculateRateId = "calculateRate_"+i;
                    var calculateRateNameVal = selList.productTeacherInfo[i].calculateRate;
                    innerValue(calculateRateId, calculateRateNameVal);
                }
            }

            if(selList.productOtherInfo){
                for(var i = 0; i < selList.productOtherInfo.length; i++){
                    var selList2 = selList.productOtherInfo[i];
                    for(var j = 0; j < selList2.length; j++){
                        if(selList2[j].resType == '8'){
                            var MockListHtml = "<tr>";
                            MockListHtml     += "<td class=\"text-left\" style=\"padding: 0.3rem;vertical-align: middle;width:95%\">";
                            MockListHtml     += "<input type='text'  id='"+ selList2[j].linkKey +"' value='"+ selList2[j].goodsName +"' readonly>";
                            MockListHtml     += "</td>";//examKey
                            MockListHtml     += "<td class=\"text-left\" style=\"padding:0.3rem;vertical-align:middle;\">";
                            MockListHtml     += "</td>";
                            MockListHtml     += "</tr>";
                            $('#allMockList > tbody:first').append(MockListHtml);
                        }else if(selList2[j].resType == '9'){
                            var examListHtml = "<tr>";
                            examListHtml     += "<td class=\"text-left\" style=\"padding: 0.3rem;vertical-align: middle;width:95%\">";
                            examListHtml     += "<input type='text'  id='"+ selList2[j].linkKey +"' value='"+ selList2[j].goodsName +"' readonly>";
                            examListHtml     += "</td>";//examKey
                            examListHtml     += "<td class=\"text-left\" style=\"padding:0.3rem;vertical-align:middle;\">";
                            examListHtml     += "</td>";
                            examListHtml     += "</tr>";
                            $('#examQuestionList > tbody:first').append(examListHtml);
                        }else if(selList2[j].resType == '5'){
                            var bookListHtml = "<tr>";
                            bookListHtml     += "<td class=\"text-left\" style=\"padding: 0.3rem;vertical-align: middle;width:95%\">";
                            bookListHtml     += "<input type='text'  id='"+ selList2[j].linkKey +"' value='"+ selList2[j].goodsName +"' readonly>";
                            bookListHtml     += "</td>";//examKey
                            bookListHtml     += "<td class=\"text-left\" style=\"padding:0.3rem;vertical-align:middle;\">";
                            bookListHtml     += "</td>";
                            bookListHtml     += "</tr>";
                            $('#bookList > tbody:first').append(bookListHtml);
                        }else if(selList2[j].resType == '4'){
                            var giftListtHtml = "<tr>";
                            giftListtHtml     += "<td class=\"text-left\" style=\"padding: 0.3rem;vertical-align: middle;width:95%\">";
                            giftListtHtml     += "<input type='text'  id='"+ selList2[j].linkKey +"' value='"+ selList2[j].goodsName +"' readonly>";
                            giftListtHtml     += "</td>";//examKey
                            giftListtHtml     += "<td class=\"text-left\" style=\"padding:0.3rem;vertical-align:middle;\">";
                            giftListtHtml     += "</td>";
                            giftListtHtml     += "</tr>";
                            $('#giftList > tbody:first').append(giftListtHtml);
                        }
                    }
                }
            }
        });

        //동영상 - 강의목록 불러오기
        productManageService.getLectureCurriList(gKey, function (selList) {
            console.log(">>>");
            console.log(selList);
            //console.log("불러오기");
            //console.log(selList);
            /*var optionHtml = "<tr>";

            $('#optionTable > tbody:first').append(optionHtml);*/

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
                            innerValue("");
                            innerValue("vodFileHigh");
                            innerValue("vodFileMobileLow");
                            innerValue("vodFileMobileHigh");
                            innerValue("vodTime");
                        }
                    });
                }
            });

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
                        <section class="col-md-6">
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
                                <input type="hidden" value="" name="description">
                                <div class="form-group">
                                    <label class="control-label col-form-label" style="margin-bottom: 0">상품타입</label>
                                    <span>온라인강좌</span>
                                    <input type="hidden" class="form-control" id="type" name='type' value="1">
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-form-label" style="margin-bottom: 0">이름</label>
                                    <input type="text" class="form-control" id="name" name="name">
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-form-label" style="margin-bottom: 0">등록일</label>
                                    <div class="input-group" id="dateRangePicker">
                                        <input type="text" class="form-control mydatepicker" placeholder="yyyy.mm.dd" name="indate" id="indate">
                                        <div class="input-group-append">
                                            <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-form-label" style="margin-bottom: 0">판매시작일</label>
                                    <div class="input-group">
                                        <input type="text" class="form-control mydatepicker" placeholder="mm/dd/yyyy" name="sellstartdate" id="sellstartdate">
                                        <div class="input-group-append">
                                            <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group row mt-4" style="">
                                    <label class="col-sm-2 text-left control-label col-form-label">노출</label>
                                    <div class="col-sm-10">
                                        <div style="margin-top: -23px;">
                                            OFF
                                            <label class="switch">
                                                <input type="checkbox" id="isShow" name="isShow" style="display:none;" value="0">
                                                <span class="slider"></span>
                                            </label>
                                            ON
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-sm-2 text-left control-label col-form-label">판매</label>
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
                                    <label class="col-sm-2 text-left control-label col-form-label">무료</label>
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
                                    <label class="control-label col-form-label" style="margin-bottom: 0">리스트이미지</label>
                                    <div>
                                        <div class="custom-file">
                                            <input type="file" class="custom-file-input" id="imageListFile"  name="imageListFile" required>
                                            <span class="custom-file-control custom-file-label"></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-form-label" style="margin-bottom: 0">상세이미지</label>
                                    <div>
                                        <div class="custom-file">
                                            <input type="file" class="custom-file-input addFile" id="imageViewFile" name="imageViewFile" required>
                                            <span class="custom-file-control1 custom-file-label"></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label  class="control-label col-form-label" style="margin-bottom: 0">강조표시</label>
                                    <div>
                                        <select class="col-sm-6 select2 form-control custom-select" id="emphasis" name="emphasis">
                                            <option  value="0">없음</option>
                                            <option value="1">BEST</option>
                                            <option value="2">NEW</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-form-label">사은품 배송비 무료</label>
                                    <div>
                                        <div style="margin-top: -23px;">
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
                                            <button type="button" onclick="optionDelete('optionDelete');" class="btn btn-danger btn-sm" style="margin-top:8%;">삭제</button>
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
                                        <td><!--포인트-->
                                            <input type="text" class="form-control" id="ctgSelOne_0" name="ctgSelOne_0" readonly>
                                        </td>
                                        <td><!--원가-->
                                            <input type="text" class="form-control" id="ctgSelTwo_0" name="ctgSelTwo_0" readonly>
                                        </td>
                                        <td><!--판매가-->
                                            <input type="text" class="form-control" id="ctgSelThr_0" name="ctgSelThr_0" readonly>
                                        </td>
                                        <td><!--포인트-->
                                            <input type="text" class="form-control" id="ctgSelFour_0" name="ctgSelFour_0" readonly>
                                        </td>
                                        <td><!--재수강1-->
                                            <input type="text" class="form-control" id="ctgSelFive_0" name="ctgSelFive_0" readonly>
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
                            <div id="section4">

                                <input type="hidden" name="lecKey" value="0">
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
                                    </select>
                                </div>
                            </div>
                        </section>
                        <!-- //4.강좌 정보 Tab -->

                        <!-- 5.강사 목록 Tab -->
                        <h3>강사목록</h3>
                        <section>
                            <div id="section5">
                                <table class="table" id="teacherTabel">
                                    <input type="hidden" name="gTeacherKey" value="0">
                                    <input type="hidden" name="gKey" value="0">
                                    <thead>
                                    <tr>
                                        <th scope="col" colspan="5" style="text-align:center;width:30%">강사목록</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td style="padding: 0.3rem;text-align: center;width: 20%;vertical-align: middle">
                                            <input type="text" class="form-control" id="SubjectList_0" name="SubjectList_0" >
                                        </td>
                                        <td style="padding: 0.3rem; vertical-align: middle;width:2%;text-align: center;">
                                            <i class="m-r-10 mdi mdi-play" style="font-size:18px;color:darkblue"></i>
                                        </td>
                                        <td style="padding: 0.3rem;width: 20%">
                                            <input type="text" class="form-control" id="teacherList_0" name="teacherList_0" >
                                        </td>
                                        <td style="padding: 0.3rem;width:60%;text-align:right;vertical-align: middle">
                                            <label style="display: inline-block">조건 : </label>
                                            <input type="text" class="form-control" style="display: inline-block;width:60%" name="calculateRate_0" id="calculateRate_0"> %
                                        </td>
                                        <td style="width:3%;vertical-align: middle">
                                            <a href="#" data-toggle="tooltip" data-placement="top" title="삭제">
                                                <i class="mdi mdi-close"></i>
                                            </a>
                                        </td>
                                    </tr>
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
                            <div id="section6">
                                <table class="table text-center table-hover" id="allMockList">
                                    <thead>
                                    <tr>
                                        <th scope="col" colspan="2">전범위 모의고사</th>
                                    </tr>
                                    </thead>
                                    <tbody id="MockTitle"></tbody>
                                </table>
                                <div class="mx-auto mb-5" style="width:5.5%">
                                    <button type="button" class="btn btn-outline-info btn-sm" data-toggle="modal" data-target="#sModal3" onclick="fn_search('new');">추가</button>
                                </div>
                                <table class="table table-hover text-center" id="examQuestionList">
                                    <thead>
                                    <tr>
                                        <th scope="col" colspan="2">기출문제 회차별</th>
                                    </tr>
                                    </thead>
                                    <tbody id="examQuestionTitle"></tbody>
                                </table>
                                <div class="mx-auto mb-5" style="width:5.5%">
                                    <button type="button" class="btn btn-outline-info btn-sm" data-toggle="modal" data-target="#sModal4" onclick="fn_search2('new');">추가</button>
                                </div>
                                <table class="table text-center table-hover" id="bookList">
                                    <thead>
                                    <tr>
                                        <th scope="col" colspan="3">강의교재</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <!--<tr>
                                       <td class="text-left" style="padding:0.3rem;vertical-align: middle;width: 65%">
                                            <span>빅주간(전범위)모의고사_공통과목 12회</span>
                                        </td>
                                        <td class="text-left" style="padding: 0.3rem; vertical-align: middle;width: 30%">
                                            <div class="col-sm-10">
                                                <div style="margin-top: -23px;">
                                                    부교재
                                                    <label class="switch">
                                                        <input type="checkbox" style="display:none;">
                                                        <span class="slider"></span>
                                                    </label>
                                                    주교재
                                                </div>
                                            </div>
                                        </td>
                                        <td class="text-left" style="padding:0.3rem;vertical-align:middle;">
                                            <button type="button" class="btn btn-outline-danger btn-sm">삭제</button>
                                        </td>
                                    </tr>-->
                                    </tbody>
                                </table>
                                <div class="mx-auto mb-5" style="width:5.5%">
                                    <button type="button" class="btn btn-outline-info btn-sm" data-toggle="modal" data-target="#bookModal" onclick="fn_search3('new');">추가</button>
                                </div>
                                <table class="table text-center table-hover" id="giftList">
                                    <thead>
                                    <tr>
                                        <th scope="col" colspan="2">사은품</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <!-- <tr>
                                        <td class="text-left" style="padding:0.3rem;vertical-align:middle;width: 95%">
                                            <span>빅주간(전범위)모의고사_공통과목 12회</span>
                                        </td>
                                        <td class="text-left" style="padding: 0.3rem;vertical-align:middle;">
                                            <button type="button" class="btn btn-outline-danger btn-sm">삭제</button>
                                        </td>
                                    </tr>-->
                                    </tbody>
                                </table>
                                <div class="mx-auto mb-5" style="width:5.5%">
                                    <button type="button" class="btn btn-outline-info btn-sm"  data-toggle="modal" data-target="#giftModal" onclick="fn_search4('new');">추가</button>
                                </div>
                            </div>
                        </section>
                        <!-- //6.선택 Tab -->

                        <!-- 7.강의 목록 Tab -->
                        <h3>강의목록</h3>
                        <section>
                            <div class="mb-3 float-right">
                                <button type="button" class="btn btn-outline-info btn-sm">순서변경</button>
                                <button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#lectureListPopup">추가</button>
                            </div>
                            <table class="table text-center table-hover"  id="lectureCurriTabel">
                                <thead>
                                <tr>
                                    <th scope="col" colspan="1" style="width:8%">번호</th>
                                    <th scope="col" colspan="1" style="width:50%">강의제목</th>
                                    <th scope="col" colspan="1" style="width:15%">시간</th>
                                    <th scope="col" colspan="1" style="width:10%">출력</th>
                                    <th scope="col" colspan="1" style="width:10%">샘플사용</th>
                                    <th scope="col" colspan="1" style="width:7%"></th>
                                </tr>
                                </thead>
                                <tbody id="lectureCurriList">
                                <!--<tr>
                                    <td class="text-center" style="padding: 0.3rem;vertical-align: middle">
                                        <span>1</span>
                                    </td>
                                    <td class="text-left" style="padding: 0.3rem; vertical-align: middle;">
                                        <span>text</span>
                                    </td>
                                    <td style="padding: 0.3rem;vertical-align: middle">
                                        <span>10</span>
                                    </td>
                                    <td style="padding: 0.3rem;vertical-align: middle">
                                        <i class="mdi mdi-close" style="color: red"></i>
                                    </td>
                                    <td style="vertical-align: middle">
                                        <i class="mdi mdi-check" style="color:green;"></i>
                                    </td>
                                    <td style="padding: 0.3rem;text-align: center;vertical-align: middle">
                                        <button type="button" class="btn btn-outline-danger btn-sm">삭제</button>
                                    </td>
                                </tr>-->
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
                        <input type="text" id="lecKey" value="<%=gKey%>" class="form-control" readonly>
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
                        <input type="text" class="form-control" id="vodTime" name="vodTime">
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
