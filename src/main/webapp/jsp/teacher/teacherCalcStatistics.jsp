<%--
  Created by IntelliJ IDEA.
  User: jihoan
  Date: 2019-04-26
  Time: 09:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/statisManageService.js'></script>
<!-- 차트 관련 스크립트 -->
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/series-label.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>

<script>
    function init() {
        menuActive('menu-8', 3);

        getExamYearSelectbox("l_year");
        getMonthsSelectbox("l_month");
    }

    function chartInit() {
        var searchType = getSelectboxValue("searchType");
        if (searchType == "month") {

            var year = getSelectboxValue("selYear");

            if (year == "") {
                alert("년도를 선택하세요.");
                focus("searchType");
                return;
            }

            gfn_display("container", true);
            gfn_display("container2", false);
            gfn_display("container3", false);

            statisManageService.getTeacherStatisGraphByMonth(year, function(result) {
                var userCounts = result.userCounts;

                Highcharts.chart('container', {
                    chart: {
                        type: 'line'
                    },
                    title: {
                        text: '월간 회원가입 통계' + '(' + year + ')'
                    },
                    // subtitle: {
                    //     text: 'Source: WorldClimate.com'
                    // },
                    xAxis: {
                        categories: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
                    },
                    yAxis: {
                        title: {
                            text: '명'
                        }
                    },
                    plotOptions: {
                        line: {
                            dataLabels: {
                                enabled: true
                            },
                            enableMouseTracking: false
                        }
                    },
                    credits: {
                        enabled: false
                    },
                    series: [{
                        name: '회원',
                        data: userCounts
                    }]
                });
            });
        } else if (searchType == "year") {
            gfn_display("container", false);
            gfn_display("container2", true);
            gfn_display("container3", false);

            statisManageService.getTeacherStatisGraphByYear(function(result) {
                var yearList = result.years;
                var userCounts = result.userCounts;


                Highcharts.chart('container2', {

                    title: {
                        text: '년간 회원가입 통계'
                    },

                    // subtitle: {
                    //     text: 'Source: thesolarfoundation.com'
                    // },

                    yAxis: {
                        title: {
                            text: '명'
                        }
                    },
                    legend: {
                        layout: 'vertical',
                        align: 'right',
                        verticalAlign: 'middle'
                    },
                    credits: {
                        enabled: false
                    },
                    plotOptions: {
                        series: {
                            label: {
                                connectorAllowed: false
                            },
                            pointStart: Number(yearList[0])
                        }
                    },

                    series: [{
                        name: '회원',
                        data: userCounts
                    }],

                    responsive: {
                        rules: [{
                            condition: {
                                maxWidth: 500
                            },
                            chartOptions: {
                                legend: {
                                    layout: 'horizontal',
                                    align: 'center',
                                    verticalAlign: 'bottom'
                                }
                            }
                        }]
                    }
                });
            });
        } else if (searchType == "day") {
            gfn_display("container", false);
            gfn_display("container2", false);
            gfn_display("container3", true);

            var year = getSelectboxValue("selYear");
            var month = getSelectboxValue("selMonth");

            if (year == "") {
                alert("년도를 선택하세요.");
                focus("selYear");
                return;
            }
            if (month == "") {
                alert("월을 선택하세요.");
                focus("selMonth");
                return;
            }

            var yyyyMM = makeYYYY_MM(year, month);

            statisManageService.getTeacherStatisGraphByDay(yyyyMM, function(result) {

                var userCounts = result.userCounts;

                Highcharts.chart('container3', {

                    title: {
                        text: '일별 회원가입 통계' + '(' + yyyyMM + ')'
                    },

                    // subtitle: {
                    //     text: 'Source: thesolarfoundation.com'
                    // },

                    yAxis: {
                        title: {
                            text: '명'
                        }
                    },
                    legend: {
                        layout: 'vertical',
                        align: 'right',
                        verticalAlign: 'middle'
                    },
                    credits: {
                        enabled: false
                    },

                    plotOptions: {
                        series: {
                            label: {
                                connectorAllowed: false
                            },
                            pointStart: 1
                        }
                    },

                    series: [{
                        name: '회원',
                        data: userCounts
                    }],

                    responsive: {
                        rules: [{
                            condition: {
                                maxWidth: 500
                            },
                            chartOptions: {
                                legend: {
                                    layout: 'horizontal',
                                    align: 'center',
                                    verticalAlign: 'bottom'
                                }
                            }
                        }]
                    }
                });
            });
        }
    }
    function changeStaticsType(val) {
        if (val != undefined) {
            if (val == "month") {
                gfn_display("l_year", true);
                gfn_display("l_month", false);
            } else if (val == "year") {
                gfn_display("l_year", false);
                gfn_display("l_month", false);
            } else if (val == "day") {
                gfn_display("l_year", true);
                gfn_display("l_month", true);
            }
        }
    }
</script>
<!-- 우측상단  -->
<div class="page-breadcrumb">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">매출 그래프</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">교수</li>
                        <li class="breadcrumb-item active" aria-current="page">매출 그래프</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</div>

<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <div style="float: left;">
                        <select id="searchType" class="form-control" onchange="changeStaticsType(this.value)">
                            <option value="year">년도별</option>
                            <option value="month">월별</option>
                            <option value="day">일별</option>
                        </select>
                    </div>
                    <div style="float: left;">
                        <span id="l_year" style="display: none"></span>
                    </div>
                    <div style="float: left;">
                        <span id="l_month" style="display: none"></span>
                    </div>
                    <div style=" float: left; width: 33%; margin-left: 10px">
                        <button type="button" class="btn btn-outline-info mx-auto" onclick="chartInit();">검색</button>
                    </div>
                </div>
                <div class="card-body">
                    <div id="container" style="min-width: 310px; height: 400px; margin: 0 auto; display: none"></div>
                    <div id="container2" style="min-width: 310px; max-width: 800px; height: 400px; margin: 0 auto; display: none"></div>
                    <div id="container3" style="min-width: 310px; height: 400px; margin: 0 auto; display: none"></div>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="/common/jsp/footer.jsp" %>

