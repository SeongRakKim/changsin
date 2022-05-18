package com.ksr.webapp.mes.base.equipment;

import com.ksr.webapp.common.config.MapperDAO;
import com.ksr.webapp.common.vo.VMap;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class EquipmentDAO extends MapperDAO {

    private static String mapperName = "mes.base.equipment";

    public List<Map<String, Object>> equList(VMap vmap) throws Exception {
        return selectList(mapperName + ".equList", vmap.getMap());
    }

    public Map<String, Object> equOne(VMap vmap) throws Exception {
        return selectOne(mapperName + ".equOne", vmap.getMap());
    }

    public Map<String, Object> equOverlap(VMap vmap) throws Exception {
        return selectOne(mapperName + ".equOverlap", vmap.getMap());
    }

    public int equRegistModify(VMap vmap) throws Exception {
        return insert(mapperName + ".equRegistModify", vmap.getMap());
    }

    public int equPackDelete(VMap vmap) throws Exception {
        return update(mapperName + ".equPackDelete", vmap.getMap());
    }

    public List<Map<String, Object>> equipmentInterfaceData(VMap vmap) throws Exception {
        return selectList(mapperName + ".equipmentInterfaceData", vmap.getMap());
    }

}
