<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tablet-header2.jspf" %>

<link rel="stylesheet" href="/plugin/jquerynumpad/jquery.numpad.css">
<script type="text/javascript" src="/plugin/jquerynumpad/jquery.numpad.js"></script>

<style>
    #planTableList thead tr th, #planTableList thead tr td {
        font-size: 1.2em;
        height: 7vh;
    }
    #planTableList {
        height: 50vh;
     }

    .tablet-list-btn-full {
        font-size: 1.15rem;
    }

    .result-button-box {
        display: flex;
        flex-wrap: nowrap;
        flex-direction: row;
        justify-content: space-evenly;
        align-items: center;
    }

    .modal-content-location {
        left: 50% !important;
        top: 50% !important;
    }

    .modal-backdrop {
        background-color: hsla(120, 100%, 150%, 0.5);
    }

    .btn .btn-wrapper--label:not(:first-child) {
        margin: 0;
    }

    .btn-pop {
        font-size: 0.3rem;
    }
</style>

<div class="container-fluid">
    <div id="dataOneDiv" class="main-content"></div>
    <div style="display: flex; flex-wrap: nowrap; flex-direction: row; justify-content: center; align-items: center;">
        <div id="tblList" class="card tablet-main-card2" ></div>
        <div id="tblList2" class="card tablet-main-card3" style="padding: 0.75rem;">
            <table id="tblPopShipmentData" class="tableSearch table table-hover table-striped table-bordered mb-5 order-bottom-success">
                <colgroup>
                    <col style="width: 10%" />
                    <col style="width: 25%" />
                    <col style="width: 25%" />
                    <col style="width: 20%" />
                    <col style="width: 20%" />
                </colgroup>
                <thead>
                <tr>
                    <th>순서</th>
                    <th>납품일</th>
                    <th>LOT.NO </th>
                    <th>납품수량 </th>
                    <th>비고 </th>
                </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
    </div>
</div>

<script id="mainListTemplate" type="text/x-handlebars-template">
    <table id="mainDataOne" class="tableSearch table table-hover table-striped table-bordered mb-5 order-bottom-success"
           style="margin-bottom: 0.5rem !important;">
        <colgroup>
            <col style="width: 10%">
            <col style="width: 25%">
            <col style="width: 10%">
            <col style="width: 25%">
            <col style="width: 10%">
            <col style="width: 20%">
        </colgroup>
        <thead class="thead-light">
            <tr>
                <th>거래처</th>
                <td>
                   <input type="hidden" id="frm_ship_cd" name="frm_ship_cd" class="form-control"
                           placeholder="납품코드" title="납품코드" value="{{ship_cd}}"/>
                    <input type="hidden" id="frm_odr_cd" name="frm_odr_cd" class="form-control"
                           placeholder="수주코드" title="수주코드" value="{{odr_cd}}"/>
                    <input type="hidden" id="frm_comp_cd" name="frm_comp_cd" class="form-control"
                           placeholder="거래처" title="거래처" value="{{comp_cd}}"/>
                    <input type="hidden" id="frm_comp_nm" name="frm_comp_nm" class="form-control"
                           placeholder="거래처" title="거래처" value="{{comp_nm}}"/>
                    <input type="hidden" id="frm_odr_dt" name="frm_odr_dt" class="form-control"
                           placeholder="수주일" title="수주일" value="{{odr_dt}}"/>
                    <input type="hidden" id="frm_odr_cnt" name="frm_odr_dt" class="form-control"
                           placeholder="수주일" title="수주일" value="{{odr_cnt}}"/>
                    <input type="hidden" id="frm_odr_ship_dt" name="frm_odr_ship_dt" class="form-control"
                           placeholder="납기요청일" title="납기요청일" value="{{odr_ship_dt}}"/>
                    {{comp_nm}}
                </td>
                <th>수주일</th>
                <td>{{odr_dt}}</td>
                <th>납기요청일</th>
                <td>{{odr_ship_dt}}</td>
            </tr>
            <tr>
                <th>품명</th>
                <td>
                    <input type="hidden" id="frm_prod_cd" name="frm_prod_cd" class="form-control" value="{{prod_cd}}"
                           placeholder="제품코드" title="제품코드" />
                    <input type="hidden" id="frm_prod_nm" name="frm_prod_nm" class="form-control" value="{{prod_nm}}"
                           placeholder="제품명" title="제품명" />
                    <input type="hidden" id="frm_prod_pn" name="frm_prod_pn" class="form-control" value="{{prod_pn}}"
                           placeholder="제품품번" title="제품코드" />
                    <input type="hidden" id="frm_prod_lot_yn" name="frm_prod_lot_yn" class="form-control" value="{{prod_lot_yn}}" />
                    {{prod_nm}}
                </td>
                <th>규격</th>
                <td>{{prod_stand}}</td>
                <th>납품요청양</th>
                <td>
                    <input type="hidden" id="frm_ship_cnt" name="frm_ship_cnt" class="form-control" value="{{ship_cnt}}" />
                    {{odr_cnt}}
                </td>
            </tr>
        </thead>
    </table>
