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
                <i class="fas fa-home"></i> <i class="fas fa-arrow-circle-right"></i> 생산관리 <i class="fas fa-arrow-circle-right"></i> 작업지시
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
                                    <th class="no-sort" style="width: 3%">
                                        <div class="custom-control custom-checkbox">
                                            <input type="checkbox" class="custom-control-input" id="listAll">
                                            <label class="custom-control-label" for="listAll"></label>
                                        </div>
                                    </th>
                                    <th>거래처</th>
                                    <th style="width: 8%">수주번호</th>
                                    <th style="width: 10%">작업지시번호</th>
                                    <th style="width: 14%">계획일</th>
                                    <th style="width: 8%">품번</th>
                                    <th style="width: 15%">품목명</th>
                                    <th>규격</th>
                                    <th style="width: 8%">계획수량</th>
                                    <th class="red">상태</th>
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
                                <input type="hidden" id="pop_plan_cd" name="pop_plan_cd" class="form-control"
                                       placeholder="계획코드" title="계획코드" />
                                <input type="hidden" id="pop_comp_cd" name="pop_comp_cd" class="form-control"
                                       placeholder="거래처" title="거래처" />
                                <input type="hidden" id="pop_comp_nm" name="pop_comp_nm" class="form-control"
                                       placeholder="거래처" title="거래처" />
                                <input type="text" id="pop_selector" name="pop_selector" class="form-control"
                                       placeholder="거래처명" title="거래처명" required />
                            </td>
                            <th>계획시작일<span class="red"> (필수)</span></th>
                            <td>
                                <div class="input-group input-group-seamless">
                                    <input id="pop_plan_stdt" name="pop_plan_stdt" class="form-control datepicker" title="계획시작일"
                                           placeholder="계획시작일" type="text" />
                                    <div class="input-group-append">
                                        <span class="input-group-text"><i class="fas fa-calendar"></i></span>
                                    </div>
                                </div>
                            </td>
                            <th>계획종료일<span class="red"> (필수)</span></th>
                            <td>
                                <div class="input-group input-group-seamless">
                                    <input id="pop_plan_eddt" name="pop_plan_eddt" class="form-control datepicker" title="계획종료일"
                                           placeholder="계획종료일" type="text" />
                                    <div class="input-group-append">
                                        <span class="input-group-text"><i class="fas fa-calendar"></i></span>
                                    </div>
                                </div>
                            </td>
                            <th>작업지시번호</th>
                            <td>
                                <input type="text" id="pop_plan_no" name="pop_plan_no" class="form-control" placeholder="작업지시번호 / 미입력 시 자동생성" title="작업지시번호" />
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
                            <th>적정재고량</th>
                            <td>
                                <input type="text" id="pop_prod_keep_cnt" name="pop_prod_keep_cnt" class="form-control"
                                       placeholder="적정재고량" title="적정재고량" readonly="readonly" />
                            </td>
                            <th>현재고량</th>
                            <td>
                                <input type="text" id="pop_prod_stock_cnt" name="pop_prod_stock_cnt" class="form-control"
                                       placeholder="적정재고량" title="적정재고량" readonly="readonly" />
                            </td>
                        </tr>
                        <tr>
                            <th>생산계획수량 <span class="red"> (필수)</span></th>
                            <td>
                                <input type="text" id="pop_plan_cnt" name="pop_plan_cnt" class="form-control"
                                       placeholder="생산계획수량" title="생산계획수량" required />
                            </td>
                            <th>비고</th>
                            <td colspan="5">
                                <input type="text" id="pop_plan_notice" name="pop_plan_notice" class="form-control" placeholder="비고" title="비고" />
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
                            <col style="width: 14%" />
                            <col style="width: 12%" />
                            <col style="width: 14%" />
                            <col style="width: 8%" />
                            <col style="width: 8%" />
                            <col style="width: 10%" />
                            <col style="width: 8%" />
                            <col style="width: 8%" />
                            <col style="width: 8%" />
                            <col style="width: 10%" />
                        </colgroup>
                        <thead>
                        <tr>
                            <th>거래처</th>
                            <th>품번</th>
                            <th>품명</th>
                            <th>규격</th>
                            <th>단위</th>
                            <th>작업지시번호</th>
                            <th>계획시작일</th>
                            <th>계획종료일</th>
                            <th>계획수량</th>
                            <th>관리</th>
                        </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>

                <div class="isProc" style="height: 250px; overflow: auto;">
                    <table id="tblPopProcData" class="table table-hover table-bordered mb-3 table-form">
                        <colgroup>
                            <col style="width: 10%" />
                            <col style="width: 40%" />
                            <col style="width: 40%" />
                            <col style="width: 10%" />
                        </colgroup>
                        <thead>
                        <tr>
                            <th>순서</th>
                            <th>공정명</th>
                            <th>비고</th>
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

