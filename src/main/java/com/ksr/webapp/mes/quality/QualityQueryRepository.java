package com.ksr.webapp.mes.quality;

import com.ksr.webapp.common.vo.VMap;
import com.ksr.webapp.mes.base.code.Code;
import com.ksr.webapp.mes.base.code.QCode;
import com.ksr.webapp.mes.base.company.QCompany;
import com.ksr.webapp.mes.base.grade.GradeRepository;
import com.ksr.webapp.mes.base.product.QProduct;
import com.ksr.webapp.mes.material.purchase.QPurchase;
import com.querydsl.core.types.ExpressionUtils;
import com.querydsl.core.types.Projections;
import com.querydsl.jpa.JPAExpressions;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;
import org.hibernate.criterion.Projection;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import java.util.List;

@RequiredArgsConstructor
@Repository
public class QualityQueryRepository {

    private final JPAQueryFactory queryFactory;
    private final GradeRepository gradeRepository;
    private final EntityManager em;

    private final QPurchase purchase = QPurchase.purchase;
    private final QProduct product = QProduct.product;
    private final QCompany company = QCompany.company;
    private final QCode code = QCode.code;


    @Transactional
    public List<PurchaseQualityData> materialInspectList(VMap vmap) {
        return queryFactory
                    .select(Projections.bean(PurchaseQualityData.class,
                            purchase.fact_cd
                            ,purchase.pur_cd
                            ,purchase.comp_cd
                            ,purchase.prod_cd
                            ,purchase.pur_dt
                            ,purchase.pur_ship_dt
                            ,purchase.pur_cnt
                            ,purchase.pur_price
                            ,purchase.pur_amt
                            ,purchase.pur_vat
                            ,purchase.pur_vat_yn
                            ,purchase.pur_in_dt
                            ,purchase.pur_in_cnt
                            ,purchase.pur_state
                            ,purchase.pur_notice
                            ,purchase.pur_quality_yn
                            ,purchase.pur_quality_cd
                            ,purchase.pur_quality_val
                            ,product.prod_pn
                            ,product.prod_nm
                            ,company.comp_nm
                            ,ExpressionUtils.as(
                                    JPAExpressions
                                            .select(Projections.fields(Code.class,
                                                    code.code_nm.as("prod_kind_nm")))
                                            .from(code)
                                            .where(code.code_id.eq("PROD_KIND").and(code.code_cd.eq(product.prod_kind)))
                            , "prod_kind_nm")
                            ))
                    .from(purchase)
                    .leftJoin(product).on(purchase.prod_cd.eq(product.prod_cd)).fetchJoin()
                    .leftJoin(company).on(purchase.comp_cd.eq(company.comp_cd)).fetchJoin()
                    .fetch();
    }

//    @Transactional
//    public void gradeRegistModify(VMap vmap) {
//
//        List<String> grade_cd =  (List<String>)vmap.get("ary_grade_cd");
//        List<String> grade_nm =  (List<String>)vmap.get("ary_grade_nm");
//
//        List<Grade> registList = new ArrayList<>();
//
//        for(int i=0; i<grade_cd.size(); i++)
//        {
//            LocalDateTime now = LocalDateTime.now();
//            DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss");
//            String nowString = now.format(dateTimeFormatter);
//
//            registList.add(new Grade(grade_cd.get(i)
//                    ,grade_nm.get(i)
//                    ,CommonUtils.isEmpty(vmap.getString("u_cd")) ? "admin" : vmap.getString("u_cd")
//                    ,CommonUtils.isEmpty(vmap.getString("u_cd")) ? "admin" : vmap.getString("u_cd")
//                    ,nowString
//                    ,nowString
//            ));
//        }
//
//        gradeRepository.saveAll(registList);
//    }
//
//    @Transactional
//    public void gradeDelete(VMap vmap) {
//
//        queryFactory.delete(qGrade)
//                .where(qGrade.grade_cd.eq(vmap.getString("grade_cd")))
//                .execute();
//
//    }

}
