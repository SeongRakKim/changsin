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
            <thead class="thead-light">
            <tr>
                <th>자재분류</th>
                <td>
                    <select id="prod_group" name="prod_group" class="custom-select w-100" required="">
                        <option value="">자재분류선택</option>
                        <c:forEach var="item" items="${vmap.mateGroupList}" varStatus="status">
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
                <i class="fas fa-home"></i> <i class="fas fa-arrow-circle-right"></i> 기준정보 <i class="fas fa-arrow-circle-right"></i> 원자재정보
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
                            <input type="hidden" id="prod_cls" name="prod_cls" value="M" />
                            <%--                            <button type="button" class="btn btn-sm btn-success" onclick='setExcelPdfButtonEvent({tableID:"tblMaster", btn:"excel"});'><i class="fas fa-file-excel"></i> 엑셀</button>--%>
                            <table id ="tblMaster" class="table-list table table-hover table-striped table-bordered mb-5" style="width: 100%">
                                <thead>
                                <tr role="row">
<%--                                    <th class="no-sort" style="width: 3%">--%>
<%--                                        <div class="custom-control custom-checkbox">--%>
<%--                                            <input type="checkbox" class="custom-control-input" id="listAll">--%>
<%--                                            <label class="custom-control-label" for="listAll"></label>--%>
<%--                                        </div>--%>
<%--                                    </th>--%>
                                    <th>자재코드</th>
                                    <th style="width: 8%">품번</th>
                                    <th style="width: 16%">품명</th>
                                    <th>분류</th>
                                    <th>규격</th>
                                    <th>단위</th>
                                    <th>단가</th>
<%--                                    <th>주거래처</th>--%>
                                    <th>안전재고</th>
                                    <th>자재재고</th>
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

    function resetForm(formId)
    {
        $("#"+formId).find("input:text").val("");
        $("#"+formId).find("input:hidden").not(":radio").val("");
        $("#"+formId).find("select").val("");
        // $("#"+formId).find("input[name$='yn']").val("Y");
        $(".key").removeClass("is-valid").removeClass("is-invalid");
        $(".invalid-feedback").text("");
        $("#"+formId).find(":disabled").prop("disabled", false);

        $("#"+formId).find("input[name$='price']").val(0);
        $("#"+formId).find("input[name$='amt']").val(0);
        $("#"+formId).find("input[name$='cnt']").val(0);
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

                let checkBoxNode = "<div class=\"custom-control custom-checkbox\">" +
                    "    <input type=\"hidden\" name=\"prod_cd\" value=\"" + item.prod_cd + "\">" +
                    "    <input type=\"checkbox\" class=\"custom-control-input\" id=\"listCheck_" + index + "\" name=\"listCheck\">" +
                    "    <label class=\"custom-control-label\" for=\"listCheck_" + index + "\"></label>" +
                    "</div>";

                // node.push(checkBoxNode);
                node.push(IsEmpty(item.prod_cd));
                node.push(IsEmpty(item.prod_pn));
                node.push(IsEmpty(item.prod_nm));
                node.push(IsEmpty(item.prod_group_nm));
                node.push(IsEmpty(item.prod_stand));
                node.push(IsEmpty(item.prod_unit_nm));
                node.push("<div class='text-right'>" + IsEmpty(item.prod_price.comma('2')) + "</div>");
                // node.push(IsEmpty(item.prod_main_comp_nm));
                node.push("<div class='text-right'>" + IsEmpty(item.prod_keep_cnt.comma('2')) + " " + IsEmpty(item.prod_unit_nm) + "</div>");
                node.push("<div class='text-right'>" + IsEmpty(item.prod_stock_cnt.comma('2')) + " " + IsEmpty(item.prod_unit_nm) + "</div>");

                // 각 row node 추가
                let row = $("#tblMaster").DataTable().row.add(node).node();
                if(item.prod_keep_cnt > item.prod_stock_cnt) {
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

</script>

<%@ include file="/WEB-INF/include/footer.jspf" %>