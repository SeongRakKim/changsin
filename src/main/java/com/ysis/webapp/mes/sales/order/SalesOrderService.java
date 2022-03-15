package com.ysis.webapp.mes.sales.order;

import com.ysis.webapp.common.util.CommonUtils;
import com.ysis.webapp.common.vo.VMap;
import com.ysis.webapp.mes.common.CommonDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
public class SalesOrderService {

    @Autowired CommonDAO commonDAO;
    @Autowired SalesOrderDAO salesOrderDAO;

    public List<Map<String, Object>> orderList(VMap vmap) throws Exception {
        return salesOrderDAO.orderList(vmap);
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
        return salesOrderDAO.orderPackDelete(vmap);
    }

    public List<Map<String, Object>> orderProcList(VMap vmap) throws Exception {
        return salesOrderDAO.orderProcList(vmap);
    }

    @Transactional
    public int orderProcRegistModify(VMap vmap) throws Exception {

        int returnCnt = 0;
        List<String> order_proc_seq =  (List<String>)vmap.get("ary_order_proc_seq");
        List<String> order_proc_cd = (List<String>)vmap.get("ary_order_proc_cd");
        List<String> proc_cd = (List<String>)vmap.get("ary_proc_cd");
        List<String> order_proc_min = (List<String>)vmap.get("ary_order_proc_min");
        List<String> order_proc_notice = (List<String>)vmap.get("ary_order_proc_notice");

        vmap.put("table_type", "PRPC");

        for(int i=0; i<order_proc_seq.size(); i++) {
            VMap orderProcMap = new VMap();

            orderProcMap.put("fact_cd", vmap.getString("fact_cd"));
            orderProcMap.put("order_cd", vmap.getString("order_cd"));
            orderProcMap.put("order_proc_seq", order_proc_seq.get(i));
            orderProcMap.put("order_proc_cd", CommonUtils.isNotEmpty(order_proc_cd.get(i)) ? order_proc_cd.get(i) : commonDAO.getTablePrimaryCode(vmap));
            orderProcMap.put("proc_cd", proc_cd.get(i));
            orderProcMap.put("order_proc_min", order_proc_min.get(i));
            orderProcMap.put("order_proc_notice", order_proc_notice.get(i));
            orderProcMap.put("u_cd", vmap.getString("u_cd"));

            salesOrderDAO.orderProcRegistModify(orderProcMap);

            returnCnt++;
        }

        return returnCnt;
    }

    public int orderProcDelete(VMap vmap) throws Exception {
        return salesOrderDAO.orderProcDelete(vmap);
    }

    public List<Map<String, Object>> orderBomList(VMap vmap) throws Exception {
        return salesOrderDAO.orderBomList(vmap);
    }

    @Transactional
    public int orderBomRegistModify(VMap vmap) throws Exception {

        int returnCnt = 0;
        List<String> order_bom_cd =  (List<String>)vmap.get("ary_order_bom_cd");
        List<String> proc_cd = (List<String>)vmap.get("ary_proc_cd");
        List<String> order_ja_cd = (List<String>)vmap.get("ary_order_ja_cd");
        List<String> order_bom_cnt = (List<String>)vmap.get("ary_order_bom_cnt");
        List<String> order_bom_notice = (List<String>)vmap.get("ary_order_bom_notice");

        vmap.put("table_type", "PRBM");

        for(int i=0; i<order_bom_cd.size(); i++) {
            VMap orderBomMap = new VMap();

            orderBomMap.put("fact_cd", vmap.getString("fact_cd"));
            orderBomMap.put("order_cd", vmap.getString("order_cd"));
            orderBomMap.put("order_bom_cd", CommonUtils.isNotEmpty(order_bom_cd.get(i)) ? order_bom_cd.get(i) : commonDAO.getTablePrimaryCode(vmap));
            orderBomMap.put("proc_cd", proc_cd.get(i));
            orderBomMap.put("order_ja_cd", order_ja_cd.get(i));
            orderBomMap.put("order_bom_cnt", order_bom_cnt.get(i));
            orderBomMap.put("order_bom_notice", order_bom_notice.get(i));
            orderBomMap.put("u_cd", vmap.getString("u_cd"));

            salesOrderDAO.orderBomRegistModify(orderBomMap);

            returnCnt++;
        }

        return returnCnt;
    }

    public int orderBomDelete(VMap vmap) throws Exception {
        return salesOrderDAO.orderBomDelete(vmap);
    }

}
