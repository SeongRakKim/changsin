package com.ksr.webapp.mes.base.product;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductKey implements Serializable {

    private String fact_cd;
    private String prod_cd;

}
