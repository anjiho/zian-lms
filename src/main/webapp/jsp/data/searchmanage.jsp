<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/dataManageService.js'></script>
<!--순서-->
<div class="page-breadcrumb">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">시험일정 관리</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">데이터관리</li>
                        <li class="breadcrumb-item active" aria-current="page">일정/검색어관리</li>
                        <li class="breadcrumb-item active" aria-current="page">시험일정관리</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</div>
<!--//순서-->

<!-- 기본 소스-->
<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title" style="display:inline-block;vertical-align:middle;margin-bottom:-2px;">일정관리</h5>
                    <button type="button" style="vertical-align: middle;display:inline-block;float:right" class="btn btn-info btn-sm" data-toggle="modal" data-target="#sModal">추가</button>
                </div>
                <table class="table table-hover text-center">
                    <thead>
                    <tr>
                        <th scope="col" style="width: 5%;">CODE</th>
                        <th scope="col" style="width: 65%;">일정이름</th>
                        <th scope="col" style="width: 15%;">날짜</th>
                        <th scope="col" style="width: 15%;">관리</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <th scope="row">96</th>
                        <td class="text-left">2019 지방직9급</td>
                        <td>2019.06.15</td>
                        <td>
                            <button type="button" class="btn btn-outline-primary btn-sm">수정</button>
                            <button type="button" class="btn btn-outline-danger btn-sm">삭제</button>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">97</th>
                        <td class="text-left">2019 서울시9급</td>
                        <td>2019.06.15</td>
                        <td>
                            <button type="button" class="btn btn-outline-primary btn-sm">수정</button>
                            <button type="button" class="btn btn-outline-danger btn-sm">삭제</button>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">98</th>
                        <td class="text-left">2019 국가직7급</td>
                        <td>2019.08.17</td>
                        <td>
                            <button type="button" class="btn btn-outline-primary btn-sm">수정</button>
                            <button type="button" class="btn btn-outline-danger btn-sm">삭제</button>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">99</th>
                        <td class="text-left">2019 지방직7급</td>
                        <td>2019.10.12</td>
                        <td>
                            <button type="button" class="btn btn-outline-primary btn-sm">수정</button>
                            <button type="button" class="btn btn-outline-danger btn-sm">삭제</button>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">100</th>
                        <td class="text-left">2019 서울시7급</td>
                        <td>2019.10.12</td>
                        <td>
                            <button type="button" class="btn btn-outline-primary btn-sm">수정</button>
                            <button type="button" class="btn btn-outline-danger btn-sm">삭제</button>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<!-- // 기본소스-->

<!-- 시험일정 추가 팝업창 -->
<div class="modal fade" id="sModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">일정설정</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <!-- modal body -->
            <div class="modal-body">
                <div class="form-group row">
                    <label for="lname" class="col-sm-3 text-right control-label col-form-label">CODE</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="scode">
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-3 text-right control-label col-form-label">일정이름</label>
                    <div class="col-md-9">
                        <div class="custom-file">
                            <input type="text" class="form-control" id="sname">
                        </div>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-3 text-right control-label col-form-label">날짜</label>
                    <div class="col-sm-9">
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="mm/dd/yyyy">
                            <div class="input-group-append">
                                <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="lname" class="col-sm-3 text-right control-label col-form-label">링크</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control">
                    </div>
                </div>
                <button type="button" class="btn btn-info float-right m-l-2">확인</button>
            </div>
            <!-- //modal body -->
        </div>
    </div>
</div>
<!-- //시험일정 추가 팝업창 -->
<!-- //form문 끝 -->
<%@include file="/common/jsp/footer.jsp" %>
