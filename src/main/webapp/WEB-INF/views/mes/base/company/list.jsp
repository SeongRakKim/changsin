<%--
  Created by IntelliJ IDEA.
  User: Mi Ra
  Date: 2022-02-09
  Time: 오후 10:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="/WEB-INF/include/header.jspf" %>

<!-- Begin Page Content -->
<div class="container-fluid">
    <div class="menu-nav">
        <div>
            <!-- Page Heading -->
<%--            <span class="btn btn-pill btn-secondary">--%>
            <span class="btn btn-pill btn-sm btn-primary">
                <i class="fas fa-home"></i> > 기준정보 > 거래처정보
            </span>
        </div>

        <%@ include file="/WEB-INF/include/main-top-right.jspf"%>
    </div>

    <%@ include file="/WEB-INF/include/main-progress.jspf"%>

    <div>
        <table class="tableSearch table table-hover table-striped table-bordered mb-5" style="margin-bottom: 0.5rem !important;">
            <colgroup>
                <col style="width: 10%">
                <col style="width: 30%">
                <col style="width: 10%">
                <col style="width: 20%">
                <col style="width: 10%">
                <col style="width: 20%">
            </colgroup>
            <thead class="thead-light">
                <tr>
                    <th>거래처구분</th>
                    <td>
                        <select id="comp_type" name="comp_type" class="custom-select w-100" required="">
                            <option value="">거래처구분선택</option>
                            <c:forEach var="item" items="${vmap.compTypeList}" varStatus="status">
                                <option value="${item.base_detail_cd}">${item.base_detail_nm}</option>
                            </c:forEach>
                        </select>
                    </td>
                    <th>거래처분류</th>
                    <td>
                        <select id="comp_group" name="comp_group" class="custom-select w-100" required="">
                            <option value="">거래처분류선택</option>
                            <c:forEach var="item" items="${vmap.compGroupList}" varStatus="status">
                                <option value="${item.base_detail_cd}">${item.base_detail_nm}</option>
                            </c:forEach>
                        </select>
                    </td>
                    <th>검색어</th>
                    <td>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text">
                                    <i class="fas fa-search"></i>
                                </span>
                            </div>
                            <input id="search_text" name="search_text" class="form-control" placeholder="검색어" type="text">
                        </div>
                    </td>
                </tr>
            </thead>
        </table>
    </div>

    <div class="card shadow" style="min-height: 800px;">
        <div class="card-body">
            <div class="table-responsive">
                <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
                    <div class="row">
                        <div class="col-sm-12">
