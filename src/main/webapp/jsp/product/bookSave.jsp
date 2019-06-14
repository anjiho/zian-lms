<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/productManageService.js'></script>
<script>
    function init() {
        menuActive('menu-1', 6);
        /*카테고리*/
        getNewCategoryList("sel_category","214",'1183');
        getCategoryNoTag2('categoryTable','1183', '3');
        /*카테고리*/
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
        getProductSearchTypeSelectbox("l_productSearch");
        getEmphasisSelectbox("l_emphasis", "");
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

            $trNew.find("td input").val('');
            $trNew.find("td input").eq(0).val('기본옵션');
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
            for(var i=0; i < $("#categoryList").find("tr").length; i++) {
                var cateName1 = $("#categoryList").find("tr").eq(i).find("td select").eq(1).val();
                if (cateName1 == "" || cateName1 == undefined) {
                    alert("카테고리 선택후 추가해 주세요.");
                    $("#categoryList").find("tr").eq(i).find("td select").eq(1).focus();
                    return false;
                }
            }
            var $tableBody = $("#categoryTable").find("tbody"),
                $trLast = $tableBody.find("tr:last"),
                $trNew = $trLast.clone();
            $trLast.after($trNew);

            getCategoryNoTag2('categoryTable','1183', '3');
        } else { //카테고리 없을 경우
            var cellData = [
                function() {return "<input type='hidden' name='inputCtgKey[]' value=''>";},
                function() {return getNewCategoryList2("categoryTable","214",'1183');},
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
            //$('#categoryList tr').eq(0).attr("style", "display:none");
        }
    }

    //옵션 - 할인률 계산
    function saleInputPrice(val) {
        var checkBtn = val;

        var tr = checkBtn.parent().parent();
        var td = tr.children();

        var sellPrice = td.find("input").eq(1).val();
        var extendPercent = td.find("input").eq(4).val();

        var sum = Math.round(sellPrice -((sellPrice * extendPercent) / 100));
        td.find("input").eq(4).val(sum);
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

    //과년도 도서 추가
    function fn_search3(val) {
        var paging = new Paging();
        var sPage = $("#sPage3").val();
        var searchType = getSelectboxValue("searchType");
        var searchText = getInputTextValue("productSearchType");

        if(val == "new") {
            sPage = "1";
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
        productManageService.getCpListCoubt("title", searchText, function(cnt) {
            paging.count(sPage, cnt, '10', '10', comment.blank_list);
            var listNum = ((cnt-1)+1)-((sPage-1)*10); //리스트 넘버링
            productManageService.getCpList(sPage, '10', "title", searchText, function (selList) {
                if (selList.length > 0) {
                    for (var i = 0; i < selList.length; i++) {
                        var cmpList = selList[i];
                        var cpSelBtn = '<input type="button" onclick="sendChildValue_1($(this))" value="선택" class="btn btn-outline-info btn-sm"/>';
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
        $.ajax({
            url: "/file/updateBookInfo",
            method: "post",
            dataType: "JSON",
            data: fileData,
            cache: false,
            processData: false,
            contentType: false,
            success: function (data) {
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
                var result = JSON.stringify(data.result);
                if(result != "") {
                    var parse = JSON.parse(result);
                    basicObj.imageList = parse.imageListFilePath;
                    basicObj.imageView = parse.imageViewFilePath;
                }

                /*  2.옵션  */
                var optionArray = new Array();
                $('#optionTable tbody tr').each(function(index){
                    var i = 0;
                    var optionName = $(this).find("td select").eq(0).val();
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
                        price:price,
                        sellPrice:sellPrice,
                        point:point,
                        extendPercent:extendPercent
                    };
                    optionArray.push(data);
                });

                var categoryArr = new Array();
                var ctgKeys = get_array_values_by_name("input", "inputCtgKey[]");
                if(ctgKeys.length > 0){
                    $.each(ctgKeys, function(index, key) {
                        var data = {
                            ctgGKey:0,
                            ctgKey:key,
                            gKey:0,
                            pos:0
                        };
                        categoryArr.push(data);
                    });
                }

                /* 4. 도서정보  */
                var bookObj = getJsonObjectFromDiv("section4");
                if(bookObj.isDeliveryFree == 'on')  bookObj.isDeliveryFree = '1';//무료
                else bookObj.isDeliveryFree = '0';
                if(bookObj.isSet == 'on')  bookObj.isSet = '1';//사은품배송비무료
                else bookObj.isSet = '0';

                $.ajax({
                    url: "/file/updateBookInfo",
                    method: "post",
                    dataType: "JSON",
                    data: fileData,
                    cache: false,
                    processData: false,
                    contentType: false,
                    success: function (data) {
                    }
                });


                if(confirm("저장하시겠습니까?")) {
                    productManageService.saveBook(basicObj, optionArray, categoryArr, bookObj, function (selList) {
                        isReloadPage(true);
                    });
                }
            }
        });
    }
</script>
<input type="hidden" name="sPage3" id="sPage3">
<div class="page-breadcrumb">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">도서 정보등록</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">상품관리</li>
                        <li class="breadcrumb-item active" aria-current="page">도서 등록</li>
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
                                <input type="hidden" value="0" name="gKey">
                                <input type="hidden" value="0" name="cpK ey">
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
                                <button type="button" class="btn btn-info btn-sm" onclick="addProductOptionInfo();">추가</button>
                            </div>
                            <div id="section2">
                                <table class="table" id="optionTable">
                                    <input type="hidden" name="priceKey" value="0">
                                    <input type="hidden" name="gKey" value="0">
                                    <input type="hidden" name="ctgKey" value="0">
                                    <thead>
                                    <tr style="border-top:0">
                                        <th scope="col" style="text-align:center;width:21%">옵션명</th>
                                        <th scope="col" style="text-align:center;width:13%">원가</th>
                                        <th scope="col" style="text-align:center;width:13%">판매가</th>
                                        <th scope="col" style="text-align:center;widht:13%">포인트</th>
                                        <th scope="col" colspan="2" style="text-align:center;width:35%">재수강</th>
                                        <th scope="col" style="text-align:center;width:5%"></th>
                                    </tr>
                                    </thead>
                                    <tbody id="optionList">
                                    <tr>
                                        <td style="padding: 0.3rem;text-align: center;">
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
                                        <td style="padding: 0.3rem;text-align: center;vertical-align: middle">
                                            <input type="number" class="form-control text-right" id="extendPercent" name="extendPercent" style="display: inline-block;width:60%;text-align: right"  onchange="saleInputPrice($(this))"> %
                                        </td>
                                        <td style="padding: 0.3rem;"><!--재수강2-->
                                            <input type="number" class="form-control" id="resultPrice" name="resultPrice" readonly>
                                        </td>
                                        <td style="padding: 0.3rem;">
                                            <button type="button" onclick="deleteTableRow('optionTable' , 'delBtn');" class="btn btn-outline-danger btn-sm delBtn" style="margin-top:8%;">삭제</button>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </section>
                        <!-- //2.옵션 Tab -->

                        <!-- 3.카테고리 목록 Tab -->
                        <h3>카테고리</h3>
                        <section>
                            <div class="float-right mb-3">
                                <button type="button" class="btn btn-info btn-sm" onclick="addCategoryInfo();">추가</button>
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
                                    <tbody id="categoryList">
                                    <tr>
                                        <td style="display: none">
                                            <input type='hidden' name='inputCtgKey[]' value=''>
                                        </td>
                                        <td>
                                            <select class='form-control'  id='sel_category' name="sel_category" disabled></select>
                                        </td>
                                        <td>
                                            <i class="m-r-10 mdi mdi-play" style="font-size:18px;color:darkblue"></i>
                                        </td>
                                        <td>
                                            <select class='form-control'>
                                            </select>
                                        </td>
                                        <td>
                                            <i class="m-r-10 mdi mdi-play" style="font-size:18px;color:darkblue"></i>
                                        </td>
                                        <td>
                                            <select class='form-control'>
                                            </select>
                                        </td>
                                        <td>
                                            <i class="m-r-10 mdi mdi-play" style="font-size:18px;color:darkblue"></i>
                                        </td>
                                        <td>
                                            <select class='form-control'>
                                            </select>
                                        </td>
                                        <td>
                                            <i class="m-r-10 mdi mdi-play" style="font-size:18px;color:darkblue"></i>
                                        </td>
                                        <td>
                                            <select class='form-control'  name="ctgKey">
                                            </select>
                                        </td>
                                        <td>
                                            <button type="button" onclick="deleteTableRow('categoryTable', 'delBtn')" class='btn btn-outline-danger btn-sm delBtn'>삭제</button>
                                        </td>
                                    </tr>

                                    </tbody>
                                </table>
                            </div>
                        </section>
                        <!-- //3.카테고리 목록 Tab -->

                        <!-- 도서정보 -->
                        <h3>도서정보</h3>
                        <section class="col-md-auto">
                            <input type="hidden" value="0" name="bookKey">
                            <input type="hidden" value="0" name="gKey">
                            <input type="hidden" value="" name="contentList">
                            <input type="hidden" value="0" name="goodsId">
                            <div id="section4">
                                <div class="col-md-12">
                                    <div class="form-group row">
                                        <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">도서코드</label>
                                        <span>0</span>
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
                        <!-- // 1.기본정보 Tab -->
                        <!-- 도서정보 -->
                    </div>
                </div>
            </div>
        </div>
        <!-- //div.card -->
    </div>
</form>
<!-- // 기본소스-->

<!--미리보기 이미지 팝업창-->
<div class="modal fade" id="sModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <input type="hidden" id="key" value="modify">
            <input type="hidden" id="searchKeywordKey" value="">
            <div class="modal-header">
                <h5 class="modal-title">리소스 수정</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <!-- modal body -->
            <div class="modal-body">
                <div class="form-group row">
                    <label class="col-sm-3 text-right control-label col-form-label">이미지</label>
                    <div class="col-sm-9">
                        <div class="custom-file">
                            <input type="file" class="custom-file-input PreviewFile" id="PreviewFile" name="PreviewFile" required>
                            <span class="custom-file-control3 custom-file-label"></span>
                        </div>
                    </div>
                </div>
                <button type="button" class="btn btn-info float-right" onclick="imageSave();">저장</button>
            </div>
            <!-- //modal body -->
        </div>
    </div>
</div>

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
    <div class="modal-dialog" role="document" style="max-width: 600px;">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">CP사 선택</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form>
                <!-- modal body -->
                <div class="modal-body" style="padding: 1.25rem;">
                    <div style="margin-bottom: 45px;">
                        <div style=" float: left;margin-top: 6px;">
                            <label>이름 </label>
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
            bookInfoSave();
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
