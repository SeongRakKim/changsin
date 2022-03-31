package com.ksr.webapp.mes.sales.order;

import com.ksr.webapp.common.util.CommonUtils;
import com.ksr.webapp.common.vo.VMap;
import com.ksr.webapp.mes.common.CommonDAO;
import com.ksr.webapp.mes.production.plan.ProductionPlanDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
public class SalesOrderService {

    @Autowired CommonDAO commonDAO;
    @Autowired SalesOrderDAO salesOrderDAO;
    @Autowired
    ProductionPlanDAO productionPlanDAO;

    public List<Map<String, Object>> orderList(VMap vmap) throws Exception {
        return salesOrderDAO.orderList(vmap);
    }

    public List<Map<String, Object>> orderList2(VMap vmap) throws Exception {
        return salesOrderDAO.orderList2(vmap);
    }

    public Map<String, Object> orderOne(VMap vmap) throws Exception {
        return salesOrderDAO.orderOne(vmap);
    }

    public Map<String, Object> orderOverlap(VMap vmap) throws Exception {
        return salesOrderDAO.orderOverlap(vmap);
    }

    @Transactional
    public int orderRegist(VMap vmap) throws Exception {

        int returnCnt = 0;
        List<String> odr_cd =  (List<String>)vmap.get("ary_odr_cd");
        List<String> comp_cd = (List<String>)vmap.get("ary_comp_cd");
        List<String> prod_cd = (List<String>)vmap.get("ary_prod_cd");
        List<String> odr_dt = (List<String>)vmap.get("ary_odr_dt");
        List<String> odr_ship_dt = (List<String>)vmap.get("ary_odr_ship_dt");
        List<String> odr_vat_yn = (List<String>)vmap.get("ary_odr_vat_yn");
        List<String> odr_cnt = (List<String>)vmap.get("ary_odr_cnt");
        List<String> odr_price = (List<String>)vmap.get("ary_odr_price");
        List<String> odr_amt = (List<String>)vmap.get("ary_odr_amt");
        List<String> odr_vat = (List<String>)vmap.get("ary_odr_vat");
        List<String> odr_notice = (List<String>)vmap.get("ary_odr_notice");
        List<String> odr_project = (List<String>)vmap.get("ary_odr_project");
        List<String> odr_nm = (List<String>)vmap.get("ary_odr_nm");
        List<String> odr_tel = (List<String>)vmap.get("ary_odr_tel");



        for(int i=0; i<odr_cd.size(); i++)
        {

            // 수주데이터
            vmap.put("table_type", "ODR");
            VMap orderMap = new VMap();

            orderMap.put("fact_cd", vmap.getString("fact_cd"));
            orderMap.put("odr_cd", CommonUtils.isNotEmpty(odr_cd.get(i)) ? odr_cd.get(i) : commonDAO.getTablePrimaryCode(vmap));
            orderMap.put("comp_cd", comp_cd.get(i));
            orderMap.put("prod_cd", prod_cd.get(i));
            orderMap.put("odr_dt", odr_dt.get(i));
            orderMap.put("odr_ship_dt", odr_ship_dt.get(i));
            orderMap.put("odr_vat_yn", odr_vat_yn.get(i));
            orderMap.put("odr_cnt", odr_cnt.get(i));
            orderMap.put("odr_price", odr_price.get(i));
            orderMap.put("odr_amt", odr_amt.get(i));
            orderMap.put("odr_vat", odr_vat.get(i));
            orderMap.put("odr_notice", odr_notice.get(i));
            orderMap.put("odr_project", odr_project.get(i));
            orderMap.put("odr_nm", odr_nm.get(i));
            orderMap.put("odr_tel", odr_tel.get(i));
            orderMap.put("u_cd", vmap.getString("u_cd"));

            salesOrderDAO.orderRegist(orderMap);

            // 납품데이터
            vmap.put("table_type", "SHIP");
            VMap shipMap = new VMap();

            shipMap.put("fact_cd", vmap.getString("fact_cd"));
            shipMap.put("odr_cd", orderMap.get("odr_cd"));
            shipMap.put("ship_cd", commonDAO.getTablePrimaryCode(vmap));
            shipMap.put("u_cd", vmap.getString("u_cd"));

            salesOrderDAO.shipRegist(shipMap);

            returnCnt++;
        }

        return returnCnt;
    }

    @Transactional
    public int orderModify(VMap vmap) throws Exception {
        return salesOrderDAO.orderModify(vmap);
    }

    public int orderPackDelete(VMap vmap) throws Exception {

        // 생산공정삭제
        productionPlanDAO.orderPlanProcDelete(vmap);

        // 생산계획삭제
        productionPlanDAO.planPackDelete(vmap);

        // 납품데이터삭제
        salesOrderDAO.shipPackDelete(vmap);

        return salesOrderDAO.orderPackDelete(vmap);
    }

    public void orderStateModify(VMap vmap) throws Exception {
        salesOrderDAO.orderStateModify(vmap);
    }

}
