//배너관리 - 서브도메인 셀렉트박스
function getSubDomainList (tag_id, val) {
    selectboxService.getSubDomainList(function (list) {
        var html = "<select id='sel_subDomain' onchange='' class='form-control'>";
        for (var i=0; i<list.length; i++) {
            if (list[i].name == val) {
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
        for (var i=0; i<list.length; i++) {
            if (list[i].name == val) {
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
            if (list[i].name == val) {
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
        for (var i=0; i<list.length; i++) {
            if (list[i].name == val) {
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
        for (var i=0; i<list.length; i++) {
            if (list[i].name == val) {
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
        for (var i=0; i<list.length; i++) {
            if (list[i].name == val) {
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