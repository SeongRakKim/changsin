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
                            <select id="date_type" name="date_type" class="custom-select w-10 vw-10 mr-1">
                                <option value="ODR_DT">수주일</option>
                                <option value="ODR_SHIP_DT">납기요청일</option>
                            </select>
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
            <div class="sub-card-state bg-gradient-primary">{{ship_state_nm}}</div>
            <div class="sub-card-table">
                <table class="table tableSearch table-bordered mb-5">
                    <colgroup>
                        <col style="width: 11%">
                        <col style="width: 23%">
                        <col style="width: 11%">
                        <col style="width: 19%">
                        <col style="width: 17%">
                        <col style="width: 19%">
                    </colgroup>
                    <thead>
                    <tr>
                        <th>거래처</th>
                        <td>
                            <input type="hidden" name="frm_ship_cd" class="form-control" value="{{ship_cd}}" />
                            <input type="hidden" name="frm_odr_cd" class="form-control" value="{{odr_cd}}" />
                            <input type="hidden" name="frm_ship_cnt" class="form-control" value="{{ship_cnt}}" />
                            <input type="hidden" name="frm_prod_cd" class="form-control" value="{{prod_cd}}" />
                            <input type="hidden" name="frm_prod_pn" class="form-control" value="{{prod_pn}}" />
                            <input type="hidden" name="frm_prod_nm" class="form-control" value="{{prod_nm}}" />
                            <input type="hidden" name="frm_prod_kind_nm" class="form-control" value="{{prod_kind_nm}}" />
                            <input type="hidden" name="frm_prod_stand" class="form-control" value="{{prod_stand}}" />
                            <input type="hidden" name="frm_prod_unit_nm" class="form-control" value="{{prod_unit_nm}}" />
                            <input type="hidden" name="frm_prod_lot_yn" class="form-control" value="{{prod_lot_yn}}" />
                            {{comp_nm}}
                        </td>
                        <th>수주일</th>
                        <td>{{odr_dt}}</td>
                        <th>납기요청일</th>
                        <td>{{odr_ship_dt}}</td>
                    </tr>
                    <tr>
                        <th>품명</th>
                        <td>{{prod_nm}}</td>
                        <th>규격</th>
                        <td>{{prod_stand}}</td>
                        <th>수량</th>
                        <td>{{ship_cnt}}{{prod_unit_nm}}</td>
                    </tr>
                    </thead>
                </table>
            </div>
            <div class="sub-card-detail">
                <button class="btn btn-ready btn-sm btn-first tablet-list-btn-full" type="button" onclick="setShipModify({{cnt}})">출고</button>
                <button class="btn btn-complete btn-sm btn-success tablet-list-btn-full" type="button" disabled style="display: none;">완료</button>
            </div>
        </div>
    </div>
</script>

<script>
    $(document).ready(() => {
        $("#tablet-top-title").text("물류 > 제품출고");
        setTimeout(() => getData(), 50);
    });

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
            // cnt : rowCnt
            cnt: ++rowCnt
            ,...item
            ,odr_cnt: item.odr_cnt.comma('2')
            ,ship_cnt: item.ship_cnt.comma('2')
        }

        $("#tblList").append(template(templateData));

        if(item.ship_state === "22") {
            $("#tblList .list_div" + rowCnt + " .btn-complete").toggle();
            $("#tblList .list_div" + rowCnt + " .btn-ready").toggle();
        }
    }

    function setShipModify(cnt)
    {
        let ship_cd = $("#tblList .list_div" + cnt).find("[name=frm_ship_cd]").val();
        let odr_cd = $("#tblList .list_div" + cnt).find("[name=frm_odr_cd]").val();

        let url = "/tablet/ship/result?";
        let param = "ship_cd="+ship_cd+"&odr_cd="+odr_cd;

        location.href = url+param;
    }
</script>

<%@ include file="/WEB-INF/include/tablet-footer.jspf" %>

