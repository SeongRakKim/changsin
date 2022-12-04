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
                <col style="width: 10%">
                <col style="width: 60%">
                <col style="width: 10%">
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
            </tr>
            <tr>
                <th>검색조건</th>
                <td>
                    <select id="prod_kind" name="prod_kind" class="custom-select w-100" style="width: 15% !important;">
                        <option value="">제품종류선택</option>
                        <option value="PA">완제품</option>
                        <option value="PH">반제품</option>
                    </select>
                    <select id="prod_group" name="prod_group" class="custom-select w-100" style="width: 15% !important;">
                        <option value="">품목분류선택</option>
                        <c:forEach var="item" items="${vmap.prodGroupList}" varStatus="status">
                            <option value="${item.base_detail_cd}">${item.base_detail_nm}</option>
                        </c:forEach>
                    </select>
                    <select id="prod_family" name="prod_family" class="custom-select w-100" style="width: 15% !important;">
                        <option value="">제품군선택</option>
                        <c:forEach var="item" items="${vmap.prodFamilyList}" varStatus="status">
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

    <div class="menu-nav">
        <div>
            <span class="btn btn-pill btn-sm btn-primary">
                <i class="fas fa-home"></i> <i class="fas fa-arrow-circle-right"></i> 입출고관리 <i class="fas fa-arrow-circle-right"></i> 제품입출고이력
            </span>
        </div>

        <%@ include file="/WEB-INF/include/main-top-right.jspf"%>
    </div>

    <%@ include file="/WEB-INF/include/main-progress.jspf"%>

    <div class="card shadow" style="height: 1500px;">
        <div class="card-body">
            <div class="table-responsive">
                <div>
                    <span style="font-size: 20px; font-weight: 300;"><i class="fas fa-check-double"></i> 입고이력</span>
                </div>
                <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
                    <div class="row">
                        <div class="col-sm-12">
                            <table id ="tblMaster" class="table-list table table-hover table-striped table-bordered mb-5" style="width: 100%">
                                <thead>
                                <tr role="row">
                                    <th>입출고일시</th>
                                    <th>구분</th>
                                    <th>종류</th>
                                    <th>위치</th>
                                    <th style="width: 8%">품번</th>
                                    <th style="width: 12%">품목명</th>
                                    <th>종류</th>
                                    <th>분류</th>
                                    <th>규격</th>
                                    <th>전일재고</th>
                                    <th>입출고량</th>
                                    <th>현재고량</th>
                                    <th style="width: 18%">상세구분</th>
                                </tr>
                                </thead>
                                <tbody></tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div style="margin-top: 80px;">
                    <span style="font-size: 20px; font-weight: 300;"><i class="fas fa-check-double"></i> 출고이력</span>
                </div>
                <div id="dataTable_wrapper2" class="dataTables_wrapper dt-bootstrap4">
                    <div class="row">
                        <div class="col-sm-12">
                            <table id ="tblMaster2" class="table-list table table-hover table-striped table-bordered mb-5" style="width: 100%">
                                <thead>
                                <tr role="row">
                                    <th>입출고일시</th>
                                    <th>구분</th>
                                    <th>종류</th>
                                    <th>위치</th>
                                    <th style="width: 8%">품번</th>
                                    <th style="width: 12%">품목명</th>
                                    <th>종류</th>
                                    <th>분류</th>
                                    <th>규격</th>
                                    <th>전일재고</th>
                                    <th>입출고량</th>
                                    <th>현재고량</th>
                                    <th style="width: 18%">상세구분</th>
                                </tr>
                                </thead>
                                <tbody></tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

<%--    <div class="card shadow" style="min-height: 740px;">--%>
<%--        <div class="card-body">--%>
<%--            <div class="table-responsive">--%>
<%--                <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">--%>
<%--                    <div class="row">--%>
<%--                        <div class="col-sm-12">--%>
<%--                            <table id ="tblMaster" class="table-list table table-hover table-striped table-bordered mb-5" style="width: 100%">--%>
<%--                                <thead>--%>
<%--                                <tr role="row">--%>
<%--                                    <th>입출고일시</th>--%>
<%--                                    <th>구분</th>--%>
<%--                                    <th>종류</th>--%>
<%--                                    <th>위치</th>--%>
<%--                                    <th style="width: 8%">품번</th>--%>
<%--                                    <th style="width: 12%">품목명</th>--%>
<%--                                    <th>종류</th>--%>
<%--                                    <th>분류</th>--%>
<%--                                    <th>규격</th>--%>
<%--                                    <th>전일재고</th>--%>
<%--                                    <th>입출고량</th>--%>
<%--                                    <th>현재고량</th>--%>
<%--                                    <th style="width: 18%">상세구분</th>--%>
<%--                                </tr>--%>
<%--                                </thead>--%>
<%--                                <tbody></tbody>--%>
<%--                            </table>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
</div>

