package com.ksr.webapp.mes.production.result;

import com.ksr.webapp.common.config.MapperDAO;
import com.ksr.webapp.common.vo.VMap;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class ProductionResultDAO extends MapperDAO {

    private static String mapperName = "mes.production.result";

    public List<Map<String, Object>> planProcessList(VMap vmap) throws Exception {
        return selectList(mapperName + ".planProcessList", vmap.getMap());
    }

    public Map<String, Object> planProcessOne(VMap vmap) throws Exception {
        return selectOne(mapperName + ".planProcessOne", vmap.getMap());
    }

    public int planProcCntModify(VMap vmap) throws Exception {
        return update(mapperName + ".planProcCntModify", vmap.getMap());
    }

    public List<Map<String, Object>> planResultList(VMap vmap) throws Exception {
        return selectList(mapperName + ".planResultList", vmap.getMap());
    }

    public List<Map<String, Object>> planMonStateList(VMap vmap) throws Exception {
        return selectList(mapperName + ".planMonStateList", vmap.getMap());
    }

    public List<Map<String, Object>> planResultDidList(VMap vmap) throws Exception {
        return selectList(mapperName + ".planResultDidList", vmap.getMap());
    }

    public Map<String, Object> planResultOne(VMap vmap) throws Exception {
        return selectOne(mapperName + ".planResultOne", vmap.getMap());
    }

    public int planResultRegist(VMap vmap) throws Exception {
        return insert(mapperName + ".planResultRegist", vmap.getMap());
    }

    public int planResultModify(VMap vmap) throws Exception {
        return insert(mapperName + ".planResultModify", vmap.getMap());
    }

    public int planResultModify2(VMap vmap) throws Exception {
        return insert(mapperName + ".planResultModify2", vmap.getMap());
    }

    public int planResultDelete(VMap vmap) throws Exception {
        return delete(mapperName + ".planResultDelete", vmap.getMap());
    }

    public List<Map<String, Object>> planInputList(VMap vmap) throws Exception {
        return selectList(mapperName + ".planInputList", vmap.getMap());
    }

    public int planInputRegist(VMap vmap) throws Exception {
        return insert(mapperName + ".planInputRegist", vmap.getMap());
    }

    public int planInputDelete(VMap vmap) throws Exception {
        return delete(mapperName + ".planInputDelete", vmap.getMap());
    }

    public List<Map<String, Object>> planStopList(VMap vmap) throws Exception {
        return selectList(mapperName + ".planStopList", vmap.getMap());
    }

    public int planStopRegistModify(VMap vmap) throws Exception {
        return insert(mapperName + ".planStopRegistModify", vmap.getMap());
    }

    public int planStopDelete(VMap vmap) throws Exception {
        return delete(mapperName + ".planStopDelete", vmap.getMap());
    }

}
