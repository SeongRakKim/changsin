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

    public Map<String, Object> userOne(String u_cd) throws Exception {
        VMap vmap = new VMap();
        vmap.put("u_cd", u_cd);
        return selectOne(mapperName + ".userOne", vmap.getMap());
    }

    public Map<String, Object> userOverlap(VMap vmap) throws Exception {
        return selectOne(mapperName + ".userOverlap", vmap.getMap());
    }

    public int userRegistModify(VMap vmap) throws Exception {
        return insert(mapperName + ".userRegistModify", vmap.getMap());
    }

    public int userPackDelete(VMap vmap) throws Exception {
        return update(mapperName + ".userPackDelete", vmap.getMap());
    }

}
