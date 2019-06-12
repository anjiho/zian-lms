//배너관리 - 서브도메인 셀렉트박스
function getProductSearchSelectbox (tagId) {
    selectboxService.getVideoSearchTypeList(function (list) {
        var html = "<select id='searchType' class='form-control'>";
        html += "<option value=''>선택</option>";
        for (var i=0; i<list.length; i++) {
            html += "<option value="+list[i].key+">"+ list[i].value +"</option>";
        }
        html += "</select>";
        innerHTML(tagId, html);
    });
}

//배너관리 - 서브도메인 셀렉트박스
function getSubDomainList (tag_id, val) {
    selectboxService.getSubDomainList(function (list) {
        var html = "<select id='sel_subDomain' onchange='' class='form-control'>";
        html += "<option value='' selected>선택</option>";
        for (var i=0; i<list.length; i++) {
            if (list[i].ctgKey == val) {
                html += "<option value="+list[i].ctgKey+" selected>"+ list[i].name +"</option>";
            } else {
                html += "<option value="+list[i].ctgKey+">"+ list[i].name +"</option>";
            }
        }
        html += "</select>";
        innerHTML(tag_id, html);
    });
}

//검색어관리
function getSearchKeywordDomainList(tag_id, val) {
    selectboxService.getSearchKeywordDomainList(function (list) {
        var html = "<select id='sel_subDomain' onchange='' class='form-control'>";
        html += "<option value='' selected>선택</option>";
        for (var i=0; i<list.length; i++) {
            if (list[i].className == val) {
                html += "<option value="+list[i].className+" selected>"+ list[i].domainName +"</option>";
            } else {
                html += "<option value="+list[i].className+">"+ list[i].domainName +"</option>";
            }
        }
        html += "</select>";
        innerHTML(tag_id, html);
    });
}

//동영상 저장 옵션명
function getVideoOptionTypeList(tag_id, val) {
    selectboxService.getVideoOptionTypeList(function (list) {
        var html = "<select id='videoOptionSel' onchange='' class='form-control'>";
        for (var i=0; i<list.length; i++) {
            if (list[i].key == val) {
                html += "<option value="+list[i].key+" selected>"+ list[i].value +"</option>";
            } else {
                html += "<option value="+list[i].key+">"+ list[i].value +"</option>";
            }
        }
        html += "</select>";
        innerHTML(tag_id, html);
    });
}

//옵션 셀렉트박스
function getAllOptionSelectboxAddTag(tagId, val) {
    selectboxService.getVideoOptionTypeList(function (list) {
        var html = "<select id='selOption' name='selOption[]' onchange='' class='form-control'>";
        html += "<option value=''>선택</option>";
        for (var i=1; i<13; i++) {
            if (i == val) {
                html += "<option value="+i+" selected>"+ i +"개월</option>";
            } else {
                html += "<option value="+i+">"+ i +"개월</option>";
            }
        }
        for (var i=0; i<list.length; i++) {
            if (list[i].key == val) {
                html += "<option value="+list[i].key+" selected>"+ list[i].value +"</option>";
            } else {
                html += "<option value="+list[i].key+">"+ list[i].value +"</option>";
            }
        }
        html += "</select>";
        innerHTML(tagId, html);
    });
}

//모의고사상품 & 리스트 셀렉트박스
function getAllListOptionSelectbox(val) {
    var optionName = "";
    var html = "<select id='sel_option' name='selOption[]' class='col-sm-7 select2 form-control custom-select'>";
        html += "<option value=''>선택</option>";

    for (var i=1; i<13; i++) {
        if (i == val) {
            html += "<option value="+i+" selected>"+ i +"개월</option>";
        } else {
            html += "<option value="+i+">"+ i +"개월</option>";
        }
    }

    for (var i = 100; i < 103; i++) {

        if(i == 100) optionName = 'VOD';
        else if(i == 101) optionName = 'Mobile';
        else optionName = 'VOD + Mobile';

        if (i == val) html += "<option value="+i+" selected>" + optionName + "</option>";
        else html += "<option value="+i+">" + optionName + "</option>";

    }

    html += "</select>";
    return html;
}

//카테고리
function getCategoryList(tag_id, val) {
    selectboxService.getCategoryList(val, function (list) {
        var html = "<select id='sel_1' onchange='' class='form-control'>";
            html += "<option value=''>선택</option>";
        for (var i=0; i<list.length; i++) {
            if (list[i].ctgKey == val) {
                html += "<option value="+list[i].ctgKey+" selected>"+ list[i].name +"</option>";
            } else {
                html += "<option value="+list[i].ctgKey+">"+ list[i].name +"</option>";
            }
        }
        html += "</select>";
        innerHTML(tag_id, html);
    });
}

//카테고리
function getNewCategoryList(tag_id, val, val2) {
    selectboxService.getCategoryList(val, function (list) {
        var html = "<select id='sel_1' class='form-control'>";
        for (var i=0; i<list.length; i++) {
            if (list[i].ctgKey == val2) {
                html += "<option value="+list[i].ctgKey+" selected>"+ list[i].name +"</option>";
            } else {
                html += "<option value="+list[i].ctgKey+">"+ list[i].name +"</option>";
            }
        }
        html += "</select>";
        innerHTML(tag_id, html);
    });
}

//급수,과목,유형
function getSelectboxListForCtgKey(tag_id, val) {
    selectboxService.getSelectboxListForCtgKey(val, function (list) {
        var html = "<select id='sel_1' class=\"col-sm-5 select2 form-control custom-select\">";
        html += "<option value='' selected>선택</option>";
        for (var i=0; i<list.length; i++) {
            if (list[i].key == val) {
                html += "<option value="+list[i].key+" selected>"+ list[i].value +"</option>";
            } else {
                html += "<option value="+list[i].key+">"+ list[i].value +"</option>";
            }
        }
        html += "</select>";
        innerHTML(tag_id, html);
    });
}

//모의고사 문제은행 출제구분 divisionCtgKey
function getSelectboxListdivisionCtgKey(tag_id, val, val2) {
    selectboxService.getSelectboxListForCtgKey(val, function (list) {
        var html = "<select id='divisionCtgKey' name='divisionCtgKey' onchange='' class=\"col-sm-5 select2 form-control custom-select\">";
        html += "<option value='' selected>선택</option>";
        for (var i=0; i<list.length; i++) {
            if (list[i].key == val2) {
                html += "<option value="+list[i].key+" selected>"+ list[i].value +"</option>";
            } else {
                html += "<option value="+list[i].key+">"+ list[i].value +"</option>";
            }
        }
        html += "</select>";
        innerHTML(tag_id, html);
    });
}

//급수,과목,유형
function getNewSelectboxListForCtgKey(tag_id, val, val2) {
    selectboxService.getSelectboxListForCtgKey(val, function (list) {
        var html = "<select id='selClassGroupCtgKey' name='classGroupCtgKey' class=\"col-sm-3 select2 form-control custom-select\">";
        html += "<option value='' selected>선택</option>";
        for (var i=0; i<list.length; i++) {
            if (list[i].key == val2) {
                html += "<option value="+list[i].key+" selected>"+ list[i].value +"</option>";
            } else {
                html += "<option value="+list[i].key+">"+ list[i].value +"</option>";
            }
        }
        html += "</select>";
        innerHTML(tag_id, html);
    });
}

