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
                <i class="fas fa-home"></i> <i class="fas fa-arrow-circle-right"></i> 생산관리 <i class="fas fa-arrow-circle-right"></i> 생산실적
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
                                        <th style="width: 14%">계획일</th>
                                        <th style="width: 10%">작업지시번호</th>
                                        <th style="width: 8%">품번</th>
                                        <th style="width: 12%">품목명</th>
                                        <th>규격</th>
                                        <th style="width: 8%">공정</th>
                                        <th style="width: 8%">순서</th>
                                        <th style="width: 8%">계획수량</th>
                                        <th style="width: 8%">생산수량</th>
                                        <th style="width: 8%">진척률</th>
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

<%-- 실적 데이터 Modal --%>
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
                            <th>공정</th>
                            <td>
                                <div class="red" id="pop_proc_nm" name="pop_proc_nm"></div>
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
                                <div class="red" id="pop_plan_proc_cnt" name="pop_plan_proc_cnt"></div>
                            </td>

                        </tr>
                    </tbody>
                </table>

                <form id="dataForm" name="dataForm" class="dataForm" method="post">
                    <div style="height: 500px; overflow: auto;">
                        <table id="tblPopResultData" class="table table-hover table-bordered mb-3 table-form">
                            <colgroup>
                                <col style="width: 6%" />
                                <col style="width: 10%" />
                                <col style="width: 10%" />
                                <col style="width: 10%" />
                                <col style="width: 10%" />
                                <col style="width: 8%" />
                                <col style="width: 12%" />
                                <col style="width: 24%" />
                            </colgroup>
                            <thead>
                            <tr>
                                <th>순서</th>
                                <th>설비 <span class="red"> (필수)</span></th>
                                <th>작업자 <span class="red"> (필수)</span></th>
                                <th>작업시작일 <span class="red"> (필수)</span></th>
                                <th>작업종료일 <span class="red"> (필수)</span></th>
                                <th>생산량 <span class="red"> (필수)</span></th>
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
                <button type="button" id="btnPopProcessComplete" class="btn btn-danger ">
                    <span class="btn-wrapper--icon">
                        <i class="fab fa-yelp"></i>
                    </span>
                    <span class="btn-wrapper--label">공정생산완료</span>
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

<%-- 실적데이터 Templete --%>
<script id="popPlanResultTemplete" type="text/x-handlebars-template">
    <tr class="dataList list_tr{{cnt}}">
        <td style="text-align: center !important;">
            <input type="hidden" name="pop_plan_res_cd" class="form-control" value="{{plan_res_cd}}" />
            {{cnt}}
        </td>
        <td>
            <select name="pop_equ_cd" class="custom-select w-100" style="width: 100% !important;" required>
                <option value="">설비선택</option>
                <c:forEach var="item" items="${vmap.equList}" varStatus="status">
                    <option value="${item.equ_cd}">${item.equ_nm}</option>
                </c:forEach>
            </select>
        </td>
        <td>
            <select name="pop_plan_res_u_cd" class="custom-select w-100" style="width: 100% !important;" required>
                <option value="">사용자선택</option>
                <c:forEach var="item" items="${vmap.userList}" varStatus="status">
                    <option value="${item.u_cd}">${item.u_nm}</option>
                </c:forEach>
            </select>
        </td>
        <td style="text-align: center;">
            <input type="text" name="pop_plan_res_stdt" class="form-control datetimepicker" value="{{plan_res_stdt}}"
                   placeholder="생산시작일시" title="생산시작일시" required />
        </td>
        <td style="text-align: center;">
            <input type="text" name="pop_plan_res_eddt" class="form-control datetimepicker" value="{{plan_res_eddt}}"
                   placeholder="생산종료일시" title="생산종료일시" required />
        </td>
        <td>
            <input type="hidden" name="pop_old_plan_res_cnt" class="form-control" value="{{old_plan_res_cnt}}"
                   placeholder="이전생산량" title="이전생산량" required />
            <input type="text" name="pop_plan_res_cnt" class="form-control" value="{{plan_res_cnt}}"
                   placeholder="생산량" title="생산량" required />
        </td>
        <td>
            <input type="text" name="pop_plan_res_notice" class="form-control" value="{{plan_res_notice}}"
                   placeholder="비고" title="비고" />
        </td>
        <td style="text-align: center;">
            <button class="btn btn-sm btn-dark result-stop" type="button" onclick="callPlanStop({{cnt}})">
                <span class="btn-wrapper--icon">
                    <i class="fas fa-stop"></i>
                </span>
                <span class="btn-wrapper--label">비가동</span>
            </button>
            <button class="btn btn-sm btn-success result-input" type="button" onclick="callPlanInput({{cnt}})">
                <span class="btn-wrapper--icon">
                    <i class="fas fa-share"></i>
                </span>
                <span class="btn-wrapper--label">투입자재</span>
            </button>
            <button class="btn btn-sm btn-primary result-regist" type="button" onclick="planResultRegist({{cnt}})">
                <span class="btn-wrapper--icon">
                    <i class="fas fa-check"></i>
                </span>
                <span class="btn-wrapper--label">저장</span>
            </button>
            <button class="btn btn-sm btn-warning result-modify" type="button" onclick="planResultModify({{cnt}})">
                <span class="btn-wrapper--icon">
                    <i class="fas fa-check"></i>
                </span>
                <span class="btn-wrapper--label">수정</span>
            </button>
            <button class="btn btn-sm btn-danger result-delete" type="button" onclick="planResultDelete({{cnt}})">
                <span class="btn-wrapper--icon">
                    <i class="fas fa-minus-circle"></i>
                </span>
                <span class="btn-wrapper--label">삭제</span>
            </button>
        </td>
    </tr>
