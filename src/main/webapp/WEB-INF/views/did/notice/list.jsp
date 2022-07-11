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

</style>

<script>

    let noticeSize;
    let offset;

    $(document).ready(() => {

        getTimeStamp();
        setInterval(() => getTimeStamp(), 1000);
        getNoticeSize();
        setTimeout(() => setContent(), 300);
        setInterval(() => setContent(), 30000);

        setTimeout(() => $(".nav-link:eq(1)").closest("li").removeClass("active"), 10);
        setTimeout(() => $(".nav-link:eq(2)").closest("li").removeClass("active"), 10);
    });

    function setContent()
    {
        offset = (IsNull(offset) ? "${vmap.offset}" : parseInt(offset)+1);
        (noticeSize === offset ? nextPage() : getData(offset));
    }

    function nextPage() {
        location.href = "/did/production/list";
    }

    function getData()
    {
        $.ajax({
            url: "/did/notice/noticeList"
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
            $("#content").text(data.notice_content);
        })
        .always(function (data) {

        })
        .fail(function (jqHXR, textStatus, errorThrown) {
            ajaxErrorAlert(jqHXR);
        });
    }

    function getNoticeSize()
    {
        $.ajax({
            url: "/did/notice/noticeSize"
            ,type: "post"
            ,headers: {
                "Content-Type": "application/json"
                ,"X-HTTP-Method-Override": "POST"
            }
            ,dataType: "json"
            ,data: JSON.stringify({})
        })
            .done(function (data)
            {
                noticeSize = data;
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
               <a class="nav-link active" href="/did/notice/list">
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
                    공&nbsp;&nbsp;&nbsp;지&nbsp;&nbsp;&nbsp;사&nbsp;&nbsp;&nbsp;&nbsp;항
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
                <div id="content" class="row" style="padding: 50px; white-space: pre; font-size: 4em; font-weight: bold;"></div>
            </div>
            <!-- content-wrapper ends -->


<%@ include file="/WEB-INF/include/did-footer.jspf" %>