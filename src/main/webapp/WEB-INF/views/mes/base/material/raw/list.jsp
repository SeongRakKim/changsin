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
                <th>자재분류</th>
                <td>
                    <select id="prod_group" name="prod_group" class="custom-select w-100" required="">
                        <option value="">자재분류선택</option>
                        <c:forEach var="item" items="${vmap.mateGroupList}" varStatus="status">
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
                <i class="fas fa-home"></i> <i class="fas fa-arrow-circle-right"></i> 기준정보 <i class="fas fa-arrow-circle-right"></i> 원자재정보
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
                            <input type="hidden" id="prod_kind" name="prod_kind" value="MO" />
                            <input type="hidden" id="prod_cls" name="prod_cls" value="M" />
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
                                    <th>자재코드</th>
                                    <th>품번</th>
                                    <th>품명</th>
                                    <th>분류</th>
                                    <th>규격</th>
                                    <th>단위</th>
                                    <th>단가</th>
                                    <th>주거래처</th>
                                    <th>안전재고</th>
                                    <th>자재재고</th>
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
                                    <th>자재코드</th>
                                    <td>
                                        <input type="text" id="pop_prod_cd" name="pop_prod_cd" class="form-control key"
                                               placeholder="자재코드 / 미입력 시 자동생성" title="자재코드"
                                        />
                                        <div class="invalid-feedback"></div>
                                    </td>
                                    <th>자재품번<span class="red"> (필수)</span></th>
                                    <td>
                                        <input type="text" id="pop_prod_pn" name="pop_prod_pn" class="form-control"
                                               placeholder="자재품번" title="자재품번"
                                               required />
                                    </td>
                                    <th>자재명<span class="red"> (필수)</span></th>
                                    <td>
                                        <input type="text" id="pop_prod_nm" name="pop_prod_nm" class="form-control"
                                               placeholder="자재명" title="자재명"
                                               required />
                                    </td>
                                </tr>
                                <tr>
                                    <th>자재분류 <span class="red"> (필수)</span></th>
                                    <td>
                                        <select id="pop_prod_group" name="pop_prod_group" class="custom-select w-100"  title="자재분류" required>
                                            <option value="">자재분류선택</option>
                                            <c:forEach var="item" items="${vmap.mateGroupList}" varStatus="status">
                                                <option value="${item.base_detail_cd}">${item.base_detail_nm}</option>
                                            </c:forEach>
                                        </select>
                                    </td>
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
                                </tr>
                                <tr>
                                    <th>단가</th>
                                    <td>
                                        <input type="text" id="pop_prod_price" name="pop_prod_price" class="form-control" value="0"
                                               placeholder="단가" title="단가" />
                                    </td>
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

        <script>

            $(document).ready(() => {
                // DataTables setting
                setDatatable();
                getData();
                initAutoCompelte("#pop_selector");


                $("input:radio[name=pop_prod_mass_yn]").on("change", () => {
                    $("input:radio[name=pop_prod_mass_yn]").each(function() {
                    });
                });

                $("#prod_kind, #prod_family, #prod_group").on("change", () => { getData() });

                // 조회
                $("#btnSearch").on("click", () => { getData() });

                // Add Data - Call Data Form
                $("#btnNew").on("click", () => {
                    callEditmodal("원자재 추가", "R");
                });

                // 상세조회
                $("#tblMaster").on("dblclick", "tr", function() {
                    let prod_cd = $(this).find("input[name=prod_cd]").val();
                    callEditmodal("원자재 수정", "M");
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
                        text: "원자재 정보를 저장하시겠습니까?",
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
                        text: "원자재 정보를 삭제하시겠습니까?",
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

                $("#pop_prod_cd").on("keyup", () => {
                    if($("#pop_prod_cd").val().length > 3)
                    {
                        $.ajax({
                            type : 'get'
                            ,url: '/mes/base/material/mateOverlap/' + $("#pop_prod_cd").val()
                            ,dataType : 'json'
                        })
                            .done(function (data)
                            {
                                if(data) {
                                    $("#pop_prod_cd").removeClass("is-valid");
                                    $("#pop_prod_cd").addClass("is-invalid");
                                    $(".invalid-feedback").text("중복된 자재 코드입니다.");
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

            function initAutoCompelte(el)
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
                        ,prod_kind: $("#prod_kind").val()
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
                            node.push(IsEmpty(item.prod_group_nm));
                            node.push(IsEmpty(item.prod_stand));
                            node.push(IsEmpty(item.prod_unit_nm));
                            node.push("<div class='text-right'>" + IsEmpty(item.prod_price.comma('2')) + "</div>");
                            node.push(IsEmpty(item.prod_main_comp_nm));
                            node.push("<div class='text-right'>" + IsEmpty(item.prod_keep_cnt.comma('2')) + "</div>");
                            node.push("<div class='text-right'>" + IsEmpty(item.prod_stock_cnt.comma('2')) + "</div>");

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
                    url: "/mes/base/material/mateOne/" + prod_cd
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
                        ,prod_kind: $("#prod_kind").val()
                        ,prod_cls: $("#prod_cls").val()
                        ,prod_cd: $("#pop_prod_cd").val()
                        ,prod_pn: $("#pop_prod_pn").val()
                        ,prod_nm: $("#pop_prod_nm").val()
                        ,prod_group: $("#pop_prod_group").val()
                        ,prod_unit: $("#pop_prod_unit").val()
                        ,prod_stand: $("#pop_prod_stand").val()
                        ,prod_price: $("#pop_prod_price").val().replace(/,/g, "")
                        ,prod_main_comp: $("#pop_prod_main_comp").val()
                        ,prod_keep_cnt: $("#pop_prod_keep_cnt").val().replace(/,/g, "")
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




        </script>

<%@ include file="/WEB-INF/include/footer.jspf" %>