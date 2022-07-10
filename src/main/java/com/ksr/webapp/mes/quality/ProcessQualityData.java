package com.ksr.webapp.mes.quality;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProcessQualityData {

    private String fact_cd;
    private String plan_cd;
    private String plan_no;
    private String plan_stdt;
    private String plan_eddt;
    private String plan_cnt;
    private String plan_proc_cd;
    private String plan_proc_cnt;
    private String plan_proc_quality_yn;
    private String plan_proc_quality_cd;
    private String plan_proc_quality_nm;
    private String plan_proc_quality_val;
    private String plan_proc_quality_cnt;

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

    private String proc_cd;
    private String proc_nm;

    private String code_nm;

}
