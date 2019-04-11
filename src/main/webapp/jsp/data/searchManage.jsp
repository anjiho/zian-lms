<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/dataManageService.js'></script>
<!--순서-->
<div class="page-breadcrumb">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">검색어 관리</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">데이터관리</li>
                        <li class="breadcrumb-item active" aria-current="page">일정/검색어관리</li>
                        <li class="breadcrumb-item active" aria-current="page">검색어관리</li>
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
        <div class="col-md-6">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title" style="position: absolute;left: -9999px;top: -9999px">직렬직 검색어선택</h5>
                    <div class="form-group row" style="margin-bottom: 0px;">
                        <label class="col-sm-3 text-left control-label col-form-label card-title"  style="margin-bottom: 0px;">직렬직선택</label>
                        <div class="col-sm-9">
                            <select class="select2 form-control custom-select">
                                <option>선택</option>
                                <option value="administrative">행정직</option>
                                <option value="acting">계리직</option>
                                <option value="technical">기술직</option>
                                <option value="online_bookstore">온라인서점 검색어관리</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title" style="display:inline-block;vertical-align:middle;margin-bottom:-2px;">검색어관리</h5>
                    <button type="button" style="vertical-align: middle;display:inline-block;float:right" class="btn btn-info btn-sm" data-toggle="modal" data-target="#sModal2">추가</button>
                </div>
                <table class="table table-hover text-center">
                    <thead>
                    <tr>
                        <th scope="col" style="width:75%;">검색어 목록</th>
                        <th scope="col" style="width:25%;">관리</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td class="text-left align-middle">안효선</td>
                        <td>
                            <button type="button" class="btn btn-outline-primary btn-sm">수정</button>
                            <button type="button" class="btn btn-outline-danger btn-sm">삭제</button>
                        </td>
                    </tr>
                    <tr>
                        <td class="text-left align-middle">2019 서울시9급</td>
                        <td>
                            <button type="button" class="btn btn-outline-primary btn-sm">수정</button>
                            <button type="button" class="btn btn-outline-danger btn-sm">삭제</button>
                        </td>
                    </tr>
                    <tr>
                        <td class="text-left align-middle">2019 국가직7급</td>
                        <td>
                            <button type="button" class="btn btn-outline-primary btn-sm">수정</button>
                            <button type="button" class="btn btn-outline-danger btn-sm">삭제</button>
                        </td>
                    </tr>
                    <tr>
                        <td class="text-left align-middle">2019 지방직7급</td>
                        <td>
                            <button type="button" class="btn btn-outline-primary btn-sm">수정</button>
                            <button type="button" class="btn btn-outline-danger btn-sm">삭제</button>
                        </td>
                    </tr>
                    <tr>
                        <td class="text-left align-middle">2019 서울시7급</td>
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
<div class="modal fade" id="sModal2" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">텍스트 입력</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <!-- modal body -->
            <div class="modal-body">
                <div class="form-group row">
                    <label class="col-sm-3 text-right control-label col-form-label">텍스트</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="scode">
                    </div>
                </div>
                <button type="button" class="btn btn-info float-right">확인</button>
            </div>
            <!-- //modal body -->
        </div>
    </div>
</div>
<%@include file="/common/jsp/footer.jsp" %>
