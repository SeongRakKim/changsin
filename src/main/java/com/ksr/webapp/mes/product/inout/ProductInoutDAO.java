package com.ksr.webapp.mes.product.inout;

import com.ksr.webapp.common.config.MapperDAO;
import com.ksr.webapp.common.vo.VMap;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class ProductInoutDAO extends MapperDAO {

    private static String mapperName = "mes.product.inout";

    public List<Map<String, Object>> productInoutList(VMap vmap) throws Exception {
        return selectList(mapperName + ".productInoutList", vmap.getMap());
    }

    public Map<String, Object> productInoutOne(VMap vmap) throws Exception {
        return selectOne(mapperName + ".productInoutOne", vmap.getMap());
    }

    public int productInoutRegist(VMap vmap) throws Exception {
        return insert(mapperName + ".productInoutRegist", vmap.getMap());
    }

}
