package com.ksr.webapp.mes.sales.shipment;

import com.ksr.webapp.mes.sales.order.OrderKey;
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
@Table(name="mes_ship_info")
@IdClass(ShipmentKey.class)
public class Shipment {

    @Id
    private String fact_cd;

    @Id
    private String odr_cd;

    @Id
    private String ship_cd;

    private String ship_dt;
    private String ship_cnt;
    private String ship_state;
    private String ship_notice;
    private String ship_quality_yn;
    private String ship_quality_cd;
    private String ship_quality_val;
    private String ship_indate;
    private String ship_inuser;
    private String ship_update;
    private String ship_upuser;

}
