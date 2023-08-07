<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tablet-header2.jspf" %>

<link rel="stylesheet" href="/plugin/jquerynumpad/jquery.numpad.css">
<script type="text/javascript" src="/plugin/jquerynumpad/jquery.numpad.js"></script>

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

    .modal-content-location {
        left: 50% !important;
        top: 50% !important;
    }

    .modal-backdrop {
        background-color: hsla(120, 100%, 150%, 0.5);
    }

    .btn .btn-wrapper--label:not(:first-child) {
        margin: 0;
    }

    .btn-pop {
        font-size: 0.3rem;
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
                   <input type="hidden" id="frm_ship_cd" name="frm_ship_cd" class="form-control"
                           placeholder="납품코드" title="납품코드" />
                    <input type="hidden" id="frm_odr_cd" name="frm_odr_cd" class="form-control"
                           placeholder="수주코드" title="수주코드" />
                    <input type="hidden" id="frm_comp_cd" name="frm_comp_cd" class="form-control"
                           placeholder="거래처" title="거래처" />
                    <input type="hidden" id="frm_comp_nm" name="frm_comp_nm" class="form-control"
                           placeholder="거래처" title="거래처" />
                    <input type="hidden" id="frm_odr_dt" name="frm_odr_dt" class="form-control"
                           placeholder="수주일" title="수주일" />
                    <input type="hidden" id="frm_odr_ship_dt" name="frm_odr_ship_dt" class="form-control"
                           placeholder="납기요청일" title="납기요청일" />
                    {{comp_nm}}
                </td>
                <th>수주일</th>
                <td>{{odr_dt}}</td>
                <th>납기요청일</th>
                <td>{{odr_ship_dt}}</td>
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
                <th>납품요청양</th>
                <td>
                    <input type="hidden" id="frm_ship_cnt" name="frm_ship_cnt" class="form-control" value="{{ship_cnt}}" />
                    {{odr_cnt}}
                </td>
            </tr>
        </thead>
    </table>
</script>

<script id="shipDetailTemplate" type="text/x-handlebars-template">
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
                            <th>납품일<span class="red"> (*)</span></th>
                            <td style="text-align: center;">
                                <input type="hidden" id="frm_ship_detail_cd" name="frm_ship_detail_cd" class="form-control" value="{{ship_detail_cd}}" />
                                <div class="input-group input-group-seamless">
                                    <input id="frm_ship_detail_dt" name="frm_ship_detail_dt" class="form-control datepicker no-reset" title="납품일자"
                                           placeholder="납품일자" type="text" value="" />
                                    <div class="input-group-append">
                                        <span class="input-group-text"><i class="fas fa-calendar"></i></span>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>LOT.NO <span class="red"> (*)</span></th>
                            <td>
                                <select id="frm_lot_no" name="frm_lot_no" class="custom-select w-100" style="width: 100% !important; display: none;" >
                                    <option value="">LOT 선택</option>
                                </select>
                                <input type="hidden" id="frm_old_lot_no" name="frm_old_lot_no" class="form-control" value="{{old_lot_no}}"
                                       placeholder="Lot.No" title="Lot.No" required />
                            </td>
                        </tr>
                        <tr>
                            <th>납품수량 <span class="red"> (*)</span></th>
                            <td>
                                <input type="hidden" name="frm_old_ship_detail_cnt" class="form-control" value="{{old_ship_detail_cnt}}"
                                       placeholder="이전납품량" title="이전납품량" required />
                                <input type="text" name="frm_ship_detail_cnt" class="form-control" value="{{ship_detail_cnt}}"
                                       placeholder="납품량" title="납품량" required />
                            </td>
                        </tr>
                    </thead>
                </table>
                <div class="result-button-box">
                    <button class="btn btn-sm btn-first tablet-list-btn-full result-main-button result-btn-regist" style="width: 100%;" onclick="shipResultRegistModify();"><i class="fas fa-check"></i> 저장</button>
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

<div class="modal fade dataModal inputModal" id="inputModal" tabindex="-1" role="dialog" aria-labelledby="registModal" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-xl modal-form-xl" role="document">
        <div class="modal-content" style="width: 85vw; height: 95vh;">
            <div class="modal-header" style="padding: 0.4rem">
                <h4 class="modal-title"><i class="fas fa-indent"></i> 투입자재현황</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">
                <table id="tblInputPopData" class="table table-hover table-bordered mb-3 table-form">
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
                            <th>품번 / 품명</th>
                            <td>
                                <input type="hidden" id="input_pop_plan_cd" name="input_pop_plan_cd" class="form-control"
                                       placeholder="계획코드" title="계획코드" />
                                <input type="hidden" id="input_pop_plan_proc_cd" name="input_pop_plan_proc_cd" class="form-control"
                                       placeholder="계획공정코드" title="계획공정코드" />
                                <input type="hidden" id="input_pop_plan_res_cd" name="input_pop_plan_res_cd" class="form-control"
                                       placeholder="계획실적코드" title="계획실적코드" />
                                <input type="hidden" id="input_pop_proc_cd" name="input_pop_proc_cd" class="form-control"
                                       placeholder="공정코드" title="공정코드" />
                                <input type="hidden" id="input_pop_odr_cd" name="input_pop_odr_cd" class="form-control"
                                       placeholder="수주코드" title="수주코드" />
                                <input type="hidden" id="input_pop_plan_proc_last_yn" name="input_pop_plan_proc_last_yn" class="form-control"
                                       placeholder="마지막공정여부" title="마지막공정여부" />
                                <input type="hidden" id="input_pop_prod_cd" name="input_pop_prod_cd" class="form-control"
                                       placeholder="제품코드" title="제품코드" />
                                <input type="hidden" id="input_pop_prod_nm" name="input_pop_prod_nm" class="form-control"
                                       placeholder="제품명" title="제품명" />
                                <input type="hidden" id="input_pop_prod_pn" name="input_pop_prod_pn" class="form-control"
                                       placeholder="제품품번" title="제품코드" />
                                <div id="input_pop_selector2" name="input_pop_selector2"></div>
                            </td>
                            <th>제품종류</th>
                            <td>
                                <div id="input_pop_prod_kind_nm" name="input_pop_prod_kind_nm"></div>
                            </td>
                            <th>제품분류</th>
                            <td>
                                <div id="input_pop_prod_group_nm" name="input_pop_prod_group_nm"></div>
                            </td>
                            <th>규격</th>
                            <td>
                                <div id="input_pop_prod_stand" name="input_pop_prod_stand"></div>
                            </td>
                        </tr>
                        <tr>
                            <th>공정</th>
                            <td>
                                <div class="red" id="input_pop_proc_nm" name="input_pop_proc_nm"></div>
                            </td>
                            <th>작업지시번호</th>
                            <td>
                                <div id="input_pop_plan_no" name="input_pop_plan_no"></div>
                            </td>
                            <th>생산계획수량</th>
                            <td class="text-right">
                                <div id="input_pop_plan_cnt" name="input_pop_plan_cnt"></div>
                            </td>
                            <th>생산량</th>
                            <td class="text-right">
                                <div class="red" id="input_pop_plan_res_cnt" name="input_pop_plan_res_cnt"></div>
                            </td>
                        </tr>
                    </tbody>
                </table>


                <form id="inputDataForm" name="dataForm" class="dataForm" method="post">
                    <div style="height: 500px; overflow: auto;">
                        <table id="tblPopInputData" class="table table-hover table-bordered mb-3 table-form">
                            <colgroup>
                                <col style="width: 6%" />
                                <col style="width: 14%" />
                                <col style="width: 15%" />
                                <col style="width: 15%" />
                                <col style="width: 10%" />
                                <col style="width: 10%" />
                                <col style="width: 10%" />
                                <col style="width: 10%" />
                                <col style="width: 10%" />
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>순서</th>
                                    <th>자재코드</th>
                                    <th>품번</th>
                                    <th>품명</th>
                                    <th>분류</th>
                                    <th>규격</th>
                                    <th>단위</th>
                                    <th>BOM소요량</th>
                                    <th>생산투입량</th>
                                </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>
                </form>
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
</div>

<script id="popPlanInputTemplete" type="text/x-handlebars-template">
    <tr class="dataList list_tr{{cnt}}">
        <td style="text-align: center !important;">
            <input type="hidden" name="pop_plan_cd" class="form-control" value="{{plan_cd}}" />
            <input type="hidden" name="pop_plan_proc_cd" class="form-control" value="{{plan_proc_cd}}" />
            <input type="hidden" name="pop_plan_res_cd" class="form-control" value="{{plan_res_cd}}" />
            <input type="hidden" name="pop_plan_input_cd" class="form-control" value="{{plan_input_cd}}" />
            {{cnt}}
        </td>
        <td>
            {{prod_ja_cd}}
        </td>
        <td>
            {{prod_ja_pn}}
        </td>
        <td>
            {{prod_ja_nm}}
        </td>
        <td>
            {{prod_ja_group_nm}}
        </td>
        <td>
            {{prod_ja_stand}}
        </td>
        <td>
            {{prod_ja_unit_nm}}
        </td>
        <td style="text-align: right !important;">
            {{plan_bom_cnt}}
        </td>
        <td style="text-align: right !important;">
            {{plan_input_cnt}}
        </td>
    </tr>
</script>

<%-- 비가동 데이터 Modal --%>
<div class="modal fade dataModal stopModal" id="stopModal" tabindex="-1" role="dialog" aria-labelledby="registModal" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-xl modal-form-xl" role="document">
        <div class="modal-content" style="width: 85vw; height: 95vh;">
            <div class="modal-header" style="padding: 0.4rem">
                <h4 class="modal-title"><i class="fas fa-stop-circle"></i> 비가동등록</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">
                <table id="tblStopPopData" class="table table-hover table-bordered mb-3 table-form">
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
                            <th>품번 / 품명</th>
                            <td>
                                <input type="hidden" id="stop_pop_plan_cd" name="stop_pop_plan_cd" class="form-control"
                                       placeholder="계획코드" title="계획코드" />
                                <input type="hidden" id="stop_pop_plan_proc_cd" name="stop_pop_plan_proc_cd" class="form-control"
                                       placeholder="계획공정코드" title="계획공정코드" />
                                <input type="hidden" id="stop_pop_plan_res_cd" name="stop_pop_plan_res_cd" class="form-control"
                                       placeholder="계획실적코드" title="계획실적코드" />
                                <input type="hidden" id="stop_pop_proc_cd" name="stop_pop_proc_cd" class="form-control"
                                       placeholder="공정코드" title="공정코드" />
                                <input type="hidden" id="stop_pop_odr_cd" name="stop_pop_odr_cd" class="form-control"
                                       placeholder="수주코드" title="수주코드" />
                                <input type="hidden" id="stop_pop_plan_proc_last_yn" name="stop_pop_plan_proc_last_yn" class="form-control"
                                       placeholder="마지막공정여부" title="마지막공정여부" />
                                <input type="hidden" id="stop_pop_prod_cd" name="stop_pop_prod_cd" class="form-control"
                                       placeholder="제품코드" title="제품코드" />
                                <input type="hidden" id="stop_pop_prod_nm" name="stop_pop_prod_nm" class="form-control"
                                       placeholder="제품명" title="제품명" />
                                <input type="hidden" id="stop_pop_prod_pn" name="stop_pop_prod_pn" class="form-control"
                                       placeholder="제품품번" title="제품코드" />
                                <div id="stop_pop_selector2" name="stop_pop_selector2"></div>
                            </td>
                            <th>제품종류</th>
                            <td>
                                <div id="stop_pop_prod_kind_nm" name="stop_pop_prod_kind_nm"></div>
                            </td>
                            <th>제품분류</th>
                            <td>
                                <div id="stop_pop_prod_group_nm" name="stop_pop_prod_group_nm"></div>
                            </td>
                            <th>규격</th>
                            <td>
                                <div id="stop_pop_prod_stand" name="stop_pop_prod_stand"></div>
                            </td>
                        </tr>
                        <tr>
                            <th>공정</th>
                            <td>
                                <div class="red" id="stop_pop_proc_nm" name="stop_pop_proc_nm"></div>
                            </td>
                            <th>작업지시번호</th>
                            <td>
                                <div id="stop_pop_plan_no" name="stop_pop_plan_no"></div>
                            </td>
                            <th>생산계획수량</th>
                            <td class="text-right">
                                <div id="stop_pop_plan_cnt" name="stop_pop_plan_cnt"></div>
                            </td>
                            <th>생산량</th>
                            <td class="text-right">
                                <div class="red" id="stop_pop_plan_res_cnt" name="stop_pop_plan_res_cnt"></div>
                            </td>
                        </tr>
                    </tbody>
                </table>

                <form id="stopForm" name="dataForm" class="dataForm" method="post">
                    <div style="height: 65vh; overflow: auto;">
                        <table id="tblPopStopData" class="table table-hover table-bordered mb-3 table-form">
                            <colgroup>
                                <col style="width: 7%" />
                                <col style="width: 16%" />
                                <col style="width: 19%" />
                                <col style="width: 19%" />
                                <col style="width: 11%" />
                                <col style="width: 18%" />
                                <col style="width: 10%" />
                            </colgroup>
                            <thead>
                            <tr>
                                <th>순서</th>
                                <th>비가동구분 <span class="red"> (필수)</span></th>
                                <th>비가동시작일시 <span class="red"> (필수)</span></th>
                                <th>비가동종료일시 <span class="red"> (필수)</span></th>
                                <th>비가동시간</th>
                                <th>비고</th>
                                <th>
                                    <button type="button" id="btnAddStopSubList" class="btn btn-primary btn-sm btn-pop">
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
                    <div style="display: flex; flex-direction: row-reverse; justify-content: center; align-items: center;">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">
                            <span class="btn-wrapper--icon">
                                <i class="fas fa-times-circle"></i>
                            </span>
                            <span class="btn-wrapper--label">닫기</span>
                        </button>

                        <button type="button" id="btnPopStopRegist" class="btn btn-primary" style="margin-right: 10px;">
                            <span class="btn-wrapper--icon">
                                <i class="fas fa-download"></i>
                            </span>
                            <span class="btn-wrapper--label">저장</span>
                        </button>
                    </div>
                </form>
            </div>

<%--            <div class="modal-footer">--%>
<%--                <button type="button" id="btnPopStopRegist" class="btn btn-primary ">--%>
<%--                    <span class="btn-wrapper--icon">--%>
<%--                        <i class="fas fa-download"></i>--%>
<%--                    </span>--%>
<%--                    <span class="btn-wrapper--label">저장</span>--%>
<%--                </button>--%>

<%--                <button type="button" class="btn btn-secondary" data-dismiss="modal">--%>
<%--                    <span class="btn-wrapper--icon">--%>
<%--                        <i class="fas fa-times-circle"></i>--%>
<%--                    </span>--%>
<%--                    <span class="btn-wrapper--label">닫기</span>--%>
<%--                </button>--%>
<%--            </div>--%>
        </div>
    </div>
</div>

<%-- 비가동데이터 Templete --%>
<script id="popPlanStopTemplete" type="text/x-handlebars-template">
    <tr class="dataList list_tr{{cnt}}">
        <td style="text-align: center !important;">
            <input type="hidden" name="pop_plan_stop_cd" class="form-control" value="{{plan_stop_cd}}" />
            {{cnt}}
        </td>
        <td>
            <select name="pop_plan_stop_item" class="custom-select w-100" style="width: 100% !important;" required>
                <option value="">비가동구분선택</option>
                <c:forEach var="item" items="${vmap.stopList}" varStatus="status">
                    <option value="${item.base_detail_cd}">${item.base_detail_nm}</option>
                </c:forEach>
            </select>
        </td>
        <td style="text-align: center;">
            <input type="text" name="pop_plan_stop_stdt" class="form-control datetimepicker" value="{{plan_stop_stdt}}"
                   placeholder="비가동시작일시" title="비가동시작일시" required />
        </td>
        <td style="text-align: center;">
            <input type="text" name="pop_plan_stop_eddt" class="form-control datetimepicker" value="{{plan_stop_eddt}}"
                   placeholder="비가동종료일시" title="비가동종료일시" required />
        </td>
        <td style="text-align: center !important;">
            <span class="red" name="pop_plan_stop_time">{{plan_stop_time}}분</span>
        </td>
        <td>
            <input type="text" name="pop_plan_stop_notice" class="form-control" value="{{plan_stop_notice}}"
                   placeholder="비고" title="비고" />
        </td>
        <td style="text-align: center !important;">
            <button class="btn btn-sm btn-danger btn-pop" type="button" onclick="planStopDelete({{cnt}})">
                <span class="btn-wrapper--icon">
                    <i class="fas fa-minus-circle"></i>
                </span>
                <span class="btn-wrapper--label">삭제</span>
            </button>
        </td>
    </tr>
</script>

<script type="text/javascript">
    $(document).ready(() => {
        $.fn.numpad.defaults.gridTpl = '<table class="table modal-content modal-content-location"></table>';
        $.fn.numpad.defaults.backgroundTpl = '<div class="modal-backdrop in"></div>';
        $.fn.numpad.defaults.displayTpl = '<input type="text" class="form-control  input-lg" style="width: 400px;" />';
        $.fn.numpad.defaults.buttonNumberTpl = '<button type="button" class="btn btn-danger btn-lg" style="width:80px;height:80px; font-size:25pt;font-weight:800;"></button>';
        $.fn.numpad.defaults.buttonFunctionTpl = '<button type="button" class="btn btn-lg" style="width: 100%; height:80px;color:#000000;"></button>';
        $.fn.numpad.defaults.onKeypadCreate = function() {
            $(this).find('.done').addClass('btn-primary');
            $(this).find('.cancel').addClass('btn-danger');
            $(this).find('.clear').addClass('btn-warning');
            $(this).find('.del').addClass('btn-warning');
        };
        // $.fn.numpad.defaults.hidePlusMinusButton = true;
        $.fn.numpad.defaults.hideDecimalButton = false;
        $.fn.numpad.defaults.hideDotButton = false;
        $.fn.numpad.defaults.textDone = '<strong style="font-size:20pt;color:#ffffff;">입력</strong>';
        $.fn.numpad.defaults.textDelete = '<strong style="font-size:20pt;color:#ffffff;">지우기</strong>';
        $.fn.numpad.defaults.textClear = '<strong style="font-size:20pt;color:#ffffff;">초기화</strong>';
        $.fn.numpad.defaults.textCancel = '<strong style="font-size:20pt;color:#ffffff;">취소</strong>';

        $("#tablet-top-title").text("생산실적등록");
        // setTimeout(() => getData(), 50);
        setTimeout(() => setResultTemplate(), 50);
        getDataOne("${vmap.odr_cd}", "${vmap.ship_cd}");

        $("#btnAddStopSubList").on("click", () => {
            addPopStopRow();
        });

        // 비가동 항목저장
        $("#btnPopStopRegist").on("click", () => {
            Swal.fire({
                title: '',
                text: "비가동 정보를 저장하시겠습니까?",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: '확인',
                cancelButtonText: '취소'
            }).then((result) => {
                if (result.isConfirmed) {
                    stopRegistModifyData();
                }
            });
        });

        $("#btnPopProcessComplete").on("click", () => {
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
    });

    function getDataOne(odr_cd, ship_cd)
    {
        $.ajax({
            url: "/mes/sales/shipment/shipOne/" + odr_cd + "/" + ship_cd
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
            ,ship_cnt: item.ship_cnt.comma('2')
        }

        $("#dataOneDiv").append(template(templateData));
    }

    // 실적 입력 template
    function setResultTemplate()
    {
        let template_html = $("#shipDetailTemplate").html();
        let template = Handlebars.compile(template_html);

        $("#tblList").append(template());

        $("#tblList").find(".datetimepicker").datetimepicker({
            format:'Y-m-d H:i',
            step:1,
            lang:'kr'
        });
        $.datetimepicker.setLocale('ko');

        $("#frm_ship_detail_cnt").numpad();
        setDatePicker("datepicker");

        // debugger
        if($("#frm_prod_lot_yn").val() === "Y") {
            setTimeout(() => setProdLotData($("#frm_prod_cd").val(), null), 300);
            $("#frm_lot_no").css("display", "block");
        }

        $("#frm_lot_no").on("change", function () {
            let lot_cnt = parseInt($(this).find("option:selected").data("qty"));
            let odr_cnt = parseInt($("#frm_odr_cnt").text().replace(/,/g, ""));
            $("#frm_ship_detail_cnt").val(lot_cnt>=odr_cnt ? odr_cnt : lot_cnt);
        });

        // setTimeout(() => getPlanResultData(), 50);
    }

    function setProdLotData(prod_cd, lot_no=null)
    {
        $.ajax({
            url: "/mes/base/product/prodLotList"
            ,type: "post"
            ,headers: {
                "Content-Type": "application/json"
                ,"X-HTTP-Method-Override": "POST"
            }
            ,dataType: "json"
            ,data: JSON.stringify({
                fact_cd: "${vmap.fact_cd}"
                ,prod_cd: prod_cd
            })
        })
        .done(function (data)
        {
            if(IsNotNull(data)) {
                $("#frm_lot_no option:not(:first)").empty();
                data.forEach((item, index) => {
                    var newOption = "<option value='" + item.lot_no + "' data-qty='" + item.lot_cnt + "'" + ">" + item.lot_no + " [" + item.lot_cnt + "]" + "</option>";
                    $("#frm_lot_no").append(newOption);
                });
            }

            if(IsNotNull(lot_no)) $("#frm_lot_no").val([lot_no]);
        })
        .always(function (data) {
        })
        .fail(function (jqHXR, textStatus, errorThrown) {
            ajaxErrorAlert(jqHXR);
        });
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
                    planResultInit();
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
                    planResultInit();
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


    function callPlanInput(cnt)
    {
        let $tr = $("#tblPopResultData .list_tr" + cnt);
        // let plan_res_cd = $tr.find("input[name=frm_plan_res_cd]").val();
        let plan_res_cd = $("#frm_plan_res_cd").val();

        if(IsNull(plan_res_cd)) {
            eAlert("실적등록 후 사용가능합니다.");
            return false;
        }

        $("#inputModal").modal("show");
        showWait('.dataModal');

        $.ajax({
            url: "/mes/production/result/planResultOne/" + $("#frm_plan_cd").val() + "/" + $("#frm_plan_proc_cd").val() + "/" + plan_res_cd
            ,type: "get"
            ,dataType: "json"
        })
        .done(function (data)
        {
            setDataOne("input_pop_", data);
            $("#input_pop_selector2").text('[' + data.prod_pn + '] ' + data.prod_nm);

            getPlanInputData(plan_res_cd);
        })
        .always(function (data) {
            hideWait('.dataModal');
        })
        .fail(function (jqHXR, textStatus, errorThrown) {
            ajaxErrorAlert(jqHXR);
        });
    }

    function getPlanInputData(plan_res_cd)
    {
        showWait('.inputModal');

        $.ajax({
            url: "/mes/production/result/planInputList"
            ,type: "post"
            ,headers: {
                "Content-Type": "application/json"
                ,"X-HTTP-Method-Override": "POST"
            }
            ,dataType: "json"
            ,data: JSON.stringify({
                fact_cd: "${vmap.fact_cd}"
                ,plan_cd: $("#pop_plan_cd").val()
                ,plan_proc_cd: $("#pop_plan_proc_cd").val()
                ,plan_res_cd: plan_res_cd
                ,isNoDate: "Y"
            })
        })
        .done(function (data)
        {
            $("#tblPopInputData > tbody").empty();
            inputRowCnt = 0;

            data.forEach((item, index) => {
                addPopInputRow(item);
            });

        })
        .always(function (data) {
            hideWait('.inputModal');
        })
        .fail(function (jqHXR, textStatus, errorThrown) {
            ajaxErrorAlert(jqHXR);
        });
    }

    // let inputRowCnt = 0;
    function addPopInputRow(data)
    {
        let template_html = $("#popPlanInputTemplete").html();
        let template = Handlebars.compile(template_html);
        let inputRowCnt = $("#tblPopInputData > tbody > tr").length + 1;
        let templateData;

        templateData = {
            cnt : inputRowCnt
            ,...data
            ,plan_bom_cnt: data.plan_bom_cnt.comma('3')
            ,plan_input_cnt: data.plan_input_cnt.comma('3')
        };

        $("#tblPopInputData > tbody").append(template(templateData));

        $("#tblPopInputData .list_tr" + inputRowCnt)
            .find("input[name$='cnt'], input[name$='price'], input[name$='amt'], input[name$='total'], input[name$='rate'], input[name$='min'], input[name$='vat']")
            .css("text-align", "right")
            .on("click", function() {
                $(this).select();
            })
            .on("keyup", function() {
                $(this).val($(this).val().comma("3"));
            });
    }

    function callPlanStop(cnt)
    {
        let $tr = $("#tblPopResultData .list_tr" + cnt);
        let plan_res_cd = $("#frm_plan_res_cd").val();

        if(IsNull(plan_res_cd)) {
            eAlert("실적등록 후 사용가능합니다.");
            return false;
        }

        $("#stopModal").modal("show");
        showWait('.dataModal');

        $.ajax({
            url: "/mes/production/result/planResultOne/" + $("#frm_plan_cd").val() + "/" + $("#frm_plan_proc_cd").val() + "/" + plan_res_cd
            ,type: "get"
            ,dataType: "json"
        })
            .done(function (data)
            {
                setDataOne("stop_pop_", data);
                $("#stop_pop_selector2").text('[' + data.prod_pn + '] ' + data.prod_nm);

                getPlanStopData(plan_res_cd);
            })
            .always(function (data) {
                hideWait('.dataModal');
            })
            .fail(function (jqHXR, textStatus, errorThrown) {
                ajaxErrorAlert(jqHXR);
            });
    }

    function getPlanStopData(plan_res_cd)
    {
        showWait('.inputModal');

        $.ajax({
            url: "/mes/production/result/planStopList"
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
                ,plan_res_cd: plan_res_cd
                ,isNoDate: "Y"
            })
        })
        .done(function (data)
        {
            $("#tblPopStopData > tbody").empty();

            data.forEach((item, index) => {
                addPopStopRow(item);
            });

        })
        .always(function (data) {
            hideWait('.inputModal');
        })
        .fail(function (jqHXR, textStatus, errorThrown) {
            ajaxErrorAlert(jqHXR);
        });
    }

    function addPopStopRow(data)
    {
        let template_html = $("#popPlanStopTemplete").html();
        let template = Handlebars.compile(template_html);
        let stopRowCnt = $("#tblPopStopData > tbody > tr").length + 1;
        let templateData;

        if(IsNull(data))
        {
            templateData = {
                cnt : stopRowCnt
            };

            $("#tblPopStopData > tbody").append(template(templateData));
        }
        else
        {
            templateData = {
                cnt : stopRowCnt
                ,...data
            };

            $("#tblPopStopData > tbody").append(template(templateData));

            $("#tblPopStopData .list_tr" + stopRowCnt).find("select[name=pop_plan_stop_item]").val(data.plan_stop_item);
        }

        $("#tblPopStopData .list_tr" + stopRowCnt)
            .find(".datetimepicker").datetimepicker({
                format:'Y-m-d H:i',
                step:1,
                lang:'kr'
            });

        $.datetimepicker.setLocale('ko');

        $("#tblPopStopData .list_tr" + stopRowCnt)
            .find("input[name$='cnt'], input[name$='price'], input[name$='amt'], input[name$='total'], input[name$='rate'], input[name$='min'], input[name$='vat']")
            .css("text-align", "right")
            .on("click", function() {
                $(this).select();
            })
            .on("keyup", function() {
                $(this).val($(this).val().comma("3"));
            });
    }

    // Add Data - ajax regist
    function stopRegistModifyData()
    {
        showWait('.stopModal');

        //. Data List
        let ary_plan_stop_cd = [];
        let ary_plan_stop_item = [];
        let ary_plan_stop_stdt = [];
        let ary_plan_stop_eddt = [];
        let ary_plan_stop_notice = [];

        $.each($("#tblPopStopData > tbody > tr"), function(index, item)
        {
            ary_plan_stop_cd.push($(item).find("input[name=pop_plan_stop_cd]").val());
            ary_plan_stop_item.push($(item).find("select[name=pop_plan_stop_item]").val());
            ary_plan_stop_stdt.push($(item).find("input[name=pop_plan_stop_stdt]").val());
            ary_plan_stop_eddt.push($(item).find("input[name=pop_plan_stop_eddt]").val());
            ary_plan_stop_notice.push($(item).find("input[name=pop_plan_stop_notice]").val());
        });

        $.ajax({
            type: "post"
            ,url: "/mes/production/result/planStopRegistModify"
            ,headers: {
                "Content-Type": "application/json"
                ,"X-HTTP-Method-Override": "POST"
            }
            ,dataType: "text"
            ,data: JSON.stringify({
                fact_cd: "${vmap.fact_cd}"
                ,plan_cd: $("#stop_pop_plan_cd").val()
                ,plan_proc_cd: $("#stop_pop_plan_proc_cd").val()
                ,plan_res_cd: $("#stop_pop_plan_res_cd").val()
                ,ary_plan_stop_cd: ary_plan_stop_cd
                ,ary_plan_stop_item: ary_plan_stop_item
                ,ary_plan_stop_stdt: ary_plan_stop_stdt
                ,ary_plan_stop_eddt: ary_plan_stop_eddt
                ,ary_plan_stop_notice: ary_plan_stop_notice
            })
        })
        .done(function (data) {
            hideWait('.stopModal');
            getPlanStopData($("#stop_pop_plan_res_cd").val());
        })
        .always(function (data) {

        })
        .fail(function (jqHXR, textStatus, errorThrown) {
            ajaxErrorAlert(jqHXR);
            hideWait('.dataModal');
        });
    }

    function planStopDelete(cnt)
    {
        let plan_stop_cd = $("#tblPopStopData .list_tr" + cnt).find("[name=pop_plan_stop_cd]").val();

        if(IsNull(plan_stop_cd))
        {
            $("#tblPopStopData .list_tr" + cnt).remove();
        }
        else
        {
            Swal.fire({
                title: '',
                text: "비가동 정보를 삭제하시겠습니까?",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: '확인',
                cancelButtonText: '취소'
            }).then((result) => {
                if (result.isConfirmed)
                {
                    showWait('.stopModal');

                    $.ajax({
                        type: "delete"
                        ,url: "/mes/production/result/planStopDelete"
                        ,headers: {
                            "Content-Type": "application/json"
                            ,"X-HTTP-Method-Override": "DELETE"
                        }
                        ,dataType: "text"
                        ,data: JSON.stringify({
                            plan_stop_cd: plan_stop_cd
                        })
                    })
                    .done(function (data) {
                        hideWait('.stopModal');
                        getPlanStopData($("#stop_pop_plan_res_cd").val());
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

    function planProcessComplete()
    {
        $.ajax({
            type: "post"
            ,url: "/mes/production/result/planProcessComplete"
            ,headers: {
                "Content-Type": "application/json"
                ,"X-HTTP-Method-Override": "POST"
            }
            ,dataType: "text"
            ,data: JSON.stringify({
                fact_cd: "${vmap.fact_cd}"
                ,plan_cd: $("#frm_plan_cd").val()
                ,plan_proc_cd: $("#frm_plan_proc_cd").val()
            })
        })
            .done(function (data) {
                hideWait('.dataModal');
                $("#dataModal").modal("hide");
                getData();
            })
            .always(function (data) {

            })
            .fail(function (jqHXR, textStatus, errorThrown) {
                ajaxErrorAlert(jqHXR);
                hideWait('.dataModal');
            });
    }

</script>

<%@ include file="/WEB-INF/include/tablet-footer.jspf" %>

