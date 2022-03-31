package com.ksr.webapp.mes.material.purchase;

import com.ksr.webapp.common.config.MapperDAO;
import com.ksr.webapp.common.vo.VMap;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class MaterialPurchaseDAO extends MapperDAO {

    private static String mapperName = "mes.material.purchase";

    public List<Map<String, Object>> purchaseList(VMap vMap) throws Exception {
        return selectList(mapperName + ".purchaseList", vMap.getMap());
    }

    public List<Map<String, Object>> purchaseList2(VMap vMap) throws Exception {
        return selectList(mapperName + ".purchaseList2", vMap.getMap());
    }

    public Map<String, Object> purchaseOne(VMap vMap) throws Exception {
        return selectOne(mapperName + ".purchaseOne", vMap.getMap());
    }

    public Map<String, Object> purchaseOverlap(VMap vMap) throws Exception {
        return selectOne(mapperName + ".purchaseOverlap", vMap.getMap());
    }

    public int purchaseRegist(VMap vmap) throws Exception {
        return insert(mapperName + ".purchaseRegist", vmap.getMap());
    }

    public int purchaseModify(VMap vmap) throws Exception {
        return insert(mapperName + ".purchaseModify", vmap.getMap());
    }

    public int purchaseInModify(VMap vmap) throws Exception {
        return update(mapperName + ".purchaseInModify", vmap.getMap());
    }

    public int shipRegist(VMap vmap) throws Exception {
        return insert(mapperName + ".shipRegist", vmap.getMap());
    }

    public int purchasePackDelete(VMap vmap) throws Exception {
        return delete(mapperName + ".purchasePackDelete", vmap.getMap());
    }

    public int shipPackDelete(VMap vmap) throws Exception {
        return delete(mapperName + ".shipPackDelete", vmap.getMap());
    }

}
