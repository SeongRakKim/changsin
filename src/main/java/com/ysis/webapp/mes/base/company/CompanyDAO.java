package com.ysis.webapp.mes.base.company;

import com.ysis.webapp.common.config.MapperDAO;
import com.ysis.webapp.common.vo.VMap;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class CompanyDAO extends MapperDAO {

    private static String mapperName = "mes.base.company";

    public List<Map<String, Object>> compList(VMap vMap) throws Exception {
        return selectList(mapperName + ".compList", vMap.getMap());
    }

    public int compRegistModify(VMap vmap) throws Exception {
        return insert(mapperName + ".compRegistModify", vmap.getMap());
    }

}
