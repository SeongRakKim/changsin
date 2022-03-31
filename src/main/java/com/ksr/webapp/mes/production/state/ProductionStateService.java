package com.ksr.webapp.mes.production.state;

import com.ksr.webapp.common.vo.VMap;
import com.ksr.webapp.mes.base.product.ProductDAO;
import com.ksr.webapp.mes.common.CommonDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class ProductionStateService {

    @Autowired CommonDAO commonDAO;

    @Autowired
    ProductionStateDAO productionStateDAO;

    @Autowired
    ProductDAO productDAO;

    public List<Map<String, Object>> stateList(VMap vmap) throws Exception {
        return productionStateDAO.stateList(vmap);
    }

    public Map<String, Object> stateOne(VMap vmap) throws Exception {
        return productionStateDAO.stateOne(vmap);
    }

}
