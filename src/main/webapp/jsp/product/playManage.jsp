<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/productManageService.js'></script>
<script type='text/javascript' src='/dwr/interface/selectboxService.js'></script>
<script>
    $( document ).ready(function() {
        getVideoOptionTypeList("kind_0","");
        getCategoryList("selCate1","214");
        getSelectboxListForCtgKey("set_1","4309");//급수 셀렉트박스
        getSelectboxListForCtgKey("set_2","70");//과목 셀렉트박스
        getSelectboxListForCtgKey("set_3","202");//유형 셀렉트박스
        getSelectboxListForCtgKey("SubjectList_0","70");//과목 셀렉트박스
        selectTeacherSelectbox("teacherList_0","");//선생님 셀렉트박스
        getLectureCountSelectbox("lectureTimeCnt","");
        getLectureCountSelectbox("lectureCnt","");
        getClassRegistraionDaySelectbox("lectureDayCnt","");
        selectExamSearchSelectbox("searchType","");
        selectExamSearchSelectbox("examsearchType","");
        selectExamSearchSelectbox("booksearchType","");
        getExamPrepareSelectbox("examYearSel","");//시험대비년도 셀렉트박스
        getLectureStatusSelectbox("status","");//강좌정보- 진행상태
        $('#description').summernote({ //기본정보-에디터
            width: 750,
            height: 300,
            focus: true,
            theme: 'cerulean'
        });
        $('.sModal3').on('hidden.bs.modal', function (e) {
            $('form').each(function(){
                this.reset();
            });
        });
        $('.sModal4').on('hidden.bs.modal', function (e) {
            $('form').each(function(){
                this.reset();
            });
        });
        $('.bookModal').on('hidden.bs.modal', function (e) {
            $('form').each(function(){
                this.reset();
            });
        });

    });

    function changesel(id, val){ //카테고리 셀렉트박스 불러오기
       /* var idNum = 0;
        if (id != undefined) {
            var split = gfn_split(id, "_");
            var idNum = "sel_" + (Number(split[1]) + 1) ;
        }*/
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

    function addOption(){ //옵션명 추가
        var optionCnt = $("#optionTable tr").length-1;
        var getOption = "kind_"+optionCnt;
        getVideoOptionTypeList(getOption, "");
        var optionHtml = "<tr>";
                optionHtml += "<td style=\"padding: 0.3rem;text-align: center;\">";
                    optionHtml += "<select class=\"select2 form-control custom-select\" style=\"height:36px;\"  id='kind_"+optionCnt+"'  name='kind_"+optionCnt+"'>";
                        optionHtml += "<option>선택</option>";
                    optionHtml += "</select>";
                optionHtml += "</td>";
                    optionHtml += "<td style=\"padding: 0.3rem;\">";
                    optionHtml += "<input type=\"number\" class=\"form-control\">";
                optionHtml += "</td>";
                    optionHtml += "<td style=\"padding: 0.3rem;\">";
                    optionHtml += "<input type=\"number\" class=\"form-control\"  id='sellPrice_"+optionCnt+"'  name='sellPrice_"+optionCnt+"'>";
                optionHtml += "</td>";
                optionHtml += " <td style=\"padding: 0.3rem;\">";
                    optionHtml += "<input type=\"text\" class=\"form-control\" >";
                optionHtml += "</td>";
                optionHtml += " <td style=\"padding: 0.3rem;\">";
                     optionHtml += "<input type=\"number\" style=\"display: inline-block\" class=\"form-control\" id=\"extendPercent\" name=\"extendPercent\" onchange='saleInputPrice(this.value"+","+optionCnt+")' >";
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

    function addTeacher(){
        var optionCnt = $("#teacherTabel tr").length-1;
        var SubjectCnt = "SubjectList_"+optionCnt;
        var teacherCnt = "teacherList_"+optionCnt;
        getSelectboxListForCtgKey(SubjectCnt,"70");//과목 셀렉트박스
        selectTeacherSelectbox(teacherCnt,"");//선생님 셀렉트박스

        var optionHtml  = "<tr>";
         optionHtml  += "<td style=\"padding: 0.3rem;text-align: center;width: 20%;vertical-align: middle\">";
         optionHtml  += "<select class=\"select2 form-control custom-select\" style=\"height:36px;\" id='SubjectList_"+optionCnt+"'>";
         optionHtml  += "<option>선택</option>";
         optionHtml  += "</select>";
         optionHtml  += "</td>";
         optionHtml  += "<td style=\"padding: 0.3rem; vertical-align: middle;width:2%;text-align: center;\">";
         optionHtml  += "<i class=\"m-r-10 mdi mdi-play\" style=\"font-size:18px;color:darkblue\"></i>";
         optionHtml  += "</td>";
         optionHtml  += "<td style=\"padding: 0.3rem;width: 20%\">";
         optionHtml  += "<select class=\"select2 form-control custom-select\" style=\"height:36px;\" id='teacherList_"+optionCnt+"'>";
         optionHtml  += " <option>선택</option>";
         optionHtml  += "</select>";
         optionHtml  += "</td>";
         optionHtml  += "<td style=\"padding: 0.3rem;width:60%;text-align:right;vertical-align: middle\">";
         optionHtml  += "<label style=\"display: inline-block\">조건 : </label>";
         optionHtml  += "<input type=\"text\" class=\"form-control\" style=\"display: inline-block;width:60%\"> %";
         optionHtml  += "</td>";
         optionHtml  += "<td style=\"width:3%;vertical-align: middle\">";
         optionHtml  += "<a href=\"#\" data-toggle=\"tooltip\" data-placement=\"top\" title=\"삭제\">";
         optionHtml  += "<i class=\"mdi mdi-close\"></i>";
         optionHtml  += "</a>";
         optionHtml  += "</td>";
         optionHtml  += "</tr>";
        $('#teacherTabel > tbody:first').append(optionHtml);
    }

    //파일 선택시 파일명 보이게 하기
    $(document).on('change', '.custom-file-input', function() {
        $(this).parent().find('.custom-file-control').html($(this).val().replace(/C:\\fakepath\\/i, ''));
    });
    $(document).on('change', '.addFile', function() {
        $(this).parent().find('.custom-file-control1').html($(this).val().replace(/C:\\fakepath\\/i, ''));
    });

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

    //옵션 - 판매가 재수강시 할인율적용 함수
    function saleInputPrice(val,cnt) {
        selPriceCnt = "sellPrice_"+cnt;
        resultPirceCnt = "resultPrice_"+cnt;
        var sellPrice = getInputTextValue(selPriceCnt);
        totalprice = Math.round(sellPrice -((sellPrice * val) / 100));
        innerValue(resultPirceCnt,totalprice);
    }

    //카테고리 리스트 추가
    function addCategory() {
        var categoryCnt = $("#categoryTable tr").length-1;

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
        categoryHtml += " <select class=\"col-sm-8 form-control custom-select\"  id='5sel_"+categoryCnt+"' name=\"ctgKey\" >";
        categoryHtml += " <option>선택</option>";
        categoryHtml += "  </select>";
        categoryHtml += " </td>";
        categoryHtml += "</tr>";
        $('#categoryTable > tbody:first').append(categoryHtml);
    }

    //저장
    function playSave() {


        var data = new FormData();
        $.each($('#imageListFile')[0].files, function(i, file) {

            data.append('imageListFile', file);
        });

        $.each($('#imageViewFile')[0].files, function(i, file) {

            data.append('imageViewFile', file);
        });

        /* 1. 기본정보 obj */
        var obj = getJsonObjectFromDiv("section1");
        if(obj.isShow == 'on')  obj.isShow = '1';//노출 checkbox
        else obj.isShow = '0';
        if(obj.isSell == 'on')  obj.isSell = '1';//판매
        else obj.isSell = '0';
        if(obj.isFree == 'on')  obj.isFree = '1';//무료
        else obj.isFree = '0';
        if(obj.isFreebieDeliveryFree == 'on')  obj.isFreebieDeliveryFree = '1';//사은품배송비무료
        else obj.isFreebieDeliveryFree = '0';
        /*  //기본정보 obj */

        /*  2.옵션 obj */
        var array = new Array();
        $('#optionTable tbody tr').each(function(index){
            var i =0;
            var kind = $(this).find("td select").eq(0).val();
            var kind1 = $(this).find("td input").eq(1).val();
            var kind2 = $(this).find("td input").eq(2).val();
            var kind3 = $(this).find("td input").eq(3).val();
            var kind4 = $(this).find("td input").eq(4).val();
            var kind5 = $(this).find("td input").eq(5).val();

            var data = {
                priceKey:'0',
                gKey:'0',
                kind:kind,
                ctgKey:'0',
                name:'0',
                price:kind1,
                sellPrice:kind2,
                point:kind3,
                extendPercent:kind4
            };
            array.push(data);
        });
        /* //옵션 obj */

        /*  3.카테고리 obj  */
        var array1 = new Array();
        $('#categoryTable tbody tr').each(function(index){
            var cate4 = $(this).find("td select").eq(4).val();
            if(cate4 == '선택')  cate4 = "";
            var data = {
                ctgGKey:0,
                ctgKey:cate4,
                gKey:0,
                pos:0
            };
            array1.push(data);
        });
        /*  //카테고리 obj  */


        /*  4.강좌정보 obj  */
        var lectureObj = getJsonObjectFromDiv("section4");
        console.log(lectureObj);
        /*  //강좌정보 obj  */

        /*  5.강사정보 obj  */
        var array2 = new Array();
        $('#teacherTabel tbody tr').each(function(index){
            var teacher = $(this).find("td select").eq(0).val();
            var teacher1 = $(this).find("td select").eq(1).val();
            var teacher2 = $(this).find("td input").eq(2).val();
            var data = {
                gTeacherKey:'0',
                gKey:'0',
                isPublicSubject:'0',
                subjectCtgKey:teacher,
                teacherKey:teacher1,
                calculateRate:teacher2,
                subjectName: "",
                teacherName: ""
            };
            array2.push(data);
        });
        /*  //강사정보 obj  */

        /*  6.선택 obj  */
        var array3 = new Array();
        $('#allMockList tbody tr').each(function(index){
            var mockTitle = $(this).find("td input").eq(0).val();
            var mockKey = $(this).find("td input").eq(1).val();
            var data = {
                linkKey: 0,
                reqKey: 0,
                resKey:mockKey,
                resType: 8,
                resType:1,
                pos: 0,
                valueBit: 0
            };
            array3.push(data);
        });
        $('#examQuestionList tbody tr').each(function(index){
            var examQuestionTitle = $(this).find("td input").eq(0).val()
            var examKey = $(this).find("td input").eq(1).val();
            var data = {
                linkKey: 0,
                reqKey: 0,
                resKey:examKey,
                resType: 9,
                resType:1,
                pos: 0,
                valueBit: 0
            };
            array3.push(data);
        });
        $('#bookList tbody tr').each(function(index){
            var bookTitle = $(this).find("td input").eq(0).val();
            var bookKey = $(this).find("td input").eq(1).val();
            var data = {
                linkKey: 0,
                reqKey: 0,
                resKey:bookKey,
                resType: 5,
                resType:1,
                pos: 0,
                valueBit: 0
            };
            array3.push(data);
        });
        $('#giftList tbody tr').each(function(index){
            var giftTitle = $(this).find("td input").eq(0).val();
            var gifyKey = $(this).find("td input").eq(1).val();
            var data = {
                linkKey: 0,
                reqKey: 0,
                resKey:gifyKey,
                resType: 4,
                resType:1,
                pos: 0,
                valueBit: 0
            };
            array3.push(data);
        });
        data.append("videoInfo", JSON.stringify(obj));
        data.append("videoOptionInfo",JSON.stringify(array));
        data.append("videoCategoryInfo",JSON.stringify(array1));
        data.append("videoLectureInfo",JSON.stringify(lectureObj));
        data.append("videoTeacherInfo",JSON.stringify(array2));
        data.append("videoOtherInfo",JSON.stringify(array3));
        console.log("123123123");
        console.log(data);
        if(confirm("저장하시겠습니까?")) {
            $.ajax({
                url: "/file/productUpload",
                method: "post",
                dataType: "JSON",
                data: data,
                cache: false,
                processData: false,
                contentType: false,
                success: function (data) {
                    console.log(data);
                }
            });
        }

    }


</script>
<div class="page-breadcrumb">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">동영상 등록</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">상품관리</li>
                        <li class="breadcrumb-item active" aria-current="page">동영상상품관리</li>
                        <li class="breadcrumb-item active" aria-current="page">동영상 등록</li>
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
    <input type="button" value="1234" onclick="playSave()">
    <div class="card">
        <div class="card-body wizard-content">
            <h4 class="card-title"></h4>
            <h6 class="card-subtitle"></h6>
            <div id="playForm" method="" action="" class="m-t-40">
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
                                            <input type="checkbox" id="is_sell" name="isSell" style="display:none;">
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
                                            <input type="checkbox" id="is_free" name="isFree" style="display:none;">
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
                                            <input type="checkbox" style="display:none;" id="is_freebie_delivery_free" name="isFreebieDeliveryFree">
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
                                        <input type="number" class="form-control" id="price" name="price">
                                    </td>
                                    <td style="padding: 0.3rem;"><!--판매가-->
                                        <input type="number" class="form-control" id="sellPrice_0" name="sellPrice_0">
                                    </td>
                                    <td style="padding: 0.3rem;"><!--포인트-->
                                        <input type="text" class="form-control" id="point" name="point">
                                    </td>
                                    <td style="padding: 0.3rem;"><!--재수강1-->
                                        <input type="number" style="display: inline-block" class="form-control" id="extendPercent" name="extendPercent" onchange="saleInputPrice(this.value,0)">
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
                                <button type="button" class="btn btn-outline-info mx-auto" onclick="addOption();">추가</button>
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
                                            <td><!--옵션명selbox-->
                                                <select class="col-sm-8 form-control custom-select" id="selCate1" onchange="changesel('selCate2', this.value);">
                                                    <option>선택</option>
                                                </select>
                                            </td>
                                            <td><!--원가-->
                                                <select class="col-sm-8 form-control custom-select" id="selCate2"  onchange="changesel('selCate3', this.value);">
                                                    <option>선택</option>
                                                </select>
                                            </td>
                                            <td><!--판매가-->
                                                <select class="col-sm-8 form-control custom-select" id="selCate3" onchange="changesel('selCate4', this.value);">
                                                    <option>선택</option>
                                                </select>
                                            </td>
                                            <td><!--포인트-->
                                                <select class="col-sm-8 form-control custom-select" id="selCate4" onchange="changesel('selCate5', this.value);">
                                                    <option>선택</option>
                                                </select>
                                            </td>
                                            <td><!--재수강1-->
                                                <select class="col-sm-8 form-control custom-select" id="selCate5" name="ctgKey">
                                                    <option>선택</option>
                                                </select>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <div class="mx-auto" style="width:5.5%">
                                    <button type="button" class="btn btn-outline-info mx-auto" onclick="addCategory();">추가</button>
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
                                <select class="col-sm-3 select2 form-control custom-select" id="set_1" name="classGroupCtgKey">
                                    <option value="">선택</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-1 control-label col-form-label" style="margin-bottom: 0">과목</label>
                                <select class="col-sm-3 select2 form-control custom-select" id="set_2" name="subjectCtgKey">
                                    <option value="">선택</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">유형</label>
                                <select class="col-sm-3 select2 form-control custom-select" id="set_3" name="stepCtgKey">
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
                                <select  class="col-sm-3 select2 form-control custom-select"  id="lectureCnt" name="limitCount">
                                    <option value="">선택</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">수강일수</label>
                                <select class="col-sm-3 select2 form-control custom-select"  id="lectureDayCnt" name="limitDay">
                                    <option value="">선택</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">강좌시간</label>
                                <select class="col-sm-3 select2 form-control custom-select"  id="lectureTimeCnt" name="lecTime">
                                    <option value="">선택</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">배수</label>
                                <input type="text" class="col-sm-3 form-control" style="display: inline-block;" name="multiple"><span style="font-size:11px;vertical-align:middle;color:#999;font-weight:500;margin-left:10px">*배수가 0이면 무제한</span>
                            </div>
                            <div class="form-group">
                                <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">시험대비년도</label>
                                <select class="col-sm-3 select2 form-control custom-select" id="examYearSel" name="examYear">
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
                                        <select class="select2 form-control custom-select" style="height:36px;" id="SubjectList_0" >
                                            <option>선택</option>
                                        </select>
                                    </td>
                                    <td style="padding: 0.3rem; vertical-align: middle;width:2%;text-align: center;">
                                        <i class="m-r-10 mdi mdi-play" style="font-size:18px;color:darkblue"></i>
                                    </td>
                                    <td style="padding: 0.3rem;width: 20%">
                                        <select class="select2 form-control custom-select" style="height:36px;" id="teacherList_0">
                                            <option>선택</option>
                                        </select>
                                    </td>
                                    <td style="padding: 0.3rem;width:60%;text-align:right;vertical-align: middle">
                                        <label style="display: inline-block">조건 : </label>
                                        <input type="text" class="form-control" style="display: inline-block;width:60%" name="calculate_rate"> %
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
                                <button type="button" class="btn btn-outline-info mx-auto" style="margin-bottom:18px;" onclick="addTeacher();">추가</button>
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
                            <button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#sModal4">추가</button>
                        </div>
                        <table class="table text-center table-hover">
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
                            <tbody>
                            <tr>
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
                            </tr>
                            <tr>
                                <td class="text-center" style="padding: 0.3rem;vertical-align: middle">
                                    <span>2</span>
                                </td>
                                <td class="text-left" style="padding: 0.3rem; vertical-align: middle;">
                                    <span>text</span>
                                </td>
                                <td style="padding: 0.3rem;vertical-align: middle">
                                    <span>120</span>
                                </td>
                                <td style="padding: 0.3rem;vertical-align: middle">
                                    <i class="mdi mdi-check" style="color:green;"></i>
                                </td>
                                <td style="vertical-align: middle">
                                    <i class="mdi mdi-check" style="color:green;"></i>
                                </td>
                                <td style="padding: 0.3rem;text-align: center;vertical-align: middle">
                                    <button type="button" class="btn btn-outline-danger btn-sm">삭제</button>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </section>
                    <!-- //7.강의 목록 Tab -->
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


<!-- 강의목록 추가 팝업창 -->
<div class="modal" id="sModal4" tabindex="-1" role="dialog" aria-hidden="true">
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
                        <span style="display: block;padding-top:5px">0</span>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-3 text-right control-label col-form-label">강의 CODE</label>
                    <div class="col-sm-9">
                        <span style="display: block;padding-top:5px">0</span>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-3 text-right control-label col-form-label">강의 이름</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-3 text-right col-sm-2 text-left control-label col-form-label">노출 여부</label>
                    <div class="col-sm-9">
                        <div style="margin-top: -23px;">
                            OFF
                            <label class="switch">
                                <input type="checkbox" />
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
                                <input type="checkbox" />
                                <span class="slider"></span>
                            </label>
                            ON
                        </div>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-3 text-right control-label col-form-label">동영상 저화질 경로</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group row">
                    <label  class="col-sm-3 text-right control-label col-form-label">동영상 고화지 경로</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group row">
                    <label  class="col-sm-3 text-right control-label col-form-label">모바일용 동영상 저화질 경로</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group row">
                    <label  class="col-sm-3 text-right control-label col-form-label">모바일용 동영상 고화질 경로</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-3 text-right control-label col-form-label" style="margin-bottom: 0">강의 자료</label>
                    <div class="col-sm-9">
                        <div class="custom-file">
                            <input type="file" class="custom-file-input" id="validatedCustomFile" required>
                            <label class="custom-file-label" for="validatedCustomFile">Choose file...</label>
                            <div class="invalid-feedback">Example invalid custom file feedback</div>
                        </div>
                    </div>
                </div>
                <div class="form-group row">
                    <label  class="col-sm-3 text-right control-label col-form-label">강의 시간 (분단위)</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="scode">
                    </div>
                </div>
                <div class="form-group row">
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
                </div>
                <button type="button" class="mt-3 mb-1 btn btn-info float-right">확인</button>
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
            transitionEffect: "slideLeft",
            onFinished: function(event, currentIndex) {
                playSave();
            }
            /*onStepChanging: function(event, currentIndex, newIndex) {
               // form.validate().settings.ignore = ":disabled,:hidden";
                //return form.valid();
            },
            onFinishing: function(event, currentIndex) {
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
