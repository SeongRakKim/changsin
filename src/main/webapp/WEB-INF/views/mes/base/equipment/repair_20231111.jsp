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
            </thead>
        </table>
    </div>

    <div class="menu-nav">
        <div>
            <span class="btn btn-pill btn-sm btn-primary">
                <i class="fas fa-home"></i> <i class="fas fa-arrow-circle-right"></i> 기준정보 <i class="fas fa-arrow-circle-right"></i> 설비수리이력
            </span>
        </div>

        <div>
            <button class="btn btn-sm btn-primary" type="button" id="btnSearch">
                                        <span class="btn-wrapper--icon">
                                            <i class="fas fa-search"></i>
                                        </span>
                <span class="btn-wrapper--label">조회</span>
            </button>
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
                                    <th>설비코드</th>
                                    <th>공정</th>
                                    <th>설비명</th>
                                    <th>설비번호</th>
                                    <th>타입</th>
                                    <th>모델</th>
                                    <th>제작국</th>
                                    <th>제작사</th>
                                    <th>비고</th>
                                </tr>
                                </thead>
                                <tbody></tbody>
                            </table>
                            <div style="display: flex; flex-wrap: nowrap; justify-content: space-between; align-items: center;">
                                <div>
                                    <span style="font-weight: 600; font-size: 30px; margin-left: 28px;">
                                    <i class="fas fa-align-justify"></i> 수리이력 ( <span id="cur_equ_nm"></span> )
                                </span>
                                </div>
                                <div id="btnGroup">
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
                                </div>
                            </div>
                            <table id ="tblMaster2" class="table-list table table-hover table-striped table-bordered mb-5" style="width: 100%">
                                <input type="hidden" id="cur_equ_cd" name="cur_equ_cd" />
                                <thead>
                                    <tr role="row">
                                        <th class="no-sort" style="width: 3%">
                                            <div class="custom-control custom-checkbox">
                                                <input type="checkbox" class="custom-control-input" id="listAll">
                                                <label class="custom-control-label" for="listAll"></label>
                                            </div>
                                        </th>
                                        <th>설비수리일</th>
                                        <th>점검구분</th>
                                        <th>원인</th>
                                        <th>수리내역</th>
                                        <th>교체부품</th>
                                        <th>소요시간</th>
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
                        <colgroup>
                            <col style="width: 15%" />
                            <col style="width: 15%" />
                            <col style="width: 15%" />
                            <col style="width: 25%" />
                            <col style="width: 15%" />
                            <col style="width: 15%" />
                        </colgroup>
                        <tbody>
                            <tr>
                                <th>설비수리일</th>
                                <td>
                                    <input type="hidden" id="pop_equ_cd" name="pop_equ_cd" />
                                    <input type="hidden" id="pop_equ_repair_cd" name="pop_equ_repair_cd" />
                                    <input type="text" id="pop_equ_repair_date" name="pop_equ_repair_date" class="form-control datepicker"
                                           placeholder="설비수리일" title="설비수리일"
                                           required />
                                </td>
                                <th>점검구분</th>
                                <td>
                                    <select id="pop_equ_repair_kind" name="pop_equ_repair_kind" class="custom-select w-100" required title="공정">
                                        <option value="">점검구분선택</option>
                                        <c:forEach var="item" items="${vmap.repairKindList}" varStatus="status">
                                            <option value="${item.base_detail_cd}">${item.base_detail_nm}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                                <th>소요시간</th>
                                <td>
                                    <input type="text" id="pop_equ_repair_time" name="pop_equ_repair_time" class="form-control"
                                           placeholder="소요시간" title="소요시간" />
                                </td>
                            </tr>
                            <tr>
                                <th>원인</th>
                                <td colspan="5">
                                    <input type="text" id="pop_equ_repair_cause" name="pop_equ_repair_cause" class="form-control"
                                           placeholder="원인" title="원인" />
                                </td>
                            </tr>
                            <tr>
                                <th>수리내역</th>
                                <td colspan="5">
                                    <input type="text" id="pop_equ_repair_break" name="pop_equ_repair_break" class="form-control"
                                           placeholder="수리내역" title="수리내역" />
                                </td>
                            </tr>
                            <tr>
                                <th>교체부품</th>
                                <td colspan="5">
                                    <input type="text" id="pop_equ_repair_part" name="pop_equ_repair_part" class="form-control"
                                           placeholder="교체부품" title="교체부품" />
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
        setDatatable2();

        $("#prod_kind, #prod_family, #prod_group").on("change", () => { getData() });

        // 조회
        $("#btnSearch").on("click", () => { getData() });

        $("#tblMaster").on("click", "tr", function() {
            let equ_cd = $(this).find("input[name=equ_cd]").val();
            let equ_nm = $(this).find("input[name=equ_nm]").val();
            $("#cur_equ_cd").val(equ_cd);
            $("#cur_equ_nm").text(equ_nm);
            getData2(equ_cd);
        });

        // Add Data - Call Data Form
        $("#btnNew").on("click", () => {
            if(IsNull($("#cur_equ_cd").val())) {
                eAlert("설비를 선택해주세요.");
                return;
            }

            callEditmodal("수리이력 추가", "R");
            $("#pop_equ_cd").val($("#cur_equ_cd").val());
        });

        // 상세조회
        $("#tblMaster2").on("dblclick", "tr", function() {
            let equ_cd = $(this).find("input[name=equ_cd]").val();
            let equ_repair_cd = $(this).find("input[name=equ_repair_cd]").val();
            callEditmodal("수리이력 수정", "M");
            getDataOne(equ_cd, equ_repair_cd);
        });

        // 저장
        $("#btnPopRegist").on("click", () =>
        {
            if(!parsleyIsValidate("dataForm")) return false;

            Swal.fire({
                title: '',
                text: "수리이력을 저장하시겠습니까?",
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
        $("#btnDelete").on("click", () =>
        {
            if($("input[name=listCheck]:checked").length === 0) {
                alert("삭제할 데이터를 선택하세요.");
                return false;
            }

            Swal.fire({
                title: '',
                text: "수리이력 정보를 삭제하시겠습니까?",
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

        setTimeout(() => getData(), 30);

    });

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
            ,paging: false
            ,field: false
            ,info: false
            ,filter: false
            ,stateSave: true
            ,collapse: false
            ,scrollY: 200
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

    // set tblMaster Database
    function setDatatable2()
    {
        var arguments2 = {
            tabldID: "tblMaster2"
            ,ordering: true
            // ,responsive: true
            ,orderIdx: []
            ,orderGubn:	[]
            ,rowspan: ""
            ,lengthMenu: [15, 50, 100, 500, 1000]
            ,paging: false
            ,field: false
            ,info: false
            ,filter: false
            ,stateSave: true
            ,collapse: false
            ,scrollY: 300
            ,selected: true
            ,multiSelected: false
            ,columnDefs : [
                {
                    "targets": 'no-sort',
                    "orderable": false
                }
            ]
        };
        setDataTablesOption(arguments2);
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
            url: "/mes/base/equipment/equList"
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
            })
        })
            .done(function (data)
            {
                $("#tblMaster").DataTable().clear();

                data.forEach((item, index) => {
                    let node = [];

                    let checkBoxNode = "<div>" +
                        "    <input type=\"hidden\" name=\"equ_cd\" value=\"" + item.equ_cd + "\">" +
                        "    <input type=\"hidden\" name=\"equ_nm\" value=\"" + item.equ_nm + "\">" +
                        IsEmpty(item.equ_cd) +
                        "</div>";

                    node.push(checkBoxNode);
                    node.push(IsEmpty(item.proc_nm));
                    node.push(IsEmpty(item.equ_nm));
                    node.push(IsEmpty(item.equ_no));
                    node.push(IsEmpty(item.equ_type));
                    node.push(IsEmpty(item.equ_model));
                    node.push(IsEmpty(item.equ_nation));
                    node.push(IsEmpty(item.equ_company));
                    node.push(IsEmpty(item.equ_notice));

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

    function getData2(equ_cd)
    {
        showWait('.container-fluid');

        $.ajax({
            url: "/mes/base/equipment/equRepairList"
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
                ,equ_cd: equ_cd
            })
        })
            .done(function (data)
            {
                $("#tblMaster2").DataTable().clear();

                data.forEach((item, index) => {
                    let node = [];

                    let checkBoxNode = "<div class=\"custom-control custom-checkbox\">" +
                        "    <input type=\"hidden\" name=\"equ_cd\" value=\"" + item.equ_cd + "\">" +
                        "    <input type=\"hidden\" name=\"equ_repair_cd\" value=\"" + item.equ_repair_cd + "\">" +
                        "    <input type=\"checkbox\" class=\"custom-control-input\" id=\"listCheck_" + index + "\" name=\"listCheck\">" +
                        "    <label class=\"custom-control-label\" for=\"listCheck_" + index + "\"></label>" +
                        "</div>";

                    node.push(checkBoxNode);

                    node.push(IsEmpty(item.equ_repair_date));
                    node.push(IsEmpty(item.equ_repair_kind_nm));
                    node.push(IsEmpty(item.equ_repair_cause));
                    node.push(IsEmpty(item.equ_repair_break));
                    node.push(IsEmpty(item.equ_repair_part));
                    node.push(IsEmpty(item.equ_repair_time));

                    // 각 row node 추가
                    let row = $("#tblMaster2").DataTable().row.add(node).node();
                });

                // datatables draw
                $("#tblMaster2").DataTable().draw(false);
            })
            .always(function (data) {
                hideWait('.container-fluid');
            })
            .fail(function (jqHXR, textStatus, errorThrown) {
                ajaxErrorAlert(jqHXR);
            });
    }

    function getDataOne(equ_cd, equ_repair_cd)
    {
        showWait('.dataModal');

        console.log("/mes/base/equipment/equRepairOne/" + equ_cd + "/" + equ_repair_cd)

        $.ajax({
            url: "/mes/base/equipment/equRepairOne/" + equ_cd + "/" + equ_repair_cd
            ,type: "get"
            ,dataType: "json"
            // ,data: JSON.stringify({})
        })
        .done(function (data)
        {
            setDataOne("pop_", data);
            $("#dataForm").find(".key").prop("disabled", true);
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
            ,url: "/mes/base/equipment/equRepairRegistModify"
            ,headers: {
                "Content-Type": "application/json"
                ,"X-HTTP-Method-Override": "POST"
            }
            ,dataType: "text"
            ,data: JSON.stringify({
                fact_cd: "${vmap.fact_cd}"
                ,equ_cd: $("#pop_equ_cd").val()
                ,equ_repair_cd: $("#pop_equ_repair_cd").val()
                ,equ_repair_date: $("#pop_equ_repair_date").val()
                ,equ_repair_kind: $("#pop_equ_repair_kind").val()
                ,equ_repair_time: $("#pop_equ_repair_time").val()
                ,equ_repair_cause: $("#pop_equ_repair_cause").val()
                ,equ_repair_break: $("#pop_equ_repair_break").val()
                ,equ_repair_part: $("#pop_equ_repair_part").val()
            })
        })
        .done(function (data) {
            hideWait('.dataModal');
            $("#dataModal").modal("hide");
            getData2();
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
            deleteItems.push($(this).closest("tr").find("input[name=equ_repair_cd]").val());
        });

        $.ajax({
            type: "delete"
            ,url: "/mes/base/equipment/equRepairPackDelete"
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
            getData2();
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