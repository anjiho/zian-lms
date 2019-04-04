<%--
  Created by IntelliJ IDEA.
  User: jihoan
  Date: 2019-04-03
  Time: 17:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.zianedu.lms.vo.TUserVO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    TUserVO tUserVO = (TUserVO) session.getAttribute("user_info");
    if (tUserVO != null) session.invalidate();
%>
<script>
    //setCookie('office_id', '', -1);
    location.href="/";
</script>
