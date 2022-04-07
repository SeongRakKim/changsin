package com.ksr.webapp.mes.base.department;

import com.ksr.webapp.common.config.MapperDAO;
import com.ksr.webapp.common.vo.VMap;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class DepartmentDAO extends MapperDAO {

    private static String mapperName = "mes.base.department";

    public List<Map<String, Object>> deptList(VMap vMap) throws Exception {
        return selectList(mapperName + ".deptList", vMap.getMap());
    }

    public Map<String, Object> deptOne(VMap vMap) throws Exception {
        return selectOne(mapperName + ".deptOne", vMap.getMap());
    }

    public Map<String, Object> deptOverlap(VMap vMap) throws Exception {
        return selectOne(mapperName + ".deptOverlap", vMap.getMap());
    }

    public int deptRegistModify(VMap vmap) throws Exception {
        return insert(mapperName + ".deptRegistModify", vmap.getMap());
    }

    public int deptPackDelete(VMap vmap) throws Exception {
        return update(mapperName + ".deptPackDelete", vmap.getMap());
    }

}
