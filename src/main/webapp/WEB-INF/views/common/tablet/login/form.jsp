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

    .bg-main-logo {
        background: url("/img/changsin_logo.png");
        background-position: center;
        background-size: contain;
        background-repeat: no-repeat;
        width: 10vw;
        height: 10vh;
    }

    .login-main-form {
        margin: 3vh 0 3vh 0;
        height: 80vh;
    }

    .table-title {
        display: flex;
        flex-direction: row;
        flex-wrap: nowrap;
        justify-content: center;
        align-items: center;
    }

    .tablet-form-select {
        width: 50vw!important;
        margin-top: 5vh;
        height: 10vh;
        font-size: 2.5em;
    }

    .select-group {
        display: flex;
        align-items: center;
        /*align-content: center;*/
        justify-content: center;
    }
</style>

<body id="page-top">

<!-- Page Wrapper -->
<div id="wrapper">
    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

        <!-- Main Content -->
        <div id="content" >


<!-- Begin Page Content -->
<div class="container-fluid">
    <div class="container">

        <!-- Outer Row -->
        <div class="row justify-content-center login-main-form" style="background-color: #2a5298">
            <div class="col-xl-10 col-lg-12 col-md-9">
                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0">
                        <!-- Nested Row within Card Body -->
                        <div class="row">
                            <div class="col-lg-12" style="height: 65vh; margin-top: 0px;">
                                <div class="p-5">
                                    <div class="text-center table-title">
                                        <div class="sidebar-brand-icon bg-main-logo"></div>
                                        <div>
                                            <h1 class="h4 text-gray-900 mb-4" style="font-size: 4em; font-weight: 500;">(유) 창신</h1>
                                        </div>
                                    </div>
                                    <form id="loginForm" class="user" method="post" action="/auth/login-proc">
                                        <div class="form-group select-group">
                                            <select id="id" name="id" class="custom-select w-100 tablet-form-select" onchange="setPassword(this);">
                                                <option value="">사용자선택</option>
                                                <c:forEach var="item" items="${vmap.userList}" varStatus="status">
                                                    <option value="${item.u_cd}" data-pw="${item.u_pw}">${item.u_nm}</option>
                                                </c:forEach>
                                            </select>
                                            <input type="hidden" id="password" name="password" value="" />
                                        </div>
                                        <a href="#" onclick="submitForm();" style="font-size: 3em; margin-top: 5vh;" class="btn btn-primary btn-user btn-block">
                                            로그인
                                        </a>
                                    </form>
                                    <hr>
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
                <%--if ("${sessionScope.isLogOut}" === "Y") sendLogApi();--%>
            });
        })();

        /*function sendLogApi()
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
        }*/

        function setPassword(obj) {
            $("#password").val($(obj).find("option:selected").data("pw"));
        }

        function submitForm() {

            // document.getElementById("loginForm").submit();

            var params = {
                'id' : $.trim($("#id").val())
                ,'password' : $("#password").val()
            }

            $.ajax({
                type : 'POST'
                ,url : '/tablet/auth/login-proc'
                ,dataType : 'json'
                ,data : params
                ,success : function(result) {
                    console.log('PM 6:25', '232', result);
                    if(result.resultCode != "00"){
                        eAlert(result.resultMessage);
                    }
                    else{
                        console.log('PM 5:54', '231', result.targetUrl);
                        // location.href=result.targetUrl;
                    }
                },
                error: function(request, status, error) {

                }
            });
        }
    </script>

<%--<%@ include file="/WEB-INF/include/footer.jspf" %>--%>