//급수,과목,유형
function getNewSelectboxListForCtgKey2(tag_id, val, val2) {
    selectboxService.getSelectboxListForCtgKey(val, function (list) {
        var html = "<select id='selSubjectCtgKey' name='subjectCtgKey' class=\"col-sm-3 select2 form-control custom-select\">";
        html += "<option value='' selected>선택</option>";
        for (var i=0; i<list.length; i++) {
            if (list[i].key == val2) {
                html += "<option value="+list[i].key+" selected>"+ list[i].value +"</option>";
            } else {
                html += "<option value="+list[i].key+">"+ list[i].value +"</option>";
            }
        }
        html += "</select>";
        innerHTML(tag_id, html);
    });
}

//급수,과목,유형
function getNewSelectboxListForCtgKey3(tag_id, val, val2) {
    selectboxService.getSelectboxListForCtgKey(val, function (list) {
        var html = "<select id='selStepCtgKey' name='stepCtgKey' class=\"col-sm-3 select2 form-control custom-select\">";
        html += "<option value='' selected>선택</option>";
        for (var i=0; i<list.length; i++) {
            if (list[i].key == val2) {
                html += "<option value="+list[i].key+" selected>"+ list[i].value +"</option>";
            } else {
                html += "<option value="+list[i].key+">"+ list[i].value +"</option>";
            }
        }
        html += "</select>";
        innerHTML(tag_id, html);
    });
}

//급수,과목,유형
function getNewSelectboxListForCtgKey4(tag_id, val, val2) {
    selectboxService.getSelectboxListForCtgKey(val, function (list) {
        var html = "<select id='selSubjectCtgKey1' name='subjectCtgKey' class=\"col-sm-5 select2 form-control custom-select\">";
        html += "<option value='' selected>선택</option>";
        for (var i=0; i<list.length; i++) {
            if (list[i].key == val2) {
                html += "<option value="+list[i].key+" selected>"+ list[i].value +"</option>";
            } else {
                html += "<option value="+list[i].key+">"+ list[i].value +"</option>";
            }
        }
        html += "</select>";
        innerHTML(tag_id, html);
    });
}

//급수,과목,유형
function getNewSelectboxListForCtgKey5(tag_id, val, val2) {
    selectboxService.getSelectboxListForCtgKey(val, function (list) {
        var html = "<select name='subjectCtgKey' class=\"col-sm-5 select2 form-control custom-select\">";
        html += "<option value='' selected>선택</option>";
        for (var i=0; i<list.length; i++) {
            if (list[i].key == val2) {
                html += "<option value="+list[i].key+" selected>"+ list[i].value +"</option>";
            } else {
                html += "<option value="+list[i].key+">"+ list[i].value +"</option>";
            }
        }
        html += "</select>";
        innerHTML(tag_id, html);
    });
}


//선생님 리스트
function selectTeacherSelectbox(tag_id,val) {
    selectboxService.selectTeacherSelectbox(function (list) {
       var html = "<select id='sel_1' onchange='' class='form-control'>";
        html += "<option value='' selected>강사선택</option>";
        for (var i=0; i<list.length; i++) {
            if (list[i].teacherKey == val) {
                html += "<option value="+list[i].teacherKey+" selected>"+ list[i].teacherName +"</option>";
            } else {
                html += "<option value="+list[i].teacherKey+">"+ list[i].teacherName +"</option>";
            }
        }
        html += "</select>";
        innerHTML(tag_id, html);
    });
}

//강좌수, 강좌시간 리스트
function getLectureCountSelectbox(tag_id,val) {
    selectboxService.getLectureCountSelectbox(function (list) {
        var html = "<select id='sel_1' onchange='' class='form-control'>";
        html += "<option value='' selected>선택</option>";
        for (var i=0; i<list.length; i++) {
            if (list[i] == val) {
                html += "<option value="+list[i]+" selected>"+ list[i]+"</option>";
            } else {
                html += "<option value="+list[i]+">"+ list[i]+"</option>";
            }
        }
        html += "</select>";
        innerHTML(tag_id, html);
    });
}

//수강일수
function getClassRegistraionDaySelectbox(tag_id,val) {
    selectboxService.getLectureCountSelectbox(function (list) {
        var html = "<select id='sel_1' onchange='' class='col-sm-3 select2 form-control custom-select'>";
        html += "<option value='' selected>선택</option>";
        for (var i=0; i<list.length; i++) {
            if (list[i] == val) {
                html += "<option value="+list[i]+" selected>"+ list[i]+"</option>";
            } else {
                html += "<option value="+list[i]+">"+ list[i]+"</option>";
            }
        }
        html += "</select>";
        innerHTML(tag_id, html);
    });
}

//모의고사 검색 셀렉트박스
function selectExamSearchSelectbox(tag_id,val) {
    selectboxService.selectExamSearchSelectbox(function (list) {
        var html = "<select id='sel_1' onchange='' class='form-control'>";
        html += "<option value='' selected>선택</option>";
        for (var i=0; i<list.length; i++) {
            if (list[i].value == val) {
                html += "<option value="+list[i].key+" selected>"+ list[i].value+"</option>";
            } else {
                html += "<option value="+list[i].key+">"+ list[i].value+"</option>";
            }
        }
        html += "</select>";
        innerHTML(tag_id, html);
    });
}

//시험대비년도 셀레긑박스
function getExamPrepareSelectbox(tag_id,val) {
    selectboxService.getExamPrepareSelectbox(function (list) {
        var html = "<select id='sel_1' onchange='' class='col-sm-3 select2 form-control custom-select'>";
        html += "<option value='' selected>선택</option>";
        for (var i=0; i<list.length; i++) {
            if (list[i] == val) {
                html += "<option value="+list[i]+" selected>"+ list[i]+"</option>";
            } else {
                html += "<option value="+list[i]+">"+ list[i]+"</option>";
            }
        }
        html += "</select>";
        innerHTML(tag_id, html);
    });
}


//진행상태 셀렉트박스
function getLectureStatusSelectbox(tag_id,val) {
    selectboxService.getLectureStatusSelectbox(function (list) {
        var html = "<select id='sel_subDomain' onchange='' class='form-control'>";
        html += "<option value='' selected>선택</option>";
        for (var i=0; i<list.length; i++) {
            if (list[i].key == val) {
                html += "<option value="+list[i].key+" selected>"+ list[i].value +"</option>";
            } else {
                html += "<option value="+list[i].key+">"+ list[i].value +"</option>";
            }
        }
        html += "</select>";
        innerHTML(tag_id, html);
    });
}

//강조표시 셀렉트박스
function getEmphasisSelectbox(tagId, val) {
    selectboxService.getEmphasisList(function (list) {
        var html = "<select id='sel_emphasis' name='emphasis' class='col-sm-3 select2 form-control custom-select'>";
        html += "<option value='' selected>선택</option>";
        for (var i=0; i<list.length; i++) {
            if (list[i].key == val) {
                html += "<option value="+list[i].key+" selected>"+ list[i].value +"</option>";
            } else {
                html += "<option value="+list[i].key+">"+ list[i].value +"</option>";
            }
        }
        html += "</select>";
        innerHTML(tagId, html);
    });
}

