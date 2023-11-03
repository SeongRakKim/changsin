<%--
  Created by IntelliJ IDEA.
  User: outsourcing
  Date: 2022-02-09
  Time: 오후 10:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="/WEB-INF/include/header.jspf" %>

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
                                <option value="PUR_DT">발주일</option>
                                <option value="PUR_SHIP_DT">납기요청일</option>
                            </select>
                            <%@ include file="/WEB-INF/include/main-search-date-content.jspf"%>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>검색조건</th>
                    <td>
                        <select id="prod_group" name="prod_group" class="custom-select w-100" style="width: 15% !important;">
                            <option value="">품목분류선택</option>
                            <c:forEach var="item" items="${vmap.prodGroupList}" varStatus="status">
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
                <i class="fas fa-home"></i> <i class="fas fa-arrow-circle-right"></i> 재고관리 <i class="fas fa-arrow-circle-right"></i> 매입관리
            </span>
        </div>

        <div id="btnGroup">

            <button class="btn btn-sm btn-primary" type="button" id="btnSearch">
                <span class="btn-wrapper--icon">
                    <i class="fas fa-search"></i>
                </span>
                <span class="btn-wrapper--label">조회</span>
            </button>

            <button class="btn btn-sm btn-warning" type="button" id="btnNew">
                <span class="btn-wrapper--icon">
                    <i class="fas fa-plus"></i>
                </span>
                <span class="btn-wrapper--label">추가</span>
            </button>

            <button class="btn btn-sm btn-danger" type="button" id="btnDelete">
                <span class="btn-wrapper--icon">
                    <i class="fas fa-trash-alt"></i>
                </span>
                <span class="btn-wrapper--label">삭제</span>
            </button>

<%--            <button class="btn btn-sm btn-first" type="button" id="btnIn">--%>
<%--                <span class="btn-wrapper--icon">--%>
<%--                    <i class="fas fa-copy"></i>--%>
<%--                </span>--%>
<%--                <span class="btn-wrapper--label">일괄입고</span>--%>
<%--            </button>--%>

        </div>

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
                                        <th class="no-sort" style="width: 3%">
                                            <div class="custom-control custom-checkbox">
                                                <input type="checkbox" class="custom-control-input" id="listAll">
                                                <label class="custom-control-label" for="listAll"></label>
                                            </div>
                                        </th>
<%--                                        <th style="width: 8%">매입번호</th>--%>
                                        <th>거래처</th>
                                        <th style="width: 6%">매입일</th>
                                        <th style="width: 6%">납기요청일</th>
                                        <th>품번</th>
                                        <th style="width: 12%">품목명</th>
                                        <th>규격</th>
                                        <th>단위</th>
                                        <th>수량</th>
                                        <th style="width: 7%">입고수량</th>
                                        <th style="width: 5%">VAT</th>
                                        <th>단가</th>
                                        <th>금액</th>
