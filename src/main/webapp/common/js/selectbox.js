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

//카테고리
function getCategoryList(tag_id, val) {
    selectboxService.getCategoryList(val, function (list) {
        var html = "<select id='sel_1' onchange='' class='form-control'>";
            html += "<option value=''>선택하세요</option>";
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
        var html = "<select id='sel_1' onchange='' class='form-control'>";
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

//급수,과목,유형
function getNewSelectboxListForCtgKey(tag_id, val, val2) {
    selectboxService.getSelectboxListForCtgKey(val, function (list) {
        var html = "<select id='selClassGroupCtgKey' name='classGroupCtgKey' class=\"col-sm-3 select2 form-control custom-select\">";
        html += "<option value='' selected>선택하세요</option>";
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
        html += "<option value='' selected>선택하세요</option>";
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
        html += "<option value='' selected>선택하세요</option>";
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
        html += "<option value='' selected>선택</option>";
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
        var html = "<select id='sel_emphasis' class='col-sm-3 select2 form-control custom-select'>";
        html += "<option value='' selected>선택하세요</option>";
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

function getOptionSelectbox(val) {
    var html = "<select id='sel_option' name='selOption[]' class='col-sm-7 select2 form-control custom-select'>";
    html += "<option value=''>선택하세요</option>";
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

function getCategoryNoTag(tableId, val, tdNum) {
    var nextTdNum = Number(tdNum)+2;
    var html = "<select id='sel_category' name='selCategory[]' onchange='changeCategory(this.value"+ ","+ '"' + tableId + '"' + ","+ '"' + nextTdNum + '"' + ");' class='form-control'>";
    html += "<option value=''>선택하세요</option>";
    selectboxService.getCategoryList(val, function (list) {
        for (var i=0; i<list.length; i++) {
            html += "<option value="+list[i].ctgKey+">"+ list[i].name +"</option>";
        }
        html += "</select>";
        $("#"+ tableId).find("tbody").find("tr:last").find("td").eq(tdNum).html(html);
        $("#"+ tableId).find("tbody").find("tr:last").find("td input").eq(0).val(val);
    });
}

function defaultCategorySelectbox() {
    var html = "<select id='sel_category' name='selCategory[]' onchange='' class='form-control'>";
    html += "<option value=''>선택하세요</option>";
    html += "</select>";
    return html;
}


function getSelectboxListForCtgKeyNoTag(tableId, val, tdNum) {
    selectboxService.getSelectboxListForCtgKey(val, function (list) {
        var html = "<select id='selSubjectKey' name='selSubjectByTeacher[]' onchange='' class='form-control'>";
        html += "<option value='' selected>선택하세요</option>";
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

function selectTeacherSelectboxNoTag(tableId, tdNum) {
    selectboxService.selectTeacherSelectbox(function (list) {
        var html = "<select id='selTeacherKey' name='selTeacher[]' class='form-control'>";
        html += "<option value='' selected>선택</option>";
        for (var i=0; i<list.length; i++) {
            html += "<option value="+list[i].teacherKey+">"+ list[i].teacherName +"</option>";
        }
        html += "</select>";
        $("#"+ tableId).find("tbody").find("tr:last").find("td").eq(tdNum).html(html);
    });
}
