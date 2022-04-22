package com.ksr.webapp.mes.material.purchase;

import com.ksr.webapp.mes.base.product.ProductKey;
import lombok.*;
import org.springframework.lang.Nullable;

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
@Table(name="mes_purchase_info")
@IdClass(PurchaseKey.class)
public class Purchase {

    private static final String PROCEDURE_PARAM = "PURCHASE";

    @Id
    private String fact_cd;

    @Id
//    @GenericGenerator(name="keyGenerator"
//                    , strategy = "com.ksr.webapp.common.config.SeqGenerator"
//                    , parameters = @org.hibernate.annotations.Parameter(name = SeqGenerator.SEQ_GENERATOR_PARAM_KEY, value = PROCEDURE_PARAM))
//    @GeneratedValue(generator = "keyGenerator")
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private String pur_cd;

    private String comp_cd;
    private String prod_cd;
    private String pur_dt;
    private String pur_ship_dt;
    private Double pur_cnt;
    private Double pur_price;
    private Integer pur_amt;
    private Integer pur_vat;
    private String pur_vat_yn;
    private String pur_in_dt;
    private Double pur_in_cnt;
    private String pur_state;
    private String pur_notice;
    private String pur_indate;
    private String pur_inuser;
    private String pur_update;
    private String pur_upuser;
    private String pur_quality_yn;
    private String pur_quality_cd;
    private String pur_quality_val;

}
