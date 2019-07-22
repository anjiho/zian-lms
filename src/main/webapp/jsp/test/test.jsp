<%--
  Created by IntelliJ IDEA.
  User: jihoan
  Date: 2019-04-26
  Time: 09:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/statisManageService.js'></script>
<!-- 차트 관련 스크립트 -->
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/series-label.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>

<script>

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
                        <span id="l_teacherList"></span>
                    </div>
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

