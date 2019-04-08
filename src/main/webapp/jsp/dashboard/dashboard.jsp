<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
    <div class="page-breadcrumb">
        <div class="row">
            <div class="col-12 d-flex no-block align-items-center">
                <h4 class="page-title">Dashboard</h4>
                <div class="ml-auto text-right">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="#">Home</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Library</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>
    <div class="container-fluid">
    <div class="row">
        <div class="col-md-6 col-lg-2 col-xlg-3">
            <div class="card card-hover">
                <div class="box bg-info text-center">
                    <h1 class="font-light text-white"><i class="mdi mdi-relative-scale"></i></h1>
                    <h6 class="text-white">Buttons</h6>
                </div>
            </div>
        </div>
        <div class="col-md-6 col-lg-2 col-xlg-3">
            <div class="card card-hover">
                <div class="box bg-cyan text-center">
                    <h1 class="font-light text-white"><i class="mdi mdi-pencil"></i></h1>
                    <h6 class="text-white">Elements</h6>
                </div>
            </div>
        </div>
        <div class="col-md-6 col-lg-2 col-xlg-3">
            <div class="card card-hover">
                <div class="box bg-success text-center">
                    <h1 class="font-light text-white"><i class="mdi mdi-calendar-check"></i></h1>
                    <h6 class="text-white">Calnedar</h6>
                </div>
            </div>
        </div>
        <div class="col-md-6 col-lg-2 col-xlg-3">
            <div class="card card-hover">
                <div class="box bg-warning text-center">
                    <h1 class="font-light text-white"><i class="mdi mdi-alert"></i></h1>
                    <h6 class="text-white">Errors</h6>
                </div>
            </div>
        </div>
    </div>
    <!--end row cloumn-->
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Real Time Chart</h5>
                    <div id="real-time" style="height:400px;"></div>
                    <p>Time between updates:
                        <input id="updateInterval" type="text" value="" style="text-align: right; width:5em"> milliseconds
                    </p>
                </div>
            </div>
        </div>
    </div>
    <!-- ENd chart-1 -->
</div>
    <!--end container-fluid-->


<%@include file="/common/jsp/footer.jsp" %>