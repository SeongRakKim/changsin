<%--
  Created by IntelliJ IDEA.
  User: outsourcing
  Date: 2022-02-09
  Time: 오후 10:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Disable tap highlight on IE -->
    <meta name="msapplication-tap-highlight" content="no">

    <title>CS</title>

    <!-- Custom fonts for this template-->
    <link href="/sbadmin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <%--        <script src="https://kit.fontawesome.com/1674c57749.js" crossorigin="anonymous"></script>--%>
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="/sbadmin/css/sb-admin-2.min.css" rel="stylesheet">

    <!-- SweetAlert2 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.9/dist/sweetalert2.min.css">

    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

    <link rel="stylesheet" type="text/css" href="/bamburgh/css/bamburgh.min.css">
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
    <link type="text/css" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/TableDnD/0.9.1/jquery.tablednd.js" integrity="sha256-d3rtug+Hg1GZPB7Y/yTcRixO/wlI78+2m08tosoRn7A=" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js" integrity="sha512-RNLkV3d+aLtfcpEyFG8jRbnWHxUqVZozacROI4J2F1sTaDqo1dPQYs01OMi1t1w9Y2FdbSCDSQ2ZVdAC8bzgAg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

    <link href="/plugin/datepicker/datepicker.css" rel="stylesheet">
    <link href="/plugin/datetimepicker/jquery.datetimepicker.css" rel="stylesheet">

    <%--        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>--%>
    <%--        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>--%>

</head>

<%--    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>--%>

<style>
    .bg-login-image2 {
        background: url("/img/mes_login_img.png");
        background-position: center;
        background-size: contain;
        background-repeat: no-repeat;
    }

    .login-main-form {
        margin: 200px 0 200px 0;
    }
</style>

<body id="page-top">

<!-- Page Wrapper -->
<div id="wrapper">
    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

        <!-- Main Content -->
        <div id="content">


<!-- Begin Page Content -->
<div class="container-fluid">
    <div class="container">

        <!-- Outer Row -->
        <div class="row justify-content-center login-main-form">

            <div class="col-xl-10 col-lg-12 col-md-9">

                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0">
                        <!-- Nested Row within Card Body -->
                        <div class="row">
                            <div class="col-lg-6 d-none d-lg-block bg-login-image2"></div>
                            <div class="col-lg-6">
                                <div class="p-5">
                                    <div class="text-center">
                                        <h1 class="h4 text-gray-900 mb-4">Manufacturing Execution System</h1>
                                    </div>
                                    <form id="loginForm" class="user" method="post" action="/auth/login-proc">
                                        <div class="form-group">
                                            <input type="text" class="form-control form-control-user"
                                                   id="id" aria-describedby="emailHelp"
                                                   placeholder="Id...">
                                        </div>
                                        <div class="form-group">
                                            <input type="password" class="form-control form-control-user"
                                                   id="password" placeholder="Password...">
                                        </div>
                                        <div class="form-group">
                                            <div class="custom-control custom-checkbox small">
                                                <input type="checkbox" class="custom-control-input" id="customCheck">
                                                <label class="custom-control-label" for="customCheck">아이디저장</label>
                                            </div>
                                        </div>
                                        <a href="#" onclick="submitForm();" class="btn btn-primary btn-user btn-block">
                                            Login
                                        </a>

<%--                                        <hr>--%>
<%--                                        <a href="index.html" class="btn btn-google btn-user btn-block">--%>
<%--                                            <i class="fab fa-google fa-fw"></i> Login with Google--%>
<%--                                        </a>--%>
<%--                                        <a href="index.html" class="btn btn-facebook btn-user btn-block">--%>
<%--                                            <i class="fab fa-facebook-f fa-fw"></i> Login with Facebook--%>
<%--                                        </a>--%>
                                    </form>
                                    <hr>
