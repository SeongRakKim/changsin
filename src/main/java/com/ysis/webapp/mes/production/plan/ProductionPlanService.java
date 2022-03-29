package com.ysis.webapp.mes.production.plan;

import com.ysis.webapp.common.config.BaseCodeItem;
import com.ysis.webapp.common.util.CommonUtils;
import com.ysis.webapp.common.vo.VMap;
import com.ysis.webapp.mes.base.product.ProductDAO;
import com.ysis.webapp.mes.common.CommonDAO;
import com.ysis.webapp.mes.sales.order.SalesOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class ProductionPlanService {

    @Autowired CommonDAO commonDAO;

    @Autowired
    ProductionPlanDAO productionPlanDAO;

    @Autowired
    ProductDAO productDAO;

    @Autowired
    SalesOrderService salesOrderService;

    public List<Map<String, Object>> planList(VMap vmap) throws Exception {
        return productionPlanDAO.planList(vmap);
    }

    public Map<String, Object> planOne(VMap vmap) throws Exception {
        return productionPlanDAO.planOne(vmap);
    }

    public Map<String, Object> planOverlap(VMap vmap) throws Exception {
        return productionPlanDAO.planOverlap(vmap);
    }

    @Transactional
    public int planRegist(VMap vmap) throws Exception {

        int returnCnt = 0;
        List<String> plan_cd =  (List<String>)vmap.get("ary_plan_cd");
        List<String> comp_cd = (List<String>)vmap.get("ary_comp_cd");
        List<String> prod_cd = (List<String>)vmap.get("ary_prod_cd");
        List<String> plan_stdt = (List<String>)vmap.get("ary_plan_stdt");
        List<String> plan_eddt = (List<String>)vmap.get("ary_plan_eddt");
        List<String> plan_cnt = (List<String>)vmap.get("ary_plan_cnt");
        List<String> plan_no = (List<String>)vmap.get("ary_plan_no");
        List<String> plan_notice = (List<String>)vmap.get("ary_plan_notice");

        for(int i=0; i<plan_cd.size(); i++)
        {
            // 생산계획 데이터
            vmap.put("table_type", "PRPL");
            vmap.put("column_type", "WK");
            VMap planMap = new VMap();

            planMap.put("fact_cd", vmap.getString("fact_cd"));
            planMap.put("plan_cd", CommonUtils.isNotEmpty(plan_cd.get(i)) ? plan_cd.get(i) : commonDAO.getTablePrimaryCode(vmap));
            planMap.put("comp_cd", comp_cd.get(i));
            planMap.put("prod_cd", prod_cd.get(i));
            planMap.put("plan_stdt", plan_stdt.get(i));
            planMap.put("plan_eddt", plan_eddt.get(i));
            planMap.put("plan_cnt", plan_cnt.get(i));
            planMap.put("plan_no", CommonUtils.isNotEmpty(plan_no.get(i)) ? plan_no.get(i) : commonDAO.getTableRandomKey(vmap));
            planMap.put("plan_notice", plan_notice.get(i));
            planMap.put("u_cd", vmap.getString("u_cd"));

            productionPlanDAO.planRegist(planMap);

            // 계획-공정 (제품-공정 데이터 생성)
            ArrayList<Map<String, Object>> prodProcList = (ArrayList)productDAO.prodProcList(planMap);
            int j=0;
            for (Map result : prodProcList)
            {
                VMap planProcMap = new VMap();

                vmap.put("column_type", "PLPC");
                planProcMap.put("fact_cd", vmap.getString("fact_cd"));
                planProcMap.put("plan_cd", planMap.getString("plan_cd"));
                planProcMap.put("plan_proc_cd", commonDAO.getTablePrimaryCode(vmap));
                planProcMap.put("proc_cd", result.get("proc_cd"));
                planProcMap.put("plan_proc_seq", ++j);
                planProcMap.put("plan_proc_last_yn", (j == prodProcList.size() ? "Y" : "N"));

                productionPlanDAO.planProcRegist(planProcMap);
            }

            returnCnt++;
        }

        return returnCnt;
    }

    @Transactional
    public int planModify(VMap vmap) throws Exception {

        // 생산지시 - 공정 변경
        List<String> plan_proc_cd =  (List<String>)vmap.get("ary_plan_proc_cd");
        List<String> proc_cd = (List<String>)vmap.get("ary_proc_cd");
        List<String> plan_proc_notice = (List<String>)vmap.get("ary_plan_proc_notice");

        for(int i=0; i<plan_proc_cd.size(); i++)
        {
            VMap planProcMap = new VMap();

            planProcMap.put("plan_proc_cd", plan_proc_cd.get(i));
            planProcMap.put("plan_proc_notice", plan_proc_notice.get(i));

            productionPlanDAO.planProcModify(planProcMap);
        }

        return productionPlanDAO.planModify(vmap);
    }

    public void planStateModify(VMap vmap) throws Exception {
        productionPlanDAO.planStateModify(vmap);
    }

    public void planProcessStateModify(VMap vmap) throws Exception {
        productionPlanDAO.planProcessStateModify(vmap);
    }

    public int planPackDelete(VMap vmap) throws Exception {

        // 생산공정삭제
        productionPlanDAO.planProcDelete(vmap);

        return productionPlanDAO.planPackDelete(vmap);
    }

    public List<Map<String, Object>> planProcList(VMap vmap) throws Exception {
        return productionPlanDAO.planProcList(vmap);
    }

    public int planProcDelete(VMap vmap) throws Exception {
        return productionPlanDAO.planProcDelete(vmap);
    }

    public int orderPlanProcDelete(VMap vmap) throws Exception {
        return productionPlanDAO.orderPlanProcDelete(vmap);
    }

    @Transactional
    public int orderPlanRegist(VMap vmap) throws Exception {

        int returnCnt = 0;
        List<String> odr_cd =  (List<String>)vmap.get("ary_odr_cd");
        List<String> comp_cd = (List<String>)vmap.get("ary_comp_cd");
        List<String> prod_cd = (List<String>)vmap.get("ary_prod_cd");
        List<String> plan_stdt = (List<String>)vmap.get("ary_plan_stdt");
        List<String> plan_eddt = (List<String>)vmap.get("ary_plan_eddt");
        List<String> plan_cnt = (List<String>)vmap.get("ary_plan_cnt");

        for(int i=0; i<odr_cd.size(); i++)
        {
            // 생산계획 데이터
            vmap.put("table_type", "PRPL");
            vmap.put("column_type", "WK");
            VMap planMap = new VMap();

            planMap.put("fact_cd", vmap.getString("fact_cd"));
            planMap.put("plan_cd", commonDAO.getTablePrimaryCode(vmap));
            planMap.put("odr_cd", odr_cd.get(i));
            planMap.put("comp_cd", comp_cd.get(i));
            planMap.put("prod_cd", prod_cd.get(i));
            planMap.put("plan_stdt", plan_stdt.get(i));
            planMap.put("plan_eddt", plan_eddt.get(i));
            planMap.put("plan_cnt", plan_cnt.get(i));
            planMap.put("plan_no", commonDAO.getTableRandomKey(vmap));
            planMap.put("plan_notice", null);
            planMap.put("u_cd", vmap.getString("u_cd"));

            productionPlanDAO.planRegist(planMap);

            // 수주데이터 엮여 있을 시 수주상태 변경 (생산대기)
            vmap.put("odr_cd", odr_cd.get(i));
            vmap.put("odr_state", BaseCodeItem.PRODUCTION_READY);
            salesOrderService.orderStateModify(vmap);

            // 계획-공정 (제품-공정 데이터 생성)
            ArrayList<Map<String, Object>> prodProcList = (ArrayList)productDAO.prodProcList(planMap);
            int j=0;
            for (Map result : prodProcList)
            {
                VMap planProcMap = new VMap();

                vmap.put("column_type", "PLPC");
                planProcMap.put("fact_cd", vmap.getString("fact_cd"));
                planProcMap.put("plan_cd", planMap.getString("plan_cd"));
                planProcMap.put("plan_proc_cd", commonDAO.getTablePrimaryCode(vmap));
                planProcMap.put("proc_cd", result.get("proc_cd"));
                planProcMap.put("plan_proc_seq", ++j);
                planProcMap.put("plan_proc_last_yn", (j == prodProcList.size() ? "Y" : "N"));

                productionPlanDAO.planProcRegist(planProcMap);
            }

            returnCnt++;
        }

        return returnCnt;
    }

}
