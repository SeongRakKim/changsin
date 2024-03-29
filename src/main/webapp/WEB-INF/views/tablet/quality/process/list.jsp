<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tablet-header2.jspf" %>

<style></style>

<div class="container-fluid">
    <div class="main-content">
        <table class="tableSearch table table-hover table-striped table-bordered mb-5 border-left-secondary"
               style="margin-bottom: 0.5rem !important;">
            <colgroup>
                <col style="width: 10%">
                <col style="width: 60%">
                <col style="width: 10%">
                <col style="width: 20%">
            </colgroup>
            <thead class="thead-light">
                <tr>
                    <th>검색날짜</th>
                    <td colspan="3">
                        <div style="display: flex;">
                            <%@ include file="/WEB-INF/include/tablet-main-search-date-content.jspf"%>
                        </div>
                    </td>
                </tr>
            </thead>
        </table>
    </div>

    <div id="tblList" class="card tablet-main-card" ></div>
</div>

<script id="purchaseListTemplate" type="text/x-handlebars-template">
    <div class="card-body card-list-body list_div{{cnt}}">
        <div class="card-border">
            <div class="sub-card-table2">
                <table class="table tableSearch table-bordered mb-5" style="height: 100%;">
                    <colgroup>
                        <col style="width: 10%">
                        <col style="width: 15%">
                        <col style="width: 10%">
                        <col style="width: 15%">
                        <col style="width: 10%">
                        <col style="width: 15%">
                        <col style="width: 10%">
                        <col style="width: 15%">
                        <col style="width: 10%">
                        <col style="width: 15%">
                    </colgroup>
                    <thead>
                    <tr>
                        <th>작업지시번호</th>
                        <td style="font-size: 0.5em;">
                            <input type="hidden" name="frm_plan_cd" class="form-control" value="{{plan_cd}}" />
                            <input type="hidden" name="frm_plan_proc_cd" class="form-control" value="{{plan_proc_cd}}" />
                            <input type="hidden" name="frm_plan_dt" class="form-control" value="{{plan_dt}}" />
                            <input type="hidden" name="frm_plan_no" class="form-control" value="{{plan_no}}" />
                            <input type="hidden" name="frm_plan_proc_dt" class="form-control" value="{{plan_proc_dt}}" />
                            <input type="hidden" name="frm_proc_nm" class="form-control" value="{{proc_nm}}" />
                            <input type="hidden" name="frm_plan_cnt" class="form-control" value="{{plan_cnt}}" />
                            <input type="hidden" name="frm_plan_proc_cnt" class="form-control" value="{{plan_proc_cnt}}" />
                            <input type="hidden" name="frm_prod_cd" class="form-control" value="{{prod_cd}}" />
                            <input type="hidden" name="frm_prod_pn" class="form-control" value="{{prod_pn}}" />
                            <input type="hidden" name="frm_prod_nm" class="form-control" value="{{prod_nm}}" />
                            <input type="hidden" name="frm_prod_kind_nm" class="form-control" value="{{prod_kind_nm}}" />
                            <input type="hidden" name="frm_prod_stand" class="form-control" value="{{prod_stand}}" />
                            <input type="hidden" name="frm_prod_unit_nm" class="form-control" value="{{prod_unit_nm}}" />
                            <input type="hidden" name="frm_prod_lot_yn" class="form-control" value="{{prod_lot_yn}}" />
                            <input type="hidden" name="frm_plan_proc_quality_yn" class="form-control" value="{{plan_proc_quality_yn}}" />
                            {{plan_no}}
                        </td>
                        <th>계획일</th>
                        <td style="font-size: 0.5em;">{{plan_dt}}</td>
                        <th>품번</th>
                        <td>{{prod_pn}}</td>
                        <th>수량</th>
                        <td>{{plan_proc_cnt}}{{prod_unit_nm}}</td>
                    </tr>
                    <tr>
                        <th>품명</th>
                        <td>{{prod_nm}}</td>
                        <th>검사유무</th>
                        <td>{{plan_proc_quality_yn}}</td>
                        <th>측정분류</th>
                        <td>{{plan_proc_quality_nm}}</td>
                        <th>측정값</th>
                        <td>{{plan_proc_quality_val}}</td>
                    </tr>
                    </thead>
                </table>
            </div>
            <div class="sub-card-detail">
                <button class="btn btn-ready btn-sm btn-first tablet-list-btn-full" type="button" onclick="goQualityModal({{cnt}})">검사</button>
                <button class="btn btn-complete btn-sm btn-info tablet-list-btn-full" type="button" disabled style="display: none;">완료</button>
            </div>
        </div>
    </div>
