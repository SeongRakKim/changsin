package com.ksr.webapp.mes.sales.order;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderKey implements Serializable {

    private String fact_cd;
    private String odr_cd;

}
