/**
 * 값 공백 체크 클래스
 * @example
 * <pre>
 * var check = new isCheck();
 * if (check.input(val1, val2) == false) return;
 * if (check.selectbox(val1, val2) == false) return;
 * if (check.value(val1, val2) == false) return;
 * if (check.value_compare_row_check(val1, val2, val3) == false) return;
 * </pre>
 */
var isCheck = function() {
	//input type=text 공백 체크
	this.input = function(tagId, alertContent) {
		if ($("#"+tagId).val() == "") {
			alert(alertContent, tagId);
			focusInputText(tagId);
			return false;
		} 
	};
	//input type=select 공백 체크
	this.selectbox = function(tagId, alertContent) {
		if ($("#"+tagId+" option:selected").val() == "") {
			alert(alertContent, tagId);
			focusInputText(tagId);
			return false;
		}
	};
	// 입력받은 변수의 공백 체크
	this.value = function(val, alertContent) {
		if (val == "" || val == undefined) {
			alert(alertContent);
			return false;
		}
	}; 
	//값 비교 체크
	this.compare = function(compareVal1, compareVal2, alertContent) {
		if (Number(compareVal1) < Number(compareVal2)) {
			alert(alertContent);
			return false;
		}
	};
}

function value_compare_row_check(val, compare_val, alert_content) {
	if (val < compare_val) {
		alert(alert_content);
		return false;
	}
}
/**
 * 값 공백 체크
 * @param val
 * @param alert_content
 * @returns {Boolean}
 */
function value_blank_check(val, alert_content) {
	if (val == "") {
		alert(alert_content);
		return false;
	}
}
/**
 * 입력 공백 체크
 * @param input_id
 * @param alert_content
 * @returns {Boolean}
 */
function input_blank_check(input_id, alert_content) {
	if ($("#"+input_id).val() == "") {
		alert(alert_content);
		$("#"+input_id).focus();
		return false;
	} 
}

/**
 * 셀렉트 박스 선택 체크 
 * @param selectbox_id
 * @param alert_content
 * @returns {Boolean}
 */
function selectbox_blank_check(selectbox_id, alert_content) {
	if ($("#"+selectbox_id+" option:selected").val() == "") {
		jAlert(alert_content, selectbox_id);
		//$("#"+selectbox_id).focus();
		return false;
	}
}