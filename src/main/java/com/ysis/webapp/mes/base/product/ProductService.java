package com.ysis.webapp.mes.base.product;

import com.ysis.webapp.common.util.CommonUtils;
import com.ysis.webapp.common.vo.VMap;
import com.ysis.webapp.mes.common.CommonDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
public class ProductService {

    @Autowired CommonDAO commonDAO;
    @Autowired ProductDAO productDAO;

    public List<Map<String, Object>> prodList(VMap vmap) throws Exception {
        return productDAO.prodList(vmap);
    }

    public Map<String, Object> prodOne(VMap vmap) throws Exception {
        return productDAO.prodOne(vmap);
    }

    public Map<String, Object> prodOverlap(VMap vmap) throws Exception {
        return productDAO.prodOverlap(vmap);
    }

    @Transactional
    public int prodRegistModify(VMap vmap) throws Exception {

        vmap.put("table_type", "PROD");
        vmap.put("prod_cd", CommonUtils.isNotEmpty(vmap.getString("prod_cd")) ? vmap.getString("prod_cd") : commonDAO.getTablePrimaryCode(vmap));

        return productDAO.prodRegistModify(vmap);
    }

    public int prodPackDelete(VMap vmap) throws Exception {
        return productDAO.prodPackDelete(vmap);
    }

}
