package com.ysis.webapp.mes.base.material;

import com.ysis.webapp.common.config.MapperDAO;
import com.ysis.webapp.common.vo.VMap;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class MaterialDAO extends MapperDAO {

    private static String mapperName = "mes.base.material";

    public List<Map<String, Object>> mateList(VMap vMap) throws Exception {
        return selectList(mapperName + ".mateList", vMap.getMap());
    }

    public Map<String, Object> mateOne(VMap vMap) throws Exception {
        return selectOne(mapperName + ".mateOne", vMap.getMap());
    }

    public Map<String, Object> mateOverlap(VMap vMap) throws Exception {
        return selectOne(mapperName + ".mateOverlap", vMap.getMap());
    }

    public List<Map<String, Object>> mateOverlap2(VMap vMap) throws Exception {
        return selectList(mapperName + ".mateOverlap2", vMap.getMap());
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
