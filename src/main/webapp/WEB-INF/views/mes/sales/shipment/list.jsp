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
                        <select id="date_type" name="date_type" class="custom-select w-10" style="width: 10% !important; margin-right: 5px;">
                            <option value="ODR_DT">수주일</option>
                            <option value="ODR_SHIP_DT">납기요청일</option>
                        </select>
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
                        <option value="">제품분류선택</option>
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
                <i class="fas fa-home"></i> <i class="fas fa-arrow-circle-right"></i> 영업관리 <i class="fas fa-arrow-circle-right"></i> 출하관리
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
<%--                                        <th class="no-sort" style="width: 3%">--%>
<%--                                            <div class="custom-control custom-checkbox">--%>
<%--                                                <input type="checkbox" class="custom-control-input" id="listAll">--%>
<%--                                                <label class="custom-control-label" for="listAll"></label>--%>
<%--                                            </div>--%>
<%--                                        </th>--%>
                                        <th style="width: 10%">수주번호</th>
                                        <th style="width: 8%">수주일</th>
                                        <th style="width: 8%">납기요청일</th>
                                        <th style="width: 14%">거래처</th>
                                        <th style="width: 12%">품번</th>
                                        <th style="width: 18%">품목명</th>
                                        <th>규격</th>
                                        <th style="width: 8%">수주수량</th>
                                        <th style="width: 8%">납품수량</th>
                                        <th>상태</th>
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

<%-- 납품 데이터 Modal --%>
<div class="modal fade dataModal" id="dataModal" tabindex="-1" role="dialog" aria-labelledby="registModal" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-xl modal-form-xl" role="document">
        <div class="modal-content" style="width: 110%;">
            <div class="modal-header">
                <h2 class="modal-title"><i id="form-modal-icon"></i> <span id="form-modal-title"></span></h2>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">
                <table id="tblPopData" class="table table-hover table-bordered mb-3 table-form">
                    <colgroup>
                        <col style="width: 10%" />
                        <col style="width: 15%" />
                        <col style="width: 10%" />
                        <col style="width: 15%" />
                        <col style="width: 10%" />
                        <col style="width: 15%" />
                        <col style="width: 10%" />
                        <col style="width: 15%" />
                    </colgroup>
                    <tbody>
                        <tr>
                            <th>거래처</th>
                            <td>
                                <input type="hidden" id="pop_ship_cd" name="pop_ship_cd" class="form-control"
                                       placeholder="납품코드" title="납품코드" />
                                <input type="hidden" id="pop_odr_cd" name="pop_odr_cd" class="form-control"
                                       placeholder="수주코드" title="수주코드" />
                                <input type="hidden" id="pop_comp_cd" name="pop_comp_cd" class="form-control"
                                       placeholder="거래처" title="거래처" />
                                <input type="hidden" id="pop_comp_nm" name="pop_comp_nm" class="form-control"
                                       placeholder="거래처" title="거래처" />
                                <div id="pop_selector" name="pop_selector"></div>
                            </td>
                            <th>수주일</th>
                            <td class="text-center">
                                <div id="pop_odr_dt" name="pop_odr_dt"></div>
                            </td>
                            <th>납기요청일</th>
                            <td class="text-center">
                                <div id="pop_odr_ship_dt" name="pop_odr_ship_dt"></div>
                            </td>
                            <th>수주수량</th>
                            <td class="text-right">
                                <div id="pop_odr_cnt" name="pop_odr_cnt"></div>
                            </td>
                        </tr>
                        <tr>
                            <th>품번 / 품명</th>
                            <td>
                                <input type="hidden" id="pop_prod_cd" name="pop_prod_cd" class="form-control"
                                       placeholder="제품코드" title="제품코드" />
                                <input type="hidden" id="pop_prod_nm" name="pop_prod_nm" class="form-control"
                                       placeholder="제품명" title="제품명" />
                                <input type="hidden" id="pop_prod_pn" name="pop_prod_pn" class="form-control"
                                       placeholder="제품품번" title="제품코드" />
                                <div id="pop_selector2" name="pop_selector2"></div>
                            </td>
                            <th>제품종류</th>
                            <td>
                                <div id="pop_prod_kind_nm" name="pop_prod_kind_nm"></div>
                            </td>
                            <th>제품분류</th>
                            <td>
                                <div id="pop_prod_group_nm" name="pop_prod_group_nm"></div>
                            </td>
                            <th>제품군</th>
                            <td>
                                <div id="pop_prod_family_nm" name="pop_prod_family_nm"></div>
                            </td>
                        </tr>
                        <tr>
                            <th>규격</th>
                            <td>
                                <div id="pop_prod_stand" name="pop_prod_stand"></div>
                            </td>
                            <th>단위</th>
                            <td>
                                <div id="pop_prod_unit_nm" name="pop_prod_unit_nm"></div>
                            </td>
                            <th>현재고량</th>
                            <td class="text-right">
                                <div id="pop_prod_stock_cnt" name="pop_prod_stock_cnt"></div>
                            </td>
                            <th>납품량</th>
                            <td class="text-right">
                                <div class="red" id="pop_ship_cnt" name="pop_ship_cnt"></div>
                            </td>
                        </tr>
                    </tbody>
                </table>

                <form id="dataForm" name="dataForm" class="dataForm" method="post">
                    <div style="height: 500px; overflow: auto;">
                        <table id="tblPopShipmentData" class="table table-hover table-bordered mb-3 table-form">
                            <colgroup>
                                <col style="width: 10%" />
                                <col style="width: 25%" />
                                <col style="width: 25%" />
                                <col style="width: 30%" />
                                <col style="width: 10%" />
                            </colgroup>
                            <thead>
                            <tr>
                                <th>순서</th>
                                <th>납품일 <span class="red"> (필수)</span></th>
                                <th>납품수량 <span class="red"> (필수)</span></th>
                                <th>비고</th>
                                <th>
                                    <button type="button" id="btnAddSubList" class="btn btn-primary btn-sm">
                                        <span class="btn-wrapper--icon">
                                            <i class="fas fa-angle-double-down"></i>
                                        </span>
                                        <span class="btn-wrapper--label">추가</span>
                                    </button>
                                </th>
                            </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>
                </form>
            </div>

            <div class="modal-footer">

                <button type="button" id="btnShipmentRegistModify" class="btn btn-primary" >
                    <span class="btn-wrapper--icon">
                        <i class="fas fa-check"></i>
                    </span>
                    <span class="btn-wrapper--label">저장</span>
                </button>

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

