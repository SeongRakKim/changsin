package com.ksr.webapp.mes.base.product;

import lombok.*;

import javax.persistence.*;
import java.io.Serializable;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Entity
@Data
@Builder
@Table(name="mes_product_info")
@IdClass(ProductKey.class)
public class Product {

    private static final String PROCEDURE_PARAM = "PRODUCT";

    @Id
    private String fact_cd;

    @Id
//    @GenericGenerator(name="keyGenerator"
//                    , strategy = "com.ksr.webapp.common.config.SeqGenerator"
//                    , parameters = @org.hibernate.annotations.Parameter(name = SeqGenerator.SEQ_GENERATOR_PARAM_KEY, value = PROCEDURE_PARAM))
//    @GeneratedValue(generator = "keyGenerator")
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private String prod_cd;

    private String prod_pn;
    private String prod_nm;
    private String prod_cls;
    private String prod_kind;
    private String prod_group;
    private String prod_family;
    private String prod_stand;
    private String prod_unit;
    private Integer prod_price;
    private String prod_main_group;
    private Double prod_keep_cnt;
    private Double prod_stock_cnt;
    private String prod_yn;
    private String prod_mass_yn;
    private String prod_notice;
    private String prod_indate;
    private String prod_inuser;
    private String prod_update;
    private String prod_upuser;

}
