package com.ysis.webapp.mes.production.plan;

import com.ysis.webapp.common.util.CommonUtils;
import com.ysis.webapp.common.vo.VMap;
import com.ysis.webapp.mes.common.CommonDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
public class ProductionPlanService {

    @Autowired CommonDAO commonDAO;
    @Autowired
    ProductionPlanDAO productionPlanDAO;

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
        List<String> plan_dt = (List<String>)vmap.get("ary_plan_dt");
        List<String> plan_ship_dt = (List<String>)vmap.get("ary_plan_ship_dt");
        List<String> plan_vat_yn = (List<String>)vmap.get("ary_plan_vat_yn");
        List<String> plan_cnt = (List<String>)vmap.get("ary_plan_cnt");
        List<String> plan_price = (List<String>)vmap.get("ary_plan_price");
        List<String> plan_amt = (List<String>)vmap.get("ary_plan_amt");
        List<String> plan_vat = (List<String>)vmap.get("ary_plan_vat");
        List<String> plan_notice = (List<String>)vmap.get("ary_plan_notice");
        List<String> plan_project = (List<String>)vmap.get("ary_plan_project");
        List<String> plan_nm = (List<String>)vmap.get("ary_plan_nm");
        List<String> plan_tel = (List<String>)vmap.get("ary_plan_tel");



        for(int i=0; i<plan_cd.size(); i++)
        {

            // 수주데이터
            vmap.put("table_type", "ODR");
            VMap planMap = new VMap();

            planMap.put("fact_cd", vmap.getString("fact_cd"));
            planMap.put("plan_cd", CommonUtils.isNotEmpty(plan_cd.get(i)) ? plan_cd.get(i) : commonDAO.getTablePrimaryCode(vmap));
            planMap.put("comp_cd", comp_cd.get(i));
            planMap.put("prod_cd", prod_cd.get(i));
            planMap.put("plan_dt", plan_dt.get(i));
            planMap.put("plan_ship_dt", plan_ship_dt.get(i));
            planMap.put("plan_vat_yn", plan_vat_yn.get(i));
            planMap.put("plan_cnt", plan_cnt.get(i));
            planMap.put("plan_price", plan_price.get(i));
            planMap.put("plan_amt", plan_amt.get(i));
            planMap.put("plan_vat", plan_vat.get(i));
            planMap.put("plan_notice", plan_notice.get(i));
            planMap.put("plan_project", plan_project.get(i));
            planMap.put("plan_nm", plan_nm.get(i));
            planMap.put("plan_tel", plan_tel.get(i));
            planMap.put("u_cd", vmap.getString("u_cd"));

            productionPlanDAO.planRegist(planMap);

            // 납품데이터
            vmap.put("table_type", "SHIP");
            VMap shipMap = new VMap();

            shipMap.put("fact_cd", vmap.getString("fact_cd"));
            shipMap.put("plan_cd", planMap.get("plan_cd"));
            shipMap.put("ship_cd", commonDAO.getTablePrimaryCode(vmap));
            shipMap.put("u_cd", vmap.getString("u_cd"));

            productionPlanDAO.shipRegist(shipMap);

            returnCnt++;
        }

        return returnCnt;
    }

    @Transactional
    public int planModify(VMap vmap) throws Exception {
        return productionPlanDAO.planModify(vmap);
    }

    public int planPackDelete(VMap vmap) throws Exception {
        return productionPlanDAO.planPackDelete(vmap);
    }

    public List<Map<String, Object>> planProcList(VMap vmap) throws Exception {
        return productionPlanDAO.planProcList(vmap);
    }

    @Transactional
    public int planProcRegistModify(VMap vmap) throws Exception {

        int returnCnt = 0;
        List<String> plan_proc_seq =  (List<String>)vmap.get("ary_plan_proc_seq");
        List<String> plan_proc_cd = (List<String>)vmap.get("ary_plan_proc_cd");
        List<String> proc_cd = (List<String>)vmap.get("ary_proc_cd");
        List<String> plan_proc_min = (List<String>)vmap.get("ary_plan_proc_min");
        List<String> plan_proc_notice = (List<String>)vmap.get("ary_plan_proc_notice");

        vmap.put("table_type", "PRPC");

        for(int i=0; i<plan_proc_seq.size(); i++) {
            VMap planProcMap = new VMap();

            planProcMap.put("fact_cd", vmap.getString("fact_cd"));
            planProcMap.put("plan_cd", vmap.getString("plan_cd"));
            planProcMap.put("plan_proc_seq", plan_proc_seq.get(i));
            planProcMap.put("plan_proc_cd", CommonUtils.isNotEmpty(plan_proc_cd.get(i)) ? plan_proc_cd.get(i) : commonDAO.getTablePrimaryCode(vmap));
            planProcMap.put("proc_cd", proc_cd.get(i));
            planProcMap.put("plan_proc_min", plan_proc_min.get(i));
            planProcMap.put("plan_proc_notice", plan_proc_notice.get(i));
            planProcMap.put("u_cd", vmap.getString("u_cd"));

            productionPlanDAO.planProcRegistModify(planProcMap);

            returnCnt++;
        }

        return returnCnt;
    }

    public int planProcDelete(VMap vmap) throws Exception {
        return productionPlanDAO.planProcDelete(vmap);
    }

    public List<Map<String, Object>> planBomList(VMap vmap) throws Exception {
        return productionPlanDAO.planBomList(vmap);
    }

    @Transactional
    public int planBomRegistModify(VMap vmap) throws Exception {

        int returnCnt = 0;
        List<String> plan_bom_cd =  (List<String>)vmap.get("ary_plan_bom_cd");
        List<String> proc_cd = (List<String>)vmap.get("ary_proc_cd");
        List<String> plan_ja_cd = (List<String>)vmap.get("ary_plan_ja_cd");
        List<String> plan_bom_cnt = (List<String>)vmap.get("ary_plan_bom_cnt");
        List<String> plan_bom_notice = (List<String>)vmap.get("ary_plan_bom_notice");

        vmap.put("table_type", "PRBM");

        for(int i=0; i<plan_bom_cd.size(); i++) {
            VMap planBomMap = new VMap();

            planBomMap.put("fact_cd", vmap.getString("fact_cd"));
            planBomMap.put("plan_cd", vmap.getString("plan_cd"));
            planBomMap.put("plan_bom_cd", CommonUtils.isNotEmpty(plan_bom_cd.get(i)) ? plan_bom_cd.get(i) : commonDAO.getTablePrimaryCode(vmap));
            planBomMap.put("proc_cd", proc_cd.get(i));
            planBomMap.put("plan_ja_cd", plan_ja_cd.get(i));
            planBomMap.put("plan_bom_cnt", plan_bom_cnt.get(i));
            planBomMap.put("plan_bom_notice", plan_bom_notice.get(i));
            planBomMap.put("u_cd", vmap.getString("u_cd"));

            productionPlanDAO.planBomRegistModify(planBomMap);

            returnCnt++;
        }

        return returnCnt;
    }

    public int planBomDelete(VMap vmap) throws Exception {
        return productionPlanDAO.planBomDelete(vmap);
    }

}
