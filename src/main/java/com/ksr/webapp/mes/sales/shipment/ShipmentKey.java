package com.ksr.webapp.mes.sales.shipment;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ShipmentKey implements Serializable {

    private String fact_cd;
    private String odr_cd;
    private String ship_cd;

}
