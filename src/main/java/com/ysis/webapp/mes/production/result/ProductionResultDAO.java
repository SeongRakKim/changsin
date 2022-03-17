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

    public Map<String, Object> resultOverlap(VMap vMap) throws Exception {
        return selectOne(mapperName + ".resultOverlap", vMap.getMap());
    }

    public int resultRegist(VMap vmap) throws Exception {
        return insert(mapperName + ".resultRegist", vmap.getMap());
    }

    public int resultModify(VMap vmap) throws Exception {
        return insert(mapperName + ".resultModify", vmap.getMap());
    }

    public int shipRegist(VMap vmap) throws Exception {
        return insert(mapperName + ".shipRegist", vmap.getMap());
    }

    public int resultPackDelete(VMap vmap) throws Exception {
        return delete(mapperName + ".resultPackDelete", vmap.getMap());
    }

    public int resultProcRegist(VMap vmap) throws Exception {
        return insert(mapperName + ".resultProcRegist", vmap.getMap());
    }

    public List<Map<String, Object>> resultProcList(VMap vMap) throws Exception {
        return selectList(mapperName + ".resultProcList", vMap.getMap());
    }

    public int resultProcModify(VMap vmap) throws Exception {
        return insert(mapperName + ".resultProcModify", vmap.getMap());
    }

    public int resultProcDelete(VMap vmap) throws Exception {
        return delete(mapperName + ".resultProcDelete", vmap.getMap());
    }

}
