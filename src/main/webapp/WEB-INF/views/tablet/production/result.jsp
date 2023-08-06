<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tablet-header2.jspf" %>

<style>
    #planTableList thead tr th, #planTableList thead tr td {
        font-size: 1.2em;
        height: 7vh;
    }
    #planTableList {
        height: 52vh;
     }

    .tablet-list-btn-full {
        font-size: 1.15rem;
    }

    .result-button-box {
        display: flex;
        flex-wrap: nowrap;
        flex-direction: row;
        justify-content: space-evenly;
        align-items: center;
    }
</style>

<div class="container-fluid">
    <div id="dataOneDiv" class="main-content"></div>
    <div style="display: flex; flex-wrap: nowrap; flex-direction: row; justify-content: center; align-items: center;">
        <div id="tblList" class="card tablet-main-card2" ></div>
        <div id="tblList2" class="card tablet-main-card3" style="padding: 0.75rem;">
            <table id="tblPopResultData" class="tableSearch table table-hover table-striped table-bordered mb-5 order-bottom-success">
                <colgroup>
                    <col style="width: 6%" />
                    <col style="width: 10%" />
                    <col style="width: 10%" />
                    <col style="width: 10%" />
                    <col style="width: 10%" />
                    <col style="width: 8%" />
                    <col style="width: 12%" />
<%--                    <col style="width: 24%" />--%>
                </colgroup>
                <thead>
                <tr>
                    <th>순서</th>
                    <th>설비</th>
                    <th>작업자 </th>
                    <th>작업시작일 </th>
                    <th>작업종료일 </th>
                    <th>생산량 </th>
                    <th>Lot.No</th>
