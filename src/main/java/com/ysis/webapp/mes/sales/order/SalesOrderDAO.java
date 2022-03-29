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

    public List<Map<String, Object>> orderList2(VMap vMap) throws Exception {
        return selectList(mapperName + ".orderList2", vMap.getMap());
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

    public int orderModify(VMap vmap) throws Exception {
        return insert(mapperName + ".orderModify", vmap.getMap());
    }

    public int shipRegist(VMap vmap) throws Exception {
        return insert(mapperName + ".shipRegist", vmap.getMap());
    }

    public int orderPackDelete(VMap vmap) throws Exception {
        return delete(mapperName + ".orderPackDelete", vmap.getMap());
    }

    public int shipPackDelete(VMap vmap) throws Exception {
        return delete(mapperName + ".shipPackDelete", vmap.getMap());
    }

    public int orderStateModify(VMap vmap) throws Exception {
        return update(mapperName + ".orderStateModify", vmap.getMap());
    }

}
