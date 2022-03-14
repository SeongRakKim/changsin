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
    <div class="menu-nav">
        <div>
            <!-- Page Heading -->
<%--            <span class="btn btn-pill btn-secondary">--%>
            <span class="btn btn-pill btn-sm btn-primary">
                <i class="fas fa-home"></i> <i class="fas fa-chevron-right"></i> 영업관리 <i class="fas fa-chevron-right"></i> 수주관리
            </span>
        </div>

        <%@ include file="/WEB-INF/include/main-top-right.jspf"%>
    </div>

    <%@ include file="/WEB-INF/include/main-progress.jspf"%>

    <div class="main-content">
        <table class="tableSearch table table-hover table-striped table-bordered mb-5" style="margin-bottom: 0.5rem !important;">
            <colgroup>
                <col style="width: 10%">
                <col style="width: 40%">
                <col style="width: 10%">
                <col style="width: 40%">
            </colgroup>
            <thead class="thead-light">
                <tr>
                    <th>검색날짜</th>
                    <td colspan="3">
                        <%@ include file="/WEB-INF/include/main-search-date-content.jspf"%>
                    </td>
                </tr>
                <tr>
<%--                    <th>수주종류</th>--%>
<%--                    <td>--%>
<%--                        <select id="prod_kind" name="prod_kind" class="custom-select w-100" required="">--%>
<%--                            <option value="">수주종류선택</option>--%>
<%--                            <option value="PA">완수주</option>--%>
<%--                            <option value="PH">반수주</option>--%>
<%--                        </select>--%>
<%--                    </td>--%>
<%--                    <th>수주분류</th>--%>
<%--                    <td>--%>
<%--                        <select id="prod_group" name="prod_group" class="custom-select w-100" required="">--%>
<%--                            <option value="">수주분류선택</option>--%>
<%--                            <c:forEach var="item" items="${vmap.prodGroupList}" varStatus="status">--%>
<%--                                <option value="${item.base_detail_cd}">${item.base_detail_nm}</option>--%>
<%--                            </c:forEach>--%>
<%--                        </select>--%>
<%--                    </td>--%>
<%--                    <th>수주군</th>--%>
<%--                    <td>--%>
<%--                        <select id="prod_family" name="prod_family" class="custom-select w-100" required="">--%>
<%--                            <option value="">수주군선택</option>--%>
<%--                            <c:forEach var="item" items="${vmap.prodFamilyList}" varStatus="status">--%>
<%--                                <option value="${item.base_detail_cd}">${item.base_detail_nm}</option>--%>
<%--                            </c:forEach>--%>
<%--                        </select>--%>
<%--                    </td>--%>
<%--                    <th>검색어</th>--%>
<%--                    <td>--%>
<%--                        <div class="input-group">--%>
<%--                            <div class="input-group-prepend">--%>
<%--                                <span class="input-group-text">--%>
<%--                                    <i class="fas fa-search"></i>--%>
<%--                                </span>--%>
<%--                            </div>--%>
<%--                            <input id="search_text" name="search_text" class="form-control" placeholder="검색어" type="text">--%>
<%--                        </div>--%>
<%--                    </td>--%>
                </tr>
            </thead>
        </table>
    </div>

    <div class="card shadow" style="min-height: 770px;">
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
                                        <th>수주코드</th>
                                        <th>품번</th>
                                        <th>품명</th>
                                        <th>종류</th>
                                        <th>분류</th>
                                        <th>수주군</th>
                                        <th>규격</th>
                                        <th>단위</th>
                                        <th>단가</th>
                                        <th>주거래처</th>
                                        <th>양산여부</th>
                                        <th style="width: 11%;">관리</th>
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
                        <table id="tblPopData" class="table table-hover table-bordered mb-3 table-form">
                            <tbody>
                                <tr>
                                    <th>거래처<span class="red"> (필수)</span></th>
                                    <td>
                                        <input type="hidden" id="pop_comp_cd" name="pop_comp_cd" class="form-control no-reset"
                                               placeholder="거래처" title="거래처" />
                                        <input type="hidden" id="pop_comp_nm" name="pop_comp_nm" class="form-control no-reset"
                                               placeholder="거래처" title="거래처" />
                                        <input type="text" id="pop_selector" name="pop_selector" class="form-control no-reset"
                                               placeholder="거래처명" title="거래처명" required />
                                    </td>
                                    <th>수주일<span class="red"> (필수)</span></th>
                                    <td>
                                        <div class="input-group input-group-seamless">
                                            <input id="pop_odr_dt" name="pop_odr_dt" class="form-control datepicker no-reset" title="수주일"
                                                   placeholder="수주일" type="text" />
                                            <div class="input-group-append">
                                                <span class="input-group-text"><i class="fas fa-calendar"></i></span>
                                            </div>
                                        </div>
                                    </td>
                                    <th>납기요청일<span class="red"> (필수)</span></th>
                                    <td>
                                        <div class="input-group input-group-seamless">
                                            <input id="pop_odr_ship_dt" name="pop_odr_ship_dt" class="form-control datepicker no-reset" title="납기요청일"
                                                   placeholder="납기요청일" type="text" />
                                            <div class="input-group-append">
                                                <span class="input-group-text"><i class="fas fa-calendar"></i></span>
                                            </div>
                                        </div>
                                    </td>
                                    <th>프로젝트</th>
                                    <td>
                                        <input type="text" id="pop_odr_project" name="pop_odr_project" class="form-control" placeholder="프로젝트" title="프로젝트" />
                                    </td>
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
                                    <th>제품군</th>
                                    <td>
                                        <input type="text" id="pop_prod_family_nm" name="pop_prod_family_nm" class="form-control"
                                               placeholder="제품군" title="제품군" readonly="readonly" />
                                    </td>
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
                                                <input type="radio" checked="" id="customRadio1" name="pop_odr_vat_yn" class="custom-control-input" value="Y">
                                                <label class="custom-control-label" for="customRadio1">포함</label>
                                            </div>
                                            <div class="custom-control custom-radio my-3">
                                                <input type="radio" id="customRadio2" name="pop_odr_vat_yn" class="custom-control-input" value="N">
                                                <label class="custom-control-label" for="customRadio2">별도</label>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th>수량 <span class="red"> (필수)</span></th>
                                    <td>
                                        <input type="text" id="pop_odr_cnt" name="pop_odr_cnt" class="form-control"
                                               placeholder="수주단가" title="수주단가" required />
                                    </td>
                                    <th>단가 <span class="red"> (필수)</span></th>
                                    <td>
                                        <input type="text" id="pop_odr_price" name="pop_odr_price" class="form-control"
                                               placeholder="수주단가" title="수주단가" required />
                                    </td>
                                    <th>금액 <span class="red"> (필수)</span></th>
                                    <td>
                                        <input type="text" id="pop_odr_amt" name="pop_odr_amt" class="form-control"
                                               placeholder="금액" title="금액" required />
                                    </td>
                                    <th>VAT <span class="red"> (필수)</span></th>
                                    <td>
                                        <input type="text" id="pop_odr_vat" name="pop_odr_vat" class="form-control"
                                               placeholder="VAT" title="VAT" required />
                                    </td>
                                </tr>
                                <tr>
                                    <th>주문자</th>
                                    <td>
                                        <input type="text" id="pop_odr_nm" name="pop_odr_nm" class="form-control" placeholder="주문자" title="주문자" />
                                    </td>
                                    <th>주문자연락처</th>
                                    <td>
                                        <input type="text" id="pop_odr_tel" name="pop_odr_tel" class="form-control" placeholder="주문자연락처" title="주문자연락처" />
                                    </td>
                                    <th>비고</th>
                                    <td colspan="3">
                                        <input type="text" id="pop_odr_notice" name="pop_odr_notice" class="form-control" placeholder="비고" title="비고" />
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
                        <table id="tblPopSubData" class="table table-hover table-bordered mb-3 table-form">
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
                                    <th>수주일</th>
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

                <button type="button" id="btnPopModify" class="btn btn-success ">수정</button>

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

