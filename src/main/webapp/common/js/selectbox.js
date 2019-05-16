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

//모의고사상품 리스트 셀렉트박스
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
    for(var j=100; i<103; i++){
        if (i == val) {
            html += "<option value="+i+" selected>"+ i +"개월</option>";
        } else {
            html += "<option value="+i+">"+ i +"개월</option>";
        }
    }
    html += "<option value='100' selected>VOD</option>";
    html += "<option value='101' selected>MOBILE</option>";
    html += "<option value='102' selected>VOD + MOBILE</option>";
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
        var html = "<select id='sel_1' onchange='' class=\"col-sm-3 select2 form-control custom-select\">";
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
        var html = "<select idㄷ='divisionCtgKey' name='divisionCtgKey' onchange='' class=\"col-sm-5 select2 form-control custom-select\">";
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
    for (var i=1; i<13; i++) {
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