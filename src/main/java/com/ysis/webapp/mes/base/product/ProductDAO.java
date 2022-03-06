package com.ysis.webapp.mes.base.product;

import com.ysis.webapp.common.config.MapperDAO;
import com.ysis.webapp.common.vo.VMap;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class ProductDAO extends MapperDAO {

    private static String mapperName = "mes.base.product";

    public List<Map<String, Object>> prodList(VMap vMap) throws Exception {
        return selectList(mapperName + ".prodList", vMap.getMap());
    }

    public Map<String, Object> prodOne(VMap vMap) throws Exception {
        return selectOne(mapperName + ".prodOne", vMap.getMap());
    }

    public Map<String, Object> prodOverlap(VMap vMap) throws Exception {
        return selectOne(mapperName + ".prodOverlap", vMap.getMap());
    }

    public int prodRegistModify(VMap vmap) throws Exception {
        return insert(mapperName + ".prodRegistModify", vmap.getMap());
    }

    public int prodPackDelete(VMap vmap) throws Exception {
        return delete(mapperName + ".prodPackDelete", vmap.getMap());
    }

}
