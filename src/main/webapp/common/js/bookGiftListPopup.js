/**
 * 강의교재, 사은품 팝업 리스트불러오기
 */

//강의교재 리스트 불러오기
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
            console.log(selList);
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

                    var bookSelBtn = '<input type="button" id="addBookBtn" onclick="sendChildValue_2($(this))" value="선택" class="btn btn-outline-info mx-auto"/>';
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


//강의교재 , 사은품 선택시 전달값
function sendChildValue_2(val) {
    var checkBtn = val;

    var tr = checkBtn.parent().parent();
    var td = tr.children();

    var gKey = td.find("input").val();
    var goodsName = td.eq(1).text();

    var resKeys = get_array_values_by_name("input", "res_key[]");
    if ($.inArray(gKey, resKeys) != '-1') {
        alert("이미 선택된 과목입니다.");
        return;
    }

    var bookkListHtml = "<tr scope='col' colspan='3'>";
    bookkListHtml     += " <td>";
    bookkListHtml     += "<span>" + goodsName + "</span>";
    bookkListHtml     += "</td>";
    bookkListHtml     += " <td>";
    bookkListHtml     += "<input type='hidden'  value='" + gKey + "' name='res_key[]'>";
    bookkListHtml     += "</td>";
    bookkListHtml     += "<td class=\"text-left\" style=\"padding: 0.3rem; vertical-align: middle;width: 30%\">";
    bookkListHtml     += " <div class='col-sm-10'>";
    bookkListHtml     += " <div style=\"margin-top: -23px;\">";
    bookkListHtml     += "부교재";
    bookkListHtml     += " <label class=\"switch\">";
    bookkListHtml     += " <input type='checkbox'  id='isBookMain_"+ gKey + "' style='display:none;' >";
    bookkListHtml     += "<span class=\"slider\" ></span>";
    bookkListHtml     += "</label>";
    bookkListHtml     += "주교재";
    bookkListHtml     += "  </div>";
    bookkListHtml     += "</div>";
    bookkListHtml     += "</td>";
    bookkListHtml     += " <td>";
    bookkListHtml     += "<button type=\"button\" onclick=\"deleteTableRow('productBook');\" class=\"btn btn-outline-danger btn-sm\" style=\"margin-top:8%;\" >삭제</button>";
    bookkListHtml     += "</td>";


    $('#bookTable > tbody:first').append(bookkListHtml);//선택 모의고사 리스트 뿌리기
    $('#bookTable tr').each(function(){
        var tr = $(this);
        //tr.children().eq(2).attr("style", "display:none");
    });


    // productManageService.getProductDetailInfo(GKey, 'BOOK', function (selList) {
    //     var bookkCnt = $("#bookList tr").length-1; //강의교재
    //     var giftCnt = $("#giftList tr").length-1;//기출문제
    //
    //     var deleteSel = "";
    //     var bookgiftOption = "";
    //     // if(set == 'bookBtn'){
    //     //     bookgiftOption = "bookName_"+bookkCnt;
    //     //     deleteSel = "bookTitleDelete";
    //     // }else if(set == 'giftBtn'){
    //     //     bookgiftOption = "giftName_"+giftCnt;
    //     //     deleteSel = "giftDelete";
    //     // }
    //     if (selList.productInfo) {
    //
    //         var title =  selList.productInfo.name;
    //         var bookkListHtml = "<tr scope='col' colspan='3'>";
    //         bookkListHtml     += " <td>";
    //         bookkListHtml     += "<span>" + title + "</span>";
    //         bookkListHtml     += "</td>";
    //         bookkListHtml     += " <td>";
    //         bookkListHtml     += "<input type='hidden'  value='"+selList.productInfo.GKey+"' name='res_key[]'>";
    //         bookkListHtml     += "</td>";
    //         //if(set == 'bookBtn'){
    //             bookkListHtml     += "<td class=\"text-left\" style=\"padding: 0.3rem; vertical-align: middle;width: 30%\">";
    //             bookkListHtml     += " <div class='col-sm-10'>";
    //             bookkListHtml     += " <div style=\"margin-top: -23px;\">";
    //             bookkListHtml     += "부교재";
    //             bookkListHtml     += " <label class=\"switch\">";
    //             bookkListHtml     += " <input type=\"checkbox\" style=\"display:none;\">";
    //             bookkListHtml     += "<span class=\"slider\"></span>";
    //             bookkListHtml     += "</label>";
    //             bookkListHtml     += "주교재";
    //             bookkListHtml     += "  </div>";
    //             bookkListHtml     += "</div>";
    //             bookkListHtml     += "</td>";
    //         //}
    //         // bookkListHtml     += "<td class=\"text-left\" style=\"padding:0.3rem;vertical-align:middle;\">";
    //         // bookkListHtml     += "<button type=\"button\" class=\"btn btn-outline-danger btn-sm\" onclick=deleteTableRow("+"'"+deleteSel+"'"+")>삭제</button>";
    //         // bookkListHtml     += "</td>";
    //         // bookkListHtml     += " </tr>";
    //
    //         $('#bookList > tbody:first').append(bookkListHtml);//선택 모의고사 리스트 뿌리기
    //         $("#"+bookgiftOption).val(title);//모의고사 제목 뿌리기
    //
    //
    //         $('#bookList tr').each(function(){
    //             var tr = $(this);
    //             tr.children().eq(2).attr("style", "display:none");
    //         });
    //
    //     }
    // });
}
