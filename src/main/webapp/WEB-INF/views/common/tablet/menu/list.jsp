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
        justify-content: center;
        align-items: center;
    }

    .card-body3 {
        width: 32vw;
        height: 30vh;
        align-items: center;
        background-color: #6699FF;
        justify-content: center;
        align-items: center;
    }

    .card-text {
        /*position: absolute;*/
        /*top: 45%;*/
        /*left: 25%;*/
        /*margin: -25px 0 0 -25px;*/
        font-size: 3.5em;
        font-weight: 800;
        color: whitesmoke;
    }

    .card-third-text { left: 18%;}
</style>

<div id='calendar-container'>
    <div class="card-main-body">
        <div class="card card-body2" onclick="goTabletPage('MI');">
            <div class="card-text">
                <i class="fa fa-reply-all" aria-hidden="true"></i> 자재입고
            </div>
        </div>
        <div class="card card-body2" onclick="goTabletPage('PD');">
            <div class="card-text">
                <i class="fas fa-truck"></i> 제품출고
            </div>
        </div>
    </div>
    <div class="card-main-body">
        <div class="card card-body2" style="width: 98vw" onclick="goTabletPage('PL');">
            <div class="card-text" style="left: 35%">
                <i class="fas fa-cogs"></i> 생산보고
            </div>
        </div>
<%--        <div class="card card-body4" onclick="goTabletPage('PI');">--%>
<%--            <div class="card-text">--%>
<%--                <i class="fas fa-cog"></i> 재료투입--%>
<%--            </div>--%>
<%--        </div>--%>
    </div>
    <div class="card-main-body">
        <div class="card card-body3" onclick="goTabletPage('QI');">
            <div class="card-text card-third-text" >
                <i class="fas fa-file-signature"></i> 수입검사
            </div>
        </div>
        <div class="card card-body3" onclick="goTabletPage('QP');">
            <div class="card-text card-third-text">
                <i class="fas fa-file-signature"></i> 공정검사
            </div>
        </div>
        <div class="card card-body3" onclick="goTabletPage('QD');">
            <div class="card-text card-third-text">
                <i class="fas fa-file-signature"></i> 출고검사
            </div>
        </div>
    </div>
</div>

<script>
    (function() {

    })();

    function goTabletPage(flag) {
        switch (flag) {
            case 'MI' :
                location.href = "/tablet/purchase/in";
                break;
            case 'PD' :
                location.href = "/tablet/ship/out";
                break;
            case 'PL' :
                location.href = "/common/tablet/process/list";
                break;
            case 'QI' :
                location.href = "/tablet/quality/material/list";
                // location.href = "/tablet/quality/list";
                break;
            case 'QP' :
                location.href = "/tablet/quality/process/list";
                break;
            case 'QD' :
                location.href = "/tablet/quality/shipment/list";
                break;
        }
    }

</script>

<%@ include file="/WEB-INF/include/tablet-footer.jspf" %>

