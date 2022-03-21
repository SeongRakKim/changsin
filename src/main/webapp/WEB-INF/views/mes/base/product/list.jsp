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
<%--            <colgroup>--%>
<%--                <col style="width: 10%">--%>
<%--                <col style="width: 20%">--%>
<%--                <col style="width: 10%">--%>
<%--                <col style="width: 20%">--%>
<%--                <col style="width: 10%">--%>
<%--                <col style="width: 30%">--%>
<%--            </colgroup>--%>
            <thead class="thead-light">
                <tr>
                    <th>제품종류</th>
                    <td>
                        <select id="prod_kind" name="prod_kind" class="custom-select w-100" required="">
                            <option value="">제품종류선택</option>
                            <option value="PA">완제품</option>
                            <option value="PH">반제품</option>
                        </select>
                    </td>
                    <th>제품분류</th>
                    <td>
                        <select id="prod_group" name="prod_group" class="custom-select w-100" required="">
                            <option value="">제품분류선택</option>
                            <c:forEach var="item" items="${vmap.prodGroupList}" varStatus="status">
                                <option value="${item.base_detail_cd}">${item.base_detail_nm}</option>
                            </c:forEach>
                        </select>
                    </td>
                    <th>품목군</th>
                    <td>
                        <select id="prod_family" name="prod_family" class="custom-select w-100" required="">
                            <option value="">품목군선택</option>
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
                <i class="fas fa-home"></i> <i class="fas fa-arrow-circle-right"></i> 기준정보 <i class="fas fa-arrow-circle-right"></i> 제품정보
            </span>
        </div>

        <%@ include file="/WEB-INF/include/main-top-right.jspf"%>
    </div>

    <%@ include file="/WEB-INF/include/main-progress.jspf"%>

    <div class="card shadow" style="min-height: 770px;">
        <div class="card-body">
            <div class="table-responsive">
                <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
                    <div class="row">
                        <div class="col-sm-12">
                            <input type="hidden" id="prod_cls" name="prod_cls" value="P" />
<%--                            <button type="button" class="btn btn-sm btn-success" onclick='setExcelPdfButtonEvent({tableID:"tblMaster", btn:"excel"});'><i class="fas fa-file-excel"></i> 엑셀</button>--%>
                            <table id ="tblMaster" class="table-list table table-hover table-striped table-bordered mb-5" style="width: 100%">
                                <thead>
                                    <tr role="row">
                                        <th class="no-sort" style="width: 3%">
                                            <div class="custom-control custom-checkbox">
                                                <input type="checkbox" class="custom-control-input" id="listAll">
                                                <label class="custom-control-label" for="listAll"></label>
                                            </div>
                                        </th>
                                        <th>제품코드</th>
                                        <th>품번</th>
                                        <th>품명</th>
                                        <th>종류</th>
                                        <th>분류</th>
                                        <th>품목군</th>
                                        <th>규격</th>
                                        <th>단위</th>
                                        <th>단가</th>
                                        <th>주거래처</th>