<%-- 납품데이터 Templete --%>
<script id="popSalesShipmentTemplete" type="text/x-handlebars-template">
    <tr class="dataList list_tr{{cnt}}">
        <td style="text-align: center !important;">
            <input type="hidden" name="pop_ship_detail_cd" class="form-control" value="{{ship_detail_cd}}" />
            {{cnt}}
        </td>
        <td style="text-align: center;">
            <div class="input-group input-group-seamless">
                <input name="pop_ship_detail_dt" class="form-control datepicker no-reset" title="납품일자"
                       placeholder="납품일자" type="text" value="{{ship_detail_dt}}" />
                <div class="input-group-append">
                    <span class="input-group-text"><i class="fas fa-calendar"></i></span>
                </div>
            </div>
        </td>
        <td>
            <input type="hidden" name="pop_old_ship_detail_cnt" class="form-control" value="{{old_ship_detail_cnt}}"
                   placeholder="이전납품량" title="이전납품량" required />
            <input type="text" name="pop_ship_detail_cnt" class="form-control" value="{{ship_detail_cnt}}"
                   placeholder="납품량" title="납품량" required />
        </td>
        <td>
            <input type="text" name="pop_ship_detail_notice" class="form-control" value="{{ship_detail_notice}}"
                   placeholder="비고" title="비고" />
        </td>
        <td style="text-align: center !important;">
            <button class="btn btn-sm btn-danger result-delete" type="button" onclick="salesShipmentDetailDelete({{cnt}})">
                <span class="btn-wrapper--icon">
                    <i class="fas fa-minus-circle"></i>
                </span>
                <span class="btn-wrapper--label">삭제</span>
            </button>
        </td>
    </tr>
</script>

