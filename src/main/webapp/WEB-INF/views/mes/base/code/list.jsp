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
            </thead>
        </table>
    </div>

    <div class="menu-nav">
        <div>
            <span class="btn btn-pill btn-sm btn-primary">
                <i class="fas fa-home"></i> <i class="fas fa-arrow-circle-right"></i> 기준정보 <i class="fas fa-arrow-circle-right"></i> 공통코드관리
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
                                        <th>공통코드</th>
                                        <th>공통코드명</th>
                                        <th>생성일</th>
                                        <th>생성자</th>
                                        <th>최종수정일</th>
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

<%-- 납품 데이터 Modal --%>
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
                        <col style="width: 50%" />
                        <col style="width: 50%" />
                    </colgroup>
                    <tbody>
                        <tr style="height: 40px; font-size: 2.5em;">
                            <th>공통코드</th>
                            <td style="text-align: center;">
                                <input type="hidden" id="pop_base_cd" name="pop_base_cd" class="form-control"
                                       placeholder="공통코드" title="공통코드" />
                                <div id="pop_base_nm" name="pop_base_nm"></div>
                            </td>
                        </tr>
                    </tbody>
                </table>

                <form id="dataForm" name="dataForm" class="dataForm" method="post">
                    <div style="height: 500px; overflow: auto;">
                        <table id="tblPopBaseCodeDetailData" class="table table-hover table-bordered mb-3 table-form">
                            <colgroup>
                                <col style="width: 80%" />
                                <col style="width: 20%" />
                            </colgroup>
                            <thead>
                            <tr>
                                <th>공통코드상세명</th>
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

                <button type="button" id="btnBaseCodeDetailRegistModify" class="btn btn-primary" >
                    <span class="btn-wrapper--icon">
                        <i class="fas fa-check"></i>
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