</script>

<div class="modal fade dataModal inspModal" id="inspModal" tabindex="-1" role="dialog" aria-labelledby="registModal" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-xl modal-form-xl" role="document">
        <div class="modal-content" style="width: 40vw; height: 80vh;">
            <div class="modal-header" style="padding: 0.4rem">
                <h4 class="modal-title"><i class="fas fa-insp-circle"></i> 공정검사등록</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">
                <table id="tblinspPopData" class="table table-hover table-bordered mb-3 table-form">
                    <colgroup>
                        <col style="width: 30%" />
                        <col style="width: 70%" />
                    </colgroup>
                    <tbody>
                        <tr role="row">
                            <th>계획일</th>
                            <td>
                                <input type="hidden" id="pop_plan_cd" name="pop_plan_cd" value="" />
                                <input type="hidden" id="pop_plan_proc_cd" name="pop_plan_proc_cd" value="" />
                                <div id="pop_plan_dt" name="pop_plan_dt"></div>
                            </td>
                        </tr>
                        <tr>
                            <th>작업지시번호</th>
                            <td>
                                <div id="pop_plan_no" name="pop_plan_no"></div>
                            </td>
                        </tr>
                        <tr>
                            <th>거래처</th>
                            <td>
                                <div id="pop_comp_nm" name="pop_comp_nm"></div>
                            </td>
                        </tr>
                        <tr>
                            <th>품번</th>
                            <td>
                                <div id="pop_prod_pn" name="pop_prod_pn"></div>
                            </td>
                        </tr>
                        <tr>
                            <th>품명</th>
                            <td>
                                <div id="pop_prod_nm" name="pop_prod_nm"></div>
                            </td>
                        </tr>
                        <tr>
                            <th>규격</th>
                            <td>
                                <div id="pop_prod_stand" name="pop_prod_stand"></div>
                            </td>
                        </tr>
                        <tr>
                            <th>단위</th>
                            <td>
                                <div id="pop_prod_unit_nm" name="pop_prod_unit_nm"></div>
                            </td>
                        </tr>
                        <tr>
                            <th>계획수량</th>
                            <td>
                                <div class="text-right" id="pop_plan_cnt" name="pop_plan_cnt"></div>
                            </td>
                        </tr>
                        <tr>
                            <th>생산수량</th>
                            <td>
                                <div class="text-right" id="pop_plan_proc_cnt" name="pop_plan_proc_cnt"></div>
                            </td>
                        </tr>
                        <tr>
                            <th>측정분류</th>
                            <td>
                                <select id="pop_plan_proc_quality_cd" name="pop_plan_proc_quality_cd" class="custom-select w-100" style="width: 80% !important;">
                                    <option value="">측정분류선택</option>
                                    <c:forEach var="item" items="${vmap.qualityItemList}" varStatus="status">
                                        <option value="${item.base_detail_cd}">${item.base_detail_nm}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th>측정값</th>
                            <td>
                                <div style="display: flex; flex-wrap: wrap;">
                                    <div class="custom-control custom-radio my-3">
                                        <input type="radio" checked=""  id="customRadio1" name="pop_plan_proc_quality_val" class="custom-control-input" value="Y">
                                        <label class="custom-control-label" for="customRadio1">양호</label>
                                    </div>
                                    <div class="custom-control custom-radio my-3">
                                        <input type="radio" id="customRadio2" name="pop_plan_proc_quality_val" class="custom-control-input" value="N">
                                        <label class="custom-control-label" for="customRadio2">불량</label>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>불량수량</th>
                            <td>
                                <input type="text" id="pop_plan_proc_quality_cnt" name="pop_plan_proc_quality_cnt" class="form-control"
                                       placeholder="생산불량수량" title="생산불량수량" />
                            </td>
                        </tr>
                    </tbody>
                </table>

                <form id="inspForm" name="dataForm" class="dataForm" method="post">
                    <div style="display: flex; flex-direction: row-reverse; justify-content: center; align-items: center;">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">
                            <span class="btn-wrapper--icon">
                                <i class="fas fa-times-circle"></i>
                            </span>
                            <span class="btn-wrapper--label">닫기</span>
                        </button>

                        <button type="button" id="btnRegist" class="btn btn-primary" style="margin-right: 10px;">
                            <span class="btn-wrapper--icon">
                                <i class="fas fa-download"></i>
                            </span>
                            <span class="btn-wrapper--label">저장</span>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>



