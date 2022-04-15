package com.ksr.webapp.mes.product.stock;

import com.ksr.webapp.common.config.MapperDAO;
import com.ksr.webapp.common.vo.VMap;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class ProductStockDAO extends MapperDAO {

    private static String mapperName = "mes.product.stock";

    public List<Map<String, Object>> prodStockList(VMap vmap) throws Exception {
        return selectList(mapperName + ".prodStockList", vmap.getMap());
    }

}
