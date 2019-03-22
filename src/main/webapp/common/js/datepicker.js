$(function() {
	$("#startDate").datepicker({
		dateFormat: 'yy-mm-dd',
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	    dayNamesMin: ['일','월','화','수','목','금','토'],
		changeMonth: true, //월변경가능
	    changeYear: true, //년변경가능
		showMonthAfterYear: true, //년 뒤에 월 표시
        yearRange: 'c-99:c+99',
	});
});
$(function() {
    $("#registerDate").datepicker({
        dateFormat: 'yy-mm-dd',
        monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
        dayNamesMin: ['일','월','화','수','목','금','토'],
        changeMonth: true, //월변경가능
        changeYear: true, //년변경가능
        showMonthAfterYear: true, //년 뒤에 월 표시
        yearRange: 'c-99:c+99',
    });
});
$(function() {
	$("#endDate").datepicker({
		dateFormat: 'yy-mm-dd',
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	    dayNamesMin: ['일','월','화','수','목','금','토'],
		changeMonth: true, //월변경가능
	    changeYear: true, //년변경가능
		showMonthAfterYear: true, //년 뒤에 월 표시
	});
});

$(function() {
	$("#searchDate").datepicker({
		dateFormat: 'yy-mm-dd',
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	    dayNamesMin: ['일','월','화','수','목','금','토'],
		changeMonth: true, //월변경가능
	    changeYear: true, //년변경가능
		showMonthAfterYear: true, //년 뒤에 월 표시
	});
});

$(function() {
	$("#startDate2").datepicker({
		dateFormat: 'yy-mm-dd',
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	    dayNamesMin: ['일','월','화','수','목','금','토'],
		changeMonth: true, //월변경가능
	    changeYear: true, //년변경가능
		showMonthAfterYear: true, //년 뒤에 월 표시
	});
});

$(function() {
	$("#startSearchDate").datepicker({
		dateFormat: 'yy-mm-dd',
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	    dayNamesMin: ['일','월','화','수','목','금','토'],
		changeMonth: true, //월변경가능
	    changeYear: true, //년변경가능
		showMonthAfterYear: true, //년 뒤에 월 표시
	});
});

$(function() {
	$("#endSearchDate").datepicker({
		dateFormat: 'yy-mm-dd',
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	    dayNamesMin: ['일','월','화','수','목','금','토'],
		changeMonth: true, //월변경가능
	    changeYear: true, //년변경가능
		showMonthAfterYear: true, //년 뒤에 월 표시
	});
});

$(function() {
	$("#startSearchDate2").datepicker({
		dateFormat: 'yy-mm-dd',
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	    dayNamesMin: ['일','월','화','수','목','금','토'],
		changeMonth: true, //월변경가능
	    changeYear: true, //년변경가능
		showMonthAfterYear: true, //년 뒤에 월 표시
	});
});

$(function() {
	$("#endSearchDate2").datepicker({
		dateFormat: 'yy-mm-dd',
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	    dayNamesMin: ['일','월','화','수','목','금','토'],
		changeMonth: true, //월변경가능
	    changeYear: true, //년변경가능
		showMonthAfterYear: true, //년 뒤에 월 표시
	});
});

$(function() {
	$("#start_time_1").timepicker({
		hourText: '시',
		minuteText: '분'
	});
	$.timepicker.setDefaults($.timepicker.regional['ko']);
});

$(function() {
    $("#end_time").timepicker({
        hourText: '시',
        minuteText: '분'
    });
    $.timepicker.setDefaults($.timepicker.regional['ko']);
});

$(function() {
    $("#firstTime_1").timepicker({
        hourText: '시',
        minuteText: '분'
    });
    $.timepicker.setDefaults($.timepicker.regional['ko']);
});

$(function () {
    $("#datepicker_img").bind("click", function () {
        var options = {
            dateFormat: 'yy-mm-dd',
            monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
            dayNamesMin: ['일','월','화','수','목','금','토'],
            changeMonth: true, //월변경가능
            changeYear: true, //년변경가능
            showMonthAfterYear: true, //년 뒤에 월 표시
        };

        $('#startDate').datepicker(options);

        $('#startDate').datepicker().bind('monthpicker-change-year', function (e, year) {
            $('#startDate').datepicker('disableMonths', []); // (re)enables all
            if (year === '2008') {
                $('#startDate').datepicker('disableMonths', [1, 2, 3, 4]);
            }
            if (year === '2010') {
                $('#startDate').datepicker('disableMonths', [9, 10, 11, 12]);
            }
        });
        $("#startDate").datepicker("show");
    });
});

$(function () {
    $("#datepicker_img2").bind("click", function () {
        var options = {
            dateFormat: 'yy-mm-dd',
            monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
            dayNamesMin: ['일','월','화','수','목','금','토'],
            changeMonth: true, //월변경가능
            changeYear: true, //년변경가능
            showMonthAfterYear: true, //년 뒤에 월 표시
        };

        $('#endDate').datepicker(options);

        $('#endDate').datepicker().bind('monthpicker-change-year', function (e, year) {
            $('#endDate').datepicker('disableMonths', []); // (re)enables all
            if (year === '2008') {
                $('#endDate').datepicker('disableMonths', [1, 2, 3, 4]);
            }
            if (year === '2010') {
                $('#endDate').datepicker('disableMonths', [9, 10, 11, 12]);
            }
        });
        $("#endDate").datepicker("show");
    });
});

$(function() {
    $("#birthDay").datepicker({
        dateFormat: 'yy-mm-dd',
        monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
        dayNamesMin: ['일','월','화','수','목','금','토'],
        changeMonth: true, //월변경가능
        changeYear: true, //년변경가능
        showMonthAfterYear: true, //년 뒤에 월 표시
    });
    $("#sexualAssultDay").datepicker({
        dateFormat: 'yy-mm-dd',
        monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
        dayNamesMin: ['일','월','화','수','목','금','토'],
        changeMonth: true, //월변경가능
        changeYear: true, //년변경가능
        showMonthAfterYear: true, //년 뒤에 월 표시
    });
    $("#educationRegDay").datepicker({
        dateFormat: 'yy-mm-dd',
        monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
        dayNamesMin: ['일','월','화','수','목','금','토'],
        changeMonth: true, //월변경가능
        changeYear: true, //년변경가능
        showMonthAfterYear: true, //년 뒤에 월 표시
    });
});