//동영상 저장 옵션명
function getVideoOptionTypeSelectbox(val) {
    var optionName = "";
    var html = "<select id='sel_option' name='selOption[]' class='col-sm-7 select2 form-control custom-select'>";
    html += "<option value=''>선택</option>";
    for (var i = 100; i < 103; i++) {
        if(i == 100) optionName = 'VOD';
        else if(i == 101) optionName = 'Mobile';
        else optionName = 'VOD + Mobile';
        if (i == val) {
            html += "<option value="+i+" selected>" + optionName + "</option>";
        } else {
            html += "<option value="+i+">" + optionName + "</option>";
        }
    }
    html += "</select>";
    return html;
}

function getOptionSelectbox(val) {
    var html = "<select id='sel_option' name='selOption[]' class='col-sm-7 select2 form-control custom-select'>";
    html += "<option value=''>선택</option>";
    for (var i=1; i<13; i++) {
        if (i == val) {
            html += "<option value="+i+" selected>"+ i +"개월</option>";
        } else {
            html += "<option value="+i+">"+ i +"개월</option>";
        }
    }
    html += "</select>";
    return html;
}

function getOptionSelectboxAddTag(val, tagId) {
    var html = "<select id='sel_option' name='selOption[]' class='col-sm-7 select2 form-control custom-select'>";
    html += "<option value=''>선택</option>";
    for (var i=1; i<25; i++) {
        if (i == val) {
            html += "<option value="+i+" selected>"+ i +"개월</option>";
        } else {
            html += "<option value="+i+">"+ i +"개월</option>";
        }
    }
    html += "</select>";
    innerHTML(tagId, html);
}

function getCategoryNoTag(tableId, val, tdNum) {
    var nextTdNum = Number(tdNum)+2;
    var html = "<select id='sel_category' name='selCategory[]' onchange='changeCategory(this.value"+ ","+ '"' + tableId + '"' + ","+ '"' + nextTdNum + '"' + ");' class='form-control'>";
    html += "<option value=''>선택</option>";
    selectboxService.getCategoryList(val, function (list) {
        for (var i=0; i<list.length; i++) {
            html += "<option value="+list[i].ctgKey+">"+ list[i].name +"</option>";
        }
        html += "</select>";
        $("#"+ tableId).find("tbody").find("tr:last").find("td").eq(tdNum).html(html);
        $("#"+ tableId).find("tbody").find("tr:last").find("td input").eq(0).val(val);
    });
}


//강사관리 - 과목 셀렉트박스
function getTeacherSubjectCategoryList2(tagId, val, index) {
    selectboxService.getCategoryList(3710, function (list) {
        var html = "<select name='subjectCtgKey' class='col-sm-3 select2 form-control custom-select'>";
        html += "<option value='' selected>선택</option>";
        for (var i=0; i<list.length; i++) {
            if(list[i].ctgKey == val){
                html += "<option value="+list[i].ctgKey+" selected>"+ list[i].name +"</option>";
            }else{
                html += "<option value="+list[i].ctgKey+">"+ list[i].name +"</option>";
            }
        }
        html += "</select>";
        innerHTML(tagId, html);
    });
}



//학원강의 등록 카테고리
function getCategoryNoTag2(tableId, val, tdNum) {
    var nextTdNum = Number(tdNum)+2;
    var html = "<select id='sel_category' name='selCategory[]' onchange='changeCategory(this.value"+ ","+ '"' + tableId + '"' + ","+ '"' + nextTdNum + '"' + ");' class='form-control'>";
    html += "<option value=''>선택</option>";
    selectboxService.getCategoryList(val, function (list) {
        for (var i=0; i<list.length; i++) {
            html += "<option value="+list[i].ctgKey+">"+ list[i].name +"</option>";
        }
        html += "</select>";
        $("#"+ tableId).find("tbody").find("tr:last").find("td").eq(tdNum).html(html);
        $("#"+ tableId).find("tbody").find("tr:last").find("td input").eq(0).val(val);
    });
}

//모의고사 등록 - 분류 셀렉트박스 //688
function getMockCategoryList(tagId, val) {
    selectboxService.getCategoryList(688, function (list) {
        var html = "<select id='classCtgKey' name='classCtgKey' class='col-sm-3 select2 form-control custom-select'>";
        html += "<option value='' selected>선택</option>";
        for (var i=0; i<list.length; i++) {
            if(list[i].ctgKey == val){
                html += "<option value="+list[i].ctgKey+" selected>"+ list[i].name +"</option>";
            }else{
                html += "<option value="+list[i].ctgKey+">"+ list[i].name +"</option>";
            }
        }
        html += "</select>";
        innerHTML(tagId, html);
    });
}

//강사관리 - 과목 셀렉트박스
function getTeacherSubjectCategoryList(tagId, val) {
    selectboxService.getCategoryList(3710, function (list) {
        var html = "<select name='subjectCtgKey' class='col-sm-3 select2 form-control custom-select'>";
        html += "<option value=''>선택</option>";
        for (var i=0; i<list.length; i++) {
            if(list[i].ctgKey == val){
                html += "<option value="+list[i].ctgKey+" selected>"+ list[i].name +"</option>";
            }else{
                html += "<option value="+list[i].ctgKey+">"+ list[i].name +"</option>";
            }
        }
        html += "</select>";
        innerHTML(tagId, html);
        //$("#prod_list").find("tbody").find("tr:last").find("td").eq(1).html(html);
    });
}

//강사관리 - 과목 셀렉트박스
function getTeacherSubjectCategoryList3(val, index) {

    selectboxService.getCategoryList(3710, function (list) {
        var html = "<select name='subjectCtgKey' class='col-sm-3 select2 form-control custom-select'>";
        html += "<option value=''>선택</option>";
        for (var i=0; i<list.length; i++) {
            if(list[i].ctgKey == val){
                html += "<option value="+list[i].ctgKey+" selected>"+ list[i].name +"</option>";
            }else{
                html += "<option value="+list[i].ctgKey+">"+ list[i].name +"</option>";
            }
        }
        html += "</select>";
        //innerHTML(tagId, html);
        $("#newList").find("tr").eq(0).find("td").eq(1).html(html);
        $("#newList").find("tr").eq(2).find("td").eq(1).html(html);
    });
}

function getTeacherSubjectCategoryList4(val) {
    selectboxService.getCategoryList(3710, function (list) {
        var html = "<select name='subjectCtgKey4' class='col-sm-3 select2 form-control custom-select'>";
        html += "<option value=''>선택</option>";
        for (var i=0; i<list.length; i++) {
            if(list[i].ctgKey == val){
                html += "<option value="+list[i].ctgKey+" selected>"+ list[i].name +"</option>";
            }else{
                html += "<option value="+list[i].ctgKey+">"+ list[i].name +"</option>";
            }
        }
        html += "</select>";
        //innerHTML(tagId, html);
        //$("#prod_list").find("tbody").find("tr").eq(index).find("td").eq(0).html(html);
        $(".testContent").find("span").eq(0).html(html);
    });
}


function getTeacherSubjectCategoryList9(val) {
    selectboxService.getCategoryList(3710, function (list) {
        var html = "<select name='subjectCtgKey4' class='col-sm-3 select2 form-control custom-select'>";
        html += "<option value=''>선택</option>";
        for (var i=0; i<list.length; i++) {
            if(list[i].ctgKey == val){
                html += "<option value="+list[i].ctgKey+" selected>"+ list[i].name +"</option>";
            }else{
                html += "<option value="+list[i].ctgKey+">"+ list[i].name +"</option>";
            }
        }
        html += "</select>";
        //innerHTML(tagId, html);
        //$("#prod_list").find("tbody").find("tr").eq(index).find("td").eq(0).html(html);
        $(".testContent1").find("span").eq(0).html(html);
    });
}

