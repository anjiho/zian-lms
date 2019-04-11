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