package com.ksr.webapp.mes.quality;

import com.ksr.webapp.common.util.CommonUtils;
import com.ksr.webapp.common.vo.VMap;
import com.ksr.webapp.mes.base.basecode.QBaseDetail;
import com.ksr.webapp.mes.base.code.Code;
import com.ksr.webapp.mes.base.code.QCode;
import com.ksr.webapp.mes.base.company.QCompany;
import com.ksr.webapp.mes.base.grade.GradeRepository;
import com.ksr.webapp.mes.base.process.QProcess;
import com.ksr.webapp.mes.base.product.QProduct;
import com.ksr.webapp.mes.material.purchase.QPurchase;
import com.ksr.webapp.mes.production.plan.QProductionPlan;
import com.ksr.webapp.mes.production.plan.QProductionPlanProc;
import com.ksr.webapp.mes.sales.order.QOrder;
import com.ksr.webapp.mes.sales.shipment.QShipment;
import com.querydsl.core.BooleanBuilder;
import com.querydsl.core.types.ExpressionUtils;
import com.querydsl.core.types.Projections;
import com.querydsl.core.types.dsl.BooleanExpression;
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

    private final QPurchase purchase = QPurchase.purchase;
    private final QProductionPlan productionPlan = QProductionPlan.productionPlan;
    private final QProductionPlanProc productionPlanProc = QProductionPlanProc.productionPlanProc;
    private final QOrder order = QOrder.order;
    private final QShipment shipment = QShipment.shipment;
    private final QProduct product = QProduct.product;
    private final QProcess process = QProcess.process;
    private final QCompany company = QCompany.company;
    private final QCode code = new QCode("code1");
    private final QCode code2 = new QCode("code2");
    private final QBaseDetail baseDetail = new QBaseDetail("baseDetail");
    private final QBaseDetail baseDetail2 = new QBaseDetail("baseDetail2");
    private final QBaseDetail baseDetail3 = new QBaseDetail("baseDetail3");
    private final QBaseDetail baseDetail4 = new QBaseDetail("baseDetail4");

    @Transactional
    public List<PurchaseQualityData> materialInspectList(VMap vmap) {

        BooleanBuilder builder = new BooleanBuilder();

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
                            ,product.prod_stand
                            ,company.comp_nm
                            ,code.code_nm.as("prod_kind_nm")
                            ,code2.code_nm.as("pur_state_nm")
                            ,baseDetail.base_detail_nm.as("prod_group_nm")
                            ,baseDetail2.base_detail_nm.as("prod_family_nm")
                            ,baseDetail3.base_detail_nm.as("prod_unit_nm")
                            ,baseDetail4.base_detail_nm.as("pur_quality_nm")
                            ))
                    .from(purchase)
                    .leftJoin(product).on(purchase.prod_cd.eq(product.prod_cd)).fetchJoin()
                    .leftJoin(company).on(purchase.comp_cd.eq(company.comp_cd)).fetchJoin()
                    .leftJoin(code).on(code.code_id.eq("PROD_KIND").and(code.code_cd.eq(product.prod_kind))).fetchJoin()
                    .leftJoin(code2).on(code2.code_id.eq("MES_STATE").and(code2.code_cd.eq(purchase.pur_state))).fetchJoin()
                    .leftJoin(baseDetail).on(baseDetail.base_detail_cd.eq(product.prod_group)).fetchJoin()
                    .leftJoin(baseDetail2).on(baseDetail2.base_detail_cd.eq(product.prod_family)).fetchJoin()
                    .leftJoin(baseDetail3).on(baseDetail3.base_detail_cd.eq(product.prod_unit)).fetchJoin()
                    .leftJoin(baseDetail4).on(baseDetail4.base_detail_cd.eq(purchase.pur_quality_cd)).fetchJoin()
                    .where(dateTypeBetween(vmap)
                            ,prodFamilyEq(vmap)
                            ,prodGroupEq(vmap)
                            ,prodKindEq(vmap)
                            ,prodSearchLike(vmap))
                    .orderBy(purchase.pur_dt.desc())
                    .fetch();
    }

    private BooleanExpression dateTypeBetween(VMap vmap) {

        if(CommonUtils.isEmpty(vmap.getString("date_type"))) {
            return null;
        }

        BooleanExpression returnVal;

        if(vmap.getString("date_type").equals("PUR_DT")) {
            returnVal = purchase.pur_dt.between(vmap.getString("startDate"), vmap.getString("endDate"));
        }else {
            returnVal = purchase.pur_ship_dt.between(vmap.getString("startDate"), vmap.getString("endDate"));
        }

        return returnVal;
    }

    private BooleanExpression planStdtBetween(VMap vmap) {
        return productionPlan.plan_stdt.between(vmap.getString("startDate"), vmap.getString("endDate"));
    }

    private BooleanExpression odrDtBetween(VMap vmap) {
        return order.odr_dt.between(vmap.getString("startDate"), vmap.getString("endDate"));
    }

    private BooleanExpression planStateEq(VMap vmap) {
        return productionPlanProc.plan_proc_state.eq(vmap.getString("mes_state"));
    }

    private BooleanExpression prodFamilyEq(VMap vmap) {

        if(CommonUtils.isEmpty(vmap.getString("prod_family"))) {
            return null;
        }

        return product.prod_family.eq(vmap.getString("prod_family"));
    }

    private BooleanExpression prodGroupEq(VMap vmap) {

        if(CommonUtils.isEmpty(vmap.getString("prod_group"))) {
            return null;
        }

        return product.prod_group.eq(vmap.getString("prod_group"));
    }

    private BooleanExpression prodKindEq(VMap vmap) {

        if(CommonUtils.isEmpty(vmap.getString("prod_kind"))) {
            return null;
        }

        return product.prod_kind.eq(vmap.getString("prod_kind"));
    }

    private BooleanExpression prodSearchLike(VMap vmap) {

        if(CommonUtils.isEmpty(vmap.getString("search_text"))) {
            return null;
        }

        return product.prod_cd.contains(vmap.getString("search_text"))
                .or(product.prod_pn.contains(vmap.getString("search_text")))
                .or(product.prod_nm.contains(vmap.getString("search_text")))
                .or(company.comp_nm.contains(vmap.getString("search_text")))
                .or(baseDetail.base_detail_nm.contains(vmap.getString("search_text")))
                .or(baseDetail2.base_detail_nm.contains(vmap.getString("search_text")));
    }


    @Transactional
    public void materialQualityModify(VMap vmap) {
        queryFactory.update(purchase)
                .set(purchase.pur_quality_yn, vmap.getString("pur_quality_yn"))
                .set(purchase.pur_quality_cd, vmap.getString("pur_quality_cd"))
                .set(purchase.pur_quality_val, vmap.getString("pur_quality_val"))
                .where(purchase.pur_cd.eq(vmap.getString("pur_cd")))
                .execute();
    }


    @Transactional
    public List<ProcessQualityData> processInspectList(VMap vmap) {

        return queryFactory
                .select(Projections.bean(ProcessQualityData.class,
                        productionPlanProc.plan_cd
                        ,productionPlanProc.plan_proc_cd
                        ,productionPlanProc.plan_proc_cnt
                        ,productionPlanProc.plan_proc_quality_yn.coalesce("N").as("plan_proc_quality_yn")
                        ,productionPlanProc.plan_proc_quality_cd
                        ,productionPlanProc.plan_proc_quality_val
                        ,productionPlan.plan_no
                        ,productionPlan.plan_stdt
                        ,productionPlan.plan_eddt
                        ,productionPlan.plan_cnt
                        ,productionPlan.plan_state
                        ,product.prod_pn
                        ,product.prod_nm
                        ,product.prod_stand
                        ,process.proc_nm
                        ,company.comp_nm
                        ,code.code_nm.as("prod_kind_nm")
                        ,baseDetail.base_detail_nm.as("prod_group_nm")
                        ,baseDetail2.base_detail_nm.as("prod_family_nm")
                        ,baseDetail3.base_detail_nm.as("prod_unit_nm")
                        ,baseDetail4.base_detail_nm.as("plan_proc_quality_nm")
                ))
                .from(productionPlanProc)
                .leftJoin(productionPlan).on(productionPlan.plan_cd.eq(productionPlanProc.plan_cd)).fetchJoin()
                .leftJoin(process).on(productionPlanProc.proc_cd.eq(process.proc_cd)).fetchJoin()
                .leftJoin(product).on(productionPlan.prod_cd.eq(product.prod_cd)).fetchJoin()
                .leftJoin(company).on(productionPlan.comp_cd.eq(company.comp_cd)).fetchJoin()
                .leftJoin(code).on(code.code_id.eq("PROD_KIND").and(code.code_cd.eq(product.prod_kind))).fetchJoin()
                .leftJoin(baseDetail).on(baseDetail.base_detail_cd.eq(product.prod_group)).fetchJoin()
                .leftJoin(baseDetail2).on(baseDetail2.base_detail_cd.eq(product.prod_family)).fetchJoin()
                .leftJoin(baseDetail3).on(baseDetail3.base_detail_cd.eq(product.prod_unit)).fetchJoin()
                .leftJoin(baseDetail4).on(baseDetail4.base_detail_cd.eq(productionPlanProc.plan_proc_quality_cd)).fetchJoin()
                .where(planStdtBetween(vmap)
                        ,planStateEq(vmap)
                        ,prodFamilyEq(vmap)
                        ,prodGroupEq(vmap)
                        ,prodKindEq(vmap)
                        ,prodSearchLike(vmap))
                .orderBy(productionPlan.plan_stdt.desc())
                .fetch();
    }

    @Transactional
    public ProcessQualityData processInspectOne(VMap vmap) {

        return queryFactory
                .select(Projections.bean(ProcessQualityData.class,
                        productionPlanProc.plan_cd
                        ,productionPlanProc.plan_proc_cd
                        ,productionPlanProc.plan_proc_cnt
                        ,productionPlanProc.plan_proc_quality_yn.coalesce("N").as("plan_proc_quality_yn")
                        ,productionPlanProc.plan_proc_quality_cd
                        ,productionPlanProc.plan_proc_quality_val
                        ,productionPlan.plan_no
                        ,productionPlan.plan_stdt
                        ,productionPlan.plan_eddt
                        ,productionPlan.plan_cnt
                        ,productionPlan.plan_state
                        ,product.prod_pn
                        ,product.prod_nm
                        ,product.prod_stand
                        ,process.proc_nm
                        ,company.comp_nm
                        ,code.code_nm.as("prod_kind_nm")
                        ,baseDetail.base_detail_nm.as("prod_group_nm")
                        ,baseDetail2.base_detail_nm.as("prod_family_nm")
                        ,baseDetail3.base_detail_nm.as("prod_unit_nm")
                        ,baseDetail4.base_detail_nm.as("plan_proc_quality_nm")
                ))
                .from(productionPlanProc)
                .leftJoin(productionPlan).on(productionPlan.plan_cd.eq(productionPlanProc.plan_cd)).fetchJoin()
                .leftJoin(process).on(productionPlanProc.proc_cd.eq(process.proc_cd)).fetchJoin()
                .leftJoin(product).on(productionPlan.prod_cd.eq(product.prod_cd)).fetchJoin()
                .leftJoin(company).on(productionPlan.comp_cd.eq(company.comp_cd)).fetchJoin()
                .leftJoin(code).on(code.code_id.eq("PROD_KIND").and(code.code_cd.eq(product.prod_kind))).fetchJoin()
                .leftJoin(baseDetail).on(baseDetail.base_detail_cd.eq(product.prod_group)).fetchJoin()
                .leftJoin(baseDetail2).on(baseDetail2.base_detail_cd.eq(product.prod_family)).fetchJoin()
                .leftJoin(baseDetail3).on(baseDetail3.base_detail_cd.eq(product.prod_unit)).fetchJoin()
                .leftJoin(baseDetail4).on(baseDetail4.base_detail_cd.eq(productionPlanProc.plan_proc_quality_cd)).fetchJoin()
                .where(productionPlanProc.plan_cd.eq(vmap.getString("plan_cd")).and(productionPlanProc.plan_proc_cd.eq(vmap.getString("plan_proc_cd"))))
                .fetchOne();
    }

    @Transactional
    public void processQualityModify(VMap vmap) {
        queryFactory.update(productionPlanProc)
                .set(productionPlanProc.plan_proc_quality_yn, vmap.getString("plan_proc_quality_yn"))
                .set(productionPlanProc.plan_proc_quality_cd, vmap.getString("plan_proc_quality_cd"))
                .set(productionPlanProc.plan_proc_quality_val, vmap.getString("plan_proc_quality_val"))
                .where(productionPlanProc.plan_cd.eq(vmap.getString("plan_cd")).and(productionPlanProc.plan_proc_cd.eq(vmap.getString("plan_proc_cd"))))
                .execute();
    }

    @Transactional
    public List<ShipmentQualityData> shipmentInspectList(VMap vmap) {

        return queryFactory
                .select(Projections.bean(ShipmentQualityData.class,
                        shipment.odr_cd
                        ,shipment.ship_cd
                        ,shipment.ship_dt
                        ,shipment.ship_cnt
                        ,shipment.ship_quality_yn.coalesce("N").as("ship_quality_yn")
                        ,shipment.ship_quality_cd
                        ,shipment.ship_quality_val
                        ,product.prod_pn
                        ,product.prod_nm
                        ,product.prod_stand
                        ,company.comp_nm
                        ,code.code_nm.as("prod_kind_nm")
                        ,baseDetail.base_detail_nm.as("prod_group_nm")
                        ,baseDetail2.base_detail_nm.as("prod_family_nm")
                        ,baseDetail3.base_detail_nm.as("prod_unit_nm")
                        ,baseDetail4.base_detail_nm.as("ship_quality_nm")
                ))
                .from(shipment)
                .leftJoin(order).on(order.odr_cd.eq(shipment.odr_cd))
                .leftJoin(product).on(order.prod_cd.eq(product.prod_cd)).fetchJoin()
                .leftJoin(company).on(order.comp_cd.eq(company.comp_cd)).fetchJoin()
                .leftJoin(code).on(code.code_id.eq("PROD_KIND").and(code.code_cd.eq(product.prod_kind))).fetchJoin()
                .leftJoin(baseDetail).on(baseDetail.base_detail_cd.eq(product.prod_group)).fetchJoin()
                .leftJoin(baseDetail2).on(baseDetail2.base_detail_cd.eq(product.prod_family)).fetchJoin()
                .leftJoin(baseDetail3).on(baseDetail3.base_detail_cd.eq(product.prod_unit)).fetchJoin()
                .leftJoin(baseDetail4).on(baseDetail4.base_detail_cd.eq(shipment.ship_quality_cd)).fetchJoin()
                .where(odrDtBetween(vmap)
                        ,prodFamilyEq(vmap)
                        ,prodGroupEq(vmap)
                        ,prodKindEq(vmap)
                        ,prodSearchLike(vmap))
                .orderBy(shipment.ship_dt.desc())
                .fetch();
    }

    @Transactional
    public ShipmentQualityData shipmentInspectOne(VMap vmap) {

        return queryFactory
                .select(Projections.bean(ShipmentQualityData.class,
                        shipment.odr_cd
                        ,shipment.ship_cd
                        ,shipment.ship_dt
                        ,shipment.ship_cnt
                        ,shipment.ship_quality_yn.coalesce("N").as("ship_quality_yn")
                        ,shipment.ship_quality_cd
                        ,shipment.ship_quality_val
                        ,product.prod_pn
                        ,product.prod_nm
                        ,product.prod_stand
                        ,company.comp_nm
                        ,code.code_nm.as("prod_kind_nm")
                        ,baseDetail.base_detail_nm.as("prod_group_nm")
                        ,baseDetail2.base_detail_nm.as("prod_family_nm")
                        ,baseDetail3.base_detail_nm.as("prod_unit_nm")
                        ,baseDetail4.base_detail_nm.as("ship_quality_nm")
                ))
                .from(shipment)
                .leftJoin(order).on(order.odr_cd.eq(shipment.odr_cd))
                .leftJoin(product).on(order.prod_cd.eq(product.prod_cd)).fetchJoin()
                .leftJoin(company).on(order.comp_cd.eq(company.comp_cd)).fetchJoin()
                .leftJoin(code).on(code.code_id.eq("PROD_KIND").and(code.code_cd.eq(product.prod_kind))).fetchJoin()
                .leftJoin(baseDetail).on(baseDetail.base_detail_cd.eq(product.prod_group)).fetchJoin()
                .leftJoin(baseDetail2).on(baseDetail2.base_detail_cd.eq(product.prod_family)).fetchJoin()
                .leftJoin(baseDetail3).on(baseDetail3.base_detail_cd.eq(product.prod_unit)).fetchJoin()
                .leftJoin(baseDetail4).on(baseDetail4.base_detail_cd.eq(shipment.ship_quality_cd)).fetchJoin()
                .where(shipment.odr_cd.eq(vmap.getString("odr_cd")).and(shipment.ship_cd.eq(vmap.getString("ship_cd"))))
                .fetchOne();
    }

    @Transactional
    public void shipmentQualityModify(VMap vmap) {
        queryFactory.update(shipment)
                .set(shipment.ship_quality_yn, vmap.getString("ship_quality_yn"))
                .set(shipment.ship_quality_cd, vmap.getString("ship_quality_cd"))
                .set(shipment.ship_quality_val, vmap.getString("ship_quality_val"))
                .where(shipment.odr_cd.eq(vmap.getString("odr_cd")).and(shipment.ship_cd.eq(vmap.getString("ship_cd"))))
                .execute();
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