<%--                                        <th>VAT</th>--%>
                                        <th>관리</th>
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
                    <form id="dataForm" name="dataForm" class="dataForm" method="post">
                        <table id="tblPopData" class="table table-hover table-bpurchaseed mb-3 table-form">
                            <tbody>
                                <tr>
                                    <th>거래처<span class="red"> (필수)</span></th>
                                    <td>
                                        <input type="hidden" id="pop_pur_cd" name="pop_pur_cd" class="form-control no-reset"
                                               placeholder="매입코드" title="매입코드" />
                                        <input type="hidden" id="pop_comp_cd" name="pop_comp_cd" class="form-control no-reset"
                                               placeholder="거래처" title="거래처" />
                                        <input type="hidden" id="pop_comp_nm" name="pop_comp_nm" class="form-control no-reset"
                                               placeholder="거래처" title="거래처" />
                                        <input type="text" id="pop_selector" name="pop_selector" class="form-control no-reset"
                                               placeholder="거래처명" title="거래처명" required />
                                    </td>
                                    <th>매입일<span class="red"> (필수)</span></th>
                                    <td>
                                        <div class="input-group input-group-seamless">
                                            <input id="pop_pur_dt" name="pop_pur_dt" class="form-control datepicker no-reset" title="매입일"
                                                   placeholder="매입일" type="text" />
                                            <div class="input-group-append">
                                                <span class="input-group-text"><i class="fas fa-calendar"></i></span>
                                            </div>
                                        </div>
                                    </td>
                                    <th>납기요청일<span class="red"> (필수)</span></th>
                                    <td>
                                        <div class="input-group input-group-seamless">
                                            <input id="pop_pur_ship_dt" name="pop_pur_ship_dt" class="form-control datepicker no-reset" title="납기요청일"
                                                   placeholder="납기요청일" type="text" />
                                            <div class="input-group-append">
                                                <span class="input-group-text"><i class="fas fa-calendar"></i></span>
                                            </div>
                                        </div>
                                    </td>
                                    <th></th>
                                    <td></td>
                                </tr>
                                <tr>
                                    <th>품번 or 품명 <span class="red"> (필수)</span></th>
                                    <td>
                                        <input type="hidden" id="pop_prod_cd" name="pop_prod_cd" class="form-control"
                                               placeholder="제품코드" title="제품코드" />
                                        <input type="hidden" id="pop_prod_nm" name="pop_prod_nm" class="form-control"
                                               placeholder="제품명" title="제품명" />
                                        <input type="hidden" id="pop_prod_pn" name="pop_prod_pn" class="form-control"
                                               placeholder="제품품번" title="제품코드" />
                                        <input type="text" id="pop_selector2" name="pop_selector2" class="form-control"
                                               placeholder="품번 or 품명" title="품번 or 품명" required />
                                    </td>
                                    <th>제품종류</th>
                                    <td>
                                        <input type="text" id="pop_prod_kind_nm" name="pop_prod_kind_nm" class="form-control"
                                               placeholder="제품종류" title="제품종류" readonly="readonly" />
                                    </td>
                                    <th>제품분류</th>
                                    <td>
                                        <input type="text" id="pop_prod_group_nm" name="pop_prod_group_nm" class="form-control"
                                               placeholder="제품분류" title="제품분류" readonly="readonly" />
                                    </td>
                                    <th></th>
                                    <td></td>
                                </tr>
                                <tr>
                                    <th>규격</th>
                                    <td>
                                        <input type="text" id="pop_prod_stand" name="pop_prod_stand" class="form-control"
                                               placeholder="규격" title="규격" readonly="readonly" />
                                    </td>
                                    <th>단위</th>
                                    <td>
                                        <input type="text" id="pop_prod_unit_nm" name="pop_prod_unit_nm" class="form-control"
                                               placeholder="단위" title="단위" readonly="readonly" />
                                    </td>
                                    <th>기본단가</th>
                                    <td>
                                        <input type="text" id="pop_prod_price" name="pop_prod_price" class="form-control"
                                               placeholder="기본단가" title="기본단가" readonly="readonly" />
                                    </td>
                                    <th>VAT 여부</th>
                                    <td>
                                        <div style="display: flex; flex-wrap: wrap;">
                                            <div class="custom-control custom-radio my-3">
                                                <input type="radio" checked="" id="customRadio1" name="pop_pur_vat_yn" class="custom-control-input" value="Y">
                                                <label class="custom-control-label" for="customRadio1">포함</label>
                                            </div>
                                            <div class="custom-control custom-radio my-3">
                                                <input type="radio" id="customRadio2" name="pop_pur_vat_yn" class="custom-control-input" value="N">
                                                <label class="custom-control-label" for="customRadio2">별도</label>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th>수량 <span class="red"> (필수)</span></th>
                                    <td>
                                        <input type="text" id="pop_pur_cnt" name="pop_pur_cnt" class="form-control"
                                               placeholder="매입단가" title="매입단가" required />
                                    </td>
                                    <th>단가 <span class="red"> (필수)</span></th>
                                    <td>
                                        <input type="text" id="pop_pur_price" name="pop_pur_price" class="form-control"
                                               placeholder="매입단가" title="매입단가" required />
                                    </td>
                                    <th>금액 <span class="red"> (필수)</span></th>
                                    <td>
                                        <input type="text" id="pop_pur_amt" name="pop_pur_amt" class="form-control"
                                               placeholder="금액" title="금액" required />
                                    </td>
                                    <th>VAT <span class="red"> (필수)</span></th>
                                    <td>
                                        <input type="text" id="pop_pur_vat" name="pop_pur_vat" class="form-control"
                                               placeholder="VAT" title="VAT" required />
                                    </td>
                                </tr>
                                <tr>
                                    <th>비고</th>
                                    <td colspan="7">
                                        <input type="text" id="pop_pur_notice" name="pop_pur_notice" class="form-control" placeholder="비고" title="비고" />
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </form>


                    <div class="mb-3 isNew" style="display: flex; justify-content: center;">
                        <button type="button" id="btnSetSubList" class="btn btn-primary ">
                            <span class="btn-wrapper--icon">
                                <i class="fas fa-angle-double-down"></i>
                            </span>
                            <span class="btn-wrapper--label">추가</span>
                        </button>
                    </div>

                    <div class="isNew" style="height: 400px; overflow: auto;">
                        <table id="tblPopSubData" class="table table-hover table-bpurchaseed mb-3 table-form">
                            <colgroup>
                                <col style="width: 12%" />
                                <col style="width: 10%" />
                                <col style="width: 12%" />
                                <col style="width: 8%" />
                                <col style="width: 8%" />
                                <col style="width: 8%" />
                                <col style="width: 7%" />
                                <col style="width: 7%" />
                                <col style="width: 9%" />
                                <col style="width: 9%" />
                                <col style="width: 10%" />
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>거래처</th>
                                    <th>품번</th>
                                    <th>품명</th>
                                    <th>규격</th>
                                    <th>매입일</th>
                                    <th>납기요청일</th>
                                    <th>수량</th>
                                    <th>단가</th>
                                    <th>금액</th>
                                    <th>VAT</th>
                                    <th>관리</th>
                                </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>
                </div>

            <div class="modal-footer">
                <button type="button" id="btnPopRegist" class="btn btn-primary ">
                    <span class="btn-wrapper--icon">
                        <i class="fas fa-download"></i>
                    </span>
                    <span class="btn-wrapper--label">저장</span>
                </button>

                <button type="button" id="btnPopModify" class="btn btn-primary" style="display: none;">
                    <span class="btn-wrapper--icon">
                        <i class="fas fa-check"></i>
                    </span>
                    <span class="btn-wrapper--label">수정</span>
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

