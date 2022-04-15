package com.ksr.webapp.mes.base.department;

import com.ksr.webapp.common.config.MapperDAO;
import com.ksr.webapp.common.vo.VMap;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class DepartmentDAO extends MapperDAO {

    private static String mapperName = "mes.base.department";

    public List<Map<String, Object>> deptList(VMap vmap) throws Exception {
        return selectList(mapperName + ".deptList", vmap.getMap());
    }

    public Map<String, Object> deptOne(VMap vmap) throws Exception {
        return selectOne(mapperName + ".deptOne", vmap.getMap());
    }

    public Map<String, Object> deptOverlap(VMap vmap) throws Exception {
        return selectOne(mapperName + ".deptOverlap", vmap.getMap());
    }

    public int deptRegistModify(VMap vmap) throws Exception {
        return insert(mapperName + ".deptRegistModify", vmap.getMap());
    }

    public int deptPackDelete(VMap vmap) throws Exception {
        return update(mapperName + ".deptPackDelete", vmap.getMap());
    }

}
