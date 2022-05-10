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
                    <th>부서</th>
                    <td>
                        <select id="dept_cd" name="dept_cd" class="custom-select w-100" required="">
                            <option value="">부서선택</option>
                            <c:forEach var="item" items="${vmap.deptList}" varStatus="status">
                                <option value="${item.dept_cd}">${item.dept_nm}</option>
                            </c:forEach>
                        </select>
                    </td>
                    <th>직급</th>
                    <td>
                        <select id="grade_cd" name="grade_cd" class="custom-select w-100" required="">
                            <option value="">직급선택</option>
                            <c:forEach var="item" items="${vmap.gradeList}" varStatus="status">
                                <option value="${item.grade_cd}">${item.grade_nm}</option>
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
                <i class="fas fa-home"></i> <i class="fas fa-arrow-circle-right"></i> 기준정보 <i class="fas fa-arrow-circle-right"></i> 사용자정보
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
                                        <th>사용자코드</th>
                                        <th>사용자명</th>
                                        <th>부서</th>
                                        <th>직급</th>
                                        <th>주소</th>
                                        <th>휴대폰번호</th>
                                        <th>메일</th>
                                        <th>입사일</th>
                                        <th>퇴사일</th>
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
                                <th>사용자코드<span class="red"> (필수)</span></th>
                                <td>
                                    <input type="text" id="pop_u_cd" name="pop_u_cd" class="form-control key" placeholder="사용자코드.." title="사용자코드"
                                           required />
                                    <div class="invalid-feedback"></div>
                                </td>
                                <th>사용자명<span class="red"> (필수)</span></th>
                                <td>
                                    <input type="text" id="pop_u_nm" name="pop_u_nm" class="form-control" placeholder="사용자명" title="사용자명"
                                           required />
                                </td>
                                <th>비밀번호<span class="red"> (필수)</span></th>
                                <td>
                                    <input type="password" id="pop_u_pw" name="pop_u_pw" class="form-control rudder" placeholder="비밀번호" title="비밀번호"
                                           />
                                </td>
                            </tr>
                            <tr>
                                <th>부서</th>
                                <td>
                                    <select id="pop_dept_cd" name="pop_dept_cd" class="custom-select w-100" >
                                        <option value="">부서선택</option>
                                        <c:forEach var="item" items="${vmap.deptList}" varStatus="status">
                                            <option value="${item.dept_cd}">${item.dept_nm}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                                <th>직급</th>
                                <td>
                                    <select id="pop_grade_cd" name="pop_grade_cd" class="custom-select w-100" >
                                        <option value="">직급선택</option>
                                        <c:forEach var="item" items="${vmap.gradeList}" varStatus="status">
                                            <option value="${item.grade_cd}">${item.grade_nm}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                                <th>휴대폰번호</th>
                                <td>
                                    <input type="text" id="pop_u_tel" name="pop_u_tel" class="form-control" placeholder="휴대폰번호" title="휴대폰번호" />
                                </td>
                            </tr>
                            <tr>
                                <th>E-MAIL</th>
                                <td>
                                    <input type="text" id="pop_u_mail" name="pop_u_mail" class="form-control" placeholder="E-MAIL" title="E-MAIL" />
                                </td>
                                <th>입사일 <span class="red"> (필수)</span></th>
                                <td>
                                    <div class="input-group input-group-seamless">
                                        <input id="pop_u_indt" name="pop_u_indt" class="form-control datepicker" title="입사일"
                                               placeholder="입사일" type="text" required />
                                        <div class="input-group-append">
                                            <span class="input-group-text"><i class="fas fa-calendar"></i></span>
                                        </div>
                                    </div>
                                </td>
                                <th>퇴사일</th>
                                <td>
                                    <div class="input-group input-group-seamless">
                                        <input id="pop_u_outdt" name="pop_u_outdt" class="form-control datepicker" title="퇴사일"
                                               placeholder="퇴사일" type="text" />
                                        <div class="input-group-append">
                                            <span class="input-group-text"><i class="fas fa-calendar"></i></span>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>주소</th>
                                <td colspan="5">
                                    <input type="text" id="pop_u_addr" name="pop_u_addr" class="form-control" placeholder="주소" title="주소" />
                                </td>
                            </tr>
                            <tr>
                                <th>비고</th>
                                <td colspan="5">
                                    <input type="text" id="pop_u_notice" name="pop_u_notice" class="form-control" placeholder="비고" title="비고" />
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
        // initAutoCompelte("#pop_u_cd");

        $("#dept_cd, #grade_cd").on("change", () => { getData() });

        // 조회
        $("#btnSearch").on("click", () => { getData() });

        // Add Data - Call Data Form
        $("#btnNew").on("click", () => {
            callEditmodal("사용자 추가", "R");
        });

        // 상세조회
        $("#tblMaster").on("dblclick", "tr", function() {
            let u_cd = $(this).find("input[name=u_cd]").val();
            callEditmodal("사용자 수정", "M");
            getDataOne(u_cd);
        });

        // 저장
        $("#btnPopRegist").on("click", () => {

            if(IsNotNull($(".invalid-feedback").text())) {
                eAlert("중복된 코드값이 존재합니다.");
                return;
            }

            var password = $("#pop_u_pw").val();

            if($("#modal_state").val() === "R")
            {
                if(IsNull(password)) {
                    eAlert("비밀번호는 필수입력 사항입니다.");
                    return;
                }

                if (!strCheck(password, "pwd")) {
                    eAlert("비밀번호는 영문/숫자/특수문자를 포함하여 8~16자리로 입력해야 합니다.");
                    return;
                }
            }else if($("#modal_state").val() != "R" && IsNotNull(password))
            {
                if (!strCheck(password, "pwd")) {
                    eAlert("비밀번호는 영문/숫자/특수문자를 포함하여 8~16자리로 입력해야 합니다.");
                    return;
                }
            }

            if(!parsleyIsValidate("dataForm")) return false;

            Swal.fire({
                title: '',
                text: "사용자 정보를 저장하시겠습니까?",
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
                text: "사용자 정보를 삭제하시겠습니까?",
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

        $("#pop_u_cd").on("keyup", () => {
            if($("#pop_u_cd").val().length > 3)
            {
                $.ajax({
                    type : 'get'
                    ,url: '/mes/base/user/userOverlap/' + $("#pop_u_cd").val()
                    ,dataType : 'json'
                })
                    .done(function (data)
                    {
                        if(data) {
                            $("#pop_u_cd").removeClass("is-valid");
                            $("#pop_u_cd").addClass("is-invalid");
                            $(".invalid-feedback").text("중복된 사용자 코드입니다.");
                        }else {
                            $("#pop_u_cd").removeClass("is-invalid");
                            $("#pop_u_cd").addClass("is-valid");
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
            url: "/mes/base/user/userList"
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
                                   "    <input type=\"hidden\" name=\"u_cd\" value=\"" + item.u_cd + "\">" +
                                   "    <input type=\"checkbox\" class=\"custom-control-input\" id=\"listCheck_" + index + "\" name=\"listCheck\">" +
                                   "    <label class=\"custom-control-label\" for=\"listCheck_" + index + "\"></label>" +
                                   "</div>";

                node.push(checkBoxNode);
                node.push(IsEmpty(item.u_cd));
                node.push(IsEmpty(item.u_nm));
                node.push(IsEmpty(item.dept_nm));
                node.push(IsEmpty(item.grade_nm));
                node.push(IsEmpty(item.u_addr));
                node.push(IsEmpty(item.u_tel));
                node.push(IsEmpty(item.u_mail));
                node.push(IsEmpty(item.u_indt));
                node.push(IsEmpty(item.u_outdt));

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

    function getDataOne(u_cd)
    {
        showWait('.dataModal');

        $.ajax({
            url: "/mes/base/user/userOne/" + u_cd
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
            ,url: "/mes/base/user/userRegistModify"
            ,headers: {
                "Content-Type": "application/json"
                ,"X-HTTP-Method-Override": "POST"
            }
            ,dataType: "text"
            ,data: JSON.stringify({
                fact_cd: "${vmap.fact_cd}"
                ,u_cd: $("#pop_u_cd").val()
                ,u_nm: $("#pop_u_nm").val()
                ,u_pw: $("#pop_u_pw").val()
                ,dept_cd: $("#pop_dept_cd").val()
                ,grade_cd: $("#pop_grade_cd").val()
                ,u_tel: $("#pop_u_tel").val()
                ,u_mail: $("#pop_u_mail").val()
                ,u_indt: $("#pop_u_indt").val()
                ,u_outdt: $("#pop_u_outdt").val()
                ,u_addr: $("#pop_u_addr").val()
                ,u_notice: $("#pop_u_notice").val()
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
            deleteItems.push($(this).closest("tr").find("input[name=u_cd]").val());
        });

        $.ajax({
            type: "delete"
            ,url: "/mes/base/user/userPackDelete"
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