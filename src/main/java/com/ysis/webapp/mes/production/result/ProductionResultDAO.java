package com.ysis.webapp.mes.production.result;

import com.ysis.webapp.common.config.MapperDAO;
import com.ysis.webapp.common.vo.VMap;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class ProductionResultDAO extends MapperDAO {

    private static String mapperName = "mes.production.result";

    public List<Map<String, Object>> planProcessList(VMap vMap) throws Exception {
        return selectList(mapperName + ".planProcessList", vMap.getMap());
    }

    public Map<String, Object> planProcessOne(VMap vMap) throws Exception {
        return selectOne(mapperName + ".planProcessOne", vMap.getMap());
    }

    public int planProcCntModify(VMap vmap) throws Exception {
        return update(mapperName + ".planProcCntModify", vmap.getMap());
    }

    public List<Map<String, Object>> planResultList(VMap vMap) throws Exception {
        return selectList(mapperName + ".planResultList", vMap.getMap());
    }

    public Map<String, Object> planResultOne(VMap vMap) throws Exception {
        return selectOne(mapperName + ".planResultOne", vMap.getMap());
    }

    public int planResultRegist(VMap vmap) throws Exception {
        return insert(mapperName + ".planResultRegist", vmap.getMap());
    }

    public int planResultModify(VMap vmap) throws Exception {
        return insert(mapperName + ".planResultModify", vmap.getMap());
    }

    public int planResultDelete(VMap vmap) throws Exception {
        return delete(mapperName + ".planResultDelete", vmap.getMap());
    }

    public List<Map<String, Object>> planInputList(VMap vMap) throws Exception {
        return selectList(mapperName + ".planInputList", vMap.getMap());
    }

    public int planInputRegist(VMap vmap) throws Exception {
        return insert(mapperName + ".planInputRegist", vmap.getMap());
    }

    public int planInputDelete(VMap vmap) throws Exception {
        return delete(mapperName + ".planInputDelete", vmap.getMap());
    }

    public List<Map<String, Object>> planStopList(VMap vMap) throws Exception {
        return selectList(mapperName + ".planStopList", vMap.getMap());
    }

    public int planStopRegistModify(VMap vmap) throws Exception {
        return insert(mapperName + ".planStopRegistModify", vmap.getMap());
    }

    public int planStopDelete(VMap vmap) throws Exception {
        return delete(mapperName + ".planStopDelete", vmap.getMap());
    }

}
