package com.ksr.webapp.mes.sales.order;

import com.ksr.webapp.common.config.MapperDAO;
import com.ksr.webapp.common.vo.VMap;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class SalesOrderDAO extends MapperDAO {

    private static String mapperName = "mes.sales.order";

    public List<Map<String, Object>> orderList(VMap vmap) throws Exception {
        return selectList(mapperName + ".orderList", vmap.getMap());
    }

    public List<Map<String, Object>> orderList2(VMap vmap) throws Exception {
        return selectList(mapperName + ".orderList2", vmap.getMap());
    }

    public Map<String, Object> orderOne(VMap vmap) throws Exception {
        return selectOne(mapperName + ".orderOne", vmap.getMap());
    }

    public Map<String, Object> orderOverlap(VMap vmap) throws Exception {
        return selectOne(mapperName + ".orderOverlap", vmap.getMap());
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
