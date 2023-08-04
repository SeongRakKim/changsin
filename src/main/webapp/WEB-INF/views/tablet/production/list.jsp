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
                        <div style="display: flex; justify-content: space-between">
                            <%@ include file="/WEB-INF/include/tablet-main-search-date-content.jspf"%>
                            <select id="mes_state" name="mes_state" class="custom-select w-10 vw-10 mr-1">
                                <option value="">전체</option>
                                <option value="10">생산대기</option>
                                <option value="11">생산중</option>
                                <option value="12">생산완료</option>
                                <option value="13">생산중단</option>
                            </select>
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
            <div class="sub-card-state bg-gradient-primary">{{plan_proc_state_nm}}</div>
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
                            <input type="hidden" name="frm_plan_no" class="form-control" value="{{plan_no}}" />
                            <input type="hidden" name="frm_plan_proc_cd" class="form-control" value="{{plan_proc_cd}}" />
                            <input type="hidden" name="frm_prod_cd" class="form-control" value="{{prod_cd}}" />
                            <input type="hidden" name="frm_prod_pn" class="form-control" value="{{prod_pn}}" />
                            <input type="hidden" name="frm_prod_nm" class="form-control" value="{{prod_nm}}" />
                            <input type="hidden" name="frm_prod_kind_nm" class="form-control" value="{{prod_kind_nm}}" />
                            <input type="hidden" name="frm_prod_stand" class="form-control" value="{{prod_stand}}" />
                            <input type="hidden" name="frm_prod_unit_nm" class="form-control" value="{{prod_unit_nm}}" />
                            <input type="hidden" name="frm_prod_lot_yn" class="form-control" value="{{prod_lot_yn}}" />
                            {{comp_nm}}
                        </td>
                        <th>품명</th>
                        <td>{{prod_nm}}</td>
<%--                        <th>품번</th>--%>
<%--                        <td>{{prod_pn}}</td>--%>
                        <th>규격</th>
                        <td>{{prod_stand}}</td>
                    </tr>
                    <tr>
                        <th>계획일</th>
                        <td>{{plan_stdt}}</td>
                        <th>계획수량</th>
                        <td>{{plan_cnt}}{{prod_unit_nm}}</td>
                        <th>생산수량</th>
                        <td>{{plan_proc_cnt}}{{prod_unit_nm}}</td>
                    </tr>
                    </thead>
                </table>
            </div>
            <div class="sub-card-detail">
<%--                <i class="fas fa-plus-square" onclick="goProductionResultModify({{cnt}})"></i>--%>
                <button class="btn btn-ready btn-sm btn-first tablet-list-btn-full" type="button" onclick="goProductionResultModify({{cnt}})">생산</button>
                <button class="btn btn-complete btn-sm btn-info tablet-list-btn-full" type="button" disabled style="display: none;">완료</button>
            </div>
        </div>
    </div>
</script>

<script>
    $(document).ready(() => {
        let proc_nm = "${vmap.proc_cd}" === "PROC2" ? "프레스" : ("${vmap.proc_cd}" === "PROC3" ? "절단" : "하부용접");
        $("#tablet-top-title").text("생산 > 생산보고(" + proc_nm + ")");
        $("#mes_state").on("change", () => { getData() });
        setTimeout(() => getData(), 50);
    });

    function getData()
    {
        showWait('.container-fluid');

        $.ajax({
            url: "/mes/production/result/planProcessList"
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
                ,proc_cd: "${vmap.proc_cd}"
                ,mes_state: $("#mes_state").val()
            })
        })
        .done(function (data)
        {
            $("#tblList").empty();
            if(IsNotNull(data)) {
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

        if(item.plan_proc_state === "12") {
            $("#tblList .list_div" + rowCnt + " .btn-complete").toggle();
            $("#tblList .list_div" + rowCnt + " .btn-ready").toggle();

            $("#tblList .list_div" + rowCnt + " .sub-card-state").addClass("bg-gradient-info");
            $("#tblList .list_div" + rowCnt + " .sub-card-state").removeClass("bg-gradient-primary");
        }
    }

    function goProductionResultModify(cnt)
    {
        const plan_cd = $("#tblList .list_div" + cnt).find("[name=frm_plan_cd]").val();
        let plan_proc_cd = $("#tblList .list_div" + cnt).find("[name=frm_plan_proc_cd]").val();
        let plan_no = $("#tblList .list_div" + cnt).find("[name=frm_plan_no]").val();

        let url = "/tablet/production/result?";
        let param = "plan_cd="+plan_cd+"&plan_proc_cd="+plan_proc_cd+"&plan_no="+plan_no;

        location.href = url+param;
    }

</script>

<%@ include file="/WEB-INF/include/tablet-footer.jspf" %>

