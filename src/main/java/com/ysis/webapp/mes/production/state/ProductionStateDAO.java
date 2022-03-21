package com.ysis.webapp.mes.production.state;

import com.ysis.webapp.common.config.MapperDAO;
import com.ysis.webapp.common.vo.VMap;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class ProductionStateDAO extends MapperDAO {

    private static String mapperName = "mes.production.state";

    public List<Map<String, Object>> stateList(VMap vMap) throws Exception {
        return selectList(mapperName + ".stateList", vMap.getMap());
    }


    public Map<String, Object> stateOne(VMap vMap) throws Exception {
        return selectOne(mapperName + ".stateOne", vMap.getMap());
    }

}
