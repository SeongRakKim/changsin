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

        (function()
        {
            $(function()
            {
                if ("${sessionScope.isLogOut}" === "Y") {
                    sendLogApi();
                    sendLogApi2();
                }
            });
        })();

        function sendLogApi()
        {
            let TIME_ZONE = 9 * 60 * 60 * 1000; // 9시간
            let d = new Date();
            let date = new Date(d.getTime() + TIME_ZONE).toISOString().split('T')[0];
            let time = d.toTimeString().split(' ')[0];
            let dateTime = date + " " + time + ".000";
            console.log('오후 6:07', 'LineNumber : 131', dateTime);

            let logData = {
                crtfcKey: "$5$API$oSxSirazOfeKdU16pm/tNPbU3Xrr74Jkwyk.9Rl.44C",
                logDt: dateTime,
                useSe: "종료",
                sysUser: "CHANGSHIN",
                conectIp: "121.178.205.94",
                dataUsgqty: "0"
            };

            $.ajax({
                type : "POST",
                url : "https://log.smart-factory.kr/apisvc/sendLogData.json",
                cache : false,
                timeout : 360000,
                data : logData,
                dataType : "json",
                // contentType : "application/x-www-form-urlencoded; charset=utf-8",
                beforeSend : function() {
                },
                success : function(data, textStatus, jqXHR) {
                    var result = data.result;
                    console.log(result);  // <-- 전송 결과 확인
                },
                error : function(jqXHR, textStatus, errorThrown) {
                },
                complete : function() {
                }
            });
        }

        function sendLogApi2()
        {
            let TIME_ZONE = 9 * 60 * 60 * 1000; // 9시간
            let d = new Date();
            let date = new Date(d.getTime() + TIME_ZONE).toISOString().split('T')[0];
            let time = d.toTimeString().split(' ')[0];
            let dateTime = date + " " + time + ".000";
            console.log('오후 6:07', 'LineNumber : 131', dateTime);

            let logData = {
                crtfcKey: "$5$API$VjQw5ZNkkPD.itxtOGlIR2HxSAA0tI1EUceTrLh7DtC",
                logDt: dateTime,
                useSe: "종료",
                sysUser: "CHANGSHIN",
                conectIp: "121.178.205.94",
                dataUsgqty: "0"
            };

            $.ajax({
                type : "POST",
                url : "https://log.smart-factory.kr/apisvc/sendLogData.json",
                cache : false,
                timeout : 360000,
                data : logData,
                dataType : "json",
                // contentType : "application/x-www-form-urlencoded; charset=utf-8",
                beforeSend : function() {
                },
                success : function(data, textStatus, jqXHR) {
                    var result = data.result;
                    console.log(result);  // <-- 전송 결과 확인
                },
                error : function(jqXHR, textStatus, errorThrown) {
                },
                complete : function() {
                }
            });
        }

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

<%@ include file="/WEB-INF/include/footer.jspf" %>