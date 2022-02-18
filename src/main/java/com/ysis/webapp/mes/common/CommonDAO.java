package com.ysis.webapp.mes.common;

import com.ysis.webapp.common.config.MapperDAO;
import com.ysis.webapp.common.vo.VMap;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class CommonDAO extends MapperDAO {

    private static String mapperName = "common.common";

    public List<Map<String, Object>> baseDetailList(VMap vmap) throws Exception {
        return selectList(mapperName + ".baseDetailList", vmap.getMap());
    }

}
