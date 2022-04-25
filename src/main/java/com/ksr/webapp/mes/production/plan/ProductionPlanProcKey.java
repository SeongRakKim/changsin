package com.ksr.webapp.mes.production.plan;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductionPlanProcKey implements Serializable {

    private String fact_cd;
    private String plan_cd;
    private String plan_proc_cd;

}
