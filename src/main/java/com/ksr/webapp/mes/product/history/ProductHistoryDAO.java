package com.ksr.webapp.mes.product.history;

import com.ksr.webapp.common.config.MapperDAO;
import com.ksr.webapp.common.vo.VMap;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class ProductHistoryDAO extends MapperDAO {

    private static String mapperName = "mes.product.history";

    public List<Map<String, Object>> prodHistoryList(VMap vmap) throws Exception {
        return selectList(mapperName + ".prodHistoryList", vmap.getMap());
    }

}