<script id="popPlanTemplete" type="text/x-handlebars-template">
    <tr class="dataList list_tr{{cnt}}">
        <td>
            <input type="hidden" name="pop_sub_plan_cd" class="form-control" value="{{plan_cd}}" />
            <input type="hidden" name="pop_sub_comp_cd" class="form-control" value="{{comp_cd}}" />
            <input type="hidden" name="pop_sub_comp_nm" class="form-control" value="{{comp_nm}}" />
            <input type="hidden" name="pop_sub_prod_cd" class="form-control" value="{{prod_cd}}" />
            <input type="hidden" name="pop_sub_plan_stdt" class="form-control" value="{{plan_stdt}}" />
            <input type="hidden" name="pop_sub_plan_eddt" class="form-control" value="{{plan_eddt}}" />
            <input type="hidden" name="pop_sub_plan_no" class="form-control" value="{{plan_no}}" />
            <input type="hidden" name="pop_sub_plan_cnt" class="form-control" value="{{plan_cnt}}" />
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
            <input type="hidden" name="pop_sub_prod_keep_cn" class="form-control" value="{{prod_keep_cn}}" />
            <input type="hidden" name="pop_sub_prod_stock_cnt" class="form-control" value="{{prod_stock_cnt}}" />
            {{prod_pn}}
        </td>
        <td>{{prod_nm}}</td>
        <td>{{prod_stand}}</td>
        <td>{{prod_unit_nm}}</td>
        <td>{{plan_no}}</td>
        <td>{{plan_stdt}}</td>
        <td>{{plan_eddt}}</td>
        <td class="txt-right">{{plan_cnt}}</td>
        <td>
            <button class="btn btn-sm btn-success" type="button" onclick="planModifyRow({{cnt}})">수정</button>
            <button class="btn btn-sm btn-danger" type="button" onclick="planDelete({{cnt}})">행삭제</button>
        </td>
    </tr>
</script>

