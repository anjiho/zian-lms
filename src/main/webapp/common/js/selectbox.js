function getSubDomainList (tag_id, val) {
    selectboxService.getSubDomainList(function (list) {
        console.log(list);
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
