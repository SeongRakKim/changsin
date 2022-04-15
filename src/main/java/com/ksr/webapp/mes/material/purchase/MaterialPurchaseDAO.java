package com.ksr.webapp.mes.material.purchase;

import com.ksr.webapp.common.config.MapperDAO;
import com.ksr.webapp.common.vo.VMap;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class MaterialPurchaseDAO extends MapperDAO {

    private static String mapperName = "mes.material.purchase";

    public List<Map<String, Object>> purchaseList(VMap vmap) throws Exception {
        return selectList(mapperName + ".purchaseList", vmap.getMap());
    }

    public List<Map<String, Object>> purchaseList2(VMap vmap) throws Exception {
        return selectList(mapperName + ".purchaseList2", vmap.getMap());
    }

    public Map<String, Object> purchaseOne(VMap vmap) throws Exception {
        return selectOne(mapperName + ".purchaseOne", vmap.getMap());
    }

    public Map<String, Object> purchaseOverlap(VMap vmap) throws Exception {
        return selectOne(mapperName + ".purchaseOverlap", vmap.getMap());
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
