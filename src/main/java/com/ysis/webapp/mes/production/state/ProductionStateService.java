package com.ysis.webapp.mes.production.state;

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
public class ProductionStateService {

    @Autowired CommonDAO commonDAO;

    @Autowired
    ProductionStateDAO productionStateDAO;

    @Autowired
    ProductDAO productDAO;

    public List<Map<String, Object>> stateList(VMap vmap) throws Exception {
        return productionStateDAO.stateList(vmap);
    }

}