<script id="popPlanProcTemplete" type="text/x-handlebars-template">
    <tr class="dataList list_tr{{cnt}}">
        <td style="text-align: center !important; ">
            <input type="hidden" name="pop_plan_proc_cd" class="form-control" value="{{plan_proc_cd}}" />
            <input type="hidden" name="pop_proc_cd" class="form-control" value="{{proc_cd}}" />
            {{plan_proc_seq}}
        </td>
        <td>
            {{proc_nm}}
        </td>
        <td>
            <input type="text" name="pop_plan_proc_notice" class="form-control" value="{{plan_proc_notice}}"
                   placeholder="비고" title="비고" />
        </td>
        <td style="text-align: center !important; ">
            <button class="btn btn-sm btn-danger" type="button" onclick="planProcDelete({{cnt}})">
                                        <span class="btn-wrapper--icon">
                                            <i class="fas fa-minus-circle"></i>
                                        </span>
                <span class="btn-wrapper--label">행삭제</span>
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
            callEditmodal("생산계획 등록", "R");
        });

        // 상세조회
        $("#tblMaster").on("dblclick", "tr", function() {
            let plan_cd = $(this).find("input[name=plan_cd]").val();
            callEditmodal("생산계획 수정", "M");
            getDataOne(plan_cd);
        });

        // 저장
        $("#btnPopRegist").on("click", () => {

            Swal.fire({
                title: '',
                text: "생산계획 정보를 저장하시겠습니까?",
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
                text: "생산계획 정보를 수정하시겠습니까?",
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

            Swal.fire({
                title: '',
                text: "생산계획 정보를 삭제하시겠습니까?",
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
            if($("#pop_plan_stdt").val() > $("#pop_plan_eddt").val()) {
                eAlert("잘못된 날짜입니다. 생산 시작일/종료일을 확인해주세요.");
                return false;
            }
            addPopPlanRow();
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
        $("#tblPopSubData tbody").empty();
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
                        "    <input type=\"hidden\" name=\"plan_cd\" value=\"" + item.plan_cd + "\">" +
                        "    <input type=\"hidden\" name=\"plan_state\" value=\"" + item.plan_state + "\">" +
                        "    <input type=\"checkbox\" class=\"custom-control-input\" id=\"listCheck_" + index + "\" name=\"listCheck\">" +
                        "    <label class=\"custom-control-label\" for=\"listCheck_" + index + "\"></label>" +
                        "</div>";

                    node.push(checkBoxNode);
                    node.push(IsEmpty(item.comp_nm));
                    node.push(IsEmpty(item.odr_cd));
                    node.push(IsEmpty(item.plan_no));
                    node.push("<div class='text-center'>" + IsEmpty(item.plan_stdt) + " ~ " + IsEmpty(item.plan_eddt) + "</div>");
                    node.push(IsEmpty(item.prod_pn));
                    node.push(IsEmpty(item.prod_nm));
                    node.push(IsEmpty(item.prod_stand));
                    node.push("<div class='text-right'>" + IsEmpty(item.plan_cnt.comma('2')) + " " + IsEmpty(item.prod_unit_nm) + "</div>");
                    node.push("<div class='text-center red'>" + IsEmpty(item.plan_state_nm) + "</div>");

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

    function getDataOne(plan_cd)
    {
        showWait('.dataModal');

        $.ajax({
            url: "/mes/production/plan/planOne/" + plan_cd
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
                $("#btnPopRegist").hide();
                $("#btnPopModify").show();

                getPlanProcData(plan_cd);
            })
            .always(function (data) {
                hideWait('.dataModal');
            })
            .fail(function (jqHXR, textStatus, errorThrown) {
                ajaxErrorAlert(jqHXR);
            });
    }

    let planRowCnt = 0;
    function addPopPlanRow()
    {
        let template_html = $("#popPlanTemplete").html();
        let template = Handlebars.compile(template_html);
        // let rowCnt = $("#tblPopSubData > tbody > tr").length + 1;

        let templateData = {
            // cnt : rowCnt
            cnt: ++planRowCnt
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
            ,prod_keep_cnt: $("#pop_prod_keep_cnt").val()
            ,prod_stock_cnt: $("#pop_prod_stock_cnt").val()
            ,plan_no: $("#pop_plan_no").val()
            ,plan_stdt: $("#pop_plan_stdt").val()
            ,plan_eddt: $("#pop_plan_eddt").val()
            ,plan_cnt: $("#pop_plan_cnt").val()
            ,plan_notice: $("#pop_plan_notice").val()
        }

        $("#tblPopSubData > tbody").append(template(templateData));

        $("#tblPopSubData .list_tr" + planRowCnt)
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

    function planModifyRow(cnt)
    {
        let comp_cd = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_comp_cd]").val();
        let comp_nm = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_comp_nm]").val();
        let prod_cd = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_prod_cd]").val();
        let plan_stdt = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_plan_stdt]").val();
        let plan_eddt = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_plan_eddt]").val();
        let plan_no = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_plan_no]").val();
        let plan_cnt = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_plan_cnt]").val();
        let plan_notice = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_plan_notice]").val();

        let prod_pn = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_prod_pn]").val();
        let prod_nm = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_prod_nm]").val();
        let prod_kind_nm = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_prod_kind_nm]").val();
        let prod_group_nm = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_prod_group_nm]").val();
        let prod_family_nm = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_prod_family_nm]").val();
        let prod_stand = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_prod_stand]").val();
        let prod_unit_nm = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_prod_unit_nm]").val();
        let prod_keep_cn = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_prod_keep_cn]").val();
        let prod_stock_cnt = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_prod_stock_cnt]").val();

        $("#pop_comp_cd").val(comp_cd);
        $("#pop_comp_nm").val(comp_nm);
        $("#pop_selector").val('['+comp_cd+']'+comp_nm);
        $("#pop_prod_cd").val(prod_cd);
        $("#pop_selector2").val('['+prod_pn+']'+prod_nm);
        $("#pop_plan_stdt").val(plan_stdt);
        $("#pop_plan_eddt").val(plan_eddt);
        $("#pop_plan_cnt").val(plan_cnt);
        $("#pop_plan_no").val(plan_no);
        $("#pop_plan_notice").val(plan_notice);
        $("#pop_prod_pn").val(prod_pn);
        $("#pop_prod_nm").val(prod_nm);
        $("#pop_prod_kind_nm").val(prod_kind_nm);
        $("#pop_prod_group_nm").val(prod_group_nm);
        $("#pop_prod_family_nm").val(prod_family_nm);
        $("#pop_prod_stand").val(prod_stand);
        $("#pop_prod_unit_nm").val(prod_unit_nm);
        $("#pop_prod_keep_cn").val(prod_keep_cn);
        $("#pop_prod_stock_cnt").val(prod_stock_cnt);

        $("#tblPopSubData .list_tr" + cnt).remove();
    }

    function planDelete(cnt)
    {
        let plan_cd = $("#tblPopSubData .list_tr" + cnt).find("[name=pop_sub_plan_cd]").val();

        if(IsNull(plan_cd))
        {
            $("#tblPopSubData .list_tr" + cnt).remove();
        }
        else
        {
        }
    }

    // Add Data - ajax regist
    function registData()
    {
        showWait('.dataModal');

        //. Data List
        let ary_plan_cd = [];
        let ary_comp_cd = [];
        let ary_prod_cd = [];
        let ary_plan_stdt = [];
        let ary_plan_eddt = [];
        let ary_plan_cnt = [];
        let ary_plan_no = [];
        let ary_plan_notice = [];

        $.each($("#tblPopSubData > tbody > tr"), function(index, item)
        {
            ary_plan_cd.push($(item).find("input[name=pop_sub_plan_cd]").val());
            ary_comp_cd.push($(item).find("input[name=pop_sub_comp_cd]").val());
            ary_prod_cd.push($(item).find("input[name=pop_sub_prod_cd]").val());
            ary_plan_stdt.push($(item).find("input[name=pop_sub_plan_stdt]").val());
            ary_plan_eddt.push($(item).find("input[name=pop_sub_plan_eddt]").val());
            ary_plan_cnt.push($(item).find("input[name=pop_sub_plan_cnt]").val().replace(/,/g, ""));
            ary_plan_no.push($(item).find("input[name=pop_sub_plan_no]").val());
            ary_plan_notice.push($(item).find("input[name=pop_sub_plan_notice]").val());
        });

        $.ajax({
            type: "post"
            ,url: "/mes/production/plan/planRegist"
            ,headers: {
                "Content-Type": "application/json"
                ,"X-HTTP-Method-Override": "POST"
            }
            ,dataType: "text"
            ,data: JSON.stringify({
                fact_cd: "${vmap.fact_cd}"
                ,ary_plan_cd: ary_plan_cd
                ,ary_comp_cd: ary_comp_cd
                ,ary_prod_cd: ary_prod_cd
                ,ary_plan_stdt: ary_plan_stdt
                ,ary_plan_eddt: ary_plan_eddt
                ,ary_plan_cnt: ary_plan_cnt
                ,ary_plan_no: ary_plan_no
                ,ary_plan_notice: ary_plan_notice
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

    // modify Data - ajax modify
    function modifyData()
    {
        showWait('.dataModal');

        //. Data List
        let ary_plan_proc_cd = [];
        let ary_proc_cd = [];
        let ary_plan_proc_notice = [];

        $.each($("#tblPopProcData > tbody > tr"), function(index, item)
        {
            ary_plan_proc_cd.push($(item).find("input[name=pop_plan_proc_cd]").val());
            ary_proc_cd.push($(item).find("input[name=pop_proc_cd]").val());
            ary_plan_proc_notice.push($(item).find("input[name=pop_plan_proc_notice]").val());
        });

        $.ajax({
            type: "post"
            ,url: "/mes/production/plan/planModify"
            ,headers: {
                "Content-Type": "application/json"
                ,"X-HTTP-Method-Override": "POST"
            }
            ,dataType: "text"
            ,data: JSON.stringify({
                fact_cd: "${vmap.fact_cd}"
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
                ,prod_keep_cnt: $("#pop_prod_keep_cnt").val()
                ,prod_stock_cnt: $("#pop_prod_stock_cnt").val()
                ,plan_cd: $("#pop_plan_cd").val()
                ,plan_no: $("#pop_plan_no").val()
                ,plan_stdt: $("#pop_plan_stdt").val()
                ,plan_eddt: $("#pop_plan_eddt").val()
                ,plan_cnt: $("#pop_plan_cnt").val().replace(/,/g, "")
                ,plan_notice: $("#pop_plan_notice").val()
                ,ary_plan_proc_cd: ary_plan_proc_cd
                ,ary_proc_cd: ary_proc_cd
                ,ary_plan_proc_notice: ary_plan_proc_notice
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
        let isFlag = false;
        let deleteItems = [];
        $.each($("input[name=listCheck]:checked"), function(item, index) {
            deleteItems.push($(this).closest("tr").find("input[name=plan_cd]").val());
            if($(this).closest("tr").find("input[name=plan_state]").val() != "10") {
                isFlag = true;
                return false;
            }
        });

        if (isFlag) {
            eAlert("[생산대기] 상태의 계획만 삭제할 수 있습니다.");
            return false;
        }

        showWait('.container-fluid');

        $.ajax({
            type: "delete"
            ,url: "/mes/production/plan/planPackDelete"
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

    function getPlanProcData(plan_cd)
    {
        showWait('.dataModal');

        $.ajax({
            url: "/mes/production/plan/process/planProcList"
            ,type: "post"
            ,headers: {
                "Content-Type": "application/json"
                ,"X-HTTP-Method-Override": "POST"
            }
            ,dataType: "json"
            ,data: JSON.stringify({
                fact_cd: "${vmap.fact_cd}"
                ,plan_cd: plan_cd
            })
        })
        .done(function (data)
        {
            $(".isProc").show();
            $("#tblPopProcData > tbody").empty();

            data.forEach((item, index) => {
                addPopPlanProcRow(item);
            });

        })
        .always(function (data) {
            hideWait('.dataModal');
        })
        .fail(function (jqHXR, textStatus, errorThrown) {
            ajaxErrorAlert(jqHXR);
        });
    }

    function addPopPlanProcRow(data)
    {
        let template_html = $("#popPlanProcTemplete").html();
        let template = Handlebars.compile(template_html);
        let rowCnt = $("#tblPopProcData > tbody > tr").length + 1;
        let templateData;

        if(IsNotNull(data)) {
            templateData = {
                cnt : rowCnt
                ,plan_proc_cd: data.plan_proc_cd
                ,proc_cd: data.proc_cd
                ,plan_proc_seq: data.plan_proc_seq
                ,proc_nm: data.proc_nm
                ,plan_proc_notice: data.plan_proc_notice
            }

            $("#tblPopProcData > tbody").append(template(templateData));
        }

        $("#tblPopProcData .list_tr" + rowCnt)
            .find("input[name$='cnt'], input[name$='price'], input[name$='amt'], input[name$='total'], input[name$='rate'], input[name$='min']")
            .css("text-align", "right")
            .on("click", function() {
                $(this).select();
            })
            .on("keyup", function() {
                $(this).val($(this).val().comma("2"));
            });
    }

    function planProcDelete(cnt)
    {
        let plan_proc_cd = $("#tblPopProcData .list_tr" + cnt).find("[name=pop_plan_proc_cd]").val();

        if(IsNull(plan_proc_cd))
        {
            $("#tblPopProcData .list_tr" + cnt).remove();
        }
        else
        {
            Swal.fire({
                title: '',
                text: "생산계획-공정 정보를 삭제하시겠습니까?",
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
                        ,url: "/mes/production/plan/process/planProcDelete"
                        ,headers: {
                            "Content-Type": "application/json"
                            ,"X-HTTP-Method-Override": "DELETE"
                        }
                        ,dataType: "text"
                        ,data: JSON.stringify({
                            plan_proc_cd: plan_proc_cd
                        })
                    })
                    .done(function (data) {
                        getPlanProcData($("#pop_plan_cd").val());
                        hideWait('.dataModal');
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


</script>

<%@ include file="/WEB-INF/include/footer.jspf" %>