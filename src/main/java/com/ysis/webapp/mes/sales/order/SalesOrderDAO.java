package com.ysis.webapp.mes.sales.order;

import com.ysis.webapp.common.config.MapperDAO;
import com.ysis.webapp.common.vo.VMap;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class SalesOrderDAO extends MapperDAO {

    private static String mapperName = "mes.sales.order";

    public List<Map<String, Object>> orderList(VMap vMap) throws Exception {
        return selectList(mapperName + ".orderList", vMap.getMap());
    }

    public Map<String, Object> orderOne(VMap vMap) throws Exception {
        return selectOne(mapperName + ".orderOne", vMap.getMap());
    }

    public Map<String, Object> orderOverlap(VMap vMap) throws Exception {
        return selectOne(mapperName + ".orderOverlap", vMap.getMap());
    }

    public int orderRegist(VMap vmap) throws Exception {
        return insert(mapperName + ".orderRegist", vmap.getMap());
    }

    public int orderPackDelete(VMap vmap) throws Exception {
        return update(mapperName + ".orderPackDelete", vmap.getMap());
    }

    public int orderProcPackDelete(VMap vmap) throws Exception {
        return delete(mapperName + ".orderProcPackDelete", vmap.getMap());
    }

    public int orderBomPackDelete(VMap vmap) throws Exception {
        return delete(mapperName + ".orderBomPackDelete", vmap.getMap());
    }

    public List<Map<String, Object>> orderProcList(VMap vMap) throws Exception {
        return selectList(mapperName + ".orderProcList", vMap.getMap());
    }

    public int orderProcRegistModify(VMap vmap) throws Exception {
        return insert(mapperName + ".orderProcRegistModify", vmap.getMap());
    }

    public int orderProcDelete(VMap vmap) throws Exception {
        return delete(mapperName + ".orderProcDelete", vmap.getMap());
    }

    public List<Map<String, Object>> orderBomList(VMap vMap) throws Exception {
        return selectList(mapperName + ".orderBomList", vMap.getMap());
    }

    public int orderBomRegistModify(VMap vmap) throws Exception {
        return insert(mapperName + ".orderBomRegistModify", vmap.getMap());
    }

    public int orderBomDelete(VMap vmap) throws Exception {
        return delete(mapperName + ".orderBomDelete", vmap.getMap());
    }

}
