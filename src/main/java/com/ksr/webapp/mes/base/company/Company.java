package com.ksr.webapp.mes.base.company;

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
@Table(name="mes_company_info")
@IdClass(CompanyKey.class)
public class Company {

    private static final String PROCEDURE_PARAM = "COMPANY";

    @Id
    private String fact_cd;

    @Id
//    @GenericGenerator(name="keyGenerator"
//                    , strategy = "com.ksr.webapp.common.config.SeqGenerator"
//                    , parameters = @org.hibernate.annotations.Parameter(name = SeqGenerator.SEQ_GENERATOR_PARAM_KEY, value = PROCEDURE_PARAM))
//    @GeneratedValue(generator = "keyGenerator")
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private String comp_cd;

    private String comp_nm;
    private String comp_type;
    private String comp_group;
    private String comp_busin_num;
    private String comp_ceo;
    private String comp_busin_stat;
    private String comp_busin_kind;
    private String comp_tel;
    private String comp_fax;
    private String comp_address;
    private String comp_email;
    private String comp_mana;
    private String comp_mana_tel;
    private String comp_yn;
    private String comp_notice;
    private String comp_indate;
    private String comp_inuser;
    private String comp_update;
    private String comp_upuser;

}