<script id="popOrderTemplete" type="text/x-handlebars-template">
    <tr class="dataList list_tr{{cnt}}">
        <td>
            <input type="hidden" name="pop_sub_odr_cd" class="form-control" value="{{odr_cd}}" />
            <input type="hidden" name="pop_sub_comp_cd" class="form-control" value="{{comp_cd}}" />
            <input type="hidden" name="pop_sub_comp_nm" class="form-control" value="{{comp_nm}}" />
            <input type="hidden" name="pop_sub_prod_cd" class="form-control" value="{{prod_cd}}" />
            <input type="hidden" name="pop_sub_odr_dt" class="form-control" value="{{odr_dt}}" />
            <input type="hidden" name="pop_sub_odr_ship_dt" class="form-control" value="{{odr_ship_dt}}" />
            <input type="hidden" name="pop_sub_odr_vat_yn" class="form-control" value="{{odr_vat_yn}}" />
            <input type="hidden" name="pop_sub_odr_cnt" class="form-control" value="{{odr_cnt}}" />
            <input type="hidden" name="pop_sub_odr_price" class="form-control" value="{{odr_price}}" />
            <input type="hidden" name="pop_sub_odr_amt" class="form-control" value="{{odr_amt}}" />
            <input type="hidden" name="pop_sub_odr_vat" class="form-control" value="{{odr_vat}}" />
            <input type="hidden" name="pop_sub_odr_notice" class="form-control" value="{{odr_notice}}" />
            <input type="hidden" name="pop_sub_odr_nm" class="form-control" value="{{odr_nm}}" />
            <input type="hidden" name="pop_sub_odr_tel" class="form-control" value="{{odr_tel}}" />
            <input type="hidden" name="pop_sub_odr_project" class="form-control" value="{{odr_project}}" />
            {{comp_nm}}
        </td>
        <td>
            <input type="hidden" name="pop_sub_prod_pn" class="form-control" value="{{prod_pn}}" />
            <input type="hidden" name="pop_sub_prod_nm" class="form-control" value="{{prod_nm}}" />
            <input type="hidden" name="pop_sub_prod_kind_nm" class="form-control" value="{{prod_kind_nm}}" />
            <input type="hidden" name="pop_sub_prod_group_nm" class="form-control" value="{{prod_group_nm}}" />
            <input type="hidden" name="pop_sub_prod_family_nm" class="form-control" value="{{prod_family_nm}}" />
            <input type="hidden" name="pop_sub_prod_stand" class="form-control" value="{{prod_stand}}" />
            <input type="hidden" name="pop_sub_prod_unit_nm" class="form-control" value="{{prod_unit_nm}}" />
            <input type="hidden" name="pop_sub_prod_price" class="form-control" value="{{prod_price}}" />
            {{prod_pn}}
        </td>
        <td>{{prod_nm}}</td>
        <td>{{prod_stand}}</td>
        <td>{{odr_dt}}</td>
        <td>{{odr_ship_dt}}</td>
        <td class="txt-right">{{odr_cnt}}</td>
        <td class="txt-right">{{odr_price}}</td>
        <td class="txt-right">{{odr_amt}}</td>
        <td class="txt-right">{{odr_vat}}</td>
        <td>
            <button class="btn btn-sm btn-success" type="button" onclick="orderModifyRow({{cnt}})">수정</button>
            <button class="btn btn-sm btn-danger" type="button" onclick="orderDelete({{cnt}})">행삭제</button>
        </td>
    </tr>
