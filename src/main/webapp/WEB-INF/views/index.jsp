<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/header.jspf" %>

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
</style>

<div id='calendar-container'>
    <div id='calendar'></div>
</div>

<script>
    (function() {
        $(function() {
            sendLogApi();

            // calendar element 취득
            var calendarEl = $('#calendar')[0];

            // full-calendar 생성하기
            var calendar = new FullCalendar.Calendar(calendarEl, {
                height: '800px', // calendar 높이 설정
                expandRows: true, // 화면에 맞게 높이 재설정
                slotMinTime: '08:00', // Day 캘린더에서 시작 시간
                slotMaxTime: '20:00', // Day 캘린더에서 종료 시간
                // 해더에 표시할 툴바
                headerToolbar: {
                    left: 'prev,next today',
                    center: 'title',
                    // right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
                    right: 'dayGridMonth,timeGridWeek,timeGridDay'
                },
                initialView: 'dayGridMonth', // 초기 로드 될때 보이는 캘린더 화면(기본 설정: 달)
                initialDate: getToday(), // 초기 날짜 설정 (설정하지 않으면 오늘 날짜가 보인다.)
                navLinks: false, // 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크
                editable: false, // 수정가능여부
                selectable: true, // 달력 일자 드래그 설정가능
                nowIndicator: true, // 현재 시간 마크
                dayMaxEvents: true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
                locale: 'ko', // 한국어 설정
                eventSources : [
                    {
                        events: function(fetchInfo, successCallback, failureCallback)
                        {
                            var startDate = moment(fetchInfo.startStr).format("YYYY-MM-DD");
                            var endDate = moment(fetchInfo.endStr).format("YYYY-MM-DD");

                            $.ajax({
                                url: "/mes/production/plan/planList"
                                ,type: "post"
                                ,headers: {
                                    "Content-Type": "application/json"
                                        ,"X-HTTP-Method-Override": "POST"
                                }
                                ,dataType: 'json'
                                ,data: JSON.stringify({
                                    startDate: startDate,
                                    endDate: endDate,
                                    fact_cd : '1000'
                                })
                            })
                            .done(function (data) {
                                var events = [];
                                $.each(data, function (i, item) {

                                    events.push({
                                        title: "품명 : " + item.prod_nm + " / " +"계획수량 : " + item.plan_cnt + " " + item.prod_unit_nm
                                        , start: moment(item.plan_stdt).format("YYYY-MM-DD")
                                        , end: moment(item.plan_eddt).format("YYYY-MM-DD")
                                    });
                                });
                                successCallback(events);
                            })
                            ;
                        }
                    }
                ],
                eventAdd: function(obj) { // 이벤트가 추가되면 발생하는 이벤트
                    console.log(obj);
                },
                eventChange: function(obj) { // 이벤트가 수정되면 발생하는 이벤트
                    console.log(obj);
                },
                eventRemove: function(obj){ // 이벤트가 삭제되면 발생하는 이벤트
                    console.log(obj);
                },
                select: function(arg) { // 캘린더에서 드래그로 이벤트를 생성할 수 있다.
                    // var title = prompt('Event Title:');
                    // if (title) {
                    //     calendar.addEvent({
                    //         title: title,
                    //         start: arg.start,
                    //         end: arg.end,
                    //         allDay: arg.allDay
                    //     })
                    // }
                    // calendar.unselect()
                },
                // 이벤트
                events: [

                ]
            });
            // 캘린더 랜더링
            calendar.render();
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
            useSe: "접속",
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
</script>

<%@ include file="/WEB-INF/include/footer.jspf" %>

