package com.ksr.webapp.mes.base.department;

import com.ksr.webapp.common.config.SeqGenerator;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Entity
@Data
@Table(name="mes_department_info")
public class Department {

    private static final String PROCEDURE_PARAM = "DEPT";


//    @Id
//    private String fact_cd;

    @Id
    @GenericGenerator(name="keyGenerator"
                    , strategy = "com.ksr.webapp.common.config.SeqGenerator"
                    , parameters = @org.hibernate.annotations.Parameter(name = SeqGenerator.SEQ_GENERATOR_PARAM_KEY, value = PROCEDURE_PARAM))
    @GeneratedValue(generator = "keyGenerator")
//    @Column(name="dpot_cd")
    private String dept_cd;

    private String dept_nm;

    private String dept_notice;

}
