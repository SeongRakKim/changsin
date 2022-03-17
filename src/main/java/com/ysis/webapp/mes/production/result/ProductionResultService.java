package com.ysis.webapp.mes.production.result;

import com.ysis.webapp.common.config.BaseCodeItem;
import com.ysis.webapp.common.util.CommonUtils;
import com.ysis.webapp.common.vo.VMap;
import com.ysis.webapp.mes.base.material.MaterialService;
import com.ysis.webapp.mes.base.product.ProductDAO;
import com.ysis.webapp.mes.common.CommonDAO;
import com.ysis.webapp.mes.material.inout.MaterialInoutService;
import com.ysis.webapp.mes.product.inout.ProductInoutService;
import com.ysis.webapp.mes.production.plan.ProductionPlanService;
import com.ysis.webapp.mes.sales.order.SalesOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class ProductionResultService {

    @Autowired CommonDAO commonDAO;

    @Autowired
    ProductionResultDAO productionResultDAO;

    @Autowired
    ProductDAO productDAO;

    @Autowired
    ProductionPlanService productionPlanService;

    @Autowired
    ProductInoutService productInoutService;

    @Autowired
    SalesOrderService salesOrderService;

    @Autowired
    MaterialInoutService materialInoutService;

    public List<Map<String, Object>> planProcessList(VMap vmap) throws Exception {
        return productionResultDAO.planProcessList(vmap);
    }

    public Map<String, Object> planProcessOne(VMap vmap) throws Exception {
        return productionResultDAO.planProcessOne(vmap);
    }

    @Transactional
    public int planResultRegist(VMap vmap) throws Exception {

        // 실적테이블 데이터 insert
        vmap.put("table_type", "PLRES");
        String plan_res_cd = commonDAO.getTablePrimaryCode(vmap);
        vmap.put("plan_res_cd", plan_res_cd);
        int returnCnt = productionResultDAO.planResultRegist(vmap);

        // 생산 - 공정 테이블 상태 변경(생산 중)
        vmap.put("plan_proc_state", BaseCodeItem.PRODUCTION_ING);
        productionPlanService.planProcessStateModify(vmap);

        // 생산계획 테이블 상태 변경(생산 중)
        vmap.put("plan_state", BaseCodeItem.PRODUCTION_ING);
        productionPlanService.planStateModify(vmap);

        // 수주데이터 엮여 있을 시 수주상태 변경 (생산 중)
        vmap.put("odr_state", BaseCodeItem.PRODUCTION_ING);
        salesOrderService.orderStateModify(vmap);

        // 생성된 제품 재고 증감 처리
        productInoutService.productStockModify(vmap
                ,"I"
                ,BaseCodeItem.INOUT_PRODUCTION
                ,vmap.getString("prod_cd")
                ,Double.parseDouble(vmap.getString("plan_res_cnt"))
                ,plan_res_cd
                ,BaseCodeItem.PLAN_RESULT_REGIST);

        // 소요자재 자동 차감
        List<Map<String, Object>> bomList = productDAO.prodBomList(vmap);
        for(Map<String, Object> result : bomList)
        {
            // 투입실적이력 생성
            VMap input = new VMap();
            input.put("fact_cd", vmap.getString("fact_cd"));
            input.put("plan_cd", vmap.getString("plan_cd"));
            input.put("plan_proc_cd", vmap.getString("plan_proc_cd"));
            input.put("plan_res_cd", plan_res_cd);
            vmap.put("table_type", "INPUT");
            input.put("plan_input_cd", commonDAO.getTablePrimaryCode(vmap));
            input.put("mate_cd", String.valueOf(result.get("prod_ja_cd")));
            input.put("plan_bom_cnt", Double.parseDouble(String.valueOf(result.get("prod_bom_cnt"))));
            input.put("plan_input_cnt", Double.parseDouble(String.valueOf(result.get("prod_bom_cnt"))) * Double.parseDouble(vmap.getString("plan_res_cnt")));

            productionResultDAO.planInputRegist(input);

            // 투입자재 재고 차감 처리
            materialInoutService.materialStockModify(vmap
                ,"O"
                ,BaseCodeItem.INOUT_INPUT
                ,String.valueOf(result.get("prod_ja_cd"))
                ,Double.parseDouble(vmap.getString("plan_res_cnt"))
                ,Double.parseDouble(String.valueOf(result.get("prod_bom_cnt")))
                ,plan_res_cd
                ,BaseCodeItem.PLAN_INPUT_REGIST);
        }


        return returnCnt;
    }

    @Transactional
    public int resultModify(VMap vmap) throws Exception {

        // 생산지시 - 공정 변경
        List<String> result_proc_cd =  (List<String>)vmap.get("ary_result_proc_cd");
        List<String> proc_cd = (List<String>)vmap.get("ary_proc_cd");
        List<String> result_proc_notice = (List<String>)vmap.get("ary_result_proc_notice");

        for(int i=0; i<result_proc_cd.size(); i++)
        {
            VMap resultProcMap = new VMap();

            resultProcMap.put("result_proc_cd", result_proc_cd.get(i));
            resultProcMap.put("result_proc_notice", result_proc_notice.get(i));

//            productionResultDAO.resultProcModify(resultProcMap);
        }

        return productionResultDAO.resultModify(vmap);
    }

}