<%--                                        <th>안전재고</th>--%>
<%--                                        <th>제품재고</th>--%>
                                        <th>양산여부</th>
                                        <th style="width: 11%;">관리</th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                        </table>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade dataModal" id="dataModal" tabindex="-1" role="dialog" aria-labelledby="registModal" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-xl modal-form-xl" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title"><i id="form-modal-icon"></i> <span id="form-modal-title"></span></h2>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <form id="dataForm" name="dataForm" class="dataForm" method="post">
                <div class="modal-body">
                    <table id="tblPopData" class="table table-hover table-bordered mb-5 table-form">
                        <tbody>
                            <tr>
                                <th>제품코드</th>
                                <td>
                                    <input type="text" id="pop_prod_cd" name="pop_prod_cd" class="form-control key"
                                           placeholder="제품코드 / 미입력 시 자동생성" title="제품코드"
                                           />
                                    <div class="invalid-feedback"></div>
                                </td>
                                <th>제품품번<span class="red"> (필수)</span></th>
                                <td>
                                    <input type="text" id="pop_prod_pn" name="pop_prod_pn" class="form-control"
                                           placeholder="제품품번" title="제품품번"
                                           required />
                                </td>
                                <th>제품명<span class="red"> (필수)</span></th>
                                <td>
                                    <input type="text" id="pop_prod_nm" name="pop_prod_nm" class="form-control"
                                           placeholder="제품명" title="제품명"
                                           required />
                                </td>
                            </tr>
                            <tr>
                                <th> 제품종류<span class="red"> (필수)</span></th>
                                <td>
                                    <select id="pop_prod_kind" name="pop_prod_kind" class="custom-select w-100"  title="제품종류" required>
                                        <option value="">제품종류선택</option>
                                        <option value="PA">완제품</option>
                                        <option value="PH">반제품</option>
                                    </select>
                                </td>
                                <th>제품분류 <span class="red"> (필수)</span></th>
                                <td>
                                    <select id="pop_prod_group" name="pop_prod_group" class="custom-select w-100"  title="제품분류" required>
                                        <option value="">제품분류선택</option>
                                        <c:forEach var="item" items="${vmap.prodGroupList}" varStatus="status">
                                            <option value="${item.base_detail_cd}">${item.base_detail_nm}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                                <th>품목군</th>
                                <td>
                                    <select id="pop_prod_family" name="pop_prod_family" class="custom-select w-100"  title="품목군">
                                        <option value="">품목군선택</option>
                                        <c:forEach var="item" items="${vmap.prodFamilyList}" varStatus="status">
                                            <option value="${item.base_detail_cd}">${item.base_detail_nm}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th>단위 <span class="red"> (필수)</span></th>
                                <td>
                                    <select id="pop_prod_unit" name="pop_prod_unit" class="custom-select w-100"  title="단위" required>
                                        <option value="">단위선택</option>
                                        <c:forEach var="item" items="${vmap.unitList}" varStatus="status">
                                            <option value="${item.base_detail_cd}">${item.base_detail_nm}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                                <th>규격</th>
                                <td>
                                    <input type="text" id="pop_prod_stand" name="pop_prod_stand" class="form-control"
                                           placeholder="규격" title="규격" />
                                </td>
                                <th>단가</th>
                                <td>
                                    <input type="text" id="pop_prod_price" name="pop_prod_price" class="form-control" value="0"
                                           placeholder="단가" title="단가" />
                                </td>
                            </tr>
                            <tr>
                                <th>주거래처</th>
                                <td>
                                    <input type="hidden" id="pop_prod_main_comp" name="pop_prod_main_comp" class="form-control"
                                           placeholder="주거래처" title="주거래처" />
                                    <input type="text" id="pop_selector" name="pop_selector" class="form-control"
                                           placeholder="주거래처" title="주거래처" />
                                </td>
                                <th>안전재고</th>
                                <td>
                                    <input type="text" id="pop_prod_keep_cnt" name="pop_prod_keep_cnt" class="form-control"
                                           placeholder="안전재고" title="안전재고" />
                                </td>
                                <th>양산제품여부</th>
                                <td>
                                    <div style="display: flex; flex-wrap: wrap;">
                                        <div class="custom-control custom-radio my-3">
<%--                                            <input type="radio" id="customRadio1" name="pop_prod_mass_yn" >--%>
                                            <input type="radio" id="customRadio1" name="pop_prod_mass_yn" class="custom-control-input" value="Y">
                                            <label class="custom-control-label" for="customRadio1">예</label>
                                        </div>
                                        <div class="custom-control custom-radio my-3">
<%--                                            <input type="radio" checked="" id="customRadio2" name="pop_prod_mass_yn" >--%>
                                            <input type="radio" checked="" id="customRadio2" name="pop_prod_mass_yn" class="custom-control-input" value="N">
                                            <label class="custom-control-label" for="customRadio2">아니오</label>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>비고</th>
                                <td colspan="5">
                                    <input type="text" id="pop_prod_notice" name="pop_prod_notice" class="form-control" placeholder="비고" title="비고" />
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </form>
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