</script>

<script id="popBomTemplete" type="text/x-handlebars-template">
    <tr class="sortable list_tr{{cnt}}">
        <td>
            <input type="hidden" name="pop_prod_bom_cd" class="form-control" value="{{prod_bom_cd}}"
                   placeholder="수주공정코드" title="수주공정코드" />
            <select name="pop_proc_cd" class="custom-select w-100"  title="공정" required>
                <option value="">공정선택</option>
                <c:forEach var="item" items="${vmap.procList}" varStatus="status">
                    <option value="${item.proc_cd}">${item.proc_nm}</option>
                </c:forEach>
            </select>
        </td>
        <td>
            <input type="hidden" name="pop_prod_ja_cd" class="form-control" value="{{prod_ja_cd}}"
                   placeholder="소요자재" title="소요자재" />
            <input type="text" name="pop_selector2" class="form-control" value="{{selector}}"
                   placeholder="소요자재" title="소요자재" />
        </td>
        <td>
            <input type="text" name="pop_prod_bom_cnt" class="form-control" value="{{prod_bom_cnt}}"
                   placeholder="소요수량" title="소요수량" />
        </td>
        <td>
            <input type="text" name="pop_prod_bom_notice" class="form-control" value="{{prod_bom_notice}}"
                   placeholder="비고" title="비고" />
        </td>
        <th>
            <button class="btn btn-sm btn-danger" type="button" onclick="prodBomDelete({{cnt}})">
                                        <span class="btn-wrapper--icon">
                                            <i class="fas fa-minus-circle"></i>
                                        </span>
                <span class="btn-wrapper--label">행삭제</span>
            </button>
        </th>
    </tr>
