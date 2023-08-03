<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tablet-header2.jspf" %>

<style></style>

<div class="container-fluid">
    <div class="main-content">
        <table class="tableSearch table table-hover table-striped table-bordered mb-5 border-left-secondary"
               style="margin-bottom: 0.5rem !important;">
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
<%--                            <select id="date_type" name="date_type" class="custom-select w-10 vw-10 mr-1">--%>
<%--                            </select>--%>
                            <%@ include file="/WEB-INF/include/tablet-main-search-date-content.jspf"%>
                        </div>
                    </td>
                </tr>
            </thead>
        </table>
    </div>

    <div id="tblList" class="card tablet-main-card" ></div>
</div>

<script id="purchaseListTemplate" type="text/x-handlebars-template">
    <div class="card-body card-list-body list_div{{cnt}}">
        <div class="card-border">
            <div class="sub-card-state bg-gradient-primary">{{plan_state_nm}}</div>
            <div class="sub-card-table">
                <table class="table tableSearch table-bordered mb-5">
                    <colgroup>
                        <col style="width: 13%">
                        <col style="width: 23%">
                        <col style="width: 13%">
                        <col style="width: 19%">
                        <col style="width: 13%">
                        <col style="width: 19%">
                    </colgroup>
                    <thead>
                    <tr>
                        <th>거래처</th>
                        <td>
                            <input type="hidden" name="frm_plan_cd" class="form-control" value="{{plan_cd}}" />
                            <input type="hidden" name="frm_prod_cd" class="form-control" value="{{prod_cd}}" />
                            <input type="hidden" name="frm_prod_pn" class="form-control" value="{{prod_pn}}" />
                            <input type="hidden" name="frm_prod_nm" class="form-control" value="{{prod_nm}}" />
                            <input type="hidden" name="frm_prod_kind_nm" class="form-control" value="{{prod_kind_nm}}" />
                            <input type="hidden" name="frm_prod_stand" class="form-control" value="{{prod_stand}}" />
                            <input type="hidden" name="frm_prod_unit_nm" class="form-control" value="{{prod_unit_nm}}" />
                            <input type="hidden" name="frm_prod_lot_yn" class="form-control" value="{{prod_lot_yn}}" />
                            {{comp_nm}}
                        </td>
                        <th>품번</th>
                        <td>{{prod_pn}}</td>
                        <th>규격</th>
                        <td>{{prod_stand}}</td>
                    </tr>
                    <tr>
                        <th>품명</th>
                        <td>{{prod_nm}}</td>
                        <th>수주번호</th>
                        <td>{{odr_cd}}</td>
                        <th>수량</th>
                        <td>{{pur_cnt}}{{prod_unit_nm}}</td>
                    </tr>
                    </thead>
                </table>
            </div>
            <div class="sub-card-detail">
<%--                <i class="fas fa-plus-square" onclick="setPurchaseInModify({{cnt}})"></i>--%>
                <button class="btn btn-ready btn-sm btn-first tablet-list-btn-full" type="button" onclick="setPurchaseInModify({{cnt}})">생산</button>
                <button class="btn btn-complete btn-sm btn-info tablet-list-btn-full" type="button" disabled style="display: none;">완료</button>
            </div>
        </div>
    </div>
</script>

<script>
    $(document).ready(() => {
        $("#tablet-top-title").text("생산 > 생산보고");
        setTimeout(() => getData(), 50);
    });

    function getData()
    {
        showWait('.container-fluid');

        $.ajax({
            url: "/mes/production/plan/planList"
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
                ,search_text: $("#search_text").val()
            })
        })
        .done(function (data)
        {
            $("#tblMaster").DataTable().clear();

            if(IsNotNull(data)) {
                $("#tblList").empty();
                data.forEach((item, index) => {
                    addGetDataList(item);
                });
            }
        })
        .always(function (data) {
            hideWait('.container-fluid');
        })
        .fail(function (jqHXR, textStatus, errorThrown) {
            ajaxErrorAlert(jqHXR);
        });
    }

    let rowCnt = 0;
    function addGetDataList(item)
    {
        let template_html = $("#purchaseListTemplate").html();
        let template = Handlebars.compile(template_html);

        let templateData = {
            ...item
            ,cnt: ++rowCnt
            ,plan_cnt: item.plan_cnt.comma('2')
        }

        $("#tblList").append(template(templateData));

        if(item.plan_state === "12") {
            $("#tblList .list_div" + rowCnt + " .btn-complete").toggle();
            $("#tblList .list_div" + rowCnt + " .btn-ready").toggle();

            $("#tblList .list_div" + rowCnt + " .sub-card-state").addClass("bg-gradient-info");
            $("#tblList .list_div" + rowCnt + " .sub-card-state").removeClass("bg-gradient-primary");
        }
    }

    function setPurchaseInModify(cnt)
    {
        let pur_cd = $("#tblList .list_div" + cnt).find("[name=frm_pur_cd]").val();
        let pur_cnt = $("#tblList .list_div" + cnt).find("[name=frm_pur_cnt]").val();
        let prod_cd = $("#tblList .list_div" + cnt).find("[name=frm_prod_cd]").val();
        let prod_lot_yn = $("#tblList .list_div" + cnt).find("[name=frm_prod_lot_yn]").val();

        Swal.fire({
            title: '',
            text: "입고처리 하시겠습니까?",
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
                    ,url: "/mes/material/purchase/purchaseInModify"
                    ,headers: {
                        "Content-Type": "application/json"
                        ,"X-HTTP-Method-Override": "POST"
                    }
                    ,dataType: "text"
                    ,data: JSON.stringify({
                        fact_cd: "${vmap.fact_cd}"
                        ,pur_cd
                        ,pur_cnt: pur_cnt.replace(/,/g, "")
                        ,prod_cd
                        ,prod_lot_yn
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

<%@ include file="/WEB-INF/include/tablet-footer.jspf" %>

