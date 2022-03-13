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
    public int orderRegistModify(VMap vmap) throws Exception {

        vmap.put("table_type", "PROD");
        vmap.put("order_cd", CommonUtils.isNotEmpty(vmap.getString("order_cd")) ? vmap.getString("order_cd") : commonDAO.getTablePrimaryCode(vmap));

        return salesOrderDAO.orderRegistModify(vmap);
    }

    public int orderPackDelete(VMap vmap) throws Exception {

        salesOrderDAO.orderProcPackDelete(vmap);
        salesOrderDAO.orderBomPackDelete(vmap);

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
