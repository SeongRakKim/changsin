<%--
  Created by IntelliJ IDEA.
  User: outsourcing
  Date: 2022-02-09
  Time: 오후 10:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.min.js"></script>
<script type="text/javascript" src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>

<%@ include file="/WEB-INF/include/header.jspf" %>

<style>
    #btnNew {display: none;}
    #btnDelete {display: none;}
    #tblPopData tbody tr th, #tblPopData tbody tr td {
        height: 22vh;
        font-size: 3.2em;
    }
    .report {
        padding: 70px;
    }
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
                <i class="fas fa-home"></i> <i class="fas fa-arrow-circle-right"></i> 보고서 <i class="fas fa-arrow-circle-right"></i> 납품실적
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
                                        <th style="width: 8%">수주일</th>
                                        <th style="width: 8%">납기요청일</th>
                                        <th style="width: 12%">거래처</th>
                                        <th style="width: 10%">품번</th>
                                        <th style="width: 14%">품목명</th>
                                        <th>규격</th>
                                        <th style="width: 8%">수주수량</th>
                                        <th style="width: 8%">납품일</th>
                                        <th style="width: 8%">납품수량</th>
                                        <th>출력</th>
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

    <div class="report" style="display: none;">
        <table id="tblPopData" class="table table-hover table-bordered mb-3 table-form">
            <colgroup>
                <col style="width: 20%" />
                <col style="width: 30%" />
                <col style="width: 20%" />
                <col style="width: 30%" />
            </colgroup>
            <thead>
            <tr>
                <th colspan="4" style="height: 35vh; font-size: 10em;">납품실적</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <th>수주번호</th>
                <td><div id="report_odr_cd" name="report_odr_cd"></div></td>
                <th>거래처</th>
                <td><div id="report_comp_nm" name="report_comp_nm"></div></td>
            </tr>
            <tr>
                <th>수주일</th>
                <td><div id="report_odr_dt" name="report_odr_dt"></div></td>
                <th>납기요청일</th>
                <td><div id="report_odr_ship_dt" name="report_odr_ship_dt"></div></td>
            </tr>
            <tr>
                <th>수주수량</th>
                <td>
                    <div id="report_odr_cnt" name="report_odr_cnt"></div>
                </td>
                <th>제품분류</th>
                <td>
                    <div id="report_prod_group_nm" name="report_prod_group_nm"></div>
                </td>
            </tr>
            <tr>
                <th>제품종류</th>
                <td>
                    <div id="report_prod_kind_nm" name="report_prod_kind_nm"></div>
                </td>
                <th>현재고량</th>
                <td class="text-right">
                    <div id="report_prod_stock_cnt" name="report_prod_stock_cnt"></div>
                </td>
            </tr>
            <tr>
                <th>규격</th>
                <td>
                    <div id="report_prod_stand" name="report_prod_stand"></div>
                </td>
                <th>단위</th>
                <td>
                    <div id="report_prod_unit_nm" name="report_prod_unit_nm"></div>
                </td>
            </tr>
            <tr>
                <th>품번</th>
                <td><div id="report_prod_pn" name="report_prod_pn"></div></td>
                <th>품명</th>
                <td><div id="report_prod_nm" name="report_prod_nm"></div></td>
            </tr>
            <tr>
                <th>납품일</th>
                <td>
                    <div id="report_ship_detail_dt" name="report_ship_detail_dt"></div>
                </td>
                <th>납품수량</th>
                <td>
                    <div id="report_ship_detail_cnt" name="report_ship_detail_cnt"></div>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</div>