<%--                    <th>비고</th>--%>
<%--                    <th>--%>
<%--                        <button type="button" id="btnAddSubList" class="btn btn-primary btn-sm">--%>
<%--                            <span class="btn-wrapper--icon">--%>
<%--                                <i class="fas fa-angle-double-down"></i>--%>
<%--                            </span>--%>
<%--                            <span class="btn-wrapper--label">추가</span>--%>
<%--                        </button>--%>
<%--                    </th>--%>
                </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
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
                    <input type="hidden" id="frm_plan_cd" name="frm_plan_cd" class="form-control" value="{{plan_cd}}"
                           placeholder="계획코드" title="계획코드" />
                    <input type="hidden" id="frm_plan_proc_cd" name="frm_plan_proc_cd" class="form-control" value="{{plan_proc_cd}}"
                           placeholder="계획공정코드" title="계획공정코드" />
                    <input type="hidden" id="frm_proc_cd" name="frm_proc_cd" class="form-control" value="{{proc_cd}}"
                           placeholder="공정코드" title="공정코드" />
                    <input type="hidden" id="frm_odr_cd" name="frm_odr_cd" class="form-control" value="{{odr_cd}}"
                           placeholder="수주코드" title="수주코드" />
                    <input type="hidden" id="frm_plan_proc_last_yn" name="frm_plan_proc_last_yn" class="form-control" value="{{plan_proc_last_yn}}"
                           placeholder="마지막공정여부" title="마지막공정여부" />
                    <input type="hidden" id="frm_plan_proc_state" name="frm_plan_proc_state" class="form-control" value="{{plan_proc_state}}"
                           placeholder="공정진행상태" title="공정진행상태" />
                    <input type="hidden" id="frm_comp_cd" name="frm_comp_cd" class="form-control" value="{{comp_cd}}"
                           placeholder="거래처" title="거래처" />
                    <input type="hidden" id="frm_comp_nm" name="frm_comp_nm" class="form-control" value="{{comp_nm}}"
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
                    <input type="hidden" id="frm_prod_cd" name="frm_prod_cd" class="form-control" value="{{prod_cd}}"
                           placeholder="제품코드" title="제품코드" />
                    <input type="hidden" id="frm_prod_nm" name="frm_prod_nm" class="form-control" value="{{prod_nm}}"
                           placeholder="제품명" title="제품명" />
                    <input type="hidden" id="frm_prod_pn" name="frm_prod_pn" class="form-control" value="{{prod_pn}}"
                           placeholder="제품품번" title="제품코드" />
                    <input type="hidden" id="frm_prod_lot_yn" name="frm_prod_lot_yn" class="form-control" value="{{prod_lot_yn}}" />
                    {{prod_nm}}
                </td>
                <th>규격</th>
                <td>{{prod_stand}}</td>
                <th>지시수량</th>
                <td>
                    <div id="frm_plan_cnt" name="frm_plan_cnt"></div>
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
                <table id="planTableList" class="table tableSearch table-bordered mb-2 tablet-proc-main-table">
                    <colgroup>
                        <col style="width: 30%">
                        <col style="width: 70%">
                    </colgroup>
                    <thead>
                        <tr>
                            <th>설비<span class="red"> (*)</span></th>
                            <td>
                                <input type="hidden" id="frm_plan_res_cd" name="frm_plan_res_cd" class="form-control" value="{{plan_res_cd}}" />
                                <select id="frm_equ_cd" name="frm_equ_cd" class="custom-select w-100" style="width: 100% !important;">
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
                                <select id="frm_plan_res_u_cd" name="frm_plan_res_u_cd" class="custom-select w-100" style="width: 100% !important;" required>
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
                                <input type="text" id="frm_plan_res_stdt" name="frm_plan_res_stdt" class="form-control datetimepicker" value="{{plan_res_stdt}}"
                                       placeholder="생산시작일시" title="생산시작일시" required />
                            </td>
                        </tr>
                        <tr>
                            <th>작업종료일 <span class="red"> (*)</span></th>
                            <td style="text-align: center;">
                                <input type="text" id="frm_plan_res_eddt" name="frm_plan_res_eddt" class="form-control datetimepicker" value="{{plan_res_eddt}}"
                                       placeholder="생산종료일시" title="생산종료일시" required />
                            </td>
                        </tr>
                        <tr>
                            <th>생산량 <span class="red"> (*)</span></th>
                            <td>
                                <input type="hidden" id="frm_old_plan_res_cnt" name="frm_old_plan_res_cnt" class="form-control" value="{{old_plan_res_cnt}}"
                                       placeholder="이전생산량" title="이전생산량" required />
                                <input type="text" id="frm_plan_res_cnt" name="frm_plan_res_cnt" class="form-control" value="{{plan_res_cnt}}"
                                       placeholder="생산량" title="생산량" required />
                            </td>
                        </tr>
                        <tr>
                            <th>Lot.No</th>
                            <td>
                                <input type="text" id="frm_lot_no" name="frm_lot_no" class="form-control" value="{{lot_no}}" readonly="readonly"
                                       placeholder="Lot.No" title="Lot.No" />
                            </td>
                        </tr>
                    </thead>
                </table>
                <div class="result-button-box">
                    <button class="btn btn-sm btn-first tablet-list-btn-full result-main-button result-btn-regist" onclick="planResultRegist();">저장</button>
                    <button class="btn btn-sm btn-warning tablet-list-btn-full result-main-button result-btn-modify" style="display: none;" onclick="planResultModify();">수정</button>
                    <button class="btn btn-sm btn-info tablet-list-btn-full result-main-button">투입자재</button>
                    <button class="btn btn-sm btn-dark tablet-list-btn-full result-main-button">비가동</button>
                </div>
                <div style="margin-top: 5px;">
                    <button class="btn btn-sm btn-danger tablet-list-btn-full result-main-button result-btn-new" style="width: 100%" onclick="planResultInit();">신규</button>
                </div>
            </div>
        </div>
    </div>
</script>

<script id="planProcListTemplate" type="text/x-handlebars-template">
    <tr class="dataList list_tr{{cnt}}">
        <td style="text-align: center !important;">
            <input type="hidden" name="pop_plan_res_cd" class="form-control" value="{{plan_res_cd}}" />
            {{cnt}}
        </td>
        <td style="text-align: center !important;">
            <input type="hidden" name="pop_equ_cd" class="form-control" value="{{equ_cd}}" />
            {{equ_nm}}
        </td>
        <td style="text-align: center !important;">
            <input type="hidden" name="pop_plan_res_u_cd" class="form-control" value="{{plan_res_u_cd}}" />
            {{plan_res_u_nm}}
        </td>
        <td style="text-align: center !important;">
            <input type="hidden" name="pop_plan_res_stdt" class="form-control" value="{{plan_res_stdt}}" />
            {{plan_res_stdt}}
        </td>
        <td style="text-align: center !important;">
            <input type="hidden" name="pop_plan_res_eddt" class="form-control" value="{{plan_res_eddt}}" />
            {{plan_res_eddt}}
        </td>
        <td style="text-align: center !important;">
            <input type="hidden" name="pop_plan_res_cnt" class="form-control" value="{{plan_res_cnt}}" />
            {{plan_res_cnt}}
        </td>
        <td style="text-align: center !important;">
            <input type="hidden" name="pop_lot_no" class="form-control" value="{{lot_no}}" />
            {{lot_no}}
        </td>
    </tr>
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

