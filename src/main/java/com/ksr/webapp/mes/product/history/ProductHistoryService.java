package com.ksr.webapp.mes.product.history;

import com.ksr.webapp.common.vo.VMap;
import com.ksr.webapp.mes.common.CommonDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class ProductHistoryService {

    @Autowired CommonDAO commonDAO;
    @Autowired
    ProductHistoryDAO productHistoryDAO;

    public List<Map<String, Object>> prodHistoryList(VMap vmap) throws Exception {
        return productHistoryDAO.prodHistoryList(vmap);
    }


}