<script id="popPurchaseTemplete" type="text/x-handlebars-template">
    <tr class="dataList list_tr{{cnt}}">
        <td>
            <input type="hidden" name="pop_sub_pur_cd" class="form-control" value="{{pur_cd}}" />
            <input type="hidden" name="pop_sub_comp_cd" class="form-control" value="{{comp_cd}}" />
            <input type="hidden" name="pop_sub_comp_nm" class="form-control" value="{{comp_nm}}" />
            <input type="hidden" name="pop_sub_prod_cd" class="form-control" value="{{prod_cd}}" />
            <input type="hidden" name="pop_sub_pur_dt" class="form-control" value="{{pur_dt}}" />
            <input type="hidden" name="pop_sub_pur_ship_dt" class="form-control" value="{{pur_ship_dt}}" />
            <input type="hidden" name="pop_sub_pur_vat_yn" class="form-control" value="{{pur_vat_yn}}" />
            <input type="hidden" name="pop_sub_pur_cnt" class="form-control" value="{{pur_cnt}}" />
            <input type="hidden" name="pop_sub_pur_price" class="form-control" value="{{pur_price}}" />
            <input type="hidden" name="pop_sub_pur_amt" class="form-control" value="{{pur_amt}}" />
            <input type="hidden" name="pop_sub_pur_vat" class="form-control" value="{{pur_vat}}" />
            <input type="hidden" name="pop_sub_pur_notice" class="form-control" value="{{pur_notice}}" />
            {{comp_nm}}
        </td>
        <td>
            <input type="hidden" name="pop_sub_prod_pn" class="form-control" value="{{prod_pn}}" />
            <input type="hidden" name="pop_sub_prod_nm" class="form-control" value="{{prod_nm}}" />
            <input type="hidden" name="pop_sub_prod_kind_nm" class="form-control" value="{{prod_kind_nm}}" />
            <input type="hidden" name="pop_sub_prod_group_nm" class="form-control" value="{{prod_group_nm}}" />
            <input type="hidden" name="pop_sub_prod_stand" class="form-control" value="{{prod_stand}}" />
            <input type="hidden" name="pop_sub_prod_unit_nm" class="form-control" value="{{prod_unit_nm}}" />
            <input type="hidden" name="pop_sub_prod_price" class="form-control" value="{{prod_price}}" />
            {{prod_pn}}
        </td>
        <td>{{prod_nm}}</td>
        <td>{{prod_stand}}</td>
        <td>{{pur_dt}}</td>
        <td>{{pur_ship_dt}}</td>
        <td style="text-align: right !important;">{{pur_cnt}}</td>
        <td style="text-align: right !important;">{{pur_price}}</td>
        <td style="text-align: right !important;">{{pur_amt}}</td>
        <td style="text-align: right !important;">{{pur_vat}}</td>
        <td>
            <button class="btn btn-sm btn-success" type="button" onclick="purchaseModifyRow({{cnt}})">수정</button>
            <button class="btn btn-sm btn-danger" type="button" onclick="purchaseDelete({{cnt}})">행삭제</button>
        </td>
    </tr>
</script>

<div class="modal fade dataModal" id="purchasePlanModal" tabindex="-1" role="dialog" aria-labelledby="registModal" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-xl modal-form-xl" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title"><i class="fas fa-edit"></i><span>생산지시</span></h2>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <form id="purchasePlanForm" name="purchasePlanForm" class="dataForm" method="post">
                <div class="modal-body">
                    <table id="tblPopPlanData" class="table table-hover table-bpurchaseed mb-5 table-form">
                        <colgroup>
                            <col style="width: 8%" />
                            <col style="width: 8%" />
                            <col style="width: 8%" />
                            <col style="width: 8%" />
                            <col style="width: 8%" />
                            <col style="width: 14%" />
                            <col style="width: 8%" />
                            <col style="width: 10%" />
                            <col style="width: 10%" />
                            <col style="width: 10%" />
                            <col style="width: 8%" />
                        </colgroup>
                        <thead>
                            <tr>
                                <th>매입번호</th>
                                <th>거래처</th>
                                <th>매입일</th>
                                <th>납기요청일</th>
                                <th>품번</th>
                                <th>품목명</th>
                                <th>규격</th>
                                <th>계획시작일</th>
                                <th>계획종료일</th>
                                <th>계획수량</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
            </form>
            <div class="modal-footer">
                <button type="button" id="btnPopPlanRegist" class="btn btn-primary ">
                    <span class="btn-wrapper--icon">
                        <i class="fas fa-download"></i>
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

<%-- 계획데이터 Templete --%>
<script id="popOrderPlanTemplete" type="text/x-handlebars-template">
    <tr class="dataList list_tr{{cnt}}">
        <td style="text-align: center !important;">
            <input type="hidden" name="pop_pur_cd" value="{{pur_cd}}"/>
            <input type="hidden" name="pop_comp_cd" value="{{comp_cd}}"/>
            <input type="hidden" name="pop_prod_cd" value="{{prod_cd}}"/>
            {{pur_cd}}
        </td>
        <td>
            {{comp_nm}}
        </td>
        <td>
            {{pur_dt}}
        </td>
        <td>
            {{pur_ship_dt}}
        </td>
        <td>
            {{prod_pn}}
        </td>
        <td>
            {{prod_nm}}
        </td>
        <td>
            {{prod_stand}}
        </td>
        <td style="text-align: center;">
            <div class="input-group input-group-seamless">
                <input name="pop_plan_stdt" class="form-control datepicker no-reset" title="생산계획시작일시"
                       placeholder="생산계획시작일시" type="text" value="{{plan_stdt}}" />
                <div class="input-group-append">
                    <span class="input-group-text"><i class="fas fa-calendar"></i></span>
                </div>
            </div>
        </td>
        <td style="text-align: center;">
            <div class="input-group input-group-seamless">
                <input name="pop_plan_eddt" class="form-control datepicker no-reset" title="생산계획종료일시"
                       placeholder="생산계획종료일시" type="text" value="{{plan_eddt}}" />
                <div class="input-group-append">
                    <span class="input-group-text"><i class="fas fa-calendar"></i></span>
                </div>
            </div>
        </td>
        <td>
            <input type="text" name="pop_plan_cnt" class="form-control" value="{{plan_cnt}}"
                   placeholder="생산계획량" title="생산계획량" required />
        </td>
        <td style="text-align: center;">
            <button class="btn btn-sm btn-danger result-delete" type="button" onclick="planResultDelete({{cnt}})">
                <span class="btn-wrapper--icon">
                    <i class="fas fa-minus-circle"></i>
                </span>
                <span class="btn-wrapper--label">삭제</span>
            </button>
        </td>
    </tr>
</script>


