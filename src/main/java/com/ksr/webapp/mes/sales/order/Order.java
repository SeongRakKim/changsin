package com.ksr.webapp.mes.sales.order;

import com.ksr.webapp.mes.production.plan.ProductionPlanKey;
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
@Table(name="mes_order_info")
@IdClass(OrderKey.class)
public class Order {

    @Id
    private String fact_cd;

    @Id
    private String odr_cd;

    private String comp_cd;
    private String prod_cd;
    private String odr_dt;
    private String odr_ship_dt;
    private String odr_cnt;
    private String odr_price;
    private String odr_amt;
    private String odr_vat;
    private String odr_vat_yn;
    private String odr_nm;
    private String odr_tel;
    private String odr_project;
    private String odr_state;
    private String odr_notice;
    private String odr_indate;
    private String odr_inuser;
    private String odr_update;
    private String odr_upuser;

}
