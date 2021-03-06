package com.ksr.webapp.mes.base.process;

import com.ksr.webapp.common.config.MapperDAO;
import com.ksr.webapp.common.vo.VMap;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class ProcessDAO extends MapperDAO {

    private static String mapperName = "mes.base.process";

    public List<Map<String, Object>> procList(VMap vmap) throws Exception {
        return selectList(mapperName + ".procList", vmap.getMap());
    }

    public Map<String, Object> procOne(VMap vmap) throws Exception {
        return selectOne(mapperName + ".procOne", vmap.getMap());
    }

    public Map<String, Object> procOverlap(VMap vmap) throws Exception {
        return selectOne(mapperName + ".procOverlap", vmap.getMap());
    }

    public int procRegistModify(VMap vmap) throws Exception {
        return insert(mapperName + ".procRegistModify", vmap.getMap());
    }

    public int procPackDelete(VMap vmap) throws Exception {
        return update(mapperName + ".procPackDelete", vmap.getMap());
    }

}