<%--                                    <div class="text-center">--%>
<%--                                        <a class="small" href="forgot-password.html">Forgot Password?</a>--%>
<%--                                    </div>--%>
<%--                                    <div class="text-center">--%>
<%--                                        <a class="small" href="register.html">Create an Account!</a>--%>
<%--                                    </div>--%>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </div>

    </div>

    <script>
        function submitForm() {

            // document.getElementById("loginForm").submit();

            var params = {
                'id' : $.trim($("#id").val())
                ,'password' : $("#password").val()
            }

            // $.ajax({
            //     type : 'POST'
            //     ,url : 'sendLogDataJSON.do'
            //     ,dataType : 'json'
            //     ,data : params
            //     ,success : function(result) {
            //         console.log("AAAAAAA");

                    $.ajax({
                        type : 'POST'
                        ,url : '/auth/login-proc'
                        ,dataType : 'json'
                        ,data : params
                        ,success : function(result) {
                            if(result.resultCode != "00"){
                                eAlert(result.resultMessage);
                            }
                            else{
                                location.href=result.targetUrl;
                            }
                        },
                        error: function(request, status, error) {

                        }
                    });
            //     },
            //     error: function(request, status, error) {
            //
            //     }
            // });
        }
    </script>

<%--<script>--%>

<%--    $(document).ready(() => {--%>
<%--        // DataTables setting--%>
<%--        setDatatable();--%>
<%--        getData();--%>
<%--        // initAutoCompelte("#pop_comp_cd");--%>

<%--        $("#comp_type, #comp_group").on("change", () => { getData() });--%>

<%--        // 조회--%>
<%--        $("#btnSearch").on("click", () => { getData() });--%>

<%--        // Add Data - Call Data Form--%>
<%--        $("#btnNew").on("click", () => {--%>
<%--            callEditmodal("거래처 추가", "R");--%>
<%--        });--%>

<%--        // 상세조회--%>
<%--        $("#tblMaster").on("dblclick", "tr", function() {--%>
<%--            let comp_cd = $(this).find("input[name=comp_cd]").val();--%>
<%--            callEditmodal("거래처 수정", "M");--%>
<%--            getDataOne(comp_cd);--%>
<%--        });--%>

<%--        $("#pop_comp_busin_num").on("keyup", function (event) {--%>
<%--            if($(this).length > 0) {--%>
<%--                $(this).val(idNumFormat($(this).val()));--%>
<%--            }--%>
<%--        });--%>

<%--        // 저장--%>
<%--        $("#btnPopRegist").on("click", () => {--%>

<%--            if(IsNotNull($(".invalid-feedback").text())) {--%>
<%--                eAlert("중복된 코드값이 존재합니다.");--%>
<%--                return;--%>
<%--            }--%>

<%--            if(!parsleyIsValidate("dataForm")) return false;--%>

<%--            Swal.fire({--%>
<%--                title: '',--%>
<%--                text: "거래처 정보를 저장하시겠습니까?",--%>
<%--                icon: 'warning',--%>
<%--                showCancelButton: true,--%>
<%--                confirmButtonColor: '#3085d6',--%>
<%--                cancelButtonColor: '#d33',--%>
<%--                confirmButtonText: '확인',--%>
<%--                cancelButtonText: '취소'--%>
<%--            }).then((result) => {--%>
<%--                if (result.isConfirmed) {--%>
<%--                    registModifyData();--%>
<%--                }--%>
<%--            });--%>

<%--        });--%>

<%--        // 데이터 삭제--%>
<%--        $("#btnDelete").on("click", () => {--%>

<%--            if($("input[name=listCheck]:checked").length === 0) {--%>
<%--                alert("삭제할 데이터를 선택하세요.");--%>
<%--                return false;--%>
<%--            }--%>

<%--            Swal.fire({--%>
<%--                title: '',--%>
<%--                text: "거래처 정보를 삭제하시겠습니까?",--%>
<%--                icon: 'warning',--%>
<%--                showCancelButton: true,--%>
<%--                confirmButtonColor: '#3085d6',--%>
<%--                cancelButtonColor: '#d33',--%>
<%--                confirmButtonText: '확인',--%>
<%--                cancelButtonText: '취소'--%>
<%--            }).then((result) => {--%>
<%--                if (result.isConfirmed) {--%>
<%--                    deleteData();--%>
<%--                }--%>
<%--            });--%>

<%--        });--%>

<%--        $("#pop_comp_cd").on("keyup", () => {--%>
<%--            if($("#pop_comp_cd").val().length > 3)--%>
<%--            {--%>
<%--                $.ajax({--%>
<%--                    type : 'get'--%>
<%--                    ,url: '/mes/base/company/compOverlap/' + $("#pop_comp_cd").val()--%>
<%--                    ,dataType : 'json'--%>
<%--                })--%>
<%--                    .done(function (data)--%>
<%--                    {--%>
<%--                        if(data) {--%>
<%--                            $("#pop_comp_cd").removeClass("is-valid");--%>
<%--                            $("#pop_comp_cd").addClass("is-invalid");--%>
<%--                            $(".invalid-feedback").text("중복된 거래처 코드입니다.");--%>
<%--                        }else {--%>
<%--                            $("#pop_comp_cd").removeClass("is-invalid");--%>
<%--                            $("#pop_comp_cd").addClass("is-valid");--%>
<%--                            $(".invalid-feedback").text("");--%>
<%--                        }--%>
<%--                    })--%>
<%--                    .always(function (data) {--%>

<%--                    });--%>
<%--            }--%>
<%--        });--%>
<%--    });--%>