function getTeacherSubjectCategoryList5(val) {
    selectboxService.getCategoryList(3710, function (list) {
        var html = "<select name='mobilesubjectCtgKey' class='col-sm-3 select2 form-control custom-select'>";
        html += "<option value=''>선택</option>";
        for (var i=0; i<list.length; i++) {
            if(list[i].ctgKey == val){
                html += "<option value="+list[i].ctgKey+" selected>"+ list[i].name +"</option>";
            }else{
                html += "<option value="+list[i].ctgKey+">"+ list[i].name +"</option>";
            }
        }
        html += "</select>";
        //innerHTML(tagId, html);
        //$("#prod_list").find("tbody").find("tr").eq(index).find("td").eq(0).html(html);
        $(".mobiletestContent1").find("span").eq(0).html(html);
    });
}

function getTeacherSubjectCategoryList10(val) {
    selectboxService.getCategoryList(3710, function (list) {
        var html = "<select name='mobilesubjectCtgKey' class='col-sm-3 select2 form-control custom-select'>";
        html += "<option value=''>선택</option>";
        for (var i=0; i<list.length; i++) {
            if(list[i].ctgKey == val){
                html += "<option value="+list[i].ctgKey+" selected>"+ list[i].name +"</option>";
            }else{
                html += "<option value="+list[i].ctgKey+">"+ list[i].name +"</option>";
            }
        }
        html += "</select>";
        //innerHTML(tagId, html);
        //$("#prod_list").find("tbody").find("tr").eq(index).find("td").eq(0).html(html);
        $(".mobiletestContent2").find("span").eq(0).html(html);
    });
}



function getTeacherSubjectCategoryList6(val, index) {
    selectboxService.getCategoryList(3710, function (list) {
        // index =  index+1;
        var html = "<select name='mobilesubjectCtgKey6' class='col-sm-3 select2 form-control custom-select'>";
        html += "<option value=''>선택</option>";
        for (var i=0; i<list.length; i++) {
            if(list[i].ctgKey == val){
                html += "<option value="+list[i].ctgKey+" selected>"+ list[i].name +"</option>";
            }else{
                html += "<option value="+list[i].ctgKey+">"+ list[i].name +"</option>";
            }
        }
        html += "</select>";
        //innerHTML(tagId, html);
        $("#newList1").find("tr").eq(0).find("td").eq(1).html(html);
    });
}

function getTeacherSubjectCategoryList7(val) {
    selectboxService.getCategoryList(3710, function (list) {
        var html = "<select name='mobilesubjectCtgKey' class='col-sm-3 select2 form-control custom-select'>";
        html += "<option value=''>선택</option>";
        for (var i=0; i<list.length; i++) {
            if(list[i].ctgKey == val){
                html += "<option value="+list[i].ctgKey+" selected>"+ list[i].name +"</option>";
            }else{
                html += "<option value="+list[i].ctgKey+">"+ list[i].name +"</option>";
            }
        }
        html += "</select>";
        //innerHTML(tagId, html);
        //$("#prod_list").find("tbody").find("tr").eq(index).find("td").eq(0).html(html);
        $(".mobiletestContent").find("span").eq(0).html(html);
    });
}


//강사관리 - 과목 셀렉트박스 123
function getMemberTeacerCategoryList(val) {
    selectboxService.getCategoryList(3710, function (list) {
        var html = "<select name='subjectCtgKey' class='col-sm-3 select2 form-control custom-select'>";
        html += "<option value='' selected>선택</option>";
        for (var i=0; i<list.length; i++) {
            if(list[i].ctgKey == val){
                html += "<option value="+list[i].ctgKey+" selected>"+ list[i].name +"</option>";
            }else{
                html += "<option value="+list[i].ctgKey+">"+ list[i].name +"</option>";
            }
        }
        html += "</select>";
        innerHTML(tagId, html);
    });
}




function getTeacherSubjectCategoryList1(tagId, val) {
    selectboxService.getCategoryList(3710, function (list) {
        var html = "<select name='subjectCtgKey1' class='col-sm-3 select2 form-control custom-select'>";
        html += "<option value='' selected>선택</option>";
        for (var i=0; i<list.length; i++) {
            if(list[i].ctgKey == val){
                html += "<option value="+list[i].ctgKey+" selected>"+ list[i].name +"</option>";
            }else{
                html += "<option value="+list[i].ctgKey+">"+ list[i].name +"</option>";
            }
        }
        html += "</select>";
        innerHTML(tagId, html);
    });
}


function defaultCategorySelectbox() {
    var html = "<select id='sel_category' name='selCategory[]' onchange='' class='form-control'>";
    html += "<option value=''>선택</option>";
    html += "</select>";
    return html;
}


function getSelectboxListForCtgKeyNoTag(tableId, val, tdNum) {
    selectboxService.getSelectboxListForCtgKey(val, function (list) {
        var html = "<select id='selSubjectKey' name='selSubjectByTeacher[]' onchange='injectSubjectKey(this.value)' class='form-control'>";
        html += "<option value='' selected>선택</option>";
        for (var i=0; i<list.length; i++) {
            if (list[i].key == val) {
                html += "<option value="+list[i].key+" selected>"+ list[i].value +"</option>";
            } else {
                html += "<option value="+list[i].key+">"+ list[i].value +"</option>";
            }
        }
        html += "</select>";
        $("#"+ tableId).find("tbody").find("tr:last").find("td").eq(tdNum).html(html);
    });
}

function getSelectboxListForCtgKeyNoTag2(tableId, val, tdNum) {
    selectboxService.getSelectboxListForCtgKey(val, function (list) {
        var html = "<select id='selSubjectKey' name='selSubjectByTeacher[]' onchange='injectSubjectKey(this.value)' class='form-control'>";
        html += "<option value='' selected>선택</option>";
        for (var i=0; i<list.length; i++) {
            if (list[i].key == val) {
                html += "<option value="+list[i].key+" selected>"+ list[i].value +"</option>";
            } else {
                html += "<option value="+list[i].key+">"+ list[i].value +"</option>";
            }
        }
        html += "</select>";
        $("#"+ tableId).find("tbody").find("tr:last").find("select").eq(tdNum).html(html);
    });
}

function selectTeacherSelectboxNoTag(tableId, tdNum) {
    selectboxService.selectTeacherSelectbox(function (list) {
        var html = "<select id='selTeacherKey' name='selTeacher[]' onchange='injectTeacherKey(this.value)' class='form-control'>";
        html += "<option value='' selected>선택</option>";
        for (var i=0; i<list.length; i++) {
            html += "<option value="+list[i].teacherKey+">"+ list[i].teacherName +"</option>";
        }
        html += "</select>";
        $("#"+ tableId).find("tbody").find("tr:last").find("td").eq(tdNum).html(html);
    });
}

function selectTeacherSelectboxNoTag2(tableId, tdNum) {
    selectboxService.selectTeacherSelectbox(function (list) {
        var html = "<select id='selTeacherKey' name='selTeacher[]' onchange='injectTeacherKey(this.value)' class='form-control'>";
        html += "<option value='' selected>선택</option>";
        for (var i=0; i<list.length; i++) {
            html += "<option value="+list[i].teacherKey+">"+ list[i].teacherName +"</option>";
        }
        html += "</select>";
        $("#"+ tableId).find("tbody").find("tr:last").find("select").eq(tdNum).html(html);
    });
}

