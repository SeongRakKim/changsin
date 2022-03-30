package com.ysis.webapp.mes.product.stock;

import com.ysis.webapp.common.util.CommonUtils;
import com.ysis.webapp.common.vo.VMap;
import com.ysis.webapp.mes.common.CommonDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