</script>

<script id="shipDetailTemplate" type="text/x-handlebars-template">
    <div class="card-body main-card-list-body">
        <div class="card-border">
            <div class="sub-card-table">
                <table id="planTableList" class="table tableSearch table-bordered mb-2 tablet-proc-main-table">
                    <colgroup>
                        <col style="width: 30%">
                        <col style="width: 70%">
                    </colgroup>
                    <thead>
                        <tr>
                            <th>납품일<span class="red"> (*)</span></th>
                            <td style="text-align: center;">
                                <input type="hidden" id="frm_ship_detail_cd" name="frm_ship_detail_cd" class="form-control" value="{{ship_detail_cd}}" />
                                <div class="input-group input-group-seamless">
                                    <input id="frm_ship_detail_dt" name="frm_ship_detail_dt" class="form-control datepicker no-reset" title="납품일자"
                                           placeholder="납품일자" type="text" value="" />
                                    <div class="input-group-append">
                                        <span class="input-group-text"><i class="fas fa-calendar"></i></span>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>LOT.NO <span class="red"> (*)</span></th>
                            <td>
                                <select id="frm_lot_no" name="frm_lot_no" class="custom-select w-100" style="width: 100% !important; display: none;" >
                                    <option value="">LOT 선택</option>
                                </select>
                                <input type="hidden" id="frm_old_lot_no" name="frm_old_lot_no" class="form-control" value="{{old_lot_no}}"
                                       placeholder="Lot.No" title="Lot.No" required />
                            </td>
                        </tr>
                        <tr>
                            <th>납품수량 <span class="red"> (*)</span></th>
                            <td>
                                <input type="hidden" id="frm_old_ship_detail_cnt" name="frm_old_ship_detail_cnt" class="form-control" value="{{old_ship_detail_cnt}}"
                                       placeholder="이전납품량" title="이전납품량" required />
                                <input type="text" id="frm_ship_detail_cnt" name="frm_ship_detail_cnt" class="form-control" value="{{ship_detail_cnt}}"
                                       placeholder="납품량" title="납품량" required />
                            </td>
                        </tr>
                        <tr>
                            <th>비고</th>
                            <td>
                                <input type="text" id="frm_ship_detail_notice" name="frm_ship_detail_notice" class="form-control" value="{{ship_detail_notice}}"
                                       placeholder="비고" title="비고" />
                            </td>
                        </tr>
                    </thead>
                </table>
                <div>
                    <button class="btn btn-sm btn-danger tablet-list-btn-full result-main-button result-btn-new" style="width: 100%; margin-bottom: 10px;" onclick="shipResultInit();"><i class="fas fa-plus"></i> 신규</button>
                    <button id="btnShipmentRegistModify" class="btn btn-sm btn-first tablet-list-btn-full result-main-button result-btn-regist" style="width: 100%;" onclick="shipmentDetailRegistModifyData();"><i class="fas fa-check"></i> 저장</button>
                </div>
            </div>
        </div>
    </div>
</script>