<script>

    $(document).ready(() => {
        // DataTables setting
        setDatatable();

        $("#prod_kind, #prod_family, #prod_group").on("change", () => { getData() });

        // 조회
        $("#btnSearch").on("click", () => { getData() });

        // 상세조회
        $("#tblMaster").on("dblclick", "tr", function() {
            let odr_cd = $(this).find("input[name=odr_cd]").val();
            let ship_cd = $(this).find("input[name=ship_cd]").val();
            callEditmodal("납품내역 등록", "M");
            getDataOne(odr_cd, ship_cd);
        });

        // 납품완료
        $("#btnShipmentRegist").on("click", () => {

            Swal.fire({
                title: '',
                text: "공정을 최종완료 하시겠습니까?",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: '확인',
                cancelButtonText: '취소'
            }).then((result) => {
                if (result.isConfirmed) {
                    planProcessComplete();
                }
            });
        });

        $("#btnAddSubList").on("click", () => {
            addPopShipmentDetailRow();
        });

        $("#btnShipmentRegistModify").on("click", () => {

            if(!parsleyIsValidate("dataForm")) return false;

            Swal.fire({
                title: '',
                text: "납품내역을 저장하시겠습니까?",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: '확인',
                cancelButtonText: '취소'
            }).then((result) => {
                if (result.isConfirmed) {
                    shipmentDetailRegistModifyData();
                }
            });
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
            url: "/mes/sales/shipment/shipList"
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

                    // let checkBoxNode = "<div class=\"custom-control custom-checkbox\">" +
                    //     "    <input type=\"hidden\" name=\"odr_cd\" value=\"" + item.odr_cd + "\">" +
                    //     "    <input type=\"hidden\" name=\"ship_cd\" value=\"" + item.ship_cd + "\">" +
                    //     "    <input type=\"hidden\" name=\"plan_state\" value=\"" + item.plan_state + "\">" +
                    //     "    <input type=\"checkbox\" class=\"custom-control-input\" id=\"listCheck_" + index + "\" name=\"listCheck\">" +
                    //     "    <label class=\"custom-control-label\" for=\"listCheck_" + index + "\"></label>" +
                    //     "</div>";

                    let firstNode = "<div class='text-center'>" +
                                    "    <input type=\"hidden\" name=\"odr_cd\" value=\"" + item.odr_cd + "\">" +
                                    "    <input type=\"hidden\" name=\"ship_cd\" value=\"" + item.ship_cd + "\">" +
                                    "    <input type=\"hidden\" name=\"ship_state\" value=\"" + item.ship_state + "\">" +
                                         IsEmpty(item.odr_cd) +
                                    "</div>";

                    node.push(firstNode);
                    node.push("<div class='text-center'>" + IsEmpty(item.odr_dt) + "</div>");
                    node.push("<div class='text-center'>" + IsEmpty(item.odr_ship_dt) + "</div>");
                    node.push(IsEmpty(item.comp_nm));
                    node.push(IsEmpty(item.prod_pn));
                    node.push(IsEmpty(item.prod_nm));
                    node.push(IsEmpty(item.prod_stand));
                    node.push("<div class='text-right'>" + IsEmpty(item.odr_cnt.comma('2')) + " " + IsEmpty(item.prod_unit_nm) + "</div>");
                    node.push("<div class='text-right'>" + IsEmpty(item.ship_cnt.comma('2')) + " " + IsEmpty(item.prod_unit_nm) + "</div>");
                    node.push("<div class='text-center red'>" + IsEmpty(item.ship_state_nm) + "</div>");

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

    function getDataOne(odr_cd, ship_cd)
    {
        showWait('.dataModal');

        $.ajax({
            url: "/mes/sales/shipment/shipOne/" + odr_cd + "/" + ship_cd
            ,type: "get"
            ,dataType: "json"
            // ,data: JSON.stringify({})
        })
        .done(function (data)
        {
            setDataOne("pop_", data);
            $("#dataForm").find(".key").prop("disabled", true);

            $("#pop_selector").text('[' + data.comp_cd + '] ' + data.comp_nm);
            $("#pop_selector2").text('[' + data.prod_pn + '] ' + data.prod_nm);

            getShipmentDetailData();
        })
        .always(function (data) {
            hideWait('.dataModal');
        })
        .fail(function (jqHXR, textStatus, errorThrown) {
            ajaxErrorAlert(jqHXR);
        });
    }

    function getShipmentDetailData()
    {
        showWait('.dataModal');

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
                ,odr_cd: $("#pop_odr_cd").val()
                ,ship_cd: $("#pop_ship_cd").val()
                ,isNoDate: "Y"
            })
        })
            .done(function (data)
            {
                $("#tblPopShipmentData > tbody").empty();
                resultRowCnt = 0;

                data.forEach((item, index) => {
                    addPopShipmentDetailRow(item);
                });
            })
            .always(function (data) {
                hideWait('.dataModal');
            })
            .fail(function (jqHXR, textStatus, errorThrown) {
                ajaxErrorAlert(jqHXR);
            });
    }

    // let resultRowCnt = 0;
    function addPopShipmentDetailRow(data)
    {
        let template_html = $("#popSalesShipmentTemplete").html();
        let template = Handlebars.compile(template_html);
        let resultRowCnt = $("#tblPopShipmentData > tbody > tr").length + 1;
        let templateData;

        if(IsNull(data))
        {
            templateData = {
                cnt : resultRowCnt
                ,old_ship_detail_cnt: 0
                ,ship_detail_dt: moment().format("YYYY-MM-DD")
            };

            $("#tblPopShipmentData > tbody").append(template(templateData));
        }
        else
        {
            templateData = {
                cnt : resultRowCnt
                ,ship_detail_cd: data.ship_detail_cd
                ,ship_detail_dt: data.ship_detail_dt
                ,old_ship_detail_cnt: data.ship_detail_cnt
                ,ship_detail_cnt: data.ship_detail_cnt.comma('3')
                ,ship_detail_notice: data.ship_detail_notice
            };

            $("#tblPopShipmentData > tbody").append(template(templateData));

        }

        setDatePicker("datepicker");

        $("#tblPopShipmentData .list_tr" + resultRowCnt)
            .find("input[name$='cnt'], input[name$='price'], input[name$='amt'], input[name$='total'], input[name$='rate'], input[name$='min'], input[name$='vat']")
            .css("text-align", "right")
            .on("click", function() {
                $(this).select();
            })
            .on("keyup", function() {
                $(this).val($(this).val().comma("2"));
            });
    }

    function shipmentDetailRegistModifyData()
    {
        showWait('.dataModal');

        //. Data List
        let ary_ship_detail_cd = [];
        let ary_ship_detail_dt = [];
        let ary_old_ship_detail_cnt = [];
        let ary_ship_detail_cnt = [];
        let ary_ship_detail_notice = [];

        $.each($("#tblPopShipmentData > tbody > tr"), function(index, item)
        {
            ary_ship_detail_cd.push($(item).find("input[name=pop_ship_detail_cd]").val());
            ary_ship_detail_dt.push($(item).find("input[name=pop_ship_detail_dt]").val());
            ary_old_ship_detail_cnt.push($(item).find("input[name=pop_old_ship_detail_cnt]").val().replace(/,/g, ""));
            ary_ship_detail_cnt.push($(item).find("input[name=pop_ship_detail_cnt]").val().replace(/,/g, ""));
            ary_ship_detail_notice.push($(item).find("input[name=pop_ship_detail_notice]").val());
        });

        $.ajax({
            type: "post"
            ,url: "/mes/sales/shipment/salesShipmentDetailRegistModify"
            ,headers: {
                "Content-Type": "application/json"
                ,"X-HTTP-Method-Override": "POST"
            }
            ,dataType: "text"
            ,data: JSON.stringify({
                fact_cd: "${vmap.fact_cd}"
                ,odr_cd: $("#pop_odr_cd").val()
                ,ship_cd: $("#pop_ship_cd").val()
                ,prod_cd: $("#pop_prod_cd").val()
                ,ary_ship_detail_cd: ary_ship_detail_cd
                ,ary_ship_detail_dt: ary_ship_detail_dt
                ,ary_old_ship_detail_cnt: ary_old_ship_detail_cnt
                ,ary_ship_detail_cnt: ary_ship_detail_cnt
                ,ary_ship_detail_notice: ary_ship_detail_notice
            })
        })
        .done(function (data) {
            hideWait('.dataModal');
            getDataOne($("#pop_odr_cd").val(), $("#pop_ship_cd").val());
        })
        .always(function (data) {

        })
        .fail(function (jqHXR, textStatus, errorThrown) {
            ajaxErrorAlert(jqHXR);
            hideWait('.dataModal');
        });
    }


    function salesShipmentDetailDelete(cnt)
    {
        let ship_detail_cd = $("#tblPopShipmentData .list_tr" + cnt).find("[name=pop_ship_detail_cd]").val();
        let ship_detail_cnt = $("#tblPopShipmentData .list_tr" + cnt).find("[name=pop_ship_detail_cnt]").val();

        if(IsNull(ship_detail_cd))
        {
            $("#tblPopShipmentData .list_tr" + cnt).remove();
        }
        else
        {
            Swal.fire({
                title: '',
                text: "납품내역을 삭제하시겠습니까?",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: '확인',
                cancelButtonText: '취소'
            }).then((result) => {
                if (result.isConfirmed)
                {
                    showWait('.dataModal');

                    $.ajax({
                        type: "delete"
                        ,url: "/mes/sales/shipment/salesShipmentDetailDelete"
                        ,headers: {
                            "Content-Type": "application/json"
                            ,"X-HTTP-Method-Override": "DELETE"
                        }
                        ,dataType: "text"
                        ,data: JSON.stringify({
                            odr_cd: $("#pop_odr_cd").val()
                            ,ship_cd: $("#pop_ship_cd").val()
                            ,prod_cd: $("#pop_prod_cd").val()
                            ,ship_detail_cd: ship_detail_cd
                            ,ship_detail_cnt: ship_detail_cnt
                        })
                    })
                    .done(function (data) {
                        hideWait('.dataModal');
                        getDataOne($("#pop_odr_cd").val(), $("#pop_ship_cd").val());
                    })
                    .always(function (data) {

                    })
                    .fail(function (jqHXR, textStatus, errorThrown) {
                        ajaxErrorAlert(jqHXR);
                    });
                }
            });
        }
    }

</script>

<%@ include file="/WEB-INF/include/footer.jspf" %>