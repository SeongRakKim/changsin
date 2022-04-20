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
                <col style="width: 20%">
                <col style="width: 10%">
                <col style="width: 20%">
                <col style="width: 10%">
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
                    <th></th>
                    <td></td>
                </tr>
            </thead>
        </table>
    </div>

    <div class="menu-nav">
        <div>
            <span class="btn btn-pill btn-sm btn-primary">
                <i class="fas fa-home"></i> <i class="fas fa-arrow-circle-right"></i> 기준정보 <i class="fas fa-arrow-circle-right"></i> 공정정보
            </span>
        </div>

        <%@ include file="/WEB-INF/include/main-top-right.jspf"%>
    </div>

    <%@ include file="/WEB-INF/include/main-progress.jspf"%>

    <div class="card shadow col-12" style="min-height: 770px;">
        <div class="card-body">
            <div class="table-responsive">
                <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
                    <div class="row">
                        <div class="col-sm-6">
                            <div style="float: right; margin: 5px 5px 5px 5px;">
                                <button class="btn btn-sm btn-first" type="button" id="btnInsert">
                                <span class="btn-wrapper--icon">
                                    <i class="fas fa-save"></i>
                                </span>
                                    <span class="btn-wrapper--label">저장</span>
                                </button>
                            </div>
                            <table id="tblDeptData" class="table table-hover table-bordered mb-5 table-form">
                                <colgroup>
                                    <col style="width: 80%">
                                    <col style="width: 20%">
                                </colgroup>
                                <thead>
                                    <tr role="row">
                                        <th>부서명</th>
                                        <th>
                                            <button type="button" id="btnAddDeptList" class="btn btn-primary btn-sm">
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
                        <div class="col-sm-6">
                            <div style="float: right; margin: 5px 5px 5px 5px;">
                                <button class="btn btn-sm btn-first" type="button" id="btnInsert2">
                                <span class="btn-wrapper--icon">
                                    <i class="fas fa-save"></i>
                                </span>
                                    <span class="btn-wrapper--label">저장</span>
                                </button>
                            </div>
                            <table id="tblGradeData" class="table table-hover table-bordered mb-5 table-form">
                                <colgroup>
                                    <col style="width: 80%">
                                    <col style="width: 20%">
                                </colgroup>
                                <thead>
                                    <tr role="row">
                                        <th>직급명</th>
                                        <th>
                                            <button type="button" id="btnAddGradeList" class="btn btn-primary btn-sm">
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
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script id="deptTemplete" type="text/x-handlebars-template">
    <tr class="dataList list_tr{{cnt}}">
        <td>
            <input type="hidden" name="dept_cd" class="form-control" value="{{dept_cd}}" />
            <input type="text" name="dept_nm" class="form-control" value="{{dept_nm}}"
                   placeholder="부서명" title="부서명" required />
        </td>
        <td style="text-align: center !important;">
            <button class="btn btn-sm btn-danger result-delete" type="button" onclick="deptDelete({{cnt}})">
            <span class="btn-wrapper--icon">
                <i class="fas fa-minus-circle"></i>
            </span>
                <span class="btn-wrapper--label">삭제</span>
            </button>
        </td>
    </tr>
</script>