<script id="popBaseCodeDetailTemplete" type="text/x-handlebars-template">
    <tr class="dataList list_tr{{cnt}}">
        <td style="text-align: center !important;">
            <input type="hidden" name="pop_base_detail_cd" class="form-control" value="{{base_detail_cd}}" />
            <input name="pop_base_detail_nm" class="form-control" title="공통코드상세명"
                   placeholder="공통코드상세명" type="text" value="{{base_detail_nm}}" />
        </td>
        <td style="text-align: center !important;">
            <button class="btn btn-sm btn-danger result-delete" type="button" onclick="baseCodeDetailDelete({{cnt}})">
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

        $("#prod_kind, #prod_family, #prod_group").on("change", () => { getData() });

        // 조회
        $("#btnSearch").on("click", () => { getData() });

        // 상세조회
        $("#tblMaster").on("dblclick", "tr", function() {
            let base_cd = $(this).find("input[name=base_cd]").val();
            callEditmodal("공통코드상세 등록", "M");
            getDataOne(base_cd);
        });

        // 납품완료
        $("#btnShipmentRegist").on("click", () => {

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
            addPopBaseCodeDetailRow();
        });

        $("#btnBaseCodeDetailRegistModify").on("click", () => {

            if(!parsleyIsValidate("dataForm")) return false;

            Swal.fire({
                title: '',
                text: "공통코드상세내역을 저장하시겠습니까?",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: '확인',
                cancelButtonText: '취소'
            }).then((result) => {
                if (result.isConfirmed) {
                    baseCodeDetailRegistModifyData();
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
        $("#btnPopRegist").show();
        $("#btnPopModify").hide();

        resetForm("dataForm");
        $("#tblPopBaseCodeDetailData tbody").empty();
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
            url: "/mes/base/code/baseList"
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
                $("#tblMaster").DataTable().clear();

                data.forEach((item, index) => {
                    let node = [];

                    let firstNode = "<div class='text-center'>" +
                                    "    <input type=\"hidden\" name=\"base_cd\" value=\"" + item.base_cd + "\">" +
                                         IsEmpty(item.base_cd) +
                                    "</div>";

                    node.push(firstNode);
                    node.push(IsEmpty(item.base_nm));
                    node.push(IsEmpty(item.base_indate));
                    node.push(IsEmpty(item.base_inuser_nm));
                    node.push(IsEmpty(item.base_update));

                    // 각 row node 추가
                    let row = $("#tblMaster").DataTable().row.add(node).node();
                    if(item.ship_state == "22") {
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

    function getDataOne(base_cd)
    {
        showWait('.dataModal');

        $.ajax({
            url: "/mes/base/code/baseOne/" + base_cd
            ,type: "get"
            ,dataType: "json"
            // ,data: JSON.stringify({})
        })
        .done(function (data)
        {
            setDataOne("pop_", data);
            $("#dataForm").find(".key").prop("disabled", true);

            getBaseCodeDetailData();
        })
        .always(function (data) {
            hideWait('.dataModal');
        })
        .fail(function (jqHXR, textStatus, errorThrown) {
            ajaxErrorAlert(jqHXR);
        });
    }

    function getBaseCodeDetailData()
    {
        showWait('.dataModal');

        $.ajax({
            url: "/mes/base/code/baseDetailList"
            ,type: "post"
            ,headers: {
                "Content-Type": "application/json"
                ,"X-HTTP-Method-Override": "POST"
            }
            ,dataType: "json"
            ,data: JSON.stringify({
                fact_cd: "${vmap.fact_cd}"
                ,base_cd: $("#pop_base_cd").val()
            })
        })
            .done(function (data)
            {
                $("#tblPopBaseCodeDetailData > tbody").empty();
                resultRowCnt = 0;

                data.forEach((item, index) => {
                    addPopBaseCodeDetailRow(item);
                });
            })
            .always(function (data) {
                hideWait('.dataModal');
            })
            .fail(function (jqHXR, textStatus, errorThrown) {
                ajaxErrorAlert(jqHXR);
            });
    }

    // let resultRowCnt = 0;
    function addPopBaseCodeDetailRow(data)
    {
        let template_html = $("#popBaseCodeDetailTemplete").html();
        let template = Handlebars.compile(template_html);
        let resultRowCnt = $("#tblPopBaseCodeDetailData > tbody > tr").length + 1;
        let templateData;

        if(IsNull(data))
        {
            templateData = {
                cnt : resultRowCnt
            };

            $("#tblPopBaseCodeDetailData > tbody").append(template(templateData));
        }
        else
        {
            templateData = {
                cnt : resultRowCnt
                ,...data
            };

            $("#tblPopBaseCodeDetailData > tbody").append(template(templateData));
        }
    }

    function baseCodeDetailRegistModifyData()
    {
        showWait('.dataModal');

        //. Data List
        let ary_base_detail_cd = [];
        let ary_base_detail_nm = [];

        $.each($("#tblPopBaseCodeDetailData > tbody > tr"), function(index, item)
        {
            ary_base_detail_cd.push($(item).find("input[name=pop_base_detail_cd]").val());
            ary_base_detail_nm.push($(item).find("input[name=pop_base_detail_nm]").val());
        });

        $.ajax({
            type: "post"
            ,url: "/mes/base/code/baseCodeDetailRegistModify"
            ,headers: {
                "Content-Type": "application/json"
                ,"X-HTTP-Method-Override": "POST"
            }
            ,dataType: "text"
            ,data: JSON.stringify({
                fact_cd: "${vmap.fact_cd}"
                ,base_cd: $("#pop_base_cd").val()
                ,ary_base_detail_cd: ary_base_detail_cd
                ,ary_base_detail_nm: ary_base_detail_nm
            })
        })
        .done(function (data) {
            hideWait('.dataModal');
            getDataOne($("#pop_base_cd").val());
        })
        .always(function (data) {

        })
        .fail(function (jqHXR, textStatus, errorThrown) {
            ajaxErrorAlert(jqHXR);
            hideWait('.dataModal');
        });
    }


    function baseCodeDetailDelete(cnt)
    {
        let base_detail_cd = $("#tblPopBaseCodeDetailData .list_tr" + cnt).find("[name=pop_base_detail_cd]").val();

        if(IsNull(base_detail_cd))
        {
            $("#tblPopBaseCodeDetailData .list_tr" + cnt).remove();
        }
        else
        {
            Swal.fire({
                title: '',
                text: "공통코드상세를 삭제하시겠습니까?",
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
                        ,url: "/mes/base/code/baseCodeDetailDelete"
                        ,headers: {
                            "Content-Type": "application/json"
                            ,"X-HTTP-Method-Override": "DELETE"
                        }
                        ,dataType: "text"
                        ,data: JSON.stringify({
                            base_detail_cd: base_detail_cd
                        })
                    })
                    .done(function (data) {
                        hideWait('.dataModal');
                        getDataOne($("#pop_base_cd").val());
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