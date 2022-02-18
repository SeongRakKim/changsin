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
                    <th scope="col">거래처구분</th>
                    <td>
                        <select id="comp_type" name="comp_type" class="custom-select w-100" required="">
                            <option value="">거래처구분선택</option>
                            <c:forEach var="item" items="${vmap.compTypeList}" varStatus="status">
                                <option value="${item.base_detail_cd}">${item.base_detail_nm}</option>
                            </c:forEach>
                        </select>
                    </td>
                    <th scope="col">거래처분류</th>
                    <td>
                        <select id="comp_group" name="comp_group" class="custom-select w-100" required="">
                            <option value="">거래처구분선택</option>
                            <c:forEach var="item" items="${vmap.compGroupList}" varStatus="status">
                                <option value="${item.base_detail_cd}">${item.base_detail_nm}</option>
                            </c:forEach>
                        </select>
                    </td>
                    <th scope="col">검색어</th>
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
                            <table id ="MasterSheet" class="table table-bordered dataTable"
                                   cellspacing="0" role="grid" aria-describedby="dataTable_info"
                                   style="width: 100%;">
                                <thead>
                                    <tr role="row">
                                        <th class="sorting sorting_asc" tabindex="0" aria-controls="dataTable" rowspan="1"
                                            colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending"
                                            style="width: 80.9531px;">Name
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

<script>
    $(function()
    {
        // DataTables setting
        setDatatable();
    });

    function setDatatable()
    {
        var arguments = {
            sheetID: "MasterSheet"
            ,lengthMenu: [20, 50, 100, 500, 1000]
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
</script>

<%@ include file="/WEB-INF/include/footer.jspf" %>