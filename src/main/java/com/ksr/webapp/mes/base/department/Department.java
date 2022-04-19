package com.ksr.webapp.mes.base.department;

import com.ksr.webapp.common.config.SeqGenerator;
import lombok.*;
import org.hibernate.annotations.GenericGenerator;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

//@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Getter
@Setter
@Entity
@Data
@Builder
@Table(name="mes_department_info")
public class Department {

    private static final String PROCEDURE_PARAM = "DEPT";

    @Id
//    @GenericGenerator(name="keyGenerator"
//                    , strategy = "com.ksr.webapp.common.config.SeqGenerator"
//                    , parameters = @org.hibernate.annotations.Parameter(name = SeqGenerator.SEQ_GENERATOR_PARAM_KEY, value = PROCEDURE_PARAM))
//    @GeneratedValue(generator = "keyGenerator")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private String dept_cd;
    private String dept_nm;
    private String dept_inuser;
    private String dept_upuser;

//    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private String dept_indate;

//    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private String dept_update;

    public Department(String dept_cd, String dept_nm, String dept_inuser, String dept_upuser, String dept_indate, String dept_update) {
        this.dept_cd = dept_cd;
        this.dept_nm = dept_nm;
        this.dept_inuser = dept_inuser;
        this.dept_upuser = dept_upuser;
        this.dept_indate = dept_indate;
        this.dept_update = dept_update;
    }
}
