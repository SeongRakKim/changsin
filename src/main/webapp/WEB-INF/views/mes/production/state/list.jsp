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
                <td>
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
<%--            <tr>--%>
<%--                <th>검색조건</th>--%>
<%--                <td>--%>
<%--                    <select id="prod_kind" name="prod_kind" class="custom-select w-100" style="width: 15% !important;">--%>
<%--                        <option value="">제품종류선택</option>--%>
<%--                        <option value="PA">완제품</option>--%>
<%--                        <option value="PH">반제품</option>--%>
<%--                    </select>--%>
<%--                    <select id="prod_group" name="prod_group" class="custom-select w-100" style="width: 15% !important;">--%>
<%--                        <option value="">품목분류선택</option>--%>
<%--                        <c:forEach var="item" items="${vmap.prodGroupList}" varStatus="status">--%>
<%--                            <option value="${item.base_detail_cd}">${item.base_detail_nm}</option>--%>
<%--                        </c:forEach>--%>
<%--                    </select>--%>
<%--                    <select id="prod_family" name="prod_family" class="custom-select w-100" style="width: 15% !important;">--%>
<%--                        <option value="">제품군선택</option>--%>
<%--                        <c:forEach var="item" items="${vmap.prodFamilyList}" varStatus="status">--%>
<%--                            <option value="${item.base_detail_cd}">${item.base_detail_nm}</option>--%>
<%--                        </c:forEach>--%>
<%--                    </select>--%>
<%--                </td>--%>
<%--                <th>검색어</th>--%>
<%--                <td>--%>
<%--                    <div class="input-group">--%>
<%--                        <div class="input-group-prepend">--%>
<%--                                <span class="input-group-text">--%>
<%--                                    <i class="fas fa-search"></i>--%>
<%--                                </span>--%>
<%--                        </div>--%>
<%--                        <input id="search_text" name="search_text" class="form-control" placeholder="검색어" type="text">--%>
<%--                    </div>--%>
<%--                </td>--%>
<%--            </tr>--%>
            </thead>
        </table>
    </div>

    <div class="menu-nav">
        <div>
            <span class="btn btn-pill btn-sm btn-primary">
                <i class="fas fa-home"></i> <i class="fas fa-arrow-circle-right"></i> 생산관리 <i class="fas fa-arrow-circle-right"></i> 생산현황
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
<%--                                    <th class="no-sort" style="width: 3%">--%>
<%--                                        <div class="custom-control custom-checkbox">--%>
<%--                                            <input type="checkbox" class="custom-control-input" id="listAll">--%>
<%--                                            <label class="custom-control-label" for="listAll"></label>--%>
<%--                                        </div>--%>
<%--                                    </th>--%>
<%--                                    <th>거래처</th>--%>
<%--                                    <th>수주번호</th>--%>
                                    <th style="width: 14%">계획일</th>
                                    <th style="width: 12%">작업지시번호</th>
                                    <th style="width: 8%">품번</th>
                                    <th style="width: 15%">품목명</th>
<%--                                    <th>종류</th>--%>
<%--                                    <th>분류</th>--%>
<%--                                    <th>제품군</th>--%>
                                    <th>규격</th>
                                    <th style="width: 8%">계획수량</th>
                                    <th style="width: 8%">생산수량</th>
                                    <th>관리</th>
                                    <th style="width: 20%">공정</th>
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

