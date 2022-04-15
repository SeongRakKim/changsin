package com.ksr.webapp.mes.base.material;

import com.ksr.webapp.common.config.MapperDAO;
import com.ksr.webapp.common.vo.VMap;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class MaterialDAO extends MapperDAO {

    private static String mapperName = "mes.base.material";

    public List<Map<String, Object>> mateList(VMap vmap) throws Exception {
        return selectList(mapperName + ".mateList", vmap.getMap());
    }

    public Map<String, Object> mateOne(VMap vmap) throws Exception {
        return selectOne(mapperName + ".mateOne", vmap.getMap());
    }

    public Map<String, Object> mateOverlap(VMap vmap) throws Exception {
        return selectOne(mapperName + ".mateOverlap", vmap.getMap());
    }

    public List<Map<String, Object>> mateOverlap2(VMap vmap) throws Exception {
        return selectList(mapperName + ".mateOverlap2", vmap.getMap());
    }

    public int mateRegistModify(VMap vmap) throws Exception {
        return insert(mapperName + ".mateRegistModify", vmap.getMap());
    }

    public int matePackDelete(VMap vmap) throws Exception {
        return update(mapperName + ".matePackDelete", vmap.getMap());
    }

    public int mateStockCntModify(VMap vmap) throws Exception {
        return update(mapperName + ".mateStockCntModify", vmap.getMap());
    }

}