<%--    function initAutoCompelte(el)--%>
<%--    {--%>
<%--        $(el).autocomplete({--%>
<%--            source : function(reuqest, response) {--%>
<%--                $.ajax({--%>
<%--                    type : 'get',--%>
<%--                    url: '/json',--%>
<%--                    dataType : 'json',--%>
<%--                    success : function(data) {--%>
<%--                        // 서버에서 json 데이터 response 후 목록 추가--%>
<%--                        response(--%>
<%--                            $.map(data, function(item) {--%>
<%--                                return {--%>
<%--                                    label : item + 'label',--%>
<%--                                    value : item,--%>
<%--                                    test : item + 'test'--%>
<%--                                }--%>
<%--                            })--%>
<%--                        );--%>
<%--                    }--%>
<%--                });--%>
<%--            },--%>
<%--            select : function(event, ui) {--%>
<%--                console.log(ui);--%>
<%--                console.log(ui.item.label);--%>
<%--                console.log(ui.item.value);--%>
<%--                console.log(ui.item.test);--%>
<%--            },--%>
<%--            focus : function(event, ui) {--%>
<%--                return false;--%>
<%--            },--%>
<%--            minLength : 1,--%>
<%--            autoFocus : true,--%>
<%--            classes : {--%>
<%--                'ui-autocomplete': 'highlight'--%>
<%--            },--%>
<%--            delay : 500,--%>
<%--            position : { my : 'right top', at : 'right bottom' },--%>
<%--            close : function(event) {--%>
<%--                console.log(event);--%>
<%--            }--%>
<%--        });--%>
<%--    }--%>

<%--    // set tblMaster Database--%>
<%--    function setDatatable()--%>
<%--    {--%>
<%--        var arguments = {--%>
<%--            tabldID: "tblMaster"--%>
<%--            ,ordering: true--%>
<%--            // ,responsive: true--%>
<%--            ,orderIdx: []--%>
<%--            ,orderGubn:	[]--%>
<%--            ,rowspan: ""--%>
<%--            ,lengthMenu: [15, 50, 100, 500, 1000]--%>
<%--            ,paging: true--%>
<%--            ,field: true--%>
<%--            ,info: true--%>
<%--            ,filter: true--%>
<%--            ,stateSave: true--%>
<%--            ,collapse: false--%>
<%--            ,scrollY: 570--%>
<%--            ,selected: true--%>
<%--            ,multiSelected: false--%>
<%--            ,columnDefs : [--%>
<%--                {--%>
<%--                    "targets": 'no-sort',--%>
<%--                    "orderable": false--%>
<%--                }--%>
<%--            ]--%>
<%--        };--%>

<%--        setDataTablesOption(arguments);--%>

<%--    }--%>

<%--    function callEditmodal(title, flag)--%>
<%--    {--%>
<%--        $("#form-modal-icon").removeAttr("class");--%>
<%--        $("#dataModal").modal("show");--%>
<%--        $("#form-modal-title").text(title);--%>
<%--        $("#form-modal-icon").addClass(flag === "R" ? "fas fa-paste" : "fas fa-edit");--%>
<%--        $("#btnPopRegist").show();--%>
<%--        $("#btnPopModify").hide();--%>

<%--        resetForm("dataForm");--%>
<%--    }--%>