<div class="modal fade dataModal" id="dataModal" tabindex="-1" role="dialog" aria-labelledby="registModal" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-xl modal-form-xl" role="document">
        <div class="modal-content" style="width: 90%;">
            <div class="modal-header">
                <h2 class="modal-title"><i id="form-modal-icon"></i> <span id="form-modal-title"></span></h2>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="dataForm" name="dataForm" class="dataForm" method="post">
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
                                    <input type="hidden" id="pop_plan_cd" name="pop_plan_cd" class="form-control"
                                           placeholder="계획코드" title="계획코드" />
                                    <input type="hidden" id="pop_plan_proc_cd" name="pop_plan_proc_cd" class="form-control"
                                           placeholder="계획공정코드" title="계획공정코드" />
                                    <input type="hidden" id="pop_proc_cd" name="pop_proc_cd" class="form-control"
                                           placeholder="공정코드" title="공정코드" />
                                    <input type="hidden" id="pop_odr_cd" name="pop_odr_cd" class="form-control"
                                           placeholder="수주코드" title="수주코드" />
                                    <input type="hidden" id="pop_plan_proc_last_yn" name="pop_plan_proc_last_yn" class="form-control"
                                           placeholder="마지막공정여부" title="마지막공정여부" />
                                    <input type="hidden" id="pop_plan_proc_state" name="pop_plan_proc_state" class="form-control"
                                           placeholder="공정진행상태" title="공정진행상태" />
                                    <input type="hidden" id="pop_comp_cd" name="pop_comp_cd" class="form-control"
                                           placeholder="거래처" title="거래처" />
                                    <input type="hidden" id="pop_comp_nm" name="pop_comp_nm" class="form-control"
                                           placeholder="거래처" title="거래처" />
                                    <div id="pop_selector" name="pop_selector"></div>
                                </td>
                                <th>생산계획수량</th>
                                <td class="text-right">
                                    <div id="pop_plan_cnt" name="pop_plan_cnt"></div>
                                </td>
                                <th>생간계획일</th>
                                <td>
                                    <div id="pop_plan_dt" name="pop_plan_dt"></div>
                                </td>
                                <th>작업지시번호</th>
                                <td>
                                    <div id="pop_plan_no" name="pop_plan_no"></div>
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
                                <th>생산량</th>
                                <td class="text-right">
                                    <div class="red" id="pop_plan_proc_last_cnt" name="pop_plan_proc_last_cnt"></div>
                                </td>

                            </tr>
                        </tbody>
                    </table>
                </form>


                <div style="height: 400px; overflow: auto;">
                    <table id="tblPopSubData" class="table table-hover table-bordered mb-3 table-form">
                        <colgroup>
                            <col style="width: 8%" />
                            <col style="width: 10%" />
                            <col style="width: 10%" />
                            <col style="width: 10%" />
                            <col style="width: 16%" />
                            <col style="width: 16%" />
                            <col style="width: 10%" />
                            <col style="width: 20%" />
                        </colgroup>
                        <thead>
                        <tr>
                            <th>순서</th>
                            <th>공정</th>
                            <th>설비</th>
                            <th>작업자</th>
                            <th>작업시작일</th>
                            <th>작업종료일</th>
                            <th>생산량</th>
                            <th>비고</th>
                        </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
            </div>

            <div class="modal-footer">
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

<script id="popPlanResultTemplete" type="text/x-handlebars-template">
    <tr class="dataList list_tr{{cnt}}">
        <td style="text-align: center !important;">{{cnt}}</td>
        <td>{{proc_nm}}</td>
        <td>{{equ_nm}}</td>
        <td>{{plan_res_u_nm}}</td>
        <td style="text-align: center !important;">{{plan_res_stdt}}</td>
        <td style="text-align: center !important;">{{plan_res_eddt}}</td>
        <td style="text-align: right !important;">{{plan_res_cnt}}</td>
        <td>{{plan_res_notice}}</td>
    </tr>
</script>

