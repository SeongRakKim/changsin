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

</style>

<script>

    let noticeSize;
    let offset;

    $(document).ready(() => {

        getTimeStamp();
        setInterval(() => getTimeStamp(), 1000);

        getData();
        setTimeout(() => nextPage(), 10000);

        setTimeout(() => $(".nav-link:eq(0)").closest("li").removeClass("active"), 10);
        setTimeout(() => $(".nav-link:eq(2)").closest("li").removeClass("active"), 10);
    });


    function nextPage() {
        location.href = "/did/equipment/list";
    }

    function getData()
    {
        $.ajax({
            url: "/did/production/planResultDidList"
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
                let html = "";
                html += "<tr>";
                html += "   <td>" + item.plan_res_dt + "</td>";
                html += "   <td>" + item.plan_no + "</td>";
                html += "   <td>" + item.prod_pn + "</td>";
                html += "   <td>" + item.prod_nm + "</td>";
                html += "   <td>" + item.plan_proc_cnt.comma('2') + "</td>";
                html += "   <td>" + item.plan_res_cnt.comma('2') + "</td>";
                html += "   <td>" + item.plan_res_u_nm + "</td>";
                html += "</tr>";

                $(".table > tbody").append(html);
            });

            console.log('오후 3:17', '82', data);
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
            <a class="sidebar-brand brand-logo" href="/did">LOGO</a>
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
               <a class="nav-link active" href="/did/production/list" >
                   <span class="menu-icon">
                       <i class="mdi mdi mdi-brightness-5"></i>
                   </span>
                   <span class="menu-title">생산현황</span>
               </a>
            </li>
            <li class="nav-item menu-items">
               <a class="nav-link" href="/did/equipment/list" >
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
                <a class="navbar-brand brand-logo-mini" href="/did"><img src="/did/images/logo-mini.svg" alt="logo" /></a>
            </div>
            <div class="navbar-menu-wrapper flex-grow d-flex align-items-end">
                <ul class="navbar-nav w-100" style="justify-content: center !important; line-height: 1.5em; font-weight: 700; font-size: 3em;" >
                    생&nbsp;&nbsp;&nbsp;산&nbsp;&nbsp;&nbsp;현&nbsp;&nbsp;&nbsp;&nbsp;황
                </ul>
                <ul class="navbar-nav navbar-nav-right w-15" style="justify-content: center !important;">
                    <li class="nav-item dropdown" style="line-height: 1.5em; font-weight: 700; font-size: 3em;">
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
                <div class="row ">
                    <div class="col-12 grid-margin" >
                        <div class="card">
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table ttaa">
                                        <thead>
                                            <tr>
                                                <th>생산일</th>
                                                <th>작업지시번호</th>
                                                <th>품명</th>
                                                <th>품번</th>
                                                <th>계획수량</th>
                                                <th>생산수량</th>
                                                <th>작업자</th>
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
            <!-- content-wrapper ends -->


<%@ include file="/WEB-INF/include/did-footer.jspf" %>