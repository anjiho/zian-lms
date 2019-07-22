<%--
  Created by IntelliJ IDEA.
  User: jihoan
  Date: 2019-04-26
  Time: 09:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script src="common/assets/libs/jquery/dist/jquery.min.js"></script>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/userService.js'></script>
<!-- 차트 관련 스크립트 -->
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/series-label.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script>
    function gogo() {
        var content = $("content").val();
        if(content == ""){
            alert("입력ㄱㄱ");
            return;
        }
        userService.jiho(content, function () {
            alert("ok");
        });
    }

    function gogo1() {
        var content = $("content1").val();
        if(content == ""){
            alert("입력ㄱㄱ");
            return;
        }
        userService.eunjeong(content, function () {
            alert("");
        });
    }
</script>
<div class="container-fluid">
    <div style="width: 50%;margin-bottom: 30px;">
        <div style="margin-bottom: 10px;">
            <span>안지호</span>
            <button onclick="gogo();">전송</button>
        </div>
        <div>
            <textarea style="width: 100%;height: 200px;" placeholder="내용을 입력해 주세요." id="content"></textarea>
        </div>
    </div>
    <div style="width: 50%;">
        <div style="margin-bottom: 10px;">
            <span>원은정</span>
            <button onclick="gogo1();">전송</button>
        </div>
        <div>
            <textarea style="width: 100%;height: 200px;" placeholder="내용을 입력해 주세요." id="content1"></textarea>
        </div>
    </div>
</div>
<%@include file="/common/jsp/footer.jsp" %>

