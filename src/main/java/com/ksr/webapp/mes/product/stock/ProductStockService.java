package com.ksr.webapp.mes.product.stock;

import com.ksr.webapp.common.vo.VMap;
import com.ksr.webapp.mes.common.CommonDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class ProductStockService {

    @Autowired CommonDAO commonDAO;
    @Autowired
    ProductStockDAO productStockDAO;

    public List<Map<String, Object>> prodStockList(VMap vmap) throws Exception {
        return productStockDAO.prodStockList(vmap);
    }


}