</script>

<%-- 투입자재 등록 조회 Modal --%>
<div class="modal fade dataModal inputModal" id="inputModal" tabindex="-1" role="dialog" aria-labelledby="registModal" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-xl modal-form-xl" role="document">
        <div class="modal-content" style="width: 80%;">
            <div class="modal-header">
                <h2 class="modal-title"><i class="fas fa-indent"></i> 투입자재현황</h2>
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
    <%--                                <th>--%>
    <%--                                    <button type="button" id="btnAddSubList" class="btn btn-primary btn-sm">--%>
    <%--                                        <span class="btn-wrapper--icon">--%>
    <%--                                            <i class="fas fa-angle-double-down"></i>--%>
    <%--                                        </span>--%>
    <%--                                        <span class="btn-wrapper--label">추가</span>--%>
    <%--                                    </button>--%>
    <%--                                </th>--%>
                                </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>
                </form>
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

<%-- 투입데이터 Templete --%>
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
<%--        <td style="text-align: center;">--%>
<%--            <button class="btn btn-sm btn-primary result-regist" type="button" onclick="planResultRegist({{cnt}})">--%>
<%--                <span class="btn-wrapper--icon">--%>
<%--                    <i class="fas fa-check"></i>--%>
<%--                </span>--%>
<%--                <span class="btn-wrapper--label">저장</span>--%>
<%--            </button>--%>
<%--            <button class="btn btn-sm btn-warning result-modify" type="button" onclick="planResultModify({{cnt}})">--%>
<%--                <span class="btn-wrapper--icon">--%>
<%--                    <i class="fas fa-check"></i>--%>
<%--                </span>--%>
<%--                <span class="btn-wrapper--label">수정</span>--%>
<%--            </button>--%>
<%--            <button class="btn btn-sm btn-danger" type="button" onclick="planResultDelete({{cnt}})">--%>
<%--                <span class="btn-wrapper--icon">--%>
<%--                    <i class="fas fa-minus-circle"></i>--%>
<%--                </span>--%>
<%--                <span class="btn-wrapper--label">삭제</span>--%>
<%--            </button>--%>
<%--        </td>--%>
    </tr>
</script>