<script type="text/javascript">
    $(document).ready(() => {
        $("#tablet-top-title").text("생산실적등록");
        // setTimeout(() => getData(), 50);
        setTimeout(() => setResultTemplate(), 50);
        getDataOne("${vmap.plan_cd}", "${vmap.plan_proc_cd}");
        $("#frm_plan_res_cnt").numpad();
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

        $("#tblList").find(".datetimepicker").datetimepicker({
            format:'Y-m-d H:i',
            step:1,
            lang:'kr'
        });
        $.datetimepicker.setLocale('ko');

        setTimeout(() => getPlanResultData(), 50);
    }


    // 실적저장
    function planResultRegist()
    {
        let plan_res_cd = $("#frm_plan_res_cd").val();
        let equ_cd = $("#frm_equ_cd").val();
        let plan_res_u_cd = $("#frm_plan_res_u_cd").val();
        let plan_res_stdt = $("#frm_plan_res_stdt").val();
        let plan_res_eddt = $("#frm_plan_res_eddt").val();
        let old_plan_res_cnt = $("#frm_old_plan_res_cnt").val();
        let plan_res_cnt = $("#frm_plan_res_cnt").val();
        let lot_no = $("#frm_lot_no").val();
        let plan_res_notice = $("frm_#plan_res_notice").val();

        if(IsNull(equ_cd)) {
            eAlert("설비는 필수입력항목입니다.");
            equ_cd.focus();
            return false;
        }

        if(IsNull(plan_res_u_cd)) {
            eAlert("사용자는 필수입력항목입니다.");
            plan_res_u_cd.focus();
            return false;
        }

        if(IsNull(plan_res_stdt)) {
            eAlert("생산시작일시는 필수입력항목입니다.");
            plan_res_stdt.focus();
            return false;
        }

        if(IsNull(plan_res_eddt)) {
            eAlert("생산종료일시는 필수입력항목입니다.");
            plan_res_eddt.focus();
            return false;
        }

        if(IsNull(plan_res_cnt) || plan_res_cnt === 0) {
            eAlert("생산량은 필수입력항목입니다.");
            plan_res_cnt.focus();
            return false;
        }

        Swal.fire({
            title: '',
            text: "생산실적 정보를 저장하시겠습니까?",
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
                    type: "post"
                    ,url: "/mes/production/result/planResultRegist"
                    ,headers: {
                        "Content-Type": "application/json"
                        ,"X-HTTP-Method-Override": "POST"
                    }
                    ,dataType: "text"
                    ,data: JSON.stringify({
                        fact_cd: "${vmap.fact_cd}"
                        ,plan_cd: $("#frm_plan_cd").val()
                        ,plan_proc_cd: $("#frm_plan_proc_cd").val()
                        ,odr_cd: $("#frm_odr_cd").val()
                        ,proc_cd: $("#frm_proc_cd").val()
                        ,prod_cd: $("#frm_prod_cd").val()
                        ,prod_lot_yn: $("#frm_prod_lot_yn").val()
                        ,plan_proc_last_yn: $("#frm_plan_proc_last_yn").val()
                        ,plan_res_cd: plan_res_cd
                        ,equ_cd: equ_cd
                        ,plan_res_u_cd: plan_res_u_cd
                        ,plan_res_stdt: plan_res_stdt
                        ,plan_res_eddt: plan_res_eddt
                        ,old_plan_res_cnt: old_plan_res_cnt
                        ,plan_res_cnt: plan_res_cnt
                        ,plan_res_notice: plan_res_notice
                        ,lot_no: lot_no
                    })
                })
                .done(function (data) {
                    hideWait('.dataModal');
                    getPlanResultData();
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

    function planResultRegist()
    {
        let plan_res_cd = $("#frm_plan_res_cd").val();
        let equ_cd = $("#frm_equ_cd").val();
        let plan_res_u_cd = $("#frm_plan_res_u_cd").val();
        let plan_res_stdt = $("#frm_plan_res_stdt").val();
        let plan_res_eddt = $("#frm_plan_res_eddt").val();
        let old_plan_res_cnt = $("#frm_old_plan_res_cnt").val();
        let plan_res_cnt = $("#frm_plan_res_cnt").val();
        let lot_no = $("#frm_lot_no").val();
        let plan_res_notice = $("frm_#plan_res_notice").val();

        if(IsNull(equ_cd)) {
            eAlert("설비는 필수입력항목입니다.");
            equ_cd.focus();
            return false;
        }

        if(IsNull(plan_res_u_cd)) {
            eAlert("사용자는 필수입력항목입니다.");
            plan_res_u_cd.focus();
            return false;
        }

        if(IsNull(plan_res_stdt)) {
            eAlert("생산시작일시는 필수입력항목입니다.");
            plan_res_stdt.focus();
            return false;
        }

        if(IsNull(plan_res_eddt)) {
            eAlert("생산종료일시는 필수입력항목입니다.");
            plan_res_eddt.focus();
            return false;
        }

        if(IsNull(plan_res_cnt) || plan_res_cnt === 0) {
            eAlert("생산량은 필수입력항목입니다.");
            plan_res_cnt.focus();
            return false;
        }

        Swal.fire({
            title: '',
            text: "생산실적 정보를 저장하시겠습니까?",
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
                    type: "post"
                    ,url: "/mes/production/result/planResultRegist"
                    ,headers: {
                        "Content-Type": "application/json"
                        ,"X-HTTP-Method-Override": "POST"
                    }
                    ,dataType: "text"
                    ,data: JSON.stringify({
                        fact_cd: "${vmap.fact_cd}"
                        ,plan_cd: $("#frm_plan_cd").val()
                        ,plan_proc_cd: $("#frm_plan_proc_cd").val()
                        ,odr_cd: $("#frm_odr_cd").val()
                        ,proc_cd: $("#frm_proc_cd").val()
                        ,prod_cd: $("#frm_prod_cd").val()
                        ,prod_lot_yn: $("#frm_prod_lot_yn").val()
                        ,plan_proc_last_yn: $("#frm_plan_proc_last_yn").val()
                        ,plan_res_cd: plan_res_cd
                        ,equ_cd: equ_cd
                        ,plan_res_u_cd: plan_res_u_cd
                        ,plan_res_stdt: plan_res_stdt
                        ,plan_res_eddt: plan_res_eddt
                        ,old_plan_res_cnt: old_plan_res_cnt
                        ,plan_res_cnt: plan_res_cnt
                        ,plan_res_notice: plan_res_notice
                        ,lot_no: lot_no
                    })
                })
                .done(function (data) {
                    hideWait('.dataModal');
                    getPlanResultData();
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

    function planResultModify()
    {
        let plan_res_cd = $("#frm_plan_res_cd").val();
        let equ_cd = $("#frm_equ_cd").val();
        let plan_res_u_cd = $("#frm_plan_res_u_cd").val();
        let plan_res_stdt = $("#frm_plan_res_stdt").val();
        let plan_res_eddt = $("#frm_plan_res_eddt").val();
        let old_plan_res_cnt = $("#frm_old_plan_res_cnt").val();
        let plan_res_cnt = $("#frm_plan_res_cnt").val();
        let lot_no = $("#frm_lot_no").val();
        let plan_res_notice = $("frm_#plan_res_notice").val();

        if(IsNull(equ_cd)) {
            eAlert("설비는 필수입력항목입니다.");
            equ_cd.focus();
            return false;
        }

        if(IsNull(plan_res_u_cd)) {
            eAlert("사용자는 필수입력항목입니다.");
            plan_res_u_cd.focus();
            return false;
        }

        if(IsNull(plan_res_stdt)) {
            eAlert("생산시작일시는 필수입력항목입니다.");
            plan_res_stdt.focus();
            return false;
        }

        if(IsNull(plan_res_eddt)) {
            eAlert("생산종료일시는 필수입력항목입니다.");
            plan_res_eddt.focus();
            return false;
        }

        if(IsNull(plan_res_cnt) || plan_res_cnt === 0) {
            eAlert("생산량은 필수입력항목입니다.");
            plan_res_cnt.focus();
            return false;
        }

        Swal.fire({
            title: '',
            text: "생산실적 정보를 저장하시겠습니까?",
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
                    type: "post"
                    ,url: "/mes/production/result/planResultModify"
                    ,headers: {
                        "Content-Type": "application/json"
                        ,"X-HTTP-Method-Override": "POST"
                    }
                    ,dataType: "text"
                    ,data: JSON.stringify({
                        fact_cd: "${vmap.fact_cd}"
                        ,plan_cd: $("#frm_plan_cd").val()
                        ,plan_proc_cd: $("#frm_plan_proc_cd").val()
                        ,odr_cd: $("#frm_odr_cd").val()
                        ,proc_cd: $("#frm_proc_cd").val()
                        ,prod_cd: $("#frm_prod_cd").val()
                        ,prod_lot_yn: $("#frm_prod_lot_yn").val()
                        ,plan_proc_last_yn: $("#frm_plan_proc_last_yn").val()
                        ,plan_res_cd: plan_res_cd
                        ,equ_cd: equ_cd
                        ,plan_res_u_cd: plan_res_u_cd
                        ,plan_res_stdt: plan_res_stdt
                        ,plan_res_eddt: plan_res_eddt
                        ,old_plan_res_cnt: old_plan_res_cnt
                        ,plan_res_cnt: plan_res_cnt
                        ,plan_res_notice: plan_res_notice
                        ,lot_no: lot_no
                    })
                })
                .done(function (data) {
                    hideWait('.dataModal');
                    getPlanResultData();
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

    // 실적정보 Load
    function getPlanResultData()
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
                ,plan_cd: $("#frm_plan_cd").val()
                ,plan_proc_cd: $("#frm_plan_proc_cd").val()
                ,isNotDate: "Y"
            })
        })
            .done(function (data)
            {
                $("#tblPopResultData > tbody").empty();
                resultRowCnt = 0;

                data.forEach((item, index) => {
                    addPopResultRow(item);
                });

                // setProcButton();

            })
            .always(function (data) {
                hideWait('.dataModal');
            })
            .fail(function (jqHXR, textStatus, errorThrown) {
                ajaxErrorAlert(jqHXR);
            });
    }

    function addPopResultRow(data)
    {
        let template_html = $("#planProcListTemplate").html();
        let template = Handlebars.compile(template_html);
        let resultRowCnt = $("#tblPopResultData > tbody > tr").length + 1;
        let templateData;

        if(IsNull(data))
        {
            templateData = {
                cnt : resultRowCnt
                ,old_plan_res_cnt: 0
            };

            $("#tblPopResultData > tbody").append(template(templateData));
        }
        else
        {
            templateData = {
                cnt : resultRowCnt
                ,...data
                ,plan_res_cnt: data.plan_res_cnt.comma('3')
            };

            $("#tblPopResultData > tbody").append(template(templateData));

            $("#tblPopResultData .list_tr" + resultRowCnt).find("select[name=pop_equ_cd]").val(data.equ_cd);
            $("#tblPopResultData .list_tr" + resultRowCnt).find("select[name=pop_plan_res_u_cd]").val(data.plan_res_u_cd);
        }

        $("#tblPopResultData .list_tr" + resultRowCnt).find(IsNull(data) ? ".result-regist" : ".result-modify").show();
        $("#tblPopResultData .list_tr" + resultRowCnt).find(IsNull(data) ? ".result-modify" : ".result-regist").hide();

        $("#tblPopResultData .list_tr" + resultRowCnt)
            .find(".datetimepicker").datetimepicker({
            format:'Y-m-d H:i',
            step:1,
            lang:'kr'
        });

        $.datetimepicker.setLocale('ko');

        $("#tblPopResultData .list_tr" + resultRowCnt)
            .find("input[name$='cnt'], input[name$='price'], input[name$='amt'], input[name$='total'], input[name$='rate'], input[name$='min'], input[name$='vat']")
            .css("text-align", "right")
            .on("click", function() {
                $(this).select();
            })
            .on("keyup", function() {
                $(this).val($(this).val().comma("2"));
            });

        $("#tblPopResultData .list_tr" + resultRowCnt).on("click", function(index, item) {
            setResultData($(this));
            $(".result-btn-regist").css("display", "none");
            $(".result-btn-modify").css("display", "block");
        });
    }

    function setResultData(el) {
        $("#frm_plan_res_cd").val(el.find("[name=pop_plan_res_cd]").val());
        $("#frm_equ_cd").val(el.find("[name=pop_equ_cd]").val());
        $("#frm_plan_res_u_cd").val(el.find("[name=pop_plan_res_u_cd]").val());
        $("#frm_plan_res_stdt").val(el.find("[name=pop_plan_res_stdt]").val());
        $("#frm_plan_res_eddt").val(el.find("[name=pop_plan_res_eddt]").val());
        $("#frm_old_plan_res_cnt").val(el.find("[name=pop_plan_res_cnt]").val().replace(/,/g, ""));
        $("#frm_plan_res_cnt").val(el.find("[name=pop_plan_res_cnt]").val().replace(/,/g, ""));
        $("#frm_lot_no").val(el.find("[name=pop_lot_no]").val());
    }

    function planResultInit() {
        $("#frm_plan_res_cd").val("");
        $("#frm_equ_cd").val("");
        $("#frm_plan_res_u_cd").val("");
        $("#frm_plan_res_stdt").val("");
        $("#frm_plan_res_eddt").val("");
        $("#frm_old_plan_res_cnt").val("");
        $("#frm_plan_res_cnt").val("");
        $("#frm_lot_no").val("");

        $(".result-btn-regist").css("display", "block");
        $(".result-btn-modify").css("display", "none");
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

