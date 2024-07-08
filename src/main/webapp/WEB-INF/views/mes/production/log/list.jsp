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
                <i class="fas fa-home"></i> <i class="fas fa-arrow-circle-right"></i> 생산관리 <i class="fas fa-arrow-circle-right"></i> 생산이력
            </span>
        </div>

        <%@ include file="/WEB-INF/include/main-top-right.jspf"%>
    </div>

    <%@ include file="/WEB-INF/include/main-progress.jspf"%>

    <div class="card shadow" style="min-height: 540px;">
        <div class="card-body">
            <div class="table-responsive">

                <table id ="tblState" class="table table-hover table-bordered mb-3 table-form" style="width: 100%">
                    <thead>
                        <tr>
                            <th>날짜(월)</th>
                            <th>근무일수</th>
                            <th>월생산량</th>
                            <th>1일생산량</th>
                            <th>시간당생산량</th>
                            <th>월총납기소요일</th>
                            <th>월평균납기일</th>
                        </tr>
                    </thead>
                    <tbody style="text-align: center;">
                        <tr>
                            <td>2024-05</td>
                            <td>23</td>
                            <td>5,114</td>
                            <td>222</td>
                            <td>28</td>
                            <td>276</td>
                            <td>12</td>
                        </tr>
                        <tr>
                            <td>2024-06</td>
                            <td>20</td>
                            <td>4,432</td>
                            <td>221</td>
                            <td>27</td>
                            <td>200</td>
                            <td>10</td>
                        </tr>
                        <tr>
                            <td>2024-07</td>
                            <td>9</td>
                            <td>2,010</td>
                            <td>223</td>
                            <td>27</td>
                            <td>99</td>
                            <td>11</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
                    <div class="row">
                        <div class="col-sm-12">
                            <table id ="tblMaster" class="table-list table table-hover table-striped table-bordered mb-5" style="width: 100%">
                                <thead>
                                <tr role="row">
                                    <th>작업지시번호</th>
                                    <th style="width: 8%">품번</th>
                                    <th style="width: 15%">품목명</th>
                                    <th>종류</th>
                                    <th>분류</th>
                                    <th>제품군</th>
                                    <th>규격</th>
                                    <th>공정</th>
                                    <th>설비</th>
                                    <th>작업자</th>
                                    <th>생산시작시간</th>
                                    <th>생산종료시간</th>
                                    <th>생산량</th>
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

<script id="popPlanStateTemplete" type="text/x-handlebars-template">
    <tr class="dataList list_tr{{cnt}}">
        <td style="text-align: center !important;">
            {{ym}}
        </td>
        <td style="text-align: center !important;">
            {{work_day}}
        </td>
        <td style="text-align: center !important;">
            {{mon_cnt}}
        </td>
        <td style="text-align: center !important;">
            {{day_cnt}}
        </td>
        <td style="text-align: center !important;">
            {{hour_cnt}}
        </td>
        <td style="text-align: center !important;">
            {{qual_cnt}}
        </td>
        <td style="text-align: center !important;">
            {{qual_mon_cnt}}%
        </td>
    </tr>
</script>

<script>

    $(document).ready(() => {
        // DataTables setting
        setDatatable();

        $("#prod_kind, #prod_family, #prod_group").on("change", () => { getData() });

        // 조회
        $("#btnSearch").on("click", () => { getData()});
        // $("#btnSearch").on("click", () => { getData(), getData2() });

        setTimeout(() => getData(), 30);
        // setTimeout(() => getData2(), 30);

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
            ,scrollY: 440
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
            url: "/mes/production/result/planResultList"
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

                    node.push(IsEmpty(item.plan_no));
                    node.push(IsEmpty(item.prod_pn));
                    node.push(IsEmpty(item.prod_nm));
                    node.push(IsEmpty(item.prod_kind_nm));
                    node.push(IsEmpty(item.prod_group_nm));
                    node.push(IsEmpty(item.prod_family_nm));
                    node.push(IsEmpty(item.prod_stand));
                    node.push(IsEmpty(item.proc_nm));
                    node.push(IsEmpty(item.equ_nm));
                    node.push(IsEmpty(item.plan_res_u_nm));
                    node.push("<div class='text-center'>" + IsEmpty(item.plan_res_stdt) + "</div>");
                    node.push("<div class='text-center'>" + IsEmpty(item.plan_res_eddt) + "</div>");
                    node.push("<div class='text-right'>" + IsEmpty(item.plan_res_cnt.comma('2')) + " " + IsEmpty(item.prod_unit_nm) + "</div>");

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

    function getData2()
    {
        // showWait('.inputModal');

        $.ajax({
            url: "/mes/production/result/planMonStateList"
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
            $("#tblState > tbody").empty();
            inputRowCnt = 0;

            data.forEach((item, index) => {
                addStateRow(item);
            });

        })
        .always(function (data) {
            // hideWait('.inputModal');
        })
        .fail(function (jqHXR, textStatus, errorThrown) {
            ajaxErrorAlert(jqHXR);
        });
    }

    function addStateRow(data)
    {
        let template_html = $("#popPlanStateTemplete").html();
        let template = Handlebars.compile(template_html);
        let planRowCnt = $("#tblState > tbody > tr").length + 1;

        let templateData = {
            cnt: planRowCnt
            ,ym: data.ym
            ,work_day: data.work_day
            ,mon_cnt: data.mon_cnt.comma()
            ,day_cnt: data.day_cnt.comma()
            ,hour_cnt: data.hour_cnt.comma()
            ,qual_cnt: data.qual_cnt
            ,qual_mon_cnt: data.qual_mon_cnt
        }

        $("#tblState > tbody").append(template(templateData));
    }


</script>

<%@ include file="/WEB-INF/include/footer.jspf" %>