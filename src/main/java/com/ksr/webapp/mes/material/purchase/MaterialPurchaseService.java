package com.ksr.webapp.mes.material.purchase;

import com.ksr.webapp.common.config.BaseCodeItem;
import com.ksr.webapp.common.util.CommonUtils;
import com.ksr.webapp.common.util.DateUtils;
import com.ksr.webapp.common.vo.VMap;
import com.ksr.webapp.mes.base.product.ProductService;
import com.ksr.webapp.mes.common.CommonDAO;
import com.ksr.webapp.mes.product.inout.ProductInoutService;
import com.ksr.webapp.mes.production.plan.ProductionPlanDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
public class MaterialPurchaseService {

    @Autowired CommonDAO commonDAO;
    @Autowired
    MaterialPurchaseDAO materialPurchaseDAO;
    @Autowired
    ProductionPlanDAO productionPlanDAO;
    @Autowired
    ProductInoutService productInoutService;

    @Autowired
    ProductService productService;

    public List<Map<String, Object>> purchaseList(VMap vmap) throws Exception {
        return materialPurchaseDAO.purchaseList(vmap);
    }

    public List<Map<String, Object>> purchaseList2(VMap vmap) throws Exception {
        return materialPurchaseDAO.purchaseList2(vmap);
    }

    public Map<String, Object> purchaseOne(VMap vmap) throws Exception {
        return materialPurchaseDAO.purchaseOne(vmap);
    }

    public Map<String, Object> purchaseOverlap(VMap vmap) throws Exception {
        return materialPurchaseDAO.purchaseOverlap(vmap);
    }

    @Transactional
    public int purchaseRegist(VMap vmap) throws Exception {

        int returnCnt = 0;
        List<String> pur_cd =  (List<String>)vmap.get("ary_pur_cd");
        List<String> comp_cd = (List<String>)vmap.get("ary_comp_cd");
        List<String> prod_cd = (List<String>)vmap.get("ary_prod_cd");
        List<String> pur_dt = (List<String>)vmap.get("ary_pur_dt");
        List<String> pur_ship_dt = (List<String>)vmap.get("ary_pur_ship_dt");
        List<String> pur_vat_yn = (List<String>)vmap.get("ary_pur_vat_yn");
        List<String> pur_cnt = (List<String>)vmap.get("ary_pur_cnt");
        List<String> pur_price = (List<String>)vmap.get("ary_pur_price");
        List<String> pur_amt = (List<String>)vmap.get("ary_pur_amt");
        List<String> pur_vat = (List<String>)vmap.get("ary_pur_vat");
        List<String> pur_notice = (List<String>)vmap.get("ary_pur_notice");

        for(int i=0; i<pur_cd.size(); i++)
        {

            // 수주데이터
            vmap.put("table_type", "PUR");
            VMap purchaseMap = new VMap();

            purchaseMap.put("fact_cd", vmap.getString("fact_cd"));
            purchaseMap.put("pur_cd", CommonUtils.isNotEmpty(pur_cd.get(i)) ? pur_cd.get(i) : commonDAO.getTablePrimaryCode(vmap));
            purchaseMap.put("comp_cd", comp_cd.get(i));
            purchaseMap.put("prod_cd", prod_cd.get(i));
            purchaseMap.put("pur_dt", pur_dt.get(i));
            purchaseMap.put("pur_ship_dt", pur_ship_dt.get(i));
            purchaseMap.put("pur_vat_yn", pur_vat_yn.get(i));
            purchaseMap.put("pur_cnt", pur_cnt.get(i));
            purchaseMap.put("pur_price", pur_price.get(i));
            purchaseMap.put("pur_amt", pur_amt.get(i));
            purchaseMap.put("pur_vat", pur_vat.get(i));
            purchaseMap.put("pur_notice", pur_notice.get(i));
            purchaseMap.put("u_cd", vmap.getString("u_cd"));

            materialPurchaseDAO.purchaseRegist(purchaseMap);

            returnCnt++;
        }

        return returnCnt;
    }

    @Transactional
    public int purchaseModify(VMap vmap) throws Exception {
        return materialPurchaseDAO.purchaseModify(vmap);
    }

    @Transactional
    public int purchaseInModify(VMap vmap) throws Exception {

        vmap.put("pur_state", BaseCodeItem.PURCHASE_COMPELTE);
//        Map<String, Object> lotMap = null;
        if(vmap.getString("prod_lot_yn").equals("Y")) {
            vmap.put("lot_date", DateUtils.getTodayDate());
            Map<String, Object> lotMap = productService.createProdLotNo(vmap);
            vmap.put("lot_no", lotMap.get("lot_no"));
        }

        // 입고처리
        productInoutService.productStockModify(vmap
                                                ,"I"
                                                ,BaseCodeItem.INOUT_PURCHASE
                                                ,vmap.getString("prod_cd")
                                                ,Double.parseDouble(vmap.getString("pur_cnt"))
                                                ,0
                                                ,vmap.getString("pur_cd")
                                                ,vmap.getString("lot_no")
                                                ,BaseCodeItem.PURCHASE_REGIST);

        return materialPurchaseDAO.purchaseInModify(vmap);
    }

    @Transactional
    public int purchaseInBundleModify(VMap vmap) throws Exception {

        int returnCnt  = 0;
        List<Map<String, Object>> purcList = materialPurchaseDAO.purchaseList2(vmap);

        for(Map<String, Object> result : purcList) {

            VMap purMap = new VMap();
            purMap.put("fact_cd", vmap.getString("fact_cd"));
            purMap.put("pur_cd", result.get("pur_cd"));
            purMap.put("pur_cnt", result.get("pur_cnt"));
            purMap.put("pur_state", BaseCodeItem.PURCHASE_COMPELTE);

            returnCnt += materialPurchaseDAO.purchaseInModify(purMap);

            // 입고처리
            productInoutService.productStockModify(vmap
                                                    ,"I"
                                                    ,BaseCodeItem.INOUT_PURCHASE
                                                    ,String.valueOf(result.get("prod_cd"))
                                                    ,Double.parseDouble(String.valueOf(result.get("pur_cnt")))
                                                    ,0
                                                    ,String.valueOf(vmap.get("pur_cd"))
                                                    ,null
                                                    ,BaseCodeItem.PURCHASE_REGIST);
        }

        return returnCnt;
    }

    public int purchasePackDelete(VMap vmap) throws Exception {
        return materialPurchaseDAO.purchasePackDelete(vmap);
    }

}
