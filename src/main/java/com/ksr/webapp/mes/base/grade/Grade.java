package com.ksr.webapp.mes.base.grade;

import lombok.*;

import javax.persistence.*;

//@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Getter
@Setter
@Entity
@Data
@Builder
@Table(name="mes_grade_info")
public class Grade {

    private static final String PROCEDURE_PARAM = "GRADE";

    @Id
//    @GenericGenerator(name="keyGenerator"
//                    , strategy = "com.ksr.webapp.common.config.SeqGenerator"
//                    , parameters = @org.hibernate.annotations.Parameter(name = SeqGenerator.SEQ_GENERATOR_PARAM_KEY, value = PROCEDURE_PARAM))
//    @GeneratedValue(generator = "keyGenerator")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private String grade_cd;
    private String grade_nm;
    private String grade_inuser;
    private String grade_upuser;

//    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private String grade_indate;

//    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private String grade_update;

    public Grade(String grade_cd, String grade_nm, String grade_inuser, String grade_upuser, String grade_indate, String grade_update) {
        this.grade_cd = grade_cd;
        this.grade_nm = grade_nm;
        this.grade_inuser = grade_inuser;
        this.grade_upuser = grade_upuser;
        this.grade_indate = grade_indate;
        this.grade_update = grade_update;
    }
}
