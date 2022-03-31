package com.ksr.webapp.mes.material.stock;

import com.ksr.webapp.common.vo.VMap;
import com.ksr.webapp.mes.common.CommonDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