<script id="popPlanProcTemplete" type="text/x-handlebars-template">
    <tr class="dataList list_tr{{cnt}}">
        <td>
            <input type="hidden" name="pop_plan_proc_cd" class="form-control" value="{{plan_proc_cd}}" />
            <input type="hidden" name="pop_proc_cd" class="form-control" value="{{proc_cd}}" />
            {{plan_proc_seq}}
        </td>
        <td>
            {{proc_nm}}
        </td>
        <td>
            <input type="text" name="pop_plan_proc_notice" class="form-control" value="{{plan_proc_notice}}"
                   placeholder="비고" title="비고" />
        </td>
        <td style="text-align: center;">
            <button class="btn btn-sm btn-danger" type="button" onclick="planProcDelete({{cnt}})">
                                        <span class="btn-wrapper--icon">
                                            <i class="fas fa-minus-circle"></i>
                                        </span>
                <span class="btn-wrapper--label">행삭제</span>
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

        // Add Data - Call Data Form
        $("#btnNew").on("click", () => {
            callEditmodal("생산계획 등록", "R");
        });

        // 상세조회
        $("#tblMaster").on("dblclick", "tr", function() { });

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

    function getData()
    {
        showWait('.container-fluid');

        $.ajax({
            url: "/mes/production/state/stateList"
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

                node.push("<div class='text-center'>" + IsEmpty(item.plan_stdt) + " ~ " + IsEmpty(item.plan_eddt) + "</div>");
                node.push(IsEmpty(item.plan_no));
                node.push(IsEmpty(item.prod_pn));
                node.push(IsEmpty(item.prod_nm));
                // node.push(IsEmpty(item.prod_kind_nm));
                // node.push(IsEmpty(item.prod_group_nm));
                // node.push(IsEmpty(item.prod_family_nm));
                node.push(IsEmpty(item.prod_stand));
                node.push("<div class='text-right'>" + IsEmpty(item.plan_cnt.comma('2')) + " " + IsEmpty(item.prod_unit_nm) + "</div>");
                node.push("<div class='text-right'>" + IsEmpty(item.plan_proc_last_cnt.comma('2')) + " " + IsEmpty(item.prod_unit_nm) + "</div>");

                let param = "{"
                    + "plan_cd: '" +  item.plan_cd + "'"
                    + ",prod_cd: '" +  item.prod_cd + "'"
                    + ",prod_pn: '" +  item.prod_pn + "'"
                    + ",prod_nm: '" +  item.prod_nm + "'"
                    + ",prod_kind_nm: '" +  item.prod_kind_nm + "'"
                    + ",prod_stand: '" +  item.prod_stand + "'"
                    + ",prod_unit_nm: '" +  item.prod_unit_nm + "'"
                + "}";

                let manageButton = "<div style='display: flex; flex-wrap: wrap; justify-content: space-around;' >" +
                                    "    <button class=\"btn-sm btn btn-outline-primary\" type=\"button\" onclick=\"getPlanData(" + param + ")\">작업현황</button>" +
                                    "</div>";

                node.push(manageButton);

                let procIngNm = "";
                item.process.forEach((item2, index) => {

                    let color;
                    switch (item2.plan_proc_state) {
                        case "11" :
                            color = "blue"
                            break;
                        case "12" :
                            color = "red"
                            break;
                    }

                    if(Object.is(item.process.length - 1, index)) {
                        procIngNm += "<span class=\"" + color + "\" style='margin-right: 10px;'>" + item2.proc_nm + "</span>";
                    }else {
                        procIngNm += "<span class=\"" + color + "\" style='margin-right: 10px;'>" + item2.proc_nm + "</span>";
                        procIngNm += "<i style='margin-right: 10px;' class=\"fas fa-arrow-circle-right " + color + "\"></i>";
                    }
                });

                node.push("<div class='text-center'>" + procIngNm + "</div>");

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

    function getPlanData()
    {
        $("#dataModal").modal("show");
        showWait('.dataModal');

        $.ajax({
            url: "/mes/production/state/stateOne/" + arguments[0].plan_cd
            ,type: "get"
            ,dataType: "json"
            // ,data: JSON.stringify({})
        })
        .done(function (data)
        {
            setDataOne("pop_", data);
            $("#dataForm").find(".key").prop("disabled", true);
            $("#pop_selector").text('[' + data.comp_cd + ']' + data.comp_nm);
            $("#pop_selector2").text('[' + data.prod_pn + ']' + data.prod_nm);

            getPlanResultData(arguments[0].plan_cd);
        })
        .always(function (data) {
            hideWait('.dataModal');
        })
        .fail(function (jqHXR, textStatus, errorThrown) {
            ajaxErrorAlert(jqHXR);
        });
    }

     function getPlanResultData(plan_cd)
    {
        showWait('.dataModal');

        $.ajax({
            url: "/mes/production/result/planResultList"
            ,type: "post"
            ,headers: {
                "Content-Type": "application/json"
                ,"X-HTTP-Method-Override": "POST"
            }
            ,dataType: "json"
            ,data: JSON.stringify({
                fact_cd: "${vmap.fact_cd}"
                ,plan_cd: plan_cd
                ,isNotDate: "Y"
            })
        })
        .done(function (data)
        {
            $("#tblPopSubData > tbody").empty();

            data.forEach((item, index) => {
                addPopPlanResultRow(item);
            });

        })
        .always(function (data) {
            hideWait('.dataModal');
        })
        .fail(function (jqHXR, textStatus, errorThrown) {
            ajaxErrorAlert(jqHXR);
        });
    }

    // let planRowCnt = 0;
    function addPopPlanResultRow(data)
    {
        let template_html = $("#popPlanResultTemplete").html();
        let template = Handlebars.compile(template_html);
        let planRowCnt = $("#tblPopSubData > tbody > tr").length + 1;

        let templateData = {
            // cnt : rowCnt
            cnt: planRowCnt
            ,proc_nm: data.proc_nm
            ,equ_nm: data.equ_nm
            ,plan_res_u_nm: data.plan_res_u_nm
            ,plan_res_stdt: data.plan_res_stdt
            ,plan_res_eddt: data.plan_res_eddt
            ,plan_res_cnt: data.plan_res_cnt.comma('3')
            ,plan_res_notice: data.plan_res_notice
        }

        $("#tblPopSubData > tbody").append(template(templateData));

        $("#tblPopSubData .list_tr" + planRowCnt)
            .find("input[name$='cnt'], input[name$='price'], input[name$='amt'], input[name$='total'], input[name$='rate'], input[name$='min'], input[name$='vat']")
            .css("text-align", "right")
            .on("click", function() {
                $(this).select();
            })
            .on("keyup", function() {
                $(this).val($(this).val().comma("2"));
            });

    }



</script>

<%@ include file="/WEB-INF/include/footer.jspf" %>