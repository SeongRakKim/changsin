package com.ksr.webapp.mes.base.sensor;

import com.ksr.webapp.common.config.MapperDAO;
import com.ksr.webapp.common.vo.VMap;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class SensorDAO extends MapperDAO {

    private static String mapperName = "mes.base.sensor";

    public List<Map<String, Object>> snsrList(VMap vmap) throws Exception {
        return selectList(mapperName + ".snsrList", vmap.getMap());
    }

    public Map<String, Object> snsrOne(VMap vmap) throws Exception {
        return selectOne(mapperName + ".snsrOne", vmap.getMap());
    }

    public Map<String, Object> snsrOne2(VMap vmap) throws Exception {
        return selectOne(mapperName + ".snsrOne2", vmap.getMap());
    }

    public Map<String, Object> snsrOverlap(VMap vmap) throws Exception {
        return selectOne(mapperName + ".snsrOverlap", vmap.getMap());
    }

    public int snsrRegistModify(VMap vmap) throws Exception {
        return insert(mapperName + ".snsrRegistModify", vmap.getMap());
    }

    public int snsrPackDelete(VMap vmap) throws Exception {
        return update(mapperName + ".snsrPackDelete", vmap.getMap());
    }

}
