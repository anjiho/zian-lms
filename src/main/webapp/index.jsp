<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%
    response.setCharacterEncoding("UTF-8");
    response.setContentType("text/html;charset=UTF-8");
    int httpStatusCode = response.getStatus();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta http-equiv="content-Type" content="text/html;charset=utf-8">
    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Favicon icon -->

    <link rel="icon" type="image/png" sizes="16x16" href="img/logo.png">
    <title>지안에듀관리자</title>
    <!-- Custom CSS -->
    <link href="common/dist/css/style.min.css" rel="stylesheet">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <!-- 공통 함수 JS -->
    <script src="common/js/common.js"></script>
    <script src="common/js/comPage.js"></script>

    <script type='text/javascript' src='/dwr/engine.js'></script>
    <script type='text/javascript' src='/dwr/util.js'></script>
    <script type='text/javascript' src='/dwr/interface/loginService.js'></script>
</head>
<script>
    var httpCode = '<%=httpStatusCode%>';

    function loginCheck() {
        var URL = null;
        if (httpCode == '901') {
            URL = window.location.pathname ;
            var data = getSearchParams();
            var i = 0;
            $.each(data, function(key, value){
                var spl = "?";
                if (i >= 1) {
                    spl = "&";
                }
                URL += spl + key + "=" + value;
                ++i;
            });
        }
        var userId = getInputTextValue("userId");
        var userPass = getInputTextValue("userPass");

        loginService.login(userId, userPass, function(data) {
            alert(data.teacherKey);
            if (data != null) {
                with(document.frm) {
                    innerValue("userKey", data.userKey);
                    innerValue("authority", data.adminAuthorityKey);
                    innerValue("userName", data.name);
                    innerValue("teacherKey", data.teacherKey)
                    innerValue("targetUrl", gfn_isnullvalue(URL, ""));
                    goPage("login", "session");
                }
            } else {
                alert("아이디 또는 비밀번호가 틀렸습니다.");
            }
        });
    }

    function getSearchParams(k){
        var p={};
        location.search.replace(/[?&]+([^=&]+)=([^&]*)/gi,function(s,k,v){p[k]=v})
        return k?p[k]:p;
    }
</script>
<body>
<div class="main-wrapper">
    <div class="preloader">
        <div class="lds-ripple">
            <div class="lds-pos"></div>
            <div class="lds-pos"></div>
        </div>
    </div>
    <div class="auth-wrapper d-flex no-block justify-content-center align-items-center bg-dark">
        <div class="auth-box bg-dark border-top border-secondary">
            <div id="loginform">
                <div class="text-center" style="margin-bottom: 20px;">
                    <span style="font-size:20px;color: white;">지안에듀 관리자</span>
                </div>

                <form class="form-horizontal m-t-20" name="frm">

                    <input type="hidden" id="page_bgn" name="page_gbn">
                    <input type="hidden" id="userKey" name="userKey">
                    <input type="hidden" id="userName" name="userName">
                    <input type="hidden" id="authority" name="authority">
                    <input type="hidden" id="targetUrl" name="targetUrl">
                    <input type="hidden" id="teacherKey" name="teacherKey">

                    <div class="row p-b-30" style="margin-bottom: 20px;">
                        <div class="col-12">
                            <div class="input-group mb-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text bg-success text-white" id="basic-addon1"><i class="ti-user"></i></span>
                                </div>
                                <input type="text" id="userId" class="form-control form-control-lg" placeholder="아이디" aria-label="Username" aria-describedby="basic-addon1" required="">
                            </div>
                            <div class="input-group mb-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text bg-warning text-white" id="basic-addon2"><i class="ti-pencil"></i></span>
                                </div>
                                <input type="password" id="userPass" class="form-control form-control-lg" placeholder="비밀번호" aria-label="Password" aria-describedby="basic-addon1" required="" onkeypress="if(event.keyCode==13) {loginCheck(); return false;}">
                            </div>
                        </div>
                    </div>
                    <div class="row border-top border-secondary">
                        <div class="col-12">
                            <div class="form-group">
                                <div style="margin-bottom: 10px;"><!--onkeypress="if(event.keyCode==13) {fn_search('new'); return false;}-->
                                    <input type="button" class="btn btn-success float-right" style="width:100%" onclick="loginCheck();" value="로그인" >
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script src="common/assets/libs/jquery/dist/jquery.min.js"></script>
<script src="common/assets/libs/popper.js/dist/umd/popper.min.js"></script>
<script src="common/assets/libs/bootstrap/dist/js/bootstrap.min.js"></script>
<script>

    $('[data-toggle="tooltip"]').tooltip();
    $(".preloader").fadeOut();
    // ==============================================================
    // Login and Recover Password
    // ==============================================================
    $('#to-recover').on("click", function() {
        $("#loginform").slideUp();
        $("#recoverform").fadeIn();
    });
    $('#to-login').click(function(){

        $("#recoverform").hide();
        $("#loginform").fadeIn();
    });

</script>
</body>

</html>
