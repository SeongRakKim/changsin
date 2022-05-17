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
                <i class="fas fa-home"></i> <i class="fas fa-arrow-circle-right"></i> 기준정보 <i class="fas fa-arrow-circle-right"></i> 공지정보
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
                                        <th>제목</th>
                                        <th>시작일</th>
                                        <th>종료일</th>
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
                <input type="hidden" id="modal_state" name="modal_state">
                <div class="modal-body">
                    <table id="tblPopData" class="table table-hover table-bordered mb-5 table-form">
                        <tbody>
                            <tr>
                                <th>제목<span class="red"> (필수)</span></th>
                                <td colspan="3">
                                    <input type="hidden" id="pop_notice_cd" name="pop_notice_cd">
                                    <input type="text" id="pop_notice_title" name="pop_notice_title" class="form-control key" placeholder="제목.." title="제목"
                                           required />
                                </td>
                            </tr>
                            <tr>
                                <th>시작일<span class="red"> (필수)</span></th>
                                <td>
                                    <div class="input-group input-group-seamless">
                                        <input id="pop_notice_stdt" name="pop_notice_stdt" class="form-control datepicker no-reset" title="시작일"
                                               placeholder="시작일" type="text" />
                                        <div class="input-group-append">
                                            <span class="input-group-text"><i class="fas fa-calendar"></i></span>
                                        </div>
                                    </div>
                                </td>
                                <th>종료일<span class="red"> (필수)</span></th>
                                <td>
                                    <div class="input-group input-group-seamless">
                                        <input id="pop_notice_eddt" name="pop_notice_eddt" class="form-control datepicker no-reset" title="종료일"
                                               placeholder="종료일" type="text" />
                                        <div class="input-group-append">
                                            <span class="input-group-text"><i class="fas fa-calendar"></i></span>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>내용</th>
                                <td colspan="3">
                                    <textarea class="form-control rudder" name="pop_notice_content" id="pop_notice_content" placeholder="내용 .." style="min-height:200px;"
                                              title="내용" data-parsley-required="true"></textarea>
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
            callEditmodal("공지 추가", "R");
        });

        // 상세조회
        $("#tblMaster").on("dblclick", "tr", function() {
            let notice_cd = $(this).find("input[name=notice_cd]").val();
            callEditmodal("공지 수정", "M");
            getDataOne(notice_cd);
        });

        // 저장
        $("#btnPopRegist").on("click", () => {

            if(!parsleyIsValidate("dataForm")) return false;

            Swal.fire({
                title: '',
                text: "공지 정보를 저장하시겠습니까?",
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
                text: "공지 정보를 삭제하시겠습니까?",
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

        $("#modal_state").val(flag);
    }

    function resetForm(formId)
    {
        $("#"+formId).find("input").val("");
        $("#"+formId).find("select").val("");
        $("#"+formId).find("input[name$='yn']").val("Y");
        $(".key").removeClass("is-valid").removeClass("is-invalid");
        $(".invalid-feedback").text("");
        $("#"+formId).find(":disabled").prop("disabled", false);
    }

    function getData()
    {
        showWait('.container-fluid');

        $.ajax({
            url: "/mes/base/notice/noticeList"
            ,type: "post"
            ,headers: {
                "Content-Type": "application/json"
                ,"X-HTTP-Method-Override": "POST"
            }
            ,dataType: "json"
            ,data: JSON.stringify({
                fact_cd: "${vmap.fact_cd}"
                ,dept_cd: $("#dept_cd").val()
                ,grade_cd: $("#grade_cd").val()
                ,search_text: $("#search_text").val()
            })
        })
        .done(function (data)
        {
            $("#tblMaster").DataTable().clear();

            data.forEach((item, index) => {
                let node = [];

                let checkBoxNode = "<div class=\"custom-control custom-checkbox\">" +
                                   "    <input type=\"hidden\" name=\"notice_cd\" value=\"" + item.notice_cd + "\">" +
                                   "    <input type=\"checkbox\" class=\"custom-control-input\" id=\"listCheck_" + index + "\" name=\"listCheck\">" +
                                   "    <label class=\"custom-control-label\" for=\"listCheck_" + index + "\"></label>" +
                                   "</div>";

                node.push(checkBoxNode);
                node.push(IsEmpty(item.notice_title));
                node.push(IsEmpty(item.notice_stdt));
                node.push(IsEmpty(item.notice_eddt));

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

    function getDataOne(notice_cd)
    {
        showWait('.dataModal');

        $.ajax({
            url: "/mes/base/notice/noticeOne/" + notice_cd
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
            ,url: "/mes/base/notice/noticeRegistModify"
            ,headers: {
                "Content-Type": "application/json"
                ,"X-HTTP-Method-Override": "POST"
            }
            ,dataType: "text"
            ,data: JSON.stringify({
                fact_cd: "${vmap.fact_cd}"
                ,notice_cd: $("#pop_notice_cd").val()
                ,notice_title: $("#pop_notice_title").val()
                ,notice_eddt: $("#pop_notice_eddt").val()
                ,notice_stdt: $("#pop_notice_stdt").val()
                ,notice_content: $("#pop_notice_content").val()
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
            deleteItems.push($(this).closest("tr").find("input[name=notice_cd]").val());
        });

        $.ajax({
            type: "delete"
            ,url: "/mes/base/notice/noticePackDelete"
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

    function idNumFormat(idNum)
    {
        idNum = idNum.replace(/[^0-9]/g, ''); // 숫자만남고 다지움
        idNum = idNum.substring(0,10); // 10자리남기고 다지움

        if( idNum.length >= 5 ) // 123-45-
        {
            idNum = idNum.substring(0,3) + '-' + idNum.substring(3,5) + '-' + idNum.substring(5);
        }
        else if( idNum.length >= 3 ) // 123-
        {
            idNum = idNum.substring(0,3) + '-' + idNum.substring(3);
        }

        return idNum;
    }

    function strCheck(str, type) {
        var REGEX = {
            EMAIL: /\S+@\S+\.\S+/,
            PWD_RULE: /^(?=.*[a-zA-Z])((?=.*\d)(?=.*\W)).{8,16}$/,
            NAME_RULE: /^[가-힣a-zA-Z]+$/
        };

        if (type === "email") {
            return REGEX.EMAIL.test(str);
        } else if (type === "pwd") {
            return REGEX.PWD_RULE.test(str);
        } else if (type === "name") {
            return REGEX.NAME_RULE.test(str);
        } else {
            return false;
        }
    }



</script>

<%@ include file="/WEB-INF/include/footer.jspf" %>