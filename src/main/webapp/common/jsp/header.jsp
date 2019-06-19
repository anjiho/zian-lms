<%--
  Created by IntelliJ IDEA.
  User: won
  Date: 2019-04-03
  Time: 오전 10:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<div class="preloader">
    <div class="lds-ripple">
        <div class="lds-pos"></div>
        <div class="lds-pos"></div>
    </div>
</div>
<div id="main-wrapper">
    <header class="topbar" data-navbarbg="skin5">
        <nav class="navbar top-navbar navbar-expand-md navbar-dark">
            <div class="navbar-header" data-logobg="skin5">
                <a class="nav-toggler waves-effect waves-light d-block d-md-none" href="javascript:void(0)"><i class="ti-menu ti-close"></i></a>
                <a class="navbar-brand" href="javascript:void(0)" attr-a="onclick: attr-a">
                    <img src="img/logo.png" alt="user" class="rounded-circle" width="31">
                    <span class="logo-text">
                        지안에듀
                    </span>
                </a>
            </div>
            <div class="navbar-collapse collapse" id="navbarSupportedContent" data-navbarbg="skin5">
                <ul class="navbar-nav float-left mr-auto"></ul>
                <ul class="navbar-nav float-right">
                    <li class="nav-item">
                        <span class=" nav-link text-muted waves-effect waves-dark pro-pic"><%=name%></span>
                        <button type="button" class="btn btn-outline-secondary" onclick="goPage('login', 'logout')"><i class="fa fa-power-off m-r-5 m-l-5"></i>  로그아웃</button>
                        <button type="button" class="btn btn-outline-warning">사이트이동</button>
                    </li>
                </ul>
            </div>
        </nav>
    </header>