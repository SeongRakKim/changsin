package com.ksr.webapp.mes.quality;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ShipmentQualityData {

    private String fact_cd;
    private String odr_cd;
    private String ship_cd;
    private String ship_dt;
    private String ship_cnt;
    private String ship_state;
    private String ship_quality_yn;
    private String ship_quality_cd;
    private String ship_quality_nm;
    private String ship_quality_val;
    private String ship_notice;
    private String ship_indate;
    private String ship_inuser;
    private String ship_update;
    private String ship_upuser;

    private String comp_cd;
    private String comp_nm;

    private String prod_cd;
    private String prod_pn;
    private String prod_nm;
    private String prod_stand;
    private String prod_kind_nm;
    private String prod_group_nm;
    private String prod_family_nm;
    private String prod_unit_nm;

    private String code_nm;

}
