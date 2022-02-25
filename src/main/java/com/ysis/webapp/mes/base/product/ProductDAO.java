package com.ysis.webapp.mes.base.product;

import com.ysis.webapp.common.config.MapperDAO;
import com.ysis.webapp.common.vo.VMap;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class ProductDAO extends MapperDAO {

    private static String mapperName = "mes.base.product";

    public List<Map<String, Object>> compList(VMap vMap) throws Exception {
        return selectList(mapperName + ".compList", vMap.getMap());
    }

    public Map<String, Object> compOne(VMap vMap) throws Exception {
        return selectOne(mapperName + ".compOne", vMap.getMap());
    }

    public Map<String, Object> compOverlap(VMap vMap) throws Exception {
        return selectOne(mapperName + ".compOverlap", vMap.getMap());
    }

    public int compRegistModify(VMap vmap) throws Exception {
        return insert(mapperName + ".compRegistModify", vmap.getMap());
    }

    public int compPackDelete(VMap vmap) throws Exception {
        return delete(mapperName + ".compPackDelete", vmap.getMap());
    }

}
