package com.ysis.webapp.mes.base.equipment;

import com.ysis.webapp.common.config.MapperDAO;
import com.ysis.webapp.common.vo.VMap;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class EquipmentDAO extends MapperDAO {

    private static String mapperName = "mes.base.equipment";

    public List<Map<String, Object>> equList(VMap vMap) throws Exception {
        return selectList(mapperName + ".equList", vMap.getMap());
    }

    public Map<String, Object> equOne(VMap vMap) throws Exception {
        return selectOne(mapperName + ".equOne", vMap.getMap());
    }

    public Map<String, Object> equOverlap(VMap vMap) throws Exception {
        return selectOne(mapperName + ".equOverlap", vMap.getMap());
    }

    public int equRegistModify(VMap vmap) throws Exception {
        return insert(mapperName + ".equRegistModify", vmap.getMap());
    }

    public int equPackDelete(VMap vmap) throws Exception {
        return delete(mapperName + ".equPackDelete", vmap.getMap());
    }

}
