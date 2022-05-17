<%--
  Created by IntelliJ IDEA.
  User: outsourcing
  Date: 2022-02-09
  Time: 오후 10:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="/WEB-INF/include/header.jspf" %>


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
                            <select id="date_type" name="date_type" class="custom-select w-10" style="width: 10% !important; margin-right: 5px;">
                                <option value="PUR_DT">발주일</option>
                                <option value="PUR_SHIP_DT">납기요청일</option>
                            </select>
                            <%@ include file="/WEB-INF/include/main-search-date-content.jspf"%>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>검색조건</th>
                    <td>
                        <select id="prod_group" name="prod_group" class="custom-select w-100" style="width: 15% !important;">
                            <option value="">품목분류선택</option>
                            <c:forEach var="item" items="${vmap.prodGroupList}" varStatus="status">
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
                <i class="fas fa-home"></i> <i class="fas fa-arrow-circle-right"></i> 품질관리 <i class="fas fa-arrow-circle-right"></i> 수입검사
            </span>
        </div>

        <div id="btnGroup">
            <button class="btn btn-sm btn-primary" type="button" id="btnSearch">
                <span class="btn-wrapper--icon">
                    <i class="fas fa-search"></i>
                </span>
                <span class="btn-wrapper--label">조회</span>
            </button>
            <button type="button" id="btnRegist" class="btn btn-sm btn-warning">
                    <span class="btn-wrapper--icon">
                        <i class="fas fa-download"></i>
                    </span>
                <span class="btn-wrapper--label">저장</span>
            </button>
        </div>

    </div>

    <%@ include file="/WEB-INF/include/main-progress.jspf"%>

    <div class="card shadow col-sm-12" style="min-height: 740px; float: left;">
        <div class="card-body">
            <div class="table-responsive">
                <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
                    <div class="row">
                        <div class="col-sm-8">
                            <table id ="tblMaster" class="table-list table table-hover table-striped table-bordered mb-5" style="width: 100%">
                                <thead>
                                    <tr role="row">
                                        <th>거래처</th>
                                        <th>매입일</th>
<%--                                        <th style="width: 6%">납기요청일</th>--%>
                                        <th style="width: 15%">품번</th>
                                        <th style="width: 20%">품목명</th>
<%--                                        <th>규격</th>--%>
<%--                                        <th>단위</th>--%>
                                        <th>수량</th>
                                        <th style="width: 10%">검사유무</th>
                                        <th style="width: 12%">측정분류</th>
                                        <th style="width: 10%">측정값</th>
                                    </tr>
                                </thead>
                                <tbody></tbody>
                            </table>
                        </div>

                        <div class="col-sm-4">
                            <form id="dataForm" name="dataForm" class="dataForm" method="post">
<%--                                <table class="table table-hover table-striped table-bordered mb-5">--%>
                                <table id="tblDataMaster" class="table table-hover table-bpurchaseed mb-3 table-form" style="margin-top: 35px;">
                                    <colgroup>
                                        <col style="width: 30%">
                                        <col style="width: 70%">
                                    </colgroup>
                                    <tbody>
                                        <tr role="row">
                                            <th>발주일</th>
                                            <td>
                                                <input type="hidden" id="frm_pur_cd" name="frm_pur_cd" value="" />
                                                <div id="frm_pur_dt" name="frm_pur_dt"></div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>납기요청일</th>
                                            <td>
                                                <div id="frm_pur_ship_dt" name="frm_pur_dt"></div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>품번</th>
                                            <td>
                                                <div id="frm_prod_pn" name="frm_prod_pn"></div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>품명</th>
                                            <td>
                                                <div id="frm_prod_nm" name="frm_prod_nm"></div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>규격</th>
                                            <td>
                                                <div id="frm_prod_stand" name="frm_prod_stand"></div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>단위</th>
                                            <td>
                                                <div id="frm_prod_unit_nm" name="frm_prod_unit_nm"></div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>수량</th>
                                            <td>
                                                <div class="text-right" id="frm_pur_cnt" name="frm_pur_cnt"></div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>입고수량</th>
                                            <td>
                                                <div class="text-right" id="frm_pur_in_cnt" name="frm_pur_in_cnt"></div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>측정분류</th>
                                            <td>
                                                <select id="frm_pur_quality_cd" name="frm_pur_quality_cd" class="custom-select w-100" style="width: 80% !important;">
                                                    <option value="">측정분류선택</option>
                                                    <c:forEach var="item" items="${vmap.qualityItemList}" varStatus="status">
                                                        <option value="${item.base_detail_cd}">${item.base_detail_nm}</option>
                                                    </c:forEach>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>측정값</th>
                                            <td>
                                                <div style="display: flex; flex-wrap: wrap;">
                                                    <div class="custom-control custom-radio my-3">
                                                        <input type="radio" checked=""  id="customRadio1" name="frm_pur_quality_val" class="custom-control-input" value="Y">
                                                        <label class="custom-control-label" for="customRadio1">양호</label>
                                                    </div>
                                                    <div class="custom-control custom-radio my-3">
                                                        <input type="radio" id="customRadio2" name="frm_pur_quality_val" class="custom-control-input" value="N">
                                                        <label class="custom-control-label" for="customRadio2">불량</label>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                    <tbody></tbody>
                                </table>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    #tblDataMaster > tbody > tr {
        height: 47px !important;
    }
</style>

