package com.ysis.webapp.mes.material.inout;

import com.ysis.webapp.common.config.MapperDAO;
import com.ysis.webapp.common.vo.VMap;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class MaterialInoutDAO extends MapperDAO {

    private static String mapperName = "mes.material.inout";

    public List<Map<String, Object>> materialInoutList(VMap vMap) throws Exception {
        return selectList(mapperName + ".materialInoutList", vMap.getMap());
    }

    public Map<String, Object> materialInoutOne(VMap vMap) throws Exception {
        return selectOne(mapperName + ".materialInoutOne", vMap.getMap());
    }

    public int materialInoutRegist(VMap vmap) throws Exception {
        return insert(mapperName + ".materialInoutRegist", vmap.getMap());
    }

}
