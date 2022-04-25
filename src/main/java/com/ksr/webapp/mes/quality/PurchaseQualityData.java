package com.ksr.webapp.mes.quality;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PurchaseQualityData {

    private String fact_cd;
    private String pur_cd;
    private String comp_cd;
    private String prod_cd;
    private String pur_dt;
    private String pur_ship_dt;
    private Double pur_cnt;
    private Double pur_price;
    private Integer pur_amt;
    private Integer pur_vat;
    private String pur_vat_yn;
    private String pur_in_dt;
    private Double pur_in_cnt;
    private String pur_state;
    private String pur_notice;
    private String pur_indate;
    private String pur_inuser;
    private String pur_update;
    private String pur_upuser;
    private String pur_quality_yn;
    private String pur_quality_cd;
    private String pur_quality_nm;
    private String pur_quality_val;

    private String prod_pn;
    private String prod_nm;
    private String prod_stand;
    private String comp_nm;
    private String code_nm;
    private String prod_kind_nm;
    private String prod_group_nm;
    private String prod_family_nm;
    private String prod_unit_nm;
    private String pur_state_nm;


}
