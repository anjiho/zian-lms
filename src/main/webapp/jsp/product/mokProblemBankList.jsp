<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/productManageService.js'></script>
<script>
    function init() {
        getProductSearchSelectbox("l_searchSel");
        menuActive('menu-1', 7);
    }

    function goModifyMockExam(examKey) {
        innerValue("examKey",examKey);
        goPage("productManage","modifyMokExam");
    }

    function fn_search(val) {
        var paging = new Paging();
        var sPage = getInputTextValue("sPage");
        var searchType = getSelectboxValue("searchType");   //검색 조건 셀렉트박스 값
        var searchText = getInputTextValue("searchText");   //검색 값

        if (val == "new") sPage = "1";

        dwr.util.removeAllRows("dataList"); //테이블 리스트 초기화
        gfn_emptyView("H", "");//페이징 예외사항처리

        productManageService.getMockExamListCount(searchType, searchText, function (cnt) {
            paging.count(sPage, cnt, '10', '10', comment.blank_list);
            var listNum = ((cnt-1)+1)-((sPage-1)*10); //리스트 넘버링
            productManageService.getMockExamList(sPage, pagingListCount(), searchType, searchText, function (selList) {
                console.log(selList);
                if (selList.length == 0) return;
                dwr.util.addRows("dataList", selList, [
                    function(data) {return "<a href='javascript:void(0);' color='blue' onclick='goModifyMockExam(" + data.examKey + ");'>" +  data.name + "</a>";},
                    function(data) {return split_minute_getDay(data.acceptStartDate)+"<br>"+split_minute_getDay(data.acceptEndDate);},
                    function(data) {return split_minute_getDay(data.onlineStartDate)+"<br>"+split_minute_getDay(data.onlineEndDate);},
                    function(data) {return data.onlineTime+'분';},
                ], {escapeHtml:false});
            });
        });
    }
</script>
<div class="page-breadcrumb">
    <input type="hidden" id="sPage">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">모의고사 목록</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">상품관리</li>
                        <li class="breadcrumb-item active" aria-current="page">모의고사 목록</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</div>
<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <div class="row border-bottom" style="display: block;overflow: hidden;padding-bottom: 10px">
                        <label class="control-label col-form-label ml-3 pt-4 font-weight-bold" style="display:inline;font-size:1.05rem;">옵션</label>
                        <button type="button" onclick="popup_save(0,786,0)" class="row btn btn-info btn-sm" style="float:right;margin-right: 1.25rem">검색</button>
                    </div>
                    <div class="row" style="padding-top:20px">
                        <div class="col">
                            <div class="form-group row">
                                <label for="lname" class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">출제년도</label>
                                <div class="col-sm-8 pl-0 pr-0">
                                    <select class="select2 form-control custom-select">
                                        <option>선택</option>
                                        <option value="best">BEST</option>
                                        <option value="new">NEW</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label  class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">출제구분</label>
                                <div class="col-sm-8 pl-0 pr-0">
                                    <select class="select2 form-control custom-select">
                                        <option>선택</option>
                                        <option value="best">BEST</option>
                                        <option value="new">NEW</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">패턴</label>
                                <div class="col-sm-8 pl-0 pr-0">
                                    <select class="select2 form-control custom-select">
                                        <option>선택</option>
                                        <option value="best">BEST</option>
                                        <option value="new">NEW</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="col">
                            <div class="form-group row" style="">
                                <label for="lname" class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">과목코드</label>
                                <input type="text" class="col-sm-8 form-control" id="lname">
                            </div>
                            <div class="form-group row">
                                <label  class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">과목</label>
                                <div class="col-sm-8 pl-0 pr-0">
                                    <select class="select2 form-control custom-select">
                                        <option>선택</option>
                                        <option value="best">BEST</option>
                                        <option value="new">NEW</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label  class="col-sm-2 control-label col-form-label" style="margin-bottom: 0">유형</label>
                                <div class="col-sm-8 pl-0 pr-0">
                                    <select class="select2 form-control custom-select">
                                        <option>선택</option>
                                        <option value="best">BEST</option>
                                        <option value="new">NEW</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <div class="form-group row">
                                <label  class="col-sm-1 control-label col-form-label" style="margin-bottom: 0">단원</label>
                                <div class="col-sm-4 pl-0 pr-0 mr-3">
                                    <select class="select2 form-control custom-select">
                                        <option>선택</option>
                                        <option value="best">현대소셜 이론과 감상</option>
                                        <option value="new">올바른 우리말 종합(삭제)</option>
                                    </select>
                                </div>
                                <div class="col-sm-3 pl-0 pr-0 mr-3">
                                    <select class="select2 form-control custom-select">
                                        <option>선택</option>
                                        <option value="best">BEST</option>
                                        <option value="new">NEW</option>
                                    </select>
                                </div>
                                <div class="col-sm-3 pl-0 pr-0">
                                    <select class="select2 form-control custom-select">
                                        <option>선택</option>
                                        <option value="best">BEST</option>
                                        <option value="new">NEW</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-body">
                        <table class="table table-hover">
                            <thead>
                            <tr>
                                <th scope="col" width="9%">코드</th>
                                <th scope="col" width="9%">출제구분</th>
                                <th scope="col" width="9%">출제년도</th>
                                <th scope="col" width="9%">과목</th>
                                <th scope="col" width="9%">난이도</th>
                                <th scope="col" width="16.5%">유형</th>
                                <th scope="col" width="16.5%">패턴</th>
                                <th scope="col" width="16.5%">단원</th>
                                <th scope="col" width="8%"></th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>15962</td>
                                <td>모의고사</td>
                                <td>2019</td>
                                <td>공업화학</td>
                                <td>상</td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td>
                                    <button type="button" class="btn btn-outline-info btn-sm" data-toggle="modal" data-target="#addModal">문제보기</button>
                                </td>
                            </tr>
                            <tr>
                                <td>15962</td>
                                <td>모의고사</td>
                                <td>2019</td>
                                <td>공업화학</td>
                                <td>상</td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td>
                                    <button type="button" class="btn btn-outline-info btn-sm" data-toggle="modal" data-target="#sModal2">문제보기</button>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                        <!-- 페이징 영역
                        <div class="paging">

                        </div>
                        !-- //페이징 영역 -->
                    </div>
                </div>
            </div>
        </div>
    </div>


<%@include file="/common/jsp/footer.jsp" %>
