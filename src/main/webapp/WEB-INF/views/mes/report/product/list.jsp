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
    #tblPopData tbody tr th, #tblPopData tbody tr td, #tblPopData thead tr th {
        height: 15vh;
        font-size: 2em;
    }
    .report {
        padding: 70px;
    }
</style>

<!-- Begin Page Content -->
<div class="container-fluid">
    <div class="main-content">
        <table class="tableSearch table table-hover table-striped table-bordered mb-5" style="margin-bottom: 0.5rem !important;">
            <thead class="thead-light">
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
                <i class="fas fa-home"></i> <i class="fas fa-chevron-right"></i> 재고관리 <i class="fas fa-chevron-right"></i> 제품재고현황
            </span>
        </div>

        <div id="btnGroup">
            <button class="btn btn-sm btn-primary" type="button" id="btnSearch">
                <span class="btn-wrapper--icon">
                    <i class="fas fa-search"></i>
                </span>
                <span class="btn-wrapper--label">조회</span>
            </button>
            <button class="btn btn-sm btn-info" type="button" id="btnReport">
                <span class="btn-wrapper--icon">
                    <i class="fas fa-file-invoice"></i>
                </span>
                <span class="btn-wrapper--label">출력</span>
            </button>
        </div>
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
                                    <th>단가</th>
<%--                                    <th>안전재고</th>--%>
<%--                                    <th>제품재고</th>--%>
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

    <div class="report" style="display: block;">
        <table id="tblPopData" class="table table-hover table-bordered mb-3 table-form">
            <thead>
                <tr>
                    <th colspan="9" style="height: 20vh; font-size: 10em;">제품재고</th>
                </tr>
                <tr>
                    <th>제품코드</th>
                    <th style="width: 8%">품번</th>
                    <th style="width: 16%">품명</th>
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
    </div>
</div>

<script id="prodStockTemplete" type="text/x-handlebars-template">
    <tr class="dataList list_tr{{cnt}}">
        <td>
            {{prod_cd}}
        </td>
        <td>
            {{prod_pn}}
        </td>
        <td>
            {{prod_nm}}
        </td>
        <td>
            {{prod_kind_nm}}
        </td>
        <td>
            {{prod_group_nm}}
        </td>
        <td>
            {{prod_family_nm}}
        </td>
        <td>
            {{prod_stand}}
        </td>
        <td>
            {{prod_stand}}
        </td>
        <td style="text-align: right !important;">
            {{prod_stock_cnt}}
        </td>
    </tr>
</script>


<script>

    $(document).ready(() => {
        // DataTables setting
        setDatatable();
        getData();

        $("#prod_kind, #prod_family, #prod_group").on("change", () => { getData() });

        // 조회
        $("#btnSearch").on("click", () => { getData() });

        $("#btnReport").on("click", () => { goReport() });

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
            url: "/mes/product/stock/prodStockList"
            ,type: "post"
            ,headers: {
                "Content-Type": "application/json"
                ,"X-HTTP-Method-Override": "POST"
            }
            ,dataType: "json"
            ,data: JSON.stringify({
                fact_cd: "${vmap.fact_cd}"
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

                let checkBoxNode = "<div class=\"custom-control custom-checkbox\">" +
                    "    <input type=\"hidden\" name=\"prod_cd\" value=\"" + item.prod_cd + "\">" +
                    "    <input type=\"checkbox\" class=\"custom-control-input\" id=\"listCheck_" + index + "\" name=\"listCheck\">" +
                    "    <label class=\"custom-control-label\" for=\"listCheck_" + index + "\"></label>" +
                    "</div>";

                // node.push(checkBoxNode);
                node.push(IsEmpty(item.prod_cd));
                node.push(IsEmpty(item.prod_pn));
                node.push(IsEmpty(item.prod_nm));
                node.push(IsEmpty(item.prod_kind_nm));
                node.push(IsEmpty(item.prod_group_nm));
                node.push(IsEmpty(item.prod_family_nm));
                node.push(IsEmpty(item.prod_stand));
                node.push(IsEmpty(item.prod_unit_nm));
                // node.push("<div class='text-right'>" + IsEmpty(item.prod_price.comma('2')) + "</div>");
                // node.push("<div class='text-right'>" + IsEmpty(item.prod_keep_cnt.comma('2')) + " " + IsEmpty(item.prod_unit_nm) + "</div>");
                node.push("<div class='text-right'>" + IsEmpty(item.prod_stock_cnt.comma('2')) + " " + IsEmpty(item.prod_unit_nm) + "</div>");

                // 각 row node 추가
                let row = $("#tblMaster").DataTable().row.add(node).node();
                if(item.prod_keep_cnt > item.prod_stock_cnt) {
                    $(row).find("td").addClass("red");
                }

                addProdStockRow(item);
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

    function addProdStockRow(data)
    {
        let template_html = $("#prodStockTemplete").html();
        let template = Handlebars.compile(template_html);
        let resultRowCnt = $("#tblPopData > tbody > tr").length + 1;
        let templateData;

        templateData = {
            ...data
        };

        $("#tblPopData > tbody").append(template(templateData));
    }
</script>

<script type="text/javascript">

    const goReport = () => {
        setTimeout(pdfMake(),500);
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
            doc.save("제품재고현황_"+dateString+'.pdf');
        });
        $(".report").hide();
    }
</script>

<%@ include file="/WEB-INF/include/footer.jspf" %>