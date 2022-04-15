package com.ksr.webapp.mes.production.state;

import com.ksr.webapp.common.config.MapperDAO;
import com.ksr.webapp.common.vo.VMap;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class ProductionStateDAO extends MapperDAO {

    private static String mapperName = "mes.production.state";

    public List<Map<String, Object>> stateList(VMap vmap) throws Exception {
        return selectList(mapperName + ".stateList", vmap.getMap());
    }


    public Map<String, Object> stateOne(VMap vmap) throws Exception {
        return selectOne(mapperName + ".stateOne", vmap.getMap());
    }

}
