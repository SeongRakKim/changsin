package com.ksr.webapp.mes.base.user;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserKey implements Serializable {

    private String fact_cd;
    private String u_cd;

}
