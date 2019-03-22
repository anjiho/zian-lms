/* MonthPicker 옵션 */
var year = getYear();
var month = getMonth();

options = {
    pattern: 'yyyy-mm', // Default is 'mm/yyyy' and separator char is not mandatory
    selectedMonth : month,
    selectedYear: year,
    startYear: year - 2,
    finalYear: year + 5,
    monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
};

/* MonthPicker Set */
$('#monthpicker').monthpicker(options);

/* 버튼 클릭시 MonthPicker Show */
$('#btn_monthpicker').bind('click', function () {
    $('#monthpicker').monthpicker('show');
});

/* MonthPicker 선택 이벤트 */
$('#monthpicker').monthpicker().bind('monthpicker-click-month', function (e, month) {
    //alert("선택하신 월은 : " + month + "월");
});