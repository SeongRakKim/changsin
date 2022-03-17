package com.ysis.webapp.mes.product.inout;

import com.ysis.webapp.common.util.CommonUtils;
import com.ysis.webapp.common.vo.VMap;
import com.ysis.webapp.mes.base.product.ProductDAO;
import com.ysis.webapp.mes.common.CommonDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class ProductInoutService {

    @Autowired CommonDAO commonDAO;

    @Autowired
    ProductInoutDAO productInoutDAO;

    @Autowired
    ProductDAO productDAO;

    public List<Map<String, Object>> productInoutList(VMap vmap) throws Exception {
        return productInoutDAO.productInoutList(vmap);
    }

    public Map<String, Object> productInoutOne(VMap vmap) throws Exception {
        return productInoutDAO.productInoutOne(vmap);
    }

    @Transactional
    public void productStockModify(VMap vmap, String inout_type, String inout_item, String prod_cd,
                                    double inout_cnt, String inout_crcd, String inout_msg) throws Exception {
        // 제품 정보 가져오기
        VMap prodMap = new VMap();
        prodMap.put("prod_cd", prod_cd);
        Map<String, Object> prod = productDAO.prodOne(vmap);

        // 입출고이력 생성
        vmap.put("table_type", "PINOUT");
        String inout_cd = commonDAO.getTablePrimaryCode(vmap);

        VMap inout = new VMap();
        inout.put("fact_cd", vmap.getString("fact_cd"));
        inout.put("inout_cd", inout_cd);
        inout.put("inout_type", inout_type);
        inout.put("inout_item", inout_item);
        inout.put("prod_cd", prod_cd);
        inout.put("inout_cnt", inout_cnt);
        inout.put("inout_crcd", inout_crcd);
        inout.put("inout_dt", null);
        inout.put("prod_stock_cnt", prod.get("prod_stock_cnt"));
        inout.put("inout_msg", inout_msg);

        productInoutDAO.productInoutRegist(inout);

        // 제품 재고 조정
        vmap.put("inout_type", inout_type);
        vmap.put("prod_stock_cnt", inout_cnt);

        productDAO.prodStockCntModify(vmap);

    }

    @Transactional
    public void resultModify(VMap vmap) throws Exception {

    }

}
