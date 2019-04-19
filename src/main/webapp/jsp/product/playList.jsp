<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/jsp/common.jsp" %>
<script type='text/javascript' src='/dwr/engine.js'></script>
<script type='text/javascript' src='/dwr/interface/productManageService.js'></script>
<script type='text/javascript' src='/dwr/interface/selectboxService.js'></script>

<script>

    function play_modify(gKey) {
        innerValue("gKey", gKey);
        goPage("productManage","modifyPlayManage");
    }

    function fn_search(val) {
        var paging = new Paging();
        var sPage = $("#sPage").val();

        if(val == "new")  sPage = "1";
        dwr.util.removeAllRows("dataList");
        gfn_emptyView("H", "");//페이징 예외사항처리

        var searchType = getSelectboxValue("searchType");
        var searchText = getInputTextValue("searchText");

        productManageService.getProductListCount(searchType, searchText, "VIDEO", function(cnt) {
            paging.count(sPage, cnt, '10', '10', comment.blank_list);
            var listNum = ((cnt-1)+1)-((sPage-1)*10); //리스트 넘버링
            productManageService.getProductList(sPage, '10',searchType, searchText, "VIDEO", function (selList) {
                console.log(selList);
                if (selList.length > 0) {
                    console.log(selList);
                    for (var i = 0; i < selList.length; i++) {
                        var cmpList = selList[i];
                        var goosNameHtml = "<a href='javascript:void(0);' color='blue' style='float:left' onclick='play_modify(" + cmpList.GKey + ");'>"+cmpList.goodsName +"</a>";
                        if (cmpList != undefined) {
                            var cellData = [
                                function(data) {return i+1;},
                                function(data) {return cmpList.GKey;},
                                function(data) {return goosNameHtml;},
                                function(data) {return split_minute_getDay(cmpList.indate);},
                                function(data) {return contentYn(cmpList.isShow);},
                                function(data) {return contentYn(cmpList.isSell);},
                                function(data) {return contentYn(cmpList.isFree);},
                                function(data) {return cmpList.teacherName == null ? "-" : cmpList.teacherName;},
                                function(data) {return cmpList.statusStr;}
                            ];
                            dwr.util.addRows("dataList", [0], cellData, {escapeHtml: false});
                        }
                    }
                }else{
                    gfn_emptyView("V", comment.blank_list2);
                }
            });
        });
    }

    function contentYn(val) {
        var content = "";
        if(val == '1'){
            content = 'O';
        }else {
            content = 'X';
        }
        return content;
    }

</script>
<div class="page-breadcrumb">
    <div class="row">
        <div class="col-12 d-flex no-block align-items-center">
            <h4 class="page-title">동영상 목록</h4>
            <div class="ml-auto text-right">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">상품관리</li>
                        <li class="breadcrumb-item active" aria-current="page">동영상 상품관리</li>
                        <li class="breadcrumb-item active" aria-current="page">동영상 목록</li>
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
                    <h5 class="card-title" style="display:inline-block;vertical-align:middle;margin-bottom:10px;">동영상 목록</h5>
                    <div>
                        <div style=" float: left; width: 10%">
                         <select class="form-control" id="searchType">
                            <option>제목</option>
                            <option>코드</option>
                        </select>
                        </div>
                        <div style=" float: left; width: 33%">
                            <input type="text" class="form-control" id="searchText">
                        </div>
                        <div style=" float: left; width: 33%">
                            <button type="button" class="btn btn-outline-info mx-auto" onclick="fn_search('new')">검색</button>
                        </div>
                    </div>
                </div>
                <input type="hidden" id="sPage" >
                <input type="hidden" id="gKey"  name="gKey">
                <table class="table table-hover text-center">
                    <thead>
                    <tr>
                        <th scope="col" style="width: 5%;">No.</th>
                        <th scope="col" style="width: 5%;">CODE</th>
                        <th scope="col" style="width: 45%;">상품명</th>
                        <th scope="col" style="width: 10%;">등록일</th>
                        <th scope="col" style="width: 5%;">노출</th>
                        <th scope="col" style="width: 5%;">판매</th>
                        <th scope="col" style="width: 5%;">무료</th>
                        <th scope="col" style="width: 10%;">강사</th>
                        <th scope="col" style="width: 15%;">진행상태</th>
                    </tr>
                    </thead>
                    <tbody id="dataList"></tbody>
                    <tr>
                        <td id="emptys" colspan='23' bgcolor="#ffffff" align='center' valign='middle' style="visibility:hidden"></td>
                    </tr>
                </table>
                <%@ include file="/common/inc/com_pageNavi.inc" %>
            </div>
        </div>
    </div>
</div>
<%@include file="/common/jsp/footer.jsp" %>
<script>
    var table = $('#zero_config').DataTable();
    var info = table.page.info();
    $('.page-link').click(function(){
        alert("1");
    });
</script>