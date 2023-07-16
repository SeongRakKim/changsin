package com.ksr.webapp.mes.base.product;

import com.ksr.webapp.common.config.MapperDAO;
import com.ksr.webapp.common.vo.VMap;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class ProductDAO extends MapperDAO {

    private static String mapperName = "mes.base.product";

    public List<Map<String, Object>> prodList(VMap vmap) throws Exception {
        return selectList(mapperName + ".prodList", vmap.getMap());
    }

    public Map<String, Object> prodOne(VMap vmap) throws Exception {
        return selectOne(mapperName + ".prodOne", vmap.getMap());
    }

    public Map<String, Object> createProdLotNo(VMap vmap) throws Exception {
        return selectOne(mapperName + ".createProdLotNo", vmap.getMap());
    }

    public int prodLotRegistModify(VMap vmap) throws Exception {
        return insert(mapperName + ".prodLotRegistModify", vmap.getMap());
    }

    public int prodLotDelete(VMap vmap) throws Exception {
        return delete(mapperName + ".prodLotDelete", vmap.getMap());
    }

    public Map<String, Object> prodOverlap(VMap vmap) throws Exception {
        return selectOne(mapperName + ".prodOverlap", vmap.getMap());
    }

    public List<Map<String, Object>> prodOverlap2(VMap vmap) throws Exception {
        return selectList(mapperName + ".prodOverlap2", vmap.getMap());
    }

    public List<Map<String, Object>> prodOverlap3(VMap vmap) throws Exception {
        return selectList(mapperName + ".prodOverlap3", vmap.getMap());
    }

    public List<Map<String, Object>> prodOverlap4(VMap vmap) throws Exception {
        return selectList(mapperName + ".prodOverlap4", vmap.getMap());
    }

    public List<Map<String, Object>> prodOverlap5(VMap vmap) throws Exception {
        return selectList(mapperName + ".prodOverlap5", vmap.getMap());
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

    public List<Map<String, Object>> prodProcList(VMap vmap) throws Exception {
        return selectList(mapperName + ".prodProcList", vmap.getMap());
    }

    public int prodProcRegistModify(VMap vmap) throws Exception {
        return insert(mapperName + ".prodProcRegistModify", vmap.getMap());
    }

    public int prodProcDelete(VMap vmap) throws Exception {
        return delete(mapperName + ".prodProcDelete", vmap.getMap());
    }

    public List<Map<String, Object>> prodBomList(VMap vmap) throws Exception {
        return selectList(mapperName + ".prodBomList", vmap.getMap());
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