function getMockExamSearchTypeSelectbox(tagId) {
    selectboxService.selectExamSearchSelectbox(function (list) {
        var html = "<select id='searchType' class='form-control'>";
        html += "<option value='' selected>선택</option>";
        for (var i=0; i<list.length; i++) {
            html += "<option value="+list[i].key+">"+ list[i].value +"</option>";
        }
        html += "</select>";
        innerHTML(tagId, html);
    });
}

function getProductSearchTypeSelectbox(tagId) {
    selectboxService.getVideoSearchTypeList(function (list) {
        var html = "<select id='searchType' class='form-control'>";
        html += "<option value='' selected>선택</option>";
        for (var i=0; i<list.length; i++) {
            html += "<option value="+list[i].key+">"+ list[i].value +"</option>";
        }
        html += "</select>";
        innerHTML(tagId, html);
    });
}

function getExamYearSelectbox(tagId) {
    selectboxService.getExamPrepareSelectbox(function (list) {
        var html = "<select id='selYear' class='form-control' onchange=''>";
        html += "<option value='' selected>선택</option>";
        for (var i=0; i<list.length; i++) {
            html += "<option value="+list[i]+">"+ list[i]+"년</option>";
        }
        html += "</select>";
        innerHTML(tagId, html);
    });
}

function getMonthsSelectbox(tagId) {
    var html = "<select id='selMonth' class='form-control'>";
    html += "<option value=''>선택</option>";
    for (var i=1; i<13; i++) {
        html += "<option value="+i+">"+ i +"월</option>";
    }
    html += "</select>";
    innerHTML(tagId, html);
}

//모의고사 출제년도 셀렉트박스
function getMockYearSelectbox(tagId, val) {
    var yearAgo   = getYearAgo(3650);
    var yearAfter =  getYearAfter(4015);
    var html = "<select id='examYear' name='examYear' class='col-sm-5 select2 form-control custom-select'>";
    html += "<option value=''>선택</option>";
    for (var i=yearAgo; i<yearAfter; i++) {
        if (i == val) {
            html += "<option value="+i+" selected>"+ i +"년</option>";
        }else{
            html += "<option value="+i+">"+ i +"년</option>";
        }
    }
    innerHTML(tagId, html);
}

//숫자 1-9까지 앞에 0 채우기
function leadingZeros(date, num) {
    if(date == 10) return 10;
    var zero = '';
    date = date.toString();

    if (date.length < num) {
        for (i = 0; i < num - date.length; i++)
            zero += '0';
    }
    return zero + date;
}

//시간(Hour) 셀렉트박스
function getTimeHourSelectbox(tagId, val) {
    var html = "<select id='timeHour' name='timeHour' class='form-control'>";
    for (var i=0; i<25; i++) {
        if (i == val) {
            html += "<option value="+i+" selected>"+ leadingZeros(i,2) +"</option>";
        } else {
            html += "<option value="+i+">"+ leadingZeros(i,2) +"</option>";
        }
    }
    html += "</select>";
    innerHTML(tagId, html);
}

//시간(분) 셀렉트박스
function getTimeMinuteSelectbox(tagId, val) {
    var html = "<select id='timeMinute' name='timeMinute' class='form-control'>";
    for (var i=0; i<60; i++) {
        if (i == val) {
            html += "<option value="+i+" selected>"+ leadingZeros(i,2) +"</option>";
        } else {
            html += "<option value="+i+">"+ leadingZeros(i,2) +"</option>";
        }
    }
    html += "</select>";
    innerHTML(tagId, html);
}

//모의고사문제은행 정답 셀렉트박스
function getAnswerSelectbox(tagId, val) {
    var html = "<select id='answer' name='answer' class='col-sm-5 select2 form-control custom-select'>";
    html += "<option value=''>선택</option>";
    for (var i=1; i<6; i++) {
        if(i == val){
            html += "<option value="+i+" selected>"+ i +"</option>";
        }else{
            html += "<option value="+i+">"+ i +"</option>";
        }
    }
    html += "</select>";
    innerHTML(tagId, html);
}

//모의고사 문제은행 난이도
function getExamLevelSelectbox(tagId, val) {
    selectboxService.selectExamLevelSelectbox(function (list) {
        var html = "<select id='examLevel' name='examLevel'  class='col-sm-5 select2 form-control custom-select'>";
        html += "<option value='' selected>선택</option>";
        for (var i=0; i<list.length; i++) {
            if (list[i].key == val) {
                html += "<option value="+list[i].key+" selected>"+ list[i].value +"</option>";
            }else{
                html += "<option value="+list[i].key+">"+ list[i].value +"</option>";
            }
        }
        html += "</select>";
        innerHTML(tagId, html);
    });
}

//모의고사 문제은행 유형,패턴,단원 - 단계별
function getSelectboxstepCtgKey(tableId, val, tdNum) {
    var nextTdNum = Number(tdNum)+1;
    var html = "<select  id='mokSel' onchange='changeExamUnit(this.value"+ ","+ '"' + tableId + '"' + ","+ '"' + nextTdNum + '"' + ");' class=\"form-control\">";
    html += "<option value='' selected>선택</option>";
    selectboxService.getSelectboxListForCtgKey(val, function (list) {
        for (var i=0; i<list.length; i++) {
            if (list[i].key == val) {
                html += "<option value="+list[i].key+" selected>"+ list[i].value +"</option>";
            } else {
                html += "<option value="+list[i].key+">"+ list[i].value +"</option>";
            }
        }
        html += "</select>";
        $("#"+ tableId).find("tbody").find("td").eq(tdNum).html(html);
    });
}

//모의고사 문제은행 수정 유형,패턴,단원 - 단계별
function getSelectboxstepCtgKey2(tableId, val, tdNum, val2) {
    var nextTdNum = Number(tdNum)+1;
    var html = "<select  id='mokSel' onchange='changeExamUnit(this.value"+ ","+ '"' + tableId + '"' + ","+ '"' + nextTdNum + '"' + ","+ '"' + '' + '"' + ");' class=\"form-control\">";
    html += "<option value='' selected>선택</option>";
    selectboxService.getSelectboxListForCtgKey(val, function (list) {
        for (var i=0; i<list.length; i++) {
            if (list[i].key == val2) {
                html += "<option value="+list[i].key+" selected>"+ list[i].value +"</option>";
            } else {
                html += "<option value="+list[i].key+">"+ list[i].value +"</option>";
            }
        }
        html += "</select>";
        $("#"+ tableId).find("tbody").find("td").eq(tdNum).html(html);
    });
}


//모의고사 문제은행 목록검색 - 전체가져오기 패턴 셀렉트박스
function getExamPatternSelectbox(tagId, val) {
    selectboxService.selectPatternSelectbox(function (list) {
        var html = "<select id='selPattern' name='selPattern'  class='col-sm-5 select2 form-control custom-select'>";
        html += "<option value='' selected>선택</option>";
        for (var i=0; i<list.length; i++) {
            if (list[i].ctgKey == val) {
                html += "<option value="+list[i].ctgKey+" selected>"+ list[i].name +"</option>";
            }else{
                html += "<option value="+list[i].ctgKey+">"+ list[i].name +"</option>";
            }
        }
        html += "</select>";
        innerHTML(tagId, html);
    });
}