<%--    function resetForm(formId)--%>
<%--    {--%>
<%--        $("#"+formId).find("input").val("");--%>
<%--        $("#"+formId).find("select").val("");--%>
<%--        $("#"+formId).find("input[name$='yn']").val("Y");--%>
<%--        $(".key").removeClass("is-valid").removeClass("is-invalid");--%>
<%--        $(".invalid-feedback").text("");--%>
<%--        $("#"+formId).find(":disabled").prop("disabled", false);--%>
<%--    }--%>

<%--    function getData()--%>
<%--    {--%>
<%--        showWait('.container-fluid');--%>

<%--        $.ajax({--%>
<%--            url: "/mes/base/company/compList"--%>
<%--            ,type: "post"--%>
<%--            ,headers: {--%>
<%--                "Content-Type": "application/json"--%>
<%--                ,"X-HTTP-Method-Override": "POST"--%>
<%--            }--%>
<%--            ,dataType: "json"--%>
<%--            ,data: JSON.stringify({--%>
<%--                fact_cd: "${vmap.fact_cd}"--%>
<%--                ,comp_type: $("#comp_type").val()--%>
<%--                ,comp_group: $("#comp_group").val()--%>
<%--                ,search_text: $("#search_text").val()--%>
<%--            })--%>
<%--        })--%>
<%--        .done(function (data)--%>
<%--        {--%>
<%--            $("#tblMaster").DataTable().clear();--%>

<%--            data.forEach((item, index) => {--%>
<%--                let node = [];--%>

<%--                let checkBoxNode = "<div class=\"custom-control custom-checkbox\">" +--%>
<%--                                   "    <input type=\"hidden\" name=\"comp_cd\" value=\"" + item.comp_cd + "\">" +--%>
<%--                                   "    <input type=\"checkbox\" class=\"custom-control-input\" id=\"listCheck_" + index + "\" name=\"listCheck\">" +--%>
<%--                                   "    <label class=\"custom-control-label\" for=\"listCheck_" + index + "\"></label>" +--%>
<%--                                   "</div>";--%>

<%--                node.push(checkBoxNode);--%>
<%--                node.push(IsEmpty(item.comp_cd));--%>
<%--                node.push(IsEmpty(item.comp_nm));--%>
<%--                node.push(IsEmpty(item.comp_type_nm));--%>
<%--                node.push(IsEmpty(item.comp_group_nm));--%>
<%--                node.push(IsEmpty(item.comp_busin_stat));--%>
<%--                node.push(IsEmpty(item.comp_busin_kind));--%>
<%--                node.push(IsEmpty(item.comp_tel));--%>
<%--                node.push(IsEmpty(item.comp_fax));--%>
<%--                node.push(IsEmpty(item.comp_email));--%>
<%--                node.push(IsEmpty(item.comp_busin_num));--%>
<%--                node.push(IsEmpty(item.comp_ceo));--%>

<%--                // 각 row node 추가--%>
<%--                $("#tblMaster").DataTable().row.add(node).node();--%>
<%--            });--%>

<%--            // datatables draw--%>
<%--            $("#tblMaster").DataTable().draw(false);--%>
<%--        })--%>
<%--        .always(function (data) {--%>
<%--            hideWait('.container-fluid');--%>
<%--        })--%>
<%--        .fail(function (jqHXR, textStatus, errorThrown) {--%>
<%--            ajaxErrorAlert(jqHXR);--%>
<%--        });--%>
<%--    }--%>

<%--    function getDataOne(comp_cd)--%>
<%--    {--%>
<%--        showWait('.dataModal');--%>

<%--        $.ajax({--%>
<%--            url: "/mes/base/company/compOne/" + comp_cd--%>
<%--            ,type: "get"--%>
<%--            ,dataType: "json"--%>
<%--            // ,data: JSON.stringify({})--%>
<%--        })--%>
<%--        .done(function (data)--%>
<%--        {--%>
<%--            setDataOne("pop_", data);--%>
<%--            $("#dataForm").find(".key").prop("disabled", true);--%>
<%--        })--%>
<%--        .always(function (data) {--%>
<%--            hideWait('.dataModal');--%>
<%--        })--%>
<%--        .fail(function (jqHXR, textStatus, errorThrown) {--%>
<%--            ajaxErrorAlert(jqHXR);--%>
<%--        });--%>
<%--    }--%>

