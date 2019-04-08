<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%
    response.setCharacterEncoding("UTF-8");
    response.setContentType("text/html;charset=UTF-8");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta http-equiv="content-Type" content="text/html;charset=utf-8">
    <%--<meta http-equiv="X-UA-Compatible" content="IE=edge">--%>
    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="common/assets/images/favicon.png">
    <title>Matrix Template - The Ultimate Multipurpose admin template</title>
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

    function loginCheck() {
        var userId = getInputTextValue("userId");
        var userPass = getInputTextValue("userPass");

        loginService.login(userId, userPass, function(data) {
            //console.log(data);
            if (data != null) {
                with(document.frm) {
                    innerValue("userKey", data.userKey);
                    innerValue("authority", data.adminAuthorityKey);
                    innerValue("userName", data.name);
                    goPage("login", "session");
                }
            } else {
                alert("error");
            }
            /*if (data.flowMemberId != null ) {
                loginOk(data, URL);
            } else {
                alert(comment.blank_login_check);
                return;
            }*/
        });
    }

    function loginOk(val) {

        with(document.frm) {
            var authority = val.adminAuthorityKey;
            alert(authority);
            if (authority == 0) {
                //alert("1111");
                authority = 4;
            }
            // innerValue("userKey", jsonData.userKey);
            // innerValue("authority", authority);
            // innerValue("userName", jsonData.name);
            //goPage("login", "session");
        }
    }

    function isNumber(value) {
        return typeof value === 'number' && isFinite(value);
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
                <form class="form-horizontal m-t-20" name="frm">

                    <input type="hidden" id="page_bgn" name="page_gbn">
                    <input type="hidden" id="userKey" name="userKey">
                    <input type="hidden" id="userName" name="userName">
                    <input type="hidden" id="authority" name="authority">

                    <div class="row p-b-30">
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
                                <input type="password" id="userPass" class="form-control form-control-lg" placeholder="비밀번호" aria-label="Password" aria-describedby="basic-addon1" required="">
                            </div>
                        </div>
                    </div>
                    <div class="row border-top border-secondary">
                        <div class="col-12">
                            <div class="form-group">
                                <div class="p-t-20">
                                    <button class="btn btn-info" id="to-recover" type="button"><i class="fa fa-lock m-r-5"></i> Lost password?</button>
                                    <input type="button" class="btn btn-success float-right" onclick="loginCheck()" value="로그인">
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div id="recoverform">
                <div class="text-center">
                    <span class="text-white">Enter your e-mail address below and we will send you instructions how to recover a password.</span>
                </div>
                <div class="row m-t-20">
                    <!-- Form -->
                    <form class="col-12">
                        <!-- email -->
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <span class="input-group-text bg-danger text-white" id="basic-addon1"><i class="ti-email"></i></span>
                            </div>
                            <input type="text" class="form-control form-control-lg" placeholder="Email Address" aria-label="Username" aria-describedby="basic-addon1">
                        </div>
                        <!-- pwd -->
                        <div class="row m-t-20 p-t-20 border-top border-secondary">
                            <div class="col-12">
                                <a class="btn btn-success" href="#" id="to-login" name="action">Back To Login</a>
                                <button class="btn btn-info float-right" type="button" name="action">Recover</button>
                            </div>
                        </div>
                    </form>
                </div>
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
