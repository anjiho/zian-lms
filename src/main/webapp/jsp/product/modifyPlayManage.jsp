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
            height: 430,
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
            }
        });
        //탭 메뉴 색상 변경
        $("#playForm ul").each(function(idx) {
            var ul = $(this);
            ul.find("li").addClass("done").attr("aria-selected", "false");
            ul.find("li").eq(0).removeClass("done").attr("aria-selected", "true");
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

    //테이블 로우 삭제
    function deleteTableRow(tableId) {
        $("#categoryTable > tbody > tr").length;

        if (tableId == "productOption") {
            if ($("#optionTable > tbody > tr").length == 1) {
                $('#optionTable > tbody:first > tr:first').attr("style", "display:none");
            } else {
                $('#optionTable > tbody:last > tr:last').remove();
            }
        } else if (tableId == "productCategory") {
            if ($("#categoryTable > tbody > tr").length == 1) {
                $('#categoryTable > tbody:first > tr:first').attr("style", "display:none");
            } else {
                $('#categoryTable > tbody:last > tr:last').remove();
            }
        } else if (tableId == "productTeacher") {
            if ($("#teacherTable > tbody > tr").length == 1) {
                $('#teacherTable > tbody:first > tr:first').attr("style", "display:none");
            } else {
                $('#teacherTable > tbody:last > tr:last').remove();
            }
        }  else if(tableId == 'productBook'){
            $('#bookTable > tbody:last > tr:last').remove();
        }
    }
    //옵션 추가 버튼
    function addProductOptionInfo() {
        var fistTrStyle = $("#optionList tr").eq(0).attr("style");

        if (fistTrStyle == "display:none") {
            $('#optionList tr').eq(0).removeAttr("style", null);
        } else {
            var $tableBody = $("#optionTable").find("tbody"),
                $trLast = $tableBody.find("tr:last"),
                $trNew = $trLast.clone();
            $trLast.after($trNew);

            $trNew.find("td select").val('');
            $trNew.find("td input").eq(0).val('');
            $trNew.find("td input").eq(1).val('');
            $trNew.find("td input").eq(2).val('');
            $trNew.find("td input").eq(3).val('');
            $trNew.find("td span").html('');
            $trNew.find("td button").attr('disabled', false);
            $trNew.find("td").eq(7).attr('style', "display:''");
        }
    }

    //카테고리 추가 버튼
    function addCategoryInfo() {
        var fistTrStyle = $("#categoryList tr").eq(0).attr("style");

        if (fistTrStyle == "display:none") {
            $('#categoryList tr').eq(0).removeAttr("style", null);
        } else {
            var $tableBody = $("#categoryTable").find("tbody"),
                $trLast = $tableBody.find("tr:last"),
                $trNew = $trLast.clone();
            $trLast.after($trNew);

            $trNew.find("td input").eq(0).val("");
            $trNew.find("td").eq(1).html("지안에듀");
            getCategoryNoTag('categoryTable','1183', '3');
            $trNew.find("td").eq(5).html(defaultCategorySelectbox());
            $trNew.find("td").eq(7).html(defaultCategorySelectbox());
            $trNew.find("td").eq(9).html(defaultCategorySelectbox());
        }
    }

    //교사 추가 버튼
    function addTeacherInfo() {
        var fistTrStyle = $("#teacherList tr").eq(0).attr("style");

        if (fistTrStyle == "display:none") {
            $('#teacherList tr').eq(0).removeAttr("style", null);
        } else {
            var $tableBody = $("#teacherTable").find("tbody"),
                $trLast = $tableBody.find("tr:last"),
                $trNew = $trLast.clone();
            $trLast.after($trNew);

            $trNew.find("td input").eq(0).val("");
            $trNew.find("td input").eq(1).val("");
            $trNew.find("td input").eq(2).val("");

            getSelectboxListForCtgKeyNoTag('teacherTable', '70', 2);
            selectTeacherSelectboxNoTag('teacherTable', 4);
        }
    }

    function setSubjectValue(val, cnt) {
        if (val != undefined && cnt != undefined) {
            innerValue("subjectHidden_" + cnt, val);
        }
    }

    function setTeacherValue(val, cnt) {
        if (val != undefined && cnt != undefined) {
            innerValue("teacherHidden_" + cnt, val);
        }
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

    //카테코리 셀렉트 박스 변경 시
    function changeCategory(tableId, val, tdNum) {
        getCategoryNoTag(val, tableId, tdNum);
    }
    //강사목록 새로 등록하는 값 주입하기(강사키)
    function injectSubjectKey(val) {
        $("#teacherTable").find("tbody").find("tr:last").find("td input").eq(1).val(val);
    }
    //강사목록 새로 등록하는 값 주입하기(과목키)
    function injectTeacherKey(val) {
        $("#teacherTable").find("tbody").find("tr:last").find("td input").eq(0).val(val);
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

    // 강의교재 / 사은품 전달값
    function sendChildValue_2(examKey,set) {
        var sendKey = "";
        if(set == 'bookBtn'){
            sendKey = 5;
        }else if(set == 'giftBtn'){
            sendKey = 4;
        }
        productManageService.getGoodsListFromTLinkKey(examKey, sendKey,function (selList) {
            console.log(selList);
            var allMockCnt = $("#bookList tr").length-1; //모의고사
            var examQuestionListCnt = $("#giftList tr").length-1;//기출문제

            var deleteSel = "";
            var getallMockOption = "";
            if(set == 'bookBtn'){
                getallMockOption = "MockName_"+allMockCnt;
                deleteSel = "allMockTitleDelete";
            }else if(set == 'giftBtn'){
                getallMockOption = "examName_"+examQuestionListCnt;
                deleteSel = "examQuestionDelete";
            }

           /* if (selList.mokExamInfo) {
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
            }*/
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

        function setCategoryCtgKey(val, tagId) {
            innerValue("categoryCtgKey_" + tagId, val);
        }

        function playDetailList() { //동영상정보
            productManageService.getProductDetailInfo(gKey, 'VIDEO', function (selList) {
                console.log(">");
                console.log(selList);
                if (selList.productInfo) {/*---기본정보---*/
                    innerValue("name", selList.productInfo.name);//이름
                    innerValue("indate", split_minute_getDay(selList.productInfo.indate));//등록일
                    innerValue("sellstartdate", split_minute_getDay(selList.productInfo.sellstartdate));//판매시작일
                    isCheckbox("isShow", selList.productInfo.isShow);//노출
                    isCheckbox("isSell", selList.productInfo.isSell);//판매
                    isCheckbox("isFree", selList.productInfo.isFree);//무료
                    if (selList.productInfo.imageList != null) {
                        $('.custom-file-control').html(fn_clearFilePath(selList.productInfo.imageList));//리스트이미지
                    }
                    if (selList.productInfo.imageView != null) {
                        $('.custom-file-control1').html(fn_clearFilePath(selList.productInfo.imageView));//상세이미지
                    }
                    $("#emphasis").val(selList.productInfo.emphasis);//강조표시
                    isCheckbox("isFreebieDeliveryFree", true);//사은품 배송비무료
                    //innerValue("description", selList.productInfo.description);//상세설명
                    $("#description").summernote("code", selList.productInfo.description);
                    //console.log(">>" + selList.productInfo.description);
                }
            /**
             * 학원 옵션정보 가져오기
             */
                var productOptionInfo = selList.productOptionInfo;
                if (productOptionInfo.length == 0) {
                    var cellData = [
                        function() {return getOptionSelectbox("", true);},
                        function() {return "<input type=\"text\" class=\"form-control \" name=\"price[]\" id='price_0'>"},
                        function() {return "<input type=\"text\" class=\"form-control \" name=\"sellPrice[]\" id='sellPrice_0'>"},
                        function() {return "<input type=\"text\" class=\"form-control \" name=\"point[]\" id='point_0'>"},
                        function() {return "<input type=\"text\" class=\"form-control \" name=\"expendPercent[]\" id='point_0' onkeypress='saleInputPrice($(this));'>"},
                        function() {return "%"},
                        function() {return "<span id='sum_0'></span>"},
                        function() {return "<button type=\"button\" onclick=\"deleteTableRow('productOption');\" class=\"btn btn-outline-danger btn-sm\" style=\"margin-top:8%;\" >삭제</button>"}
                    ];
                    dwr.util.addRows("optionList", [0], cellData, {escapeHtml: false});
                    $('#optionList tr').eq(0).attr("style", "display:none");

                } else {
                    dwr.util.addRows("optionList", productOptionInfo, [
                        function(data) {return getOptionSelectbox(data.kind, true);},
                        function(data) {return "<input type=\"text\" class=\"form-control \" name=\"price[]\" id='price_" + data.priceKey + "'  value='"+ data.price +"' >"},
                        function(data) {return "<input type=\"text\" class=\"form-control \" name=\"sellPrice[]\" id='sellPrice_" + data.priceKey + "'  value='"+ data.sellPrice +"' >"},
                        function(data) {return "<input type=\"text\" class=\"form-control \" name=\"point[]\" id='point_" + data.priceKey + "'  value='"+ data.point +"' >"},
                        function(data) {return "<input type=\"text\" class=\"form-control \" name=\"expendPercent[]\" id='point_" + data.priceKey + "'  value='"+ data.extendPercent +"' onkeypress='saleInputPrice($(this));'>"},
                        //function(data) {return "<input type=\"text\" class=\"form-control \" name=\"expendPercent[]\" id='point_" + data.priceKey + "'  value='"+ data.extendPercent +"' onkeypress='saleInputPrice(this.value"+ ","+ '"' + data.sellPrice + '"' + ","+ '"' + data.priceKey + '"' + ");'>"},
                        function(data) {return "%"},
                        function(data) {return "<span id='sum_" + data.priceKey + "'>" + Math.round(data.sellPrice -((data.sellPrice * data.extendPercent) / 100)) + "</span>"},
                        function(data) {return "<button type=\"button\" onclick=\"deleteTableRow('productOption');\" class=\"btn btn-outline-danger btn-sm\" style=\"margin-top:8%;\" >삭제</button>"}
                    ], {escapeHtml:false});
                    $('#optionList tr').eq(0).children().eq(7).attr("style", "display:none");
                }
            /**
             * 학원 카테고리 정보 가져오기
             */
            var productCategoryInfo = selList.productCategoryInfo;
            var nextIcon = "<i class=\"m-r-10 mdi mdi-play\" style=\"font-size:18px;color:darkblue\"></i>";

            if (productCategoryInfo.length == 0) {
                var cellData = [
                    function() {return "<input type='hidden' name='inputCtgKey[]' value=''>";},
                    function() {return "지안에듀";},
                    function() {return nextIcon},
                    function() {return getCategoryNoTag('categoryTable','1183', '3');},
                    function() {return nextIcon},
                    function() {return defaultCategorySelectbox();},
                    function() {return nextIcon},
                    function() {return defaultCategorySelectbox();},
                    function() {return nextIcon},
                    function() {return defaultCategorySelectbox();},
                    function() {return "<button type=\"button\" onclick=\"deleteTableRow('productCategory');\" class=\"btn btn-outline-danger btn-sm\" style=\"margin-top:8%;\" >삭제</button>"},
                ];
                dwr.util.addRows("categoryList", [0], cellData, {escapeHtml: false});
                $('#categoryList tr').eq(0).attr("style", "display:none");
            }

            dwr.util.addRows("categoryList", productCategoryInfo, [
                function(data) {return "<input type='hidden' name='inputCtgKey[]' value='"+data[0].ctgKey+"'>";},
                function() {return "지안에듀";},
                function() {return nextIcon},
                function(data) {return data[3].name;},
                function() {return nextIcon},
                function(data) {return data[2].name;},
                function() {return nextIcon},
                function(data) {return data[1].name;},
                function() {return nextIcon},
                function(data) {return data[0].name;},
                function(data) {return "<button type=\"button\" onclick=\"deleteTableRow('productCategory');\" class=\"btn btn-outline-danger btn-sm\" style=\"margin-top:8%;\" >삭제</button>"},
                // function(data) {return "<input type='hidden' name='selOption[]' value='" + data[0].ctgKey + "'>";}
            ], {escapeHtml:false});

            $('#categoryList tr').each(function(){
                var tr = $(this);
                tr.children().eq(0).attr("style", "display:none");
                tr.children().eq(11).attr("style", "display:none");
            });
            /**
             * 학원 강좌정보 가져오기
             */
            if (selList.productLectureInfo == null) {
                getNewSelectboxListForCtgKey("l_classGroup", "4309", "");
                getNewSelectboxListForCtgKey2("l_subjectGroup", "70", "");
                getNewSelectboxListForCtgKey3("l_stepGroup", "202", "");
                getLectureStatusSelectbox("status", "");//강좌정보- 진행상태
                getLectureCountSelectbox("limitCount", "");//강좌정보 강좌수
                getClassRegistraionDaySelectbox("limitDay", "");//수강일수
                getLectureCountSelectbox("lecTime", "");//강좌시간
                getExamPrepareSelectbox("examYear", "");//시험대비년도 셀렉트박스
                getLectureCountSelectbox("limitCount", "");//강좌정보 강좌수
                getClassRegistraionDaySelectbox("limitDay", "");//수강일수
                getLectureCountSelectbox("lecTime", "");//강좌시간
                innerValue("multiple", gfn_zeroToZero("0"));//배수
            } else {
                var productLectureInfo = selList.productLectureInfo;
                getNewSelectboxListForCtgKey("l_classGroup", "4309", productLectureInfo.classGroupCtgKey);
                getNewSelectboxListForCtgKey2("l_subjectGroup", "70", productLectureInfo.subjectCtgKey);
                getNewSelectboxListForCtgKey3("l_stepGroup", "202", productLectureInfo.stepCtgKey);
                getLectureStatusSelectbox("status", productLectureInfo.status);//강좌정보- 진행상태
                getLectureCountSelectbox("limitCount", productLectureInfo.limitCount);//강좌정보 강좌수
                getClassRegistraionDaySelectbox("limitDay", productLectureInfo.limitDay);//수강일수
                getLectureCountSelectbox("lecTime", productLectureInfo.lecTime);//강좌시간
                getExamPrepareSelectbox("examYear", productLectureInfo.examYear);//시험대비년도 셀렉트박스
                getLectureCountSelectbox("limitCount", productLectureInfo.limitCount);//강좌정보 강좌수
                getClassRegistraionDaySelectbox("limitDay", productLectureInfo.limitDay);//수강일수
                getLectureCountSelectbox("lecTime", productLectureInfo.lecTime);//강좌시간
                innerValue("multiple", gfn_zeroToZero(productLectureInfo.multiple));//배수
            }

        //동영상 - 강의목록 불러오기
        productManageService.getLectureCurriList(selList.productLectureInfo.lecKey, function (selList) {
            $( "#lectureCurriTabel tbody" ).sortable({
                update: function( event, ui ) {
                    $(this).children().each(function(index) {
                        $(this).find('tr').last().html(index + 1);
                    });
                }
            });
            if (selList.length > 0) {
                for (var i = 0; i < selList.length; i++) {
                    console.log(">>");
                    console.log(selList);
                    var cmpList = selList[i];
                    if (cmpList != undefined) {
                        var text = "'CURRI'";
                        var btn = '<button type="button" onclick="deleteOtherInfo(' + cmpList.curriKey + "," + text + ')"  class="btn btn-outline-danger btn-sm">삭제</button>';
                        var deleteBtn =  '<button type="button" onclick="LectureCurriPopup('+cmpList.curriKey+')"  class="btn btn-success btn-sm" data-toggle="modal" data-target="#lectureListPopup">수정</button>';
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


        /**
         * 강사 목록 가져오기
         */
        var productTeacherInfo = selList.productTeacherInfo;
        var nextIcon = "<i class=\"m-r-10 mdi mdi-play\" style=\"font-size:18px;color:darkblue\"></i>";

        if (productTeacherInfo.length == 0) {
            var cellData = [
                function() {return "<input type='hidden'  name='teacherKeys[]' value=''>";},
                function() {return "<input type='hidden'  name='subjectKeys[]' value=''>";},
                function() {return getSelectboxListForCtgKeyNoTag('teacherTable', '70', 2);},
                function() {return nextIcon},
                function() {return selectTeacherSelectboxNoTag('teacherTable', 4);},
                function() {return "<input type='text' name='calcRate[]' class='form-control' >"},
                function() {return "<button type=\"button\" onclick=\"deleteTableRow('productTeacher');\" class=\"btn btn-outline-danger btn-sm\" style=\"margin-top:8%;\" >삭제</button>"},
            ];
            dwr.util.addRows("teacherList", [0], cellData, {escapeHtml: false});
            $('#teacherList tr').eq(0).attr("style", "display:none");
            $('#teacherList tr').each(function(){
                var tr = $(this);
                tr.children().eq(0).attr("style", "display:none");
                tr.children().eq(1).attr("style", "display:none");
            });
        } else {
            for (var i = 0; i < productTeacherInfo.length; i++) {
                var cmpList = productTeacherInfo[i];
                var cellData = [
                    function() {return "<input type='hidden' name='teacherKeys[]' value='" + cmpList.teacherKey + "'>";},
                    function() {return "<input type='hidden' name='subjectKeys[]' value='" + cmpList.subjectCtgKey + "'>";},
                    function() {return cmpList.subjectName},
                    function() {return nextIcon},
                    function() {return cmpList.teacherName},
                    function() {return "<input type='text' name='calcRate[]' class='form-control' value='"+ cmpList.calculateRate +"'>"},
                    function() {return "<button type=\"button\" onclick=\"deleteTableRow('productTeacher');\" class=\"btn btn-outline-danger btn-sm\" style=\"margin-top:8%;\" >삭제</button>"},
                ];
                dwr.util.addRows("teacherList", [0], cellData, {escapeHtml: false});
            }
            $('#teacherList tr').each(function(){
                var tr = $(this);
                tr.children().eq(0).attr("style", "display:none");
                tr.children().eq(1).attr("style", "display:none");
            });
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
                            function LectureCurriPopup(curriKey) {
                                productManageService.getLectureCurriInfo(curriKey, function (info) {
                                    innerValue("curriKey", info.curriKey);
                                    innerValue("lectureName", info.name);//강의이름
                                    // //노출여부,샘플여부
                                    isCheckbox("lectureIsShow", info.isShow);//노출
                                    isCheckbox("isSample", info.isSample);//판매
                                    innerValue("vodFileLow", info.vodFileLow);//동영상 저화질 경로
                                    innerValue("vodFileHigh", info.vodFileHigh);//동영상 저화질 경로
                                    innerValue("vodFileMobileLow", info.vodFileMobileLow);//모바일 동영상 저화질 경로
                                    innerValue("vodFileMobileHigh", info.vodFileMobileHigh);//모바일동영상 저화질 경로
                                    // //강의자료
                                    innerValue("l_lectureFile", info.dataFile == null ? "" : $('.custom-file-control2').html(fn_clearFilePath(info.dataFile)));
                                    innerValue("vodTime", info.vodTime);
                                });
                            }
                            //옵션 - 할인률 계산
                            function saleInputPrice(val) {
                                var checkBtn = val;

                                var tr = checkBtn.parent().parent();
                                var td = tr.children();

                                var sellPrice = td.find("input").eq(0).val();
                                var extendPercent = td.find("input").eq(3).val();

                                var sum = Math.round(sellPrice -((sellPrice * extendPercent) / 100));
                                td.find("span").html(sum);
                                //innerHTML(calcPrice, sum);
                                }
                            //강의목록- 입력 저장
                            function videoLectureSave() {
                                var lecKey = getInputTextValue("curri_lecKey");
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
                                            var curriKey = getInputTextValue("curriKey");
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
                                                curriKey:curriKey == undefined ? 0 : curriKey,
                                                lecKey:lecKey,
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
                                            if (curriKey == undefined || curriKey == null || curriKey == "") {
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
                                            } else {
                                                productManageService.updateTLecCurri(data, function () {
                                                        alert("수정되었습니다.");
                                                });
                                            }
                                        }
                                    });
                            }

                            //기본정보 수정 함수
                            function basicModify() {
                                var fileData = new FormData();
                                $.each($('#imageListFile')[0].files, function(i, file) {
                                    fileData.append('imageListFile', file);
                                });

                                $.each($('#imageViewFile')[0].files, function(i, file) {
                                    fileData.append('imageViewFile', file);
                                });

                                if(confirm("기본정보를 수정 하시겠습니까?")){
                                    $.ajax({
                                        url: "/file/updateVideoInfo",
                                        method: "post",
                                        dataType: "JSON",
                                        data: fileData,
                                        cache: false,
                                        processData: false,
                                        contentType: false,
                                        success: function (data) {
                                            var result = JSON.stringify(data.result);
                                            var data = getJsonObjectFromDiv("section1");

                                            if(data.isShow == 'on')  data.isShow = '1';//노출 checkbox
                                            else data.isShow = '0';
                                            if(data.isSell == 'on')  data.isSell = '1';//판매
                                            else data.isSell = '0';
                                            if(data.isFree == 'on')  data.isFree = '1';//무료
                                            else data.isFree = '0';
                                            if(data.isFreebieDeliveryFree == 'on')  data.isFreebieDeliveryFree = '1';//사은품배송비무료
                                            else data.isFreebieDeliveryFree = '0';

                                            var imageListFile = "";
                                            var imageViewFile = "";
                                            if(result != "") {
                                                var parse = JSON.parse(result);
                                                imageListFile = parse.imageListFilePath;
                                                imageViewFile = parse.imageViewFilePath;
                                            }
                                            productManageService.updateGoodsInfo(data, data.gKey, imageListFile, imageViewFile,function (data) {
                                                isReloadPage(true);
                                            });
                                        }
                                    });
                                }
                            }

        //옵션정보 수정
        function updateOptionInfo() {
            var optionNames = get_array_values_by_name("select", "selOption[]");
            var optionPrices = get_array_values_by_name("input", "price[]");
            var sellPrices = get_array_values_by_name("input", "sellPrice[]");
            var points = get_array_values_by_name("input", "point[]");
            var expendPercents = get_array_values_by_name("input", "expendPercent[]");

            var dataArr = new Array();
            for (var i=0; i<optionNames.length; i++) {
                var data = {
                    priceKey:'0',
                    gKey:'0',
                    kind:optionNames[i],
                    ctgKey:'0',
                    name:'0',
                    price:optionPrices[i],
                    sellPrice:sellPrices[i],
                    point:points[i],
                    extendPercent:expendPercents[i]
                }
                dataArr.push(data)
            }
            if(confirm("옵션정보를 수정 하시겠습니까?")){
                productManageService.upsultTGoodsPriceOption(dataArr, gKey,function () {
                    isReloadPage(true);
                });
            }
        }

        //카테고리정보 수정
        function updateCategoryInfo() {
            var ctgKeys = get_array_values_by_name("input", "inputCtgKey[]");

            if(confirm("카테고리를 수정 하시겠습니까?")){

                var fistTrStyle = $("#categoryList tr").eq(0).attr("style");

                if (fistTrStyle == "display:none") {
                    productManageService.deleteTCategoryGoods(gKey, function(){
                        isReloadPage(true);
                    });
                } else {
                    var dataArr = new Array();
                    $.each(ctgKeys, function(index, key) {
                        var data = {
                            ctgGKey:0,
                            ctgKey:key,
                            gKey:0,
                            pos:0
                        };
                        dataArr.push(data);
                    });
                    productManageService.upsultTCategoryGoods(dataArr, gKey,function () {
                        isReloadPage(true);
                    });
                }
            }
        }



    //강좌정보 수정
    function updateLectureInfo() {
        if (confirm("강좌정보를 수정 하시겠습니까?")) {
            var lectureObj = getJsonObjectFromDiv("section4");
            productManageService.upsultTLec(lectureObj, gKey,function () {
                isReloadPage(true);
            });
        }
    }

    //강사목록 수정 버튼
    function updateTeacherList() {
        var teacherKeys = get_array_values_by_name("input", "teacherKeys[]");
        var subjectKeys = get_array_values_by_name("input", "subjectKeys[]");
        var calcRates = get_array_values_by_name("input", "calcRate[]");

        if(confirm("강좌정보를 수정 하시겠습니까?")) {

            var fistTrStyle = $("#teacherList tr").eq(0).attr("style");

            if (fistTrStyle == "display:none") {
                productManageService.deleteTGoodsTeacherLinkByGkey(gKey, function(){
                    location.reload();
                });
            } else {
                var dataArr = new Array();
                for (var i=0; i<teacherKeys.length; i++) {
                    var data = {
                        gTeacherKey:0,
                        isPublicSubject:0,
                        subjectCtgKey : subjectKeys[i],
                        teacherKey : teacherKeys[i],
                        calculateRate : calcRates[i],
                        subjectName: "",
                        teacherName: ""
                    }
                    dataArr.push(data);
                }
                productManageService.upsultTGoodTeacherLink(dataArr, gKey,function () {
                    isReloadPage(true);
                });
            }
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
                    <div>
                    <!-- 1.기본정보 Tab -->
                    <h3>기본정보</h3>
                    <section class="col-md-auto">
                    <div id="section1">
                        <input type="hidden" value="<%=gKey%>" name="gKey">
                        <input type="hidden" value="0" name="cpKey">
                        <input type="hidden" value="0" name="isNodc">
                        <input type="hidden" value="0" name="tags">
                        <input type="hidden" value="0" name="calculateRate">
                        <input type="hidden" value="0" name="isQuickDelivery">
                        <input type="hidden" value="" name="goodsId">
                        <input type="hidden" value="" name="goodsTypeName">
                        <input type="hidden" value="" name="summary">
                        <button type="button" class="btn btn-outline-primary btn-sm float-right" onclick="basicModify();">수정</button>
                        <div class="col-md-6">
                            <div class="form-group row">
                                <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">상품타입</label>
                                <span>온라인강좌</span>
                                <input type="hidden" id="type" name='type' class="col-sm-6 bg-light required form-control" value="1" readonly>
                            </div>
                            <div class="form-group row">
                                <label for="lname" class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">이름</label>
                                <input type="text" class="col-sm-6 form-control" id="name" name="name">
                            </div>
                            <div class="form-group row">
                                <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">등록일</label>
                                <div class="col-sm-6 input-group pl-0 pr-0">
                                    <input type="text" class="form-control mydatepicker" placeholder="yyyy.mm.dd" name="indate" id="indate">
                                    <div class="input-group-append">
                                        <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">판매시작일</label>
                                <div class="col-sm-6 input-group pl-0 pr-0">
                                    <input type="text" class="form-control mydatepicker" placeholder="mm/dd/yyyy" name="sellstartdate" id="sellstartdate">
                                    <div class="input-group-append">
                                        <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group row mt-4">
                                <label class="col-sm-2 text-left control-label col-form-label">노출</label>
                                <div class="col-sm-10">
                                    <div style="margin-top: -23px;">
                                        OFF
                                        <label class="switch">
                                            <input type="checkbox" id="isShow" name="isShow" style="display:none;" />
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
                            <div class="form-group row">
                                <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">리스트이미지</label>
                                <div class="col-sm-8 pl-0 pr-0">
                                    <div class="custom-file">
                                        <input type="file" class="custom-file-input" id="imageListFile"  name="imageListFile" required>
                                        <label class="custom-file-control custom-file-label">Choose file...</label>

                                    </div>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">상세이미지</label>
                                <div class="col-sm-8 pl-0 pr-0">
                                    <div class="custom-file">
                                        <input type="file" class="custom-file-input"  id="imageViewFile" name="imageViewFile" required>
                                        <span class="custom-file-control1 custom-file-label"></span>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label  class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">강조표시</label>
                                <div class="col-sm-6 pl-0 pr-0">
                                    <select class="select2 form-control custom-select" id="emphasis" name="emphasis">
                                        <option value="0">없음</option>
                                        <option value="1">BEST</option>
                                        <option value="2">NEW</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-sm-2 control-label col-form-label">사은품 배송비무료</label>
                                <div class="col-sm-10">
                                    <div style="margin-top: -23px;">
                                        OFF
                                        <label class="switch">
                                            <input type="checkbox"  id="isFreebieDeliveryFree" name="isFreebieDeliveryFree" style="display:none;">
                                            <span class="slider"></span>
                                        </label>
                                        ON
                                    </div>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">상세설명</label>
                                <textarea class="col-sm-10 form-control" value="" id="description" name="description"></textarea>
                            </div>
                        </div>
                    </div>
                </section>
<!-- // 1.기본정보 Tab -->

<!-- 2.옵션 Tab -->
<h3>옵션</h3>
<section>
    <div class="float-right mb-3">
        <input type="button" value="수정" class="btn btn-outline-primary btn-sm" onclick="updateOptionInfo();">
    </div>
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
            <tbody id="optionList"> </tbody>
        </table>
        <div class="mx-auto" style="width:5.5%">
            <button type="button" class="btn btn-outline-info mx-auto" onclick="addProductOptionInfo();">추가</button>
        </div>
    </div>
</section>
<!-- //2.옵션 Tab -->

<!-- 3.카테고리 목록 Tab -->
<h3>카테고리</h3>
<section>
    <div class="float-right mb-3">
        <input type="button" value="수정" class="btn btn-outline-primary btn-sm"  onclick="updateCategoryInfo();">
    </div>
    <div id="section3">
        <table class="table" id="categoryTable">
            <input type="hidden" name="ctgGKey" value="0">
            <input type="hidden" name="gKey" value="0">
            <input type="hidden" name="pos" value="0">
            <thead>
            <tr style="display:none;">
                <th></th>
                <th scope="col"></th>
                <th scope="col"></th>
                <th scope="col"></th>
                <th scope="col"></th>
                <th scope="col"></th>
                <th scope="col"></th>
                <th scope="col"></th>
            </tr>
            </thead>
            <tbody id="categoryList"></tbody>
        </table>
        <div class="mx-auto" style="width:5.5%">
            <button type="button" class="btn btn-outline-info mx-auto" onclick="addCategoryInfo('new');">추가</button>
        </div>
    </div>
</section>
<!-- //3.카테고리 목록 Tab -->

<!-- 4.강좌 정보 Tab -->
<h3>강좌정보</h3>
<section>
    <div class="float-right mb-3">
        <input type="button" value="수정" class="btn btn-outline-primary btn-sm" onclick="updateLectureInfo();">
    </div>
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
            <span id="l_classGroup"></span>
        </div>
        <div class="form-group">
            <label class="col-sm-1 control-label col-form-label" style="margin-bottom: 0">과목</label>
            <span id="l_subjectGroup"></span>
        </div>
        <div class="form-group">
            <label class=" col-sm-1 control-label col-form-label" style="margin-bottom: 0">유형</label>
            <span id="l_stepGroup"></span>
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
    <div class="float-right mb-3">
        <input type="button" value="수정" class="btn btn-outline-primary btn-sm" onclick="updateTeacherList();">
    </div>
    <div id="section5">
        <table class="table" id="teacherTable">
            <input type="hidden" id="gTeacherKey_0" >
            <input type="hidden" id="subjectHidden_0" >
            <input type="hidden" id="teacherHidden_0" >
            <input type="hidden" name="gKey" value="0">
            <colgroup>
                <col width="30%" />
                <col width="10%" />
                <col width="30%" />
                <col width="30%" />
            </colgroup>
            <thead>
            <tr style="">
                <th>과목</th>
                <th></th>
                <th>선생님명</th>
                <th>정산률(%)</th>
            </tr>
            </thead>
            <tbody id="teacherList"></tbody>
        </table>
        <div class="mx-auto" style="width:5.5%">
            <button type="button" class="btn btn-outline-info mx-auto" style="margin-bottom:18px;" onclick="addTeacherInfo('new');">추가</button>
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
        <!--<table class="table text-center table-hover" id="bookList">
            <thead>
            <tr>
                <th scope="col" colspan="3">강의교재
                <button type="button"  style="float: right" class="btn btn-outline-info btn-sm" data-toggle="modal" data-target="#bookModal" onclick="fn_search3('new');">추가</button>
                </th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>-->
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
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
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
<div class="modal fade" id="lectureListPopup" tabindex="-1" role="dialog" aria-hidden="true">
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
        <input type="hidden" id="curri_lecKey">
        <input type="hidden" id="curriKey">
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
<%--                            <span id="l_lectureFile"></span>--%>
                </div>
            </div>
        </div>
        <div class="form-group row">
            <label  class="col-sm-3 text-right control-label col-form-label">강의 시간 (분단위)</label>
            <div class="col-sm-9">
                <input type="number" class="form-control" id="vodTime" name="vodTime">
            </div>
        </div>
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
    enablePagination : false,
onFinished: function(event, currentIndex) {
    playSave();
},
// onContentLoaded: function (event, currentIndex) {
//
// }
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
<script src='https://code.jquery.com/ui/1.11.4/jquery-ui.min.js'></script>
