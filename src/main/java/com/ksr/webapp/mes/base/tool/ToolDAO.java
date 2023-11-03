package com.ksr.webapp.mes.base.tool;

import com.ksr.webapp.common.config.MapperDAO;
import com.ksr.webapp.common.vo.VMap;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class ToolDAO extends MapperDAO {

    private static String mapperName = "mes.base.tool";

    public List<Map<String, Object>> toolList(VMap vmap) throws Exception {
        return selectList(mapperName + ".toolList", vmap.getMap());
    }

    public Map<String, Object> toolOne(VMap vmap) throws Exception {
        return selectOne(mapperName + ".toolOne", vmap.getMap());
    }

    public Map<String, Object> toolOverlap(VMap vmap) throws Exception {
        return selectOne(mapperName + ".toolOverlap", vmap.getMap());
    }

    public int toolRegistModify(VMap vmap) throws Exception {
        return insert(mapperName + ".toolRegistModify", vmap.getMap());
    }

    public int toolPackDelete(VMap vmap) throws Exception {
        return update(mapperName + ".toolPackDelete", vmap.getMap());
    }

}
