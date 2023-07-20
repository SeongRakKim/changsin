package com.ksr.webapp.mes.sales.shipment;

import com.ksr.webapp.common.config.BaseCodeItem;
import com.ksr.webapp.common.util.CommonUtils;
import com.ksr.webapp.common.vo.VMap;
import com.ksr.webapp.mes.base.product.ProductDAO;
import com.ksr.webapp.mes.common.CommonDAO;
import com.ksr.webapp.mes.material.inout.MaterialInoutService;
import com.ksr.webapp.mes.product.inout.ProductInoutService;
import com.ksr.webapp.mes.production.plan.ProductionPlanService;
import com.ksr.webapp.mes.sales.order.SalesOrderService;
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

    public List<Map<String, Object>> salesShipmentDetailtList(VMap vmap) throws Exception {
        return salesShipmentDAO.salesShipmentDetailtList(vmap);
    }

    @Transactional
    public int salesShipmentDetailRegistModify(VMap vmap) throws Exception {


        int returnCnt = 0;

        List<String> ship_detail_cd =  (List<String>)vmap.get("ary_ship_detail_cd");
        List<String> ship_detail_dt = (List<String>)vmap.get("ary_ship_detail_dt");
        List<String> ary_old_lot_no = (List<String>)vmap.get("ary_old_lot_no");
        List<String> ary_lot_no = (List<String>)vmap.get("ary_lot_no");
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
            shipMap.put("lot_no", ary_lot_no.get(i));
            shipMap.put("ship_detail_cd", CommonUtils.isNotEmpty(ship_detail_cd.get(i)) ? ship_detail_cd.get(i) : commonDAO.getTablePrimaryCode(vmap));
            shipMap.put("ship_detail_dt", ship_detail_dt.get(i));
            shipMap.put("ship_detail_cnt", ship_detail_cnt.get(i));
            shipMap.put("ship_detail_notice", ship_detail_notice.get(i));

            returnCnt += salesShipmentDAO.salesShipmentDetailRegistModify(shipMap);

            double diffCnt = Double.parseDouble(ship_detail_cnt.get(i)) - Double.parseDouble(old_ship_detail_cnt.get(i));

            if(diffCnt != 0)
            {
                String inout_type;
                if(diffCnt < 0) {
                    inout_type = "I";
                    diffCnt = diffCnt * -1;
                }else {
                    inout_type = "O";
                }

                String ioMsg = (Integer.parseInt(String.valueOf(old_ship_detail_cnt.get(i))) == 0) ? BaseCodeItem.SHIP_REGIST : BaseCodeItem.SHIP_MODIFY;

                // 생성된 제품 재고 보정 처리
                productInoutService.productStockModify(vmap
                                                        ,inout_type
                                                        ,BaseCodeItem.INOUT_SHIP
                                                        ,vmap.getString("prod_cd")
                                                        ,diffCnt
                                                        ,0
                                                        ,vmap.getString("ship_cd")
                                                        ,ary_lot_no.get(i)
                                                        ,ioMsg);
            }
        }

        salesShipmentDAO.salesShipmentStateModify(vmap);

        return returnCnt;
    }

    public int salesShipmentDetailDelete(VMap vmap) throws Exception {

        productInoutService.productStockModify(vmap
                                                ,"I"
                                                ,BaseCodeItem.INOUT_SHIP
                                                ,vmap.getString("prod_cd")
                                                ,Double.parseDouble(vmap.getString("ship_detail_cnt"))
                                                ,0
                                                ,vmap.getString("ship_cd")
                                                ,vmap.getString("lot_no")
                                                ,BaseCodeItem.SHIP_DELETE);

        int returnCnt = salesShipmentDAO.salesShipmentDetailDelete(vmap);

        salesShipmentDAO.salesShipmentStateModify(vmap);

        return returnCnt;
    }

}
