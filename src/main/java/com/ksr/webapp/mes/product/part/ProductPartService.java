package com.ksr.webapp.mes.product.part;

import com.ksr.webapp.common.vo.VMap;
import com.ksr.webapp.mes.common.CommonDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class ProductPartService {

    @Autowired CommonDAO commonDAO;
    @Autowired
    ProductPartDAO productPartDAO;

    public List<Map<String, Object>> prodPartList(VMap vmap) throws Exception {
        return productPartDAO.prodPartList(vmap);
    }


}