<script id="popProcessTemplete" type="text/x-handlebars-template">
    <tr class="sortable list_tr{{cnt}}">
        <td class="handle" style="text-align: center;">
            <span class="ui-icon ui-icon-arrowthick-2-n-s"></span> <span class="order">{{cnt}}</span>
            <input type="hidden" name="pop_prod_proc_cd" class="form-control" value="{{prod_proc_cd}}"
                   placeholder="제품공정코드" title="제품공정코드" />
        </td>
        <td>
            <select name="pop_proc_cd" class="custom-select w-100"  title="공정" required>
                <option value="">공정선택</option>
                <c:forEach var="item" items="${vmap.procList}" varStatus="status">
                    <option value="${item.proc_cd}">${item.proc_nm}</option>
                </c:forEach>
            </select>
        </td>
        <td>
            <input type="text" name="pop_prod_proc_min" class="form-control" value="{{prod_proc_min}}"
                   placeholder="표준공수" title="표준공수" />
        </td>
        <td>
            <input type="text" name="pop_prod_proc_notice" class="form-control" value="{{prod_proc_notice}}"
                   placeholder="비고" title="비고" />
        </td>
        <td style="text-align: center;">
            <button class="btn btn-sm btn-danger" type="button" onclick="prodProcDelete({{cnt}})">
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
        getData();
        initAutoComplete("#pop_selector");

        setSortable("tblPopProcess");

        $("input:radio[name=pop_prod_mass_yn]").on("change", () => {
            $("input:radio[name=pop_prod_mass_yn]").each(function() {
            });
        });

        $("#prod_kind, #prod_family, #prod_group").on("change", () => { getData() });

        // 조회
        $("#btnSearch").on("click", () => { getData() });

        // Add Data - Call Data Form
        $("#btnNew").on("click", () => {
            callEditmodal("제품 추가", "R");
        });

        // 상세조회
        $("#tblMaster").on("dblclick", "tr", function() {
            let prod_cd = $(this).find("input[name=prod_cd]").val();
            callEditmodal("제품 수정", "M");
            getDataOne(prod_cd);
        });

        // 저장
        $("#btnPopRegist").on("click", () => {
            if(IsNotNull($(".invalid-feedback").text())) {
                eAlert("중복된 코드값이 존재합니다.");
                return;
            }

            if(!parsleyIsValidate("dataForm")) return false;

            Swal.fire({
                title: '',
                text: "제품 정보를 저장하시겠습니까?",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: '확인',
                cancelButtonText: '취소'
            }).then((result) => {
                if (result.isConfirmed) {
                    registModifyData();
                }
            });
        });

        // 데이터 삭제
        $("#btnDelete").on("click", () => {

            Swal.fire({
                title: '',
                text: "제품 정보를 삭제하시겠습니까?",
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

        // 공정저장
        $("#btnPopProcessRegist").on("click", () => {

            if(!parsleyIsValidate("processForm")) return false;

            Swal.fire({
                title: '',
                text: "제품-공정 정보를 저장하시겠습니까?",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: '확인',
                cancelButtonText: '취소'
            }).then((result) => {
                if (result.isConfirmed) {
                    prodProcRegistModifyData();
                }
            });
        });

        // bom저장
        $("#btnPopBomRegist").on("click", () => {

            if(!parsleyIsValidate("bomForm")) return false;

            Swal.fire({
                title: '',
                text: "제품-BOM 정보를 저장하시겠습니까?",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: '확인',
                cancelButtonText: '취소'
            }).then((result) => {
                if (result.isConfirmed) {
                    prodBomRegistModifyData();
                }
            });
        });

        // 코드 중복 검사
        $("#pop_prod_cd").on("keyup", () => {
            if($("#pop_prod_cd").val().length > 3)
            {
                $.ajax({
                    type : 'get'
                    ,url: '/mes/base/product/prodOverlap/' + $("#pop_prod_cd").val()
                    ,dataType : 'json'
                })
                    .done(function (data)
                    {
                        if(data) {
                            $("#pop_prod_cd").removeClass("is-valid");
                            $("#pop_prod_cd").addClass("is-invalid");
                            $(".invalid-feedback").text("중복된 제품 코드입니다.");
                        }else {
                            $("#pop_prod_cd").removeClass("is-invalid");
                            $("#pop_prod_cd").addClass("is-valid");
                            $(".invalid-feedback").text("");
                        }
                    })
                    .always(function (data) {

                    });
            }
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
                                    comp_cd : item.comp_cd
                                }
                            })
                        );
                    }
                });
            },
            select : function(event, ui) {
                $("#pop_prod_main_comp").val(ui.item.comp_cd);
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
        let $tr = $(el).closest("tr");

        $(el).autocomplete({
            search: function(event, ui) {
                if(event.keyCode == 37 || event.keyCode == 38 || event.keyCode == 39 || event.keyCode == 40) {
                    event.preventDefault();
                }
            },
            source : function(reuqest, response) {
                $.ajax({
                    type : 'get',
                    url: '/mes/base/product/prodOverlap3/' + $(el).val(),
                    dataType : 'json',
                    success : function(data) {
                        // 서버에서 json 데이터 response 후 목록 추가
                        response(
                            $.map(data, function(item) {
                                return {
                                    label : "[" + item.prod_cd + "] " + item.prod_nm,
                                    value : "[" + item.prod_cd + "] " + item.prod_nm,
                                    prod_cd : item.prod_cd
                                }
                            })
                        );
                    }
                });
            },
            select : function(event, ui) {
                $tr.find("[name=pop_prod_ja_cd]").val(ui.item.prod_cd);
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
    }

    function getData()
    {
        showWait('.container-fluid');

        $.ajax({
            url: "/mes/base/product/prodList"
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
                ,prod_cls: $("#prod_cls").val()
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
                node.push("<div class='text-right'>" + IsEmpty(item.prod_price.comma('2')) + "</div>");
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
            url: "/mes/base/product/prodOne/" + prod_cd
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

    // Add Data - ajax regist
    function registModifyData()
    {
        showWait('.dataModal');

        $.ajax({
            type: "post"
            ,url: "/mes/base/product/prodRegistModify"
            ,headers: {
                "Content-Type": "application/json"
                ,"X-HTTP-Method-Override": "POST"
            }
            ,dataType: "text"
            ,data: JSON.stringify({
                fact_cd: "${vmap.fact_cd}"
                ,prod_cls: $("#prod_cls").val()
                ,prod_cd: $("#pop_prod_cd").val()
                ,prod_pn: $("#pop_prod_pn").val()
                ,prod_nm: $("#pop_prod_nm").val()
                ,prod_kind: $("#pop_prod_kind").val()
                ,prod_group: $("#pop_prod_group").val()
                ,prod_family: $("#pop_prod_family").val()
                ,prod_unit: $("#pop_prod_unit").val()
                ,prod_stand: $("#pop_prod_stand").val()
                ,prod_price: $("#pop_prod_price").val().replace(/,/g, "")
                ,prod_main_comp: $("#pop_prod_main_comp").val()
                ,prod_keep_cnt: $("#pop_prod_keep_cnt").val().replace(/,/g, "")
                ,prod_mass_yn: $("input:radio[name=pop_prod_mass_yn]:checked").val()
                ,prod_notice: $("#pop_prod_notice").val()
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
            ,url: "/mes/base/product/prodPackDelete"
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

    function setProductProcess()
    {
        $("#processModal").modal("show");

        $("#pop_proc_prod_cd").html(IsEmpty(arguments[0].prod_cd));
        $("#pop_proc_prod_pn").html(IsEmpty(arguments[0].prod_pn));
        $("#pop_proc_prod_nm").html(IsEmpty(arguments[0].prod_nm));
        $("#pop_proc_prod_kind_nm").html(IsEmpty(arguments[0].prod_kind_nm));
        $("#pop_proc_prod_stand").html(IsEmpty(arguments[0].prod_stand));
        $("#pop_proc_prod_unit_nm").html(IsEmpty(arguments[0].prod_unit_nm));

        getProductProcessData();
    }

    function getProductProcessData()
    {
        showWait('.dataModal');

        $.ajax({
            url: "/mes/base/product/process/prodProcList"
            ,type: "post"
            ,headers: {
                "Content-Type": "application/json"
                ,"X-HTTP-Method-Override": "POST"
            }
            ,dataType: "json"
            ,data: JSON.stringify({
                fact_cd: "${vmap.fact_cd}"
                ,prod_cd: $("#pop_proc_prod_cd").text()
            })
        })
        .done(function (data)
        {
            $("#tblPopProcess > tbody").empty();

            data.forEach((item, index) => {
                addPopProcRow(item);
            });

        })
        .always(function (data) {
            hideWait('.dataModal');
        })
        .fail(function (jqHXR, textStatus, errorThrown) {
            ajaxErrorAlert(jqHXR);
        });
    }

    function addPopProcRow(data)
    {
        let template_html = $("#popProcessTemplete").html();
        let template = Handlebars.compile(template_html);
        let rowCnt = $("#tblPopProcess > tbody > tr").length + 1;
        let templateData;

        if(IsNotNull(data)) {
            templateData = {
                cnt : rowCnt
                ,prod_proc_cd: data.prod_proc_cd
                ,prod_proc_min: data.prod_proc_min
                ,prod_proc_notice: data.prod_proc_notice
            }

            $("#tblPopProcess > tbody").append(template(templateData));
            $("#tblPopProcess .list_tr" + rowCnt).find("[name=pop_proc_cd]").val(data.proc_cd);

        }else {
            templateData = {
                cnt : rowCnt
            }

            $("#tblPopProcess > tbody").append(template(templateData));
        }

        $("#tblPopProcess .list_tr" + rowCnt)
            .find("input[name$='cnt'], input[name$='price'], input[name$='amt'], input[name$='total'], input[name$='rate'], input[name$='min']")
            .css("text-align", "right")
            .on("click", function() {
                $(this).select();
            })
            .on("keyup", function() {
                $(this).val($(this).val().comma("2"));
            });
    }

    // 제품 공정정보 data regist
    function prodProcRegistModifyData()
    {
        showWait('.dataModal');

        //. Data List
        let ary_prod_proc_seq = [];
        let ary_prod_proc_cd = [];
        let ary_proc_cd = [];
        let ary_prod_proc_min = [];
        let ary_prod_proc_notice = [];

        $.each($("#tblPopProcess > tbody > tr"), function(index, item)
        {
            ary_prod_proc_seq.push($(item).find(".order").text());
            ary_prod_proc_cd.push($(item).find("input[name=pop_prod_proc_cd]").val());
            ary_proc_cd.push($(item).find("select[name=pop_proc_cd]").val());
            ary_prod_proc_min.push($(item).find("input[name=pop_prod_proc_min]").val());
            ary_prod_proc_notice.push($(item).find("input[name=pop_prod_proc_notice]").val());
        });

        $.ajax({
            type: "post"
            ,url: "/mes/base/product/process/prodProcRegistModify"
            ,headers: {
                "Content-Type": "application/json"
                ,"X-HTTP-Method-Override": "POST"
            }
            ,dataType: "text"
            ,data: JSON.stringify({
                fact_cd: "${vmap.fact_cd}"
                ,prod_cd: $("#pop_proc_prod_cd").text()
                ,ary_prod_proc_seq: ary_prod_proc_seq
                ,ary_prod_proc_cd: ary_prod_proc_cd
                ,ary_proc_cd: ary_proc_cd
                ,ary_prod_proc_min: ary_prod_proc_min
                ,ary_prod_proc_notice: ary_prod_proc_notice
            })
        })
        .done(function (data) {
            hideWait('.dataModal');
            $("#dataModal").modal("hide");
            getProductProcessData();
        })
        .always(function (data) {

        })
        .fail(function (jqHXR, textStatus, errorThrown) {
            ajaxErrorAlert(jqHXR);
            hideWait('.dataModal');
        });
    }

    function prodProcDelete(cnt)
    {
        let prod_proc_cd = $("#tblPopProcess .list_tr" + cnt).find("[name=pop_prod_proc_cd]").val();

        if(IsNull(prod_proc_cd))
        {
            $("#tblPopProcess .list_tr" + cnt).remove();
        }
        else
        {
            Swal.fire({
            title: '',
            text: "제품-공정 정보를 삭제하시겠습니까?",
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
                        ,url: "/mes/base/product/process/prodProcDelete"
                        ,headers: {
                            "Content-Type": "application/json"
                            ,"X-HTTP-Method-Override": "DELETE"
                        }
                        ,dataType: "text"
                        ,data: JSON.stringify({
                            prod_proc_cd: prod_proc_cd
                        })
                    })
                    .done(function (data) {
                        getProductProcessData();
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

    function setProductBom()
    {
        $("#bomModal").modal("show");

        $("#pop_bom_prod_cd").html(IsEmpty(arguments[0].prod_cd));
        $("#pop_bom_prod_pn").html(IsEmpty(arguments[0].prod_pn));
        $("#pop_bom_prod_nm").html(IsEmpty(arguments[0].prod_nm));
        $("#pop_bom_prod_kind_nm").html(IsEmpty(arguments[0].prod_kind_nm));
        $("#pop_bom_prod_stand").html(IsEmpty(arguments[0].prod_stand));
        $("#pop_bom_prod_unit_nm").html(IsEmpty(arguments[0].prod_unit_nm));

        getProductBomData();
    }

    function getProductBomData()
    {
        showWait('.dataModal');

        $.ajax({
            url: "/mes/base/product/bom/prodBomList"
            ,type: "post"
            ,headers: {
                "Content-Type": "application/json"
                ,"X-HTTP-Method-Override": "POST"
            }
            ,dataType: "json"
            ,data: JSON.stringify({
                fact_cd: "${vmap.fact_cd}"
                ,prod_cd: $("#pop_proc_prod_cd").text()
            })
        })
        .done(function (data)
        {
            $("#tblPopBom > tbody").empty();

            data.forEach((item, index) => {
                addPopBomRow(item);
            });

        })
        .always(function (data) {
            hideWait('.dataModal');
        })
        .fail(function (jqHXR, textStatus, errorThrown) {
            ajaxErrorAlert(jqHXR);
        });
    }

    function addPopBomRow(data)
    {
        let template_html = $("#popBomTemplete").html();
        let template = Handlebars.compile(template_html);
        let rowCnt = $("#tblPopBom > tbody > tr").length + 1;
        let templateData;

        if(IsNotNull(data)) {
            templateData = {
                cnt : rowCnt
                ,prod_bom_cd: data.prod_bom_cd
                ,prod_ja_cd: data.prod_ja_cd
                ,prod_ja_nm: data.prod_ja_nm
                ,prod_bom_cnt: data.prod_bom_cnt.comma('6')
                ,prod_bom_notice: data.prod_bom_notice
                ,selector: "[" + data.prod_ja_cd + "] " + data.prod_ja_nm
            }

            $("#tblPopBom > tbody").append(template(templateData));
            $("#tblPopBom .list_tr" + rowCnt).find("[name=pop_proc_cd]").val(data.proc_cd);

        }else {
            templateData = {
                cnt : rowCnt
            }

            $("#tblPopBom > tbody").append(template(templateData));
        }

        initAutoComplete2($("#tblPopBom .list_tr" + rowCnt).find("[name=pop_selector2]"));

        $("#tblPopBom .list_tr" + rowCnt)
            .find("input[name$='cnt'], input[name$='price'], input[name$='amt'], input[name$='total'], input[name$='rate'], input[name$='min']")
            .css("text-align", "right")
            .on("click", function() {
                $(this).select();
            })
            .on("keyup", function() {
                $(this).val($(this).val().comma("2"));
            });
    }

    // 제품 BOM정보 data regist
    function prodBomRegistModifyData()
    {
        showWait('.dataModal');

        //. Data List
        let ary_prod_bom_cd = [];
        let ary_proc_cd = [];
        let ary_prod_ja_cd = [];
        let ary_prod_bom_cnt = [];
        let ary_prod_bom_notice = [];

        $.each($("#tblPopBom > tbody > tr"), function(index, item)
        {
            ary_prod_bom_cd.push($(item).find("input[name=pop_prod_bom_cd]").val());
            ary_proc_cd.push($(item).find("select[name=pop_proc_cd]").val());
            ary_prod_ja_cd.push($(item).find("input[name=pop_prod_ja_cd]").val());
            ary_prod_bom_cnt.push($(item).find("input[name=pop_prod_bom_cnt]").val().replace(/,/g, ""));
            ary_prod_bom_notice.push($(item).find("input[name=pop_prod_bom_notice]").val());
        });

        $.ajax({
            type: "post"
            ,url: "/mes/base/product/bom/prodBomRegistModify"
            ,headers: {
                "Content-Type": "application/json"
                ,"X-HTTP-Method-Override": "POST"
            }
            ,dataType: "text"
            ,data: JSON.stringify({
                fact_cd: "${vmap.fact_cd}"
                ,prod_cd: $("#pop_bom_prod_cd").text()
                ,ary_prod_bom_cd: ary_prod_bom_cd
                ,ary_proc_cd: ary_proc_cd
                ,ary_prod_ja_cd: ary_prod_ja_cd
                ,ary_prod_bom_cnt: ary_prod_bom_cnt
                ,ary_prod_bom_notice: ary_prod_bom_notice
            })
        })
        .done(function (data) {
            hideWait('.dataModal');
            $("#dataModal").modal("hide");
            getProductBomData();
        })
        .always(function (data) {

        })
        .fail(function (jqHXR, textStatus, errorThrown) {
            ajaxErrorAlert(jqHXR);
            hideWait('.dataModal');
        });
    }

    function prodBomDelete(cnt)
    {
        let prod_bom_cd = $("#tblPopBom .list_tr" + cnt).find("[name=pop_prod_bom_cd]").val();

        if(IsNull(prod_bom_cd))
        {
            $("#tblPopBom .list_tr" + cnt).remove();
        }
        else
        {
            Swal.fire({
            title: '',
            text: "제품-BOM 정보를 삭제하시겠습니까?",
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
                        ,url: "/mes/base/product/bom/prodBomDelete"
                        ,headers: {
                            "Content-Type": "application/json"
                            ,"X-HTTP-Method-Override": "DELETE"
                        }
                        ,dataType: "text"
                        ,data: JSON.stringify({
                            prod_bom_cd: prod_bom_cd
                        })
                    })
                    .done(function (data) {
                        getProductBomData();
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