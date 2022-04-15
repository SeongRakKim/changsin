package com.ksr.webapp.mes.product.part;

import com.ksr.webapp.common.config.MapperDAO;
import com.ksr.webapp.common.vo.VMap;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class ProductPartDAO extends MapperDAO {

    private static String mapperName = "mes.product.part";

    public List<Map<String, Object>> prodPartList(VMap vmap) throws Exception {
        return selectList(mapperName + ".prodPartList", vmap.getMap());
    }

}
