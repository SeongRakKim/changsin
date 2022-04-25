package com.ksr.webapp.mes.production.plan;

import com.ksr.webapp.mes.base.product.ProductKey;
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
@Table(name="mes_production_plan")
@IdClass(ProductionPlanKey.class)
public class ProductionPlan {

    @Id
    private String fact_cd;

    @Id
    private String plan_cd;

    private String odr_cd;
    private String plan_no;
    private String comp_cd;
    private String prod_cd;
    private String plan_stdt;
    private String plan_eddt;
    private String plan_cnt;
    private String plan_state;
    private String plan_notice;
    private String plan_indate;
    private String plan_inuser;
    private String plan_update;
    private String plan_upuser;

}