<%--                            <table id ="tblMaster" class="table table-bordered dataTable"--%>
<%--                                   cellspacing="0" role="grid" aria-describedby="dataTable_info"--%>
<%--                                   style="width: 100%;">--%>
                            <table id ="tblMaster" class="table table-hover table-striped table-bordered mb-5">
                                <thead>
                                    <tr role="row">
                                        <th>Name
                                        </th>
                                        <th class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1"
                                            aria-label="Position: activate to sort column ascending" style="width: 117.172px;">
                                            Position
                                        </th>
                                        <th class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1"
                                            aria-label="Office: activate to sort column ascending" style="width: 63.4219px;">Office
                                        </th>
                                        <th class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1"
                                            aria-label="Age: activate to sort column ascending" style="width: 30.1719px;">Age
                                        </th>
                                        <th class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1"
                                            aria-label="Start date: activate to sort column ascending" style="width: 70.1406px;">
                                            Start date
                                        </th>
                                        <th class="sorting" tabindex="0" aria-controls="dataTable" rowspan="1" colspan="1"
                                            aria-label="Salary: activate to sort column ascending" style="width: 66.1406px;">Salary
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%@ include file="/WEB-INF/include/test-data.jspf"%>
                                </tbody>
                        </table>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="dataModal" tabindex="-1" role="dialog" aria-labelledby="registModal" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-xl modal-form-xl" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h6 class="modal-title" id="form-modal-title"></h6>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <form id="dataForm" name="dataForm" method="post">
                <div class="modal-body">
                    <table id="tblPopData" class="table table-hover table-bordered mb-5 table-form">
                        <tbody>
                            <tr>
                                <th>거래처코드<span class="red"> (필수)</span></th>
                                <td>
                                    <input type="text" id="pop_comp_cd" name="pop_comp_cd" class="form-control" placeholder="거래처코드" title="거래처코드"
                                           required />
                                    <div class="invalid-feedback"></div>
                                </td>
                                <th>거래처명<span class="red"> (필수)</span></th>
                                <td>
                                    <input type="text" id="pop_comp_nm" name="pop_comp_nm" class="form-control" placeholder="거래처명" title="거래처명"
                                           required />
                                </td>
                                <th>사업자등록번호</th>
                                <td>
                                    <input type="text" id="pop_comp_busin_num" name="pop_comp_busin_num" class="form-control" placeholder="사업자등록번호" title="사업자등록번호" />
                                </td>
                            </tr>
                            <tr>
                                <th>거래처구분<span class="red"> (필수)</span></th>
                                <td>
                                    <select id="pop_comp_type" name="pop_comp_type" class="custom-select w-100" title="거래처구분" required>
                                        <option value="">거래처구분선택</option>
                                        <c:forEach var="item" items="${vmap.compTypeList}" varStatus="status">
                                            <option value="${item.base_detail_cd}">${item.base_detail_nm}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                                <th>거래처분류</th>
                                <td>
                                    <select id="pop_comp_group" name="pop_comp_group" class="custom-select w-100"  title="거래처분류">
                                        <option value="">거래처분류선택</option>
                                        <c:forEach var="item" items="${vmap.compGroupList}" varStatus="status">
                                            <option value="${item.base_detail_cd}">${item.base_detail_nm}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                                <th>대표자명</th>
                                <td>
                                    <input type="text" id="pop_comp_ceo" name="pop_comp_ceo" class="form-control" placeholder="대표자명" title="대표자명" />
                                </td>
                            </tr>
                            <tr>
                                <th>대표전화</th>
                                <td>
                                    <input type="text" id="pop_comp_tel" name="pop_comp_tel" class="form-control" placeholder="대표전화" title="대표전화" />
                                </td>
                                <th>FAX</th>
                                <td>
                                    <input type="text" id="pop_comp_fax" name="pop_comp_fax" class="form-control" placeholder="FAX" title="FAX" />
                                </td>
                                <th>E-MAIL</th>
                                <td>
                                    <input type="text" id="pop_comp_email" name="pop_comp_email" class="form-control" placeholder="E-MAIL" title="E-MAIL" />
                                </td>
                            </tr>
                            <tr>
                                <th>담당자</th>
                                <td>
                                    <input type="text" id="pop_comp_mana" name="pop_comp_mana" class="form-control" placeholder="담당자" title="담당자" />
                                </td>
                                <th>담당자연락처</th>
                                <td>
                                    <input type="text" id="pop_comp_mana_tel" name="pop_comp_mana_tel" class="form-control" placeholder="담당자연락처" title="담당자연락처" />
                                </td>
                                <th>업태</th>
                                <td>
                                    <input type="text" id="pop_comp_busin_stat" name=pop_comp_busin_stat" class="form-control" placeholder="업태" title="업태" />
                                </td>
                            </tr>
                            <tr>
                                <th>종목</th>
                                <td>
                                    <input type="text" id="pop_comp_busin_kind" name="pop_comp_busin_kind" class="form-control" placeholder="종목" title="종목" />
                                </td>
                                <th>주소</th>
                                <td colspan="3">
                                    <input type="text" id="pop_comp_address" name="pop_comp_address" class="form-control" placeholder="주소" title="주소" />
                                </td>
                            </tr>
                            <tr>
                                <th>비고</th>
                                <td colspan="5">
                                    <input type="text" id="pop_comp_nt" name="pop_comp_nt" class="form-control" placeholder="비고" title="비고" />
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </form>
            <div class="modal-footer">
                <button type="button" id="btnPopRegist" class="btn btn-primary ">
                    <span class="btn-wrapper--icon">
                        <i class="fas fa-download"></i>
                    </span>
                    <span class="btn-wrapper--label">등록</span>
                </button>

                <button type="button" id="btnPopModify" class="btn btn-success ">수정</button>

                <button type="button" class="btn btn-secondary" data-dismiss="modal">
                    <span class="btn-wrapper--icon">
                        <i class="fas fa-times-circle"></i>
                    </span>
                    <span class="btn-wrapper--label">닫기</span>
                </button>
            </div>
        </div>
    </div>
</div>

<script>
    $(function()
    {
        // DataTables setting
        setDatatable();
    });


    // set tblMaster Database
    function setDatatable()
    {
        var arguments = {
            sheetID: "tblMaster"
            ,ordering: true
            ,orderIdx: []
            ,orderGubn:	[]
            ,rowspan: ""
            ,paging: true
            ,field: true
            ,info: true
            ,filter: true
            ,stateSave: true
            ,collapse: false
            ,scrollY: 580
            ,selected: true
            ,multiSelected: false
        };

        setDataTablesOption(arguments);

    }

    // Add Data - Call Data Form
    $("#btnNew").on("click",function() {
        $("#dataModal").modal("show");
        $("#form-modal-title").text("거래처 추가");
        $("#btnPopRegist").show();
        $("#btnPopModify").hide();
    });

    $("#btnPopRegist").on("click", function()
    {
        if (!parsleyFormValidate("dataForm")) return false;

        Swal.fire({
            title: '',
            text: "거래처 정보를 저장하시겠습니까?",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: '확인',
            cancelButtonText: '취소'
        }).then((result) => {
            if (result.isConfirmed) {
                registModifyData();
            }
        })
    });

    function registModifyData()
    {

        // $.ajax({
        //     type: "post"
        //     ,url: "/mes/base/equipment/repairRegist"
        //     ,headers: {
        //         "Content-Type": "application/json"
        //         ,"X-HTTP-Method-Override": "POST"
        //     }
        //     ,data: JSON.stringify({
        //         equp_cd: equp_cd
        //         ,repair_date : repair_date
        //         ,repair_note : repair_note
        //         ,repair_comp : repair_comp
        //         ,repair_cost : repair_cost
        //     })
        //     ,dataType: "json"
        //     ,success: function(data) {
        //
        //     }
        // });
    }




</script>

<%@ include file="/WEB-INF/include/footer.jspf" %>