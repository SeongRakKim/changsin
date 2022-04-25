package com.ksr.webapp.mes.production.plan;

import lombok.*;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.Table;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Entity
@Data
@Builder
@Table(name="mes_production_plan_process")
@IdClass(ProductionPlanProcKey.class)
public class ProductionPlanProc {

    @Id
    private String fact_cd;

    @Id
    private String plan_cd;

    @Id
    private String plan_proc_cd;

    private String proc_cd;
    private String plan_proc_seq;
    private String plan_proc_last_yn;
    private String plan_proc_cnt;
    private String plan_proc_state;
    private String plan_proc_quality_yn;
    private String plan_proc_quality_cd;
    private String plan_proc_quality_val;
    private String plan_proc_notice;
    private String plan_proc_indate;
    private String plan_proc_inuser;
    private String plan_proc_update;
    private String plan_proc_upuser;

}