<script id="gradeTemplete" type="text/x-handlebars-template">
    <tr class="dataList list_tr{{cnt}}">
        <td>
            <input type="hidden" name="grade_cd" class="form-control" value="{{grade_cd}}" />
            <input type="text" name="grade_nm" class="form-control" value="{{grade_nm}}"
                   placeholder="직급명" title="직급명" required />
        </td>
        <td style="text-align: center !important;">
            <button class="btn btn-sm btn-danger result-delete" type="button" onclick="gradeDelete({{cnt}})">
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
        getData();
        getData2();

        $("input:radio[name=pop_proc_mass_yn]").on("change", () => {
            $("input:radio[name=pop_proc_mass_yn]").each(function() {
            });
        });

        // 조회
        $("#btnSearch").on("click", () => { getData(), getData2() });

        $("#btnAddDeptList").on("click", () => {
            addDeptRow();
        });

        $("#btnAddGradeList").on("click", () => {
            addGradeRow();
        });

        // 저장
        $("#btnInsert").on("click", () => {

            Swal.fire({
                title: '',
                text: "부서 정보를 저장하시겠습니까?",
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

        $("#btnInsert2").on("click", () => {

            Swal.fire({
                title: '',
                text: "직급 정보를 저장하시겠습니까?",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: '확인',
                cancelButtonText: '취소'
            }).then((result) => {
                if (result.isConfirmed) {
                    registModifyData2();
                }
            });
        });

    });

    function getData()
    {
        showWait('.container-fluid');

        $.ajax({
            url: "/mes/base/department/deptList"
            ,type: "post"
            ,headers: {
                "Content-Type": "application/json"
                ,"X-HTTP-Method-Override": "POST"
            }
            ,dataType: "json"
            ,data: JSON.stringify({
                fact_cd: "${vmap.fact_cd}"
            })
        })
        .done(function (data)
        {
            $("#tblDeptData tbody").empty();

            data.forEach((item, index) => {
                addDeptRow(item);
            });
        })
        .always(function (data) {
            hideWait('.container-fluid');
        })
        .fail(function (jqHXR, textStatus, errorThrown) {
            ajaxErrorAlert(jqHXR);
        });
    }

    function addDeptRow(data) {
        let template_html = $("#deptTemplete").html();
        let template = Handlebars.compile(template_html);
        let resultRowCnt = $("#tblDeptData > tbody > tr").length + 1;
        let templateData;

        if(IsNull(data)) {
            templateData = {
                cnt : resultRowCnt
            };
        }else {
            templateData = {
                cnt : resultRowCnt
                ,dept_cd: data.dept_cd
                ,dept_nm: data.dept_nm
            };
        }

        $("#tblDeptData > tbody").append(template(templateData));
    }

    // Add Data - ajax regist
    function registModifyData()
    {

        let ary_dept_cd = [];
        let ary_dept_nm = [];

        $.each($("#tblDeptData > tbody > tr"), function(index, item)
        {
            ary_dept_cd.push($(item).find("input[name=dept_cd]").val());
            ary_dept_nm.push($(item).find("input[name=dept_nm]").val());
        });

        showWait('.dataModal');

        $.ajax({
            type: "post"
            ,url: "/mes/base/department/deptRegistModify"
            ,headers: {
                "Content-Type": "application/json"
                ,"X-HTTP-Method-Override": "POST"
            }
            ,dataType: "text"
            ,data: JSON.stringify({
                fact_cd: "${vmap.fact_cd}"
                ,ary_dept_cd: ary_dept_cd
                ,ary_dept_nm: ary_dept_nm
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

    function deptDelete(cnt)
    {
        let dept_cd = $("#tblDeptData .list_tr" + cnt).find("[name=dept_cd]").val();

        if(IsNull(dept_cd))
        {
            $("#tblDeptData .list_tr" + cnt).remove();
        }
        else
        {
            Swal.fire({
                title: '',
                text: "부서정보를 삭제하시겠습니까?",
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
                        ,url: "/mes/base/department/deptDelete"
                        ,headers: {
                            "Content-Type": "application/json"
                            ,"X-HTTP-Method-Override": "DELETE"
                        }
                        ,dataType: "text"
                        ,data: JSON.stringify({
                            dept_cd: dept_cd
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
                    });
                }
            });
        }
    }

    function getData2()
    {
        showWait('.container-fluid');

        $.ajax({
            url: "/mes/base/grade/gradeList"
            ,type: "post"
            ,headers: {
                "Content-Type": "application/json"
                ,"X-HTTP-Method-Override": "POST"
            }
            ,dataType: "json"
            ,data: JSON.stringify({
                fact_cd: "${vmap.fact_cd}"
            })
        })
        .done(function (data)
        {
            $("#tblGradeData tbody").empty();

            data.forEach((item, index) => {
                addGradeRow(item);
            });
        })
        .always(function (data) {
            hideWait('.container-fluid');
        })
        .fail(function (jqHXR, textStatus, errorThrown) {
            ajaxErrorAlert(jqHXR);
        });
    }

    function addGradeRow(data) {
        let template_html = $("#gradeTemplete").html();
        let template = Handlebars.compile(template_html);
        let resultRowCnt = $("#tblGradeData > tbody > tr").length + 1;
        let templateData;

        if(IsNull(data)) {
            templateData = {
                cnt : resultRowCnt
            };
        }else {
            templateData = {
                cnt : resultRowCnt
                ,grade_cd: data.grade_cd
                ,grade_nm: data.grade_nm
            };
        }

        $("#tblGradeData > tbody").append(template(templateData));
    }

    // Add Data - ajax regist
    function registModifyData2()
    {

        let ary_grade_cd = [];
        let ary_grade_nm = [];

        $.each($("#tblGradeData > tbody > tr"), function(index, item)
        {
            ary_grade_cd.push($(item).find("input[name=grade_cd]").val());
            ary_grade_nm.push($(item).find("input[name=grade_nm]").val());
        });

        showWait('.dataModal');

        $.ajax({
            type: "post"
            ,url: "/mes/base/grade/gradeRegistModify"
            ,headers: {
                "Content-Type": "application/json"
                ,"X-HTTP-Method-Override": "POST"
            }
            ,dataType: "text"
            ,data: JSON.stringify({
                fact_cd: "${vmap.fact_cd}"
                ,ary_grade_cd: ary_grade_cd
                ,ary_grade_nm: ary_grade_nm
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

    function gradeDelete(cnt)
    {
        let grade_cd = $("#tblGradeData .list_tr" + cnt).find("[name=grade_cd]").val();

        if(IsNull(grade_cd))
        {
            $("#tblGradeData .list_tr" + cnt).remove();
        }
        else
        {
            Swal.fire({
                title: '',
                text: "직급정보를 삭제하시겠습니까?",
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
                        ,url: "/mes/base/grade/gradeDelete"
                        ,headers: {
                            "Content-Type": "application/json"
                            ,"X-HTTP-Method-Override": "DELETE"
                        }
                        ,dataType: "text"
                        ,data: JSON.stringify({
                            grade_cd: grade_cd
                        })
                    })
                    .done(function (data) {
                        hideWait('.dataModal');
                        getData2();
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