<script id="popSalesShipmentTemplete" type="text/x-handlebars-template">
    <tr class="dataList list_tr{{cnt}}">
        <td style="text-align: center !important;">
            <input type="hidden" name="pop_ship_detail_cd" class="form-control" value="{{ship_detail_cd}}" />
            {{cnt}}
        </td>
        <td style="text-align: center !important;">
            <input type="hidden" name="pop_ship_detail_dt" class="form-control" value="{{ship_detail_dt}}" />
            {{ship_detail_dt}}
        </td>
        <td style="text-align: center !important;">
            <input type="hidden" name="pop_old_lot_no" class="form-control" value="{{old_lot_no}}" />
            <input type="hidden" name="pop_lot_no" class="form-control" value="{{lot_no}}" />
            {{lot_no}}
        </td>
        <td style="text-align: center !important;">
            <input type="hidden" name="pop_old_ship_detail_cnt" class="form-control" value="{{old_ship_detail_cnt}}" />
            <input type="hidden" name="pop_ship_detail_cnt" class="form-control" value="{{ship_detail_cnt}}" />
            {{ship_detail_cnt}}
        </td>
        <td style="text-align: center !important;">
            <input type="hidden" name="pop_ship_detail_notice" class="form-control" value="{{ship_detail_notice}}" />
            {{ship_detail_notice}}
        </td>
    </tr>
</script>


<script id="planProcListTemplate" type="text/x-handlebars-template">
    <div class="card-body card-list-body list_div{{cnt}}">
        <div class="card-border">
            <div class="sub-card-state bg-gradient-primary">{{plan_proc_state_nm}}</div>
            <div class="sub-card-table">
                <table class="table tableSearch table-bordered mb-5">
                    <colgroup>
                        <col style="width: 13%">
                        <col style="width: 23%">
                        <col style="width: 13%">
                        <col style="width: 19%">
                        <col style="width: 13%">
                        <col style="width: 19%">
                    </colgroup>
                    <thead>
                    <tr>
                        <th>거래처</th>
                        <td>
                            <input type="hidden" name="frm_plan_cd" class="form-control" value="{{plan_cd}}" />
                            <input type="hidden" name="frm_plan_proc_cd" class="form-control" value="{{plan_proc_cd}}" />
                            <input type="hidden" name="frm_prod_cd" class="form-control" value="{{prod_cd}}" />
                            <input type="hidden" name="frm_prod_pn" class="form-control" value="{{prod_pn}}" />
                            <input type="hidden" name="frm_prod_nm" class="form-control" value="{{prod_nm}}" />
                            <input type="hidden" name="frm_prod_kind_nm" class="form-control" value="{{prod_kind_nm}}" />
                            <input type="hidden" name="frm_prod_stand" class="form-control" value="{{prod_stand}}" />
                            <input type="hidden" name="frm_prod_unit_nm" class="form-control" value="{{prod_unit_nm}}" />
                            <input type="hidden" name="frm_prod_lot_yn" class="form-control" value="{{prod_lot_yn}}" />
                            {{comp_nm}}
                        </td>
                        <th>품명</th>
                        <td>{{prod_nm}}</td>
<%--                        <th>품번</th>--%>
<%--                        <td>{{prod_pn}}</td>--%>
                        <th>규격</th>
                        <td>{{prod_stand}}</td>
                    </tr>
                    <tr>
                        <th>계획일</th>
                        <td>{{plan_stdt}}</td>
                        <th>계획수량</th>
                        <td>{{plan_cnt}}{{prod_unit_nm}}</td>
                        <th>생산수량</th>
                        <td>{{plan_proc_cnt}}{{prod_unit_nm}}</td>
                    </tr>
                    </thead>
                </table>
            </div>
            <div class="sub-card-detail">
<%--                <i class="fas fa-plus-square" onclick="setPurchaseInModify({{cnt}})"></i>--%>
                <button class="btn btn-ready btn-sm btn-first tablet-list-btn-full" type="button" onclick="setPurchaseInModify({{cnt}})">생산</button>
                <button class="btn btn-complete btn-sm btn-info tablet-list-btn-full" type="button" disabled style="display: none;">완료</button>
            </div>
        </div>
    </div>
</script>

