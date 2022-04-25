package com.ksr.webapp.mes.base.process;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProcessKey implements Serializable {

    private String fact_cd;
    private String proc_cd;

}
