<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<%
    String gKey = request.getParameter("param_key");
%>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/productManageService.js'></script>
<script>
    var gKey = '<%=gKey%>';
    function init() {
        menuActive('menu-1', 5);
        getCategoryList("sel_category","214");
        getProductSearchTypeSelectbox("l_productSearch");
        $('#bookTable tr').eq(0).attr("style", "display:none");
        productManageService.getBookDetailInfo(gKey, function(info) {
            /*1. 기본정보 가져오기 */
            var productInfo = info.productInfo;
            innerValue("name", productInfo.name);
            innerValue("indate", split_minute_getDay(productInfo.indate));
            innerValue("sellstartdate", split_minute_getDay(productInfo.sellstartdate));
            isCheckboxByNumber("isShow", productInfo.isShow);//노출
            isCheckboxByNumber("isSell", productInfo.isSell);//판매
            isCheckboxByNumber("isFree", productInfo.isFree);//무료
            isCheckboxByNumber("isFreebieDeliveryFree", productInfo.isFreebieDeliveryFree);//판매
            isCheckboxByNumber("isQuickDelivery", productInfo.isQuickDelivery);//무료
            if (productInfo.imageList != null) {
                $('.custom-file-control').html(fn_clearFilePath(productInfo.imageList));//리스트이미지
            }
            if (productInfo.imageView != null) {
                $('.custom-file-control1').html(fn_clearFilePath(productInfo.imageView));//상세이미지
            }
            getEmphasisSelectbox("l_emphasis", productInfo.emphasis);
            innerValue("calculateRate", productInfo.calculateRate);
            $("#description1").summernote("code", productInfo.description);

            /*2. 옵션 가져오기 */
            var productOptionInfo = info.productOptionInfo;
            if (productOptionInfo.length == 0) {
                var cellData = [
                    function() {return "기본옵션"},
                    function() {return "<input type=\"text\" class=\"form-control \" name=\"price[]\" id='price_0'>"},
                    function() {return "<input type=\"text\" class=\"form-control \" name=\"sellPrice[]\" id='sellPrice_0'>"},
                    function() {return "<input type=\"text\" class=\"form-control \" name=\"point[]\" id='point_0'>"},
                    function() {return "<input type=\"text\" class=\"form-control \" name=\"expendPercent[]\" id='point_0' onkeyup='saleInputPrice($(this));'>"},
                    function() {return "%"},
                    function() {return "<span id='sum_0'></span>"},
                    function() {return "<button type=\"button\" onclick=\"deleteTableRow('optionTable', 'delBtn');\" class=\"btn btn-outline-danger btn-sm delBtn\">삭제</button>"}
                ];
                dwr.util.addRows("optionList", [0], cellData, {escapeHtml: false});
                $('#optionList tr').eq(0).attr("style", "display:none");

            } else {
                dwr.util.addRows("optionList", productOptionInfo, [
                    function(data) {return "기본옵션"},
                    function(data) {return "<input type=\"text\" class=\"form-control \" name=\"price[]\" id='price_" + data.priceKey + "'  value='"+ format(data.price) +"' >"},
                    function(data) {return "<input type=\"text\" class=\"form-control \" name=\"sellPrice[]\" id='sellPrice_" + data.priceKey + "'  value='"+ format(data.sellPrice) +"' >"},
                    function(data) {return "<input type=\"text\" class=\"form-control \" name=\"point[]\" id='point_" + data.priceKey + "'  value='"+ format(data.point) +"' >"},
                    function(data) {return "<input type=\"text\" class=\"form-control \" name=\"expendPercent[]\" id='point_" + data.priceKey + "'  value='"+ data.extendPercent +"' onkeyup='saleInputPrice($(this));'>"},
                    //function(data) {return "<input type=\"text\" class=\"form-control \" name=\"expendPercent[]\" id='point_" + data.priceKey + "'  value='"+ data.extendPercent +"' onkeypress='saleInputPrice(this.value"+ ","+ '"' + data.sellPrice + '"' + ","+ '"' + data.priceKey + '"' + ");'>"},
                    function(data) {return "%"},
                    function(data) {return "<span id='sum_" + data.priceKey + "'>" + format(Math.round(data.sellPrice -((data.sellPrice * data.extendPercent) / 100))) + "</span>"},
                    function(data) {return "<button type=\"button\" onclick=\"deleteTableRow('optionTable', 'delBtn');\" class=\"btn btn-outline-danger btn-sm delBtn\">삭제</button>"}
                ], {escapeHtml:false});
                $('#optionList tr').eq(0).children().eq(7).attr("style", "display:none");
            }

            /*3. 카테고리 가져오기*/
            var productCategoryInfo = info.productCategoryInfo;
            var nextIcon = "<i class=\"m-r-10 mdi mdi-play\" style=\"font-size:18px;color:darkblue\"></i>";
            if(productCategoryInfo.length > 0){
                dwr.util.addRows("categoryList", productCategoryInfo, [
                    function(data) {return "<input type='hidden' name='inputCtgKey[]' value='"+data[0].ctgKey+"'>";},
                    function()     {return "지안에듀";},
                    function()     {return nextIcon},
                    function(data) {return data[3].name == "지안에듀"? data[2].name : data[3].name;},
                    function()     {return nextIcon},
                    function(data) {return data[3].name == "지안에듀"? data[1].name : data[2].name;},
                    function()     {return nextIcon},
                    function(data) {return data[3].name == "지안에듀"? data[0].name : data[1].name;},
                    function(data) {return data[3].name == "지안에듀"? "" : nextIcon;},
                    function(data) {return data[3].name == "지안에듀"? "" : data[0].name;},
                    function(data) {return "<button type=\"button\" onclick=\"deleteTableRow('categoryTable', 'delBtn');\" class=\"btn btn-outline-danger btn-sm delBtn\">삭제</button>"},
                    // function(data) {return "<input type='hidden' name='selOption[]' value='" + data[0].ctgKey + "'>";}
                ], {escapeHtml:false});

                $('#categoryList tr').each(function(){
                    var tr = $(this);
                    tr.children().eq(0).attr("style", "display:none");
                    tr.children().eq(11).attr("style", "display:none");
                });
            }else{
                var cellData = [
                    function() {return "<input type='hidden' name='inputCtgKey[]' value='0'>";},
                    function() {return "지안에듀";},
                    function() {return nextIcon},
                    function() {return getCategoryNoTag('categoryTable','1183', '3');},
                    function() {return nextIcon},
                    function() {return defaultCategorySelectbox();},
                    function() {return nextIcon},
                    function() {return defaultCategorySelectbox();},
                    function() {return nextIcon},
                    function() {return defaultCategorySelectbox();},
                    function() {return "<button type=\"button\" onclick=\"deleteTableRow('categoryTable', 'delBtn');\" class=\"btn btn-outline-danger btn-sm delBtn\">삭제</button>"},
                ];
                dwr.util.addRows("categoryList", [0], cellData, {escapeHtml: false});
            }

            /*4. 도서정보 가져오기*/
            var bookInfo = info.bookInfo;
            console.log(bookInfo);
            innerValue("bookKey", bookInfo.bookKey);
            innerHTML("bookCode", bookInfo.bookKey);
            getLectureStatusSelectbox("status", bookInfo.status);//판매상태
            getNewSelectboxListForCtgKey("l_classGroup", "4309", bookInfo.classGroupCtgKey);//급수
            getNewSelectboxListForCtgKey2("l_subjectGroup", "70", bookInfo.subjectCtgKey);//과목
            innerValue("writer", bookInfo.writer);//저자
            innerValue("cpdate", split_minute_getDay(bookInfo.publishDate));//최신발행일
            innerValue("isbn", bookInfo.isbn);//ISBN
            innerValue("pageCnt", bookInfo.pageCnt);//페이지수
            innerValue("cpKey", bookInfo.cpKey);//출판사 키
            innerHTML("cpName", bookInfo.cpName);//출판사
            isCheckboxByNumber("isDeliveryFree", bookInfo.isDeliveryFree);//배송비무료
            isCheckboxByNumber("isSet", bookInfo.isSet);//세트상품
            innerValue("nextGKey", bookInfo.nextGKey);//과년도도서 카
            innerHTML("goodName", bookInfo.nextGoodsName);//과년도도서
            $("#contentList").summernote("code", bookInfo.contentList);

            /*2. 미리보기 이미지 가져오기 */
            var previewInfo = info.previewInfo;
            if (previewInfo.length != 0) {
                dwr.util.addRows("previewImgList", previewInfo, [
                    function(data) {return "<input type='hidden' id='reskey' value='"+ data.resKey +"'>"},
                    function(data) {return fn_clearFilePath(data.value)},
                    function(data) {return "<button type='button' onclick='deleteImg("+ data.resKey +")' class='btn btn-outline-danger btn-sm'>삭제</button>"},
                    function(data) {return ""},
                    function(data) {return ""},
                    function(data) {return ""},
                    function(data) {return ""},
                ], {escapeHtml:false});
                $('#previewImgList tr').eq(0).children().eq(7).attr("style", "display:none");
            }
        });
    }

    function deleteImg(val){
        if(confirm("삭제 하시겠습니까?")) {
            productManageService.deletePreviewInfo(val, function () {
                if ($("#bookTable > tbody > tr").length == 1) {
                    $('#bookTable > tbody:first > tr:first').attr("style", "display:none");
                } else {
                    $('#bookTable > tbody:last > tr:last').remove();
                }
            });
        }
    }

    $( document ).ready(function() {
        $('textarea[name=description]').summernote({ //기본정보-에디터
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
        $('#contentList').summernote({ //기본정보-에디터
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
        var inputCtgKey = get_array_values_by_name("input", "inputCtgKey[]");
        var nextIcon = "<i class=\"m-r-10 mdi mdi-play\" style=\"font-size:18px;color:darkblue\"></i>";

        if (inputCtgKey.length > 0) {
            var $tableBody = $("#categoryTable").find("tbody"),
                $trLast = $tableBody.find("tr:last"),
                $trNew = $trLast.clone();
            $trLast.after($trNew);

            $trNew.find("td input").eq(0).html("");
            $trNew.find("td").eq(1).html("지안에듀");
            getCategoryNoTag('categoryTable','1183', '3');
            $trNew.find("td").eq(5).html(defaultCategorySelectbox());
            $trNew.find("td").eq(7).html(defaultCategorySelectbox());
            $trNew.find("td").eq(9).html(defaultCategorySelectbox());
        } else { //카테고리 없을 경우
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
                function() {return "<button type=\"button\" onclick=\"deleteTableRow('categoryTable', 'delBtn');\" class=\"btn btn-outline-danger btn-sm delBtn\" style=\"margin-top:8%;\" >삭제</button>"},
            ];
            dwr.util.addRows("categoryList", [0], cellData, {escapeHtml: false});
            //$('#categoryList tr').eq(0).attr("style", "display:none");
        }
    }

    //옵션 - 할인률 계산
    function saleInputPrice(val) {
        var checkBtn = val;
        var tr = checkBtn.parent().parent();
        var td = tr.children();

        var sellPrice = td.find("input").eq(1).val();
        var extendPercent = td.find("input").eq(3).val();

        var sum = Math.round(removeComma(sellPrice) -((removeComma(sellPrice) * extendPercent) / 100));
        td.find("span").html(sum);
        //innerHTML(calcPrice, sum);
    }
    //카테코리 셀렉트 박스 변경 시
    function changeCategory(tableId, val, tdNum) {
        getCategoryNoTag2(val, tableId, tdNum);
    }

    //과년도 도서 추가
    function fn_search3(val) {
        var paging = new Paging();
        var sPage = $("#sPage3").val();
        var searchType = getSelectboxValue("searchType");
        var searchText = getInputTextValue("productSearchType");

        if(val == "new")  sPage = "1";

        dwr.util.removeAllRows("dataList3");
        gfn_emptyView3("H", "");//페이징 예외사항처리
        productManageService.getProductListCount(searchType, searchText, 'BOOK', function(cnt) {
            paging.count3(sPage, cnt, '10', '10', comment.blank_list);
            var listNum = ((cnt-1)+1)-((sPage-1)*10); //리스트 넘버링
            productManageService.getProductList(sPage, '10',searchType, searchText, 'BOOK', function (selList) {
                if (selList.length > 0) {
                    for (var i = 0; i < selList.length; i++) {
                        var cmpList = selList[i];
                        var isShow = "";
                        var isSell = "";
                        var isFree = "";
                        if(cmpList.isShow == '1') isShow = '<i class="mdi mdi-check" style="color:green;"></i>';
                        else isShow = '<i class="mdi mdi-close" style="color: red"></i>';
                        if(cmpList.isSell == '1') isSell = '<i class="mdi mdi-check" style="color:green;"></i>';
                        else isSell = '<i class="mdi mdi-close" style="color: red"></i>';
                        if(cmpList.isFree == '1') isFree = '<i class="mdi mdi-check" style="color:green;"></i>';
                        else isFree = '<i class="mdi mdi-close" style="color: red"></i>';

                        var bookSelBtn = '<input type="button" onclick="sendChildValue_2($(this))" value="선택" class="btn btn-outline-info mx-auto"/>';
                        if (cmpList != undefined) {
                            var cellData = [
                                function(data) {return '<input name="bookKey[]" value=' + "'" + cmpList.GKey + "'" + '>';},
                                function(data) {return cmpList.goodsName;},
                                function(data) {return isShow;},
                                function(data) {return isSell;},
                                function(data) {return isFree;},
                                function(data) {return bookSelBtn;}
                            ];
                            dwr.util.addRows("dataList3", [0], cellData, {escapeHtml: false});
                            $('#dataList3 tr').each(function(){
                                var tr = $(this);
                                tr.children().eq(0).attr("style", "display:none");
                            });
                        }
                    }
                }else{
                    gfn_emptyView3("V", comment.blank_list2);
                }
            });
        });
    }

    //과년도 도서 전달값
    function sendChildValue_2(val) {
        var checkBtn = val;

        var tr = checkBtn.parent().parent();
        var td = tr.children();

        var gKey = td.find("input").val();

        var goodsName = td.eq(1).text();

        var resKeys = get_array_values_by_name("input", "res_key[]");
        if ($.inArray(gKey, resKeys) != '-1') {
            alert("이미 선택된 도서입니다.");
            return;
        }
        $("#goodName").html(goodsName);
        $("#nextGKey").val(gKey);
    }


    //출판사 추가
    function fn_search(val) {
        var paging = new Paging();
        var sPage = $("#sPage").val();
        var searchText = getInputTextValue("CpSearchType");

        if(val == "new")  sPage = "1";

        dwr.util.removeAllRows("dataList");
        gfn_emptyView3("H", "");//페이징 예외사항처리
        productManageService.getCpListCount("name", searchText, function(cnt) {
            paging.count(sPage, cnt, '10', '10', comment.blank_list);
            var listNum = ((cnt-1)+1)-((sPage-1)*10); //리스트 넘버링
            productManageService.getCpList(sPage, '10', "name", searchText, function (selList) {
                if (selList.length > 0) {
                    for (var i = 0; i < selList.length; i++) {
                        var cmpList = selList[i];
                        var cpSelBtn = '<input type="button" onclick="sendChildValue_1($(this))" value="선택" class="btn btn-outline-info mx-auto"/>';
                        if (cmpList != undefined) {
                            var cellData = [
                                function(data) {return '<input name="bookKey[]" value=' + "'" + cmpList.cpKey + "'" + '>';},
                                function(data) {return cmpList.name;},
                                function(data) {return cpSelBtn;},
                            ];
                            dwr.util.addRows("dataList", [0], cellData, {escapeHtml: false});
                            $('#dataList tr').each(function(){
                                var tr = $(this);
                                tr.children().eq(0).attr("style", "display:none");
                            });
                        }
                    }
                }else{
                    gfn_emptyView3("V", comment.blank_list2);
                }
            });
        });
    }

    //출판사 전달값
    function sendChildValue_1(val) {
        var checkBtn = val;

        var tr = checkBtn.parent().parent();
        var td = tr.children();

        var gKey = td.find("input").val();
        var goodsName = td.eq(1).text();

        var resKeys = get_array_values_by_name("input", "res_key[]");
        if ($.inArray(gKey, resKeys) != '-1') {
            alert("이미 선택된 출판사입니다.");
            return;
        }
        $("#cpName").html(goodsName);
        $("#cpKey").val(gKey);
    }


    function bookInfoSave() {
        var data = new FormData();
        var fileData = new FormData();
        $.each($('#imageListFile')[0].files, function(i, file) {
            fileData.append('imageListFile', file);
        });

        $.each($('#imageViewFile')[0].files, function(i, file) {
            fileData.append('imageViewFile', file);
        });

        /* 1. 기본정보 obj */
        $.ajax({
            url: "/file/updateBookInfo",
            method: "post",
            dataType: "JSON",
            data: fileData,
            cache: false,
            processData: false,
            contentType: false,
            success: function (data) {
                /* 1. 기본정보 */
                var cpKey = $("#cpKey").val();
                var basicObj = getJsonObjectFromDiv("section1");
                if(basicObj.isShow == 'on')  basicObj.isShow = '1';//노출 checkbox
                else basicObj.isShow = '0';
                if(basicObj.isSell == 'on')  basicObj.isSell = '1';//판매
                else basicObj.isSell = '0';
                if(basicObj.isFree == 'on')  basicObj.isFree = '1';//무료
                else basicObj.isFree = '0';
                if(basicObj.isFreebieDeliveryFree == 'on')  basicObj.isFreebieDeliveryFree = '1';//사은품배송비무료
                else basicObj.isFreebieDeliveryFree = '0';
                if(basicObj.isQuickDelivery == 'on')  basicObj.isQuickDelivery = '1';//사은품배송비무료
                else basicObj.isQuickDelivery = '0';
                basicObj.cpKey = cpKey;
                basicObj.GKey = gKey;

                var result = JSON.stringify(data.result);
                if(result != "") {
                    var parse = JSON.parse(result);
                    basicObj.imageList = parse.imageListFilePath;
                    basicObj.imageView = parse.imageViewFilePath;
                }

                /*  2.옵션 obj */
                var optionArray = new Array();
                $('#optionTable tbody tr').each(function(index){
                    var i = 0;
                    //var optionName = $(this).find("td select").eq(0).val();
                    var price = $(this).find("td input").eq(0).val();
                    var sellPrice = $(this).find("td input").eq(1).val();
                    var point = $(this).find("td input").eq(2).val();
                    var extendPercent = $(this).find("td input").eq(3).val();
                    var data = {
                        priceKey:'0',
                        gKey:'0',
                        kind:'0',
                        ctgKey:'0',
                        name:'0',
                        price:removeComma(price),
                        sellPrice:removeComma(sellPrice),
                        point:removeComma(point),
                        extendPercent:extendPercent
                    };
                    optionArray.push(data);
                });

                /* 3. 카테고리 저장 */
                var ctgKeys = get_array_values_by_name("input", "inputCtgKey[]");
                if (ctgKeys.length > 0) {
                    var categoryArr = new Array();
                    $.each(ctgKeys, function(index, key) {
                        if(key != '0'){
                            var data = {
                                ctgGKey:0,
                                ctgKey:Number(key),
                                gKey:0,
                                pos:0
                            };
                            categoryArr.push(data);
                        }
                    });
                }
                /* 4. 도서정보 obj */
                var bookObj = getJsonObjectFromDiv("section4");
                if(bookObj.isDeliveryFree == 'on')  bookObj.isDeliveryFree = '1';//무료
                else bookObj.isDeliveryFree = '0';
                if(bookObj.isSet == 'on')  bookObj.isSet = '1';//사은품배송비무료
                else bookObj.isSet = '0';

                if(categoryArr == undefined){
                    categoryArr = [];
                }
                console.log(categoryArr);
                    if(confirm("수정 하시겠습니까?")) {
                    productManageService.saveBook(basicObj, optionArray, categoryArr, bookObj, function (selList) {
                        isReloadPage(true);
                    });
                }

            }
        });
    }

    function imageSave() {
        var fileName =$(".custom-file-control3").html();
        if(fileName == ""){
            alert("이미지를 첨부해 주세요.");
            return false;
        }else{
            //previewFileUpload
            var data = new FormData();
            $.each($('#PreviewFile')[0].files, function(i, file) {
                data.append('PreviewFile', file);
                if(confirm("이미지를 저장 하시겠습니까?")) {
                    $.ajax({
                        url: "/file/previewFileUpload",
                        method: "post",
                        dataType: "JSON",
                        data: data,
                        cache: false,
                        processData: false,
                        contentType: false,
                        success: function (data) {
                            $(".custom-file-control3").html('');
                            if(data.result){
                                var fileName = fn_clearFilePath(data.result);
                                var tResVO = {
                                    key00 : gKey,
                                    value : data.result
                                };
                                productManageService.saveBookPreviewInfo(tResVO , function (resKey) {
                                    if(resKey != null){
                                        var cellData = [
                                            function() {return "<input type='hidden' id='reskey' value='"+ resKey +"'>"},
                                            function() {return fileName},
                                            function() {return "<button type='button' onclick='deleteImg("+ resKey +")' class='btn btn-outline-danger btn-sm' style='margin-top:8%;'>삭제</button>"}
                                        ];
                                        dwr.util.addRows("previewImgList", [0], cellData, {escapeHtml: false});
                                    }
                                });
                            }
                        }//success
                    });
                }
            });
        }
    }
</script>
<input type="hidden" name="sPage3" id="sPage3">
<div class="page-breadcrumb">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">도서 정보수정</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">상품관리</li>
                        <li class="breadcrumb-item active" aria-current="page">도서 수정</li>
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
                                <input type="hidden" value="0" name="goodsId">
                                <input type="hidden" value="" name="goodsTypeName">
                                <input type="hidden" value="" name="summary">
                                <div class="col-md-12">
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">상품타입</label>
                                        <span>도서</span>
                                        <input type="hidden" class="col-sm-6 bg-light required form-control" id="type" name='type' value="3">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">이름</label>
                                        <input type="text" class="col-sm-6 form-control" style="display: inline-block;" id="name" name="name">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">등록일</label>
                                        <div class="col-sm-6 input-group pl-0 pr-0" id="dateRangePicker">
                                            <input type="text" class="form-control mydatepicker" placeholder="yyyy-mm-dd" name="indate" id="indate">
                                            <div class="input-group-append">
                                                <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label"  style="margin-bottom: 0">판매시작일</label>
                                        <div class="col-sm-6 input-group pl-0 pr-0">
                                            <input type="text" class="form-control mydatepicker" placeholder="yyyy-mm-dd" name="sellstartdate" id="sellstartdate">
                                            <div class="input-group-append">
                                                <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row mt-4">
                                        <label class="col-sm-2 text-left control-label col-form-label"  style="margin-bottom: 0">노출</label>
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
                                        <label class="col-sm-2 text-left control-label col-form-label" style="margin-bottom: 0">판매</label>
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
                                        <label class="col-sm-2 text-left control-label col-form-label" style="margin-bottom: 0">무료</label>
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
                                        <div class="col-sm-6 pl-0 pr-0">
                                            <div class="custom-file">
                                                <input type="file" class="custom-file-input" id="imageListFile"  name="imageListFile" required>
                                                <span class="custom-file-control custom-file-label"></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">상세이미지</label>
                                        <div class="col-sm-6 pl-0 pr-0">
                                            <div class="custom-file">
                                                <input type="file" class="custom-file-input addFile" id="imageViewFile" name="imageViewFile" required>
                                                <span class="custom-file-control1 custom-file-label"></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label  class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">강조표시</label>
                                        <div class="col-sm-6 pl-0 pr-0">
                                            <span id="l_emphasis"></span>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">정산율</label>
                                        <div class="col-sm-6 pl-0 pr-0">
                                            <input type="text" class="col-sm-6 form-control" style="display: inline-block;" id="calculateRate" name="calculateRate">%
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">사은품 배송비 무료</label>
                                        <div class="col-sm-10">
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
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">황금날개배송</label>
                                        <div class="col-sm-10">
                                            <div style="margin-top: -23px;" class="col-sm-5">
                                                OFF
                                                <label class="switch">
                                                    <input type="checkbox" style="display:none;" id="isQuickDelivery" name="isQuickDelivery">
                                                    <span class="slider"></span>
                                                </label>
                                                ON
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-form-label">상세설명</label>
                                        <div>
                                            <textarea value="" id="description1" name="description"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>
                        <!-- // 1.기본정보 Tab -->
                        <!-- 2.옵션 Tab -->
                        <h3>옵션</h3>
                        <section>
                            <div class="float-right mb-3">
                                <!--<button type="button" class="btn btn-outline-primary btn-sm" onclick="updateOptionInfo();">수정</button>-->
                                <button type="button" class="btn btn-info btn-sm" onclick="addProductOptionInfo();">추가</button>
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
                                        <th scope="col"></th>
                                    </tr>
                                    </thead>
                                    <tbody id="optionList">
                                    </tbody>
                                </table>
                            </div>
                        </section>
                        <!-- //2.옵션 Tab -->

                        <!-- 3.카테고리 목록 Tab -->
                        <h3>카테고리</h3>
                        <section>
                            <div class="float-right mb-3">
                                <!--<button type="button" class="btn btn-outline-primary btn-sm" onclick="updateCategoryInfo();">수정</button>-->
                                <button type="button" class="btn btn-info btn-sm" onclick="addCategoryInfo()">추가</button>
                            </div>
                            <div id="section3">
                                <table class="table" id="categoryTable">
                                    <input type="hidden" name="ctgGKey" value="0">
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
                            </div>
                        </section>
                        <!-- //3.카테고리 목록 Tab -->

                        <!-- 4. 도서정보 -->
                        <h3>도서정보</h3>
                        <section class="col-md-auto">
                            <div id="section4">
                                <input type="hidden" value="" name="bookKey" id="bookKey">
                                <input type="hidden" value="0" name="goodsId">
                                <input type="hidden" value="<%=gKey%>" name="gKey">
                                <div class="col-md-12">
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">도서코드</label>
                                        <span id="bookCode">0</span>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">판매상태</label>
                                        <select class="col-sm-3 select2 form-control custom-select" id="status" name='status'>
                                            <option value="">선택</option>
                                            <option value="0">예약</option>
                                            <option value="1">판매중</option>
                                            <option value="2">품절</option>
                                            <option value="3">절판</option>
                                        </select>
                                    </div>
                                    <div class="form-group row">
                                        <label  class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">급수</label>
                                        <div class="col-sm-6 pl-0 pr-0">
                                            <span id="l_classGroup"></span>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label  class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">과목</label>
                                        <div class="col-sm-6 pl-0 pr-0">
                                            <span id="l_subjectGroup"></span>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">저자</label>
                                        <input type="text" class="col-sm-3 form-control" style="display: inline-block;" name="writer" id="writer">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">최신발행일</label>
                                        <div class="col-sm-3 input-group pl-0 pr-0">
                                            <input type="text" class="form-control mydatepicker" placeholder="yyyy-mm-dd" name="publishDate" id="cpdate">
                                            <div class="input-group-append">
                                                <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">ISBN</label>
                                        <input type="text" class="col-sm-3 form-control" style="display: inline-block;" name="isbn" id="isbn">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">페이지 수</label>
                                        <input type="text" class="col-sm-3 form-control" style="display: inline-block;" name="pageCnt" id="pageCnt">
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">출판사</label>
                                        <div class="col-sm-7 pl-0 pr-0">
                                            <input type="hidden" id="cpKey" name='cpKey' value="">
                                            <span id="cpName" class="pr-2"></span>
                                            <button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#cpModal" onclick="fn_search('new');">출판사 추가</button>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">배송비 무료</label>
                                        <div class="col-sm-10">
                                            <div style="margin-top: -23px;" class="col-sm-5">
                                                OFF
                                                <label class="switch">
                                                    <input type="checkbox" style="display:none;" id="isDeliveryFree" name="isDeliveryFree">
                                                    <span class="slider"></span>
                                                </label>
                                                ON
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">세트상품</label>
                                        <div class="col-sm-10">
                                            <div style="margin-top: -23px;" class="col-sm-5">
                                                OFF
                                                <label class="switch">
                                                    <input type="checkbox" style="display:none;" id="isSet" name="isSet">
                                                    <span class="slider"></span>
                                                </label>
                                                ON
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">과년도 도서</label>
                                        <div class="col-sm-7 pl-0 pr-0">
                                            <input type="hidden" id="nextGKey" name="nextGKey" value="">
                                            <span id="goodName" class="pr-2"></span>
                                            <button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#bookModal" onclick="fn_search3('new');">과년도 도서 추가</button>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-form-label">목차</label>
                                        <div>
                                            <textarea value="" id="contentList" name="contentList"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>
                        <!-- 도서정보 -->

                        <!-- 5. 미리보기 이미지 Tab -->
                        <h3>미리보기이미지</h3>
                        <section>
                            <div class="form-group row" style="width:80%;margin: auto;">
                                <label class="col-sm-3 text-right control-label col-form-label">이미지 추가</label>
                                <div class="col-sm-8">
                                    <div class="custom-file">
                                        <input type="file" class="custom-file-input PreviewFile" id="PreviewFile" name="PreviewFile" required>
                                        <span class="custom-file-control3 custom-file-label"></span>
                                    </div>
                                </div>
                                <button type="button" class="btn btn-info btn-sm" style="height: 35px;" onclick="imageSave();">추가</button>
                            </div>
                            <div id="section6" style="text-align: center">
                                <table class="table text-center table-hover" id="bookTable" style="width:80%;margin: auto;">
                                    <thead>
                                    <tr style="display:none;">
                                        <th style="width:45%"></th>
                                        <th style="width:5%"></th>
                                        <th style="width:10%"></th>
                                        <th style="width:10%"></th>
                                        <th style="width:10%"></th>
                                        <th style="width:10%"></th>
                                    </tr>
                                    </thead>
                                    <tbody id="previewImgList"></tbody>
                                </table>
                            </div>
                        </section>
                    </div>
                </div>
            </div>
        </div>
        <!-- //div.card -->
    </div>
</form>
<!-- // 기본소스-->
<!-- 과년도 도서 팝업창-->
<div class="modal fade" id="bookModal" tabindex="-1" role="dialog" aria-hidden="true">
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
                    <div style="margin-bottom: 45px;">
                        <div style=" float: left;">
                            <span id="l_productSearch"></span>
                        </div>
                        <div style=" float: left; width: 33%; margin-left: 5px">
                            <input type="text" class="form-control" id="productSearchType" onkeypress="if(event.keyCode==13) {fn_search3('new'); return false;}">
                        </div>
                        <div style=" float: left; width: 33%; margin-left: 5px;">
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

<!-- 출판사 팝업창-->
<div class="modal fade" id="cpModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document" style="max-width: 500px">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">CP사 선택</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form>
                <!-- modal body -->
                <div class="modal-body">
                    <div style="margin-bottom: 45px;">
                        <div style=" float: left;">
                            <label style="margin-top:6px;">이름</label>
                        </div>
                        <div style=" float: left; width: 33%; margin-left: 5px">
                            <input type="text" class="form-control" id="CpSearchType" onkeypress="if(event.keyCode==13) {fn_search('new'); return false;}">
                        </div>
                        <div style=" float: left; width: 33%; margin-left: 5px;">
                            <button type="button" class="btn btn-outline-info mx-auto" onclick="fn_search('new')">검색</button>
                        </div>
                    </div>
                    <div class="table-responsive">
                        <input type="hidden" id="sPage" >
                        <table id="zero_config" class="table table-hover text-center">
                            <thead class="thead-light">
                            <tr>
                                <th style="width:45%">출판사명</th>
                                <th style="width:15%"></th>
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

<%@include file="/common/jsp/footer.jsp" %>
<script>
    var form = $("#playForm");
    form.children("div").steps({
        headerTag: "h3",
        bodyTag: "section",
        enableAllSteps: true,
        startIndex : 0,
        saveState : true, //현재 단계 쿠키저장
        enablePagination : true,
        onFinished: function(event, currentIndex) {
            bookInfoSave();
        }
    });

    $('#indate').datepicker({
        format: "yyyy-mm-dd",
        language: "kr"
    });
    $('#sellstartdate').datepicker({
        format: "yyyy-mm-dd",
        language: "kr"
    });
    $('#cpdate').datepicker({
        format: "yyyy-mm-dd",
        language: "kr"
    });

    //파일 선택시 파일명 보이게 하기
    $(document).on('change', '.custom-file-input', function() {
        $(this).parent().find('.custom-file-control').html($(this).val().replace(/C:\\fakepath\\/i, ''));
    });
    $(document).on('change', '.addFile', function() {
        $(this).parent().find('.custom-file-control1').html($(this).val().replace(/C:\\fakepath\\/i, ''));
    });
    $(document).on('change', '.PreviewFile', function() {
        $(this).parent().find('.custom-file-control3').html($(this).val().replace(/C:\\fakepath\\/i, ''));
    });

</script>

<%@include file="/common/jsp/footer.jsp" %>