<script type="text/javascript">
    $(document).ready(() => {
        $.fn.numpad.defaults.gridTpl = '<table class="table modal-content modal-content-location"></table>';
        $.fn.numpad.defaults.backgroundTpl = '<div class="modal-backdrop in"></div>';
        $.fn.numpad.defaults.displayTpl = '<input type="text" class="form-control  input-lg" style="width: 400px;" />';
        $.fn.numpad.defaults.buttonNumberTpl = '<button type="button" class="btn btn-danger btn-lg" style="width:80px;height:80px; font-size:25pt;font-weight:800;"></button>';
        $.fn.numpad.defaults.buttonFunctionTpl = '<button type="button" class="btn btn-lg" style="width: 100%; height:80px;color:#000000;"></button>';
        $.fn.numpad.defaults.onKeypadCreate = function() {
            $(this).find('.done').addClass('btn-primary');
            $(this).find('.cancel').addClass('btn-danger');
            $(this).find('.clear').addClass('btn-warning');
            $(this).find('.del').addClass('btn-warning');
        };
        // $.fn.numpad.defaults.hidePlusMinusButton = true;
        $.fn.numpad.defaults.hideDecimalButton = false;
        $.fn.numpad.defaults.hideDotButton = false;
        $.fn.numpad.defaults.textDone = '<strong style="font-size:20pt;color:#ffffff;">입력</strong>';
        $.fn.numpad.defaults.textDelete = '<strong style="font-size:20pt;color:#ffffff;">지우기</strong>';
        $.fn.numpad.defaults.textClear = '<strong style="font-size:20pt;color:#ffffff;">초기화</strong>';
        $.fn.numpad.defaults.textCancel = '<strong style="font-size:20pt;color:#ffffff;">취소</strong>';

        $("#tablet-top-title").text("납품실적등록");
        // setTimeout(() => getData(), 50);
        setTimeout(() => setResultTemplate(), 50);
        getDataOne("${vmap.odr_cd}", "${vmap.ship_cd}");

    });

    function getDataOne(odr_cd, ship_cd)
    {
        $.ajax({
            url: "/mes/sales/shipment/shipOne/" + odr_cd + "/" + ship_cd
            ,type: "get"
            ,dataType: "json"
            // ,data: JSON.stringify({})
        })
        .done(function (data)
        {
            addDataOne(data);
        })
        .always(function (data) {
            hideWait('.dataModal');
        })
        .fail(function (jqHXR, textStatus, errorThrown) {
            ajaxErrorAlert(jqHXR);
        });
    }

    // 지시정보
    let mainRowCnt = 0;
    function addDataOne(item)
    {
        let template_html = $("#mainListTemplate").html();
        let template = Handlebars.compile(template_html);

        let templateData = {
            ...item
            ,cnt: ++mainRowCnt
            ,ship_cnt: item.ship_cnt.comma('2')
        }

        $("#dataOneDiv").append(template(templateData));
        getShipmentDetailData();
    }

    // 실적 입력 template
    function setResultTemplate()
    {
        let template_html = $("#shipDetailTemplate").html();
        let template = Handlebars.compile(template_html);

        let templateData = {
            old_ship_detail_cnt: 0
        }

        $("#tblList").append(template(templateData));

        $("#tblList").find(".datetimepicker").datetimepicker({
            format:'Y-m-d H:i',
            step:1,
            lang:'kr'
        });
        $.datetimepicker.setLocale('ko');

        $("#frm_ship_detail_cnt").numpad();
        setDatePicker("datepicker");

        // debugger
        if($("#frm_prod_lot_yn").val() === "Y") {
            setTimeout(() => setProdLotData($("#frm_prod_cd").val(), null), 300);
            $("#frm_lot_no").css("display", "block");
        }

        $("#frm_lot_no").on("change", function () {
            let lot_cnt = parseInt($(this).find("option:selected").data("qty"));
            let odr_cnt = parseInt($("#frm_odr_cnt").val().replace(/,/g, ""));
            $("#frm_ship_detail_cnt").val(lot_cnt>=odr_cnt ? odr_cnt : lot_cnt);
        });

        // setTimeout(() => getPlanResultData(), 50);
    }

    function setProdLotData(prod_cd, lot_no=null)
    {
        $.ajax({
            url: "/mes/base/product/prodLotList"
            ,type: "post"
            ,headers: {
                "Content-Type": "application/json"
                ,"X-HTTP-Method-Override": "POST"
            }
            ,dataType: "json"
            ,data: JSON.stringify({
                fact_cd: "${vmap.fact_cd}"
                ,prod_cd: prod_cd
            })
        })
        .done(function (data)
        {
            if(IsNotNull(data)) {
                $("#frm_lot_no option:not(:first)").empty();
                data.forEach((item, index) => {
                    var newOption = "<option value='" + item.lot_no + "' data-qty='" + item.lot_cnt + "'" + ">" + item.lot_no + " [" + item.lot_cnt + "]" + "</option>";
                    $("#frm_lot_no").append(newOption);
                });
            }

            if(IsNotNull(lot_no)) $("#frm_lot_no").val([lot_no]);
        })
        .always(function (data) {
        })
        .fail(function (jqHXR, textStatus, errorThrown) {
            ajaxErrorAlert(jqHXR);
        });
    }

    function shipmentDetailRegistModifyData()
    {
        showWait('.dataModal');

        let ship_detail_cd = $("#frm_ship_detail_cd").val();
        let ship_detail_dt = $("#frm_ship_detail_dt").val();
        let lot_no = $("#frm_lot_no").val();
        let old_lot_no = $("#frm_old_lot_no").val();
        let old_ship_detail_cnt = $("#frm_old_ship_detail_cnt").val();
        let ship_detail_cnt = $("#frm_ship_detail_cnt").val();
        let ship_detail_notice = $("#frm_ship_detail_notice").val();

        if(IsNull(ship_detail_dt)) {
            eAlert("납품일은 필수입력항목입니다.");
            ship_detail_dt.focus();
            return false;
        }

        if(IsNull(ship_detail_cnt)) {
            eAlert("납품수량은 필수입력항목입니다.");
            ship_detail_cnt.focus();
            return false;
        }

        //. Data List
        let ary_ship_detail_cd = [];
        let ary_ship_detail_dt = [];
        let ary_old_lot_no = [];
        let ary_lot_no = [];
        let ary_old_ship_detail_cnt = [];
        let ary_ship_detail_cnt = [];
        let ary_ship_detail_notice = [];

        ary_ship_detail_cd.push(ship_detail_cd);
        ary_ship_detail_dt.push(ship_detail_dt);
        ary_old_lot_no.push(old_lot_no);
        ary_lot_no.push(lot_no);
        ary_old_ship_detail_cnt.push(old_ship_detail_cnt.replace(/,/g, ""));
        ary_ship_detail_cnt.push(ship_detail_cnt.replace(/,/g, ""));
        ary_ship_detail_notice.push(ship_detail_notice);

        $.ajax({
            type: "post"
            ,url: "/mes/sales/shipment/salesShipmentDetailRegistModify"
            ,headers: {
                "Content-Type": "application/json"
                ,"X-HTTP-Method-Override": "POST"
            }
            ,dataType: "text"
            ,data: JSON.stringify({
                fact_cd: "${vmap.fact_cd}"
                ,odr_cd: $("#frm_odr_cd").val()
                ,ship_cd: $("#frm_ship_cd").val()
                ,prod_cd: $("#frm_prod_cd").val()
                ,ary_ship_detail_cd: ary_ship_detail_cd
                ,ary_ship_detail_dt: ary_ship_detail_dt
                ,ary_old_lot_no: ary_old_lot_no
                ,ary_lot_no: ary_lot_no
                ,ary_old_ship_detail_cnt: ary_old_ship_detail_cnt
                ,ary_ship_detail_cnt: ary_ship_detail_cnt
                ,ary_ship_detail_notice: ary_ship_detail_notice
            })
        })
        .done(function (data) {
            hideWait('.dataModal');
            getShipmentDetailData();
            shipResultInit();
        })
        .always(function (data) {

        })
        .fail(function (jqHXR, textStatus, errorThrown) {
            ajaxErrorAlert(jqHXR);
            hideWait('.dataModal');
        });
    }

    function getShipmentDetailData()
    {
        showWait('.dataModal');

        $.ajax({
            url: "/mes/sales/shipment/salesShipmentDetailtList"
            ,type: "post"
            ,headers: {
                "Content-Type": "application/json"
                ,"X-HTTP-Method-Override": "POST"
            }
            ,dataType: "json"
            ,data: JSON.stringify({
                fact_cd: "${vmap.fact_cd}"
                ,odr_cd: $("#frm_odr_cd").val()
                ,ship_cd: $("#frm_ship_cd").val()
                ,isNoDate: "Y"
            })
        })
            .done(function (data)
            {
                $("#tblPopShipmentData > tbody").empty();
                resultRowCnt = 0;

                data.forEach((item, index) => {
                    addPopShipmentDetailRow(item);
                });
            })
            .always(function (data) {
                hideWait('.dataModal');
            })
            .fail(function (jqHXR, textStatus, errorThrown) {
                ajaxErrorAlert(jqHXR);
            });
    }

    // let resultRowCnt = 0;
    function addPopShipmentDetailRow(data)
    {
        let template_html = $("#popSalesShipmentTemplete").html();
        let template = Handlebars.compile(template_html);
        let resultRowCnt = $("#tblPopShipmentData > tbody > tr").length + 1;
        let templateData;

        if(IsNull(data))
        {
            templateData = {
                cnt : resultRowCnt
                ,old_ship_detail_cnt: 0
                ,ship_detail_dt: moment().format("YYYY-MM-DD")
            };

            $("#tblPopShipmentData > tbody").append(template(templateData));
        }
        else
        {
            templateData = {
                cnt : resultRowCnt
                ,...data
                ,old_plot_no: data.plot_no
                ,old_ship_detail_cnt: data.ship_detail_cnt
                ,ship_detail_cnt: data.ship_detail_cnt.comma('3')
            };

            $("#tblPopShipmentData > tbody").append(template(templateData));
        }

        $("#tblPopShipmentData .list_tr" + resultRowCnt).on("click", function(index, item) {
            setResultData($(this));
        });

        // setDatePicker("datepicker");
        // let thisRow = $("#tblPopShipmentData .list_tr" + resultRowCnt);
        //
        // // debugger
        // if($("#pop_prod_lot_yn").val() === "Y") {
        //     setTimeout(() =>
        //         IsNull(data) ? setProdLotData($("#pop_prod_cd").val(), resultRowCnt) : setProdLotData($("#pop_prod_cd").val(), resultRowCnt, data.lot_no)
        //     , 300);
        //
        //     $("#tblPopShipmentData .list_tr" + resultRowCnt).find("select[name=pop_lot_no]").css("display", "block");
        // }
        //
        // thisRow.find("select[name=pop_lot_no]").on("change", function () {
        //     let lot_cnt = parseInt($(this).find("option:selected").data("qty"));
        //     let odr_cnt = parseInt($("#pop_odr_cnt").text().replace(/,/g, ""));
        //     thisRow.find("[name=pop_ship_detail_cnt]").val(lot_cnt>=odr_cnt ? odr_cnt : lot_cnt);
        // });
        //
        // thisRow.find("input[name$='cnt'], input[name$='price'], input[name$='amt'], input[name$='total'], input[name$='rate'], input[name$='min'], input[name$='vat']")
        //         .css("text-align", "right")
        //         .on("click", function() {
        //             $(this).select();
        //         })
        //         .on("keyup", function() {
        //             $(this).val($(this).val().comma("2"));
        //         });
    }

    function setResultData(el) {
        $("#frm_ship_detail_cd").val(el.find("[name=pop_ship_detail_cd]").val());
        $("#frm_ship_detail_dt").val(el.find("[name=pop_ship_detail_dt]").val());
        $("#frm_lot_no").val(el.find("[name=pop_old_lot_no]").val());
        $("#frm_old_lot_no").val(el.find("[name=pop_lot_no]").val());
        $("#frm_old_ship_detail_cnt").val(el.find("[name=pop_old_ship_detail_cnt]").val().replace(/,/g, ""));
        $("#frm_ship_detail_cnt").val(el.find("[name=pop_ship_detail_cnt]").val().replace(/,/g, ""));
        $("#frm_ship_detail_notice").val(el.find("[name=pop_ship_detail_notice]").val());
    }

    function shipResultInit() {
        $("#frm_ship_detail_cd").val("");
        $("#frm_ship_detail_dt").val("");
        $("#frm_lot_no").val("");
        $("#frm_old_lot_no").val("");
        $("#frm_old_ship_detail_cnt").val("0");
        $("#frm_ship_detail_cnt").val("");
        $("#frm_ship_detail_notice").val("");
    }

</script>

<%@ include file="/WEB-INF/include/tablet-footer.jspf" %>