//모의고사 문제은행 목록검색 - 전체가져오기 유형 셀렉트박스
function getTypeSelectbox(tagId, val) {
    selectboxService.selectTypeSelectbox(function (list) {
        var html = "<select id='selUnit' name='selUnit'  class='col-sm-5 select2 form-control custom-select'>";
        html += "<option value='' selected>선택</option>";
        for (var i=0; i<list.length; i++) {
            if (list[i].ctgKey == val) {
                html += "<option value="+list[i].ctgKey+" selected>"+ list[i].name +"</option>";
            }else{
                html += "<option value="+list[i].ctgKey+">"+ list[i].name +"</option>";
            }
        }
        html += "</select>";
        innerHTML(tagId, html);
    });
}

function deviceLimitSelectbox(tagId, val) {
    var html = "<select id='deviceLimitCount' class='form-control'>";
    html += "<option value=''>선택</option>";
    for (var i=0; i<11; i++) {
        if(i == 0){
            if(val == 0){
                html += "<option value="+ i +" selected>무제한</option>";
            }else{
                html += "<option value="+ i +">무제한</option>";
            }
        }else if(i == val){
            html += "<option value="+i+" selected>"+ i +"</option>";
        }else{
            html += "<option value="+i+">"+ i +"</option>";
        }
    }
    html += "</select>";
    innerHTML(tagId, html);
}

/* 주문관리 - 처리상태  */
function orderStatusTypeSelecbox(tagId, val) {
    var html = "<select id='orderStatus' name='orderStatus' class='col-sm-5 select2 form-control custom-select'>";

        if(val == '-1') html += "<option value='-1' selected>전체</option>";
        else html += "<option value='-1'>전체</option>";
        if(val == '0') html += "<option value='0' selected>입금예정</option>";
        else html += "<option value='0'>입금예정</option>";
        if(val == '1') html += "<option value='1' selected>결제대기</option>";
        else html += "<option value='1'>결제대기</option>";
        if(val == '2') html += "<option value='2' selected>결제완료</option>";
        else html += "<option value='2'>결제완료</option>";
        html += "</select>";

        innerHTML(tagId, html);
}

/* 주문관리 - 처리상태  */
function orderPayStatusTypeSelecbox(tagId, val) {
    var html = "<select id='orderPayStatus' name='orderPayStatus' class='col-sm-5 select2 form-control custom-select'>";
        if(val == '-1') html += "<option value='-1' selected>전체</option>";
        else html += "<option value='-1'>전체</option>";
        if(val == '8') html += "<option value='8' selected>결제취소</option>";
        else html += "<option value='8'>결제취소</option>";
        if(val == '9') html += "<option value='9' selected>주문취소</option>";
        else html += "<option value='9'>주문취소</option>";
        if(val == '10') html += "<option value='10' selected>결제실패</option>";
        else html += "<option value='10'>결제실패</option>";
        html += "</select>";

        innerHTML(tagId, html);
}

/* 주문관리 - 처리상태  */
function orderStatusTypeChangeSelecbox(tagId, val) {
    var html = "<select id='orderStatus' name='orderStatus' class='col-sm-5 select2 form-control custom-select'>";

    if(val == '-1') html += "<option value='' selected>선택</option>";
    else html += "<option value=''>선택</option>";
    if(val == '0') html += "<option value='0' selected>입금예정</option>";
    else html += "<option value='0'>입금예정</option>";
    if(val == '1') html += "<option value='1' selected>결제대기</option>";
    else html += "<option value='1'>결제대기</option>";
    if(val == '2') html += "<option value='2' selected>결제완료</option>";
    else html += "<option value='2'>결제완료</option>";
    if(val == '8') html += "<option value='8' selected>결제취소</option>";
    else html += "<option value='8'>결제취소</option>";
    if(val == '9') html += "<option value='9' selected>주문취소</option>";
    else html += "<option value='9'>주문취소</option>";
    if(val == '10') html += "<option value='10' selected>결제실패</option>";
    else html += "<option value='10'>결제실패</option>";
    html += "</select>";

    innerHTML(tagId, html);
}

/* 주문관리 - 구매장소  */
function isOfflineSelectbox(tagId, val) {
    var html = "<select id='isOffline' name='isOffline' class='col-sm-5 select2 form-control custom-select'>";

    if(val == '-1') html += "<option value='-1' selected>전체</option>";
    else html += "<option value='-1'>전체</option>";
    if(val == '0') html += "<option value='0' selected>온라인</option>";
    else html += "<option value='0'>온라인</option>";
    if(val == '1') html += "<option value='1' selected>오프라인</option>";
    else html += "<option value='1'>오프라인</option>";
    html += "</select>";
    innerHTML(tagId, html);
}

/* 주문관리 - 결제방법  */
function orderPayTypeSelectbox(tagId, val) {
    var html = "<select id='orderPayType' name='orderPayType' class='col-sm-5 select2 form-control custom-select'>";

    if(val == '-1') html += "<option value='-1' selected>전체</option>";
    else html += "<option value='-1'>전체</option>";
    if(val == '0') html += "<option value='0' selected>신용카드</option>";
    else html += "<option value='0'>신용카드</option>";
    if(val == '19') html += "<option value='19' selected>무통장입금</option>";
    else html += "<option value='19'>무통장입금</option>";
    if(val == '20') html += "<option value='20' selected>무료</option>";
    else html += "<option value='20'>무료</option>";
    if(val == '21') html += "<option value='21' selected>현금</option>";
    else html += "<option value='21'>현금</option>";
    if(val == '22') html += "<option value='22' selected>현금+신용카드</option>";
    else html += "<option value='22'>현금+신용카드</option>";
    if(val == '23') html += "<option value='23' selected>온라인</option>";
    else html += "<option value='23'>온라인</option>";
    html += "</select>";
    innerHTML(tagId, html);
}


/* 주문관리 - 결제방법  */
function orderSearchSelectbox(tagId, val) {
    var html = "<select id='searchType' class='col-sm-5 select2 form-control custom-select'>";
    html +=     '<option value="" selected>선택</option>';
    if(val == 'orderUserId') html += "<option value='orderUserId'>주문자 ID</option>";
    else html += "<option value='orderUserId'>주문자 ID</option>";
    if(val == 'orderUserName') html += "<option value='orderUserName' >주문자 이름</option>";
    else html += "<option value='orderUserName'>주문자 이름</option>";
    if(val == 'orderId') html += "<option value='orderId'>주문번호</option>";
    else html += "<option value='orderId'>주문번호</option>";
    if(val == 'orderGoodsName') html += "<option value='orderGoodsName'>상품명</option>";
    else html += "<option value='orderGoodsName'>상품명</option>";
    html += "</select>";
    innerHTML(tagId, html);
}

function listNumberSelectbox(tagId, val) {
    var html = "<select id='listNumberSel' onchange='changeList();' class='col-sm-3 select2 form-control custom-select'>";

    for (var i=10; i < 101; i+=10) {
        if(i == val){
            html += "<option value="+i+" selected>"+ i +"</option>";
        }else{
            html += "<option value="+i+">"+ i +"</option>";
        }
    }
    html += "</select>";
    innerHTML(tagId, html);
}

