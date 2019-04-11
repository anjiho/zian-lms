<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<div class="page-breadcrumb">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">동영상 등록</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">상품관리</li>
                        <li class="breadcrumb-item active" aria-current="page">동영상 상품관리</li>
                        <li class="breadcrumb-item active" aria-current="page">동영상 등록</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</div>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-6">
            <div class="card">
                <form class="form-horizontal">
                    <div class="card-body">
                        <h4 class="card-title">기본정보</h4>
                        <div class="form-group row">
                            <label class="col-sm-3 text-right control-label col-form-label">상품타입</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" value="온라인강좌" readonly>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="lname" class="col-sm-3 text-right control-label col-form-label">이름</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="lname">
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-3 text-right control-label col-form-label">등록일</label>
                            <div class="col-sm-9">
                                <div class="input-group">
                                    <input type="text" class="form-control mydatepicker" placeholder="mm/dd/yyyy">
                                    <div class="input-group-append">
                                        <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-3 text-right control-label col-form-label">판매시작일</label>
                            <div class="col-sm-9">
                                <div class="input-group">
                                    <input type="text" class="form-control mydatepicker" placeholder="mm/dd/yyyy">
                                    <div class="input-group-append">
                                        <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-3 text-right control-label col-form-label">노출</label>
                            <div class="col-sm-9">
                                <div style="margin-top: -23px;">
                                    OFF
                                    <label class="switch">
                                        <input type="checkbox">
                                        <span class="slider"></span>
                                    </label>
                                    ON
                                </div>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-3 text-right control-label col-form-label">판매</label>
                            <div class="col-sm-9">
                                <div style="margin-top: -23px;">
                                    OFF
                                    <label class="switch">
                                        <input type="checkbox">
                                        <span class="slider"></span>
                                    </label>
                                    ON
                                </div>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-3 text-right control-label col-form-label">무료</label>
                            <div class="col-sm-9">
                                <div style="margin-top: -23px;">
                                    OFF
                                    <label class="switch">
                                        <input type="checkbox">
                                        <span class="slider"></span>
                                    </label>
                                    ON
                                </div>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-3 text-right control-label col-form-label">리스트이미지</label>
                            <div class="col-md-9">
                                <div class="custom-file">
                                    <input type="file" class="custom-file-input" required>
                                    <label class="custom-file-label" >Choose file...</label>
                                    <div class="invalid-feedback">Example invalid custom file feedback</div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-3 text-right control-label col-form-label">상세이미지</label>
                            <div class="col-md-9">
                                <div class="custom-file">
                                    <input type="file" class="custom-file-input" required>
                                    <label class="custom-file-label" >Choose file...</label>
                                    <div class="invalid-feedback">Example invalid custom file feedback</div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label  class="col-sm-3 text-right control-label col-form-label">강조표시</label>
                            <div class="col-sm-9">
                                <select class="select2 form-control custom-select" style="width:50%;height:36px;">
                                    <option>Select</option>
                                    <option value="AK">Alaska</option>
                                    <option value="HI">Hawaii</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-3 text-right control-label col-form-label">정산율</label>
                            <div class="row col-sm-9">
                                <div class="col-lg-3">
                                    <input type="text" class="form-control">
                                </div>
                                <div class="col-lg-2">
                                    <span>%</span>
                                </div>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-3 text-right control-label col-form-label">사은품 배송비무료</label>
                            <div class="col-sm-9">
                                <div style="margin-top: -23px;">
                                    OFF
                                    <label class="switch">
                                        <input type="checkbox">
                                        <span class="slider"></span>
                                    </label>
                                    ON
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div><!--end 기본정보card-->
        </div><!--end 기본정보div-->
        <div class="col-md-6">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title m-b-0">옵션</h5>
                    <button type="button" class="btn btn-info" style="float:right;">추가</button>
                </div>
                <table class="table">
                    <thead>
                    <tr>
                        <th scope="col" style="text-align:center;width:30%">옵션명</th>
                        <th scope="col" style="text-align:center;">원가</th>
                        <th scope="col" style="text-align:center;">판매가</th>
                        <th scope="col" style="text-align:center;">포인트</th>
                        <th scope="col" colspan="2" style="text-align:center;">재수강</th>
                        <th scope="col" colspan="2" style="text-align:center;"></th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td style="padding: 0.3rem;text-align: center;">
                            <select class="select2 form-control custom-select" style="height:36px;">
                                <option>Select</option>
                                <option value="AK">Alaska</option>
                                <option value="HI">Hawaii</option>
                            </select>
                        </td>
                        <td style="padding: 0.3rem;">
                            <input type="text" class="form-control">
                        </td>
                        <td style="padding: 0.3rem;">
                            <input type="text" class="form-control">
                        </td>
                        <td style="padding: 0.3rem;">
                            <input type="text" class="form-control">
                        </td>
                        <td style="padding: 0.3rem;">
                            <input type="text" class="form-control">
                        </td>
                        <td style="padding: 0.3rem;">
                            <input type="text" class="form-control">
                        </td>
                        <td>
                            <a href="#" data-toggle="tooltip" data-placement="top" title="Delete">
                                </i><i class="mdi mdi-close"></i>
                            </a>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <!-- card new -->

        </div><!--end row-->
    </div><!--end container-fluid-->
    <%@include file="/common/jsp/footer.jsp" %>
    <script>
        $('.mydatepicker').datepicker();
        $('#datepicker-autoclose').datepicker({
            autoclose: true,
            todayHighlight: true
        });
        var quill = new Quill('#editor', {
            theme: 'snow'
        });


    </script>