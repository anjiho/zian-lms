/**
 * require : <script src="paging-count-check.js"></script>
 * DWR 페이징 개수 체크 후 공통 로직
 * sPage : 현재 페이지 넘버(초기 값)
 * cnt : 메서드에서 가져온 데이터 개수
 * list_count : 리스트 개수
 * empty_comment : 개수가 없을때 보여질 멘트
 */
var Paging = function() {
	this.count = function(sPage, cnt, paging_count, list_count, empty_comment) {
		if (cnt == "0") {
			gfn_printPageNum_new('0', paging_count, list_count, '1');
			gfn_emptyView("V", empty_comment);
		}  else {
			if (new Number(cnt) < (list_count * sPage)) {
				if (new Number(cnt) < (list_count * (sPage - 1))) {
					sPage = 1;
					innerValue("sPage", sPage);
				}
			}
			gfn_printPageNum_new(cnt, paging_count, list_count, sPage);
		}
	};
	
	this.count2 = function(sPage, cnt, paging_count, list_count, empty_comment) {
		if (cnt == "0") {
			gfn_printPageNum_new2('0', paging_count, list_count, '1');
			gfn_emptyView2("V", empty_comment);
		}  else {
			if (new Number(cnt) < (list_count * sPage)) {
				if (new Number(cnt) < (list_count * (sPage - 1))) {
					sPage = 1;
					innerValue("sPage2", sPage);
				}
			}
			gfn_printPageNum_new2(cnt, paging_count, list_count, sPage);
		}
	};
	
	this.count3 = function(sPage, cnt, paging_count, list_count, empty_comment) {
		if (cnt == "0") {
			gfn_printPageNum_new3('0', paging_count, list_count, '1');
			gfn_emptyView3("V", empty_comment);
		}  else {
			if (new Number(cnt) < (list_count * sPage)) {
				if (new Number(cnt) < (list_count * (sPage - 1))) {
					sPage = 1;
					innerValue("sPage3", sPage);
				}
			}
			gfn_printPageNum_new3(cnt, paging_count, list_count, sPage);
		}
	};
	
	this.count4 = function(sPage, cnt, paging_count, list_count, empty_comment) {
		if (cnt == "0") {
			gfn_printPageNum_new4('0', paging_count, list_count, '1');
			gfn_emptyView4("V", empty_comment);
		}  else {
			if (new Number(cnt) < (list_count * sPage)) {
				if (new Number(cnt) < (list_count * (sPage - 1))) {
					sPage = 1;
					innerValue("sPage4", sPage);
				}
			}
			gfn_printPageNum_new4(cnt, paging_count, list_count, sPage);
		}
	};
	
}