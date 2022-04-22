package com.ksr.webapp.mes.material.purchase;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PurchaseKey implements Serializable {

    private String fact_cd;
    private String pur_cd;

}
