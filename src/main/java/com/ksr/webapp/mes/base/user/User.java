package com.ksr.webapp.mes.base.user;

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
@Table(name="mes_user_info")
@IdClass(UserKey.class)
public class User {

    private static final String PROCEDURE_PARAM = "USER";

    @Id
    private String fact_cd;

    @Id
    private String u_cd;

    private String u_pw;
    private String u_nm;
    private String dept_cd;
    private String grade_cd;
    private String u_addr;
    private String u_tel;
    private String u_mail;
    private String u_indt;
    private String u_outdt;
    private String u_yn;
    private String u_notice;
    private String u_indate;
    private String u_inuser;
    private String u_update;
    private String u_upuser;

}
