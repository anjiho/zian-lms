
function goPage(mapping_value, page_value, obj) {
    var data = $(obj).attr('data');
    if (data == 1) {
        return false;
    } else {
        with (document.frm) {
            if (mapping_value != "" && page_value != "") {
                page_gbn.value = page_value;
            }
            action = "/" + mapping_value + "/" + page_value;
            submit();
        }
    }
}
