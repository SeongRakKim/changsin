package com.ksr.webapp.mes.material.stock;

import com.ksr.webapp.common.config.MapperDAO;
import com.ksr.webapp.common.vo.VMap;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class MaterialStockDAO extends MapperDAO {

    private static String mapperName = "mes.material.stock";

    public List<Map<String, Object>> mateStockList(VMap vmap) throws Exception {
        return selectList(mapperName + ".mateStockList", vmap.getMap());
    }

}
