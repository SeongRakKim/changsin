<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tablet-header2.jspf" %>

<style>
    #planTableList thead tr th {
        font-size: 1em;
        height: 6vh;
    }
    #planTableList {
        height: 55vh;
     }
</style>

<div class="container-fluid">
    <div id="dataOneDiv" class="main-content"></div>
    <div>
        <div id="tblList" class="card tablet-main-card2" ></div>
        <div id="tblList2" class="card tablet-main-card" ></div>
    </div>
</div>

<script id="mainListTemplate" type="text/x-handlebars-template">
    <table id="mainDataOne" class="tableSearch table table-hover table-striped table-bordered mb-5 order-bottom-success"
           style="margin-bottom: 0.5rem !important;">
        <colgroup>
            <col style="width: 10%">
            <col style="width: 25%">
            <col style="width: 10%">
            <col style="width: 25%">
            <col style="width: 10%">
            <col style="width: 20%">
        </colgroup>
        <thead class="thead-light">
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
                    {{comp_nm}}
                </td>
                <th>생산지시일</th>
                <td>{{plan_proc_indate}}</td>
                <th>공정</th>
                <td>{{proc_nm}}</td>
            </tr>
            <tr>
                <th>품명</th>
                <td>
                    <input type="hidden" id="pop_prod_cd" name="pop_prod_cd" class="form-control"
                           placeholder="제품코드" title="제품코드" />
                    <input type="hidden" id="pop_prod_nm" name="pop_prod_nm" class="form-control"
                           placeholder="제품명" title="제품명" />
                    <input type="hidden" id="pop_prod_pn" name="pop_prod_pn" class="form-control"
                           placeholder="제품품번" title="제품코드" />
                    <input type="hidden" id="pop_prod_lot_yn" name="pop_prod_lot_yn" class="form-control" />
                    {{prod_nm}}
                </td>
                <th>규격</th>
                <td>{{prod_stand}}</td>
                <th>지시수량</th>
                <td>
                    <div id="pop_plan_cnt" name="pop_plan_cnt"></div>
                    {{plan_cnt}}
                </td>
            </tr>
        </thead>
    </table>
</script>

<script id="planProcTemplate" type="text/x-handlebars-template">
    <div class="card-body main-card-list-body">
        <div class="card-border">
            <div class="sub-card-table">
                <table id="planTableList" class="table tableSearch table-bordered mb-5 tablet-proc-main-table">
                    <colgroup>
                        <col style="width: 30%">
                        <col style="width: 70%">
                    </colgroup>
                    <thead>
                        <tr>
                            <th>설비<span class="red"> (*)</span></th>
                            <td>
                                <select name="pop_equ_cd" class="custom-select w-100" style="width: 100% !important;">
                                    <option value="">설비선택</option>
                                    <c:forEach var="item" items="${vmap.equList}" varStatus="status">
                                        <option value="${item.equ_cd}">${item.equ_nm}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th>작업자 <span class="red"> (*)</span></th>
                            <td>
                                <select name="pop_plan_res_u_cd" class="custom-select w-100" style="width: 100% !important;" required>
                                    <option value="">사용자선택</option>
                                    <c:forEach var="item" items="${vmap.userList}" varStatus="status">
                                        <option value="${item.u_cd}">${item.u_nm}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th>작업시작일 <span class="red"> (*)</span></th>
                            <td style="text-align: center;">
                                <input type="text" name="pop_plan_res_stdt" class="form-control datetimepicker" value="{{plan_res_stdt}}"
                                       placeholder="생산시작일시" title="생산시작일시" required />
                            </td>
                        </tr>
                        <tr>
                            <th>작업종료일 <span class="red"> (*)</span></th>
                            <td style="text-align: center;">
                                <input type="text" name="pop_plan_res_eddt" class="form-control datetimepicker" value="{{plan_res_eddt}}"
                                       placeholder="생산종료일시" title="생산종료일시" required />
                            </td>
                        </tr>
                        <tr>
                            <th>생산량 <span class="red"> (*)</span></th>
                            <td>
                                <input type="hidden" name="pop_old_plan_res_cnt" class="form-control" value="{{old_plan_res_cnt}}"
                                       placeholder="이전생산량" title="이전생산량" required />
                                <input type="text" name="pop_plan_res_cnt" class="form-control" value="{{plan_res_cnt}}"
                                       placeholder="생산량" title="생산량" required />
                            </td>
                        </tr>
                        <tr>
                            <th>Lot.No</th>
                            <td>
                                <input type="text" name="pop_lot_no" class="form-control" value="{{lot_no}}" readonly="readonly"
                                       placeholder="Lot.No" title="Lot.No" />
                            </td>
                        </tr>
                    </thead>
                </table>
            </div>
        </div>
    </div>
</script>

<script id="planProcListTemplate" type="text/x-handlebars-template">
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
<%--                <i class="fas fa-plus-square" onclick="setPurchaseInModify({{cnt}})"></i>--%>
                <button class="btn btn-ready btn-sm btn-first tablet-list-btn-full" type="button" onclick="setPurchaseInModify({{cnt}})">생산</button>
                <button class="btn btn-complete btn-sm btn-info tablet-list-btn-full" type="button" disabled style="display: none;">완료</button>
            </div>
        </div>
    </div>
</script>

<script>
    $(document).ready(() => {
        $("#tablet-top-title").text("생산실적등록");
        // setTimeout(() => getData(), 50);
        setTimeout(() => setResultTemplate(), 50);
        getDataOne("${vmap.plan_cd}", "${vmap.plan_proc_cd}");
    });

    function getDataOne(plan_cd, plan_proc_cd)
    {
        $.ajax({
            url: "/mes/production/result/planProcessOne/" + plan_cd + "/" + plan_proc_cd
            ,type: "get"
            ,dataType: "json"
            // ,data: JSON.stringify({})
        })
        .done(function (data)
        {
            addDataOne(data);
        })
        .always(function (data) {
            hideWait('.dataModal');
        })
        .fail(function (jqHXR, textStatus, errorThrown) {
            ajaxErrorAlert(jqHXR);
        });
    }

    // 지시정보
    let mainRowCnt = 0;
    function addDataOne(item)
    {
        let template_html = $("#mainListTemplate").html();
        let template = Handlebars.compile(template_html);

        let templateData = {
            ...item
            ,cnt: ++mainRowCnt
            ,plan_cnt: item.plan_cnt.comma('2')
        }

        $("#dataOneDiv").append(template(templateData));
    }

    // 실적 입력 template
    function setResultTemplate()
    {
        let template_html = $("#planProcTemplate").html();
        let template = Handlebars.compile(template_html);


        $("#tblList").append(template());
    }

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
        let template_html = $("#planProcTemplate").html();
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

