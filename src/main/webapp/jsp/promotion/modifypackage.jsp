<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<%
    String gKey = request.getParameter("param_key");
%>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/promotionManageService.js'></script>
<script type='text/javascript' src='/dwr/interface/productManageService.js'></script>
<script>
    var gKey = '<%=gKey%>';
    function init() {
        menuActive('menu-2', 1);
        getCategoryList("sel_category","214");
        getNewSelectboxListForCtgKey("l_classGroup", "4309", "");
        getNewSelectboxListForCtgKey2("l_subjectGroup", "70", "");
        getNewSelectboxListForCtgKey3("l_stepGroup", "202", "");
        getLectureStatusSelectbox("status", "");//강좌정보- 진행상태
        getLectureCountSelectbox("limitCount", "");//강좌정보 강좌수
        getClassRegistraionDaySelectbox("limitDay", "");//수강일수
        getLectureCountSelectbox("lecTime", "");//강좌시간
        getExamPrepareSelectbox("examYear", "");//시험대비년도 셀렉트박스
        getSelectboxListForCtgKeyNoTag2('teacherTable', '70', 0);
        selectTeacherSelectboxNoTag2('teacherTable', 1);
        getProductSearchTypeSelectbox("l_productSearch");//검색 셀렉박
        getEmphasisSelectbox("l_emphasis", "");//강조표시
        getSelectboxListForCtgKey('affiliationCtgKey','133','');//직렬

        /* 패키시상품 정보 가져오기 */
        promotionManageService.getPackageDetailInfo(gKey, function(info) {
            console.log(info);
            var productInfo = info.productInfo;
            innerValue("name", productInfo.name);
            innerValue("indate", split_minute_getDay(productInfo.indate));
            innerValue("sellstartdate", split_minute_getDay(productInfo.sellstartdate));
            isCheckboxByNumber("isShow", productInfo.isShow);//노출
            isCheckboxByNumber("isSell", productInfo.isSell);//판매
            isCheckboxByNumber("isFree", productInfo.isFree);//무료
            isCheckboxByNumber("isFreebieDeliveryFree", productInfo.isFreebieDeliveryFree);//판매
            if (productInfo.imageList != null) {
                $('.custom-file-control').html(fn_clearFilePath(productInfo.imageList));//리스트이미지
            }
            if (productInfo.imageView != null) {
                $('.custom-file-control1').html(fn_clearFilePath(productInfo.imageView));//상세이미지
            }
            getEmphasisSelectbox("l_emphasis", productInfo.emphasis);
            innerValue("calculateRate", productInfo.calculateRate);
            $("#description1").summernote("code", productInfo.description);

            /**
             * 옵션정보 가져오기
             */
            var productOptionInfo = info.productOptionInfo;

            if (productOptionInfo.length == 0) {
                var cellData = [
                    function() {return getAllListOptionSelectbox('');},
                    function() {return "<input type=\"text\" class=\"form-control \" name=\"price[]\" id='price_0'>"},
                    function() {return "<input type=\"text\" class=\"form-control \" name=\"sellPrice[]\" id='sellPrice_0'>"},
                    function() {return "<input type=\"text\" class=\"form-control \" name=\"point[]\" id='point_0'>"},
                    function() {return "<input type=\"text\" class=\"form-control \" name=\"expendPercent[]\" id='point_0' onkeypress='saleInputPrice($(this));'>"},
                    function() {return "%"},
                    function() {return "<span id='sum_0'></span>"},
                    function() {return "<button type=\"button\" onclick=\"deleteTableRow('optionTable', 'delBtn');\" class=\"btn btn-outline-danger btn-sm delBtn\">삭제</button>"}
                ];
                dwr.util.addRows("optionList", [0], cellData, {escapeHtml: false});
                $('#optionList tr').eq(0).attr("style", "display:none");

            } else {
                dwr.util.addRows("optionList", productOptionInfo, [
                    function(data) {return getAllListOptionSelectbox(data.kind);},
                    function(data) {return "<input type=\"text\" class=\"form-control \" name=\"price[]\" id='price_" + data.priceKey + "'  value='"+ format(data.price) +"' >"},
                    function(data) {return "<input type=\"text\" class=\"form-control \" name=\"sellPrice[]\" id='sellPrice_" + data.priceKey + "'  value='"+ format(data.sellPrice) +"' >"},
                    function(data) {return "<input type=\"text\" class=\"form-control \" name=\"point[]\" id='point_" + data.priceKey + "'  value='"+ format(data.point) +"' >"},
                    function(data) {return "<input type=\"text\" class=\"form-control \" name=\"expendPercent[]\" id='point_" + data.priceKey + "'  value='"+ data.extendPercent +"' onkeypress='saleInputPrice($(this));'>"},
                    //function(data) {return "<input type=\"text\" class=\"form-control \" name=\"expendPercent[]\" id='point_" + data.priceKey + "'  value='"+ data.extendPercent +"' onkeypress='saleInputPrice(this.value"+ ","+ '"' + data.sellPrice + '"' + ","+ '"' + data.priceKey + '"' + ");'>"},
                    function(data) {return "%"},
                    function(data) {return "<span id='sum_" + data.priceKey + "'>" + format(Math.round(data.sellPrice -((data.sellPrice * data.extendPercent) / 100))) + "</span>"},
                    function(data) {return "<button type=\"button\" onclick=\"deleteTableRow('optionTable', 'delBtn');\" class=\"btn btn-outline-danger btn-sm delBtn\">삭제</button>"},
                ], {escapeHtml:false});
                $('#optionList tr').eq(0).children().eq(7).attr("style", "display:none");
            }

            /**
             * 카테고리 정보 가져오기
             */
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
                    function() {return "<button type=\"button\" onclick=\"deleteTableRow('categoryTable', 'delBtn');\" class=\"btn btn-outline-danger btn-sm delBtn\">삭제</button>"},
                ];
                dwr.util.addRows("categoryList", [0], cellData, {escapeHtml: false});
            }

            //프로모션정보 가져오기
            var productPromotionInfo = info.productPromotionInfo;
            getClassRegistraionDaySelectbox("limitDay", productPromotionInfo.limitDay);//수강일수
            getExamPrepareSelectbox("examYear", productPromotionInfo.examYear);//시험대비년도 셀렉트박스
            getNewSelectboxListForCtgKey("l_classGroup", "4309", productPromotionInfo.classGroupCtgKey);
            getNewSelectboxListForCtgKey('affiliationCtgKey', '133', productPromotionInfo.affiliationCtgKey);//직렬
            innerValue("pmKey", productPromotionInfo.pmKey);

            /*포함된 온라인강좌 가져오기*/
            var productOnlineLectureInfo = info.productOnlineLectureInfo;
            if (productOnlineLectureInfo.length == 0) {

            } else {
                dwr.util.addRows("promotionOnlineList", productOnlineLectureInfo, [
                    function(data) {return data.goodsName;},
                    function(data) {return "<input type='hidden' name='res_key[]' value='" + data.resKey + "'>";},
                    function(data) {return "<input type='hidden' name='linkKey[]' value='" + data.linkKey + "'>";},
                    function(data) {return "<input type='hidden' name='reqKey[]' value='" + data.reqKey + "'>";},
                    function() {return "<button type=\"button\" onclick=\"deleteTableRow('promotionOnlineTable', 'delBtn');\" class=\"btn btn-outline-danger btn-sm delBtn\">삭제</button>"}
                ], {escapeHtml:false});
                $('#promotionOnlineList tr').each(function(){
                    var tr = $(this);
                    tr.children().eq(2).addClass("text-left").attr("style", "padding: 0.3rem; vertical-align: middle;width: 30%");

                });
            }
        });

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
        var ctgKeys = get_array_values_by_name("input", "inputCtgKey[]");
        var nextIcon = "<i class=\"m-r-10 mdi mdi-play\" style=\"font-size:18px;color:darkblue\"></i>";
        if (ctgKeys.length > 0) {
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

    //강사목록 새로 등록하는 값 주입하기(강사키)
    function injectSubjectKey(val) {
        $("#teacherTable").find("tbody").find("tr:last").find("td input").eq(1).val(val);
    }

    //강사목록 새로 등록하는 값 주입하기(과목키)
    function injectTeacherKey(val) {
        $("#teacherTable").find("tbody").find("tr:last").find("td input").eq(0).val(val);
    }

    //포함된 온라인강좌 팝업창
    function fn_search(val) {
        var paging = new Paging();
        var sPage = $("#sPage").val();
        var searchType = getSelectboxValue("searchType");
        var searchText = getInputTextValue("productSearchType");

        if(val == "new")  sPage = "1";
        dwr.util.removeAllRows("dataList");
        gfn_emptyView("H", "");//페이징 예외사항처리

        productManageService.getProductListCount(searchType, searchText, "VIDEO", function(cnt) {
            paging.count(sPage, cnt, '10', '10', comment.blank_list);
            var listNum = ((cnt-1)+1)-((sPage-1)*10); //리스트 넘버링
            productManageService.getProductList(sPage, '10',searchType, searchText, "VIDEO", function (selList) {

                if (selList.length > 0) {
                    for (var i = 0; i < selList.length; i++) {
                        var cmpList = selList[i];
                        var bookSelBtn = '<input type="button" id="addBookBtn" onclick="sendChildValue($(this))" value="선택" class="btn btn-outline-info mx-auto"/>';
                        var keyHtml = "<input type='hidden' value='"+ cmpList.GKey +"' id='promotiongKey[]'>";
                        if (cmpList != undefined) {
                            var cellData = [
                                function(data) {return keyHtml;},
                                function(data) {return cmpList.goodsName;},
                                function(data) {return cmpList.isShow == 0 ? "<i class='mdi mdi-close' style='color: red'></i>" : "<i class='mdi mdi-check' style='color:green;'></i>";},
                                function(data) {return cmpList.isSell == 0 ? "<i class='mdi mdi-close' style='color: red'></i>" : "<i class='mdi mdi-check' style='color:green;'></i>";},
                                function(data) {return cmpList.isFree == 0 ? "<i class='mdi mdi-close' style='color: red'></i>" : "<i class='mdi mdi-check' style='color:green;'></i>";},
                                function(data) {return cmpList.teacherName;},
                                function(data) {return cmpList.statusStr;},
                                function(data) {return bookSelBtn;}
                            ];
                            dwr.util.addRows("dataList", [0], cellData, {escapeHtml: false});
                            $('#dataList tr').each(function(){
                                var tr = $(this);
                                tr.children().eq(0).attr("style", "display:none");
                            });
                        }
                    }
                }else{
                    gfn_emptyView("V", comment.blank_list2);
                }
            });
        });
    }

    function sendChildValue(val) {
        var checkBtn = val;

        var tr = checkBtn.parent().parent();
        var td = tr.children();

        var gKey = td.find("input").val();
        var goodsName = td.eq(1).text();

        var resKeys = get_array_values_by_name("input", "res_key[]");
        if ($.inArray(gKey, resKeys) != '-1') {
            alert("이미 선택된 온라인강좌입니다.");
            return;
        }

        var onlineListHtml = "<tr scope='col' colspan='3'>";
        onlineListHtml     += " <td>";
        onlineListHtml     += "<span>" + goodsName + "</span>";
        onlineListHtml     += "</td>";
        onlineListHtml     += " <td>";
        onlineListHtml     += "<input type='hidden'  value='" + gKey + "' name='res_key[]'>";
        onlineListHtml     += "</td>";
        onlineListHtml     += " <td>";
        onlineListHtml     += "<span></span>";
        onlineListHtml     += "</td>";
        onlineListHtml     += " <td>";
        onlineListHtml     += "<span></span>";
        onlineListHtml     += "</td>";
        onlineListHtml     += " <td>";
        onlineListHtml     += "<button type=\"button\" onclick=\"deleteTableRow('promotionOnlineTable', 'delBtn');\" class=\"btn btn-outline-danger btn-sm delBtn\">삭제</button>";
        onlineListHtml     += "</td>";


        $('#promotionOnlineTable > tbody:first').append(onlineListHtml);//선택 모의고사 리스트 뿌리기
        $('#promotionOnlineTable tr').each(function(){
            var tr = $(this);
            //tr.children().eq(2).attr("style", "display:none");
        });

    }

    //수정
    function promotionPacakgeSave() {
        if($('#imageListFile').val() == "" || $('#imageViewFile').val() == ""){
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
                basicObj.imageList = "";
                basicObj.imageView = "";

            /*  2.옵션 obj */
            var optionArray = new Array();
            $('#optionTable tbody tr').each(function(index){
                var i =0;
                var optionName = $(this).find("td select").eq(0).val();
                var price = $(this).find("td input").eq(0).val();
                var sellPrice = $(this).find("td input").eq(1).val();
                var point = $(this).find("td input").eq(2).val();
                var extendPercent = $(this).find("td input").eq(3).val();
                var data = {
                    priceKey:'0',
                    gKey:gKey,
                    kind:optionName,
                    ctgKey:'0',
                    name:'',
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
                    var data = {
                        ctgGKey:0,
                        ctgKey:key,
                        gKey:0,
                        pos:0
                    };
                    categoryArr.push(data);
                });
            } else { //카테고리 없을 경우
                productManageService.deleteTCategoryGoods(gKey, function(){isReloadPage(true);});
            }


            /* 4. 프로모션정보 저장 */
            var promotionInfo = getJsonObjectFromDiv("section4");

            /* 5. 포함된온라인강좌 저장 */
            var onlineLecInfo = new Array();
            $('#promotionOnlineTable tbody tr').each(function(index){
                var onlineKey = $(this).find("td input").eq(0).val();
                var linkKey = $(this).find("td input").eq(1).val();
                var reqKey = $(this).find("td input").eq(2).val();

                var data = {
                    linkKey: 0,
                    reqKey: gKey,
                    resKey: onlineKey,
                    resType: 5,
                    pos: 0,
                };
                onlineLecInfo.push(data);
            });

            if(confirm("수정 하시겠습니까?")) {
                promotionManageService.savePackage(basicObj, optionArray, categoryArr, promotionInfo, onlineLecInfo, function () {
                    isReloadPage(true);
                });
            }
        }else{
            var data = new FormData();
            var fileData = new FormData();
            $.each($('#imageListFile')[0].files, function(i, file) {
                fileData.append('imageListFile', file);
            });

            $.each($('#imageViewFile')[0].files, function(i, file) {
                fileData.append('imageViewFile', file);
            });

            fileData.append('uploadType', 'PACKAGE');

            $.ajax({
                url: "/file/imageFileUpload",
                method: "post",
                dataType: "JSON",
                data: fileData,
                cache: false,
                processData: false,
                contentType: false,
                success: function (data) {
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
                    var result = JSON.stringify(data.result);

                    if(result != "") {
                        var parse = JSON.parse(result);
                        basicObj.imageList = parse.imageListFilePath;
                        basicObj.imageView = parse.imageViewFilePath;
                    }else{
                        basicObj.imageList = "";
                        basicObj.imageView = "";
                    }
                    /*  2.옵션 obj */
                    var optionArray = new Array();
                    $('#optionTable tbody tr').each(function(index){
                        var i =0;
                        var optionName = $(this).find("td select").eq(0).val();
                        var price = $(this).find("td input").eq(0).val();
                        var sellPrice = $(this).find("td input").eq(1).val();
                        var point = $(this).find("td input").eq(2).val();
                        var extendPercent = $(this).find("td input").eq(3).val();
                        var data = {
                            priceKey:'0',
                            gKey:gKey,
                            kind:optionName,
                            ctgKey:'0',
                            name:'',
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
                            var data = {
                                ctgGKey:0,
                                ctgKey:key,
                                gKey:0,
                                pos:0
                            };
                            categoryArr.push(data);
                        });
                    } else { //카테고리 없을 경우
                        productManageService.deleteTCategoryGoods(gKey, function(){isReloadPage(true);});
                    }

                    /* 4. 프로모션정보 저장 */
                    var promotionInfo = getJsonObjectFromDiv("section4");

                    /* 5. 포함된온라인강좌 저장 */
                    var onlineLecInfo = new Array();
                    $('#promotionOnlineTable tbody tr').each(function(index){
                        var onlineKey = $(this).find("td input").eq(0).val();
                        var linkKey = $(this).find("td input").eq(1).val();
                        var reqKey = $(this).find("td input").eq(2).val();

                        var data = {
                            linkKey: 0,
                            reqKey: gKey,
                            resKey: onlineKey,
                            resType: 5,
                            pos: 0,
                        };
                        onlineLecInfo.push(data);
                    });


                    if(confirm("수정 하시겠습니까?")) {
                        promotionManageService.savePackage(basicObj, optionArray, categoryArr, promotionInfo, onlineLecInfo, function () {
                            isReloadPage(true);
                        });
                    }
                }
            });
        }
    }

</script>
<input type="hidden" name="sPage3" id="sPage3">
<div class="page-breadcrumb">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">패키지상품 수정</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">프로모션 관리</li>
                        <li class="breadcrumb-item active" aria-current="page">패키지상품 수정</li>
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
                                <input type="hidden" value=<%=gKey%> name="GKey">
                                <input type="hidden" value="0" name="cpKey">
                                <input type="hidden" value="0" name="isNodc">
                                <input type="hidden" value="0" name="tags">
                                <input type="hidden" value="0" name="goodsId">
                                <input type="hidden" value="" name="goodsTypeName">
                                <input type="hidden" value="" name="summary">
                                <div class="col-md-12">
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">상품타입</label>
                                        <span>프로모션</span>
                                        <input type="hidden" class="col-sm-6 bg-light required form-control" id="type" name='type' value="5">
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
                                        <th scope="col" style="text-align:center;"></th>
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
                        <!-- 프로모션 정보 -->
                        <h3>프로모션정보</h3>
                        <section class="col-md-auto">
                            <div id="section4">
                                <input type="hidden" value="" name="pmKey" id="pmKey">
                                <input type="hidden" value="1" name="pmType">
                                <input type="hidden" value="PACKAGE" name="pmTypeStr">
                                <div class="col-md-12">
                                    <div class="form-group row">
                                        <label  class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">수강일수</label>
                                        <div class="col-sm-6 pl-0 pr-0">
                                            <select class="col-sm-3 select2 form-control custom-select"  id="limitDay" name="limitDay">
                                                <option value="">선택</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label  class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">시험대비년도</label>
                                        <div class="col-sm-6 pl-0 pr-0">
                                            <select class="col-sm-3 select2 form-control custom-select"  id="examYear" name="examYear">
                                                <option value="">선택</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label  class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">급수</label>
                                        <div class="col-sm-6 pl-0 pr-0">
                                            <span id="l_classGroup"></span>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label  class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">직렬</label>
                                        <div class="col-sm-6 pl-0 pr-0">
                                            <span id="sel_serial"></span>
                                            <select class="col-sm-3 select2 form-control custom-select"  id="affiliationCtgKey" name="affiliationCtgKey">
                                                <option value="">선택</option>
                                            </select>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </section>
                        <!-- 프로모션정보 -->
                        <!-- 6.강의 교재선택 Tab -->
                        <h3>포함된 온라인강좌</h3>
                        <section>
                            <div class="float-right mb-3">
                                <button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#promotionOnlineModal" onclick="fn_search('new');">추가</button>
                            </div>
                            <div id="section6">
                                <table class="table text-center table-hover" id="promotionOnlineTable">
                                    <thead>
                                    <tr>
                                        <th scope="col" colspan="5" style="text-align:center;width:30%">온라인강좌 목록</th>
                                    </tr>
                                    </thead>
                                    <tbody id="promotionOnlineList"></tbody>
                                </table>
                            </div>
                        </section>
                        <!-- //6.강의 교재선택 Tab -->
                    </div>
                </div>
            </div>
        </div>
        <!-- //div.card -->
    </div>
</form>
<!-- // 기본소스-->

<!-- 과년도 도서 팝업창-->
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
                    <div style="margin-bottom: 45px;">
                        <div style=" float: left;">
                            <span id="l_productSearch"></span>
                        </div>
                        <div style=" float: left; width: 33%; margin-left: 5px">
                            <input type="text" class="form-control" id="productSearchType" onkeypress="if(event.keyCode==13) {fn_search('new'); return false;}">
                        </div>
                        <div style=" float: left; width: 33%; margin-left: 5px;">
                            <button type="button" class="btn btn-outline-info mx-auto" onclick="fn_search('new')">검색</button>
                        </div>
                    </div>
                    <div class="table-responsive   scrollable" style="height:800px;">>
                        <input type="hidden" id="sPage" >
                        <table id="zero_config" class="table table-hover">
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
