/**
 * 강의 레벨 선택 라디오 박스
 * @param tag_id
 * @param val
 * @param on_click
 */
function lectureLevelRadio(tag_id, val, on_click) {
    lectureService.getLectureLevelList(function (list) {
        var html = "<div class='checkbox_t1'>";
    	var check = "";
        for (var i=0; i<list.length; i++) {
            if (list[i].levelCode == val) {
				check = "checked"
            } else {
				check = "";
            }
            html += "<label><input type='radio' name='lecture_level' value=" + list[i].levelCode + " onclick=" + "'" + on_click + "'" + check + "><span>" + list[i].levelName+ "</span></label>";;
        }
        html += "</div>";
        innerHTML(tag_id, html);
    });
}

/**
 * 메모 종류 선택 라디오 박스
 * @param tag_id
 * @param val
 * @param on_click
 */
function studentMemoTypeRadio(tag_id, val, on_click) {
    studentService.getStudentMemoTypeList(function (list) {
        var html = "<div class='checkbox_t1'>";
        var check = "";
        for (var i=0; i<list.length; i++) {
            list[i].memoCode == val ? check = "checked" : check = "";
            html += "<label><input type='radio' name='memo_type' value=" + list[i].memoCode + " onclick=" + "'" + on_click + "'" + check + "><span>" + list[i].memoName + "</span></label>";
        }
        html += "</div>";
        innerHTML(tag_id, html);
    });
}

/**
 * 성별선택 라디오
 * @param tag_id
 * @param gender
 * @param on_click
 */
function genderRadio(tag_id, gender, on_click) {
    var male_check = "";
    var female_check = "";

    if (gender == "MALE") male_check = "checked";
    else if (gender == "FEMALE") female_check = "checked";

    var radio = "<div class='checkbox_t1 black'>";
    radio += "<label><input type='radio' name='student_gender' value='MALE' onclick=" + "'" + on_click + "'" + male_check + "><span>남</span></label>";
    radio += "<label><input type='radio' name='student_gender' value='FEMALE' onclick=" + "'" + on_click + "'" + female_check + "><span>여</span></label></div>";

    innerHTML(tag_id, radio);
}