<%--    // Add Data - ajax regist--%>
<%--    function registModifyData()--%>
<%--    {--%>
<%--        showWait('.dataModal');--%>

<%--        $.ajax({--%>
<%--            type: "post"--%>
<%--            ,url: "/mes/base/company/compRegistModify"--%>
<%--            ,headers: {--%>
<%--                "Content-Type": "application/json"--%>
<%--                ,"X-HTTP-Method-Override": "POST"--%>
<%--            }--%>
<%--            ,dataType: "text"--%>
<%--            ,data: JSON.stringify({--%>
<%--                fact_cd: "${vmap.fact_cd}"--%>
<%--                ,comp_cd: $("#pop_comp_cd").val()--%>
<%--                ,comp_nm: $("#pop_comp_nm").val()--%>
<%--                ,comp_busin_num: $("#pop_comp_busin_num").val()--%>
<%--                ,comp_type: $("#pop_comp_type").val()--%>
<%--                ,comp_group: $("#pop_comp_group").val()--%>
<%--                ,comp_ceo: $("#pop_comp_ceo").val()--%>
<%--                ,comp_tel: $("#pop_comp_tel").val()--%>
<%--                ,comp_fax: $("#pop_comp_fax").val()--%>
<%--                ,comp_email: $("#pop_comp_email").val()--%>
<%--                ,comp_mana: $("#pop_comp_mana").val()--%>
<%--                ,comp_mana_tel: $("#pop_comp_mana_tel").val()--%>
<%--                ,comp_busin_stat: $("#pop_comp_busin_stat").val()--%>
<%--                ,comp_busin_kind: $("#pop_comp_busin_kind").val()--%>
<%--                ,comp_address: $("#pop_comp_address").val()--%>
<%--                ,comp_notice: $("#pop_comp_notice").val()--%>
<%--            })--%>
<%--        })--%>
<%--        .done(function (data) {--%>
<%--            hideWait('.dataModal');--%>
<%--            $("#dataModal").modal("hide");--%>
<%--            getData();--%>
<%--        })--%>
<%--        .always(function (data) {--%>

<%--        })--%>
<%--        .fail(function (jqHXR, textStatus, errorThrown) {--%>
<%--            ajaxErrorAlert(jqHXR);--%>
<%--            hideWait('.dataModal');--%>
<%--        });--%>
<%--    }--%>

<%--    function deleteData()--%>
<%--    {--%>
<%--        showWait('.container-fluid');--%>

<%--        let deleteItems = [];--%>
<%--        $.each($("input[name=listCheck]:checked"), function(item, index) {--%>
<%--            deleteItems.push($(this).closest("tr").find("input[name=comp_cd]").val());--%>
<%--        });--%>

<%--        $.ajax({--%>
<%--            type: "delete"--%>
<%--            ,url: "/mes/base/company/compPackDelete"--%>
<%--            ,headers: {--%>
<%--                "Content-Type": "application/json"--%>
<%--                ,"X-HTTP-Method-Override": "DELETE"--%>
<%--            }--%>
<%--            ,dataType: "text"--%>
<%--            ,data: JSON.stringify({--%>
<%--                deleteItems: deleteItems--%>
<%--            })--%>
<%--        })--%>
<%--        .done(function (data) {--%>
<%--            getData();--%>
<%--            hideWait('.container-fluid');--%>
<%--        })--%>
<%--        .always(function (data) {--%>

<%--        })--%>
<%--        .fail(function (jqHXR, textStatus, errorThrown) {--%>
<%--            ajaxErrorAlert(jqHXR);--%>
<%--        });--%>

<%--    }--%>

<%--    function idNumFormat(idNum)--%>
<%--    {--%>
<%--        idNum = idNum.replace(/[^0-9]/g, ''); // 숫자만남고 다지움--%>
<%--        idNum = idNum.substring(0,10); // 10자리남기고 다지움--%>

<%--        if( idNum.length >= 5 ) // 123-45---%>
<%--        {--%>
<%--            idNum = idNum.substring(0,3) + '-' + idNum.substring(3,5) + '-' + idNum.substring(5);--%>
<%--        }--%>
<%--        else if( idNum.length >= 3 ) // 123---%>
<%--        {--%>
<%--            idNum = idNum.substring(0,3) + '-' + idNum.substring(3);--%>
<%--        }--%>

<%--        return idNum;--%>
<%--    }--%>


<%--</script>--%>

<%@ include file="/WEB-INF/include/footer.jspf" %>