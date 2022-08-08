<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="/WEB-INF/include/did-header.jspf" %>

<style>
    .sidebar .sidebar-brand-wrapper {
        height: 100px !important;
        background-color: #f6c634;
    }

    .navbar {
        height: 100px !important;
    }

    .nav .nav-item {
        height: 250px !important;
    }

    .nav .nav-item .nav-link {
        height: 250px !important;
    }

    .sidebar .nav .nav-item .nav-link .menu-title {
        font-size: 1.9375rem !important;
        font-weight: bold;
    }

    .sidebar .nav .nav-item .menu-icon {
        width: 131px !important;
        height: 60px !important;
    }

    .sidebar .nav .nav-item .menu-icon i {
        font-size: 2rem;
    }

    .main-panel {
        padding-top: 100px !important;
    }

    .table > tbody > tr > td {
        color: whitesmoke !important;
        font-size: 2em !important;
    }

    .table > thead > tr > th {
        font-size: 2em !important;
    }

    .tb_th {
        background-color: #8457d5;
        height: 140px !important;
        font-size: 1.5em !important;
        text-align: center !important;
    }

    .tb_td {
        text-align: center !important;
    }

    .brand-logo {
        background: url("/img/changsin_logo.png");
        background-position: center;
        background-size: contain;
        background-repeat: no-repeat;
        width: 100%;
        height: 10vh;
    }

</style>

<script>

    let noticeSize;
    let offset;

    $(document).ready(() => {

        getTimeStamp();
        getData();

        setInterval(() => getTimeStamp(), 1000);
        setInterval(() => getData(), 3000);
        setTimeout(() => nextPage(), 300000);

        setTimeout(() => $(".nav-link:eq(0)").closest("li").removeClass("active"), 10);
        setTimeout(() => $(".nav-link:eq(1)").closest("li").removeClass("active"), 10);
    });


    function nextPage() {
        location.href = "/did/notice/list";
    }

    function getData()
    {
        $.ajax({
            url: "/did/equipment/equipmentInterfaceData"
            ,type: "post"
            ,headers: {
                "Content-Type": "application/json"
                ,"X-HTTP-Method-Override": "POST"
            }
            ,dataType: "json"
            ,data: JSON.stringify({
                offset: offset
            })
        })
        .done(function (data)
        {
            data.forEach((item, index) => {

                let tableId = "#" + item.equ_cd;
                let titleId = "#" + item.equ_cd + "_title";

                $(titleId).text(item.equ_nm);

                $(tableId).find(".equ_if_qty").text(item.equ_if_qty.comma('3'));
                $(tableId).find(".equ_if_inoff").text((item.equ_if_inoff === "Y" ? "O" : "X"));
                $(tableId).find(".equ_if_stdt").html(item.equ_if_st_date + "</br>" + item.equ_if_st_time);
                $(tableId).find(".equ_if_eddt").html(item.equ_if_ed_date + "</br>" + item.equ_if_ed_time);
            });
        })
        .always(function (data) {

        })
        .fail(function (jqHXR, textStatus, errorThrown) {
            ajaxErrorAlert(jqHXR);
        });
    }

    function getClock(){
        const date = new Date()
        const hour = String(date.getHours()).padStart(2,"0");
        const minutes = String(date.getMinutes()).padStart(2,"0");
        const second = String(date.getSeconds()).padStart(2,"0");//number이기 때문에 padStart 붙일 수 없음. String 변환해주어야한다.
        return hour + ":" + minutes + ":" + second;
    }

    function getTimeStamp() {
        var d = new Date();

        var s =
            leadingZeros(d.getFullYear(), 4) + '-' +
            leadingZeros(d.getMonth() + 1, 2) + '-' +
            leadingZeros(d.getDate(), 2);

        $("#clock").text(s + " " + getClock());
    }

    function leadingZeros(n, digits) {
        var zero = '';
        n = n.toString();

        if (n.length < digits) {
            for (i = 0; i < digits - n.length; i++)
                zero += '0';
        }

        return zero + n;
    }

</script>

<div class="container-scroller">
    <!-- partial:partials/_sidebar.html -->
    <nav class="sidebar sidebar-offcanvas" id="sidebar">
        <div class="sidebar-brand-wrapper d-none d-lg-flex align-items-center justify-content-center fixed-top" style="text-align: center;">
            <div class="brand-logo"></div>
        </div>
        <ul class="nav" style="margin-top: 100px;">
            <li class="nav-item menu-items">
               <a class="nav-link" href="/did/notice/list">
                   <span class="menu-icon">
                       <i class="mdi mdi mdi-clipboard-text"></i>
                   </span>
                   <span class="menu-title">공지사항</span>
               </a>
            </li>
            <li class="nav-item menu-items">
               <a class="nav-link" href="/did/production/list" >
                   <span class="menu-icon">
                       <i class="mdi mdi mdi-brightness-5"></i>
                   </span>
                   <span class="menu-title">생산현황</span>
               </a>
            </li>
            <li class="nav-item menu-items">
               <a class="nav-link active" href="/did/equipment/list" >
                   <span class="menu-icon">
                       <i class="mdi mdi mdi mdi-vector-combine"></i>
                   </span>
                   <span class="menu-title">가동현황</span>
               </a>
            </li>
        </ul>
    </nav>
    <!-- partial -->
    <div class="container-fluid page-body-wrapper">
        <!-- partial:partials/_navbar.html -->
        <nav class="navbar p-0 fixed-top d-flex flex-row" >
            <div class="navbar-brand-wrapper d-flex d-lg-none align-items-center justify-content-center">
