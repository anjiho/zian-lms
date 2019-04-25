<%@ page import="com.zianedu.lms.utils.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<%
    String gKey = Util.isNullValue(request.getParameter("gKey"), "");
%>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/productManageService.js'></script>
<!-- 강의교재 메뉴 팝업 관련 스크립트 include -->
<script src="common/js/bookGiftListPopup.js"></script>
<script>
    var gKey = '<%=gKey%>';
    $( document ).ready(function() {
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

    //수정화면 최고 진입 시 데이터 출력하기
    function init() {
        getProductSearchTypeSelectbox("l_productSearch");

        productManageService.getProductDetailInfo(gKey, "ACADEMY", function(info) {
            /**
             * 학원강의 기본정보 가져오기
             */
            var productInfo = info.productInfo;
            innerValue("name", productInfo.name);   //상품이름
            innerValue("indate", split_minute_getDay(productInfo.indate));   //등록일
            innerValue("sellstartdate", split_minute_getDay(productInfo.sellstartdate)); //판매일
            isCheckboxByNumber("isShow", productInfo.isShow);//노출
            isCheckboxByNumber("isSell", productInfo.isSell);//판매
            isCheckboxByNumber("isFree", productInfo.isFree);//무료

            if (productInfo.imageList != null) {
                $('.custom-file-control').html(fn_clearFilePath(productInfo.imageList));//리스트이미지
            }
            if (productInfo.imageView != null) {
                $('.custom-file-control1').html(fn_clearFilePath(productInfo.imageView));//상세이미지
            }
            getEmphasisSelectbox("l_emphasis", productInfo.emphasis);   //강조표시
            isCheckboxByNumber("isFreebieDeliveryFree", productInfo.isFreebieDeliveryFree);//무료
            $("#description").summernote("code", productInfo.description);

            /**
             * 학원 옵션정보 가져오기
             */
            var productOptionInfo = info.productOptionInfo;
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
            var productCategoryInfo = info.productCategoryInfo;
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
            if (info.productLectureInfo == null) {
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
                var productLectureInfo = info.productLectureInfo;
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


            /**
             * 강사 목록 가져오기
             */
            var productTeacherInfo = info.productTeacherInfo;
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

            /**
             * 강의교재 항목 가져오기
             */
            var productOtherInfo = info.productOtherInfo;
            //MockTitle
            if (productOptionInfo.length == 0) {

            } else {
                dwr.util.addRows("bookList", productOtherInfo[0], [
                    function(data) {return data.goodsName;},
                    function(data) {return "<input type='hidden' name='res_key[]' value='" + data.resKey + "'>";},
                    function(data) {return getBookMainCheckbox(data.resKey, data.valueBit);},
                    function() {return "<button type=\"button\" onclick=\"deleteTableRow('productBook');\" class=\"btn btn-outline-danger btn-sm\" style=\"margin-top:8%;\" >삭제</button>"}
                    ], {escapeHtml:false});

                for (var i=0; i<productOtherInfo[0].length; i++) {
                    var cmpList = productOtherInfo[0][i];
                    var valueBit = cmpList.valueBit;
                    var resKey = cmpList.resKey;
                    var checkboxId = "isBookMain_" + resKey;

                    var isCheck = true;
                    if (valueBit == "0") isCheck = false;
                    isCheckbox(checkboxId, isCheck);

                }
                $('#bookList tr').each(function(){
                    var tr = $(this);
                    tr.children().eq(2).addClass("text-left").attr("style", "padding: 0.3rem; vertical-align: middle;width: 30%");
                });
            }
        });
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

    //기본정보 수정
    function updateBasicInfo() {
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

    //강의교재 수정 버튼
    function updateLectureBookList() {
        var bookKeys = get_array_values_by_name("input", "res_key[]");
        console.log(bookKeys);
        if (confirm("강의교재 정보를 수정 하시겠습니까?")) {
            var dataArr = new Array();
            for (var i = 0; i < bookKeys.length; i++) {
                var valueBit;
                var isBookMainId = "isBookMain_" + bookKeys[i];
                var isBookMain = $("input:checkbox[id=" + "'" + isBookMainId + "'" + "]").is(":checked");

                //주교재 여부 값 변환
                if (isBookMain) valueBit = 1;
                else valueBit = 0;

                var data = {
                    linkKey: 0,
                    reqKey: gKey,
                    resKey: bookKeys[i],
                    resType: 5,
                    pos: 0,
                    valueBit: valueBit
                }
                dataArr.push(data);
            }
            if (dataArr.length == 0) {
                productManageService.deleteTLinkKeyByResType(gKey, 5, function() {
                    isReloadPage(true);
                });
            } else {
                productManageService.upsultTLinkKink(dataArr, gKey, function () {
                    isReloadPage(true);
                });
            }
        }
    }

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
</script>
<input type="hidden" name="sPage3" id="sPage3">
<div class="page-breadcrumb">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">학원강의 수정</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">상품관리</li>
                        <li class="breadcrumb-item active" aria-current="page">학원강의 상품관리</li>
                        <li class="breadcrumb-item active" aria-current="page">학원강의 수정</li>
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
<%--                                            <input type="hidden" id="gKey" name="gKey" value="<%=gKey%>">--%>
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
<%--                                <input type="hidden" value="" name="summary">--%>
                                <div class="form-group">
                                    <label class="col-sm-1 control-label col-form-label" style="margin-bottom: 0">상품타입</label>
                                    <span>온라인강좌</span>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-1 control-label col-form-label" style="margin-bottom: 0">이름</label>
                                    <input type="text" class="col-sm-8 form-control" style="display: inline-block;" id="name" name="name">
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-1 control-label col-form-label" style="margin-bottom: 0">등록일</label>
                                    <div class="input-group col-sm-3" id="dateRangePicker">
                                        <input type="text" class="form-control mydatepicker" placeholder="yyyy-mm-dd" name="indate" id="indate">
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
                                    <span id="l_emphasis"></span>
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
                                    <textarea name="description"  value="" id="description"></textarea>
                                </div>
                            </div>
                            <div style="float: right">
                                <input type="button" class="btn btn-default" value="수정" onclick="updateBasicInfo();">
                            </div>
                        </div>
                    </section>
                <!-- // 1.기본정보 Tab -->

                <!-- 2.옵션 Tab -->
                <h3>옵션</h3>
                <section>
                    <input type="button" value="수정" onclick="updateOptionInfo();">
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
                            <tbody id="optionList">
                            </tbody>
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
                    <input type="button" value="수정" onclick="updateCategoryInfo();">
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
                            <button type="button" class="btn btn-outline-info mx-auto" onclick="addCategoryInfo();">추가</button>
                        </div>
                    </div>
                </section>
                <!-- //3.카테고리 목록 Tab -->

                <!-- 4.강좌 정보 Tab -->
                <h3>강좌정보</h3>
                <section>
                    <input type="button" value="수정" onclick="updateLectureInfo();">
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
                    <input type="button" value="수정" onclick="updateTeacherList();">
                    <span></span>
                    <div id="section5">
                        <table class="table"id="teacherTable">
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
                            <button type="button" class="btn btn-outline-info mx-auto" style="margin-bottom:18px;" onclick="addTeacherInfo();">추가</button>
                        </div>
                    </div>
                </section>
                <!-- //5.강사 목록 Tab -->

                <!-- 6.강의 교재선택 Tab -->
                <h3>강의 교재선택</h3>
                <section>
                    <input type="button" value="수정" onclick="updateLectureBookList();">
                    <div id="section6">
                        <button type="button"  style="float: right" class="btn btn-outline-info btn-sm" data-toggle="modal" data-target="#bookModal" onclick="fn_search3('new');">추가</button>
                        <table class="table text-center table-hover" id="bookTable">
                            <thead>
                            </thead>
                            <tbody id="bookList"></tbody>
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
                    <span id="l_productSearch"></span>
                </div>
                <div style=" float: left; width: 33%">
                    <input type="text" class="form-control" id="productSearchType">
                </div>
                <div style=" float: left; width: 33%">
                    <button type="button" class="btn btn-outline-info mx-auto" onclick="fn_search3('new')">검색</button>
                </div>
            </div>
            <div class="table-responsive">
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
                </div>
            </div>
        </div>
        <div class="form-group row">
            <label  class="col-sm-3 text-right control-label col-form-label">강의 시간 (분단위)</label>
            <div class="col-sm-9">
                <input type="number" class="form-control" id="vodTime" name="vodTime">
            </div>
        </div>
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

</script>
<script src='https://code.jquery.com/ui/1.11.4/jquery-ui.min.js'></script>
