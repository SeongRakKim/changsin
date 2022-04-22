package com.ksr.webapp.mes.base.basecode;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BaseDetailKey implements Serializable {

    private String fact_cd;
    private String base_cd;
    private String base_detail_cd;

}
