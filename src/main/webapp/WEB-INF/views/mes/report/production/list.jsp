<%--
  Created by IntelliJ IDEA.
  User: outsourcing
  Date: 2022-02-09
  Time: 오후 10:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.min.js"></script>
<script type="text/javascript" src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>

<%@ include file="/WEB-INF/include/header.jspf" %>

<style>
    #btnNew {display: none;}
    #btnDelete {display: none;}
</style>

<!-- Begin Page Content -->
<div class="container-fluid">
    <div class="main-content">
        <table class="tableSearch table table-hover table-striped table-bordered mb-5" style="margin-bottom: 0.5rem !important;">
            <colgroup>
                <col style="width: 10%">
                <col style="width: 60%">
                <col style="width: 10%">
                <col style="width: 20%">
            </colgroup>
            <thead class="thead-light">
            <tr>
                <th>검색날짜</th>
                <td>
                    <div style="display: flex;">
                        <%@ include file="/WEB-INF/include/main-search-date-content.jspf"%>
                    </div>
                </td>
                <th>검색어</th>
                <td>
                    <div class="input-group">
                        <div class="input-group-prepend">
                                <span class="input-group-text">
                                    <i class="fas fa-search"></i>
                                </span>
                        </div>
                        <input id="search_text" name="search_text" class="form-control" placeholder="검색어" type="text">
                    </div>
                </td>
            </tr>
            </thead>
        </table>
    </div>

    <div class="menu-nav">
        <div>
            <span class="btn btn-pill btn-sm btn-primary">
                <i class="fas fa-home"></i> <i class="fas fa-arrow-circle-right"></i> 보고서 <i class="fas fa-arrow-circle-right"></i> 생산실적
            </span>
        </div>

        <%@ include file="/WEB-INF/include/main-top-right.jspf"%>
    </div>

    <%@ include file="/WEB-INF/include/main-progress.jspf"%>

    <div class="card shadow" style="min-height: 740px;">
        <div class="card-body">
            <div class="table-responsive">
                <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
                    <div class="row">
                        <div class="col-sm-12">
                            <table id ="tblMaster" class="table-list table table-hover table-striped table-bordered mb-5" style="width: 100%">
                                <thead>
                                <tr role="row">
                                    <th>생산시작시간</th>
                                    <th>생산종료시간</th>
                                    <th style="width: 8%">품번</th>
                                    <th style="width: 15%">품목명</th>
                                    <th>작업지시번호</th>
                                    <th>작업자</th>
                                    <th>생산량</th>
                                    <th>출력</th>
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

    <div class="report">
<%--        <div id="all">--%>
            <div id="a">
                <h1>A 영역 입니다.</h1>
            </div>

            <div id="b">
                <h1>B 영역 입니다.</h1>
            </div>

            <div id="c">
                <h1>C 영역 입니다.</h1>
            </div>

            <div id="d">
                <h1>D 영역 입니다.</h1>
            </div>
<%--        </div>--%>
    </div>
</div>