<script>

    $(document).ready(() => {
        // DataTables setting
        setDatatable();

        $("#prod_kind, #prod_family, #prod_group").on("change", () => { getData() });

        // 조회
        $("#btnSearch").on("click", () => { getData() });

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

    function callEditmodal(title, flag)
    {
        $("#form-modal-icon").removeAttr("class");
        $("#dataModal").modal("show");
        $("#form-modal-title").text(title);
        $("#form-modal-icon").addClass(flag === "R" ? "fas fa-paste" : "fas fa-edit");
        $("#btnPopRegist").show();
        $("#btnPopModify").hide();

        resetForm("dataForm");
        $("#tblPopShipmentData tbody").empty();
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
        $("#"+formId).find("input[name$='vat']").val(0);

        $("#pop_plan_stdt").val(moment().format('YYYY-MM-DD'));
        $("#pop_plan_eddt").val(moment().format('YYYY-MM-DD'));
    }

    function resetForm2(formId)
    {
        $("#"+formId).find("input:text").not(".no-reset").val("");
        $("#"+formId).find("input:hidden").not(".no-reset").val("");
        $("#"+formId).find("select").val("");
        $("#"+formId).find(":disabled").prop("disabled", false);

        $("#"+formId).find("input[name$='price']").val(0);
        $("#"+formId).find("input[name$='amt']").val(0);
        $("#"+formId).find("input[name$='cnt']").val(0);
        $("#"+formId).find("input[name$='vat']").val(0);
    }

    function getData()
    {
        showWait('.container-fluid');

        $.ajax({
            url: "/mes/sales/shipment/salesShipmentDetailtList"
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
                ,search_text: $("#search_text").val()
                ,ship_state: "22"
            })
        })
        .done(function (data)
        {
            $("#tblMaster").DataTable().clear();

            data.forEach((item, index) => {
                let node = [];

                let firstNode = "<div class='text-center'>" +
                                "    <input type=\"hidden\" name=\"odr_cd\" value=\"" + item.odr_cd + "\">" +
                                "    <input type=\"hidden\" name=\"ship_cd\" value=\"" + item.ship_cd + "\">" +
                                "    <input type=\"hidden\" name=\"ship_state\" value=\"" + item.ship_state + "\">" +
                                     IsEmpty(item.odr_dt) +
                                "</div>";

                node.push(firstNode);
                node.push("<div class='text-center'>" + IsEmpty(item.odr_ship_dt) + "</div>");
                node.push(IsEmpty(item.comp_nm));
                node.push(IsEmpty(item.prod_pn));
                node.push(IsEmpty(item.prod_nm));
                node.push(IsEmpty(item.prod_stand));
                node.push("<div class='text-right'>" + IsEmpty(item.odr_cnt.comma('2')) + " " + IsEmpty(item.prod_unit_nm) + "</div>");
                node.push("<div class='text-center'>" + IsEmpty(item.ship_detail_dt) + "</div>");
                node.push("<div class='text-right'>" + IsEmpty(item.ship_detail_cnt.comma('2')) + " " + IsEmpty(item.prod_unit_nm) + "</div>");

                let manageButton = "<div style='display: flex; flex-wrap: wrap; justify-content: space-around;' >" +
                    "    <button class=\"btn btn-sm btn btn-first \" type=\"button\" onclick=\"goReport('" + item.ship_cd + "', '" + item.ship_detail_cd + "')\">출력</button>" +
                    "</div>";

                node.push(manageButton);

                // 각 row node 추가
                let row = $("#tblMaster").DataTable().row.add(node).node();
                if(item.ship_state == "22") {
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
</script>

<script type="text/javascript">

    function goReport (ship_cd, ship_detail_cd)
    {
        $.ajax({
            url: "/mes/sales/shipment/shipDetailOne/" + ship_cd + "/" + ship_detail_cd
            ,type: "get"
            ,dataType: "json"
        })
        .done(function (data)
        {
            setDataOne("report_", data);
            setTimeout(pdfMake(),500);
        })
        .always(function (data) {
            hideWait('.dataModal');
        })
        .fail(function (jqHXR, textStatus, errorThrown) {
            ajaxErrorAlert(jqHXR);
        });
    }

    const pdfMake = () => {
        $(".report").show();
        html2canvas($('.report')[0]).then(function(canvas) {
            let imgData = canvas.toDataURL('image/png');

            let imgWidth = 210; // 이미지 가로 길이(mm) A4 기준
            let pageHeight = imgWidth * 1.414;  // 출력 페이지 세로 길이 계산 A4 기준
            let imgHeight = canvas.height * imgWidth / canvas.width;
            let heightLeft = imgHeight;

            let doc = new jsPDF('p', 'mm');
            let position = 0;

            // 첫 페이지 출력
            doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
            heightLeft -= pageHeight;

            // 한 페이지 이상일 경우 루프 돌면서 출력
            while (heightLeft >= 20) {
                position = heightLeft - imgHeight;
                doc.addPage();
                doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
                heightLeft -= pageHeight;
            }

            let today = new Date();
            let year = today.getFullYear();
            let month = ('0' + (today.getMonth() + 1)).slice(-2);
            let day = ('0' + today.getDate()).slice(-2);
            let hours = ('0' + today.getHours()).slice(-2);
            let minutes = ('0' + today.getMinutes()).slice(-2);

            let dateString = year + month + day + hours + minutes;

            // 파일 저장
            doc.save("납품실적_"+dateString+'.pdf');
        });
        $(".report").hide();
    }
</script>

<%@ include file="/WEB-INF/include/footer.jspf" %>