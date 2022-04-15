package com.ksr.webapp.mes.base.company;

import com.ksr.webapp.common.config.MapperDAO;
import com.ksr.webapp.common.vo.VMap;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class CompanyDAO extends MapperDAO {

    private static String mapperName = "mes.base.company";

    public List<Map<String, Object>> compList(VMap vmap) throws Exception {
        return selectList(mapperName + ".compList", vmap.getMap());
    }

    public Map<String, Object> compOne(VMap vmap) throws Exception {
        return selectOne(mapperName + ".compOne", vmap.getMap());
    }

    public Map<String, Object> compOverlap(VMap vmap) throws Exception {
        return selectOne(mapperName + ".compOverlap", vmap.getMap());
    }

    public List<Map<String, Object>> compCompletOverlap(VMap vmap) throws Exception {
        return selectList(mapperName + ".compCompletOverlap", vmap.getMap());
    }

    public int compRegistModify(VMap vmap) throws Exception {
        return insert(mapperName + ".compRegistModify", vmap.getMap());
    }

//    public int compPackDelete(VMap vmap) throws Exception {
//        return delete(mapperName + ".compPackDelete", vmap.getMap());
//    }

    public int compPackDelete(VMap vmap) throws Exception {
        return update(mapperName + ".compPackDelete", vmap.getMap());
    }

}
