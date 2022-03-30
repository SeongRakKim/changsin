package com.ysis.webapp.mes.material.stock;

import com.ysis.webapp.common.config.MapperDAO;
import com.ysis.webapp.common.vo.VMap;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class MaterialStockDAO extends MapperDAO {

    private static String mapperName = "mes.material.stock";

    public List<Map<String, Object>> mateStockList(VMap vMap) throws Exception {
        return selectList(mapperName + ".mateStockList", vMap.getMap());
    }

}
