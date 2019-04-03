<%@include file="/common/jsp/common.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script type='text/javascript' src='/dwr/interface/loginService.js'></script>
    아이디 : <input type="text" id="userId">
    비밀번호 : <input type="password" id="userPass">
    <input type="button" value="로그인" onclick="loginCheck();">

</form>
</body>
</html>
<script>
    function loginCheck() {
        var userId = getInputTextValue("userId");
        var userPass = getInputTextValue("userPass");

        loginService.login(userId, userPass, function(data) {
            /*if (data.flowMemberId != null ) {
                loginOk(data, URL);
            } else {
                alert(comment.blank_login_check);
                return;
            }*/
            alert(data);
        });
    }
</script>

