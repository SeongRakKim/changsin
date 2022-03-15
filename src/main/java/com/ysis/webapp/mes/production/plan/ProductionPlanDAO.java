package com.ysis.webapp.mes.production.plan;

import com.ysis.webapp.common.config.MapperDAO;
import com.ysis.webapp.common.vo.VMap;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class ProductionPlanDAO extends MapperDAO {

    private static String mapperName = "mes.production.plan";

    public List<Map<String, Object>> planList(VMap vMap) throws Exception {
        return selectList(mapperName + ".planList", vMap.getMap());
    }

    public Map<String, Object> planOne(VMap vMap) throws Exception {
        return selectOne(mapperName + ".planOne", vMap.getMap());
    }

    public Map<String, Object> planOverlap(VMap vMap) throws Exception {
        return selectOne(mapperName + ".planOverlap", vMap.getMap());
    }

    public int planRegist(VMap vmap) throws Exception {
        return insert(mapperName + ".planRegist", vmap.getMap());
    }

    public int planModify(VMap vmap) throws Exception {
        return insert(mapperName + ".planModify", vmap.getMap());
    }

    public int shipRegist(VMap vmap) throws Exception {
        return insert(mapperName + ".shipRegist", vmap.getMap());
    }

    public int planPackDelete(VMap vmap) throws Exception {
        return delete(mapperName + ".planPackDelete", vmap.getMap());
    }

    public int planProcPackDelete(VMap vmap) throws Exception {
        return delete(mapperName + ".planProcPackDelete", vmap.getMap());
    }

    public int planBomPackDelete(VMap vmap) throws Exception {
        return delete(mapperName + ".planBomPackDelete", vmap.getMap());
    }

    public List<Map<String, Object>> planProcList(VMap vMap) throws Exception {
        return selectList(mapperName + ".planProcList", vMap.getMap());
    }

    public int planProcRegistModify(VMap vmap) throws Exception {
        return insert(mapperName + ".planProcRegistModify", vmap.getMap());
    }

    public int planProcDelete(VMap vmap) throws Exception {
        return delete(mapperName + ".planProcDelete", vmap.getMap());
    }

    public List<Map<String, Object>> planBomList(VMap vMap) throws Exception {
        return selectList(mapperName + ".planBomList", vMap.getMap());
    }

    public int planBomRegistModify(VMap vmap) throws Exception {
        return insert(mapperName + ".planBomRegistModify", vmap.getMap());
    }

    public int planBomDelete(VMap vmap) throws Exception {
        return delete(mapperName + ".planBomDelete", vmap.getMap());
    }

}
