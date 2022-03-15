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
                    <th>거래처구분</th>
                    <td>
                        <select id="comp_type" name="comp_type" class="custom-select w-100" required="">
                            <option value="">거래처구분선택</option>
                            <c:forEach var="item" items="${vmap.compTypeList}" varStatus="status">
                                <option value="${item.base_detail_cd}">${item.base_detail_nm}</option>
                            </c:forEach>
                        </select>
                    </td>
                    <th>거래처분류</th>
                    <td>
                        <select id="comp_group" name="comp_group" class="custom-select w-100" required="">
                            <option value="">거래처분류선택</option>
                            <c:forEach var="item" items="${vmap.compGroupList}" varStatus="status">
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
                <i class="fas fa-home"></i> <i class="fas fa-chevron-right"></i> 기준정보 <i class="fas fa-chevron-right"></i> 거래처정보
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
                                        <th>거래처코드</th>
                                        <th>거래처명</th>
                                        <th>구분</th>
                                        <th>분류</th>
                                        <th>업태</th>
                                        <th>종목</th>
                                        <th>전화</th>
                                        <th>FAX</th>
                                        <th>MAIL</th>
                                        <th>사업자등록번호</th>
                                        <th>대표자명</th>
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
                                <th>거래처코드</th>
                                <td>
                                    <input type="text" id="pop_comp_cd" name="pop_comp_cd" class="form-control key" placeholder="거래처코드 / 미입력 시 자동생성" title="거래처코드"
                                           />
                                    <div class="invalid-feedback"></div>
                                </td>
                                <th>거래처명<span class="red"> (필수)</span></th>
                                <td>
                                    <input type="text" id="pop_comp_nm" name="pop_comp_nm" class="form-control" placeholder="거래처명" title="거래처명"
                                           required />
                                </td>
                                <th>사업자등록번호</th>
                                <td>
                                    <input type="text" id="pop_comp_busin_num" name="pop_comp_busin_num" class="form-control rudder"
                                           placeholder="사업자등록번호" title="사업자등록번호" />
                                </td>
                            </tr>
                            <tr>
                                <th>거래처구분<span class="red"> (필수)</span></th>
                                <td>
                                    <select id="pop_comp_type" name="pop_comp_type" class="custom-select w-100" title="거래처구분" required>
                                        <option value="">거래처구분선택</option>
                                        <c:forEach var="item" items="${vmap.compTypeList}" varStatus="status">
                                            <option value="${item.base_detail_cd}">${item.base_detail_nm}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                                <th>거래처분류</th>
                                <td>
                                    <select id="pop_comp_group" name="pop_comp_group" class="custom-select w-100"  title="거래처분류">
                                        <option value="">거래처분류선택</option>
                                        <c:forEach var="item" items="${vmap.compGroupList}" varStatus="status">
                                            <option value="${item.base_detail_cd}">${item.base_detail_nm}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                                <th>대표자명</th>
                                <td>
                                    <input type="text" id="pop_comp_ceo" name="pop_comp_ceo" class="form-control" placeholder="대표자명" title="대표자명" />
                                </td>
                            </tr>
                            <tr>
                                <th>대표전화</th>
                                <td>
                                    <input type="text" id="pop_comp_tel" name="pop_comp_tel" class="form-control" placeholder="대표전화" title="대표전화" />
                                </td>
                                <th>FAX</th>
                                <td>
                                    <input type="text" id="pop_comp_fax" name="pop_comp_fax" class="form-control" placeholder="FAX" title="FAX" />
                                </td>
                                <th>E-MAIL</th>
                                <td>
                                    <input type="text" id="pop_comp_email" name="pop_comp_email" class="form-control" placeholder="E-MAIL" title="E-MAIL" />
                                </td>
                            </tr>
                            <tr>
                                <th>담당자</th>
                                <td>
                                    <input type="text" id="pop_comp_mana" name="pop_comp_mana" class="form-control" placeholder="담당자" title="담당자" />
                                </td>
                                <th>담당자연락처</th>
                                <td>
                                    <input type="text" id="pop_comp_mana_tel" name="pop_comp_mana_tel" class="form-control" placeholder="담당자연락처" title="담당자연락처" />
                                </td>
                                <th>업태</th>
                                <td>
                                    <input type="text" id="pop_comp_busin_stat" name="pop_comp_busin_stat" class="form-control" placeholder="업태" title="업태" />
                                </td>
                            </tr>
                            <tr>
                                <th>종목</th>
                                <td>
                                    <input type="text" id="pop_comp_busin_kind" name="pop_comp_busin_kind" class="form-control" placeholder="종목" title="종목" />
                                </td>
                                <th>주소</th>
                                <td colspan="3">
                                    <input type="text" id="pop_comp_address" name="pop_comp_address" class="form-control" placeholder="주소" title="주소" />
                                </td>
                            </tr>
                            <tr>
                                <th>비고</th>
                                <td colspan="5">
                                    <input type="text" id="pop_comp_notice" name="pop_comp_notice" class="form-control" placeholder="비고" title="비고" />
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
        // initAutoCompelte("#pop_comp_cd");

        $("#comp_type, #comp_group").on("change", () => { getData() });

        // 조회
        $("#btnSearch").on("click", () => { getData() });

        // Add Data - Call Data Form
        $("#btnNew").on("click", () => {
            callEditmodal("거래처 추가", "R");
        });

        // 상세조회
        $("#tblMaster").on("dblclick", "tr", function() {
            let comp_cd = $(this).find("input[name=comp_cd]").val();
            callEditmodal("거래처 수정", "M");
            getDataOne(comp_cd);
        });

        $("#pop_comp_busin_num").on("keyup", function (event) {
            if($(this).length > 0) {
                $(this).val(idNumFormat($(this).val()));
            }
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
                text: "거래처 정보를 저장하시겠습니까?",
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
                text: "거래처 정보를 삭제하시겠습니까?",
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

        $("#pop_comp_cd").on("keyup", () => {
            if($("#pop_comp_cd").val().length > 3)
            {
                $.ajax({
                    type : 'get'
                    ,url: '/mes/base/company/compOverlap/' + $("#pop_comp_cd").val()
                    ,dataType : 'json'
                })
                    .done(function (data)
                    {
                        if(data) {
                            $("#pop_comp_cd").removeClass("is-valid");
                            $("#pop_comp_cd").addClass("is-invalid");
                            $(".invalid-feedback").text("중복된 거래처 코드입니다.");
                        }else {
                            $("#pop_comp_cd").removeClass("is-invalid");
                            $("#pop_comp_cd").addClass("is-valid");
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
            source : function(reuqest, response) {
                $.ajax({
                    type : 'get',
                    url: '/json',
                    dataType : 'json',
                    success : function(data) {
                        // 서버에서 json 데이터 response 후 목록 추가
                        response(
                            $.map(data, function(item) {
                                return {
                                    label : item + 'label',
                                    value : item,
                                    test : item + 'test'
                                }
                            })
                        );
                    }
                });
            },
            select : function(event, ui) {
                console.log(ui);
                console.log(ui.item.label);
                console.log(ui.item.value);
                console.log(ui.item.test);
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
            url: "/mes/base/company/compList"
            ,type: "post"
            ,headers: {
                "Content-Type": "application/json"
                ,"X-HTTP-Method-Override": "POST"
            }
            ,dataType: "json"
            ,data: JSON.stringify({
                fact_cd: "${vmap.fact_cd}"
                ,comp_type: $("#comp_type").val()
                ,comp_group: $("#comp_group").val()
                ,search_text: $("#search_text").val()
            })
        })
        .done(function (data)
        {
            $("#tblMaster").DataTable().clear();

            data.forEach((item, index) => {
                let node = [];

                let checkBoxNode = "<div class=\"custom-control custom-checkbox\">" +
                                   "    <input type=\"hidden\" name=\"comp_cd\" value=\"" + item.comp_cd + "\">" +
                                   "    <input type=\"checkbox\" class=\"custom-control-input\" id=\"listCheck_" + index + "\" name=\"listCheck\">" +
                                   "    <label class=\"custom-control-label\" for=\"listCheck_" + index + "\"></label>" +
                                   "</div>";

                node.push(checkBoxNode);
                node.push(IsEmpty(item.comp_cd));
                node.push(IsEmpty(item.comp_nm));
                node.push(IsEmpty(item.comp_type_nm));
                node.push(IsEmpty(item.comp_group_nm));
                node.push(IsEmpty(item.comp_busin_stat));
                node.push(IsEmpty(item.comp_busin_kind));
                node.push(IsEmpty(item.comp_tel));
                node.push(IsEmpty(item.comp_fax));
                node.push(IsEmpty(item.comp_email));
                node.push(IsEmpty(item.comp_busin_num));
                node.push(IsEmpty(item.comp_ceo));

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

    function getDataOne(comp_cd)
    {
        showWait('.dataModal');

        $.ajax({
            url: "/mes/base/company/compOne/" + comp_cd
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
            ,url: "/mes/base/company/compRegistModify"
            ,headers: {
                "Content-Type": "application/json"
                ,"X-HTTP-Method-Override": "POST"
            }
            ,dataType: "text"
            ,data: JSON.stringify({
                fact_cd: "${vmap.fact_cd}"
                ,comp_cd: $("#pop_comp_cd").val()
                ,comp_nm: $("#pop_comp_nm").val()
                ,comp_busin_num: $("#pop_comp_busin_num").val()
                ,comp_type: $("#pop_comp_type").val()
                ,comp_group: $("#pop_comp_group").val()
                ,comp_ceo: $("#pop_comp_ceo").val()
                ,comp_tel: $("#pop_comp_tel").val()
                ,comp_fax: $("#pop_comp_fax").val()
                ,comp_email: $("#pop_comp_email").val()
                ,comp_mana: $("#pop_comp_mana").val()
                ,comp_mana_tel: $("#pop_comp_mana_tel").val()
                ,comp_busin_stat: $("#pop_comp_busin_stat").val()
                ,comp_busin_kind: $("#pop_comp_busin_kind").val()
                ,comp_address: $("#pop_comp_address").val()
                ,comp_notice: $("#pop_comp_notice").val()
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
            deleteItems.push($(this).closest("tr").find("input[name=comp_cd]").val());
        });

        $.ajax({
            type: "delete"
            ,url: "/mes/base/company/compPackDelete"
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


</script>

<%@ include file="/WEB-INF/include/footer.jspf" %>