<script>

    $(document).ready(() => {
        // DataTables setting
        setDatatable("tblMaster");
        setDatatable("tblMaster2");

        $("#prod_kind, #prod_family, #prod_group").on("change", () => {
            getData();
            getData2();
        });

        // 조회
        $("#btnSearch").on("click", () => {
            getData();
            getData2();
        });

        setTimeout(() => getData(), 30);
        setTimeout(() => getData2(), 30);

    });

    // set tblMaster Database
    function setDatatable(tableId)
    {
        var arguments = {
            tabldID: tableId
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
            ,scrollY: 540
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
            url: "/mes/product/inout/productInoutList"
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
                ,inout_type: "I"
            })
        })
        .done(function (data)
        {
            $("#tblMaster").DataTable().clear();

            data.forEach((item, index) => {
                let node = [];

                node.push("<div class='text-center'>" + IsEmpty(item.inout_dt_time) + "</div>");
                node.push("<div class='text-center'>" + IsEmpty(item.inout_type_nm) + "</div>");
                node.push("<div class='text-center'>" + IsEmpty(item.inout_item_nm) + "</div>");
                node.push("<div class='text-center'>" + IsEmpty(item.inout_crcd_nm) + "</div>");
                node.push(IsEmpty(item.prod_pn));
                node.push(IsEmpty(item.prod_nm));
                node.push(IsEmpty(item.prod_kind_nm));
                node.push(IsEmpty(item.prod_group_nm));
                node.push(IsEmpty(item.prod_stand));
                node.push("<div class='text-right'>" + IsEmpty(item.prod_stock_cnt.comma('2')) + " " + IsEmpty(item.prod_unit_nm) + "</div>");
                if(item.inout_type === "I") {
                    node.push("<div class='text-right'>" + IsEmpty(item.inout_cnt.comma('2')) + " " + IsEmpty(item.prod_unit_nm) + "</div>");
                }else {
                    node.push("<div class='text-right'>" + "-" + IsEmpty(item.inout_cnt.comma('2')) + " " + IsEmpty(item.prod_unit_nm) + "</div>");
                }
                node.push("<div class='text-right'>" + IsEmpty(item.cur_prod_stock_cnt.comma('2')) + " " + IsEmpty(item.prod_unit_nm) + "</div>");
                node.push(IsEmpty(item.inout_msg));

                // 각 row node 추가
                let row = $("#tblMaster").DataTable().row.add(node).node();
                if(item.inout_type == "O") {
                    $(row).find("td").addClass("red");
                }
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

    function getData2()
    {
        showWait('.container-fluid');

        $.ajax({
            url: "/mes/product/inout/productInoutList"
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
                ,inout_type: "O"
            })
        })
        .done(function (data)
        {
            $("#tblMaster2").DataTable().clear();

            data.forEach((item, index) => {
                let node = [];

                node.push("<div class='text-center'>" + IsEmpty(item.inout_dt_time) + "</div>");
                node.push("<div class='text-center'>" + IsEmpty(item.inout_type_nm) + "</div>");
                node.push("<div class='text-center'>" + IsEmpty(item.inout_item_nm) + "</div>");
                node.push("<div class='text-center'>" + IsEmpty(item.inout_crcd_nm) + "</div>");
                node.push(IsEmpty(item.prod_pn));
                node.push(IsEmpty(item.prod_nm));
                node.push(IsEmpty(item.prod_kind_nm));
                node.push(IsEmpty(item.prod_group_nm));
                node.push(IsEmpty(item.prod_stand));
                node.push("<div class='text-right'>" + IsEmpty(item.prod_stock_cnt.comma('2')) + " " + IsEmpty(item.prod_unit_nm) + "</div>");
                if(item.inout_type === "I") {
                    node.push("<div class='text-right'>" + IsEmpty(item.inout_cnt.comma('2')) + " " + IsEmpty(item.prod_unit_nm) + "</div>");
                }else {
                    node.push("<div class='text-right'>" + "-" + IsEmpty(item.inout_cnt.comma('2')) + " " + IsEmpty(item.prod_unit_nm) + "</div>");
                }
                node.push("<div class='text-right'>" + IsEmpty(item.cur_prod_stock_cnt.comma('2')) + " " + IsEmpty(item.prod_unit_nm) + "</div>");
                node.push(IsEmpty(item.inout_msg));

                // 각 row node 추가
                let row = $("#tblMaster2").DataTable().row.add(node).node();
                if(item.inout_type == "O") {
                    $(row).find("td").addClass("red");
                }
            });

            // datatables draw
            $("#tblMaster2").DataTable().draw(false);
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