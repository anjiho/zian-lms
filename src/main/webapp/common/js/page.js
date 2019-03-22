
function getContextPath() {
	 var offset=location.href.indexOf(location.host)+location.host.length;
	var ctxPath=location.href.substring(offset,location.href.indexOf('/',offset+1));
	return ctxPath;
}

function goHome() {
	location.href= getContextPath();
}

function goLogout() {
	if (confirm("로그아웃 하시겠습니까?")) {
		with(document.frm) {
			page_gbn.value = "logout";
			action = getContextPath()+"/login.do";
			submit();
		} 
	}
}

function goPage(mapping_value, page_value, obj) {
 	var data = $(obj).attr('data');
 	if (data == 1) {
        return false;
    } else {
        with (document.frm) {
            if (mapping_value != "" && page_value != "") {
                page_gbn.value = page_value;
            }
            action = getContextPath() + "/" + mapping_value + ".do";
            submit();
        }
    }
	// with(document.frm) {
	// 	if (mapping_value != "" && page_value != "") {
	// 		page_gbn.value = page_value;
	// 	}
	// 	action = getContextPath()+"/"+mapping_value+".do";
	// 	submit();
	// }
}

function lecture_go(val) {
    if(val=="price"){
        goPage('lecture','lecture_price');
    }else if(val=="room"){
        goPage('lecture','lecture_room');
    }else if(val=="lecture_list"){
        goPage('lecture','lecture_list');
	}
}

function prepare() {
	alert("기능준비중입니다.");
	return;
}
