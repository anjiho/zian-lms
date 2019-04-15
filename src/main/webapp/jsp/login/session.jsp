<%@ page import="com.zianedu.lms.utils.CreateSESSION" %>
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
		TUserVO tUserVO = CreateSESSION.createSession(request);
		System.out.println(" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  " + tUserVO.toString());
        session.setAttribute("user_info", tUserVO);
        session.setMaxInactiveInterval(60*60);
	}catch (Exception e) {
		System.out.println("SESSION CREATE ERROR.....");
		e.printStackTrace();
	}

%>
<script type="text/javascript">
	var page_gbn = "<%=page_gbn%>";
	function init() {
		with(document.frm) {
			action = "/dashboard";
			page_gbn.value = "dashboard";
			submit();
		}
	}
</script>
<body onload="init();">
<form name="frm" method="get">
	<input type="hidden" name="page_gbn">
</form>
</body>