</script>


<script>

    $(document).ready(() => {
        // DataTables setting
        setDatatable();
        // getData();
        initAutoComplete("#pop_selector");
        initAutoComplete2("#pop_selector2");

        $("input:radio[name=pop_prod_mass_yn]").on("change", () => {
            $("input:radio[name=pop_prod_mass_yn]").each(function() {
            });
        });

        $("#prod_kind, #prod_family, #prod_group").on("change", () => { getData() });

        $("#pop_odr_cnt, #pop_odr_price").on("keyup", () => { calcOrderAmtVat() });

        $("input:radio[name=pop_odr_vat_yn]").on("change", () => { calcOrderAmtVat() });

        // 조회
        $("#btnSearch").on("click", () => { getData() });

        // Add Data - Call Data Form
        $("#btnNew").on("click", () => {
            callEditmodal("수주 등록", "R");
        });

        // 상세조회
        $("#tblMaster").on("dblclick", "tr", function() {
            let prod_cd = $(this).find("input[name=prod_cd]").val();
            callEditmodal("수주 수정", "M");
            getDataOne(prod_cd);
        });

        // 저장
        $("#btnPopRegist").on("click", () => {

            Swal.fire({
                title: '',
                text: "수주 정보를 저장하시겠습니까?",
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

        // 데이터 삭제
        $("#btnDelete").on("click", () => {

            Swal.fire({
                title: '',
                text: "수주 정보를 삭제하시겠습니까?",
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

        $("#btnSetSubList").on("click", () => {
            if(!parsleyIsValidate("dataForm")) return false;
            addPopOrderRow();
        });

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
                $("#pop_prod_family_nm").val(ui.item.prod_family_nm);
                $("#pop_prod_stand").val(ui.item.prod_stand);
                $("#pop_prod_unit_nm").val(ui.item.prod_unit_nm);
                $("#pop_prod_price").val(ui.item.prod_price.comma());
                $("#pop_odr_price").val(ui.item.prod_price.comma());
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
            ,scrollY: 570
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

        $("#pop_odr_dt").val(moment().format('YYYY-MM-DD'));
        $("#pop_odr_ship_dt").val(moment().add(7, 'days').format('YYYY-MM-DD'));
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
            url: "/mes/sales/order/orderList"
            ,type: "post"
            ,headers: {
                "Content-Type": "application/json"
                ,"X-HTTP-Method-Override": "POST"
            }
            ,dataType: "json"
            ,data: JSON.stringify({
                fact_cd: "${vmap.fact_cd}"
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

                let checkBoxNode = "<div class=\"custom-control custom-checkbox\">" +
                                   "    <input type=\"hidden\" name=\"prod_cd\" value=\"" + item.prod_cd + "\">" +
                                   "    <input type=\"checkbox\" class=\"custom-control-input\" id=\"listCheck_" + index + "\" name=\"listCheck\">" +
                                   "    <label class=\"custom-control-label\" for=\"listCheck_" + index + "\"></label>" +
                                   "</div>";

                node.push(checkBoxNode);
                node.push(IsEmpty(item.prod_cd));
                node.push(IsEmpty(item.prod_pn));
                node.push(IsEmpty(item.prod_nm));
                node.push(IsEmpty(item.prod_kind_nm));
                node.push(IsEmpty(item.prod_group_nm));
                node.push(IsEmpty(item.prod_family_nm));
                node.push(IsEmpty(item.prod_stand));
                node.push(IsEmpty(item.prod_unit_nm));
                node.push(IsEmpty(item.prod_price.comma('2')));
                node.push(IsEmpty(item.prod_main_comp_nm));
                // node.push(IsEmpty(item.prod_keep_cnt.comma('2')));
                // node.push(IsEmpty(item.prod_stock_cnt.comma('2')));
                node.push(IsEmpty(item.prod_mass_yn));

                let param = "{"
                    + "prod_cd: '" +  item.prod_cd + "'"
                    + ",prod_pn: '" +  item.prod_pn + "'"
                    + ",prod_nm: '" +  item.prod_nm + "'"
                    + ",prod_kind_nm: '" +  item.prod_kind_nm + "'"
                    + ",prod_stand: '" +  item.prod_stand + "'"
                    + ",prod_unit_nm: '" +  item.prod_unit_nm + "'"
                + "}";

                let manageButton = "<div style='display: flex; flex-wrap: wrap; justify-content: space-around;' >" +
                                   "    <button class=\"btn btn-sm btn " + (item.proc_cnt > 0 ? "btn-first" : "btn-outline-first" ) + "\" type=\"button\" onclick=\"setProductProcess(" + param + ")\">공정</button>" +
                                   "    <button class=\"btn btn-sm btn " + (item.bom_cnt > 0 ? "btn-first" : "btn-outline-first" ) + "\" type=\"button\" onclick=\"setProductBom(" + param + ")\">BOM</button>" +
                                   "</div>";

                node.push(manageButton);

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

    function getDataOne(prod_cd)
    {
        showWait('.dataModal');

        $.ajax({
            url: "/mes/sales/order/orderOne/" + prod_cd
            ,type: "get"
            ,dataType: "json"
            // ,data: JSON.stringify({})
        })
        .done(function (data)
        {
            setDataOne("pop_", data);
            $("#dataForm").find(".key").prop("disabled", true);
            $("#pop_selector").val(data.prod_main_comp_nm);
        })
        .always(function (data) {
            hideWait('.dataModal');
        })
        .fail(function (jqHXR, textStatus, errorThrown) {
            ajaxErrorAlert(jqHXR);
        });
    }

    let orderRowCnt = 0;
    function addPopOrderRow()
    {
        let template_html = $("#popOrderTemplete").html();
        let template = Handlebars.compile(template_html);
        // let rowCnt = $("#tblPopSubData > tbody > tr").length + 1;

        let templateData = {
            // cnt : rowCnt
            cnt: ++orderRowCnt
            ,comp_cd: $("#pop_comp_cd").val()
            ,comp_nm: $("#pop_comp_nm").val()
            ,prod_cd: $("#pop_prod_cd").val()
            ,prod_pn: $("#pop_prod_pn").val()
            ,prod_nm: $("#pop_prod_nm").val()
            ,prod_kind_nm: $("#pop_prod_kind_nm").val()
            ,prod_group_nm: $("#pop_prod_group_nm").val()
            ,prod_family_nm: $("#pop_prod_family_nm").val()
            ,prod_stand: $("#pop_prod_stand").val()
            ,prod_unit_nm: $("#pop_prod_unit_nm").val()
            ,prod_price: $("#pop_prod_price").val()
            ,odr_dt: $("#pop_odr_dt").val()
            ,odr_ship_dt: $("#pop_odr_ship_dt").val()
            ,odr_vat_yn: $("input:radio[name=pop_odr_vat_yn]:checked").val()
            ,odr_cnt: $("#pop_odr_cnt").val()
            ,odr_price: $("#pop_odr_price").val()
            ,odr_amt: $("#pop_odr_amt").val()
            ,odr_vat: $("#pop_odr_vat").val()
            ,odr_notice: $("#pop_odr_notice").val()
            ,odr_project: $("#pop_odr_project").val()
            ,odr_nm: $("#pop_odr_nm").val()
            ,odr_tel: $("#pop_odr_tel").val()
        }

        $("#tblPopSubData > tbody").append(template(templateData));

        $("#tblPopSubData .list_tr" + orderRowCnt)
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

    function orderModifyRow(cnt)
    {
        let comp_cd = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_comp_cd]").val();
        let comp_nm = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_comp_nm]").val();
        let prod_cd = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_prod_cd]").val();
        let odr_dt = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_odr_dt]").val();
        let odr_ship_dt = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_odr_ship_dt]").val();
        let odr_vat_yn = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_odr_vat_yn]").val();
        let odr_cnt = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_odr_cnt]").val();
        let odr_price = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_odr_price]").val();
        let odr_amt = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_odr_amt]").val();
        let odr_vat = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_odr_vat]").val();
        let odr_notice = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_odr_notice]").val();
        let odr_nm = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_odr_nm]").val();
        let odr_tel = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_odr_tel]").val();
        let odr_project = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_odr_project]").val();

        let prod_pn = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_prod_pn]").val();
        let prod_nm = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_prod_nm]").val();
        let prod_kind_nm = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_prod_kind_nm]").val();
        let prod_group_nm = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_prod_group_nm]").val();
        let prod_family_nm = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_prod_family_nm]").val();
        let prod_stand = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_prod_stand]").val();
        let prod_unit_nm = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_prod_unit_nm]").val();
        let prod_price = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_prod_price]").val();

        $("input[name=pop_odr_vat_yn]").val([odr_vat_yn]);
        $("#pop_comp_cd").val(comp_cd);
        $("#pop_comp_nm").val(comp_nm);
        $("#pop_selector").val('['+comp_cd+']'+comp_nm);
        $("#pop_prod_cd").val(prod_cd);
        $("#pop_selector2").val('['+prod_pn+']'+prod_nm);
        $("#pop_odr_dt").val(odr_dt);
        $("#pop_odr_ship_dt").val(odr_ship_dt);
        $("#pop_odr_cnt").val(odr_cnt);
        $("#pop_odr_price").val(odr_price);
        $("#pop_odr_amt").val(odr_amt);
        $("#pop_odr_vat").val(odr_vat);
        $("#pop_odr_notice").val(odr_notice);
        $("#pop_odr_nm").val(odr_nm);
        $("#pop_odr_tel").val(odr_tel);
        $("#pop_odr_project").val(odr_project);
        $("#pop_prod_pn").val(prod_pn);
        $("#pop_prod_nm").val(prod_nm);
        $("#pop_prod_kind_nm").val(prod_kind_nm);
        $("#pop_prod_group_nm").val(prod_group_nm);
        $("#pop_prod_family_nm").val(prod_family_nm);
        $("#pop_prod_stand").val(prod_stand);
        $("#pop_prod_unit_nm").val(prod_unit_nm);
        $("#pop_prod_price").val(prod_price);

        $("#tblPopSubData .list_tr" + cnt).remove();
    }

    function orderDelete(cnt)
    {
        let odr_cd = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_odr_cd]").val();

        if(IsNull(odr_cd))
        {
            $("#tblPopSubData .list_tr" + cnt).remove();
        }
        else
        {
            // Swal.fire({
            // title: '',
            // text: "수주-BOM 정보를 삭제하시겠습니까?",
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
            //             ,url: "/mes/sales/order/bom/orderBomDelete"
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
        let ary_odr_cd = [];
        let ary_comp_cd = [];
        let ary_prod_cd = [];
        let ary_odr_dt = [];
        let ary_odr_ship_dt = [];
        let ary_odr_vat_yn = [];
        let ary_odr_cnt = [];
        let ary_odr_price = [];
        let ary_odr_amt = [];
        let ary_odr_vat = [];
        let ary_odr_notice = [];
        let ary_odr_project = [];
        let ary_odr_nm = [];
        let ary_odr_tel = [];

        $.each($("#tblPopSubData > tbody > tr"), function(index, item)
        {
            ary_odr_cd.push($(item).find("input[name=pop_sub_odr_cd]").val());
            ary_comp_cd.push($(item).find("input[name=pop_sub_comp_cd]").val());
            ary_prod_cd.push($(item).find("input[name=pop_sub_prod_cd]").val());
            ary_odr_dt.push($(item).find("input[name=pop_sub_odr_dt]").val());
            ary_odr_ship_dt.push($(item).find("input[name=pop_sub_odr_ship_dt]").val());
            ary_odr_vat_yn.push($(item).find("input[name=pop_sub_odr_vat_yn]").val());
            ary_odr_cnt.push($(item).find("input[name=pop_sub_odr_cnt]").val().replace(/,/g, ""));
            ary_odr_price.push($(item).find("input[name=pop_sub_odr_price]").val().replace(/,/g, ""));
            ary_odr_amt.push($(item).find("input[name=pop_sub_odr_amt]").val().replace(/,/g, ""));
            ary_odr_vat.push($(item).find("input[name=pop_sub_odr_vat]").val().replace(/,/g, ""));
            ary_odr_notice.push($(item).find("input[name=pop_sub_odr_notice]").val());
            ary_odr_project.push($(item).find("input[name=pop_sub_odr_project]").val());
            ary_odr_nm.push($(item).find("input[name=pop_sub_odr_nm]").val());
            ary_odr_tel.push($(item).find("input[name=pop_sub_odr_tel]").val());
        });

        $.ajax({
            type: "post"
            ,url: "/mes/sales/order/orderRegist"
            ,headers: {
                "Content-Type": "application/json"
                ,"X-HTTP-Method-Override": "POST"
            }
            ,dataType: "text"
            ,data: JSON.stringify({
                fact_cd: "${vmap.fact_cd}"
                ,ary_odr_cd: ary_odr_cd
                ,ary_comp_cd: ary_comp_cd
                ,ary_prod_cd: ary_prod_cd
                ,ary_odr_dt: ary_odr_dt
                ,ary_odr_ship_dt: ary_odr_ship_dt
                ,ary_odr_vat_yn: ary_odr_vat_yn
                ,ary_odr_cnt: ary_odr_cnt
                ,ary_odr_price: ary_odr_price
                ,ary_odr_amt: ary_odr_amt
                ,ary_odr_vat: ary_odr_vat
                ,ary_odr_notice: ary_odr_notice
                ,ary_odr_project: ary_odr_project
                ,ary_odr_nm: ary_odr_nm
                ,ary_odr_tel: ary_odr_tel
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
        showWait('.container-fluid');

        let deleteItems = [];
        $.each($("input[name=listCheck]:checked"), function(item, index) {
            deleteItems.push($(this).closest("tr").find("input[name=prod_cd]").val());
        });

        $.ajax({
            type: "delete"
            ,url: "/mes/sales/order/orderPackDelete"
            ,headers: {
                "Content-Type": "application/json"
                ,"X-HTTP-Method-Override": "DELETE"
            }
            ,dataType: "text"
            ,data: JSON.stringify({
                deleteItems: deleteItems
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
        let odrCnt = $("#pop_odr_cnt").val().replace(/,/g, "");
        let odrPrice = $("#pop_odr_price").val().replace(/,/g, "");
        let odrVatYn = $("input:radio[name=pop_odr_vat_yn]:checked").val();
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

        $("#pop_odr_amt").val(odrAmt.comma());
        $("#pop_odr_vat").val(odrVat.comma());
    }


</script>

<%@ include file="/WEB-INF/include/footer.jspf" %>