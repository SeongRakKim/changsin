package com.ksr.webapp.mes.base.product;

import com.ksr.webapp.common.config.MapperDAO;
import com.ksr.webapp.common.vo.VMap;
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

    public List<Map<String, Object>> prodOverlap2(VMap vMap) throws Exception {
        return selectList(mapperName + ".prodOverlap2", vMap.getMap());
    }

    public List<Map<String, Object>> prodOverlap3(VMap vMap) throws Exception {
        return selectList(mapperName + ".prodOverlap3", vMap.getMap());
    }

    public List<Map<String, Object>> prodOverlap4(VMap vMap) throws Exception {
        return selectList(mapperName + ".prodOverlap4", vMap.getMap());
    }

    public List<Map<String, Object>> prodOverlap5(VMap vMap) throws Exception {
        return selectList(mapperName + ".prodOverlap5", vMap.getMap());
    }

    public int prodRegistModify(VMap vmap) throws Exception {
        return insert(mapperName + ".prodRegistModify", vmap.getMap());
    }

    public int prodPackDelete(VMap vmap) throws Exception {
        return update(mapperName + ".prodPackDelete", vmap.getMap());
    }

    public int prodProcPackDelete(VMap vmap) throws Exception {
        return delete(mapperName + ".prodProcPackDelete", vmap.getMap());
    }

    public int prodBomPackDelete(VMap vmap) throws Exception {
        return delete(mapperName + ".prodBomPackDelete", vmap.getMap());
    }

    public List<Map<String, Object>> prodProcList(VMap vMap) throws Exception {
        return selectList(mapperName + ".prodProcList", vMap.getMap());
    }

    public int prodProcRegistModify(VMap vmap) throws Exception {
        return insert(mapperName + ".prodProcRegistModify", vmap.getMap());
    }

    public int prodProcDelete(VMap vmap) throws Exception {
        return delete(mapperName + ".prodProcDelete", vmap.getMap());
    }

    public List<Map<String, Object>> prodBomList(VMap vMap) throws Exception {
        return selectList(mapperName + ".prodBomList", vMap.getMap());
    }

    public int prodBomRegistModify(VMap vmap) throws Exception {
        return insert(mapperName + ".prodBomRegistModify", vmap.getMap());
    }

    public int prodBomDelete(VMap vmap) throws Exception {
        return delete(mapperName + ".prodBomDelete", vmap.getMap());
    }

    public int prodStockCntModify(VMap vmap) throws Exception {
        return update(mapperName + ".prodStockCntModify", vmap.getMap());
    }

}
