<%--
  Created by IntelliJ IDEA.
  User: Mi Ra
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
                <i class="fas fa-home"></i> <i class="fas fa-chevron-right"></i> 기준정보 <i class="fas fa-chevron-right"></i> 설비정보
            </span>
        </div>

        <%@ include file="/WEB-INF/include/main-top-right.jspf"%>
    </div>

    <%@ include file="/WEB-INF/include/main-progress.jspf"%>

    <div class="main-content">
        <table class="tableSearch table table-hover table-striped table-bordered mb-5" style="margin-bottom: 0.5rem !important;">
            <colgroup>
                <col style="width: 10%">
                <col style="width: 20%">
                <col style="width: 10%">
                <col style="width: 20%">
                <col style="width: 10%">
                <col style="width: 30%">
            </colgroup>
            <thead class="thead-light">
                <tr>
                    <th>공정</th>
                    <td>
                        <select id="proc_cd" name="proc_cd" class="custom-select w-100" required="">
                            <option value="">공정선택</option>
                            <c:forEach var="item" items="${vmap.processList}" varStatus="status">
                                <option value="${item.proc_cd}">${item.proc_nm}</option>
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
                    <th></th>
                    <td></td>
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
                                <th>설비코드</th>
                                <td>
                                    <input type="text" id="pop_equ_cd" name="pop_equ_cd" class="form-control key"
                                           placeholder="설비코드 / 미입력 시 자동생성" title="설비코드"
                                           />
                                    <div class="invalid-feedback"></div>
                                </td>
                                <th>설비명<span class="red"> (필수)</span></th>
                                <td>
                                    <input type="text" id="pop_equ_nm" name="pop_equ_nm" class="form-control"
                                           placeholder="설비명" title="설비명"
                                           required />
                                </td>
                                <th>공정<span class="red"> (필수)</span></th>
                                <td>
                                    <select id="pop_proc_cd" name="pop_proc_cd" class="custom-select w-100" required>
                                        <option value="">공정선택</option>
                                        <c:forEach var="item" items="${vmap.processList}" varStatus="status">
                                            <option value="${item.proc_cd}">${item.proc_nm}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th>설비번호</th>
                                <td>
                                    <input type="text" id="pop_equ_no" name="pop_equ_no" class="form-control"
                                           placeholder="설비번호" title="설비번호" />
                                </td>
                                <th>설비모델명</th>
                                <td>
                                    <input type="text" id="pop_equ_model" name="pop_equ_model" class="form-control"
                                           placeholder="설비모델명" title="설비모델명" />
                                </td>
                                <th>설비타입</th>
                                <td>
                                    <input type="text" id="pop_equ_type" name="pop_equ_type" class="form-control"
                                           placeholder="설비타입" title="설비타입" />
                                </td>
                            </tr>
                            <tr>
                                <th>제작국</th>
                                <td>
                                    <input type="text" id="pop_equ_nation" name="pop_equ_nation" class="form-control"
                                           placeholder="제작국" title="제작국" />
                                </td>
                                <th>제작사</th>
                                <td>
                                    <input type="text" id="pop_equ_company" name="pop_equ_company" class="form-control"
                                           placeholder="제작사" title="제작사" />
                                </td>
                                <th></th>
                                <td></td>
                            </tr>
                            <tr>
                                <th>비고</th>
                                <td colspan="5">
                                    <input type="text" id="pop_equ_notice" name="pop_equ_notice" class="form-control" placeholder="비고" title="비고" />
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

        // 조회
        $("#btnSearch").on("click", () => { getData() });

        // Add Data - Call Data Form
        $("#btnNew").on("click", () => {
            callEditmodal("설비 추가", "R");
        });

        // 상세조회
        $("#tblMaster").on("dblclick", "tr", function() {
            let equ_cd = $(this).find("input[name=equ_cd]").val();
            callEditmodal("설비 수정", "M");
            getDataOne(equ_cd);
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
                text: "설비 정보를 저장하시겠습니까?",
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
                text: "설비 정보를 삭제하시겠습니까?",
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

        $("#pop_equ_cd").on("keyup", () => {
            if($("#pop_equ_cd").val().length > 3)
            {
                $.ajax({
                    type : 'get'
                    ,url: '/mes/base/equipment/equOverlap/' + $("#pop_equ_cd").val()
                    ,dataType : 'json'
                })
                    .done(function (data)
                    {
                        if(data) {
                            $("#pop_equ_cd").removeClass("is-valid");
                            $("#pop_equ_cd").addClass("is-invalid");
                            $(".invalid-feedback").text("중복된 설비 코드입니다.");
                        }else {
                            $("#pop_equ_cd").removeClass("is-invalid");
                            $("#pop_equ_cd").addClass("is-valid");
                            $(".invalid-feedback").text("");
                        }
                    })
                    .always(function (data) {

                    });
            }
        });

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
            url: "/mes/base/equipment/equList"
            ,type: "post"
            ,headers: {
                "Content-Type": "application/json"
                ,"X-HTTP-Method-Override": "POST"
            }
            ,dataType: "json"
            ,data: JSON.stringify({
                fact_cd: "${vmap.fact_cd}"
                ,equ_kind: $("#equ_kind").val()
                ,equ_family: $("#equ_family").val()
                ,equ_group: $("#equ_group").val()
                ,search_text: $("#search_text").val()
            })
        })
        .done(function (data)
        {
            $("#tblMaster").DataTable().clear();

            data.forEach((item, index) => {
                let node = [];

                let checkBoxNode = "<div class=\"custom-control custom-checkbox\">" +
                                   "    <input type=\"hidden\" name=\"equ_cd\" value=\"" + item.equ_cd + "\">" +
                                   "    <input type=\"checkbox\" class=\"custom-control-input\" id=\"listCheck_" + index + "\" name=\"listCheck\">" +
                                   "    <label class=\"custom-control-label\" for=\"listCheck_" + index + "\"></label>" +
                                   "</div>";

                node.push(checkBoxNode);
                node.push(IsEmpty(item.equ_cd));
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

    function getDataOne(equ_cd)
    {
        showWait('.dataModal');

        $.ajax({
            url: "/mes/base/equipment/equOne/" + equ_cd
            ,type: "get"
            ,dataType: "json"
            // ,data: JSON.stringify({})
        })
        .done(function (data)
        {
            setDataOne("pop_", data);
            $("#dataForm").find(".key").prop("disabled", true);
            $("#pop_selector").val(data.equ_main_comp_nm);
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
            ,url: "/mes/base/equipment/equRegistModify"
            ,headers: {
                "Content-Type": "application/json"
                ,"X-HTTP-Method-Override": "POST"
            }
            ,dataType: "text"
            ,data: JSON.stringify({
                fact_cd: "${vmap.fact_cd}"
                ,equ_cd: $("#pop_equ_cd").val()
                ,equ_nm: $("#pop_equ_nm").val()
                ,proc_cd: $("#pop_proc_cd").val()
                ,equ_no: $("#pop_equ_no").val()
                ,equ_model: $("#pop_equ_model").val()
                ,equ_type: $("#pop_equ_type").val()
                ,equ_nation: $("#pop_equ_nation").val()
                ,equ_company: $("#pop_equ_company").val()
                ,equ_notice: $("#pop_equ_notice").val()
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
            deleteItems.push($(this).closest("tr").find("input[name=equ_cd]").val());
        });

        $.ajax({
            type: "delete"
            ,url: "/mes/base/equipment/equPackDelete"
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