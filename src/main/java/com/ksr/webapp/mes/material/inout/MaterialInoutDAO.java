package com.ksr.webapp.mes.material.inout;

import com.ksr.webapp.common.config.MapperDAO;
import com.ksr.webapp.common.vo.VMap;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class MaterialInoutDAO extends MapperDAO {

    private static String mapperName = "mes.material.inout";

    public List<Map<String, Object>> materialInoutList(VMap vmap) throws Exception {
        return selectList(mapperName + ".materialInoutList", vmap.getMap());
    }

    public Map<String, Object> materialInoutOne(VMap vmap) throws Exception {
        return selectOne(mapperName + ".materialInoutOne", vmap.getMap());
    }

    public int materialInoutRegist(VMap vmap) throws Exception {
        return insert(mapperName + ".materialInoutRegist", vmap.getMap());
    }

}
