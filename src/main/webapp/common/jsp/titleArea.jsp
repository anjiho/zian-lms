<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type='text/javascript' src='<%=webRoot%>/dwr/interface/studentService.js'></script>
<section class="top_area clear">
    <div class="gnb">
        <div class="total_search">
            <%--<button class="fa fa-search"></button>--%>
        </div>
        <%--<div class="menu_bar">--%>
            <%--<span></span>--%>
            <%--<span></span>--%>
            <%--<span></span>--%>
        <%--</div>--%>
        <span id="l_office"></span>
        <div class="my_box">
            <%--<a href="javascript:void(0);" onclick="goPage('member','login_member_modify')"></a>--%>
            <button id="my_menu_btn"><%=memberName%>님 안녕하세요. <span class="caret"></span></button>
            <ul class="my_menu" style="display: none;">
                <li><a href="javascript:void(0);" onclick="goPage('member','login_member_modify')"><span class="fa fa-cog"></span> 비밀번호 변경</a></li>
                <li><a href="javascript:void(0);" onclick="javascript:goLogout();"><span class="fa fa-sign-out"></span> 로그아웃</a></li>
                <!--

                <li><a href="">메뉴2</a></li>
                <li><a href="">메뉴3</a></li>
                -->
            </ul>
        </div>
    </div>
    <div class="out_box">
<script>
    $(function(){
        $("#my_menu_btn").mouseover(function(){
            var menu = $(this).next('.my_menu');
            $(".my_menu").show();
        });

        $(".my_menu").mouseleave(function(){
            var menu = $(this).next('.my_menu');
            $(".my_menu").hide();
        });

        //반응형 메뉴 스크립트
        $('.top_area .gnb .menu_bar').click(function(){
            $('#header').animate({"left":"0px"},500);
        });

        $('#header .menu_close_btn').click(function(){
            $('#header').animate({"left":"-350px"},500);
        });

        var memberType = '<%=memberType%>';
        if (memberType == 'ADMIN' || memberType == "CS") {
            officeAllList("l_office", '<%=officeId%>');
        } else {
            memberOfficeList("l_office", '<%=officeId%>');
        }
    });

    // 상단 관 변경
    function change_ofiice(val) {
        var data = new FormData();
        data.append("office_id", val);

        $.ajax({
            url: "<%=webRoot%>/session/change.do",
            method: "POST",
            dataType: "JSON",
            data: data,
            cache: false,
            processData: false,
            contentType: false,
            success: function (response) {
            }, error: function (response) {
            }
        });
        isReloadPage(true);
    }
</script>
