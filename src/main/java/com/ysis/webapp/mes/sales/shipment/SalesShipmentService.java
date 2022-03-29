package com.ysis.webapp.mes.sales.shipment;

import com.ysis.webapp.common.config.BaseCodeItem;
import com.ysis.webapp.common.util.CommonUtils;
import com.ysis.webapp.common.vo.VMap;
import com.ysis.webapp.mes.base.product.ProductDAO;
import com.ysis.webapp.mes.common.CommonDAO;
import com.ysis.webapp.mes.material.inout.MaterialInoutService;
import com.ysis.webapp.mes.product.inout.ProductInoutService;
import com.ysis.webapp.mes.production.plan.ProductionPlanService;
import com.ysis.webapp.mes.sales.order.SalesOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
public class SalesShipmentService {

    @Autowired CommonDAO commonDAO;

    @Autowired
    SalesShipmentDAO salesShipmentDAO;

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

    public List<Map<String, Object>> shipList(VMap vmap) throws Exception {
        return salesShipmentDAO.shipList(vmap);
    }

    public Map<String, Object> shipOne(VMap vmap) throws Exception {
        return salesShipmentDAO.shipOne(vmap);
    }

    @Transactional
    public int salesShipmentDetailRegistModify(VMap vmap) throws Exception {


        int returnCnt = 0;

        List<String> ship_detail_cd =  (List<String>)vmap.get("ary_ship_detail_cd");
        List<String> ship_detail_dt = (List<String>)vmap.get("ary_ship_detail_dt");
        List<String> old_ship_detail_cnt = (List<String>)vmap.get("ary_old_ship_detail_cnt");
        List<String> ship_detail_cnt = (List<String>)vmap.get("ary_ship_detail_cnt");
        List<String> ship_detail_notice = (List<String>)vmap.get("ary_ship_detail_notice");

        for(int i=0; i<ship_detail_cd.size(); i++)
        {
            vmap.put("table_type", "SHIPDT");

            // 납품내역 수정
            VMap shipMap = new VMap();
            shipMap.put("fact_cd", vmap.getString("fact_cd"));
            shipMap.put("odr_cd", vmap.getString("odr_cd"));
            shipMap.put("ship_cd", vmap.getString("ship_cd"));
            shipMap.put("ship_detail_cd", CommonUtils.isNotEmpty(ship_detail_cd.get(i)) ? ship_detail_cd.get(i) : commonDAO.getTablePrimaryCode(vmap));
            shipMap.put("ship_detail_dt", ship_detail_dt.get(i));
            shipMap.put("ship_detail_cnt", ship_detail_cnt.get(i));
            shipMap.put("ship_detail_notice", ship_detail_notice.get(i));

            returnCnt += salesShipmentDAO.salesShipmentDetailRegistModify(shipMap);



        }


//        // 실적정보 수정
//        int returnCnt = salesShipmentDAO.planResultModify(vmap);
//
//        double diffCnt = Double.parseDouble(vmap.getString("plan_res_cnt")) - Double.parseDouble(vmap.getString("old_plan_res_cnt"));
//        if(diffCnt != 0)
//        {
//            String inout_type;
//            if(diffCnt < 0) {
//                inout_type = "O";
//                diffCnt = diffCnt * -1;
//            }else {
//                inout_type = "I";
//            }
//
//            // 생산-공정 총 수량변경
//            vmap.put("inout_type", inout_type);
//            vmap.put("plan_proc_cnt", diffCnt);
//            salesShipmentDAO.planProcCntModify(vmap);
//
//            if(vmap.getString("plan_proc_last_yn").equals("Y"))
//            {
//                // 생성된 제품 재고 보정 처리
//                productInoutService.productStockModify(vmap
//                        ,inout_type
//                        ,BaseCodeItem.INOUT_PRODUCTION
//                        ,vmap.getString("prod_cd")
//                        ,diffCnt
//                        ,0
//                        ,vmap.getString("plan_res_cd")
//                        ,BaseCodeItem.PLAN_RESULT_MODIFY);
//            }
//
//            // 소요자재 투입이력 삭제
//            salesShipmentDAO.planInputDelete(vmap);
//
//            // 소요자재 자동 차감
//            List<Map<String, Object>> bomList = productDAO.prodBomList(vmap);
//            for(Map<String, Object> result : bomList)
//            {
//                // 투입실적이력 생성
//                VMap input = new VMap();
//                input.put("fact_cd", vmap.getString("fact_cd"));
//                input.put("plan_cd", vmap.getString("plan_cd"));
//                input.put("plan_proc_cd", vmap.getString("plan_proc_cd"));
//                input.put("plan_res_cd", vmap.getString("plan_res_cd"));
//                vmap.put("table_type", "INPUT");
//                input.put("plan_input_cd", commonDAO.getTablePrimaryCode(vmap));
//                input.put("prod_ja_cd", String.valueOf(result.get("prod_ja_cd")));
//                input.put("plan_bom_cnt", Double.parseDouble(String.valueOf(result.get("prod_bom_cnt"))));
//                input.put("plan_input_cnt", Double.parseDouble(String.valueOf(result.get("prod_bom_cnt"))) * Double.parseDouble(vmap.getString("plan_res_cnt")));
//
//                salesShipmentDAO.planInputRegist(input);
//
//                // 투입자재 재고 차감 처리
//                productInoutService.productStockModify(vmap
//                        ,inout_type.equals("I") ? "O" : "I"
//                        ,BaseCodeItem.INOUT_INPUT
//                        ,String.valueOf(result.get("prod_ja_cd"))
//                        ,Double.parseDouble(String.valueOf(result.get("prod_bom_cnt"))) * diffCnt
//                        ,Double.parseDouble(String.valueOf(result.get("prod_bom_cnt")))
//                        ,vmap.getString("plan_res_cd")
//                        ,BaseCodeItem.PLAN_RESULT_MODIFY);
//            }
//        }

        return returnCnt;
    }

//    public List<Map<String, Object>> planResultList(VMap vmap) throws Exception {
//        return salesShipmentDAO.planResultList(vmap);
//    }
//
//    public Map<String, Object> planResultOne(VMap vmap) throws Exception {
//        return salesShipmentDAO.planResultOne(vmap);
//    }
//
//    @Transactional
//    public int planResultRegist(VMap vmap) throws Exception {
//
//        // 실적테이블 데이터 insert
//        vmap.put("table_type", "PLRES");
//        String plan_res_cd = commonDAO.getTablePrimaryCode(vmap);
//        vmap.put("plan_res_cd", plan_res_cd);
//        int returnCnt = salesShipmentDAO.planResultRegist(vmap);
//
//        // 생산 - 공정 테이블 상태 변경(생산 중)
//        vmap.put("plan_proc_state", BaseCodeItem.PRODUCTION_ING);
//        productionPlanService.salesShipmentStateModify(vmap);
//
//        // 생산계획 테이블 상태 변경(생산 중)
//        vmap.put("plan_state", BaseCodeItem.PRODUCTION_ING);
//        productionPlanService.planStateModify(vmap);
//
//        // 수주데이터 엮여 있을 시 수주상태 변경 (생산 중)
//        vmap.put("odr_state", BaseCodeItem.PRODUCTION_ING);
//        salesOrderService.orderStateModify(vmap);
//
//        // 생산-공정 총 수량변경
//        vmap.put("inout_type", "I");
//        vmap.put("plan_proc_cnt", Double.parseDouble(vmap.getString("plan_res_cnt")));
//        salesShipmentDAO.planProcCntModify(vmap);
//
//        // 생성된 제품 재고 증감 처리
//        if(vmap.getString("plan_proc_last_yn").equals("Y"))
//        {
//            productInoutService.productStockModify(vmap
//                    ,"I"
//                    ,BaseCodeItem.INOUT_PRODUCTION
//                    ,vmap.getString("prod_cd")
//                    ,Double.parseDouble(vmap.getString("plan_res_cnt"))
//                    ,0
//                    ,plan_res_cd
//                    ,BaseCodeItem.PLAN_RESULT_REGIST);
//        }
//
//        // 소요자재 자동 차감
//        List<Map<String, Object>> bomList = productDAO.prodBomList(vmap);
//        for(Map<String, Object> result : bomList)
//        {
//            // 투입실적이력 생성
//            VMap input = new VMap();
//            input.put("fact_cd", vmap.getString("fact_cd"));
//            input.put("plan_cd", vmap.getString("plan_cd"));
//            input.put("plan_proc_cd", vmap.getString("plan_proc_cd"));
//            input.put("plan_res_cd", plan_res_cd);
//            vmap.put("table_type", "INPUT");
//            input.put("plan_input_cd", commonDAO.getTablePrimaryCode(vmap));
//            input.put("prod_ja_cd", String.valueOf(result.get("prod_ja_cd")));
//            input.put("plan_bom_cnt", Double.parseDouble(String.valueOf(result.get("prod_bom_cnt"))));
//            input.put("plan_input_cnt", Double.parseDouble(String.valueOf(result.get("prod_bom_cnt"))) * Double.parseDouble(vmap.getString("plan_res_cnt")));
//
//            salesShipmentDAO.planInputRegist(input);
//
//            // 투입자재 재고 차감 처리
//            productInoutService.productStockModify(vmap
//                ,"O"
//                ,BaseCodeItem.INOUT_INPUT
//                ,String.valueOf(result.get("prod_ja_cd"))
//                ,Double.parseDouble(String.valueOf(result.get("prod_bom_cnt"))) * Double.parseDouble(vmap.getString("plan_res_cnt"))
//                ,Double.parseDouble(String.valueOf(result.get("prod_bom_cnt")))
//                ,plan_res_cd
//                ,BaseCodeItem.PLAN_INPUT_REGIST);
//        }
//
//        return returnCnt;
//    }
//
//    @Transactional
//    public int salesShipmentDetailRegistModify(VMap vmap) throws Exception {
//
//        // 실적정보 수정
//        int returnCnt = salesShipmentDAO.planResultModify(vmap);
//
//        double diffCnt = Double.parseDouble(vmap.getString("plan_res_cnt")) - Double.parseDouble(vmap.getString("old_plan_res_cnt"));
//        if(diffCnt != 0)
//        {
//            String inout_type;
//            if(diffCnt < 0) {
//                inout_type = "O";
//                diffCnt = diffCnt * -1;
//            }else {
//                inout_type = "I";
//            }
//
//            // 생산-공정 총 수량변경
//            vmap.put("inout_type", inout_type);
//            vmap.put("plan_proc_cnt", diffCnt);
//            salesShipmentDAO.planProcCntModify(vmap);
//
//            if(vmap.getString("plan_proc_last_yn").equals("Y"))
//            {
//                // 생성된 제품 재고 보정 처리
//                productInoutService.productStockModify(vmap
//                        ,inout_type
//                        ,BaseCodeItem.INOUT_PRODUCTION
//                        ,vmap.getString("prod_cd")
//                        ,diffCnt
//                        ,0
//                        ,vmap.getString("plan_res_cd")
//                        ,BaseCodeItem.PLAN_RESULT_MODIFY);
//            }
//
//            // 소요자재 투입이력 삭제
//            salesShipmentDAO.planInputDelete(vmap);
//
//            // 소요자재 자동 차감
//            List<Map<String, Object>> bomList = productDAO.prodBomList(vmap);
//            for(Map<String, Object> result : bomList)
//            {
//                // 투입실적이력 생성
//                VMap input = new VMap();
//                input.put("fact_cd", vmap.getString("fact_cd"));
//                input.put("plan_cd", vmap.getString("plan_cd"));
//                input.put("plan_proc_cd", vmap.getString("plan_proc_cd"));
//                input.put("plan_res_cd", vmap.getString("plan_res_cd"));
//                vmap.put("table_type", "INPUT");
//                input.put("plan_input_cd", commonDAO.getTablePrimaryCode(vmap));
//                input.put("prod_ja_cd", String.valueOf(result.get("prod_ja_cd")));
//                input.put("plan_bom_cnt", Double.parseDouble(String.valueOf(result.get("prod_bom_cnt"))));
//                input.put("plan_input_cnt", Double.parseDouble(String.valueOf(result.get("prod_bom_cnt"))) * Double.parseDouble(vmap.getString("plan_res_cnt")));
//
//                salesShipmentDAO.planInputRegist(input);
//
//                // 투입자재 재고 차감 처리
//                productInoutService.productStockModify(vmap
//                        ,inout_type.equals("I") ? "O" : "I"
//                        ,BaseCodeItem.INOUT_INPUT
//                        ,String.valueOf(result.get("prod_ja_cd"))
//                        ,Double.parseDouble(String.valueOf(result.get("prod_bom_cnt"))) * diffCnt
//                        ,Double.parseDouble(String.valueOf(result.get("prod_bom_cnt")))
//                        ,vmap.getString("plan_res_cd")
//                        ,BaseCodeItem.PLAN_RESULT_MODIFY);
//            }
//        }
//
//        return returnCnt;
//    }
//
//    public int planResultDelete(VMap vmap) throws Exception {
//
//        Map<String, Object> result = salesShipmentDAO.planResultOne(vmap);
//
//        // 생산-공정 총 수량변경
//        vmap.put("inout_type", "O");
//        vmap.put("plan_proc_cnt", Double.parseDouble(String.valueOf(result.get("plan_res_cnt"))));
//        salesShipmentDAO.planProcCntModify(vmap);
//
//        if(vmap.getString("plan_proc_last_yn").equals("Y"))
//        {
//            // 생성된 제품 재고 보정 처리
//            productInoutService.productStockModify(vmap
//                    ,"O"
//                    ,BaseCodeItem.INOUT_PRODUCTION
//                    ,String.valueOf(result.get("prod_cd"))
//                    ,Double.parseDouble(String.valueOf(result.get("plan_res_cnt")))
//                    ,0
//                    ,String.valueOf(result.get("plan_res_cd"))
//                    ,BaseCodeItem.PLAN_RESULT_DELETE);
//        }
//
//        // 소요자재 재고 보정
//        List<Map<String, Object>> inputList = salesShipmentDAO.planInputList(vmap);
//        for(Map<String, Object> input : inputList)
//        {
//            // 투입자재 재고 차감 처리
//            productInoutService.productStockModify(vmap
//                    ,"I"
//                    ,BaseCodeItem.INOUT_INPUT
//                    ,String.valueOf(input.get("prod_ja_cd"))
//                    ,Double.parseDouble(String.valueOf(input.get("plan_input_cnt")))
//                    ,Double.parseDouble(String.valueOf(input.get("plan_bom_cnt")))
//                    ,String.valueOf(result.get("plan_res_cd"))
//                    ,BaseCodeItem.PLAN_INPUT_DELETE);
//        }
//
//        // 소요자재 투입이력 삭제
//        salesShipmentDAO.planInputDelete(vmap);
//
//        // 투입자재 삭제
//        int returnCnt = salesShipmentDAO.planResultDelete(vmap);
//
//        if(salesShipmentDAO.planResultList(vmap).size() == 0)
//        {
//            // 생산 - 공정 테이블 상태 변경(생산 중)
//            vmap.put("plan_proc_state", BaseCodeItem.PRODUCTION_READY);
//            productionPlanService.salesShipmentStateModify(vmap);
//
//            // 생산계획 테이블 상태 변경(생산 중)
//            vmap.put("plan_state", BaseCodeItem.PRODUCTION_READY);
//            productionPlanService.planStateModify(vmap);
//
//            // 수주데이터 엮여 있을 시 수주상태 변경 (생산 중)
//            vmap.put("odr_state", BaseCodeItem.PRODUCTION_READY);
//            salesOrderService.orderStateModify(vmap);
//        }
//
//        return returnCnt;
//    }
//
//    public List<Map<String, Object>> planInputList(VMap vmap) throws Exception {
//        return salesShipmentDAO.planInputList(vmap);
//    }
//
//    public List<Map<String, Object>> planStopList(VMap vmap) throws Exception {
//        return salesShipmentDAO.planStopList(vmap);
//    }
//
//    @Transactional
//    public int planStopRegistModify(VMap vmap) throws Exception {
//
//        int returnCnt = 0;
//
//        List<String> plan_stop_cd =  (List<String>)vmap.get("ary_plan_stop_cd");
//        List<String> plan_stop_item = (List<String>)vmap.get("ary_plan_stop_item");
//        List<String> plan_stop_stdt = (List<String>)vmap.get("ary_plan_stop_stdt");
//        List<String> plan_stop_eddt = (List<String>)vmap.get("ary_plan_stop_eddt");
//        List<String> plan_stop_notice = (List<String>)vmap.get("ary_plan_stop_notice");
//
//        for(int i=0; i<plan_stop_cd.size(); i++)
//        {
//
//            // 수주데이터
//            vmap.put("table_type", "STOP");
//            VMap stopMap = new VMap();
//
//            stopMap.put("fact_cd", vmap.getString("fact_cd"));
//            stopMap.put("plan_cd", vmap.getString("plan_cd"));
//            stopMap.put("plan_proc_cd", vmap.getString("plan_proc_cd"));
//            stopMap.put("plan_res_cd", vmap.getString("plan_res_cd"));
//            stopMap.put("plan_stop_cd", CommonUtils.isNotEmpty(plan_stop_cd.get(i)) ? plan_stop_cd.get(i) : commonDAO.getTablePrimaryCode(vmap));
//            stopMap.put("plan_stop_item", plan_stop_item.get(i));
//            stopMap.put("plan_stop_stdt", plan_stop_stdt.get(i));
//            stopMap.put("plan_stop_eddt", plan_stop_eddt.get(i));
//            stopMap.put("plan_stop_notice", plan_stop_notice.get(i));
//            stopMap.put("u_cd", vmap.getString("u_cd"));
//
//            salesShipmentDAO.planStopRegistModify(stopMap);
//
//            returnCnt++;
//        }
//
//        return returnCnt;
//    }
//
//    public int planStopDelete(VMap vmap) throws Exception {
//        return salesShipmentDAO.planStopDelete(vmap);
//    }
//
//    @Transactional
//    public void salesShipmentComplete(VMap vmap) throws Exception {
//        vmap.put("plan_proc_state", BaseCodeItem.PRODUCTION_COMPLETE);
//        productionPlanService.salesShipmentStateModify(vmap);
//
//        if(productionPlanService.planOne(vmap).get("plan_comp_yn").equals("Y")) {
//            vmap.put("plan_state", BaseCodeItem.PRODUCTION_COMPLETE);
//            productionPlanService.planStateModify(vmap);
//        }
//
//        vmap.put("odr_state", BaseCodeItem.PRODUCTION_COMPLETE);
//        salesOrderService.orderStateModify(vmap);
//    }

}
