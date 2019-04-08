<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/dataManageService.js'></script>
<script type='text/javascript' src='/dwr/interface/selectboxService.js'></script>
<script>
$(document).ready(function() {
    getSubDomainList("sel_subDomain", "");//서브도메인 select 불러오기
//    getBannerList();
});


function changeBox2(val) {
   dataManageService.getBannerList(val,function (selList) {
       if (selList.length > 0) {
           for (var i = 0; i < selList.length; i++) {
               var cmpList = selList[i];
               var result = cmpList.result;
               console.log(result);





               var selList2 = cmpList.resultList;

               for (var j=0; j<selList2.length;j++){
                  var cmpList2 =  selList2[j];
                  console.log(cmpList2);
               }


              /* if (cmpList != undefined) {
                   for(var i = 0; i < cmpList.resultList.length; i++){
                       var reList = cmpList.resultList[i];
                       console.log(reList.value5);
                   }
               }*/
           }
       }
   });
}
</script>
<div class="page-breadcrumb">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">배너관리</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">배너관리</li>
                        <li class="breadcrumb-item active" aria-current="page">배너관리</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</div>
<div class="container-fluid">
    <div class="form-group">
        <div class="row">
            <label  class="text-right control-label col-form-label">서브도메인</label>
            <div class="col-sm-5">
                <select id="sel_subDomain" class="form-control" onChange="changeBox2(this.value);">
                    <option value="">선택</option>
                </select>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6" id="banner_top">
            <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">상단 대 배너</h5>
                        <button type="button" class="btn btn-info" style="float:right;" data-toggle="modal" data-target="#Modal1">추가</button>
                        <button type="button" class="btn btn-success" style="float:right;">순서변경</button>
                    </div>
            </div>
        </div><!--end card-->
        <!--<div class="col-md-6">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title m-b-0">상단 소 배너</h5>
                    <button type="button" class="btn btn-info" style="float:right;">추가</button>

                </div>
            </div>
        </div>
    </div>
    <%--<div class="row">--%>
        <%--<div class="col-md-6">--%>
            <%--<div class="card">--%>
                <%--<form class="form-horizontal">--%>
                    <%--<div class="card-body">--%>
                        <%--<h5 class="card-title">자인교수진</h5>--%>
                        <%--<button type="button" class="btn btn-info" style="float:right;">추가</button>--%>
                        <%--<div class="form-group row">--%>

                        <%--</div>--%>
                    <%--</div>--%>
                <%--</form>--%>
            <%--</div>--%>
        <%--</div>--%>
        <%--<div class="col-md-6">--%>
            <%--<div class="card">--%>
                <%--<div class="card-body">--%>
                    <%--<h5 class="card-title m-b-0">중앙 소 배너</h5>--%>
                    <%--<button type="button" class="btn btn-info" style="float:right;">추가</button>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</div>--%>
    <%--</div>--%>
    <%--<div class="row">--%>
        <%--<div class="col-md-6">--%>
            <%--<div class="card">--%>
                <%--<form class="form-horizontal">--%>
                    <%--<div class="card-body">--%>
                        <%--<h5 class="card-title">이벤트 소식</h5>--%>
                        <%--<button type="button" class="btn btn-info" style="float:right;">추가</button>--%>
                        <%--<div class="form-group row">--%>

                        <%--</div>--%>
                    <%--</div>--%>
                <%--</form>--%>
            <%--</div>--%>
        <%--</div>--%>
    <%--</div>--%>
<%--</div>--%>

<!--배너 등록 팝업-->
<div class="modal fade" id="Modal1" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">배너설정</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true ">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="form-group row">
                    <label for="lname" class="col-sm-3 text-right control-label col-form-label">이름</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="lname">
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-3 text-right control-label col-form-label">이미지</label>
                    <div class="col-md-9">
                        <div class="custom-file">
                            <input type="file" class="custom-file-input" id="validatedCustomFile" required>
                            <label class="custom-file-label" for="validatedCustomFile">Choose file...</label>
                            <div class="invalid-feedback">Example invalid custom file feedback</div>
                        </div>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-3 text-right control-label col-form-label">배경이미지</label>
                    <div class="col-md-9">
                        <div class="custom-file">
                            <input type="file" class="custom-file-input" required>
                            <label class="custom-file-label" for="validatedCustomFile">Choose file...</label>
                            <div class="invalid-feedback">Example invalid custom file feedback</div>
                        </div>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-3 text-right control-label col-form-label">배경색상</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group row">
                    <label for="lname" class="col-sm-3 text-right control-label col-form-label">링크URL</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-3 text-right control-label col-form-label">새창열기</label>
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
                <button type="button" class="btn btn-info" style="float:right;">저장</button>
            </div><!--//modal-body-->
        </div>
    </div>
</div>
<!--// 배너 등록 팝업-->
<%@include file="/common/jsp/footer.jsp" %>