<%-- 비가동 데이터 Modal --%>
<div class="modal fade dataModal stopModal" id="stopModal" tabindex="-1" role="dialog" aria-labelledby="registModal" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-xl modal-form-xl" role="document">
        <div class="modal-content" style="width: 80%;">
            <div class="modal-header">
                <h2 class="modal-title"><i class="fas fa-stop-circle"></i> 비가동등록</h2>
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
                    <div style="height: 500px; overflow: auto;">
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
                                    <button type="button" id="btnAddStopSubList" class="btn btn-primary btn-sm">
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
                <button type="button" id="btnPopStopRegist" class="btn btn-primary ">
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
            <button class="btn btn-sm btn-danger" type="button" onclick="planStopDelete({{cnt}})">
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
        initAutoComplete("#pop_selector");
        initAutoComplete2("#pop_selector2");

        $("input:radio[name=pop_prod_mass_yn]").on("change", () => {
            $("input:radio[name=pop_prod_mass_yn]").each(function() {
            });
        });

        $("#prod_kind, #prod_family, #prod_group").on("change", () => { getData() });

        // 조회
        $("#btnSearch").on("click", () => { getData() });

        // Add Data - Call Data Form
        $("#btnNew").on("click", () => {
            callEditmodal("생산실적 등록", "R");
        });

        // 상세조회
        $("#tblMaster").on("dblclick", "tr", function() {
            let plan_cd = $(this).find("input[name=plan_cd]").val();
            let plan_proc_cd = $(this).find("input[name=plan_proc_cd]").val();
            callEditmodal("생산실적 등록", "M");
            getDataOne(plan_cd, plan_proc_cd);
        });

        // 공정생산완료
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

        $("#btnAddSubList").on("click", () => {
            addPopResultRow();
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

        $("#btnAddStopSubList").on("click", () => {
            addPopStopRow();
        });

        setTimeout(() => getData(), 30);

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
                    url: '/mes/base/product/prodOverlap2/' + $(el).val(),
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
                                    prod_price : item.prod_price,
                                    prod_keep_cnt : item.prod_keep_cnt,
                                    prod_stock_cnt : item.prod_stock_cnt,
                                    prod_mass_yn : item.prod_mass_yn
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
                $("#pop_prod_family_nm").val(ui.item.prod_family_nm);
                $("#pop_prod_stand").val(ui.item.prod_stand);
                $("#pop_prod_unit_nm").val(ui.item.prod_unit_nm);
                $("#pop_prod_keep_cnt").val(ui.item.prod_keep_cnt.comma());
                $("#pop_prod_stock_cnt").val(ui.item.prod_stock_cnt.comma());
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
        $(".isNew").show();
        $(".isProc").hide();
        $("#btnPopRegist").show();
        $("#btnPopModify").hide();

        resetForm("dataForm");
        $("#tblPopResultData tbody").empty();
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
                    //     "    <input type=\"hidden\" name=\"plan_cd\" value=\"" + item.plan_cd + "\">" +
                    //     "    <input type=\"hidden\" name=\"plan_proc_cd\" value=\"" + item.plan_proc_cd + "\">" +
                    //     "    <input type=\"hidden\" name=\"plan_state\" value=\"" + item.plan_state + "\">" +
                    //     "    <input type=\"checkbox\" class=\"custom-control-input\" id=\"listCheck_" + index + "\" name=\"listCheck\">" +
                    //     "    <label class=\"custom-control-label\" for=\"listCheck_" + index + "\"></label>" +
                    //     "</div>";

                    let firstNode = "<div class='text-center'>" +
                                    "    <input type=\"hidden\" name=\"plan_cd\" value=\"" + item.plan_cd + "\">" +
                                    "    <input type=\"hidden\" name=\"plan_proc_cd\" value=\"" + item.plan_proc_cd + "\">" +
                                    "    <input type=\"hidden\" name=\"plan_state\" value=\"" + item.plan_state + "\">" +
                                         IsEmpty(item.plan_stdt) + " ~ " + IsEmpty(item.plan_eddt) +
                                    "</div>";

                    node.push(firstNode);
                    node.push(IsEmpty(item.plan_no));
                    node.push(IsEmpty(item.prod_pn));
                    node.push(IsEmpty(item.prod_nm));
                    node.push(IsEmpty(item.prod_stand));
                    node.push("<div class='text-center'>" + IsEmpty(item.proc_nm) + "</div>");
                    node.push("<div class='text-center'>" + IsEmpty(item.plan_proc_seq) + " / " + IsEmpty(item.tot_proc_cnt) + "</div>");
                    node.push("<div class='text-right'>" + IsEmpty(item.plan_cnt.comma('2')) + " " + IsEmpty(item.prod_unit_nm) + "</div>");
                    node.push("<div class='text-right'>" + IsEmpty(item.plan_proc_cnt.comma('2')) + " " + IsEmpty(item.prod_unit_nm) + "</div>");
                    node.push("<div class='text-center'>" + IsEmpty(item.plan_progress) + "%</div>");
                    node.push("<div class='text-center red'>" + IsEmpty(item.plan_proc_state_nm) + "</div>");

                    // 각 row node 추가
                    let row = $("#tblMaster").DataTable().row.add(node).node();
                    if(item.plan_proc_state == "12") {
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

    function getDataOne(plan_cd, plan_proc_cd)
    {
        showWait('.dataModal');

        $.ajax({
            url: "/mes/production/result/planProcessOne/" + plan_cd + "/" + plan_proc_cd
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

            getPlanResultData();
        })
        .always(function (data) {
            hideWait('.dataModal');
        })
        .fail(function (jqHXR, textStatus, errorThrown) {
            ajaxErrorAlert(jqHXR);
        });
    }

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
                ,plan_cd: $("#pop_plan_cd").val()
                ,plan_proc_cd: $("#pop_plan_proc_cd").val()
            })
        })
            .done(function (data)
            {
                $("#tblPopResultData > tbody").empty();
                resultRowCnt = 0;

                data.forEach((item, index) => {
                    addPopResultRow(item);
                });

                setProcButton();

            })
            .always(function (data) {
                hideWait('.dataModal');
            })
            .fail(function (jqHXR, textStatus, errorThrown) {
                ajaxErrorAlert(jqHXR);
            });
    }

    // let resultRowCnt = 0;
    function addPopResultRow(data)
    {
        let template_html = $("#popPlanResultTemplete").html();
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
                ,plan_res_cd: data.plan_res_cd
                ,plan_res_stdt: data.plan_res_stdt
                ,plan_res_eddt: data.plan_res_eddt
                ,old_plan_res_cnt: data.plan_res_cnt
                ,plan_res_cnt: data.plan_res_cnt.comma('3')
                ,plan_res_notice: data.plan_res_notice
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
    }

    // Add Data - ajax regist
    function planResultRegist(cnt)
    {
        // if(!parsleyIsValidate("dataForm")) return false;
        let $tr = $("#tblPopResultData .list_tr" + cnt);
        let equ_cd = $tr.find("select[name=pop_equ_cd]").val();
        let plan_res_cd = $tr.find("select[name=pop_plan_res_cd]").val();
        let plan_res_u_cd = $tr.find("select[name=pop_plan_res_u_cd]").val();
        let plan_res_stdt = $tr.find("input[name=pop_plan_res_stdt]").val();
        let plan_res_eddt = $tr.find("input[name=pop_plan_res_eddt]").val();
        let old_plan_res_cnt = $tr.find("input[name=pop_old_plan_res_cnt]").val();
        let plan_res_cnt = $tr.find("input[name=pop_plan_res_cnt]").val().replace(/,/g, "");
        let plan_res_notice = $tr.find("input[name=pop_plan_res_notice]").val();

        if(IsNull(equ_cd)) {
            eAlert("설비는 필수입력항목입니다.");
            $tr.find("select[name=pop_equ_cd]").focus();
            return false;
        }

        if(IsNull(plan_res_u_cd)) {
            eAlert("사용자는 필수입력항목입니다.");
            $tr.find("select[name=pop_u_cd]").focus();
            return false;
        }

        if(IsNull(plan_res_stdt)) {
            eAlert("생산시작일시는 필수입력항목입니다.");
            $tr.find("input[name=pop_plan_res_stdt]").focus();
            return false;
        }

        if(IsNull(plan_res_eddt)) {
            eAlert("생산종료일시는 필수입력항목입니다.");
            $tr.find("input[name=pop_plan_res_eddt]").focus();
            return false;
        }

        if(IsNull(plan_res_cnt) || plan_res_cnt === 0) {
            eAlert("생산량은 필수입력항목입니다.");
            $tr.find("input[name=pop_plan_res_cnt]").focus();
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
                        ,plan_cd: $("#pop_plan_cd").val()
                        ,plan_proc_cd: $("#pop_plan_proc_cd").val()
                        ,odr_cd: $("#pop_odr_cd").val()
                        ,proc_cd: $("#pop_proc_cd").val()
                        ,prod_cd: $("#pop_prod_cd").val()
                        ,plan_proc_last_yn: $("#pop_plan_proc_last_yn").val()
                        ,equ_cd: equ_cd
                        ,plan_res_cd: plan_res_cd
                        ,plan_res_u_cd: plan_res_u_cd
                        ,plan_res_stdt: plan_res_stdt
                        ,plan_res_eddt: plan_res_eddt
                        ,old_plan_res_cnt: old_plan_res_cnt
                        ,plan_res_cnt: plan_res_cnt
                        ,plan_res_notice: plan_res_notice
                    })
                })
                .done(function (data) {
                    hideWait('.dataModal');
                    // getPlanResultData();
                    getDataOne($("#pop_plan_cd").val(), $("#pop_plan_proc_cd").val());
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
    function planResultModify(cnt)
    {
        let $tr = $("#tblPopResultData .list_tr" + cnt);
        let plan_res_cd = $tr.find("input[name=pop_plan_res_cd]").val();
        let equ_cd = $tr.find("select[name=pop_equ_cd]").val();
        let plan_res_u_cd = $tr.find("select[name=pop_plan_res_u_cd]").val();
        let plan_res_stdt = $tr.find("input[name=pop_plan_res_stdt]").val();
        let plan_res_eddt = $tr.find("input[name=pop_plan_res_eddt]").val();
        let old_plan_res_cnt = $tr.find("input[name=pop_old_plan_res_cnt]").val();
        let plan_res_cnt = $tr.find("input[name=pop_plan_res_cnt]").val().replace(/,/g, "");
        let plan_res_notice = $tr.find("input[name=pop_plan_res_notice]").val();

        if(IsNull(equ_cd)) {
            eAlert("설비는 필수입력항목입니다.");
            $tr.find("select[name=pop_equ_cd]").focus();
            return false;
        }

        if(IsNull(plan_res_u_cd)) {
            eAlert("사용자는 필수입력항목입니다.");
            $tr.find("select[name=pop_u_cd]").focus();
            return false;
        }

        if(IsNull(plan_res_stdt)) {
            eAlert("생산시작일시는 필수입력항목입니다.");
            $tr.find("input[name=pop_plan_res_stdt]").focus();
            return false;
        }

        if(IsNull(plan_res_eddt)) {
            eAlert("생산종료일시는 필수입력항목입니다.");
            $tr.find("input[name=pop_plan_res_eddt]").focus();
            return false;
        }

        if(IsNull(plan_res_cnt) || plan_res_cnt === 0) {
            eAlert("생산량은 필수입력항목입니다.");
            $tr.find("input[name=pop_plan_res_cnt]").focus();
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
                        ,plan_cd: $("#pop_plan_cd").val()
                        ,plan_proc_cd: $("#pop_plan_proc_cd").val()
                        ,odr_cd: $("#pop_odr_cd").val()
                        ,proc_cd: $("#pop_proc_cd").val()
                        ,prod_cd: $("#pop_prod_cd").val()
                        ,plan_proc_last_yn: $("#pop_plan_proc_last_yn").val()
                        ,plan_res_cd: plan_res_cd
                        ,equ_cd: equ_cd
                        ,plan_res_u_cd: plan_res_u_cd
                        ,plan_res_stdt: plan_res_stdt
                        ,plan_res_eddt: plan_res_eddt
                        ,old_plan_res_cnt: old_plan_res_cnt
                        ,plan_res_cnt: plan_res_cnt
                        ,plan_res_notice: plan_res_notice
                    })
                })
                .done(function (data) {
                    hideWait('.dataModal');
                    getDataOne($("#pop_plan_cd").val(), $("#pop_plan_proc_cd").val());
                    // getPlanResultData();
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

    function planResultDelete(cnt)
    {
        let plan_res_cd = $("#tblPopResultData .list_tr" + cnt).find("[name=pop_plan_res_cd]").val();

        if(IsNull(plan_res_cd))
        {
            $("#tblPopResultData .list_tr" + cnt).remove();
        }
        else
        {
            Swal.fire({
                title: '',
                text: "생산실적정보를 삭제하시겠습니까?",
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
                        ,url: "/mes/production/result/planResultDelete"
                        ,headers: {
                            "Content-Type": "application/json"
                            ,"X-HTTP-Method-Override": "DELETE"
                        }
                        ,dataType: "text"
                        ,data: JSON.stringify({
                            plan_cd: $("#pop_plan_cd").val()
                            ,plan_proc_cd: $("#pop_plan_proc_cd").val()
                            ,odr_cd: $("#pop_odr_cd").val()
                            ,plan_res_cd: plan_res_cd
                            ,plan_proc_last_yn: $("#pop_plan_proc_last_yn").val()
                        })
                    })
                    .done(function (data) {
                        hideWait('.dataModal');
                        // getPlanResultData();
                        getDataOne($("#pop_plan_cd").val(), $("#pop_plan_proc_cd").val());
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

    function callPlanInput(cnt)
    {
        let $tr = $("#tblPopResultData .list_tr" + cnt);
        let plan_res_cd = $tr.find("input[name=pop_plan_res_cd]").val();

        if(IsNull(plan_res_cd)) {
            eAlert("실적등록 후 사용가능합니다.");
            return false;
        }

        $("#inputModal").modal("show");
        showWait('.dataModal');

        $.ajax({
            url: "/mes/production/result/planResultOne/" + $("#pop_plan_cd").val() + "/" + $("#pop_plan_proc_cd").val() + "/" + plan_res_cd
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
            ,plan_cd: data.plan_cd
            ,plan_proc_cd: data.plan_proc_cd
            ,plan_res_cd: data.plan_res_cd
            ,plan_input_cd: data.plan_input_cd
            ,prod_ja_cd: data.prod_ja_cd
            ,prod_ja_pn: data.prod_ja_pn
            ,prod_ja_nm: data.prod_ja_nm
            ,prod_ja_group_nm: data.prod_ja_group_nm
            ,prod_ja_stand: data.prod_ja_stand
            ,prod_ja_unit_nm: data.prod_ja_unit_nm
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
        let plan_res_cd = $tr.find("input[name=pop_plan_res_cd]").val();

        if(IsNull(plan_res_cd)) {
            eAlert("실적등록 후 사용가능합니다.");
            return false;
        }

        $("#stopModal").modal("show");
        showWait('.dataModal');

        $.ajax({
            url: "/mes/production/result/planResultOne/" + $("#pop_plan_cd").val() + "/" + $("#pop_plan_proc_cd").val() + "/" + plan_res_cd
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
                ,plan_cd: $("#pop_plan_cd").val()
                ,plan_proc_cd: $("#pop_plan_proc_cd").val()
                ,plan_res_cd: plan_res_cd
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
                ,plan_cd: data.plan_cd
                ,plan_proc_cd: data.plan_proc_cd
                ,plan_res_cd: data.plan_res_cd
                ,plan_stop_cd: data.plan_stop_cd
                ,plan_stop_stdt: data.plan_stop_stdt
                ,plan_stop_eddt: data.plan_stop_eddt
                ,plan_stop_time: data.plan_stop_time
                ,plan_stop_notice: data.plan_stop_notice
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
                ,plan_cd: $("#pop_plan_cd").val()
                ,plan_proc_cd: $("#pop_plan_proc_cd").val()
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

    function setProcButton()
    {
        let completeYn = $("#pop_plan_proc_state").val() === "12" ? true : false;

        $("#btnPopProcessComplete").attr("disabled", completeYn);

        $.each($("#tblPopResultData > tbody > tr"), function(index, item)
        {
            $(item).find(".result-regist").attr("disabled", completeYn);
            $(item).find(".result-modify").attr("disabled", completeYn);
            $(item).find(".result-delete").attr("disabled", completeYn);
        });
    }


</script>

<%@ include file="/WEB-INF/include/footer.jspf" %>