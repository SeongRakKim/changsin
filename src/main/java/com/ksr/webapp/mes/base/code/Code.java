package com.ksr.webapp.mes.base.code;

import com.ksr.webapp.mes.base.company.CompanyKey;
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
@Table(name="dft_code_info")
@IdClass(CodeKey.class)
public class Code {

    private static final String PROCEDURE_PARAM = "CODE";

    @Id
    private String code_id;

    @Id
    private String code_cd;

    private String code_nm;
    private String code_seq;
    private String code_etc;
    private String code_indate;
    private String code_inuser;
    private String code_update;
    private String code_upuser;

}
