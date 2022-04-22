package com.ksr.webapp.mes.base.code;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CodeKey implements Serializable {

    private String code_id;
    private String code_cd;

}
