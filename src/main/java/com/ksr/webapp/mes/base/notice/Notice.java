package com.ksr.webapp.mes.base.notice;

import lombok.*;

import javax.persistence.*;

//@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Getter
@Setter
@Entity
@Data
@Builder
@Table(name="mes_notice_info")
public class Notice {

    private static final String PROCEDURE_PARAM = "NOTICE";

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private String notice_cd;
    private String notice_title;
    private String notice_content;
    private String notice_stdt;
    private String notice_eddt;
    private String notice_indate;
    private String notice_inuser;
    private String notice_update;
    private String notice_upuser;

    public Notice(String notice_cd, String notice_title, String notice_content, String notice_stdt, String notice_eddt, String notice_indate, String notice_inuser, String notice_update, String notice_upuser) {
        this.notice_cd = notice_cd;
        this.notice_title = notice_title;
        this.notice_content = notice_content;
        this.notice_stdt = notice_stdt;
        this.notice_eddt = notice_eddt;
        this.notice_indate = notice_indate;
        this.notice_inuser = notice_inuser;
        this.notice_update = notice_update;
        this.notice_upuser = notice_upuser;
    }
}
