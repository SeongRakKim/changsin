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

    }

    .card-body2 {
        width: 49vw;
        height: 30vh;
        align-items: center;
    }

    .card-text {
        position: absolute;
        top: 50%;
        left: 50%;
        margin: -25px 0 0 -25px;
        font-size: 4em;
        font-weight: 900;
    }
</style>

<div id='calendar-container'>
    <div class="card-main-body">
        <div class="card card-body2" >
            <div class="card-text">
                <i class="fa fa-reply-all" aria-hidden="true"></i> 자재입고
            </div>
        </div>
        <div class="card card-body2">
            제품출고
        </div>
    </div>
</div>

<script>
    (function() {

    })();

</script>

<%@ include file="/WEB-INF/include/tablet-footer.jspf" %>

