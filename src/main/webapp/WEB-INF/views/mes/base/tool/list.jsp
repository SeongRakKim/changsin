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
                <col style="width: 20%">
                <col style="width: 30%">
                <col style="width: 20%">
                <col style="width: 30%">
            </colgroup>
            <thead class="thead-light">
                <tr>
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

    <div class="menu-nav">
        <div>
            <span class="btn btn-pill btn-sm btn-primary">
                <i class="fas fa-home"></i> <i class="fas fa-arrow-circle-right"></i> 기준정보 <i class="fas fa-arrow-circle-right"></i> 치공구정보
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
                            <table id ="tblMaster" class="table-list table table-hover table-striped table-bordered mb-5" style="width: 100%">
                                <thead>
                                    <tr role="row">
                                        <th class="no-sort" style="width: 3%">
                                            <div class="custom-control custom-checkbox">
                                                <input type="checkbox" class="custom-control-input" id="listAll">
                                                <label class="custom-control-label" for="listAll"></label>
                                            </div>
                                        </th>
                                        <th>치공구코드</th>
                                        <th>치공구명</th>
                                        <th>치공구번호</th>
                                        <th>규격</th>
                                        <th>제작일</th>
                                        <th>위치</th>
                                        <th>적용제품</th>
                                        <th>관리부서</th>
                                        <th>최종검사일</th>
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
                                <th>치공구코드</th>
                                <td>
                                    <input type="text" id="pop_tool_cd" name="pop_tool_cd" class="form-control key"
                                           placeholder="치공구코드 / 미입력 시 자동생성" title="치공구코드"
                                           />
                                    <div class="invalid-feedback"></div>
                                </td>
                                <th>치공구명<span class="red"> (필수)</span></th>
                                <td>
                                    <input type="text" id="pop_tool_nm" name="pop_tool_nm" class="form-control"
                                           placeholder="치공구명" title="치공구명"
                                           required />
                                </td>
                                <th>치공구번호</th>
                                <td>
                                    <input type="text" id="pop_tool_no" name="pop_tool_no" class="form-control"
                                           placeholder="관리번호" title="관리번호" />
                                </td>
                            </tr>
                            <tr>
                                <th>치공구규격</th>
                                <td>
                                    <input type="text" id="pop_tool_stand" name="pop_tool_stand" class="form-control"
                                           placeholder="치공구규격" title="치공구규격" />
                                </td>
                                <th>제작일</th>
                                <td>
                                    <input type="text" id="pop_tool_date" name="pop_tool_date" class="form-control datepicker"
                                           placeholder="제작일" title="제작일" />
                                </td>
                                <th>위치</th>
                                <td>
                                    <input type="text" id="pop_tool_loc" name="pop_tool_loc" class="form-control"
                                           placeholder="위치" title="위치" />
                                </td>
                            </tr>
                            <tr>
                                <th>적용제품</th>
                                <td>
                                    <select id="pop_tool_pmok" name="pop_tool_pmok" class="custom-select w-100" required title="적용제품">
                                        <option value="">적용제품선택</option>
                                        <c:forEach var="item" items="${vmap.productList}" varStatus="status">
                                            <option value="${item.prod_cd}">${item.prod_nm}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                                <th>관리부서</th>
                                <td>
                                    <select id="pop_tool_dept" name="pop_tool_dept" class="custom-select w-100" required title="관리부서">
                                        <option value="">관리부서선택</option>
                                        <c:forEach var="item" items="${vmap.deptList}" varStatus="status">
                                            <option value="${item.dept_cd}">${item.dept_nm}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                                <th>최종검사일</th>
                                <td>
                                    <input type="text" id="pop_tool_check_date" name="pop_tool_check_date" class="form-control datepicker"
                                           placeholder="최종검사일" title="최종검사일" />
                                </td>
                            </tr>
                            <tr>
                                <th>비고</th>
                                <td colspan="5">
                                    <input type="text" id="pop_tool_notice" name="pop_tool_notice" class="form-control" placeholder="비고" title="비고" />
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
            callEditmodal("치공구 추가", "R");
        });

        // 상세조회
        $("#tblMaster").on("dblclick", "tr", function() {
            let tool_cd = $(this).find("input[name=tool_cd]").val();
            callEditmodal("치공구 수정", "M");
            getDataOne(tool_cd);
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
                text: "치공구 정보를 저장하시겠습니까?",
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

            if($("input[name=listCheck]:checked").length === 0) {
                alert("삭제할 데이터를 선택하세요.");
                return false;
            }

            Swal.fire({
                title: '',
                text: "치공구 정보를 삭제하시겠습니까?",
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

        $("#pop_tool_cd").on("keyup", () => {
            if($("#pop_tool_cd").val().length > 3)
            {
                $.ajax({
                    type : 'get'
                    ,url: '/mes/base/tool/toolOverlap/' + $("#pop_tool_cd").val()
                    ,dataType : 'json'
                })
                    .done(function (data)
                    {
                        if(data) {
                            $("#pop_tool_cd").removeClass("is-valid");
                            $("#pop_tool_cd").addClass("is-invalid");
                            $(".invalid-feedback").text("중복된 치공구 코드입니다.");
                        }else {
                            $("#pop_tool_cd").removeClass("is-invalid");
                            $("#pop_tool_cd").addClass("is-valid");
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
            url: "/mes/base/tool/toolList"
            ,type: "post"
            ,headers: {
                "Content-Type": "application/json"
                ,"X-HTTP-Method-Override": "POST"
            }
            ,dataType: "json"
            ,data: JSON.stringify({
                fact_cd: "${vmap.fact_cd}"
                ,search_text: $("#search_text").val()
            })
        })
        .done(function (data)
        {
            $("#tblMaster").DataTable().clear();

            data.forEach((item, index) => {
                let node = [];

                let checkBoxNode = "<div class=\"custom-control custom-checkbox\">" +
                                   "    <input type=\"hidden\" name=\"tool_cd\" value=\"" + item.tool_cd + "\">" +
                                   "    <input type=\"checkbox\" class=\"custom-control-input\" id=\"listCheck_" + index + "\" name=\"listCheck\">" +
                                   "    <label class=\"custom-control-label\" for=\"listCheck_" + index + "\"></label>" +
                                   "</div>";

                node.push(checkBoxNode);
                node.push(IsEmpty(item.tool_cd));
                node.push(IsEmpty(item.tool_nm));
                node.push(IsEmpty(item.tool_no));
                node.push(IsEmpty(item.tool_stand));
                node.push(IsEmpty(item.tool_date));
                node.push(IsEmpty(item.tool_loc));
                node.push(IsEmpty(item.tool_pmok_nm));
                node.push(IsEmpty(item.tool_dept_nm));
                node.push(IsEmpty(item.tool_check_date));
                node.push(IsEmpty(item.tool_notice));

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

    function getDataOne(tool_cd)
    {
        showWait('.dataModal');

        $.ajax({
            url: "/mes/base/tool/toolOne/" + tool_cd
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
            ,url: "/mes/base/tool/toolRegistModify"
            ,headers: {
                "Content-Type": "application/json"
                ,"X-HTTP-Method-Override": "POST"
            }
            ,dataType: "text"
            ,data: JSON.stringify({
                fact_cd: "${vmap.fact_cd}"
                ,tool_cd: $("#pop_tool_cd").val()
                ,tool_nm: $("#pop_tool_nm").val()
                ,tool_no: $("#pop_tool_no").val()
                ,tool_stand: $("#pop_tool_stand").val()
                ,tool_date: $("#pop_tool_date").val()
                ,tool_loc: $("#pop_tool_loc").val()
                ,tool_pmok: $("#pop_tool_pmok").val()
                ,tool_dept: $("#pop_tool_dept").val()
                ,tool_check_date: $("#pop_tool_check_date").val()
                ,tool_notice: $("#pop_tool_notice").val()
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
            deleteItems.push($(this).closest("tr").find("input[name=tool_cd]").val());
        });

        $.ajax({
            type: "delete"
            ,url: "/mes/base/tool/toolPackDelete"
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