/*택배사*/
function deliveryCompanySelectbox(tagId, val) {
    selectboxService.selectDeliveryCompanyList(function (list) {
        var html = "<select id='deliverycompany'  class='col-sm-5 select2 form-control custom-select'>";
        for (var i=0; i<list.length; i++) {
            if (list[i].key == val) {
                html += "<option value="+list[i].key+" selected>"+ list[i].value +"</option>";
            }else{
                html += "<option value="+list[i].key+">"+ list[i].value +"</option>";
            }
        }
        html += "</select>";
        innerHTML(tagId, html);
    });
}

function orderDeliveryInfoSelectbox(tagId, val) {
    var html = "<select id='deliveryType' name='deliveryType' class='col-sm-5 select2 form-control custom-select'>";

    if(val == '0') html += "<option value='0' selected>준비중</option>";
    else html += "<option value='0'>준비중</option>";
    if(val == '1') html += "<option value='1' selected>배송중</option>";
    else html += "<option value='1'>배송중</option>";
    if(val == '2') html += "<option value='2' selected>배송완료</option>";
    else html += "<option value='2'>배송완료</option>";
    if(val == '3') html += "<option value='3' selected>방문수령</option>";
    else html += "<option value='3'>방문수령</option>";
    if(val == '4') html += "<option value='4' selected>방문수령완료</option>";
    else html += "<option value='4'>방문수령완료</option>";
    html += "</select>";

    innerHTML(tagId, html);
}

function getEmailSelectbox(tagId, val) {
    var html = '<select class=\'col-sm-5 select2 form-control custom-select\' id="emailSel" onchange="emailSelChange(this.value);">';
    html +=     '<option value="1">직접입력</option>';
    html +=     '<option value="naver.com">naver.com</option>';
    html +=     '<option value="chol.com">chol.com</option>';
    html +=     '<option value="dreamwiz.com">dreamwiz.com</option>';
    html +=     '<option value="empal.com">empal.com</option>';
    html +=     '<option value="freechel.com">freechel.com</option>';
    html +=     '<option value="gmail.com">gmail.com</option>';
    html +=     '<option value="hanafos.com">hanafos.com</option>';
    html +=     '<option value="hanmail.net">hanmail.net</option>';
    html +=     '<option value="hanmir.com">hanmir.com</option>';
    html +=     '<option value="hitel.net">hitel.net</option>';
    html +=     '<option value="hotmail.com">hotmail.com</option>';
    html +=     '<option value="korea.com">korea.com</option>';
    html +=     '<option value="lycos.co.kr">lycos.co.kr</option>';
    html +=     '<option value="nate.com">nate.com</option>';
    html +=     '<option value="netian.com">netian.com</option>';
    html +=     '<option value="paran.com">paran.com</option>';
    html +=     '<option value="yahoo.com">yahoo.com</option>';
    html +=     '<option value="yahoo.co.kr">yahoo.co.kr</option>';
    html +=  '</select>';
    innerHTML(tagId, html);
}

//수강내역목록 - 결제상태 셀렉박스
function getlectureWatchPayStatusSelectbox(tagId, val) {
    var html = "<select id='PayStatus' class='col-sm-5 select2 form-control custom-select'>";
    var selected = '';
    if(val == '2') selected = 'selected';
    else if(val == '8') selected = 'selected';

    html += "<option value='2' "+ selected +">결제완료</option>";
    html += "<option value='8' "+ selected +">결제취소</option>";
    html += "</select>";

    innerHTML(tagId, html);
}
//수강내역목록 - 진행상태 셀렉박스
function getlectureWatchOrderStatusSelectbox(tagId, val) {
    var html = "<select id='orderStatus' class='col-sm-5 select2 form-control custom-select'>";
    var selected = '';
    if(val == '1') selected = 'selected';
    else if(val == '2') selected = 'selected';
    else if(val == '3') selected = 'selected';
    else if(val == '4') selected = 'selected';


    html += "<option value='1' "+ selected +">대기중+시작</option>";
    html += "<option value='2' "+ selected +">일시정지</option>";
    html += "<option value='3' "+ selected +">종강</option>";
    html += "<option value='4' "+ selected +">재시작대기</option>";
    html += "</select>";

    innerHTML(tagId, html);
}

function getMemberSearchSelectbox(tagId) {
    var html = "<select class='col-sm-8 select2 form-control custom-select' id='memberSel'>";
    html +=  "<option value='name'>이름</option>";
    html +=  "<option value='id'>ID</option>";
    html +=  "<option value='phone'>전화번호</option>";
    html +=  "<option value='mobile'>휴대전화번호</option>";
    html +=  "<option value='code'>코드</option>";
    html +=  "</select>";
    innerHTML(tagId, html);
}

//학원수강 입력 = 결제방법
function getAcaLecturePayTypeSelectbox(tagId, val) {
    var html = "<select id='payType' class='col-sm-3 select2 form-control custom-select'>";
    var selected = '';
    if(val == '21') selected = 'selected';
    else if(val == '22') selected = 'selected';
    else selected = 'selected';

    html += "<option value='21' "+ selected +">현금</option>";
    html += "<option value='22' "+ selected +">현금+신용카드</option>";
    html += "<option value='23' "+ selected +">온라인</option>";
    html += "</select>";
    innerHTML(tagId, html);
}

//카드선택
function getCardKindSelectbox(tagId, val) {
    var html = "<select id='cardCode' class='col-sm-3 select2 form-control custom-select'>";
    var selected = '';
    if(val == '0') selected = 'selected';
    else if(val == '01') selected = 'selected';
    else if(val == '03') selected = 'selected';
    else if(val == '06') selected = 'selected';
    else if(val == '04') selected = 'selected';
    else if(val == '12') selected = 'selected';
    else if(val == '11') selected = 'selected';
    else if(val == '14') selected = 'selected';
    else if(val == '16') selected = 'selected';
    else if(val == '17') selected = 'selected';
    else if(val == '900') selected = 'selected';
    else if(val == '901') selected = 'selected';
    else selected = 'selected';

    html += "<option value='0' "+ selected +">카드선택</option>";
    html += "<option value='01' "+ selected +">외환</option>";
    html += "<option value='03' "+ selected +">롯데</option>";
    html += "<option value='06' "+ selected +">국민</option>";
    html += "<option value='04' "+ selected +">현대</option>";
    html += "<option value='12' "+ selected +">삼성</option>";
    html += "<option value='11' "+ selected +">BC</option>";
    html += "<option value='14' "+ selected +">신한</option>";
    html += "<option value='16' "+ selected +">NH</option>";
    html += "<option value='17' "+ selected +">하나 SK</option>";
    html += "<option value='900' "+ selected +">기업</option>";
    html += "<option value='901' "+ selected +">우리</option>";
    html += "<option value='999' "+ selected +">기타</option>";

    html += "</select>";
    innerHTML(tagId, html);
}

function deviceManageSelectbox(tagId, val) {
    var html = "<select id='deivceSel' class='form-control' onchange='changeDeviceList(this.value);'>";
    var selected = '';
    if(val == '0') selected = 'selected';
    else if(val == '1') selected = 'selected';
    html += "<option value='0' "+ selected +">상품별 디바이스 관리</option>";
    html += "<option value='1' "+ selected +">모바일 디바이스 관리</option>";
    html += "</select>";
    innerHTML(tagId, html);
}

