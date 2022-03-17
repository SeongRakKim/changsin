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

    public int planResultRegist(VMap vmap) throws Exception {
        return insert(mapperName + ".planResultRegist", vmap.getMap());
    }

    public int resultModify(VMap vmap) throws Exception {
        return insert(mapperName + ".resultModify", vmap.getMap());
    }

    public int planInputRegist(VMap vmap) throws Exception {
        return insert(mapperName + ".planInputRegist", vmap.getMap());
    }


}