<script>

    $(document).ready(() =>
    {
        // DataTables setting
        setDatatable();
        initAutoComplete("#pop_selector");
        initAutoComplete2("#pop_selector2");


        $("input:radio[name=pop_prod_mass_yn]").on("change", () => {
            $("input:radio[name=pop_prod_mass_yn]").each(function() {
            });
        });

        $("#prod_kind, #prod_family, #prod_group").on("change", () => { getData() });

        $("#pop_pur_cnt, #pop_pur_price").on("keyup", () => { calcOrderAmtVat() });

        $("input:radio[name=pop_pur_vat_yn]").on("change", () => { calcOrderAmtVat() });

        // 조회
        $("#btnSearch").on("click", () => { getData() });

        // Add Data - Call Data Form
        $("#btnNew").on("click", () => {
            callEditmodal("매입 등록", "R");
        });

        // 상세조회
        $("#tblMaster").on("dblclick", "tr", function() {
            let pur_cd = $(this).find("input[name=pur_cd]").val();
            callEditmodal("매입 수정", "M");
            getDataOne(pur_cd);
        });

        // 저장
        $("#btnPopRegist").on("click", () => {

            Swal.fire({
                title: '',
                text: "매입 정보를 저장하시겠습니까?",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: '확인',
                cancelButtonText: '취소'
            }).then((result) => {
                if (result.isConfirmed) {
                    registData();
                }
            });
        });

        // 수정
        $("#btnPopModify").on("click", () => {

            Swal.fire({
                title: '',
                text: "매입 정보를 수정하시겠습니까?",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: '확인',
                cancelButtonText: '취소'
            }).then((result) => {
                if (result.isConfirmed) {
                    modifyData();
                }
            });
        });

        // 데이터 삭제
        $("#btnDelete").on("click", () => {

            if($("input[name=listCheck]:checked").length === 0) {
                alert("삭제할 데이터를 선택하세요.");
                return false;
            }

            Swal.fire({
                title: '',
                text: "매입 정보를 삭제하시겠습니까?",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: '확인',
                cancelButtonText: '취소'
            }).then((result) => {
                if (result.isConfirmed) {
                    deleteData();
                }
            });
        });

        $("#btnIn").on("click", () => {

            if($("input[name=listCheck]:checked").length === 0) {
                alert("입고처리 할 매입정보를 선택하세요.");
                return false;
            }

            var isFlag = false;
            let checkItems = [];
            $.each($("input[name=listCheck]:checked"), function(item, index) {
                checkItems.push($(this).closest("tr").find("input[name=pur_cd]").val());
                if($(this).closest("tr").find("input[name=pur_state]").val() != '30') {
                    isFlag = true;
                    return false;
                }
            });

            if(isFlag) {
                eAlert("[발주] 상태의 매입건만 일괄입고 할 수 있습니다.");
                return false;
            }

            Swal.fire({
                title: '',
                text: "일괄입고 처리하시겠습니까?",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: '확인',
                cancelButtonText: '취소'
            }).then((result) => {
                if (result.isConfirmed) {

                    showWait('.container-fluid');

                    $.ajax({
                        type: "post"
                        ,url: "/mes/material/purchase/purchaseInBundleModify"
                        ,headers: {
                            "Content-Type": "application/json"
                            ,"X-HTTP-Method-Override": "POST"
                        }
                        ,dataType: "text"
                        ,data: JSON.stringify({
                            fact_cd: "${vmap.fact_cd}"
                            ,checkItems: checkItems
                        })
                    })
                    .done(function (data) {
                        hideWait('.container-fluid');
                        getData();
                    })
                    .always(function (data) {

                    })
                    .fail(function (jqHXR, textStatus, errorThrown) {
                        ajaxErrorAlert(jqHXR);
                        hideWait('.container-fluid');
                    });

                }
            });


            // getOrderData();
        });

        // 생산계획생성
        $("#btnPopPlanRegist").on("click", () => {

            if(!parsleyIsValidate("purchasePlanForm")) return false;

            Swal.fire({
                title: '',
                text: "생산계획을 생성하시겠습니까?",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: '확인',
                cancelButtonText: '취소'
            }).then((result) => {
                if (result.isConfirmed) {
                    purchasePlanRegist();
                }
            });
        });

        $("#btnSetSubList").on("click", () => {
            if(!parsleyIsValidate("dataForm")) return false;
            addPopOrderRow();
        });

        setTimeout(() => getData(), 50);

    });

    function initAutoComplete(el)
    {
        $(el).autocomplete({
            search: function(event, ui) {
                if(event.keyCode == 37 || event.keyCode == 38 || event.keyCode == 39 || event.keyCode == 40) {
                    event.preventDefault();
                }
            },
            source : function(reuqest, response) {
                $.ajax({
                    type : 'get',
                    url: '/mes/base/company/compCompletOverlap/' + $(el).val(),
                    dataType : 'json',
                    success : function(data) {
                        // 서버에서 json 데이터 response 후 목록 추가
                        response(
                            $.map(data, function(item) {
                                return {
                                    label : "[" + item.comp_cd + "] " + item.comp_nm,
                                    value : "[" + item.comp_cd + "] " + item.comp_nm,
                                    comp_cd : item.comp_cd,
                                    comp_nm : item.comp_nm
                                }
                            })
                        );
                    }
                });
            },
            select : function(event, ui) {
                $("#pop_comp_cd").val(ui.item.comp_cd);
                $("#pop_comp_nm").val(ui.item.comp_nm);
            },
            focus : function(event, ui) {
                return false;
            },
            minLength : 1,
            autoFocus : true,
            classes : {
                'ui-autocomplete': 'highlight'
            },
            delay : 500,
            position : { my : 'right top', at : 'right bottom' },
            close : function(event) {
                console.log(event);
            }
        });
    }

    function initAutoComplete2(el)
    {
        $(el).autocomplete({
            search: function(event, ui) {
                if(event.keyCode == 37 || event.keyCode == 38 || event.keyCode == 39 || event.keyCode == 40) {
                    event.preventDefault();
                }
            },
            source : function(reuqest, response) {
                $.ajax({
                    type : 'get',
                    url: '/mes/base/product/prodOverlap5/' + $(el).val(),
                    dataType : 'json',
                    success : function(data) {
                        // 서버에서 json 데이터 response 후 목록 추가
                        response(
                            $.map(data, function(item) {
                                return {
                                    label : "[" + item.prod_pn + "] " + item.prod_nm,
                                    value : "[" + item.prod_pn + "] " + item.prod_nm,
                                    prod_cd : item.prod_cd,
                                    prod_pn : item.prod_pn,
                                    prod_nm : item.prod_nm,
                                    prod_kind_nm : item.prod_kind_nm,
                                    prod_group_nm : item.prod_group_nm,
                                    prod_family_nm : item.prod_family_nm,
                                    prod_stand : item.prod_stand,
                                    prod_unit_nm : item.prod_unit_nm,
                                    prod_price : item.prod_price
                                }
                            })
                        );
                    }
                });
            },
            select : function(event, ui) {
                $("#pop_prod_cd").val(ui.item.prod_cd);
                $("#pop_prod_nm").val(ui.item.prod_nm);
                $("#pop_prod_pn").val(ui.item.prod_pn);
                $("#pop_prod_kind_nm").val(ui.item.prod_kind_nm);
                $("#pop_prod_group_nm").val(ui.item.prod_group_nm);
                $("#pop_prod_stand").val(ui.item.prod_stand);
                $("#pop_prod_unit_nm").val(ui.item.prod_unit_nm);
                $("#pop_prod_price").val(ui.item.prod_price.comma());
                $("#pop_pur_price").val(ui.item.prod_price.comma());
            },
            focus : function(event, ui) {
                return false;
            },
            minLength : 1,
            autoFocus : true,
            classes : {
                'ui-autocomplete': 'highlight'
            },
            delay : 500,
            position : { my : 'right top', at : 'right bottom' },
            close : function(event) {
                console.log(event);
            }
        });
    }

    // set tblMaster Database
    function setDatatable()
    {
        var arguments = {
            tabldID: "tblMaster"
            ,purchaseing: true
            // ,responsive: true
            ,purchaseIdx: []
            ,purchaseGubn:	[]
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
                    "purchaseable": false
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
        $(".isNew").show();
        $("#btnPopRegist").show();
        $("#btnPopModify").hide();

        resetForm("dataForm");
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

        $("#pop_pur_dt").val(moment().format('YYYY-MM-DD'));
        $("#pop_pur_ship_dt").val(moment().add(7, 'days').format('YYYY-MM-DD'));
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
            url: "/mes/material/purchase/purchaseList"
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

                // if(item.pur_state == "30") {
                    let checkBoxNode = "<div class=\"custom-control custom-checkbox\">" +
                        "    <input type=\"hidden\" name=\"pur_cd\" value=\"" + item.pur_cd + "\">" +
                        "    <input type=\"hidden\" name=\"pur_state\" value=\"" + item.pur_state + "\">" +
                        "    <input type=\"checkbox\" class=\"custom-control-input\" id=\"listCheck_" + index + "\" name=\"listCheck\">" +
                        "    <label class=\"custom-control-label\" for=\"listCheck_" + index + "\"></label>" +
                        "</div>";

                    node.push(checkBoxNode);
                // }else {
                //     node.push("");
                // }

                // node.push("<div class='text-center'>" + IsEmpty(item.pur_cd) + "</div>");
                node.push(IsEmpty(item.comp_nm));
                node.push("<div class='text-center'>" + IsEmpty(item.pur_dt) + "</div>");
                node.push("<div class='text-center'>" + IsEmpty(item.pur_ship_dt) + "</div>");
                node.push(IsEmpty(item.prod_pn));
                node.push(IsEmpty(item.prod_nm));
                node.push(IsEmpty(item.prod_stand));
                node.push(IsEmpty(item.prod_unit_nm));
                node.push("<div class='text-right'>" + IsEmpty(item.pur_cnt.comma('2')) + " " + IsEmpty(item.prod_unit_nm) + "</div>");
                node.push("<div class='text-right'>" + IsEmpty(item.pur_in_cnt.comma('2')) + " " + IsEmpty(item.prod_unit_nm) + "</div>");
                // node.push("<div class='text-center'>" + IsEmpty(item.pur_vat_yn) + "</div>");
                node.push("<div class='text-right'>" + IsEmpty(item.pur_price.comma('2')) + "</div>");
                node.push("<div class='text-right'>" + IsEmpty(item.pur_amt.comma('2')) + "</div>");
                node.push("<div class='text-right'>" + IsEmpty(item.pur_vat.comma('2')) + "</div>");

                if(item.pur_state == '30') {
                    let param = "{"
                        + "pur_cd: '" +  item.pur_cd + "'"
                        + ",pur_cnt: '" +  item.pur_cnt + "'"
                        + ",prod_cd: '" +  item.prod_cd + "'"
                        + ",prod_pn: '" +  item.prod_pn + "'"
                        + ",prod_nm: '" +  item.prod_nm + "'"
                        + ",prod_kind_nm: '" +  item.prod_kind_nm + "'"
                        + ",prod_stand: '" +  item.prod_stand + "'"
                        + ",prod_unit_nm: '" +  item.prod_unit_nm + "'"
                        + ",prod_lot_yn: '" +  item.prod_lot_yn + "'"
                        + "}";

                    let manageButton = "<div style='display: flex; flex-wrap: wrap; justify-content: space-around;' >" +
                        "    <button class=\"btn btn-sm btn btn-first\" type=\"button\" onclick=\"setPurchaseInModify(" + param + ")\">입고</button>" +
                        "</div>";

                    node.push(manageButton);
                }else {
                    node.push("<div class='text-center'>" + IsEmpty(item.pur_in_dt) + "</div>");
                }


                node.push("<div class='text-center red'>" + IsEmpty(item.pur_state_nm) + "</div>");

                // 각 row node 추가
                let row =  $("#tblMaster").DataTable().row.add(node).node();
                if(item.pur_state == "31") {
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

    function getDataOne(pur_cd)
    {
        showWait('.dataModal');

        $.ajax({
            url: "/mes/material/purchase/purchaseOne/" + pur_cd
            ,type: "get"
            ,dataType: "json"
            // ,data: JSON.stringify({})
        })
        .done(function (data)
        {
            setDataOne("pop_", data);
            $("#dataForm").find(".key").prop("disabled", true);
            $("#pop_selector").val('[' + data.comp_cd + ']' + data.comp_nm);
            $("#pop_selector2").val('[' + data.prod_pn + ']' + data.prod_nm);

            $(".isNew").hide();
            if(data.pur_state == "31") {
                $("#btnPopModify").hide();
            }else {
                $("#btnPopModify").show();
            }
            $("#btnPopRegist").hide();

        })
        .always(function (data) {
            hideWait('.dataModal');
        })
        .fail(function (jqHXR, textStatus, errorThrown) {
            ajaxErrorAlert(jqHXR);
        });
    }

    let purchaseRowCnt = 0;
    function addPopOrderRow()
    {
        let template_html = $("#popPurchaseTemplete").html();
        let template = Handlebars.compile(template_html);
        // let rowCnt = $("#tblPopSubData > tbody > tr").length + 1;

        let templateData = {
            // cnt : rowCnt
            cnt: ++purchaseRowCnt
            ,comp_cd: $("#pop_comp_cd").val()
            ,comp_nm: $("#pop_comp_nm").val()
            ,prod_cd: $("#pop_prod_cd").val()
            ,prod_pn: $("#pop_prod_pn").val()
            ,prod_nm: $("#pop_prod_nm").val()
            ,prod_kind_nm: $("#pop_prod_kind_nm").val()
            ,prod_group_nm: $("#pop_prod_group_nm").val()
            ,prod_stand: $("#pop_prod_stand").val()
            ,prod_unit_nm: $("#pop_prod_unit_nm").val()
            ,prod_price: $("#pop_prod_price").val()
            ,pur_dt: $("#pop_pur_dt").val()
            ,pur_ship_dt: $("#pop_pur_ship_dt").val()
            ,pur_vat_yn: $("input:radio[name=pop_pur_vat_yn]:checked").val()
            ,pur_cnt: $("#pop_pur_cnt").val()
            ,pur_price: $("#pop_pur_price").val()
            ,pur_amt: $("#pop_pur_amt").val()
            ,pur_vat: $("#pop_pur_vat").val()
            ,pur_notice: $("#pop_pur_notice").val()
        }

        $("#tblPopSubData > tbody").append(template(templateData));

        $("#tblPopSubData .list_tr" + purchaseRowCnt)
            .find("input[name$='cnt'], input[name$='price'], input[name$='amt'], input[name$='total'], input[name$='rate'], input[name$='min'], input[name$='vat']")
            .css("text-align", "right")
            .on("click", function() {
                $(this).select();
            })
            .on("keyup", function() {
                $(this).val($(this).val().comma("2"));
            });

        resetForm2("dataForm");
    }

    function purchaseModifyRow(cnt)
    {
        let comp_cd = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_comp_cd]").val();
        let comp_nm = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_comp_nm]").val();
        let prod_cd = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_prod_cd]").val();
        let pur_dt = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_pur_dt]").val();
        let pur_ship_dt = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_pur_ship_dt]").val();
        let pur_vat_yn = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_pur_vat_yn]").val();
        let pur_cnt = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_pur_cnt]").val();
        let pur_price = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_pur_price]").val();
        let pur_amt = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_pur_amt]").val();
        let pur_vat = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_pur_vat]").val();
        let pur_notice = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_pur_notice]").val();

        let prod_pn = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_prod_pn]").val();
        let prod_nm = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_prod_nm]").val();
        let prod_kind_nm = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_prod_kind_nm]").val();
        let prod_group_nm = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_prod_group_nm]").val();
        let prod_stand = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_prod_stand]").val();
        let prod_unit_nm = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_prod_unit_nm]").val();
        let prod_price = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_prod_price]").val();

        $("input[name=pop_pur_vat_yn]").val([pur_vat_yn]);
        $("#pop_comp_cd").val(comp_cd);
        $("#pop_comp_nm").val(comp_nm);
        $("#pop_selector").val('['+comp_cd+']'+comp_nm);
        $("#pop_prod_cd").val(prod_cd);
        $("#pop_selector2").val('['+prod_pn+']'+prod_nm);
        $("#pop_pur_dt").val(pur_dt);
        $("#pop_pur_ship_dt").val(pur_ship_dt);
        $("#pop_pur_cnt").val(pur_cnt);
        $("#pop_pur_price").val(pur_price);
        $("#pop_pur_amt").val(pur_amt);
        $("#pop_pur_vat").val(pur_vat);
        $("#pop_pur_notice").val(pur_notice);
        $("#pop_prod_pn").val(prod_pn);
        $("#pop_prod_nm").val(prod_nm);
        $("#pop_prod_kind_nm").val(prod_kind_nm);
        $("#pop_prod_group_nm").val(prod_group_nm);
        $("#pop_prod_stand").val(prod_stand);
        $("#pop_prod_unit_nm").val(prod_unit_nm);
        $("#pop_prod_price").val(prod_price);

        $("#tblPopSubData .list_tr" + cnt).remove();
    }

    function purchaseDelete(cnt)
    {
        let pur_cd = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_pur_cd]").val();

        if(IsNull(pur_cd))
        {
            $("#tblPopSubData .list_tr" + cnt).remove();
        }
        else
        {
            // Swal.fire({
            // title: '',
            // text: "매입-BOM 정보를 삭제하시겠습니까?",
            // icon: 'warning',
            // showCancelButton: true,
            // confirmButtonColor: '#3085d6',
            // cancelButtonColor: '#d33',
            // confirmButtonText: '확인',
            // cancelButtonText: '취소'
            // }).then((result) => {
            //     if (result.isConfirmed)
            //     {
            //         showWait('.dataModal');
            //
            //         $.ajax({
            //             type: "delete"
            //             ,url: "/mes/material/purchase/bom/purchaseBomDelete"
            //             ,headers: {
            //                 "Content-Type": "application/json"
            //                 ,"X-HTTP-Method-Override": "DELETE"
            //             }
            //             ,dataType: "text"
            //             ,data: JSON.stringify({
            //                 prod_bom_cd: prod_bom_cd
            //             })
            //         })
            //         .done(function (data) {
            //             getProductBomData();
            //             hideWait('.dataModal');
            //         })
            //         .always(function (data) {
            //
            //         })
            //         .fail(function (jqHXR, textStatus, errorThrown) {
            //             ajaxErrorAlert(jqHXR);
            //         });
            //     }
            // });
        }
    }

    // Add Data - ajax regist
    function registData()
    {
        showWait('.dataModal');

        //. Data List
        let ary_pur_cd = [];
        let ary_comp_cd = [];
        let ary_prod_cd = [];
        let ary_pur_dt = [];
        let ary_pur_ship_dt = [];
        let ary_pur_vat_yn = [];
        let ary_pur_cnt = [];
        let ary_pur_price = [];
        let ary_pur_amt = [];
        let ary_pur_vat = [];
        let ary_pur_notice = [];

        $.each($("#tblPopSubData > tbody > tr"), function(index, item)
        {
            ary_pur_cd.push($(item).find("input[name=pop_sub_pur_cd]").val());
            ary_comp_cd.push($(item).find("input[name=pop_sub_comp_cd]").val());
            ary_prod_cd.push($(item).find("input[name=pop_sub_prod_cd]").val());
            ary_pur_dt.push($(item).find("input[name=pop_sub_pur_dt]").val());
            ary_pur_ship_dt.push($(item).find("input[name=pop_sub_pur_ship_dt]").val());
            ary_pur_vat_yn.push($(item).find("input[name=pop_sub_pur_vat_yn]").val());
            ary_pur_cnt.push($(item).find("input[name=pop_sub_pur_cnt]").val().replace(/,/g, ""));
            ary_pur_price.push($(item).find("input[name=pop_sub_pur_price]").val().replace(/,/g, ""));
            ary_pur_amt.push($(item).find("input[name=pop_sub_pur_amt]").val().replace(/,/g, ""));
            ary_pur_vat.push($(item).find("input[name=pop_sub_pur_vat]").val().replace(/,/g, ""));
            ary_pur_notice.push($(item).find("input[name=pop_sub_pur_notice]").val());
        });

        $.ajax({
            type: "post"
            ,url: "/mes/material/purchase/purchaseRegist"
            ,headers: {
                "Content-Type": "application/json"
                ,"X-HTTP-Method-Override": "POST"
            }
            ,dataType: "text"
            ,data: JSON.stringify({
                fact_cd: "${vmap.fact_cd}"
                ,ary_pur_cd: ary_pur_cd
                ,ary_comp_cd: ary_comp_cd
                ,ary_prod_cd: ary_prod_cd
                ,ary_pur_dt: ary_pur_dt
                ,ary_pur_ship_dt: ary_pur_ship_dt
                ,ary_pur_vat_yn: ary_pur_vat_yn
                ,ary_pur_cnt: ary_pur_cnt
                ,ary_pur_price: ary_pur_price
                ,ary_pur_amt: ary_pur_amt
                ,ary_pur_vat: ary_pur_vat
                ,ary_pur_notice: ary_pur_notice
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

    function setPurchaseInModify()
    {
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
                        ,pur_cd: arguments[0].pur_cd
                        ,pur_cnt: arguments[0].pur_cnt.replace(/,/g, "")
                        ,prod_cd: arguments[0].prod_cd
                        ,prod_lot_yn: arguments[0].prod_lot_yn
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

    // modify Data - ajax modify
    function modifyData()
    {
        showWait('.dataModal');

        $.ajax({
            type: "post"
            ,url: "/mes/material/purchase/purchaseModify"
            ,headers: {
                "Content-Type": "application/json"
                ,"X-HTTP-Method-Override": "POST"
            }
            ,dataType: "text"
            ,data: JSON.stringify({
                fact_cd: "${vmap.fact_cd}"
                ,pur_cd: $("#pop_pur_cd").val()
                ,comp_cd: $("#pop_comp_cd").val()
                ,comp_nm: $("#pop_comp_nm").val()
                ,prod_cd: $("#pop_prod_cd").val()
                ,prod_pn: $("#pop_prod_pn").val()
                ,prod_nm: $("#pop_prod_nm").val()
                ,prod_kind_nm: $("#pop_prod_kind_nm").val()
                ,prod_group_nm: $("#pop_prod_group_nm").val()
                ,prod_stand: $("#pop_prod_stand").val()
                ,prod_unit_nm: $("#pop_prod_unit_nm").val()
                ,prod_price: $("#pop_prod_price").val()
                ,pur_dt: $("#pop_pur_dt").val()
                ,pur_ship_dt: $("#pop_pur_ship_dt").val()
                ,pur_vat_yn: $("input:radio[name=pop_pur_vat_yn]:checked").val()
                ,pur_cnt: $("#pop_pur_cnt").val().replace(/,/g, "")
                ,pur_price: $("#pop_pur_price").val().replace(/,/g, "")
                ,pur_amt: $("#pop_pur_amt").val().replace(/,/g, "")
                ,pur_vat: $("#pop_pur_vat").val().replace(/,/g, "")
                ,pur_notice: $("#pop_pur_notice").val()
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

    function deleteData()
    {

        var isFlag = false;
        let purchaseDeleteItems = [];
        $.each($("input[name=listCheck]:checked"), function(item, index) {
            purchaseDeleteItems.push($(this).closest("tr").find("input[name=pur_cd]").val());
            if($(this).closest("tr").find("input[name=pur_state]").val() == '31') {
                isFlag = true;
                return false;
            }
        });

        if(isFlag) {
            eAlert("매입삭제는 상태가 [발주]인 항목만 가능합니다.");
            return false;
        }

        showWait('.container-fluid');

        $.ajax({
            type: "delete"
            ,url: "/mes/material/purchase/purchasePackDelete"
            ,headers: {
                "Content-Type": "application/json"
                ,"X-HTTP-Method-Override": "DELETE"
            }
            ,dataType: "text"
            ,data: JSON.stringify({
                purchaseDeleteItems: purchaseDeleteItems
            })
        })
        .done(function (data) {
            getData();
            hideWait('.container-fluid');
        })
        .always(function (data) {

        })
        .fail(function (jqHXR, textStatus, errorThrown) {
            ajaxErrorAlert(jqHXR);
        });
    }

    function calcOrderAmtVat()
    {
        let odrCnt = $("#pop_pur_cnt").val().replace(/,/g, "");
        let odrPrice = $("#pop_pur_price").val().replace(/,/g, "");
        let odrVatYn = $("input:radio[name=pop_pur_vat_yn]:checked").val();
        let odrTempAmt = parseFloat(odrCnt) * parseFloat(odrPrice);
        let odrAmt;
        let odrVat;

        if(odrVatYn === "Y") {
            odrAmt = Math.round(odrTempAmt / 1.1);
            odrVat = odrTempAmt - odrAmt;
        }else {
            odrVat = Math.round(odrTempAmt / 10);
            odrAmt = odrTempAmt;
        }

        $("#pop_pur_amt").val(odrAmt.comma());
        $("#pop_pur_vat").val(odrVat.comma());
    }

    function getOrderData()
    {
        var isFlag = false;
        let checkItems = [];
        $.each($("input[name=listCheck]:checked"), function(item, index) {
            checkItems.push($(this).closest("tr").find("input[name=pur_cd]").val());
            if($(this).closest("tr").find("input[name=pur_state]").val() != '01') {
                isFlag = true;
                return false;
            }
        });

        if(isFlag) {
            eAlert("생산지시는 상태가 [매입등록]인 항목만 가능합니다.");
            return false;
        }

        showWait('.container-fluid');

        $.ajax({
            url: "/mes/material/purchase/purchaseList2"
            ,type: "post"
            ,headers: {
                "Content-Type": "application/json"
                ,"X-HTTP-Method-Override": "POST"
            }
            ,dataType: "json"
            ,data: JSON.stringify({
                fact_cd: "${vmap.fact_cd}"
                ,checkItems: checkItems
            })
        })
        .done(function (data)
        {
            $("#purchasePlanModal").modal("show");
            $("#tblPopPlanData tbody").empty();

            data.forEach((item, index) => {
                addPopOrderPlanRow(item);
            });
        })
        .always(function (data) {
            hideWait('.container-fluid');
        })
        .fail(function (jqHXR, textStatus, errorThrown) {
            ajaxErrorAlert(jqHXR);
        });
    }

    function addPopOrderPlanRow(data)
    {
        let template_html = $("#popOrderPlanTemplete").html();
        let template = Handlebars.compile(template_html);
        let resultRowCnt = $("#tblPopPlanData > tbody > tr").length + 1;
        let templateData;

        templateData = {
            cnt : resultRowCnt
            ,pur_cd: data.pur_cd
            ,comp_cd: data.comp_cd
            ,prod_cd: data.prod_cd
            ,comp_nm: data.comp_nm
            ,pur_dt: data.pur_dt
            ,pur_ship_dt: data.pur_ship_dt
            ,prod_pn: data.prod_pn
            ,prod_nm: data.prod_nm
            ,prod_stand: data.prod_stand
            ,plan_stdt: data.pur_dt
            ,plan_eddt: data.pur_dt
            ,plan_cnt: data.pur_cnt.comma('3')
        };

        $("#tblPopPlanData > tbody").append(template(templateData));

        setDatePicker("datepicker");

        $("#tblPopPlanData .list_tr" + resultRowCnt)
            .find("input[name$='cnt'], input[name$='price'], input[name$='amt'], input[name$='total'], input[name$='rate'], input[name$='min'], input[name$='vat']")
            .css("text-align", "right")
            .on("click", function() {
                $(this).select();
            })
            .on("keyup", function() {
                $(this).val($(this).val().comma("2"));
            });
    }


    function purchasePlanRegist()
    {
        showWait('.dataModal');

        //. Data List
        let ary_pur_cd = [];
        let ary_comp_cd = [];
        let ary_prod_cd = [];
        let ary_plan_stdt = [];
        let ary_plan_eddt = [];
        let ary_plan_cnt = [];

        $.each($("#tblPopPlanData > tbody > tr"), function(index, item)
        {
            ary_pur_cd.push($(item).find("input[name=pop_pur_cd]").val());
            ary_comp_cd.push($(item).find("input[name=pop_comp_cd]").val());
            ary_prod_cd.push($(item).find("input[name=pop_prod_cd]").val());
            ary_plan_stdt.push($(item).find("input[name=pop_plan_stdt]").val());
            ary_plan_eddt.push($(item).find("input[name=pop_plan_eddt]").val());
            ary_plan_cnt.push($(item).find("input[name=pop_plan_cnt]").val().replace(/,/g, ""));
        });

        $.ajax({
            type: "post"
            ,url: "/mes/material/purchase/purchasePlanRegist"
            ,headers: {
                "Content-Type": "application/json"
                ,"X-HTTP-Method-Override": "POST"
            }
            ,dataType: "text"
            ,data: JSON.stringify({
                fact_cd: "${vmap.fact_cd}"
                ,ary_pur_cd: ary_pur_cd
                ,ary_comp_cd: ary_comp_cd
                ,ary_prod_cd: ary_prod_cd
                ,ary_plan_stdt: ary_plan_stdt
                ,ary_plan_eddt: ary_plan_eddt
                ,ary_plan_cnt: ary_plan_cnt
            })
        })
        .done(function (data) {
            hideWait('.dataModal');
            $("#purchasePlanModal").modal("hide");
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

<%@ include file="/WEB-INF/include/footer.jspf" %>