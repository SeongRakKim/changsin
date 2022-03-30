package com.ysis.webapp.mes.material.stock;

import com.ysis.webapp.common.util.CommonUtils;
import com.ysis.webapp.common.vo.VMap;
import com.ysis.webapp.mes.common.CommonDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
public class MaterialStockService {

    @Autowired CommonDAO commonDAO;
    @Autowired
    MaterialStockDAO materialStockDAO;

    public List<Map<String, Object>> mateStockList(VMap vmap) throws Exception {
        return materialStockDAO.mateStockList(vmap);
    }

}
