<%--
  Created by IntelliJ IDEA.
  User: outsourcing
  Date: 2022-02-09
  Time: 오후 10:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="/WEB-INF/include/header.jspf" %>

<style>
    #btnNew {display: none;}
    #btnDelete {display: none;}
</style>

<!-- Begin Page Content -->
<div class="container-fluid">
    <div class="main-content">
        <table class="tableSearch table table-hover table-striped table-bordered mb-5" style="margin-bottom: 0.5rem !important;">
            <colgroup>
                <col style="width: 15%">
                <col style="width: 20%">
                <col style="width: 12%">
                <col style="width: 20%">
                <col style="width: 13%">
                <col style="width: 20%">
            </colgroup>
            <thead class="thead-light">
                <tr>
                    <th>검색날짜</th>
                    <td colspan="3">
                        <div style="display: flex;">
                            <%@ include file="/WEB-INF/include/main-search-date-content.jspf"%>
                        </div>
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
                <tr>
                    <th>제품종류</th>
                    <td>
                        <select id="prod_kind" name="prod_kind" class="custom-select w-100" required="">
                            <option value="">제품종류선택</option>
                            <option value="PA">완제품</option>
                            <option value="PH">반제품</option>
                        </select>
                    </td>
                    <th>제품분류</th>
                    <td>
                        <select id="prod_group" name="prod_group" class="custom-select w-100" required="">
                            <option value="">품목분류선택</option>
                            <c:forEach var="item" items="${vmap.prodGroupList}" varStatus="status">
                                <option value="${item.base_detail_cd}">${item.base_detail_nm}</option>
                            </c:forEach>
                        </select>
                    </td>
                    <th>품목군</th>
                    <td>
                        <select id="prod_family" name="prod_family" class="custom-select w-100" required="">
                            <option value="">품목군선택</option>
                            <c:forEach var="item" items="${vmap.prodFamilyList}" varStatus="status">
                                <option value="${item.base_detail_cd}">${item.base_detail_nm}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
            </thead>
        </table>
    </div>

    <div class="menu-nav">
        <div>
            <span class="btn btn-pill btn-sm btn-primary">
                <i class="fas fa-home"></i> <i class="fas fa-chevron-right"></i> 재고관리 <i class="fas fa-chevron-right"></i> 제품수불부
            </span>
        </div>

        <%@ include file="/WEB-INF/include/main-top-right.jspf"%>
    </div>

    <%@ include file="/WEB-INF/include/main-progress.jspf"%>

    <div class="card shadow" style="min-height: 770px;">
        <div class="card-body">
            <div class="table-responsive">
                <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
                    <div class="row">
                        <div class="col-sm-12">
                            <input type="hidden" id="prod_cls" name="prod_cls" value="P" />
                            <%--                            <button type="button" class="btn btn-sm btn-success" onclick='setExcelPdfButtonEvent({tableID:"tblMaster", btn:"excel"});'><i class="fas fa-file-excel"></i> 엑셀</button>--%>
                            <table id ="tblMaster" class="table-list table table-hover table-striped table-bordered mb-5" style="width: 100%">
                                <thead>
                                <tr role="row">
                                    <th>제품코드</th>
                                    <th style="width: 8%">품번</th>
                                    <th style="width: 16%">품명</th>
                                    <th>종류</th>
                                    <th>분류</th>
                                    <th>품목군</th>
                                    <th>규격</th>
                                    <th>단위</th>
                                    <th>전일재고</th>
                                    <th>생산량</th>
                                    <th>출고량</th>
                                    <th>현재고</th>
                                </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<script>

    $(document).ready(() => {
        // DataTables setting
        setDatatable();
        getData();

        $("#prod_kind, #prod_family, #prod_group").on("change", () => { getData() });

        // 조회
        $("#btnSearch").on("click", () => { getData() });

    });

    // set tblMaster Database
    function setDatatable()
    {
        var arguments = {
            tabldID: "tblMaster"
            ,ordering: true
            // ,responsive: true
            ,orderIdx: []
            ,orderGubn:	[]
            ,rowspan: ""
            ,lengthMenu: [15, 50, 100, 500, 1000]
            ,paging: true
            ,field: true
            ,info: true
            ,filter: true
            ,stateSave: true
            ,collapse: false
            ,scrollY: 570
            ,selected: true
            ,multiSelected: false
            ,columnDefs : [
                {
                    "targets": 'no-sort',
                    "orderable": false
                }
            ]
        };

        setDataTablesOption(arguments);

    }

    function getData()
    {
        showWait('.container-fluid');

        $.ajax({
            url: "/mes/product/part/prodPartList"
            ,type: "post"
            ,headers: {
                "Content-Type": "application/json"
                ,"X-HTTP-Method-Override": "POST"
            }
            ,dataType: "json"
            ,data: JSON.stringify({
                fact_cd: "${vmap.fact_cd}"
                ,startDate: $("#startDate").val()
                ,endDate: $("#endDate").val()
                ,prod_kind: $("#prod_kind").val()
                ,prod_family: $("#prod_family").val()
                ,prod_group: $("#prod_group").val()
                ,search_text: $("#search_text").val()
                ,prod_cls: $("#prod_cls").val()
            })
        })
            .done(function (data)
            {
                $("#tblMaster").DataTable().clear();

                data.forEach((item, index) => {
                    let node = [];

                    node.push(IsEmpty(item.prod_cd));
                    node.push(IsEmpty(item.prod_pn));
                    node.push(IsEmpty(item.prod_nm));
                    node.push(IsEmpty(item.prod_kind_nm));
                    node.push(IsEmpty(item.prod_group_nm));
                    node.push(IsEmpty(item.prod_family_nm));
                    node.push(IsEmpty(item.prod_stand));
                    node.push(IsEmpty(item.prod_unit_nm));
                    node.push("<div class='text-right blue'>" + IsEmpty(item.df_prod_stock_cnt.comma('2')) + " " + IsEmpty(item.prod_unit_nm) + "</div>");
                    node.push("<div class='text-right'>" + IsEmpty(item.production_cnt.comma('2')) + " " + IsEmpty(item.prod_unit_nm) + "</div>");
                    node.push("<div class='text-right'>-" + IsEmpty(item.ship_cnt.comma('2')) + " " + IsEmpty(item.prod_unit_nm) + "</div>");
                    node.push("<div class='text-right red'>" + IsEmpty(item.cur_prod_stock_cnt.comma('2')) + " " + IsEmpty(item.prod_unit_nm) + "</div>");

                    // 각 row node 추가
                    let row = $("#tblMaster").DataTable().row.add(node).node();
                });

                // datatables draw
                $("#tblMaster").DataTable().draw(false);
            })
            .always(function (data) {
                hideWait('.container-fluid');
            })
            .fail(function (jqHXR, textStatus, errorThrown) {
                ajaxErrorAlert(jqHXR);
            });
    }

</script>

<%@ include file="/WEB-INF/include/footer.jspf" %>