<script>

    $(document).ready(() => {
        // DataTables setting
        setDatatable();

        $("#prod_kind, #prod_family, #prod_group").on("change", () => { getData() });

        $("#pop_pur_cnt, #pop_pur_price").on("keyup", () => { calcOrderAmtVat() });

        // 조회
        $("#btnSearch").on("click", () => { getData() });

        // Add Data - Call Data Form
        $("#btnNew").on("click", () => {
            callEditmodal("매입 등록", "R");
        });

        // 상세조회
        $("#tblMaster").on("click", "tr", function() {
            let pur_cd = $(this).find("input[name=pur_cd]").val();
            getDataOne(pur_cd);
        });

        $("#btnRegist").on("click", () => {

            if(IsNull($("#frm_pur_cd").val())) {
                alert("저장할 항목을 선택해주세요.");
                return false;
            }

            if(IsNull($("#frm_pur_quality_cd").val())) {
                alert("측정분류를 선택해주세요.");
                return false;
            }

            setPurchaseQualityModify();

        });

        setTimeout(() => getData(), 50);

    });

    // set tblMaster Database
    function setDatatable()
    {
        var arguments = {
            tabldID: "tblMaster"
            ,purchaseing: true
            // ,responsive: true
            ,purchaseIdx: []
            ,purchaseGubn:	[]
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
                    "purchaseable": false
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

        $("#"+formId).find("input[name$='price']").val("");
        $("#"+formId).find("input[name$='amt']").val("");
        $("#"+formId).find("input[name$='cnt']").val("");
        $("#"+formId).find("input[name$='vat']").val("");
    }


    function getData()
    {
        showWait('.container-fluid');

        $.ajax({
            url: "/mes/quality/material/materialInspectList"
            ,type: "post"
            ,headers: {
                "Content-Type": "application/json"
                ,"X-HTTP-Method-Override": "POST"
            }
            ,dataType: "json"
            ,data: JSON.stringify({
                fact_cd: "${vmap.fact_cd}"
                ,date_type: $("#date_type").val()
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

                let firstHtml = "<div class='text-left'>" + IsEmpty(item.comp_nm) + "</div>" +
                    "<input type=\"hidden\" name=\"fact_cd\" value=\"" + item.fact_cd + "\"</input>"+
                    "<input type=\"hidden\" name=\"pur_cd\" value=\"" + item.pur_cd + "\"</input>";

                node.push(firstHtml);
                node.push("<div class='text-center'>" + IsEmpty(item.pur_dt) + "</div>");
                node.push(IsEmpty(item.prod_pn));
                node.push(IsEmpty(item.prod_nm));
                // node.push(IsEmpty(item.prod_stand));
                // node.push(IsEmpty(item.prod_unit_nm));
                node.push("<div class='text-right'>" + IsEmpty(item.pur_cnt.comma('2')) + " " + IsEmpty(item.prod_unit_nm) + "</div>");

                node.push("<div class='text-center'>" + IsEmpty(item.pur_quality_yn) + "</div>");
                node.push("<div class='text-center'>" + IsEmpty(item.pur_quality_nm) + "</div>");
                node.push("<div class='text-center'>" + IsEmpty(item.pur_quality_val) + "</div>");

                // 각 row node 추가
                let row =  $("#tblMaster").DataTable().row.add(node).node();
                if(item.pur_quality_yn == "Y") {
                    $(row).find("td").addClass("bg-neutral-danger-custom");
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

    function getDataOne(pur_cd)
    {
        showWait('.container-fluid');

        $.ajax({
            url: "/mes/material/purchase/purchaseOne/" + pur_cd
            ,type: "get"
            ,dataType: "json"
            // ,data: JSON.stringify({})
        })
        .done(function (data)
        {
            resetForm("dataForm");
            setDataOne("frm_", data);

            if(data.pur_state == "31") {
                $("#btnPopModify").hide();
            }else {
                $("#btnPopModify").show();
            }
            $("#btnPopRegist").hide();

        })
        .always(function (data) {
            hideWait('.container-fluid');
        })
        .fail(function (jqHXR, textStatus, errorThrown) {
            ajaxErrorAlert(jqHXR);
        });
    }

    function setPurchaseQualityModify()
    {
        Swal.fire({
            title: '',
            text: "수입검사 결과를 저장하시겠습니까?",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: '확인',
            cancelButtonText: '취소'
        }).then((result) => {
            if (result.isConfirmed) {

                showWait('.dataModal');

                $.ajax({
                    type: "post"
                    ,url: "/mes/quality/material/materialQualityModify"
                    ,headers: {
                        "Content-Type": "application/json"
                        ,"X-HTTP-Method-Override": "POST"
                    }
                    ,dataType: "text"
                    ,data: JSON.stringify({
                        fact_cd: "${vmap.fact_cd}"
                        ,pur_cd: $("#frm_pur_cd").val()
                        ,pur_quality_yn: "Y"
                        ,pur_quality_cd: $("#frm_pur_quality_cd").val()
                        ,pur_quality_val: $("input:radio[name=frm_pur_quality_val]:checked").val()
                    })
                })
                .done(function (data) {
                    hideWait('.dataModal');
                    getData();
                })
                .always(function (data) {

                })
                .fail(function (jqHXR, textStatus, errorThrown) {
                    ajaxErrorAlert(jqHXR);
                    hideWait('.dataModal');
                });

            }
        });
    }


</script>

<%@ include file="/WEB-INF/include/footer.jspf" %>