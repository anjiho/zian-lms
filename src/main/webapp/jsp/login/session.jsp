<%--
  Created by IntelliJ IDEA.
  User: jihoan
  Date: 2019-04-03
  Time: 10:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.zianedu.lms.utils.CreateSESSION" %>
<%@ page import="com.zianedu.lms.service.LoginService" %>
<%@ page import="com.zianedu.lms.vo.TUserVO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
    if (request.getProtocol().equals("HTTP/1.1"))
        response.setHeader("Cache-Control", "no-cache");

    String webRoot = request.getContextPath();

    String targetUrl = request.getParameter("target_url");

    String page_gbn = "";

    try {
        String userKey = request.getParameter("userKey");
        TUserVO tUserVO = CreateSESSION.createSession(request);
//        FlowEduMemberDto dto = CreateSESSION.sessionCF(request);
//        session.setAttribute("member_info", dto);
//        session.setMaxInactiveInterval(60*60);
    }catch (Exception e) {
        System.out.println("SESSION CREATE ERROR.....");
        e.printStackTrace();
    }


%>
<script type="text/javascript">
    var page_gbn = "<%=page_gbn%>";
    function init() {
        var url = '<%=targetUrl%>';
        if (url != "") {
            location.replace(url);
        } else {
            with(document.frm) {
                action = "<%=webRoot%>/dashboard.do";
                page_gbn.value = "dashboard_list";
                submit();
            }
        }
    }
</script>
<body onload="init();">
<form name="frm" method="get">
    <input type="hidden" name="page_gbn">
</form>
</body>
