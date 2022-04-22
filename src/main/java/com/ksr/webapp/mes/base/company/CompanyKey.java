package com.ksr.webapp.mes.base.company;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CompanyKey implements Serializable {

    private String fact_cd;
    private String comp_cd;

}
