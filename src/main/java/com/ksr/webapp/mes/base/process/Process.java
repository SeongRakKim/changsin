package com.ksr.webapp.mes.base.process;

import com.ksr.webapp.mes.base.product.ProductKey;
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
@Table(name="mes_process_info")
@IdClass(ProcessKey.class)
public class Process {

    private static final String PROCEDURE_PARAM = "PROCESS";

    @Id
    private String fact_cd;

    @Id
    private String proc_cd;

    private String proc_nm;
    private String proc_rate;
    private String proc_yn;
    private String proc_notice;
    private String proc_indate;
    private String proc_inuser;
    private String proc_update;
    private String proc_upuser;

}
