package com.ksr.webapp.mes.material.part;

import com.ksr.webapp.common.config.MapperDAO;
import com.ksr.webapp.common.vo.VMap;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class MaterialPartDAO extends MapperDAO {

    private static String mapperName = "mes.material.part";

    public List<Map<String, Object>> prodPartList(VMap vMap) throws Exception {
        return selectList(mapperName + ".prodPartList", vMap.getMap());
    }

}
