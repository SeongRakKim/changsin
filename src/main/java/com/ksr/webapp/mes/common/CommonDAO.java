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

    public List<Map<String, Object>> baseDetailList(VMap vmap) throws Exception {
        return selectList(mapperName + ".baseDetailList", vmap.getMap());
    }

}