<script>
    let selectRow = null;
    $(document).ready(() => {
        $("#tablet-top-title").text("품질검사 > 공정검사");
        setTimeout(() => getData(), 50);

        $("#btnRegist").on("click", () =>
        {
            if(IsNull($("#pop_plan_proc_cd").val())) {
                alert("저장할 항목을 선택해주세요.");
                return false;
            }
            if(IsNull($("#pop_plan_proc_quality_cd").val())) {
                alert("측정분류를 선택해주세요.");
                return false;
            }
            setProcessQualityModify();
        });
    });

    function getData()
    {
        showWait('.container-fluid');

        $.ajax({
            url: "/mes/quality/process/processInspectList"
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
                ,mes_state: "12"
                ,search_text: $("#search_text").val()
            })
        })
        .done(function (data)
        {
            $("#tblList").empty();
            if(IsNotNull(data)) {
                data.forEach((item, index) => {
                    addGetDataList(item);
                });
            }
        })
        .always(function (data) {
            hideWait('.container-fluid');
        })
        .fail(function (jqHXR, textStatus, errorThrown) {
            ajaxErrorAlert(jqHXR);
        });
    }

    let rowCnt = 0;
    function addGetDataList(item)
    {
        let template_html = $("#purchaseListTemplate").html();
        let template = Handlebars.compile(template_html);

        let templateData = {
            ...item
            , cnt: ++rowCnt
            ,plan_proc_cnt: item.plan_proc_cnt.comma('2')
            ,plan_dt: item.plan_stdt + " ~ " + item.plan_eddt
        };

        $("#tblList").append(template(templateData));

        if(item.plan_proc_quality_yn === "Y") {
            $("#tblList .list_div" + rowCnt + " .btn-complete").toggle();
            $("#tblList .list_div" + rowCnt + " .btn-ready").toggle();

            $("#tblList .list_div" + rowCnt + " .sub-card-state").addClass("bg-gradient-info");
            $("#tblList .list_div" + rowCnt + " .sub-card-state").removeClass("bg-gradient-primary");
        }
    }

    function goQualityModal(cnt)
    {
        $("#inspModal").modal("show");

        let frm_plan_cd = $("#tblList .list_div" + cnt).find("[name=frm_plan_cd]").val();
        let frm_plan_proc_cd = $("#tblList .list_div" + cnt).find("[name=frm_plan_proc_cd]").val();
        let frm_plan_dt = $("#tblList .list_div" + cnt).find("[name=frm_plan_dt]").val();
        let frm_plan_no = $("#tblList .list_div" + cnt).find("[name=frm_plan_no]").val();
        let frm_comp_nm = $("#tblList .list_div" + cnt).find("[name=frm_comp_nm]").val();
        let frm_prod_pn = $("#tblList .list_div" + cnt).find("[name=frm_prod_pn]").val();
        let frm_prod_nm = $("#tblList .list_div" + cnt).find("[name=frm_prod_nm]").val();
        let frm_prod_stand = $("#tblList .list_div" + cnt).find("[name=frm_prod_stand]").val();
        let frm_prod_unit_nm = $("#tblList .list_div" + cnt).find("[name=frm_prod_unit_nm]").val();
        let frm_plan_cnt = $("#tblList .list_div" + cnt).find("[name=frm_plan_cnt]").val();
        let frm_plan_proc_cnt = $("#tblList .list_div" + cnt).find("[name=frm_plan_proc_cnt]").val();
        let frm_plan_proc_in_cnt = $("#tblList .list_div" + cnt).find("[name=frm_plan_proc_in_cnt]").val();
        let frm_plan_proc_quality_cd = $("#tblList .list_div" + cnt).find("[name=frm_plan_proc_quality_cd]").val();
        let frm_plan_proc_quality_val = $("#tblList .list_div" + cnt).find("input:radio[name=frm_plan_proc_quality_val]:checked").val();

        $("#pop_plan_cd").val(frm_plan_cd);
        $("#pop_plan_proc_cd").val(frm_plan_proc_cd);
        $("#pop_plan_dt").text(frm_plan_dt);
        $("#pop_plan_no").text(frm_plan_no);
        $("#pop_comp_nm").val(frm_comp_nm);
        $("#pop_prod_pn").text(frm_prod_pn);
        $("#pop_prod_nm").text(frm_prod_nm);
        $("#pop_prod_stand").text(frm_prod_stand);
        $("#pop_prod_unit_nm").text(frm_prod_unit_nm);
        $("#pop_plan_cnt").text(frm_plan_cnt);
        $("#pop_plan_proc_cnt").text(frm_plan_proc_cnt);
        $("#pop_plan_proc_in_cnt").text(frm_plan_proc_in_cnt);
        $("#pop_plan_proc_quality_cd").val(frm_plan_proc_quality_cd);
        $("#pop_plan_proc_quality_val").val(frm_plan_proc_quality_val);
    }

    function setProcessQualityModify()
    {
        Swal.fire({
            title: '',
            text: "공정검사 결과를 저장하시겠습니까?",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: '확인',
            cancelButtonText: '취소'
        }).then((result) => {
            if (result.isConfirmed)
            {
                showWait('.dataModal');
                $.ajax({
                    type: "post"
                    ,url: "/mes/quality/process/processQualityModify"
                    ,headers: {
                        "Content-Type": "application/json"
                        ,"X-HTTP-Method-Override": "POST"
                    }
                    ,dataType: "text"
                    ,data: JSON.stringify({
                        fact_cd: "${vmap.fact_cd}"
                        ,plan_cd: $("#pop_plan_cd").val()
                        ,plan_proc_cd: $("#pop_plan_proc_cd").val()
                        ,plan_proc_quality_yn: "Y"
                        ,plan_proc_quality_cd: $("#pop_plan_proc_quality_cd").val()
                        ,plan_proc_quality_val: $("input:radio[name=pop_plan_proc_quality_val]:checked").val()
                        ,plan_proc_quality_cnt: $("#pop_plan_proc_quality_cnt").val()
                    })
                })
                .done(function (data) {
                    hideWait('.dataModal');
                    $("#inspModal").modal("hide");
                    getData();
                })
                .always(function (data) {

                })
                .fail(function (jqHXR, textStatus, errorThrown) {
                    ajaxErrorAlert(jqHXR);
                    hideWait('.dataModal');
                });
            }
        });
    }

</script>

<%@ include file="/WEB-INF/include/tablet-footer.jspf" %>