<%--                <a class="navbar-brand brand-logo-mini" href="/did"><img src="/did/images/logo-mini.svg" alt="logo" /></a>--%>
            </div>
            <div class="navbar-menu-wrapper flex-grow d-flex align-items-end">
                <ul class="navbar-nav w-100" style="justify-content: center !important; line-height: 1.5em; font-weight: 700; font-size: 3em;" >
                    설&nbsp;비&nbsp;가&nbsp;동&nbsp;현&nbsp;황
                </ul>
                <ul class="navbar-nav navbar-nav-right w-20" style="justify-content: center !important;">
                    <li class="nav-item dropdown" style="line-height: 1.5em; font-weight: 700; font-size: 3em !important;">
                        <div class="navbar-profile">
                            <p class="mb-0 d-none d-sm-block navbar-profile-name" style="font-size: 0.5em !important;" id="clock"></p>
                        </div>
                    </li>
                </ul>
            </div>
        </nav>


        <!-- partial -->
        <div class="main-panel">
            <div class="content-wrapper">
                <div class="row">
                    <div class="col-md-6 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body">
                                <div>
                                    <h1 id="EQU2_title" class="card-title" style="float: left"></h1>
                                    <div class="card-subtitle" style="float: right; color: red; font-size: 1.5em;">
                                        단위 : 1일
                                    </div>
                                </div>
                                <div class="table-responsive">
                                    <table id="EQU2" class="table table-bordered table-contextual">
                                        <colgroup>
                                            <col style="width: 15%">
                                            <col style="width: 35%">
                                            <col style="width: 15%">
                                            <col style="width: 35%">
                                        </colgroup>
                                        <tbody>
                                            <tr>
                                                <th class="tb_th">생산량</th>
                                                <td class="tb_td equ_if_qty"></td>
                                                <th class="tb_th">가동현황</th>
                                                <td class="tb_td equ_if_inoff"></td>
                                            </tr>
                                            <tr>
                                                <th class="tb_th">가동</br>시작시간</th>
                                                <td class="tb_td equ_if_stdt"></td>
                                                <th class="tb_th">가동</br>종료시간</th>
                                                <td class="tb_td equ_if_eddt"></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body">
                                <div>
                                    <h1 id="EQU3_title" class="card-title" style="float: left"></h1>
                                    <div class="card-subtitle" style="float: right; color: red; font-size: 1.5em;">
                                        단위 : 1일
                                    </div>
                                </div>
                                <div class="table-responsive">
                                    <table id="EQU3" class="table table-bordered table-contextual">
                                        <colgroup>
                                            <col style="width: 15%">
                                            <col style="width: 35%">
                                            <col style="width: 15%">
                                            <col style="width: 35%">
                                        </colgroup>
                                        <tbody>
                                        <tr>
                                            <th class="tb_th">생산량</th>
                                            <td class="tb_td equ_if_qty"></td>
                                            <th class="tb_th">가동현황</th>
                                            <td class="tb_td equ_if_inoff"></td>
                                        </tr>
                                        <tr>
                                            <th class="tb_th">가동</br>시작시간</th>
                                            <td class="tb_td equ_if_stdt"></td>
                                            <th class="tb_th">가동</br>종료시간</th>
                                            <td class="tb_td equ_if_eddt"></td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body">
                                <div>
                                    <h1 id="EQU4_title" class="card-title" style="float: left"></h1>
                                    <div class="card-subtitle" style="float: right; color: red; font-size: 1.5em;">
                                        단위 : 1일
                                    </div>
                                </div>
                                <div class="table-responsive">
                                    <table id="EQU4" class="table table-bordered table-contextual">
                                        <colgroup>
                                            <col style="width: 15%">
                                            <col style="width: 35%">
                                            <col style="width: 15%">
                                            <col style="width: 35%">
                                        </colgroup>
                                        <tbody>
                                        <tr>
                                            <th class="tb_th">생산량</th>
                                            <td class="tb_td equ_if_qty"></td>
                                            <th class="tb_th">가동현황</th>
                                            <td class="tb_td equ_if_inoff"></td>
                                        </tr>
                                        <tr>
                                            <th class="tb_th">가동</br>시작시간</th>
                                            <td class="tb_td equ_if_stdt"></td>
                                            <th class="tb_th">가동</br>종료시간</th>
                                            <td class="tb_td equ_if_eddt"></td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
            <!-- content-wrapper ends -->


<%@ include file="/WEB-INF/include/did-footer.jspf" %>