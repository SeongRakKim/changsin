package com.ksr.webapp.mes.base.user;

import com.ksr.webapp.common.config.MapperDAO;
import com.ksr.webapp.common.vo.VMap;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class UserDAO extends MapperDAO {

    private static String mapperName = "mes.base.user";

    public List<Map<String, Object>> userList(VMap vmap) throws Exception {
        return selectList(mapperName + ".userList", vmap.getMap());
    }

    public Map<String, Object> planOne(VMap vmap) throws Exception {
        return selectOne(mapperName + ".planOne", vmap.getMap());
    }

    public Map<String, Object> planOverlap(VMap vmap) throws Exception {
        return selectOne(mapperName + ".planOverlap", vmap.getMap());
    }

    public int planRegist(VMap vmap) throws Exception {
        return insert(mapperName + ".planRegist", vmap.getMap());
    }

    public int planModify(VMap vmap) throws Exception {
        return insert(mapperName + ".planModify", vmap.getMap());
    }

    public int shipRegist(VMap vmap) throws Exception {
        return insert(mapperName + ".shipRegist", vmap.getMap());
    }

    public int planPackDelete(VMap vmap) throws Exception {
        return delete(mapperName + ".planPackDelete", vmap.getMap());
    }

    public int planProcRegist(VMap vmap) throws Exception {
        return insert(mapperName + ".planProcRegist", vmap.getMap());
    }

    public List<Map<String, Object>> planProcList(VMap vmap) throws Exception {
        return selectList(mapperName + ".planProcList", vmap.getMap());
    }

    public int planProcModify(VMap vmap) throws Exception {
        return insert(mapperName + ".planProcModify", vmap.getMap());
    }

    public int planProcDelete(VMap vmap) throws Exception {
        return delete(mapperName + ".planProcDelete", vmap.getMap());
    }

}
