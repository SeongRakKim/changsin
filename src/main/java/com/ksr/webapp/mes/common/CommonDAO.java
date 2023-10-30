package com.ksr.webapp.mes.common;

import com.ksr.webapp.common.config.MapperDAO;
import com.ksr.webapp.common.vo.VMap;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class CommonDAO extends MapperDAO {

    private static String mapperName = "common.common";

    public String getTablePrimaryCode(VMap vmap) throws Exception {
        return selectOneString(mapperName + ".getTablePrimaryCode", vmap.getMap());
    }

    public String getTableRandomKey(VMap vmap) throws Exception {
        return selectOneString(mapperName + ".getTableRandomKey", vmap.getMap());
    }

    public List<Map<String, Object>> baseList(VMap vmap) throws Exception {
        return selectList(mapperName + ".baseList", vmap.getMap());
    }

    public Map<String, Object> baseOne(VMap vmap) throws Exception {
        return selectOne(mapperName + ".baseOne", vmap.getMap());
    }

    public List<Map<String, Object>> baseDetailList(VMap vmap) throws Exception {
        return selectList(mapperName + ".baseDetailList", vmap.getMap());
    }

    public int baseCodeDetailRegistModify(VMap vmap) throws Exception {
        return insert(mapperName + ".baseCodeDetailRegistModify", vmap.getMap());
    }

    public int baseCodeDetailDelete(VMap vmap) throws Exception {
        return delete(mapperName + ".baseCodeDetailDelete", vmap.getMap());
    }

}