<script>

    $(document).ready(() => {
        // DataTables setting
        setDatatable();

        $("#prod_kind, #prod_family, #prod_group").on("change", () => { getData() });

        // 조회
        $("#btnSearch").on("click", () => { getData() });

        setTimeout(() => getData(), 30);

    });

    // set tblMaster Database
    function setDatatable()
    {
        var arguments = {
            tabldID: "tblMaster"
            ,ordering: true
            // ,responsive: true
            ,orderIdx: []
            ,orderGubn:	[]
            ,rowspan: ""
            ,lengthMenu: [15, 50, 100, 500, 1000]
            ,paging: true
            ,field: true
            ,info: true
            ,filter: true
            ,stateSave: true
            ,collapse: false
            ,scrollY: 540
            ,selected: true
            ,multiSelected: false
            ,columnDefs : [
                {
                    "targets": 'no-sort',
                    "orderable": false
                }
            ]
        };

        setDataTablesOption(arguments);

    }

    function getData()
    {
        showWait('.container-fluid');

        $.ajax({
            url: "/mes/production/result/planResultList"
            ,type: "post"
            ,headers: {
                "Content-Type": "application/json"
                ,"X-HTTP-Method-Override": "POST"
            }
            ,dataType: "json"
            ,data: JSON.stringify({
                fact_cd: "${vmap.fact_cd}"
                ,startDate: $("#startDate").val()
                ,endDate: $("#endDate").val()
                ,search_text: $("#search_text").val()
            })
        })
            .done(function (data)
            {
                $("#tblMaster").DataTable().clear();

                data.forEach((item, index) => {
                    let node = [];

                    node.push("<div class='text-center'>" + IsEmpty(item.plan_res_stdt) + "</div>");
                    node.push("<div class='text-center'>" + IsEmpty(item.plan_res_eddt) + "</div>");
                    node.push(IsEmpty(item.prod_pn));
                    node.push(IsEmpty(item.prod_nm));
                    node.push(IsEmpty(item.plan_no));
                    node.push(IsEmpty(item.plan_res_u_nm));
                    node.push("<div class='text-right'>" + IsEmpty(item.plan_res_cnt.comma('2')) + " " + IsEmpty(item.prod_unit_nm) + "</div>");

                    let manageButton = "<div style='display: flex; flex-wrap: wrap; justify-content: space-around;' >" +
                                       "    <button class=\"btn btn-sm btn btn-first \" type=\"button\" onclick=\"goReport()\">출력</button>" +
                                       "</div>";

                    node.push(manageButton);

                    // 각 row node 추가
                    $("#tblMaster").DataTable().row.add(node).node();
                });

                // datatables draw
                $("#tblMaster").DataTable().draw(false);
            })
            .always(function (data) {
                hideWait('.container-fluid');
            })
            .fail(function (jqHXR, textStatus, errorThrown) {
                ajaxErrorAlert(jqHXR);
            });
    }
</script>

<script type="text/javascript">
    let all_area_array = ['#a','#b','#c','#d']; //전체영역 area
    let area_array = ['#a','#c','#d']; //pdf 다운 영역

    const goReport = () => {
        let difference = all_area_array.filter(x => !area_array.includes(x));

        // $.each(difference,function(index, item){
        //     $(item).attr('data-html2canvas-ignore', true);
        // });

        // $("#all").attr("data-html2canvas-ignore", true);

        setTimeout(pdfMake(),500);
    }

    // $('#pdf').on("click", function () {
    //     let difference = all_area_array.filter(x => !area_array.includes(x));
    //     $.each(difference,function(index, item){
    //         $(item).attr('data-html2canvas-ignore', true);
    //     });
    //     setTimeout(pdfMake(),500);
    // });

    const pdfMake = () => {
        html2canvas($('.report')[0]).then(function(canvas) {
            let imgData = canvas.toDataURL('image/png');

            let imgWidth = 210; // 이미지 가로 길이(mm) A4 기준
            let pageHeight = imgWidth * 1.414;  // 출력 페이지 세로 길이 계산 A4 기준
            let imgHeight = canvas.height * imgWidth / canvas.width;
            let heightLeft = imgHeight;

            let doc = new jsPDF('p', 'mm');
            let position = 0;

            // 첫 페이지 출력
            doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
            heightLeft -= pageHeight;

            // 한 페이지 이상일 경우 루프 돌면서 출력
            while (heightLeft >= 20) {
                position = heightLeft - imgHeight;
                doc.addPage();
                doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
                heightLeft -= pageHeight;
            }

            let today = new Date();
            let year = today.getFullYear();
            let month = ('0' + (today.getMonth() + 1)).slice(-2);
            let day = ('0' + today.getDate()).slice(-2);
            let hours = ('0' + today.getHours()).slice(-2);
            let minutes = ('0' + today.getMinutes()).slice(-2);

            let dateString = year + month + day + hours + minutes;

            // 파일 저장
            doc.save("생산실적_"+dateString+'.pdf');
        });
    }
</script>

<%@ include file="/WEB-INF/include/footer.jspf" %>