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
                        <option value="MO">원자재</option>
                        <option value="MS">부자재</option>
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
                <i class="fas fa-home"></i> <i class="fas fa-arrow-circle-right"></i> 입출고관리 <i class="fas fa-arrow-circle-right"></i> 자산수불부
            </span>
        </div>

        <%@ include file="/WEB-INF/include/main-top-right.jspf"%>
    </div>

    <%@ include file="/WEB-INF/include/main-progress.jspf"%>

    <div class="card shadow" style="min-height: 740px;">
        <div class="card-body">
            <div class="table-responsive">
                <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
                    <div class="row">
                        <div class="col-sm-12">
                            <table id ="tblMaster" class="table-list table table-hover table-striped table-bordered mb-5" style="width: 100%">
                                <thead>
                                    <tr role="row">
                                        <th>코드</th>
                                        <th>품번</th>
                                        <th>품명</th>
                                        <th>종류</th>
                                        <th>분류</th>
                                        <th>품목군</th>
                                        <th>규격</th>
                                        <th>단위</th>
                                        <th>단가</th>
                                    </tr>
                                </thead>
                                <tbody></tbody>
                            </table>
                            <div>
                                <span style="font-weight: 600; font-size: 30px; margin-left: 28px;">
                                    <i class="fas fa-align-justify"></i> 수불이력
                                </span>
                            </div>
                            <table id ="tblMaster2" class="table-list table table-hover table-striped table-bordered mb-5" style="width: 100%">
                                <thead>
                                <tr role="row">
                                    <th style="width: 9%">입출고일시</th>
                                    <th style="width: 5%">구분</th>
                                    <th style="width: 5%">종류</th>
                                    <th style="width: 5%">위치</th>
                                    <th>품번</th>
                                    <th>품목명</th>
<%--                                    <th>종류</th>--%>
<%--                                    <th>분류</th>--%>
                                    <th style="width: 6%">규격</th>
                                    <th style="width: 7%">전일재고</th>
                                    <th>Lot.No</th>
                                    <th style="width: 7%">입출고량</th>
                                    <th style="width: 7%">현재고량</th>
                                    <th>상세구분</th>
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
</div>

<script>

    $(document).ready(() => {
        // DataTables setting
        setDatatable();
        setDatatable2();

        $("#prod_kind, #prod_family, #prod_group").on("change", () => { getData() });

        // 조회
        $("#btnSearch").on("click", () => { getData() });

        $("#tblMaster").on("click", "tr", function() {
            let prod_cd = $(this).find("input[name=prod_cd]").val();
            getData2(prod_cd);
        });

        setTimeout(() => getData(), 30);

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
            ,paging: false
            ,field: false
            ,info: false
            ,filter: false
            ,stateSave: true
            ,collapse: false
            ,scrollY: 200
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

    // set tblMaster Database
    function setDatatable2()
    {
        var arguments2 = {
            tabldID: "tblMaster2"
            ,ordering: true
            // ,responsive: true
            ,orderIdx: []
            ,orderGubn:	[]
            ,rowspan: ""
            ,lengthMenu: [15, 50, 100, 500, 1000]
            ,paging: false
            ,field: false
            ,info: false
            ,filter: false
            ,stateSave: true
            ,collapse: false
            ,scrollY: 300
            ,selected: true
            ,multiSelected: false
            ,columnDefs : [
                {
                    "targets": 'no-sort',
                    "orderable": false
                }
            ]
        };

        setDataTablesOption(arguments2);
    }

    function getData()
    {
        showWait('.container-fluid');

        $.ajax({
            url: "/mes/base/product/prodList"
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
            })
        })
            .done(function (data)
            {
                $("#tblMaster").DataTable().clear();

                data.forEach((item, index) => {
                    let node = [];

                    let checkBoxNode = "<div>" +
                                        "    <input type=\"hidden\" name=\"prod_cd\" value=\"" + item.prod_cd + "\">" +
                                        IsEmpty(item.prod_cd) +
                                        "</div>";

                    node.push(checkBoxNode);
                    // node.push(IsEmpty(item.prod_cd));
                    node.push(IsEmpty(item.prod_pn));
                    node.push(IsEmpty(item.prod_nm));
                    node.push(IsEmpty(item.prod_kind_nm));
                    node.push(IsEmpty(item.prod_group_nm));
                    node.push(IsEmpty(item.prod_family_nm));
                    node.push(IsEmpty(item.prod_stand));
                    node.push(IsEmpty(item.prod_unit_nm));
                    node.push("<div class='text-right'>" + IsEmpty(item.prod_price.comma('2')) + "</div>");

                    // 각 row node 추가
                    $("#tblMaster").DataTable().row.add(node).node();
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

    function getData2(prod_cd)
    {
        showWait('.container-fluid');

        $.ajax({
            url: "/mes/asset/part/assetPartList"
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
                ,prod_cd: prod_cd
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
                // node.push(IsEmpty(item.prod_kind_nm));
                // node.push(IsEmpty(item.prod_group_nm));
                node.push(IsEmpty(item.prod_stand));
                node.push("<div class='text-right'>" + IsEmpty(item.prod_stock_cnt.comma('2')) + " " + IsEmpty(item.prod_unit_nm) + "</div>");
                node.push(IsEmpty(item.lot_no));
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