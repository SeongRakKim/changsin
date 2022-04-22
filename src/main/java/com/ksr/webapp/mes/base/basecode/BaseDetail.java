package com.ksr.webapp.mes.base.basecode;

import com.ksr.webapp.mes.base.code.CodeKey;
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
@Table(name="dft_base_detail")
@IdClass(BaseDetailKey.class)
public class BaseDetail {

    private static final String PROCEDURE_PARAM = "BASEDETAIL";

    @Id
    private String fact_cd;

    @Id
    private String base_cd;

    @Id
    private String base_detail_cd;

    private String base_detail_nm;
    private String base_detail_yn;
    private String base_detail_nt;
    private String base_detail_indate;
    private String base_detail_inuser;
    private String base_detail_update;
    private String base_detail_upuser;

}