/* 주문관리 - 디바이스  */
function deviceSelectbox(tagId, val) {
    var html = "<select id='deviceSel' name='deviceSel' class='col-sm-5 select2 form-control custom-select'>";

    if(val == '-1') html += "<option value='-1' selected>전체</option>";
    else html += "<option value='-1'>전체</option>";
    if(val == '0') html += "<option value='0' selected>PC</option>";
    else html += "<option value='0'>PC</option>";
    if(val == '1') html += "<option value='1' selected>Mobile</option>";
    else html += "<option value='1'>Mobile</option>";
    html += "</select>";
    innerHTML(tagId, html);
}
//

//디바이스관리 - 검색 셀렉트박스
function getSearchDeviceSelectbox(tagId) {
    var html = "<select id='searchType' class='form-control'>";
    html += "<option value=''>선택</option>";
    html += "<option value='id'>회원ID</option>";
    html += "<option value='name' >회원이름</option>";
    html += "<option value='device'>디바이스 ID</option>";
    html += "</select>";
    innerHTML(tagId, html);
}

function deviceSelectbox1(tagId, val) {
    var html = "<select id='deviceSel' name='deviceSel' class='col-sm-3 select2 form-control custom-select'>";

    if(val == 'pc') html += "<option value='pc' selected>PC</option>";
    else html += "<option value='pc'>PC</option>";
    if(val == 'mobile') html += "<option value='mobile' selected>Mobile</option>";
    else html += "<option value='mobile'>Mobile</option>";
    html += "</select>";
    innerHTML(tagId, html);
}

//selectMemberGradeTypeSelectbox
function memberGrageSelectBox(tagId, val) {
    selectboxService.selectMemberGradeTypeSelectbox(function (list) {
        var html = "<select id='memberGradeSel'  class='col-sm-5 select2 form-control custom-select'>";
        for (var i=0; i<list.length; i++) {
            if (list[i].key == val) {
                html += "<option value="+list[i].key+" selected>"+ list[i].value +"</option>";
            }else{
                html += "<option value="+list[i].key+">"+ list[i].value +"</option>";
            }
        }
        html += "</select>";
        innerHTML(tagId, html);
    });
}

function getwelfareDcPercentSelectBox(tagId, val) {
    var html = "<select id='twelfareDcPercentSel'  class='col-sm-5 select2 form-control custom-select'>";
    var selected = '';
    if(val == '0') selected = 'selected';
    else if(val == '30') selected = 'selected';
    else if(val == '50') selected = 'selected';
    html += "<option value='0' "+ selected +">없음</option>";
    html += "<option value='30' "+ selected +">30%</option>";
    html += "<option value='50' "+ selected +">50%</option>";
    html += "</select>";
    innerHTML(tagId, html);
}

//상담구분
function getConsultDivisionSelectBox(tagId, val) {
    selectboxService.selectCounselTypeSelectbox(function (list) {
        var html = "<select id='consultDivisionSel'  class='col-sm-5 select2 form-control custom-select'>";
        for (var i=0; i<list.length; i++) {
            if (list[i].key == val) {
                html += "<option value="+list[i].key+" selected>"+ list[i].value +"</option>";
            }else{
                html += "<option value="+list[i].key+">"+ list[i].value +"</option>";
            }
        }
        html += "</select>";
        innerHTML(tagId, html);
    });
}

//진행상태
function getConsultStatusSelectBox(tagId, val) {
    selectboxService.selectCounselStatusTypeSelectbox(function (list) {
        var html = "<select id='consultStatusSel'  class='col-sm-5 select2 form-control custom-select'>";
        for (var i=0; i<list.length; i++) {
            if (list[i].key == val) {
                html += "<option value="+list[i].key+" selected>"+ list[i].value +"</option>";
            }else{
                html += "<option value="+list[i].key+">"+ list[i].value +"</option>";
            }
        }
        html += "</select>";
        innerHTML(tagId, html);
    });
}

function searchMemberSelectBox(tagId) {
    var html = "<select id='searchMemberSel'  class='form-control'>";
    html += "<option value=''>선택</option>";
    html += "<option value='id'>아이디</option>";
    html += "<option value='name'>이름</option>";
    html += "</select>";
    innerHTML(tagId, html);
}

function searchMemberSelectBox1(tagId) {
    var html = "<select id='searchMemberSel1' class='form-control'>";
    html += "<option value=''>선택</option>";
    html += "<option value='id'>아이디</option>";
    html += "<option value='name'>이름</option>";
    html += "</select>";
    innerHTML(tagId, html);
}


function searchCounselSelectBox(tagId) {
    var html = "<select id='searchCounselSel' class='form-control'>";
    html += "<option value=''>선택</option>";
    html += "<option value='number'>상담번호</option>";
    html += "<option value='id'>회원아이디</option>";
    html += "<option value='name'>회원이름</option>";
    html += "</select>";
    innerHTML(tagId, html);
}

//강사정보 권한
function getAuthoritySelectbox(tagId, val) {
    var html = "<select id='authoritSel' class='form-control'>";
    var selected = "";

    if(val == '0') selected = 'selected';
    else if(val == '5') selected = 'selected';

    html += "<option value=0 "+ selected +">관리자</option>";
    html += "<option value=5 "+ selected +">강사</option>";
    html += "</select>";
    innerHTML(tagId, html);
}

//강사정보 관리자권한등급
function getAuthorityGradeSelectbox(tagId, val) {
    var html = "<select id='authoritGradeSel' class='form-control'>";
    var selected = "";

    if(val == '0') selected = 'selected';
    else if(val == '5') selected = 'selected';
    html += "<option value=0 "+ selected +">관리자</option>";
    html += "<option value=5 "+ selected +">강사</option>";
    html += "</select>";
    innerHTML(tagId, html);
}

//sms관리 년도 셀렉박스
function getSmsYearSelectbox(tagId, val) {
    var yearAgo   = getYearAgo(1460);
    var today = new Date();
    var mm = today.getMonth() + 1;
    var yyyy = today.getFullYear();
    var html = "<select id='searchYearMonth' name='searchYearMonth' class='form-control'>";
    html += "<option value=''>년월선택</option>";
    for (var i=yyyy; i>=yearAgo; i--) {
        if(i == yyyy || i == yearAgo){
            for(var j=mm; j>0; j--) {
                if(j < 10) j = "0"+j;
                if (i == val) html += "<option value=" + i + j + " selected>" + i + "년" + j + "월" + "</option>";
                else html += "<option value=" + i + j + ">" + i + "년" + j + "월" + "</option>";
            }
        }else{
            for(var j=12; j>0; j--) {
                if(j < 10) j = "0"+j;
                if (i == val) html += "<option value=" + i + j + " selected>" + i + "년" + j + "월" + "</option>";
                else html += "<option value=" + i + j + ">" + i + "년" + j + "월" + "</option>";
            }
        }
    }
   innerHTML(tagId, html);
}

function getSmsSearchSelectbox(tagId) {
    var html = "<select id='searchType' class='form-control'>";
    html += "<option value=''>선택</option>";
    html += "<option value='name'>이름</option>";
    html += "<option value='id'>아이디</option>";
    html += "<option value='phone'>휴대전화번호</option>";
    html += "<option value='content'>내용</option>";
    html += "</select>";
    innerHTML(tagId, html);
}
