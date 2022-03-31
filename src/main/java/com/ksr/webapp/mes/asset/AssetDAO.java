package com.ksr.webapp.mes.asset;

import com.ksr.webapp.common.config.MapperDAO;
import com.ksr.webapp.common.vo.VMap;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class AssetDAO extends MapperDAO {

    private static String mapperName = "mes.asset";

    public List<Map<String, Object>> assetPartList(VMap vMap) throws Exception {
        return selectList(mapperName + ".assetPartList", vMap.getMap());
    }

    public Map<String, Object> productInoutOne(VMap vMap) throws Exception {
        return selectOne(mapperName + ".productInoutOne", vMap.getMap());
    }

    public int productInoutRegist(VMap vmap) throws Exception {
        return insert(mapperName + ".productInoutRegist", vmap.getMap());
    }

}
