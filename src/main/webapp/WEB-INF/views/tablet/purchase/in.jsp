<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tablet-header.jspf" %>

<!-- jquery CDN -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- fullcalendar CDN -->
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet' />
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>
<!-- fullcalendar 언어 CDN -->
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script>

<style>  /* body 스타일 */
    /*html, body {*/
    /*    overflow: hidden;*/
    /*    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;*/
    /*    font-size: 14px;*/
    /*}*/

    /* 캘린더 위의 해더 스타일(날짜가 있는 부분) */
    .fc-header-toolbar {
        padding-top: 1em;
        padding-left: 1em;
        padding-right: 1em;
    }

    .card-main-body {
        display: flex;
        flex-wrap: nowrap;
        justify-content: space-around;
        align-items: center;
        flex-direction: row;
        margin-top: 5px;
    }

    .card-body2 {
        width: 48vw;
        height: 30vh;
        align-items: center;
        background-color: #6699FF;
    }

    .card-body3 {
        width: 32vw;
        height: 30vh;
        align-items: center;
        background-color: #6699FF;
    }

    .card-text {
        position: absolute;
        top: 45%;
        left: 25%;
        margin: -25px 0 0 -25px;
        font-size: 3.5em;
        font-weight: 800;
        color: whitesmoke;
    }

    .card-third-text { left: 18%;}
</style>

<div id='calendar-container'>
    <div class="card-main-body">
        <div class="card card-body2" onclick="goTablePage('MI');">
            <div class="card-text">
                <i class="fa fa-reply-all" aria-hidden="true"></i> 자재입고
            </div>
        </div>
        <div class="card card-body2" onclick="goTablePage('PD');">
            <div class="card-text">
                <i class="fas fa-truck"></i> 제품출고
            </div>
        </div>
    </div>
    <div class="card-main-body">
        <div class="card card-body2" onclick="goTablePage('PL');">
            <div class="card-text">
                <i class="fas fa-cogs"></i> 생산보고
            </div>
        </div>
        <div class="card card-body2" onclick="goTablePage('PI');">
            <div class="card-text">
                <i class="fas fa-cog"></i> 재료투입2
            </div>
        </div>
    </div>
    <div class="card-main-body">
        <div class="card card-body3" onclick="goTablePage('QI');">
            <div class="card-text card-third-text" >
                <i class="fas fa-file-signature"></i> 수입검사
            </div>
        </div>
        <div class="card card-body3" onclick="goTablePage('QP');">
            <div class="card-text card-third-text">
                <i class="fas fa-file-signature"></i> 공정검사
            </div>
        </div>
        <div class="card card-body3" onclick="goTablePage('QD');">
            <div class="card-text card-third-text">
                <i class="fas fa-file-signature"></i> 출고검사
            </div>
        </div>
    </div>
</div>

<script>
    (function() {

    })();

    function goTablePage(flag) {
        console.log('PM 6:34', '112', flag);
    }

</script>

<%@ include file="/WEB-INF/include/tablet-footer.jspf" %>

